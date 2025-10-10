// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.

#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel.
                   // defined by kernel.ld.

struct run
{
  struct run *next;
};

struct
{
  struct spinlock lock;
  struct run *freelist;
} kmem;

// 定义一个关于页面分配的全局变量,增加关于一个页面的引用计数
struct ref_stru
{
  struct spinlock lock;        // 自旋锁,很简单,防止两个进程同时进行fork或者终止的操作
  int count[PHYSTOP / PGSIZE]; // 用当前的地址 / 4096 这样就会映射到内存的每个部分,用这个数组来处理引用计数

} ref;

void kinit()
{
  initlock(&kmem.lock, "kmem");
  // 初始化这个自旋锁
  initlock(&ref.lock, "ref");
  freerange(end, (void *)PHYSTOP);
}

void freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char *)PGROUNDUP((uint64)pa_start);
  for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
  {
    ref.count[(uint64)p / PGSIZE] = 1;
    kfree(p);
  }
}

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void kfree(void *pa)
{
  struct run *r;

  if (((uint64)pa % PGSIZE) != 0 || (char *)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  // 在free进行操作的时候,我们先处理引用计数
  acquire(&ref.lock);

  if (--ref.count[(uint64)pa / PGSIZE] == 0)
  {
    // 先把这个lock给释放掉.
    release(&ref.lock);
    // Fill with junk to catch dangling refs.
    memset(pa, 1, PGSIZE);

    r = (struct run *)pa;

    acquire(&kmem.lock);
    r->next = kmem.freelist;
    kmem.freelist = r;
    release(&kmem.lock);
  }
  else
  {
    release(&ref.lock);
  }
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  if (r)
  {
    kmem.freelist = r->next;
    acquire(&ref.lock);
    // 刚开始分配,初始化计数为1
    ref.count[(uint64)r / PGSIZE] = 1;
    release(&ref.lock);
  }
  release(&kmem.lock);

  if (r)
    memset((char *)r, 5, PGSIZE); // fill with junk
  return (void *)r;
}

// 判断是不是cowpage
int is_cowpage(pagetable_t pagetable, uint64 va)
{
  if (va >= MAXVA)
  {
    return -1;
  }
  // walk 找最低级页表项判断是不是cowpage
  pte_t *pte = walk(pagetable, va, 0);
  if (pte == 0)
  {
    return -1;
  }
  if ((*pte & PTE_V) == 0)
  {
    return -1;
  }

  return (*pte & PTE_F) ? 0 : -1;
}

// 给物理地址,获取页面的引用计数
int krefcount(void *pa)
{
  return ref.count[(uint64)pa / PGSIZE];
}

// alloc,增加page的引用计数
int kaddrefcount(void *pa)
{
  if (((uint64)pa % PGSIZE) != 0 || (char *)pa < end || (uint64)pa >= PHYSTOP)
  {
    return -1;
  }

  acquire(&ref.lock);
  ++ref.count[(uint64)pa / PGSIZE];
  release(&ref.lock);

  return 0;
}

// 实现cowalloc,实际上就是lazy alloc,只有需要修改内存的时候,才会进行更改.
void *cowalloc(pagetable_t pagetable, uint64 va)
{
  // 虚拟内存地址要对齐
  if (va % PGSIZE != 0)
  {
    return 0;
  }

  // 拿到物理地址
  uint64 pa = walkaddr(pagetable, va);
  if (pa == 0)
  {
    return 0;
  }

  // 拿到对应的pte最低级的entry
  pte_t *pte = walk(pagetable, va, 0);

  if (krefcount((char *)pa) == 1)
  {
    // 标注是可写的
    *pte |= PTE_W;
    // 去掉fork的标记
    *pte &= (~PTE_F);
    return (void *)pa;
  }
  else
  {
    // 如果存在引用的话就要分配新的页面
    char *mem = kalloc();
    if (mem == 0)
    {
      return 0;
    }

    // 把内存进行复制
    memmove(mem, (char *)pa, PGSIZE);

    // 清除pte_v?
    *pte &= (~PTE_V);

    // 进行这个子进程的映射操作
    if (mappages(pagetable, va, PGSIZE, (uint64)mem, (PTE_FLAGS(*pte) | PTE_W) & (~PTE_F)) != 0)
    {
      kfree(mem);
      *pte |= PTE_V;
      return 0;
    }

    // 一个子进程分出去了,物理内存-1
    // 把物理内存向下来对齐
    kfree((char *)PGROUNDDOWN(pa));
    return mem;
  }
}