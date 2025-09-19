#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "sysinfo.h"


uint64
sys_exit(void)
{
  int n;
  if(argint(0, &n) < 0)
    return -1;
  exit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  if(argaddr(0, &p) < 0)
    return -1;
  return wait(p);
}

uint64
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}



// 内核实现的系统调用处理函数,用户态调用trace的时候,控制流会进入内核,内核调用sys_call()函数
// sys_call函数取用户态的参数mask存入proc的字段,来判断是否继续追踪并且返回0给用户态
// 因为子进程在fork的时候,会复制父进程的mask字段

// 因为参数不会直接传给内核态的函数 用户态--->内核态,切换会保存一个用户态的快照,我们会调用函数argint等等
// 调用这些函数从那个快照里面获取用户态的参数
uint64
sys_trace(void){
  int mask;
  if(argint(0, &mask) < 0){
    return -1;
  }

  // 获取当前的一个进程状态
  struct proc* p = myproc();
  p->tracemask = (uint)mask;
  return 0;
}

uint64
sys_sysinfo(void){
  uint64 dst;
  struct sysinfo info;

  if(argaddr(0, &dst) < 0){
    return -1;
  }
  
  info.freemem = freemem();
  info.nproc = nproc();

  if(copyout(myproc()->pagetable, dst, (char*)&info, sizeof(info)) < 0){
    return -1;
  }
  return 0;
}
