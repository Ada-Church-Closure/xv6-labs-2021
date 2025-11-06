
user/_uthread:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thread_init>:
struct thread all_thread[MAX_THREAD];
struct thread *current_thread;
extern void thread_switch(uint64, uint64);

void thread_init(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  // save thread 0's state.  thread_schedule() won't run the main thread ever
  // again, because its state is set to RUNNING, and thread_schedule() selects
  // a RUNNABLE thread.

  // 主线程是thread0,调用thread_schedule,需要一个stack去转换
  current_thread = &all_thread[0];
   8:	00001797          	auipc	a5,0x1
   c:	2e878793          	addi	a5,a5,744 # 12f0 <all_thread>
  10:	00001717          	auipc	a4,0x1
  14:	2cf73823          	sd	a5,720(a4) # 12e0 <current_thread>
  current_thread->state = RUNNING;
  18:	4785                	li	a5,1
  1a:	00003717          	auipc	a4,0x3
  1e:	2cf72b23          	sw	a5,726(a4) # 32f0 <__global_pointer$+0x182c>
}
  22:	60a2                	ld	ra,8(sp)
  24:	6402                	ld	s0,0(sp)
  26:	0141                	addi	sp,sp,16
  28:	8082                	ret

000000000000002a <thread_schedule>:

void thread_schedule(void)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	addi	s0,sp,16
  struct thread *t, *next_thread;

  /* Find another runnable thread. */
  next_thread = 0;
  t = current_thread + 1;
  32:	00001317          	auipc	t1,0x1
  36:	2ae33303          	ld	t1,686(t1) # 12e0 <current_thread>
  3a:	6589                	lui	a1,0x2
  3c:	07858593          	addi	a1,a1,120 # 2078 <__global_pointer$+0x5b4>
  40:	959a                	add	a1,a1,t1
  42:	4791                	li	a5,4
  for (int i = 0; i < MAX_THREAD; i++)
  {
    if (t >= all_thread + MAX_THREAD)
  44:	00009897          	auipc	a7,0x9
  48:	48c88893          	addi	a7,a7,1164 # 94d0 <base>
      t = all_thread;
    if (t->state == RUNNABLE)
  4c:	6809                	lui	a6,0x2
  4e:	4609                	li	a2,2
    {
      next_thread = t;
      break;
    }
    t = t + 1;
  50:	07880693          	addi	a3,a6,120 # 2078 <__global_pointer$+0x5b4>
  54:	a809                	j	66 <thread_schedule+0x3c>
    if (t->state == RUNNABLE)
  56:	01058733          	add	a4,a1,a6
  5a:	4318                	lw	a4,0(a4)
  5c:	02c70963          	beq	a4,a2,8e <thread_schedule+0x64>
    t = t + 1;
  60:	95b6                	add	a1,a1,a3
  for (int i = 0; i < MAX_THREAD; i++)
  62:	37fd                	addiw	a5,a5,-1
  64:	cb81                	beqz	a5,74 <thread_schedule+0x4a>
    if (t >= all_thread + MAX_THREAD)
  66:	ff15e8e3          	bltu	a1,a7,56 <thread_schedule+0x2c>
      t = all_thread;
  6a:	00001597          	auipc	a1,0x1
  6e:	28658593          	addi	a1,a1,646 # 12f0 <all_thread>
  72:	b7d5                	j	56 <thread_schedule+0x2c>
  }

  if (next_thread == 0)
  {
    printf("thread_schedule: no runnable threads\n");
  74:	00001517          	auipc	a0,0x1
  78:	bb450513          	addi	a0,a0,-1100 # c28 <malloc+0xfc>
  7c:	00001097          	auipc	ra,0x1
  80:	9f4080e7          	jalr	-1548(ra) # a70 <printf>
    exit(-1);
  84:	557d                	li	a0,-1
  86:	00000097          	auipc	ra,0x0
  8a:	684080e7          	jalr	1668(ra) # 70a <exit>
  }

  if (current_thread != next_thread)
  8e:	02b30263          	beq	t1,a1,b2 <thread_schedule+0x88>
  { /* switch threads?  */
    next_thread->state = RUNNING;
  92:	6789                	lui	a5,0x2
  94:	97ae                	add	a5,a5,a1
  96:	4705                	li	a4,1
  98:	c398                	sw	a4,0(a5)
    t = current_thread;
    current_thread = next_thread;
  9a:	00001797          	auipc	a5,0x1
  9e:	24b7b323          	sd	a1,582(a5) # 12e0 <current_thread>
     * Invoke thread_switch to switch from t to next_thread:
     * thread_switch(??, ??);
     */
    // 此时旧线程是t,新线程是current_thread
    // 进行寄存器的切换
    thread_switch((uint64)&t->context, (uint64)&current_thread->context);
  a2:	6509                	lui	a0,0x2
  a4:	0521                	addi	a0,a0,8 # 2008 <__global_pointer$+0x544>
  a6:	95aa                	add	a1,a1,a0
  a8:	951a                	add	a0,a0,t1
  aa:	00000097          	auipc	ra,0x0
  ae:	368080e7          	jalr	872(ra) # 412 <thread_switch>
  }
  else
    next_thread = 0;
}
  b2:	60a2                	ld	ra,8(sp)
  b4:	6402                	ld	s0,0(sp)
  b6:	0141                	addi	sp,sp,16
  b8:	8082                	ret

00000000000000ba <thread_create>:

void thread_create(void (*func)())
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e406                	sd	ra,8(sp)
  be:	e022                	sd	s0,0(sp)
  c0:	0800                	addi	s0,sp,16
  struct thread *t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++)
  c2:	00003797          	auipc	a5,0x3
  c6:	2a678793          	addi	a5,a5,678 # 3368 <__global_pointer$+0x18a4>
  ca:	0000b597          	auipc	a1,0xb
  ce:	47e58593          	addi	a1,a1,1150 # b548 <__BSS_END__+0x2068>
  d2:	6609                	lui	a2,0x2
  d4:	07860613          	addi	a2,a2,120 # 2078 <__global_pointer$+0x5b4>
  {
    if (t->state == FREE)
  d8:	873e                	mv	a4,a5
  da:	f887a683          	lw	a3,-120(a5)
  de:	ce91                	beqz	a3,fa <thread_create+0x40>
  for (t = all_thread; t < all_thread + MAX_THREAD; t++)
  e0:	97b2                	add	a5,a5,a2
  e2:	feb79be3          	bne	a5,a1,d8 <thread_create+0x1e>
      break;
  }
  t->state = RUNNABLE;
  e6:	6789                	lui	a5,0x2
  e8:	97ba                	add	a5,a5,a4
  ea:	4709                	li	a4,2
  ec:	c398                	sw	a4,0(a5)
  // YOUR CODE HERE
  // 创建线程,记录此时线程的上下文
  // 刚创建的时候,RUNNABLE.
  // 返回地址就是执行的代码逻辑
  t->context.ra = (uint64)func;
  ee:	e788                	sd	a0,8(a5)
  t->context.sp = (uint64)t->stack + STACK_SIZE;
  f0:	eb9c                	sd	a5,16(a5)
}
  f2:	60a2                	ld	ra,8(sp)
  f4:	6402                	ld	s0,0(sp)
  f6:	0141                	addi	sp,sp,16
  f8:	8082                	ret
  fa:	7779                	lui	a4,0xffffe
  fc:	f8870713          	addi	a4,a4,-120 # ffffffffffffdf88 <__BSS_END__+0xffffffffffff4aa8>
 100:	973e                	add	a4,a4,a5
 102:	b7d5                	j	e6 <thread_create+0x2c>

0000000000000104 <thread_yield>:

// 这个操作需要有原子性
void thread_yield(void)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  current_thread->state = RUNNABLE;
 10c:	00001797          	auipc	a5,0x1
 110:	1d47b783          	ld	a5,468(a5) # 12e0 <current_thread>
 114:	6709                	lui	a4,0x2
 116:	97ba                	add	a5,a5,a4
 118:	4709                	li	a4,2
 11a:	c398                	sw	a4,0(a5)
  thread_schedule();
 11c:	00000097          	auipc	ra,0x0
 120:	f0e080e7          	jalr	-242(ra) # 2a <thread_schedule>
}
 124:	60a2                	ld	ra,8(sp)
 126:	6402                	ld	s0,0(sp)
 128:	0141                	addi	sp,sp,16
 12a:	8082                	ret

000000000000012c <thread_a>:

volatile int a_started, b_started, c_started;
volatile int a_n, b_n, c_n;

void thread_a(void)
{
 12c:	7179                	addi	sp,sp,-48
 12e:	f406                	sd	ra,40(sp)
 130:	f022                	sd	s0,32(sp)
 132:	ec26                	sd	s1,24(sp)
 134:	e84a                	sd	s2,16(sp)
 136:	e44e                	sd	s3,8(sp)
 138:	e052                	sd	s4,0(sp)
 13a:	1800                	addi	s0,sp,48
  int i;
  printf("thread_a started\n");
 13c:	00001517          	auipc	a0,0x1
 140:	b1450513          	addi	a0,a0,-1260 # c50 <malloc+0x124>
 144:	00001097          	auipc	ra,0x1
 148:	92c080e7          	jalr	-1748(ra) # a70 <printf>
  a_started = 1;
 14c:	4785                	li	a5,1
 14e:	00001717          	auipc	a4,0x1
 152:	18f72723          	sw	a5,398(a4) # 12dc <a_started>
  while (b_started == 0 || c_started == 0)
 156:	00001497          	auipc	s1,0x1
 15a:	18248493          	addi	s1,s1,386 # 12d8 <b_started>
 15e:	00001917          	auipc	s2,0x1
 162:	17690913          	addi	s2,s2,374 # 12d4 <c_started>
 166:	a029                	j	170 <thread_a+0x44>
    thread_yield();
 168:	00000097          	auipc	ra,0x0
 16c:	f9c080e7          	jalr	-100(ra) # 104 <thread_yield>
  while (b_started == 0 || c_started == 0)
 170:	409c                	lw	a5,0(s1)
 172:	2781                	sext.w	a5,a5
 174:	dbf5                	beqz	a5,168 <thread_a+0x3c>
 176:	00092783          	lw	a5,0(s2)
 17a:	2781                	sext.w	a5,a5
 17c:	d7f5                	beqz	a5,168 <thread_a+0x3c>

  for (i = 0; i < 100; i++)
 17e:	4481                	li	s1,0
  {
    printf("thread_a %d\n", i);
 180:	00001a17          	auipc	s4,0x1
 184:	ae8a0a13          	addi	s4,s4,-1304 # c68 <malloc+0x13c>
    a_n += 1;
 188:	00001917          	auipc	s2,0x1
 18c:	14890913          	addi	s2,s2,328 # 12d0 <a_n>
  for (i = 0; i < 100; i++)
 190:	06400993          	li	s3,100
    printf("thread_a %d\n", i);
 194:	85a6                	mv	a1,s1
 196:	8552                	mv	a0,s4
 198:	00001097          	auipc	ra,0x1
 19c:	8d8080e7          	jalr	-1832(ra) # a70 <printf>
    a_n += 1;
 1a0:	00092783          	lw	a5,0(s2)
 1a4:	2785                	addiw	a5,a5,1
 1a6:	00f92023          	sw	a5,0(s2)
    thread_yield();
 1aa:	00000097          	auipc	ra,0x0
 1ae:	f5a080e7          	jalr	-166(ra) # 104 <thread_yield>
  for (i = 0; i < 100; i++)
 1b2:	2485                	addiw	s1,s1,1
 1b4:	ff3490e3          	bne	s1,s3,194 <thread_a+0x68>
  }
  printf("thread_a: exit after %d\n", a_n);
 1b8:	00001597          	auipc	a1,0x1
 1bc:	1185a583          	lw	a1,280(a1) # 12d0 <a_n>
 1c0:	00001517          	auipc	a0,0x1
 1c4:	ab850513          	addi	a0,a0,-1352 # c78 <malloc+0x14c>
 1c8:	00001097          	auipc	ra,0x1
 1cc:	8a8080e7          	jalr	-1880(ra) # a70 <printf>

  current_thread->state = FREE;
 1d0:	00001797          	auipc	a5,0x1
 1d4:	1107b783          	ld	a5,272(a5) # 12e0 <current_thread>
 1d8:	6709                	lui	a4,0x2
 1da:	97ba                	add	a5,a5,a4
 1dc:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 1e0:	00000097          	auipc	ra,0x0
 1e4:	e4a080e7          	jalr	-438(ra) # 2a <thread_schedule>
}
 1e8:	70a2                	ld	ra,40(sp)
 1ea:	7402                	ld	s0,32(sp)
 1ec:	64e2                	ld	s1,24(sp)
 1ee:	6942                	ld	s2,16(sp)
 1f0:	69a2                	ld	s3,8(sp)
 1f2:	6a02                	ld	s4,0(sp)
 1f4:	6145                	addi	sp,sp,48
 1f6:	8082                	ret

00000000000001f8 <thread_b>:

void thread_b(void)
{
 1f8:	7179                	addi	sp,sp,-48
 1fa:	f406                	sd	ra,40(sp)
 1fc:	f022                	sd	s0,32(sp)
 1fe:	ec26                	sd	s1,24(sp)
 200:	e84a                	sd	s2,16(sp)
 202:	e44e                	sd	s3,8(sp)
 204:	e052                	sd	s4,0(sp)
 206:	1800                	addi	s0,sp,48
  int i;
  printf("thread_b started\n");
 208:	00001517          	auipc	a0,0x1
 20c:	a9050513          	addi	a0,a0,-1392 # c98 <malloc+0x16c>
 210:	00001097          	auipc	ra,0x1
 214:	860080e7          	jalr	-1952(ra) # a70 <printf>
  b_started = 1;
 218:	4785                	li	a5,1
 21a:	00001717          	auipc	a4,0x1
 21e:	0af72f23          	sw	a5,190(a4) # 12d8 <b_started>
  while (a_started == 0 || c_started == 0)
 222:	00001497          	auipc	s1,0x1
 226:	0ba48493          	addi	s1,s1,186 # 12dc <a_started>
 22a:	00001917          	auipc	s2,0x1
 22e:	0aa90913          	addi	s2,s2,170 # 12d4 <c_started>
 232:	a029                	j	23c <thread_b+0x44>
    thread_yield();
 234:	00000097          	auipc	ra,0x0
 238:	ed0080e7          	jalr	-304(ra) # 104 <thread_yield>
  while (a_started == 0 || c_started == 0)
 23c:	409c                	lw	a5,0(s1)
 23e:	2781                	sext.w	a5,a5
 240:	dbf5                	beqz	a5,234 <thread_b+0x3c>
 242:	00092783          	lw	a5,0(s2)
 246:	2781                	sext.w	a5,a5
 248:	d7f5                	beqz	a5,234 <thread_b+0x3c>

  for (i = 0; i < 100; i++)
 24a:	4481                	li	s1,0
  {
    printf("thread_b %d\n", i);
 24c:	00001a17          	auipc	s4,0x1
 250:	a64a0a13          	addi	s4,s4,-1436 # cb0 <malloc+0x184>
    b_n += 1;
 254:	00001917          	auipc	s2,0x1
 258:	07890913          	addi	s2,s2,120 # 12cc <b_n>
  for (i = 0; i < 100; i++)
 25c:	06400993          	li	s3,100
    printf("thread_b %d\n", i);
 260:	85a6                	mv	a1,s1
 262:	8552                	mv	a0,s4
 264:	00001097          	auipc	ra,0x1
 268:	80c080e7          	jalr	-2036(ra) # a70 <printf>
    b_n += 1;
 26c:	00092783          	lw	a5,0(s2)
 270:	2785                	addiw	a5,a5,1
 272:	00f92023          	sw	a5,0(s2)
    thread_yield();
 276:	00000097          	auipc	ra,0x0
 27a:	e8e080e7          	jalr	-370(ra) # 104 <thread_yield>
  for (i = 0; i < 100; i++)
 27e:	2485                	addiw	s1,s1,1
 280:	ff3490e3          	bne	s1,s3,260 <thread_b+0x68>
  }
  printf("thread_b: exit after %d\n", b_n);
 284:	00001597          	auipc	a1,0x1
 288:	0485a583          	lw	a1,72(a1) # 12cc <b_n>
 28c:	00001517          	auipc	a0,0x1
 290:	a3450513          	addi	a0,a0,-1484 # cc0 <malloc+0x194>
 294:	00000097          	auipc	ra,0x0
 298:	7dc080e7          	jalr	2012(ra) # a70 <printf>

  current_thread->state = FREE;
 29c:	00001797          	auipc	a5,0x1
 2a0:	0447b783          	ld	a5,68(a5) # 12e0 <current_thread>
 2a4:	6709                	lui	a4,0x2
 2a6:	97ba                	add	a5,a5,a4
 2a8:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 2ac:	00000097          	auipc	ra,0x0
 2b0:	d7e080e7          	jalr	-642(ra) # 2a <thread_schedule>
}
 2b4:	70a2                	ld	ra,40(sp)
 2b6:	7402                	ld	s0,32(sp)
 2b8:	64e2                	ld	s1,24(sp)
 2ba:	6942                	ld	s2,16(sp)
 2bc:	69a2                	ld	s3,8(sp)
 2be:	6a02                	ld	s4,0(sp)
 2c0:	6145                	addi	sp,sp,48
 2c2:	8082                	ret

00000000000002c4 <thread_c>:

void thread_c(void)
{
 2c4:	7179                	addi	sp,sp,-48
 2c6:	f406                	sd	ra,40(sp)
 2c8:	f022                	sd	s0,32(sp)
 2ca:	ec26                	sd	s1,24(sp)
 2cc:	e84a                	sd	s2,16(sp)
 2ce:	e44e                	sd	s3,8(sp)
 2d0:	e052                	sd	s4,0(sp)
 2d2:	1800                	addi	s0,sp,48
  int i;
  printf("thread_c started\n");
 2d4:	00001517          	auipc	a0,0x1
 2d8:	a0c50513          	addi	a0,a0,-1524 # ce0 <malloc+0x1b4>
 2dc:	00000097          	auipc	ra,0x0
 2e0:	794080e7          	jalr	1940(ra) # a70 <printf>
  c_started = 1;
 2e4:	4785                	li	a5,1
 2e6:	00001717          	auipc	a4,0x1
 2ea:	fef72723          	sw	a5,-18(a4) # 12d4 <c_started>
  while (a_started == 0 || b_started == 0)
 2ee:	00001497          	auipc	s1,0x1
 2f2:	fee48493          	addi	s1,s1,-18 # 12dc <a_started>
 2f6:	00001917          	auipc	s2,0x1
 2fa:	fe290913          	addi	s2,s2,-30 # 12d8 <b_started>
 2fe:	a029                	j	308 <thread_c+0x44>
    thread_yield();
 300:	00000097          	auipc	ra,0x0
 304:	e04080e7          	jalr	-508(ra) # 104 <thread_yield>
  while (a_started == 0 || b_started == 0)
 308:	409c                	lw	a5,0(s1)
 30a:	2781                	sext.w	a5,a5
 30c:	dbf5                	beqz	a5,300 <thread_c+0x3c>
 30e:	00092783          	lw	a5,0(s2)
 312:	2781                	sext.w	a5,a5
 314:	d7f5                	beqz	a5,300 <thread_c+0x3c>

  for (i = 0; i < 100; i++)
 316:	4481                	li	s1,0
  {
    printf("thread_c %d\n", i);
 318:	00001a17          	auipc	s4,0x1
 31c:	9e0a0a13          	addi	s4,s4,-1568 # cf8 <malloc+0x1cc>
    c_n += 1;
 320:	00001917          	auipc	s2,0x1
 324:	fa890913          	addi	s2,s2,-88 # 12c8 <c_n>
  for (i = 0; i < 100; i++)
 328:	06400993          	li	s3,100
    printf("thread_c %d\n", i);
 32c:	85a6                	mv	a1,s1
 32e:	8552                	mv	a0,s4
 330:	00000097          	auipc	ra,0x0
 334:	740080e7          	jalr	1856(ra) # a70 <printf>
    c_n += 1;
 338:	00092783          	lw	a5,0(s2)
 33c:	2785                	addiw	a5,a5,1
 33e:	00f92023          	sw	a5,0(s2)
    thread_yield();
 342:	00000097          	auipc	ra,0x0
 346:	dc2080e7          	jalr	-574(ra) # 104 <thread_yield>
  for (i = 0; i < 100; i++)
 34a:	2485                	addiw	s1,s1,1
 34c:	ff3490e3          	bne	s1,s3,32c <thread_c+0x68>
  }
  printf("thread_c: exit after %d\n", c_n);
 350:	00001597          	auipc	a1,0x1
 354:	f785a583          	lw	a1,-136(a1) # 12c8 <c_n>
 358:	00001517          	auipc	a0,0x1
 35c:	9b050513          	addi	a0,a0,-1616 # d08 <malloc+0x1dc>
 360:	00000097          	auipc	ra,0x0
 364:	710080e7          	jalr	1808(ra) # a70 <printf>

  current_thread->state = FREE;
 368:	00001797          	auipc	a5,0x1
 36c:	f787b783          	ld	a5,-136(a5) # 12e0 <current_thread>
 370:	6709                	lui	a4,0x2
 372:	97ba                	add	a5,a5,a4
 374:	0007a023          	sw	zero,0(a5)
  thread_schedule();
 378:	00000097          	auipc	ra,0x0
 37c:	cb2080e7          	jalr	-846(ra) # 2a <thread_schedule>
}
 380:	70a2                	ld	ra,40(sp)
 382:	7402                	ld	s0,32(sp)
 384:	64e2                	ld	s1,24(sp)
 386:	6942                	ld	s2,16(sp)
 388:	69a2                	ld	s3,8(sp)
 38a:	6a02                	ld	s4,0(sp)
 38c:	6145                	addi	sp,sp,48
 38e:	8082                	ret

0000000000000390 <main>:

int main(int argc, char *argv[])
{
 390:	1141                	addi	sp,sp,-16
 392:	e406                	sd	ra,8(sp)
 394:	e022                	sd	s0,0(sp)
 396:	0800                	addi	s0,sp,16
  a_started = b_started = c_started = 0;
 398:	00001797          	auipc	a5,0x1
 39c:	f207ae23          	sw	zero,-196(a5) # 12d4 <c_started>
 3a0:	00001797          	auipc	a5,0x1
 3a4:	f207ac23          	sw	zero,-200(a5) # 12d8 <b_started>
 3a8:	00001797          	auipc	a5,0x1
 3ac:	f207aa23          	sw	zero,-204(a5) # 12dc <a_started>
  a_n = b_n = c_n = 0;
 3b0:	00001797          	auipc	a5,0x1
 3b4:	f007ac23          	sw	zero,-232(a5) # 12c8 <c_n>
 3b8:	00001797          	auipc	a5,0x1
 3bc:	f007aa23          	sw	zero,-236(a5) # 12cc <b_n>
 3c0:	00001797          	auipc	a5,0x1
 3c4:	f007a823          	sw	zero,-240(a5) # 12d0 <a_n>
  thread_init();
 3c8:	00000097          	auipc	ra,0x0
 3cc:	c38080e7          	jalr	-968(ra) # 0 <thread_init>
  thread_create(thread_a);
 3d0:	00000517          	auipc	a0,0x0
 3d4:	d5c50513          	addi	a0,a0,-676 # 12c <thread_a>
 3d8:	00000097          	auipc	ra,0x0
 3dc:	ce2080e7          	jalr	-798(ra) # ba <thread_create>
  thread_create(thread_b);
 3e0:	00000517          	auipc	a0,0x0
 3e4:	e1850513          	addi	a0,a0,-488 # 1f8 <thread_b>
 3e8:	00000097          	auipc	ra,0x0
 3ec:	cd2080e7          	jalr	-814(ra) # ba <thread_create>
  thread_create(thread_c);
 3f0:	00000517          	auipc	a0,0x0
 3f4:	ed450513          	addi	a0,a0,-300 # 2c4 <thread_c>
 3f8:	00000097          	auipc	ra,0x0
 3fc:	cc2080e7          	jalr	-830(ra) # ba <thread_create>
  thread_schedule();
 400:	00000097          	auipc	ra,0x0
 404:	c2a080e7          	jalr	-982(ra) # 2a <thread_schedule>
  exit(0);
 408:	4501                	li	a0,0
 40a:	00000097          	auipc	ra,0x0
 40e:	300080e7          	jalr	768(ra) # 70a <exit>

0000000000000412 <thread_switch>:
		 * 直接进行上下文的切换,其实就是寄存器的加载
         */

	.globl thread_switch
thread_switch:
        sd ra, 0(a0)
 412:	00153023          	sd	ra,0(a0)
        sd sp, 8(a0)
 416:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
 41a:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
 41c:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
 41e:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
 422:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
 426:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
 42a:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
 42e:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
 432:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
 436:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
 43a:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
 43e:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
 442:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
 446:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
 44a:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
 44e:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
 450:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
 452:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
 456:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
 45a:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
 45e:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
 462:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
 466:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
 46a:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
 46e:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
 472:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
 476:	0685bd83          	ld	s11,104(a1)
        
	ret    /* return to ra */
 47a:	8082                	ret

000000000000047c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 47c:	1141                	addi	sp,sp,-16
 47e:	e406                	sd	ra,8(sp)
 480:	e022                	sd	s0,0(sp)
 482:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 484:	87aa                	mv	a5,a0
 486:	0585                	addi	a1,a1,1
 488:	0785                	addi	a5,a5,1
 48a:	fff5c703          	lbu	a4,-1(a1)
 48e:	fee78fa3          	sb	a4,-1(a5)
 492:	fb75                	bnez	a4,486 <strcpy+0xa>
    ;
  return os;
}
 494:	60a2                	ld	ra,8(sp)
 496:	6402                	ld	s0,0(sp)
 498:	0141                	addi	sp,sp,16
 49a:	8082                	ret

000000000000049c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 49c:	1141                	addi	sp,sp,-16
 49e:	e406                	sd	ra,8(sp)
 4a0:	e022                	sd	s0,0(sp)
 4a2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 4a4:	00054783          	lbu	a5,0(a0)
 4a8:	cb91                	beqz	a5,4bc <strcmp+0x20>
 4aa:	0005c703          	lbu	a4,0(a1)
 4ae:	00f71763          	bne	a4,a5,4bc <strcmp+0x20>
    p++, q++;
 4b2:	0505                	addi	a0,a0,1
 4b4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	fbe5                	bnez	a5,4aa <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 4bc:	0005c503          	lbu	a0,0(a1)
}
 4c0:	40a7853b          	subw	a0,a5,a0
 4c4:	60a2                	ld	ra,8(sp)
 4c6:	6402                	ld	s0,0(sp)
 4c8:	0141                	addi	sp,sp,16
 4ca:	8082                	ret

00000000000004cc <strlen>:

uint
strlen(const char *s)
{
 4cc:	1141                	addi	sp,sp,-16
 4ce:	e406                	sd	ra,8(sp)
 4d0:	e022                	sd	s0,0(sp)
 4d2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4d4:	00054783          	lbu	a5,0(a0)
 4d8:	cf91                	beqz	a5,4f4 <strlen+0x28>
 4da:	00150793          	addi	a5,a0,1
 4de:	86be                	mv	a3,a5
 4e0:	0785                	addi	a5,a5,1
 4e2:	fff7c703          	lbu	a4,-1(a5)
 4e6:	ff65                	bnez	a4,4de <strlen+0x12>
 4e8:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 4ec:	60a2                	ld	ra,8(sp)
 4ee:	6402                	ld	s0,0(sp)
 4f0:	0141                	addi	sp,sp,16
 4f2:	8082                	ret
  for(n = 0; s[n]; n++)
 4f4:	4501                	li	a0,0
 4f6:	bfdd                	j	4ec <strlen+0x20>

00000000000004f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4f8:	1141                	addi	sp,sp,-16
 4fa:	e406                	sd	ra,8(sp)
 4fc:	e022                	sd	s0,0(sp)
 4fe:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 500:	ca19                	beqz	a2,516 <memset+0x1e>
 502:	87aa                	mv	a5,a0
 504:	1602                	slli	a2,a2,0x20
 506:	9201                	srli	a2,a2,0x20
 508:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 50c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 510:	0785                	addi	a5,a5,1
 512:	fee79de3          	bne	a5,a4,50c <memset+0x14>
  }
  return dst;
}
 516:	60a2                	ld	ra,8(sp)
 518:	6402                	ld	s0,0(sp)
 51a:	0141                	addi	sp,sp,16
 51c:	8082                	ret

000000000000051e <strchr>:

char*
strchr(const char *s, char c)
{
 51e:	1141                	addi	sp,sp,-16
 520:	e406                	sd	ra,8(sp)
 522:	e022                	sd	s0,0(sp)
 524:	0800                	addi	s0,sp,16
  for(; *s; s++)
 526:	00054783          	lbu	a5,0(a0)
 52a:	cf81                	beqz	a5,542 <strchr+0x24>
    if(*s == c)
 52c:	00f58763          	beq	a1,a5,53a <strchr+0x1c>
  for(; *s; s++)
 530:	0505                	addi	a0,a0,1
 532:	00054783          	lbu	a5,0(a0)
 536:	fbfd                	bnez	a5,52c <strchr+0xe>
      return (char*)s;
  return 0;
 538:	4501                	li	a0,0
}
 53a:	60a2                	ld	ra,8(sp)
 53c:	6402                	ld	s0,0(sp)
 53e:	0141                	addi	sp,sp,16
 540:	8082                	ret
  return 0;
 542:	4501                	li	a0,0
 544:	bfdd                	j	53a <strchr+0x1c>

0000000000000546 <gets>:

char*
gets(char *buf, int max)
{
 546:	711d                	addi	sp,sp,-96
 548:	ec86                	sd	ra,88(sp)
 54a:	e8a2                	sd	s0,80(sp)
 54c:	e4a6                	sd	s1,72(sp)
 54e:	e0ca                	sd	s2,64(sp)
 550:	fc4e                	sd	s3,56(sp)
 552:	f852                	sd	s4,48(sp)
 554:	f456                	sd	s5,40(sp)
 556:	f05a                	sd	s6,32(sp)
 558:	ec5e                	sd	s7,24(sp)
 55a:	e862                	sd	s8,16(sp)
 55c:	1080                	addi	s0,sp,96
 55e:	8baa                	mv	s7,a0
 560:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 562:	892a                	mv	s2,a0
 564:	4481                	li	s1,0
    cc = read(0, &c, 1);
 566:	faf40b13          	addi	s6,s0,-81
 56a:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 56c:	8c26                	mv	s8,s1
 56e:	0014899b          	addiw	s3,s1,1
 572:	84ce                	mv	s1,s3
 574:	0349d663          	bge	s3,s4,5a0 <gets+0x5a>
    cc = read(0, &c, 1);
 578:	8656                	mv	a2,s5
 57a:	85da                	mv	a1,s6
 57c:	4501                	li	a0,0
 57e:	00000097          	auipc	ra,0x0
 582:	1a4080e7          	jalr	420(ra) # 722 <read>
    if(cc < 1)
 586:	00a05d63          	blez	a0,5a0 <gets+0x5a>
      break;
    buf[i++] = c;
 58a:	faf44783          	lbu	a5,-81(s0)
 58e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 592:	0905                	addi	s2,s2,1
 594:	ff678713          	addi	a4,a5,-10
 598:	c319                	beqz	a4,59e <gets+0x58>
 59a:	17cd                	addi	a5,a5,-13
 59c:	fbe1                	bnez	a5,56c <gets+0x26>
    buf[i++] = c;
 59e:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 5a0:	9c5e                	add	s8,s8,s7
 5a2:	000c0023          	sb	zero,0(s8)
  return buf;
}
 5a6:	855e                	mv	a0,s7
 5a8:	60e6                	ld	ra,88(sp)
 5aa:	6446                	ld	s0,80(sp)
 5ac:	64a6                	ld	s1,72(sp)
 5ae:	6906                	ld	s2,64(sp)
 5b0:	79e2                	ld	s3,56(sp)
 5b2:	7a42                	ld	s4,48(sp)
 5b4:	7aa2                	ld	s5,40(sp)
 5b6:	7b02                	ld	s6,32(sp)
 5b8:	6be2                	ld	s7,24(sp)
 5ba:	6c42                	ld	s8,16(sp)
 5bc:	6125                	addi	sp,sp,96
 5be:	8082                	ret

00000000000005c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 5c0:	1101                	addi	sp,sp,-32
 5c2:	ec06                	sd	ra,24(sp)
 5c4:	e822                	sd	s0,16(sp)
 5c6:	e04a                	sd	s2,0(sp)
 5c8:	1000                	addi	s0,sp,32
 5ca:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5cc:	4581                	li	a1,0
 5ce:	00000097          	auipc	ra,0x0
 5d2:	17c080e7          	jalr	380(ra) # 74a <open>
  if(fd < 0)
 5d6:	02054663          	bltz	a0,602 <stat+0x42>
 5da:	e426                	sd	s1,8(sp)
 5dc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 5de:	85ca                	mv	a1,s2
 5e0:	00000097          	auipc	ra,0x0
 5e4:	182080e7          	jalr	386(ra) # 762 <fstat>
 5e8:	892a                	mv	s2,a0
  close(fd);
 5ea:	8526                	mv	a0,s1
 5ec:	00000097          	auipc	ra,0x0
 5f0:	146080e7          	jalr	326(ra) # 732 <close>
  return r;
 5f4:	64a2                	ld	s1,8(sp)
}
 5f6:	854a                	mv	a0,s2
 5f8:	60e2                	ld	ra,24(sp)
 5fa:	6442                	ld	s0,16(sp)
 5fc:	6902                	ld	s2,0(sp)
 5fe:	6105                	addi	sp,sp,32
 600:	8082                	ret
    return -1;
 602:	57fd                	li	a5,-1
 604:	893e                	mv	s2,a5
 606:	bfc5                	j	5f6 <stat+0x36>

0000000000000608 <atoi>:

int
atoi(const char *s)
{
 608:	1141                	addi	sp,sp,-16
 60a:	e406                	sd	ra,8(sp)
 60c:	e022                	sd	s0,0(sp)
 60e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 610:	00054683          	lbu	a3,0(a0)
 614:	fd06879b          	addiw	a5,a3,-48
 618:	0ff7f793          	zext.b	a5,a5
 61c:	4625                	li	a2,9
 61e:	02f66963          	bltu	a2,a5,650 <atoi+0x48>
 622:	872a                	mv	a4,a0
  n = 0;
 624:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 626:	0705                	addi	a4,a4,1 # 2001 <__global_pointer$+0x53d>
 628:	0025179b          	slliw	a5,a0,0x2
 62c:	9fa9                	addw	a5,a5,a0
 62e:	0017979b          	slliw	a5,a5,0x1
 632:	9fb5                	addw	a5,a5,a3
 634:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 638:	00074683          	lbu	a3,0(a4)
 63c:	fd06879b          	addiw	a5,a3,-48
 640:	0ff7f793          	zext.b	a5,a5
 644:	fef671e3          	bgeu	a2,a5,626 <atoi+0x1e>
  return n;
}
 648:	60a2                	ld	ra,8(sp)
 64a:	6402                	ld	s0,0(sp)
 64c:	0141                	addi	sp,sp,16
 64e:	8082                	ret
  n = 0;
 650:	4501                	li	a0,0
 652:	bfdd                	j	648 <atoi+0x40>

0000000000000654 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 654:	1141                	addi	sp,sp,-16
 656:	e406                	sd	ra,8(sp)
 658:	e022                	sd	s0,0(sp)
 65a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 65c:	02b57563          	bgeu	a0,a1,686 <memmove+0x32>
    while(n-- > 0)
 660:	00c05f63          	blez	a2,67e <memmove+0x2a>
 664:	1602                	slli	a2,a2,0x20
 666:	9201                	srli	a2,a2,0x20
 668:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 66c:	872a                	mv	a4,a0
      *dst++ = *src++;
 66e:	0585                	addi	a1,a1,1
 670:	0705                	addi	a4,a4,1
 672:	fff5c683          	lbu	a3,-1(a1)
 676:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 67a:	fee79ae3          	bne	a5,a4,66e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 67e:	60a2                	ld	ra,8(sp)
 680:	6402                	ld	s0,0(sp)
 682:	0141                	addi	sp,sp,16
 684:	8082                	ret
    while(n-- > 0)
 686:	fec05ce3          	blez	a2,67e <memmove+0x2a>
    dst += n;
 68a:	00c50733          	add	a4,a0,a2
    src += n;
 68e:	95b2                	add	a1,a1,a2
 690:	fff6079b          	addiw	a5,a2,-1
 694:	1782                	slli	a5,a5,0x20
 696:	9381                	srli	a5,a5,0x20
 698:	fff7c793          	not	a5,a5
 69c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 69e:	15fd                	addi	a1,a1,-1
 6a0:	177d                	addi	a4,a4,-1
 6a2:	0005c683          	lbu	a3,0(a1)
 6a6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 6aa:	fef71ae3          	bne	a4,a5,69e <memmove+0x4a>
 6ae:	bfc1                	j	67e <memmove+0x2a>

00000000000006b0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 6b0:	1141                	addi	sp,sp,-16
 6b2:	e406                	sd	ra,8(sp)
 6b4:	e022                	sd	s0,0(sp)
 6b6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 6b8:	c61d                	beqz	a2,6e6 <memcmp+0x36>
 6ba:	1602                	slli	a2,a2,0x20
 6bc:	9201                	srli	a2,a2,0x20
 6be:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 6c2:	00054783          	lbu	a5,0(a0)
 6c6:	0005c703          	lbu	a4,0(a1)
 6ca:	00e79863          	bne	a5,a4,6da <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 6ce:	0505                	addi	a0,a0,1
    p2++;
 6d0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 6d2:	fed518e3          	bne	a0,a3,6c2 <memcmp+0x12>
  }
  return 0;
 6d6:	4501                	li	a0,0
 6d8:	a019                	j	6de <memcmp+0x2e>
      return *p1 - *p2;
 6da:	40e7853b          	subw	a0,a5,a4
}
 6de:	60a2                	ld	ra,8(sp)
 6e0:	6402                	ld	s0,0(sp)
 6e2:	0141                	addi	sp,sp,16
 6e4:	8082                	ret
  return 0;
 6e6:	4501                	li	a0,0
 6e8:	bfdd                	j	6de <memcmp+0x2e>

00000000000006ea <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6ea:	1141                	addi	sp,sp,-16
 6ec:	e406                	sd	ra,8(sp)
 6ee:	e022                	sd	s0,0(sp)
 6f0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 6f2:	00000097          	auipc	ra,0x0
 6f6:	f62080e7          	jalr	-158(ra) # 654 <memmove>
}
 6fa:	60a2                	ld	ra,8(sp)
 6fc:	6402                	ld	s0,0(sp)
 6fe:	0141                	addi	sp,sp,16
 700:	8082                	ret

0000000000000702 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 702:	4885                	li	a7,1
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <exit>:
.global exit
exit:
 li a7, SYS_exit
 70a:	4889                	li	a7,2
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <wait>:
.global wait
wait:
 li a7, SYS_wait
 712:	488d                	li	a7,3
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 71a:	4891                	li	a7,4
 ecall
 71c:	00000073          	ecall
 ret
 720:	8082                	ret

0000000000000722 <read>:
.global read
read:
 li a7, SYS_read
 722:	4895                	li	a7,5
 ecall
 724:	00000073          	ecall
 ret
 728:	8082                	ret

000000000000072a <write>:
.global write
write:
 li a7, SYS_write
 72a:	48c1                	li	a7,16
 ecall
 72c:	00000073          	ecall
 ret
 730:	8082                	ret

0000000000000732 <close>:
.global close
close:
 li a7, SYS_close
 732:	48d5                	li	a7,21
 ecall
 734:	00000073          	ecall
 ret
 738:	8082                	ret

000000000000073a <kill>:
.global kill
kill:
 li a7, SYS_kill
 73a:	4899                	li	a7,6
 ecall
 73c:	00000073          	ecall
 ret
 740:	8082                	ret

0000000000000742 <exec>:
.global exec
exec:
 li a7, SYS_exec
 742:	489d                	li	a7,7
 ecall
 744:	00000073          	ecall
 ret
 748:	8082                	ret

000000000000074a <open>:
.global open
open:
 li a7, SYS_open
 74a:	48bd                	li	a7,15
 ecall
 74c:	00000073          	ecall
 ret
 750:	8082                	ret

0000000000000752 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 752:	48c5                	li	a7,17
 ecall
 754:	00000073          	ecall
 ret
 758:	8082                	ret

000000000000075a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 75a:	48c9                	li	a7,18
 ecall
 75c:	00000073          	ecall
 ret
 760:	8082                	ret

0000000000000762 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 762:	48a1                	li	a7,8
 ecall
 764:	00000073          	ecall
 ret
 768:	8082                	ret

000000000000076a <link>:
.global link
link:
 li a7, SYS_link
 76a:	48cd                	li	a7,19
 ecall
 76c:	00000073          	ecall
 ret
 770:	8082                	ret

0000000000000772 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 772:	48d1                	li	a7,20
 ecall
 774:	00000073          	ecall
 ret
 778:	8082                	ret

000000000000077a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 77a:	48a5                	li	a7,9
 ecall
 77c:	00000073          	ecall
 ret
 780:	8082                	ret

0000000000000782 <dup>:
.global dup
dup:
 li a7, SYS_dup
 782:	48a9                	li	a7,10
 ecall
 784:	00000073          	ecall
 ret
 788:	8082                	ret

000000000000078a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 78a:	48ad                	li	a7,11
 ecall
 78c:	00000073          	ecall
 ret
 790:	8082                	ret

0000000000000792 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 792:	48b1                	li	a7,12
 ecall
 794:	00000073          	ecall
 ret
 798:	8082                	ret

000000000000079a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 79a:	48b5                	li	a7,13
 ecall
 79c:	00000073          	ecall
 ret
 7a0:	8082                	ret

00000000000007a2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7a2:	48b9                	li	a7,14
 ecall
 7a4:	00000073          	ecall
 ret
 7a8:	8082                	ret

00000000000007aa <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7aa:	1101                	addi	sp,sp,-32
 7ac:	ec06                	sd	ra,24(sp)
 7ae:	e822                	sd	s0,16(sp)
 7b0:	1000                	addi	s0,sp,32
 7b2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 7b6:	4605                	li	a2,1
 7b8:	fef40593          	addi	a1,s0,-17
 7bc:	00000097          	auipc	ra,0x0
 7c0:	f6e080e7          	jalr	-146(ra) # 72a <write>
}
 7c4:	60e2                	ld	ra,24(sp)
 7c6:	6442                	ld	s0,16(sp)
 7c8:	6105                	addi	sp,sp,32
 7ca:	8082                	ret

00000000000007cc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7cc:	7139                	addi	sp,sp,-64
 7ce:	fc06                	sd	ra,56(sp)
 7d0:	f822                	sd	s0,48(sp)
 7d2:	f04a                	sd	s2,32(sp)
 7d4:	ec4e                	sd	s3,24(sp)
 7d6:	0080                	addi	s0,sp,64
 7d8:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7da:	cad9                	beqz	a3,870 <printint+0xa4>
 7dc:	01f5d79b          	srliw	a5,a1,0x1f
 7e0:	cbc1                	beqz	a5,870 <printint+0xa4>
    neg = 1;
    x = -xx;
 7e2:	40b005bb          	negw	a1,a1
    neg = 1;
 7e6:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 7e8:	fc040993          	addi	s3,s0,-64
  neg = 0;
 7ec:	86ce                	mv	a3,s3
  i = 0;
 7ee:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7f0:	00000817          	auipc	a6,0x0
 7f4:	59880813          	addi	a6,a6,1432 # d88 <digits>
 7f8:	88ba                	mv	a7,a4
 7fa:	0017051b          	addiw	a0,a4,1
 7fe:	872a                	mv	a4,a0
 800:	02c5f7bb          	remuw	a5,a1,a2
 804:	1782                	slli	a5,a5,0x20
 806:	9381                	srli	a5,a5,0x20
 808:	97c2                	add	a5,a5,a6
 80a:	0007c783          	lbu	a5,0(a5)
 80e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 812:	87ae                	mv	a5,a1
 814:	02c5d5bb          	divuw	a1,a1,a2
 818:	0685                	addi	a3,a3,1
 81a:	fcc7ffe3          	bgeu	a5,a2,7f8 <printint+0x2c>
  if(neg)
 81e:	00030c63          	beqz	t1,836 <printint+0x6a>
    buf[i++] = '-';
 822:	fd050793          	addi	a5,a0,-48
 826:	00878533          	add	a0,a5,s0
 82a:	02d00793          	li	a5,45
 82e:	fef50823          	sb	a5,-16(a0)
 832:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 836:	02e05763          	blez	a4,864 <printint+0x98>
 83a:	f426                	sd	s1,40(sp)
 83c:	377d                	addiw	a4,a4,-1
 83e:	00e984b3          	add	s1,s3,a4
 842:	19fd                	addi	s3,s3,-1
 844:	99ba                	add	s3,s3,a4
 846:	1702                	slli	a4,a4,0x20
 848:	9301                	srli	a4,a4,0x20
 84a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 84e:	0004c583          	lbu	a1,0(s1)
 852:	854a                	mv	a0,s2
 854:	00000097          	auipc	ra,0x0
 858:	f56080e7          	jalr	-170(ra) # 7aa <putc>
  while(--i >= 0)
 85c:	14fd                	addi	s1,s1,-1
 85e:	ff3498e3          	bne	s1,s3,84e <printint+0x82>
 862:	74a2                	ld	s1,40(sp)
}
 864:	70e2                	ld	ra,56(sp)
 866:	7442                	ld	s0,48(sp)
 868:	7902                	ld	s2,32(sp)
 86a:	69e2                	ld	s3,24(sp)
 86c:	6121                	addi	sp,sp,64
 86e:	8082                	ret
  neg = 0;
 870:	4301                	li	t1,0
 872:	bf9d                	j	7e8 <printint+0x1c>

0000000000000874 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 874:	715d                	addi	sp,sp,-80
 876:	e486                	sd	ra,72(sp)
 878:	e0a2                	sd	s0,64(sp)
 87a:	f84a                	sd	s2,48(sp)
 87c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 87e:	0005c903          	lbu	s2,0(a1)
 882:	1a090b63          	beqz	s2,a38 <vprintf+0x1c4>
 886:	fc26                	sd	s1,56(sp)
 888:	f44e                	sd	s3,40(sp)
 88a:	f052                	sd	s4,32(sp)
 88c:	ec56                	sd	s5,24(sp)
 88e:	e85a                	sd	s6,16(sp)
 890:	e45e                	sd	s7,8(sp)
 892:	8aaa                	mv	s5,a0
 894:	8bb2                	mv	s7,a2
 896:	00158493          	addi	s1,a1,1
  state = 0;
 89a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 89c:	02500a13          	li	s4,37
 8a0:	4b55                	li	s6,21
 8a2:	a839                	j	8c0 <vprintf+0x4c>
        putc(fd, c);
 8a4:	85ca                	mv	a1,s2
 8a6:	8556                	mv	a0,s5
 8a8:	00000097          	auipc	ra,0x0
 8ac:	f02080e7          	jalr	-254(ra) # 7aa <putc>
 8b0:	a019                	j	8b6 <vprintf+0x42>
    } else if(state == '%'){
 8b2:	01498d63          	beq	s3,s4,8cc <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 8b6:	0485                	addi	s1,s1,1
 8b8:	fff4c903          	lbu	s2,-1(s1)
 8bc:	16090863          	beqz	s2,a2c <vprintf+0x1b8>
    if(state == 0){
 8c0:	fe0999e3          	bnez	s3,8b2 <vprintf+0x3e>
      if(c == '%'){
 8c4:	ff4910e3          	bne	s2,s4,8a4 <vprintf+0x30>
        state = '%';
 8c8:	89d2                	mv	s3,s4
 8ca:	b7f5                	j	8b6 <vprintf+0x42>
      if(c == 'd'){
 8cc:	13490563          	beq	s2,s4,9f6 <vprintf+0x182>
 8d0:	f9d9079b          	addiw	a5,s2,-99
 8d4:	0ff7f793          	zext.b	a5,a5
 8d8:	12fb6863          	bltu	s6,a5,a08 <vprintf+0x194>
 8dc:	f9d9079b          	addiw	a5,s2,-99
 8e0:	0ff7f713          	zext.b	a4,a5
 8e4:	12eb6263          	bltu	s6,a4,a08 <vprintf+0x194>
 8e8:	00271793          	slli	a5,a4,0x2
 8ec:	00000717          	auipc	a4,0x0
 8f0:	44470713          	addi	a4,a4,1092 # d30 <malloc+0x204>
 8f4:	97ba                	add	a5,a5,a4
 8f6:	439c                	lw	a5,0(a5)
 8f8:	97ba                	add	a5,a5,a4
 8fa:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8fc:	008b8913          	addi	s2,s7,8
 900:	4685                	li	a3,1
 902:	4629                	li	a2,10
 904:	000ba583          	lw	a1,0(s7)
 908:	8556                	mv	a0,s5
 90a:	00000097          	auipc	ra,0x0
 90e:	ec2080e7          	jalr	-318(ra) # 7cc <printint>
 912:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 914:	4981                	li	s3,0
 916:	b745                	j	8b6 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 918:	008b8913          	addi	s2,s7,8
 91c:	4681                	li	a3,0
 91e:	4629                	li	a2,10
 920:	000ba583          	lw	a1,0(s7)
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	ea6080e7          	jalr	-346(ra) # 7cc <printint>
 92e:	8bca                	mv	s7,s2
      state = 0;
 930:	4981                	li	s3,0
 932:	b751                	j	8b6 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 934:	008b8913          	addi	s2,s7,8
 938:	4681                	li	a3,0
 93a:	4641                	li	a2,16
 93c:	000ba583          	lw	a1,0(s7)
 940:	8556                	mv	a0,s5
 942:	00000097          	auipc	ra,0x0
 946:	e8a080e7          	jalr	-374(ra) # 7cc <printint>
 94a:	8bca                	mv	s7,s2
      state = 0;
 94c:	4981                	li	s3,0
 94e:	b7a5                	j	8b6 <vprintf+0x42>
 950:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 952:	008b8793          	addi	a5,s7,8
 956:	8c3e                	mv	s8,a5
 958:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 95c:	03000593          	li	a1,48
 960:	8556                	mv	a0,s5
 962:	00000097          	auipc	ra,0x0
 966:	e48080e7          	jalr	-440(ra) # 7aa <putc>
  putc(fd, 'x');
 96a:	07800593          	li	a1,120
 96e:	8556                	mv	a0,s5
 970:	00000097          	auipc	ra,0x0
 974:	e3a080e7          	jalr	-454(ra) # 7aa <putc>
 978:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 97a:	00000b97          	auipc	s7,0x0
 97e:	40eb8b93          	addi	s7,s7,1038 # d88 <digits>
 982:	03c9d793          	srli	a5,s3,0x3c
 986:	97de                	add	a5,a5,s7
 988:	0007c583          	lbu	a1,0(a5)
 98c:	8556                	mv	a0,s5
 98e:	00000097          	auipc	ra,0x0
 992:	e1c080e7          	jalr	-484(ra) # 7aa <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 996:	0992                	slli	s3,s3,0x4
 998:	397d                	addiw	s2,s2,-1
 99a:	fe0914e3          	bnez	s2,982 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 99e:	8be2                	mv	s7,s8
      state = 0;
 9a0:	4981                	li	s3,0
 9a2:	6c02                	ld	s8,0(sp)
 9a4:	bf09                	j	8b6 <vprintf+0x42>
        s = va_arg(ap, char*);
 9a6:	008b8993          	addi	s3,s7,8
 9aa:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 9ae:	02090163          	beqz	s2,9d0 <vprintf+0x15c>
        while(*s != 0){
 9b2:	00094583          	lbu	a1,0(s2)
 9b6:	c9a5                	beqz	a1,a26 <vprintf+0x1b2>
          putc(fd, *s);
 9b8:	8556                	mv	a0,s5
 9ba:	00000097          	auipc	ra,0x0
 9be:	df0080e7          	jalr	-528(ra) # 7aa <putc>
          s++;
 9c2:	0905                	addi	s2,s2,1
        while(*s != 0){
 9c4:	00094583          	lbu	a1,0(s2)
 9c8:	f9e5                	bnez	a1,9b8 <vprintf+0x144>
        s = va_arg(ap, char*);
 9ca:	8bce                	mv	s7,s3
      state = 0;
 9cc:	4981                	li	s3,0
 9ce:	b5e5                	j	8b6 <vprintf+0x42>
          s = "(null)";
 9d0:	00000917          	auipc	s2,0x0
 9d4:	35890913          	addi	s2,s2,856 # d28 <malloc+0x1fc>
        while(*s != 0){
 9d8:	02800593          	li	a1,40
 9dc:	bff1                	j	9b8 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 9de:	008b8913          	addi	s2,s7,8
 9e2:	000bc583          	lbu	a1,0(s7)
 9e6:	8556                	mv	a0,s5
 9e8:	00000097          	auipc	ra,0x0
 9ec:	dc2080e7          	jalr	-574(ra) # 7aa <putc>
 9f0:	8bca                	mv	s7,s2
      state = 0;
 9f2:	4981                	li	s3,0
 9f4:	b5c9                	j	8b6 <vprintf+0x42>
        putc(fd, c);
 9f6:	02500593          	li	a1,37
 9fa:	8556                	mv	a0,s5
 9fc:	00000097          	auipc	ra,0x0
 a00:	dae080e7          	jalr	-594(ra) # 7aa <putc>
      state = 0;
 a04:	4981                	li	s3,0
 a06:	bd45                	j	8b6 <vprintf+0x42>
        putc(fd, '%');
 a08:	02500593          	li	a1,37
 a0c:	8556                	mv	a0,s5
 a0e:	00000097          	auipc	ra,0x0
 a12:	d9c080e7          	jalr	-612(ra) # 7aa <putc>
        putc(fd, c);
 a16:	85ca                	mv	a1,s2
 a18:	8556                	mv	a0,s5
 a1a:	00000097          	auipc	ra,0x0
 a1e:	d90080e7          	jalr	-624(ra) # 7aa <putc>
      state = 0;
 a22:	4981                	li	s3,0
 a24:	bd49                	j	8b6 <vprintf+0x42>
        s = va_arg(ap, char*);
 a26:	8bce                	mv	s7,s3
      state = 0;
 a28:	4981                	li	s3,0
 a2a:	b571                	j	8b6 <vprintf+0x42>
 a2c:	74e2                	ld	s1,56(sp)
 a2e:	79a2                	ld	s3,40(sp)
 a30:	7a02                	ld	s4,32(sp)
 a32:	6ae2                	ld	s5,24(sp)
 a34:	6b42                	ld	s6,16(sp)
 a36:	6ba2                	ld	s7,8(sp)
    }
  }
}
 a38:	60a6                	ld	ra,72(sp)
 a3a:	6406                	ld	s0,64(sp)
 a3c:	7942                	ld	s2,48(sp)
 a3e:	6161                	addi	sp,sp,80
 a40:	8082                	ret

0000000000000a42 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a42:	715d                	addi	sp,sp,-80
 a44:	ec06                	sd	ra,24(sp)
 a46:	e822                	sd	s0,16(sp)
 a48:	1000                	addi	s0,sp,32
 a4a:	e010                	sd	a2,0(s0)
 a4c:	e414                	sd	a3,8(s0)
 a4e:	e818                	sd	a4,16(s0)
 a50:	ec1c                	sd	a5,24(s0)
 a52:	03043023          	sd	a6,32(s0)
 a56:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a5a:	8622                	mv	a2,s0
 a5c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a60:	00000097          	auipc	ra,0x0
 a64:	e14080e7          	jalr	-492(ra) # 874 <vprintf>
}
 a68:	60e2                	ld	ra,24(sp)
 a6a:	6442                	ld	s0,16(sp)
 a6c:	6161                	addi	sp,sp,80
 a6e:	8082                	ret

0000000000000a70 <printf>:

void
printf(const char *fmt, ...)
{
 a70:	711d                	addi	sp,sp,-96
 a72:	ec06                	sd	ra,24(sp)
 a74:	e822                	sd	s0,16(sp)
 a76:	1000                	addi	s0,sp,32
 a78:	e40c                	sd	a1,8(s0)
 a7a:	e810                	sd	a2,16(s0)
 a7c:	ec14                	sd	a3,24(s0)
 a7e:	f018                	sd	a4,32(s0)
 a80:	f41c                	sd	a5,40(s0)
 a82:	03043823          	sd	a6,48(s0)
 a86:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a8a:	00840613          	addi	a2,s0,8
 a8e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a92:	85aa                	mv	a1,a0
 a94:	4505                	li	a0,1
 a96:	00000097          	auipc	ra,0x0
 a9a:	dde080e7          	jalr	-546(ra) # 874 <vprintf>
}
 a9e:	60e2                	ld	ra,24(sp)
 aa0:	6442                	ld	s0,16(sp)
 aa2:	6125                	addi	sp,sp,96
 aa4:	8082                	ret

0000000000000aa6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 aa6:	1141                	addi	sp,sp,-16
 aa8:	e406                	sd	ra,8(sp)
 aaa:	e022                	sd	s0,0(sp)
 aac:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 aae:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ab2:	00001797          	auipc	a5,0x1
 ab6:	8367b783          	ld	a5,-1994(a5) # 12e8 <freep>
 aba:	a039                	j	ac8 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 abc:	6398                	ld	a4,0(a5)
 abe:	00e7e463          	bltu	a5,a4,ac6 <free+0x20>
 ac2:	00e6ea63          	bltu	a3,a4,ad6 <free+0x30>
{
 ac6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac8:	fed7fae3          	bgeu	a5,a3,abc <free+0x16>
 acc:	6398                	ld	a4,0(a5)
 ace:	00e6e463          	bltu	a3,a4,ad6 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad2:	fee7eae3          	bltu	a5,a4,ac6 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ad6:	ff852583          	lw	a1,-8(a0)
 ada:	6390                	ld	a2,0(a5)
 adc:	02059813          	slli	a6,a1,0x20
 ae0:	01c85713          	srli	a4,a6,0x1c
 ae4:	9736                	add	a4,a4,a3
 ae6:	02e60563          	beq	a2,a4,b10 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 aea:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 aee:	4790                	lw	a2,8(a5)
 af0:	02061593          	slli	a1,a2,0x20
 af4:	01c5d713          	srli	a4,a1,0x1c
 af8:	973e                	add	a4,a4,a5
 afa:	02e68263          	beq	a3,a4,b1e <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 afe:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 b00:	00000717          	auipc	a4,0x0
 b04:	7ef73423          	sd	a5,2024(a4) # 12e8 <freep>
}
 b08:	60a2                	ld	ra,8(sp)
 b0a:	6402                	ld	s0,0(sp)
 b0c:	0141                	addi	sp,sp,16
 b0e:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 b10:	4618                	lw	a4,8(a2)
 b12:	9f2d                	addw	a4,a4,a1
 b14:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b18:	6398                	ld	a4,0(a5)
 b1a:	6310                	ld	a2,0(a4)
 b1c:	b7f9                	j	aea <free+0x44>
    p->s.size += bp->s.size;
 b1e:	ff852703          	lw	a4,-8(a0)
 b22:	9f31                	addw	a4,a4,a2
 b24:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 b26:	ff053683          	ld	a3,-16(a0)
 b2a:	bfd1                	j	afe <free+0x58>

0000000000000b2c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b2c:	7139                	addi	sp,sp,-64
 b2e:	fc06                	sd	ra,56(sp)
 b30:	f822                	sd	s0,48(sp)
 b32:	f04a                	sd	s2,32(sp)
 b34:	ec4e                	sd	s3,24(sp)
 b36:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b38:	02051993          	slli	s3,a0,0x20
 b3c:	0209d993          	srli	s3,s3,0x20
 b40:	09bd                	addi	s3,s3,15
 b42:	0049d993          	srli	s3,s3,0x4
 b46:	2985                	addiw	s3,s3,1
 b48:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 b4a:	00000517          	auipc	a0,0x0
 b4e:	79e53503          	ld	a0,1950(a0) # 12e8 <freep>
 b52:	c905                	beqz	a0,b82 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b54:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b56:	4798                	lw	a4,8(a5)
 b58:	09377a63          	bgeu	a4,s3,bec <malloc+0xc0>
 b5c:	f426                	sd	s1,40(sp)
 b5e:	e852                	sd	s4,16(sp)
 b60:	e456                	sd	s5,8(sp)
 b62:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b64:	8a4e                	mv	s4,s3
 b66:	6705                	lui	a4,0x1
 b68:	00e9f363          	bgeu	s3,a4,b6e <malloc+0x42>
 b6c:	6a05                	lui	s4,0x1
 b6e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b72:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b76:	00000497          	auipc	s1,0x0
 b7a:	77248493          	addi	s1,s1,1906 # 12e8 <freep>
  if(p == (char*)-1)
 b7e:	5afd                	li	s5,-1
 b80:	a089                	j	bc2 <malloc+0x96>
 b82:	f426                	sd	s1,40(sp)
 b84:	e852                	sd	s4,16(sp)
 b86:	e456                	sd	s5,8(sp)
 b88:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b8a:	00009797          	auipc	a5,0x9
 b8e:	94678793          	addi	a5,a5,-1722 # 94d0 <base>
 b92:	00000717          	auipc	a4,0x0
 b96:	74f73b23          	sd	a5,1878(a4) # 12e8 <freep>
 b9a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b9c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ba0:	b7d1                	j	b64 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 ba2:	6398                	ld	a4,0(a5)
 ba4:	e118                	sd	a4,0(a0)
 ba6:	a8b9                	j	c04 <malloc+0xd8>
  hp->s.size = nu;
 ba8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bac:	0541                	addi	a0,a0,16
 bae:	00000097          	auipc	ra,0x0
 bb2:	ef8080e7          	jalr	-264(ra) # aa6 <free>
  return freep;
 bb6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 bb8:	c135                	beqz	a0,c1c <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bba:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bbc:	4798                	lw	a4,8(a5)
 bbe:	03277363          	bgeu	a4,s2,be4 <malloc+0xb8>
    if(p == freep)
 bc2:	6098                	ld	a4,0(s1)
 bc4:	853e                	mv	a0,a5
 bc6:	fef71ae3          	bne	a4,a5,bba <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 bca:	8552                	mv	a0,s4
 bcc:	00000097          	auipc	ra,0x0
 bd0:	bc6080e7          	jalr	-1082(ra) # 792 <sbrk>
  if(p == (char*)-1)
 bd4:	fd551ae3          	bne	a0,s5,ba8 <malloc+0x7c>
        return 0;
 bd8:	4501                	li	a0,0
 bda:	74a2                	ld	s1,40(sp)
 bdc:	6a42                	ld	s4,16(sp)
 bde:	6aa2                	ld	s5,8(sp)
 be0:	6b02                	ld	s6,0(sp)
 be2:	a03d                	j	c10 <malloc+0xe4>
 be4:	74a2                	ld	s1,40(sp)
 be6:	6a42                	ld	s4,16(sp)
 be8:	6aa2                	ld	s5,8(sp)
 bea:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 bec:	fae90be3          	beq	s2,a4,ba2 <malloc+0x76>
        p->s.size -= nunits;
 bf0:	4137073b          	subw	a4,a4,s3
 bf4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 bf6:	02071693          	slli	a3,a4,0x20
 bfa:	01c6d713          	srli	a4,a3,0x1c
 bfe:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c00:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c04:	00000717          	auipc	a4,0x0
 c08:	6ea73223          	sd	a0,1764(a4) # 12e8 <freep>
      return (void*)(p + 1);
 c0c:	01078513          	addi	a0,a5,16
  }
}
 c10:	70e2                	ld	ra,56(sp)
 c12:	7442                	ld	s0,48(sp)
 c14:	7902                	ld	s2,32(sp)
 c16:	69e2                	ld	s3,24(sp)
 c18:	6121                	addi	sp,sp,64
 c1a:	8082                	ret
 c1c:	74a2                	ld	s1,40(sp)
 c1e:	6a42                	ld	s4,16(sp)
 c20:	6aa2                	ld	s5,8(sp)
 c22:	6b02                	ld	s6,0(sp)
 c24:	b7f5                	j	c10 <malloc+0xe4>
