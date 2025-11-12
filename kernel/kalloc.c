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

// 为每个CPU维护一个空闲链表
struct
{
  struct spinlock lock;
  struct run *freelist;
} kmem[NCPU];

//  修改kinit，为所有锁初始化以“kmem”开头的名称，该函数只会被一个CPU调用，freerange调用kfree将所有空闲内存挂在该CPU的空闲列表上
void kinit()
{
  char lockname[8];
  for (int index = 0; index < NCPU; ++index)
  {
    snprintf(lockname, sizeof(lockname), "kmem_%d", index);
    initlock(&kmem[index].lock, lockname);
  }
  freerange(end, (void *)PHYSTOP);
}

void freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char *)PGROUNDUP((uint64)pa_start);
  for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    kfree(p);
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

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);

  r = (struct run *)pa;

  // 关闭中断
  push_off();

  int cpu_index = cpuid();

  acquire(&kmem[cpu_index].lock);
  // 清空并且加入当前空闲链表的头部.
  r->next = kmem[cpu_index].freelist;
  kmem[cpu_index].freelist = r;
  release(&kmem[cpu_index].lock);

  // 开启中断
  pop_off();
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
  struct run *r;
  // 关闭中断
  push_off();

  int id = cpuid();
  acquire(&kmem[id].lock);
  r = kmem[id].freelist;

  if (r)
    kmem[id].freelist = r->next;
  else
  {
    // 自己没有空闲链表了,偷别cpu的去,嘿嘿
    int other_cpu_id;
    for (other_cpu_id = 0; other_cpu_id < NCPU; ++other_cpu_id)
    {
      if (other_cpu_id == id)
      {
        continue; // 偷到自己了,不嘻嘻
      }

      acquire(&kmem[other_cpu_id].lock);
      r = kmem[other_cpu_id].freelist;
      if (r)
      { // 你真抢到了
        kmem[other_cpu_id].freelist = r->next;
        release(&kmem[other_cpu_id].lock);
        break;
      }
      release(&kmem[other_cpu_id].lock);
    }
  }
  release(&kmem[id].lock);
  // 开启中断
  pop_off();

  if (r)
    memset((char *)r, 5, PGSIZE); // fill with junk
  return (void *)r;
}
