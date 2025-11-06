
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0000b117          	auipc	sp,0xb
    80000004:	0c013103          	ld	sp,192(sp) # 8000b0c0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	7d0050ef          	jal	800057e6 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	00024797          	auipc	a5,0x24
    8000002c:	21878793          	addi	a5,a5,536 # 80024240 <end>
    80000030:	00f53733          	sltu	a4,a0,a5
    80000034:	47c5                	li	a5,17
    80000036:	07ee                	slli	a5,a5,0x1b
    80000038:	17fd                	addi	a5,a5,-1
    8000003a:	00a7b7b3          	sltu	a5,a5,a0
    8000003e:	8fd9                	or	a5,a5,a4
    80000040:	e7a1                	bnez	a5,80000088 <kfree+0x6c>
    80000042:	84aa                	mv	s1,a0
    80000044:	03451793          	slli	a5,a0,0x34
    80000048:	e3a1                	bnez	a5,80000088 <kfree+0x6c>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    8000004a:	6605                	lui	a2,0x1
    8000004c:	4585                	li	a1,1
    8000004e:	00000097          	auipc	ra,0x0
    80000052:	13c080e7          	jalr	316(ra) # 8000018a <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000056:	0000c917          	auipc	s2,0xc
    8000005a:	fda90913          	addi	s2,s2,-38 # 8000c030 <kmem>
    8000005e:	854a                	mv	a0,s2
    80000060:	00006097          	auipc	ra,0x6
    80000064:	1de080e7          	jalr	478(ra) # 8000623e <acquire>
  r->next = kmem.freelist;
    80000068:	01893783          	ld	a5,24(s2)
    8000006c:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    8000006e:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000072:	854a                	mv	a0,s2
    80000074:	00006097          	auipc	ra,0x6
    80000078:	27a080e7          	jalr	634(ra) # 800062ee <release>
}
    8000007c:	60e2                	ld	ra,24(sp)
    8000007e:	6442                	ld	s0,16(sp)
    80000080:	64a2                	ld	s1,8(sp)
    80000082:	6902                	ld	s2,0(sp)
    80000084:	6105                	addi	sp,sp,32
    80000086:	8082                	ret
    panic("kfree");
    80000088:	00008517          	auipc	a0,0x8
    8000008c:	f7850513          	addi	a0,a0,-136 # 80008000 <etext>
    80000090:	00006097          	auipc	ra,0x6
    80000094:	c1e080e7          	jalr	-994(ra) # 80005cae <panic>

0000000080000098 <freerange>:
{
    80000098:	7179                	addi	sp,sp,-48
    8000009a:	f406                	sd	ra,40(sp)
    8000009c:	f022                	sd	s0,32(sp)
    8000009e:	ec26                	sd	s1,24(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	00e504b3          	add	s1,a0,a4
    800000ac:	777d                	lui	a4,0xfffff
    800000ae:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b0:	94be                	add	s1,s1,a5
    800000b2:	0295e463          	bltu	a1,s1,800000da <freerange+0x42>
    800000b6:	e84a                	sd	s2,16(sp)
    800000b8:	e44e                	sd	s3,8(sp)
    800000ba:	e052                	sd	s4,0(sp)
    800000bc:	892e                	mv	s2,a1
    kfree(p);
    800000be:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c0:	89be                	mv	s3,a5
    kfree(p);
    800000c2:	01448533          	add	a0,s1,s4
    800000c6:	00000097          	auipc	ra,0x0
    800000ca:	f56080e7          	jalr	-170(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ce:	94ce                	add	s1,s1,s3
    800000d0:	fe9979e3          	bgeu	s2,s1,800000c2 <freerange+0x2a>
    800000d4:	6942                	ld	s2,16(sp)
    800000d6:	69a2                	ld	s3,8(sp)
    800000d8:	6a02                	ld	s4,0(sp)
}
    800000da:	70a2                	ld	ra,40(sp)
    800000dc:	7402                	ld	s0,32(sp)
    800000de:	64e2                	ld	s1,24(sp)
    800000e0:	6145                	addi	sp,sp,48
    800000e2:	8082                	ret

00000000800000e4 <kinit>:
{
    800000e4:	1141                	addi	sp,sp,-16
    800000e6:	e406                	sd	ra,8(sp)
    800000e8:	e022                	sd	s0,0(sp)
    800000ea:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000ec:	00008597          	auipc	a1,0x8
    800000f0:	f2458593          	addi	a1,a1,-220 # 80008010 <etext+0x10>
    800000f4:	0000c517          	auipc	a0,0xc
    800000f8:	f3c50513          	addi	a0,a0,-196 # 8000c030 <kmem>
    800000fc:	00006097          	auipc	ra,0x6
    80000100:	0a8080e7          	jalr	168(ra) # 800061a4 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000104:	45c5                	li	a1,17
    80000106:	05ee                	slli	a1,a1,0x1b
    80000108:	00024517          	auipc	a0,0x24
    8000010c:	13850513          	addi	a0,a0,312 # 80024240 <end>
    80000110:	00000097          	auipc	ra,0x0
    80000114:	f88080e7          	jalr	-120(ra) # 80000098 <freerange>
}
    80000118:	60a2                	ld	ra,8(sp)
    8000011a:	6402                	ld	s0,0(sp)
    8000011c:	0141                	addi	sp,sp,16
    8000011e:	8082                	ret

0000000080000120 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000120:	1101                	addi	sp,sp,-32
    80000122:	ec06                	sd	ra,24(sp)
    80000124:	e822                	sd	s0,16(sp)
    80000126:	e426                	sd	s1,8(sp)
    80000128:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    8000012a:	0000c517          	auipc	a0,0xc
    8000012e:	f0650513          	addi	a0,a0,-250 # 8000c030 <kmem>
    80000132:	00006097          	auipc	ra,0x6
    80000136:	10c080e7          	jalr	268(ra) # 8000623e <acquire>
  r = kmem.freelist;
    8000013a:	0000c497          	auipc	s1,0xc
    8000013e:	f0e4b483          	ld	s1,-242(s1) # 8000c048 <kmem+0x18>
  if(r)
    80000142:	c89d                	beqz	s1,80000178 <kalloc+0x58>
    kmem.freelist = r->next;
    80000144:	609c                	ld	a5,0(s1)
    80000146:	0000c717          	auipc	a4,0xc
    8000014a:	f0f73123          	sd	a5,-254(a4) # 8000c048 <kmem+0x18>
  release(&kmem.lock);
    8000014e:	0000c517          	auipc	a0,0xc
    80000152:	ee250513          	addi	a0,a0,-286 # 8000c030 <kmem>
    80000156:	00006097          	auipc	ra,0x6
    8000015a:	198080e7          	jalr	408(ra) # 800062ee <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000015e:	6605                	lui	a2,0x1
    80000160:	4595                	li	a1,5
    80000162:	8526                	mv	a0,s1
    80000164:	00000097          	auipc	ra,0x0
    80000168:	026080e7          	jalr	38(ra) # 8000018a <memset>
  return (void*)r;
}
    8000016c:	8526                	mv	a0,s1
    8000016e:	60e2                	ld	ra,24(sp)
    80000170:	6442                	ld	s0,16(sp)
    80000172:	64a2                	ld	s1,8(sp)
    80000174:	6105                	addi	sp,sp,32
    80000176:	8082                	ret
  release(&kmem.lock);
    80000178:	0000c517          	auipc	a0,0xc
    8000017c:	eb850513          	addi	a0,a0,-328 # 8000c030 <kmem>
    80000180:	00006097          	auipc	ra,0x6
    80000184:	16e080e7          	jalr	366(ra) # 800062ee <release>
  if(r)
    80000188:	b7d5                	j	8000016c <kalloc+0x4c>

000000008000018a <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000018a:	1141                	addi	sp,sp,-16
    8000018c:	e406                	sd	ra,8(sp)
    8000018e:	e022                	sd	s0,0(sp)
    80000190:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000192:	ca19                	beqz	a2,800001a8 <memset+0x1e>
    80000194:	87aa                	mv	a5,a0
    80000196:	1602                	slli	a2,a2,0x20
    80000198:	9201                	srli	a2,a2,0x20
    8000019a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000019e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    800001a2:	0785                	addi	a5,a5,1
    800001a4:	fee79de3          	bne	a5,a4,8000019e <memset+0x14>
  }
  return dst;
}
    800001a8:	60a2                	ld	ra,8(sp)
    800001aa:	6402                	ld	s0,0(sp)
    800001ac:	0141                	addi	sp,sp,16
    800001ae:	8082                	ret

00000000800001b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    800001b0:	1141                	addi	sp,sp,-16
    800001b2:	e406                	sd	ra,8(sp)
    800001b4:	e022                	sd	s0,0(sp)
    800001b6:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001b8:	c61d                	beqz	a2,800001e6 <memcmp+0x36>
    800001ba:	1602                	slli	a2,a2,0x20
    800001bc:	9201                	srli	a2,a2,0x20
    800001be:	00c506b3          	add	a3,a0,a2
    if(*s1 != *s2)
    800001c2:	00054783          	lbu	a5,0(a0)
    800001c6:	0005c703          	lbu	a4,0(a1)
    800001ca:	00e79863          	bne	a5,a4,800001da <memcmp+0x2a>
      return *s1 - *s2;
    s1++, s2++;
    800001ce:	0505                	addi	a0,a0,1
    800001d0:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001d2:	fed518e3          	bne	a0,a3,800001c2 <memcmp+0x12>
  }

  return 0;
    800001d6:	4501                	li	a0,0
    800001d8:	a019                	j	800001de <memcmp+0x2e>
      return *s1 - *s2;
    800001da:	40e7853b          	subw	a0,a5,a4
}
    800001de:	60a2                	ld	ra,8(sp)
    800001e0:	6402                	ld	s0,0(sp)
    800001e2:	0141                	addi	sp,sp,16
    800001e4:	8082                	ret
  return 0;
    800001e6:	4501                	li	a0,0
    800001e8:	bfdd                	j	800001de <memcmp+0x2e>

00000000800001ea <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001ea:	1141                	addi	sp,sp,-16
    800001ec:	e406                	sd	ra,8(sp)
    800001ee:	e022                	sd	s0,0(sp)
    800001f0:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001f2:	c205                	beqz	a2,80000212 <memmove+0x28>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001f4:	02a5e363          	bltu	a1,a0,8000021a <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001f8:	1602                	slli	a2,a2,0x20
    800001fa:	9201                	srli	a2,a2,0x20
    800001fc:	00c587b3          	add	a5,a1,a2
{
    80000200:	872a                	mv	a4,a0
      *d++ = *s++;
    80000202:	0585                	addi	a1,a1,1
    80000204:	0705                	addi	a4,a4,1
    80000206:	fff5c683          	lbu	a3,-1(a1)
    8000020a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8000020e:	feb79ae3          	bne	a5,a1,80000202 <memmove+0x18>

  return dst;
}
    80000212:	60a2                	ld	ra,8(sp)
    80000214:	6402                	ld	s0,0(sp)
    80000216:	0141                	addi	sp,sp,16
    80000218:	8082                	ret
  if(s < d && s + n > d){
    8000021a:	02061693          	slli	a3,a2,0x20
    8000021e:	9281                	srli	a3,a3,0x20
    80000220:	00d58733          	add	a4,a1,a3
    80000224:	fce57ae3          	bgeu	a0,a4,800001f8 <memmove+0xe>
    d += n;
    80000228:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    8000022a:	fff6079b          	addiw	a5,a2,-1 # fff <_entry-0x7ffff001>
    8000022e:	1782                	slli	a5,a5,0x20
    80000230:	9381                	srli	a5,a5,0x20
    80000232:	fff7c793          	not	a5,a5
    80000236:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000238:	177d                	addi	a4,a4,-1
    8000023a:	16fd                	addi	a3,a3,-1
    8000023c:	00074603          	lbu	a2,0(a4)
    80000240:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000244:	fee79ae3          	bne	a5,a4,80000238 <memmove+0x4e>
    80000248:	b7e9                	j	80000212 <memmove+0x28>

000000008000024a <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    8000024a:	1141                	addi	sp,sp,-16
    8000024c:	e406                	sd	ra,8(sp)
    8000024e:	e022                	sd	s0,0(sp)
    80000250:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000252:	00000097          	auipc	ra,0x0
    80000256:	f98080e7          	jalr	-104(ra) # 800001ea <memmove>
}
    8000025a:	60a2                	ld	ra,8(sp)
    8000025c:	6402                	ld	s0,0(sp)
    8000025e:	0141                	addi	sp,sp,16
    80000260:	8082                	ret

0000000080000262 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000262:	1141                	addi	sp,sp,-16
    80000264:	e406                	sd	ra,8(sp)
    80000266:	e022                	sd	s0,0(sp)
    80000268:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8000026a:	ce11                	beqz	a2,80000286 <strncmp+0x24>
    8000026c:	00054783          	lbu	a5,0(a0)
    80000270:	cf89                	beqz	a5,8000028a <strncmp+0x28>
    80000272:	0005c703          	lbu	a4,0(a1)
    80000276:	00f71a63          	bne	a4,a5,8000028a <strncmp+0x28>
    n--, p++, q++;
    8000027a:	367d                	addiw	a2,a2,-1
    8000027c:	0505                	addi	a0,a0,1
    8000027e:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000280:	f675                	bnez	a2,8000026c <strncmp+0xa>
  if(n == 0)
    return 0;
    80000282:	4501                	li	a0,0
    80000284:	a801                	j	80000294 <strncmp+0x32>
    80000286:	4501                	li	a0,0
    80000288:	a031                	j	80000294 <strncmp+0x32>
  return (uchar)*p - (uchar)*q;
    8000028a:	00054503          	lbu	a0,0(a0)
    8000028e:	0005c783          	lbu	a5,0(a1)
    80000292:	9d1d                	subw	a0,a0,a5
}
    80000294:	60a2                	ld	ra,8(sp)
    80000296:	6402                	ld	s0,0(sp)
    80000298:	0141                	addi	sp,sp,16
    8000029a:	8082                	ret

000000008000029c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000029c:	1141                	addi	sp,sp,-16
    8000029e:	e406                	sd	ra,8(sp)
    800002a0:	e022                	sd	s0,0(sp)
    800002a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    800002a4:	87aa                	mv	a5,a0
    800002a6:	a011                	j	800002aa <strncpy+0xe>
    800002a8:	8636                	mv	a2,a3
    800002aa:	02c05863          	blez	a2,800002da <strncpy+0x3e>
    800002ae:	fff6069b          	addiw	a3,a2,-1
    800002b2:	8836                	mv	a6,a3
    800002b4:	0785                	addi	a5,a5,1
    800002b6:	0005c703          	lbu	a4,0(a1)
    800002ba:	fee78fa3          	sb	a4,-1(a5)
    800002be:	0585                	addi	a1,a1,1
    800002c0:	f765                	bnez	a4,800002a8 <strncpy+0xc>
    ;
  while(n-- > 0)
    800002c2:	873e                	mv	a4,a5
    800002c4:	01005b63          	blez	a6,800002da <strncpy+0x3e>
    800002c8:	9fb1                	addw	a5,a5,a2
    800002ca:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    800002cc:	0705                	addi	a4,a4,1
    800002ce:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    800002d2:	40e786bb          	subw	a3,a5,a4
    800002d6:	fed04be3          	bgtz	a3,800002cc <strncpy+0x30>
  return os;
}
    800002da:	60a2                	ld	ra,8(sp)
    800002dc:	6402                	ld	s0,0(sp)
    800002de:	0141                	addi	sp,sp,16
    800002e0:	8082                	ret

00000000800002e2 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002e2:	1141                	addi	sp,sp,-16
    800002e4:	e406                	sd	ra,8(sp)
    800002e6:	e022                	sd	s0,0(sp)
    800002e8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002ea:	02c05363          	blez	a2,80000310 <safestrcpy+0x2e>
    800002ee:	fff6069b          	addiw	a3,a2,-1
    800002f2:	1682                	slli	a3,a3,0x20
    800002f4:	9281                	srli	a3,a3,0x20
    800002f6:	96ae                	add	a3,a3,a1
    800002f8:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002fa:	00d58963          	beq	a1,a3,8000030c <safestrcpy+0x2a>
    800002fe:	0585                	addi	a1,a1,1
    80000300:	0785                	addi	a5,a5,1
    80000302:	fff5c703          	lbu	a4,-1(a1)
    80000306:	fee78fa3          	sb	a4,-1(a5)
    8000030a:	fb65                	bnez	a4,800002fa <safestrcpy+0x18>
    ;
  *s = 0;
    8000030c:	00078023          	sb	zero,0(a5)
  return os;
}
    80000310:	60a2                	ld	ra,8(sp)
    80000312:	6402                	ld	s0,0(sp)
    80000314:	0141                	addi	sp,sp,16
    80000316:	8082                	ret

0000000080000318 <strlen>:

int
strlen(const char *s)
{
    80000318:	1141                	addi	sp,sp,-16
    8000031a:	e406                	sd	ra,8(sp)
    8000031c:	e022                	sd	s0,0(sp)
    8000031e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000320:	00054783          	lbu	a5,0(a0)
    80000324:	cf91                	beqz	a5,80000340 <strlen+0x28>
    80000326:	00150793          	addi	a5,a0,1
    8000032a:	86be                	mv	a3,a5
    8000032c:	0785                	addi	a5,a5,1
    8000032e:	fff7c703          	lbu	a4,-1(a5)
    80000332:	ff65                	bnez	a4,8000032a <strlen+0x12>
    80000334:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    80000338:	60a2                	ld	ra,8(sp)
    8000033a:	6402                	ld	s0,0(sp)
    8000033c:	0141                	addi	sp,sp,16
    8000033e:	8082                	ret
  for(n = 0; s[n]; n++)
    80000340:	4501                	li	a0,0
    80000342:	bfdd                	j	80000338 <strlen+0x20>

0000000080000344 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000344:	1141                	addi	sp,sp,-16
    80000346:	e406                	sd	ra,8(sp)
    80000348:	e022                	sd	s0,0(sp)
    8000034a:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000034c:	00001097          	auipc	ra,0x1
    80000350:	b44080e7          	jalr	-1212(ra) # 80000e90 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000354:	0000c717          	auipc	a4,0xc
    80000358:	cac70713          	addi	a4,a4,-852 # 8000c000 <started>
  if(cpuid() == 0){
    8000035c:	c139                	beqz	a0,800003a2 <main+0x5e>
    while(started == 0)
    8000035e:	431c                	lw	a5,0(a4)
    80000360:	2781                	sext.w	a5,a5
    80000362:	dff5                	beqz	a5,8000035e <main+0x1a>
      ;
    __sync_synchronize();
    80000364:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000368:	00001097          	auipc	ra,0x1
    8000036c:	b28080e7          	jalr	-1240(ra) # 80000e90 <cpuid>
    80000370:	85aa                	mv	a1,a0
    80000372:	00008517          	auipc	a0,0x8
    80000376:	cc650513          	addi	a0,a0,-826 # 80008038 <etext+0x38>
    8000037a:	00006097          	auipc	ra,0x6
    8000037e:	97e080e7          	jalr	-1666(ra) # 80005cf8 <printf>
    kvminithart();    // turn on paging
    80000382:	00000097          	auipc	ra,0x0
    80000386:	0d8080e7          	jalr	216(ra) # 8000045a <kvminithart>
    trapinithart();   // install kernel trap vector
    8000038a:	00001097          	auipc	ra,0x1
    8000038e:	78e080e7          	jalr	1934(ra) # 80001b18 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000392:	00005097          	auipc	ra,0x5
    80000396:	e22080e7          	jalr	-478(ra) # 800051b4 <plicinithart>
  }

  scheduler();        
    8000039a:	00001097          	auipc	ra,0x1
    8000039e:	040080e7          	jalr	64(ra) # 800013da <scheduler>
    consoleinit();
    800003a2:	00006097          	auipc	ra,0x6
    800003a6:	822080e7          	jalr	-2014(ra) # 80005bc4 <consoleinit>
    printfinit();
    800003aa:	00006097          	auipc	ra,0x6
    800003ae:	b58080e7          	jalr	-1192(ra) # 80005f02 <printfinit>
    printf("\n");
    800003b2:	00008517          	auipc	a0,0x8
    800003b6:	c6650513          	addi	a0,a0,-922 # 80008018 <etext+0x18>
    800003ba:	00006097          	auipc	ra,0x6
    800003be:	93e080e7          	jalr	-1730(ra) # 80005cf8 <printf>
    printf("xv6 kernel is booting\n");
    800003c2:	00008517          	auipc	a0,0x8
    800003c6:	c5e50513          	addi	a0,a0,-930 # 80008020 <etext+0x20>
    800003ca:	00006097          	auipc	ra,0x6
    800003ce:	92e080e7          	jalr	-1746(ra) # 80005cf8 <printf>
    printf("\n");
    800003d2:	00008517          	auipc	a0,0x8
    800003d6:	c4650513          	addi	a0,a0,-954 # 80008018 <etext+0x18>
    800003da:	00006097          	auipc	ra,0x6
    800003de:	91e080e7          	jalr	-1762(ra) # 80005cf8 <printf>
    kinit();         // physical page allocator
    800003e2:	00000097          	auipc	ra,0x0
    800003e6:	d02080e7          	jalr	-766(ra) # 800000e4 <kinit>
    kvminit();       // create kernel page table
    800003ea:	00000097          	auipc	ra,0x0
    800003ee:	320080e7          	jalr	800(ra) # 8000070a <kvminit>
    kvminithart();   // turn on paging
    800003f2:	00000097          	auipc	ra,0x0
    800003f6:	068080e7          	jalr	104(ra) # 8000045a <kvminithart>
    procinit();      // process table
    800003fa:	00001097          	auipc	ra,0x1
    800003fe:	9d8080e7          	jalr	-1576(ra) # 80000dd2 <procinit>
    trapinit();      // trap vectors
    80000402:	00001097          	auipc	ra,0x1
    80000406:	6ee080e7          	jalr	1774(ra) # 80001af0 <trapinit>
    trapinithart();  // install kernel trap vector
    8000040a:	00001097          	auipc	ra,0x1
    8000040e:	70e080e7          	jalr	1806(ra) # 80001b18 <trapinithart>
    plicinit();      // set up interrupt controller
    80000412:	00005097          	auipc	ra,0x5
    80000416:	d88080e7          	jalr	-632(ra) # 8000519a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000041a:	00005097          	auipc	ra,0x5
    8000041e:	d9a080e7          	jalr	-614(ra) # 800051b4 <plicinithart>
    binit();         // buffer cache
    80000422:	00002097          	auipc	ra,0x2
    80000426:	e56080e7          	jalr	-426(ra) # 80002278 <binit>
    iinit();         // inode table
    8000042a:	00002097          	auipc	ra,0x2
    8000042e:	4b4080e7          	jalr	1204(ra) # 800028de <iinit>
    fileinit();      // file table
    80000432:	00003097          	auipc	ra,0x3
    80000436:	496080e7          	jalr	1174(ra) # 800038c8 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000043a:	00005097          	auipc	ra,0x5
    8000043e:	e9a080e7          	jalr	-358(ra) # 800052d4 <virtio_disk_init>
    userinit();      // first user process
    80000442:	00001097          	auipc	ra,0x1
    80000446:	d5c080e7          	jalr	-676(ra) # 8000119e <userinit>
    __sync_synchronize();
    8000044a:	0330000f          	fence	rw,rw
    started = 1;
    8000044e:	4785                	li	a5,1
    80000450:	0000c717          	auipc	a4,0xc
    80000454:	baf72823          	sw	a5,-1104(a4) # 8000c000 <started>
    80000458:	b789                	j	8000039a <main+0x56>

000000008000045a <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000045a:	1141                	addi	sp,sp,-16
    8000045c:	e406                	sd	ra,8(sp)
    8000045e:	e022                	sd	s0,0(sp)
    80000460:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000462:	0000c797          	auipc	a5,0xc
    80000466:	ba67b783          	ld	a5,-1114(a5) # 8000c008 <kernel_pagetable>
    8000046a:	83b1                	srli	a5,a5,0xc
    8000046c:	577d                	li	a4,-1
    8000046e:	177e                	slli	a4,a4,0x3f
    80000470:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    80000472:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000476:	12000073          	sfence.vma
  sfence_vma();
}
    8000047a:	60a2                	ld	ra,8(sp)
    8000047c:	6402                	ld	s0,0(sp)
    8000047e:	0141                	addi	sp,sp,16
    80000480:	8082                	ret

0000000080000482 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000482:	7139                	addi	sp,sp,-64
    80000484:	fc06                	sd	ra,56(sp)
    80000486:	f822                	sd	s0,48(sp)
    80000488:	f426                	sd	s1,40(sp)
    8000048a:	f04a                	sd	s2,32(sp)
    8000048c:	ec4e                	sd	s3,24(sp)
    8000048e:	e852                	sd	s4,16(sp)
    80000490:	e456                	sd	s5,8(sp)
    80000492:	e05a                	sd	s6,0(sp)
    80000494:	0080                	addi	s0,sp,64
    80000496:	84aa                	mv	s1,a0
    80000498:	89ae                	mv	s3,a1
    8000049a:	8b32                	mv	s6,a2
  if(va >= MAXVA)
    8000049c:	57fd                	li	a5,-1
    8000049e:	83e9                	srli	a5,a5,0x1a
    800004a0:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    800004a2:	4ab1                	li	s5,12
  if(va >= MAXVA)
    800004a4:	04b7e263          	bltu	a5,a1,800004e8 <walk+0x66>
    pte_t *pte = &pagetable[PX(level, va)];
    800004a8:	0149d933          	srl	s2,s3,s4
    800004ac:	1ff97913          	andi	s2,s2,511
    800004b0:	090e                	slli	s2,s2,0x3
    800004b2:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004b4:	00093483          	ld	s1,0(s2)
    800004b8:	0014f793          	andi	a5,s1,1
    800004bc:	cf95                	beqz	a5,800004f8 <walk+0x76>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004be:	80a9                	srli	s1,s1,0xa
    800004c0:	04b2                	slli	s1,s1,0xc
  for(int level = 2; level > 0; level--) {
    800004c2:	3a5d                	addiw	s4,s4,-9
    800004c4:	ff5a12e3          	bne	s4,s5,800004a8 <walk+0x26>
        return 0;
      memset(pagetable, 0, PGSIZE);
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
    800004c8:	00c9d513          	srli	a0,s3,0xc
    800004cc:	1ff57513          	andi	a0,a0,511
    800004d0:	050e                	slli	a0,a0,0x3
    800004d2:	9526                	add	a0,a0,s1
}
    800004d4:	70e2                	ld	ra,56(sp)
    800004d6:	7442                	ld	s0,48(sp)
    800004d8:	74a2                	ld	s1,40(sp)
    800004da:	7902                	ld	s2,32(sp)
    800004dc:	69e2                	ld	s3,24(sp)
    800004de:	6a42                	ld	s4,16(sp)
    800004e0:	6aa2                	ld	s5,8(sp)
    800004e2:	6b02                	ld	s6,0(sp)
    800004e4:	6121                	addi	sp,sp,64
    800004e6:	8082                	ret
    panic("walk");
    800004e8:	00008517          	auipc	a0,0x8
    800004ec:	b6850513          	addi	a0,a0,-1176 # 80008050 <etext+0x50>
    800004f0:	00005097          	auipc	ra,0x5
    800004f4:	7be080e7          	jalr	1982(ra) # 80005cae <panic>
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    800004f8:	020b0663          	beqz	s6,80000524 <walk+0xa2>
    800004fc:	00000097          	auipc	ra,0x0
    80000500:	c24080e7          	jalr	-988(ra) # 80000120 <kalloc>
    80000504:	84aa                	mv	s1,a0
    80000506:	d579                	beqz	a0,800004d4 <walk+0x52>
      memset(pagetable, 0, PGSIZE);
    80000508:	6605                	lui	a2,0x1
    8000050a:	4581                	li	a1,0
    8000050c:	00000097          	auipc	ra,0x0
    80000510:	c7e080e7          	jalr	-898(ra) # 8000018a <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000514:	00c4d793          	srli	a5,s1,0xc
    80000518:	07aa                	slli	a5,a5,0xa
    8000051a:	0017e793          	ori	a5,a5,1
    8000051e:	00f93023          	sd	a5,0(s2)
    80000522:	b745                	j	800004c2 <walk+0x40>
        return 0;
    80000524:	4501                	li	a0,0
    80000526:	b77d                	j	800004d4 <walk+0x52>

0000000080000528 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000528:	57fd                	li	a5,-1
    8000052a:	83e9                	srli	a5,a5,0x1a
    8000052c:	00b7f463          	bgeu	a5,a1,80000534 <walkaddr+0xc>
    return 0;
    80000530:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000532:	8082                	ret
{
    80000534:	1141                	addi	sp,sp,-16
    80000536:	e406                	sd	ra,8(sp)
    80000538:	e022                	sd	s0,0(sp)
    8000053a:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000053c:	4601                	li	a2,0
    8000053e:	00000097          	auipc	ra,0x0
    80000542:	f44080e7          	jalr	-188(ra) # 80000482 <walk>
  if(pte == 0)
    80000546:	c901                	beqz	a0,80000556 <walkaddr+0x2e>
  if((*pte & PTE_V) == 0)
    80000548:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000054a:	0117f693          	andi	a3,a5,17
    8000054e:	4745                	li	a4,17
    return 0;
    80000550:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000552:	00e68663          	beq	a3,a4,8000055e <walkaddr+0x36>
}
    80000556:	60a2                	ld	ra,8(sp)
    80000558:	6402                	ld	s0,0(sp)
    8000055a:	0141                	addi	sp,sp,16
    8000055c:	8082                	ret
  pa = PTE2PA(*pte);
    8000055e:	83a9                	srli	a5,a5,0xa
    80000560:	00c79513          	slli	a0,a5,0xc
  return pa;
    80000564:	bfcd                	j	80000556 <walkaddr+0x2e>

0000000080000566 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000566:	715d                	addi	sp,sp,-80
    80000568:	e486                	sd	ra,72(sp)
    8000056a:	e0a2                	sd	s0,64(sp)
    8000056c:	fc26                	sd	s1,56(sp)
    8000056e:	f84a                	sd	s2,48(sp)
    80000570:	f44e                	sd	s3,40(sp)
    80000572:	f052                	sd	s4,32(sp)
    80000574:	ec56                	sd	s5,24(sp)
    80000576:	e85a                	sd	s6,16(sp)
    80000578:	e45e                	sd	s7,8(sp)
    8000057a:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    8000057c:	ca21                	beqz	a2,800005cc <mappages+0x66>
    8000057e:	8a2a                	mv	s4,a0
    80000580:	8aba                	mv	s5,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    80000582:	777d                	lui	a4,0xfffff
    80000584:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    80000588:	fff58913          	addi	s2,a1,-1
    8000058c:	9932                	add	s2,s2,a2
    8000058e:	00e97933          	and	s2,s2,a4
  a = PGROUNDDOWN(va);
    80000592:	84be                	mv	s1,a5
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    80000594:	4b05                	li	s6,1
    80000596:	40f689b3          	sub	s3,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    8000059a:	6b85                	lui	s7,0x1
    if((pte = walk(pagetable, a, 1)) == 0)
    8000059c:	865a                	mv	a2,s6
    8000059e:	85a6                	mv	a1,s1
    800005a0:	8552                	mv	a0,s4
    800005a2:	00000097          	auipc	ra,0x0
    800005a6:	ee0080e7          	jalr	-288(ra) # 80000482 <walk>
    800005aa:	c129                	beqz	a0,800005ec <mappages+0x86>
    if(*pte & PTE_V)
    800005ac:	611c                	ld	a5,0(a0)
    800005ae:	8b85                	andi	a5,a5,1
    800005b0:	e795                	bnez	a5,800005dc <mappages+0x76>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005b2:	013487b3          	add	a5,s1,s3
    800005b6:	83b1                	srli	a5,a5,0xc
    800005b8:	07aa                	slli	a5,a5,0xa
    800005ba:	0157e7b3          	or	a5,a5,s5
    800005be:	0017e793          	ori	a5,a5,1
    800005c2:	e11c                	sd	a5,0(a0)
    if(a == last)
    800005c4:	05248063          	beq	s1,s2,80000604 <mappages+0x9e>
    a += PGSIZE;
    800005c8:	94de                	add	s1,s1,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800005ca:	bfc9                	j	8000059c <mappages+0x36>
    panic("mappages: size");
    800005cc:	00008517          	auipc	a0,0x8
    800005d0:	a8c50513          	addi	a0,a0,-1396 # 80008058 <etext+0x58>
    800005d4:	00005097          	auipc	ra,0x5
    800005d8:	6da080e7          	jalr	1754(ra) # 80005cae <panic>
      panic("mappages: remap");
    800005dc:	00008517          	auipc	a0,0x8
    800005e0:	a8c50513          	addi	a0,a0,-1396 # 80008068 <etext+0x68>
    800005e4:	00005097          	auipc	ra,0x5
    800005e8:	6ca080e7          	jalr	1738(ra) # 80005cae <panic>
      return -1;
    800005ec:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800005ee:	60a6                	ld	ra,72(sp)
    800005f0:	6406                	ld	s0,64(sp)
    800005f2:	74e2                	ld	s1,56(sp)
    800005f4:	7942                	ld	s2,48(sp)
    800005f6:	79a2                	ld	s3,40(sp)
    800005f8:	7a02                	ld	s4,32(sp)
    800005fa:	6ae2                	ld	s5,24(sp)
    800005fc:	6b42                	ld	s6,16(sp)
    800005fe:	6ba2                	ld	s7,8(sp)
    80000600:	6161                	addi	sp,sp,80
    80000602:	8082                	ret
  return 0;
    80000604:	4501                	li	a0,0
    80000606:	b7e5                	j	800005ee <mappages+0x88>

0000000080000608 <kvmmap>:
{
    80000608:	1141                	addi	sp,sp,-16
    8000060a:	e406                	sd	ra,8(sp)
    8000060c:	e022                	sd	s0,0(sp)
    8000060e:	0800                	addi	s0,sp,16
    80000610:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80000612:	86b2                	mv	a3,a2
    80000614:	863e                	mv	a2,a5
    80000616:	00000097          	auipc	ra,0x0
    8000061a:	f50080e7          	jalr	-176(ra) # 80000566 <mappages>
    8000061e:	e509                	bnez	a0,80000628 <kvmmap+0x20>
}
    80000620:	60a2                	ld	ra,8(sp)
    80000622:	6402                	ld	s0,0(sp)
    80000624:	0141                	addi	sp,sp,16
    80000626:	8082                	ret
    panic("kvmmap");
    80000628:	00008517          	auipc	a0,0x8
    8000062c:	a5050513          	addi	a0,a0,-1456 # 80008078 <etext+0x78>
    80000630:	00005097          	auipc	ra,0x5
    80000634:	67e080e7          	jalr	1662(ra) # 80005cae <panic>

0000000080000638 <kvmmake>:
{
    80000638:	1101                	addi	sp,sp,-32
    8000063a:	ec06                	sd	ra,24(sp)
    8000063c:	e822                	sd	s0,16(sp)
    8000063e:	e426                	sd	s1,8(sp)
    80000640:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000642:	00000097          	auipc	ra,0x0
    80000646:	ade080e7          	jalr	-1314(ra) # 80000120 <kalloc>
    8000064a:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000064c:	6605                	lui	a2,0x1
    8000064e:	4581                	li	a1,0
    80000650:	00000097          	auipc	ra,0x0
    80000654:	b3a080e7          	jalr	-1222(ra) # 8000018a <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000658:	4719                	li	a4,6
    8000065a:	6685                	lui	a3,0x1
    8000065c:	10000637          	lui	a2,0x10000
    80000660:	85b2                	mv	a1,a2
    80000662:	8526                	mv	a0,s1
    80000664:	00000097          	auipc	ra,0x0
    80000668:	fa4080e7          	jalr	-92(ra) # 80000608 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000066c:	4719                	li	a4,6
    8000066e:	6685                	lui	a3,0x1
    80000670:	10001637          	lui	a2,0x10001
    80000674:	85b2                	mv	a1,a2
    80000676:	8526                	mv	a0,s1
    80000678:	00000097          	auipc	ra,0x0
    8000067c:	f90080e7          	jalr	-112(ra) # 80000608 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000680:	4719                	li	a4,6
    80000682:	004006b7          	lui	a3,0x400
    80000686:	0c000637          	lui	a2,0xc000
    8000068a:	85b2                	mv	a1,a2
    8000068c:	8526                	mv	a0,s1
    8000068e:	00000097          	auipc	ra,0x0
    80000692:	f7a080e7          	jalr	-134(ra) # 80000608 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000696:	4729                	li	a4,10
    80000698:	80008697          	auipc	a3,0x80008
    8000069c:	96868693          	addi	a3,a3,-1688 # 8000 <_entry-0x7fff8000>
    800006a0:	4605                	li	a2,1
    800006a2:	067e                	slli	a2,a2,0x1f
    800006a4:	85b2                	mv	a1,a2
    800006a6:	8526                	mv	a0,s1
    800006a8:	00000097          	auipc	ra,0x0
    800006ac:	f60080e7          	jalr	-160(ra) # 80000608 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006b0:	4719                	li	a4,6
    800006b2:	00008697          	auipc	a3,0x8
    800006b6:	94e68693          	addi	a3,a3,-1714 # 80008000 <etext>
    800006ba:	47c5                	li	a5,17
    800006bc:	07ee                	slli	a5,a5,0x1b
    800006be:	40d786b3          	sub	a3,a5,a3
    800006c2:	00008617          	auipc	a2,0x8
    800006c6:	93e60613          	addi	a2,a2,-1730 # 80008000 <etext>
    800006ca:	85b2                	mv	a1,a2
    800006cc:	8526                	mv	a0,s1
    800006ce:	00000097          	auipc	ra,0x0
    800006d2:	f3a080e7          	jalr	-198(ra) # 80000608 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006d6:	4729                	li	a4,10
    800006d8:	6685                	lui	a3,0x1
    800006da:	00007617          	auipc	a2,0x7
    800006de:	92660613          	addi	a2,a2,-1754 # 80007000 <_trampoline>
    800006e2:	040005b7          	lui	a1,0x4000
    800006e6:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800006e8:	05b2                	slli	a1,a1,0xc
    800006ea:	8526                	mv	a0,s1
    800006ec:	00000097          	auipc	ra,0x0
    800006f0:	f1c080e7          	jalr	-228(ra) # 80000608 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006f4:	8526                	mv	a0,s1
    800006f6:	00000097          	auipc	ra,0x0
    800006fa:	62c080e7          	jalr	1580(ra) # 80000d22 <proc_mapstacks>
}
    800006fe:	8526                	mv	a0,s1
    80000700:	60e2                	ld	ra,24(sp)
    80000702:	6442                	ld	s0,16(sp)
    80000704:	64a2                	ld	s1,8(sp)
    80000706:	6105                	addi	sp,sp,32
    80000708:	8082                	ret

000000008000070a <kvminit>:
{
    8000070a:	1141                	addi	sp,sp,-16
    8000070c:	e406                	sd	ra,8(sp)
    8000070e:	e022                	sd	s0,0(sp)
    80000710:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80000712:	00000097          	auipc	ra,0x0
    80000716:	f26080e7          	jalr	-218(ra) # 80000638 <kvmmake>
    8000071a:	0000c797          	auipc	a5,0xc
    8000071e:	8ea7b723          	sd	a0,-1810(a5) # 8000c008 <kernel_pagetable>
}
    80000722:	60a2                	ld	ra,8(sp)
    80000724:	6402                	ld	s0,0(sp)
    80000726:	0141                	addi	sp,sp,16
    80000728:	8082                	ret

000000008000072a <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000072a:	715d                	addi	sp,sp,-80
    8000072c:	e486                	sd	ra,72(sp)
    8000072e:	e0a2                	sd	s0,64(sp)
    80000730:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000732:	03459793          	slli	a5,a1,0x34
    80000736:	e39d                	bnez	a5,8000075c <uvmunmap+0x32>
    80000738:	f84a                	sd	s2,48(sp)
    8000073a:	f44e                	sd	s3,40(sp)
    8000073c:	f052                	sd	s4,32(sp)
    8000073e:	ec56                	sd	s5,24(sp)
    80000740:	e85a                	sd	s6,16(sp)
    80000742:	e45e                	sd	s7,8(sp)
    80000744:	8a2a                	mv	s4,a0
    80000746:	892e                	mv	s2,a1
    80000748:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000074a:	0632                	slli	a2,a2,0xc
    8000074c:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000750:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000752:	6b05                	lui	s6,0x1
    80000754:	0935fb63          	bgeu	a1,s3,800007ea <uvmunmap+0xc0>
    80000758:	fc26                	sd	s1,56(sp)
    8000075a:	a8a9                	j	800007b4 <uvmunmap+0x8a>
    8000075c:	fc26                	sd	s1,56(sp)
    8000075e:	f84a                	sd	s2,48(sp)
    80000760:	f44e                	sd	s3,40(sp)
    80000762:	f052                	sd	s4,32(sp)
    80000764:	ec56                	sd	s5,24(sp)
    80000766:	e85a                	sd	s6,16(sp)
    80000768:	e45e                	sd	s7,8(sp)
    panic("uvmunmap: not aligned");
    8000076a:	00008517          	auipc	a0,0x8
    8000076e:	91650513          	addi	a0,a0,-1770 # 80008080 <etext+0x80>
    80000772:	00005097          	auipc	ra,0x5
    80000776:	53c080e7          	jalr	1340(ra) # 80005cae <panic>
      panic("uvmunmap: walk");
    8000077a:	00008517          	auipc	a0,0x8
    8000077e:	91e50513          	addi	a0,a0,-1762 # 80008098 <etext+0x98>
    80000782:	00005097          	auipc	ra,0x5
    80000786:	52c080e7          	jalr	1324(ra) # 80005cae <panic>
      panic("uvmunmap: not mapped");
    8000078a:	00008517          	auipc	a0,0x8
    8000078e:	91e50513          	addi	a0,a0,-1762 # 800080a8 <etext+0xa8>
    80000792:	00005097          	auipc	ra,0x5
    80000796:	51c080e7          	jalr	1308(ra) # 80005cae <panic>
      panic("uvmunmap: not a leaf");
    8000079a:	00008517          	auipc	a0,0x8
    8000079e:	92650513          	addi	a0,a0,-1754 # 800080c0 <etext+0xc0>
    800007a2:	00005097          	auipc	ra,0x5
    800007a6:	50c080e7          	jalr	1292(ra) # 80005cae <panic>
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800007aa:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007ae:	995a                	add	s2,s2,s6
    800007b0:	03397c63          	bgeu	s2,s3,800007e8 <uvmunmap+0xbe>
    if((pte = walk(pagetable, a, 0)) == 0)
    800007b4:	4601                	li	a2,0
    800007b6:	85ca                	mv	a1,s2
    800007b8:	8552                	mv	a0,s4
    800007ba:	00000097          	auipc	ra,0x0
    800007be:	cc8080e7          	jalr	-824(ra) # 80000482 <walk>
    800007c2:	84aa                	mv	s1,a0
    800007c4:	d95d                	beqz	a0,8000077a <uvmunmap+0x50>
    if((*pte & PTE_V) == 0)
    800007c6:	6108                	ld	a0,0(a0)
    800007c8:	00157793          	andi	a5,a0,1
    800007cc:	dfdd                	beqz	a5,8000078a <uvmunmap+0x60>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007ce:	3ff57793          	andi	a5,a0,1023
    800007d2:	fd7784e3          	beq	a5,s7,8000079a <uvmunmap+0x70>
    if(do_free){
    800007d6:	fc0a8ae3          	beqz	s5,800007aa <uvmunmap+0x80>
      uint64 pa = PTE2PA(*pte);
    800007da:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800007dc:	0532                	slli	a0,a0,0xc
    800007de:	00000097          	auipc	ra,0x0
    800007e2:	83e080e7          	jalr	-1986(ra) # 8000001c <kfree>
    800007e6:	b7d1                	j	800007aa <uvmunmap+0x80>
    800007e8:	74e2                	ld	s1,56(sp)
    800007ea:	7942                	ld	s2,48(sp)
    800007ec:	79a2                	ld	s3,40(sp)
    800007ee:	7a02                	ld	s4,32(sp)
    800007f0:	6ae2                	ld	s5,24(sp)
    800007f2:	6b42                	ld	s6,16(sp)
    800007f4:	6ba2                	ld	s7,8(sp)
  }
}
    800007f6:	60a6                	ld	ra,72(sp)
    800007f8:	6406                	ld	s0,64(sp)
    800007fa:	6161                	addi	sp,sp,80
    800007fc:	8082                	ret

00000000800007fe <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007fe:	1101                	addi	sp,sp,-32
    80000800:	ec06                	sd	ra,24(sp)
    80000802:	e822                	sd	s0,16(sp)
    80000804:	e426                	sd	s1,8(sp)
    80000806:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    80000808:	00000097          	auipc	ra,0x0
    8000080c:	918080e7          	jalr	-1768(ra) # 80000120 <kalloc>
    80000810:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000812:	c519                	beqz	a0,80000820 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000814:	6605                	lui	a2,0x1
    80000816:	4581                	li	a1,0
    80000818:	00000097          	auipc	ra,0x0
    8000081c:	972080e7          	jalr	-1678(ra) # 8000018a <memset>
  return pagetable;
}
    80000820:	8526                	mv	a0,s1
    80000822:	60e2                	ld	ra,24(sp)
    80000824:	6442                	ld	s0,16(sp)
    80000826:	64a2                	ld	s1,8(sp)
    80000828:	6105                	addi	sp,sp,32
    8000082a:	8082                	ret

000000008000082c <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    8000082c:	7179                	addi	sp,sp,-48
    8000082e:	f406                	sd	ra,40(sp)
    80000830:	f022                	sd	s0,32(sp)
    80000832:	ec26                	sd	s1,24(sp)
    80000834:	e84a                	sd	s2,16(sp)
    80000836:	e44e                	sd	s3,8(sp)
    80000838:	e052                	sd	s4,0(sp)
    8000083a:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    8000083c:	6785                	lui	a5,0x1
    8000083e:	04f67863          	bgeu	a2,a5,8000088e <uvminit+0x62>
    80000842:	89aa                	mv	s3,a0
    80000844:	8a2e                	mv	s4,a1
    80000846:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80000848:	00000097          	auipc	ra,0x0
    8000084c:	8d8080e7          	jalr	-1832(ra) # 80000120 <kalloc>
    80000850:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000852:	6605                	lui	a2,0x1
    80000854:	4581                	li	a1,0
    80000856:	00000097          	auipc	ra,0x0
    8000085a:	934080e7          	jalr	-1740(ra) # 8000018a <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000085e:	4779                	li	a4,30
    80000860:	86ca                	mv	a3,s2
    80000862:	6605                	lui	a2,0x1
    80000864:	4581                	li	a1,0
    80000866:	854e                	mv	a0,s3
    80000868:	00000097          	auipc	ra,0x0
    8000086c:	cfe080e7          	jalr	-770(ra) # 80000566 <mappages>
  memmove(mem, src, sz);
    80000870:	8626                	mv	a2,s1
    80000872:	85d2                	mv	a1,s4
    80000874:	854a                	mv	a0,s2
    80000876:	00000097          	auipc	ra,0x0
    8000087a:	974080e7          	jalr	-1676(ra) # 800001ea <memmove>
}
    8000087e:	70a2                	ld	ra,40(sp)
    80000880:	7402                	ld	s0,32(sp)
    80000882:	64e2                	ld	s1,24(sp)
    80000884:	6942                	ld	s2,16(sp)
    80000886:	69a2                	ld	s3,8(sp)
    80000888:	6a02                	ld	s4,0(sp)
    8000088a:	6145                	addi	sp,sp,48
    8000088c:	8082                	ret
    panic("inituvm: more than a page");
    8000088e:	00008517          	auipc	a0,0x8
    80000892:	84a50513          	addi	a0,a0,-1974 # 800080d8 <etext+0xd8>
    80000896:	00005097          	auipc	ra,0x5
    8000089a:	418080e7          	jalr	1048(ra) # 80005cae <panic>

000000008000089e <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000089e:	1101                	addi	sp,sp,-32
    800008a0:	ec06                	sd	ra,24(sp)
    800008a2:	e822                	sd	s0,16(sp)
    800008a4:	e426                	sd	s1,8(sp)
    800008a6:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800008a8:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800008aa:	00b67d63          	bgeu	a2,a1,800008c4 <uvmdealloc+0x26>
    800008ae:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800008b0:	6785                	lui	a5,0x1
    800008b2:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008b4:	00f60733          	add	a4,a2,a5
    800008b8:	76fd                	lui	a3,0xfffff
    800008ba:	8f75                	and	a4,a4,a3
    800008bc:	97ae                	add	a5,a5,a1
    800008be:	8ff5                	and	a5,a5,a3
    800008c0:	00f76863          	bltu	a4,a5,800008d0 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800008c4:	8526                	mv	a0,s1
    800008c6:	60e2                	ld	ra,24(sp)
    800008c8:	6442                	ld	s0,16(sp)
    800008ca:	64a2                	ld	s1,8(sp)
    800008cc:	6105                	addi	sp,sp,32
    800008ce:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008d0:	8f99                	sub	a5,a5,a4
    800008d2:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008d4:	4685                	li	a3,1
    800008d6:	0007861b          	sext.w	a2,a5
    800008da:	85ba                	mv	a1,a4
    800008dc:	00000097          	auipc	ra,0x0
    800008e0:	e4e080e7          	jalr	-434(ra) # 8000072a <uvmunmap>
    800008e4:	b7c5                	j	800008c4 <uvmdealloc+0x26>

00000000800008e6 <uvmalloc>:
  if(newsz < oldsz)
    800008e6:	0ab66c63          	bltu	a2,a1,8000099e <uvmalloc+0xb8>
{
    800008ea:	715d                	addi	sp,sp,-80
    800008ec:	e486                	sd	ra,72(sp)
    800008ee:	e0a2                	sd	s0,64(sp)
    800008f0:	f84a                	sd	s2,48(sp)
    800008f2:	f052                	sd	s4,32(sp)
    800008f4:	ec56                	sd	s5,24(sp)
    800008f6:	e45e                	sd	s7,8(sp)
    800008f8:	0880                	addi	s0,sp,80
    800008fa:	8aaa                	mv	s5,a0
    800008fc:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008fe:	6785                	lui	a5,0x1
    80000900:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000902:	95be                	add	a1,a1,a5
    80000904:	77fd                	lui	a5,0xfffff
    80000906:	00f5f933          	and	s2,a1,a5
    8000090a:	8bca                	mv	s7,s2
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000090c:	08c97b63          	bgeu	s2,a2,800009a2 <uvmalloc+0xbc>
    80000910:	fc26                	sd	s1,56(sp)
    80000912:	f44e                	sd	s3,40(sp)
    80000914:	e85a                	sd	s6,16(sp)
    memset(mem, 0, PGSIZE);
    80000916:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80000918:	4b79                	li	s6,30
    mem = kalloc();
    8000091a:	00000097          	auipc	ra,0x0
    8000091e:	806080e7          	jalr	-2042(ra) # 80000120 <kalloc>
    80000922:	84aa                	mv	s1,a0
    if(mem == 0){
    80000924:	c90d                	beqz	a0,80000956 <uvmalloc+0x70>
    memset(mem, 0, PGSIZE);
    80000926:	864e                	mv	a2,s3
    80000928:	4581                	li	a1,0
    8000092a:	00000097          	auipc	ra,0x0
    8000092e:	860080e7          	jalr	-1952(ra) # 8000018a <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80000932:	875a                	mv	a4,s6
    80000934:	86a6                	mv	a3,s1
    80000936:	864e                	mv	a2,s3
    80000938:	85ca                	mv	a1,s2
    8000093a:	8556                	mv	a0,s5
    8000093c:	00000097          	auipc	ra,0x0
    80000940:	c2a080e7          	jalr	-982(ra) # 80000566 <mappages>
    80000944:	ed05                	bnez	a0,8000097c <uvmalloc+0x96>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000946:	994e                	add	s2,s2,s3
    80000948:	fd4969e3          	bltu	s2,s4,8000091a <uvmalloc+0x34>
  return newsz;
    8000094c:	8552                	mv	a0,s4
    8000094e:	74e2                	ld	s1,56(sp)
    80000950:	79a2                	ld	s3,40(sp)
    80000952:	6b42                	ld	s6,16(sp)
    80000954:	a821                	j	8000096c <uvmalloc+0x86>
      uvmdealloc(pagetable, a, oldsz);
    80000956:	865e                	mv	a2,s7
    80000958:	85ca                	mv	a1,s2
    8000095a:	8556                	mv	a0,s5
    8000095c:	00000097          	auipc	ra,0x0
    80000960:	f42080e7          	jalr	-190(ra) # 8000089e <uvmdealloc>
      return 0;
    80000964:	4501                	li	a0,0
    80000966:	74e2                	ld	s1,56(sp)
    80000968:	79a2                	ld	s3,40(sp)
    8000096a:	6b42                	ld	s6,16(sp)
}
    8000096c:	60a6                	ld	ra,72(sp)
    8000096e:	6406                	ld	s0,64(sp)
    80000970:	7942                	ld	s2,48(sp)
    80000972:	7a02                	ld	s4,32(sp)
    80000974:	6ae2                	ld	s5,24(sp)
    80000976:	6ba2                	ld	s7,8(sp)
    80000978:	6161                	addi	sp,sp,80
    8000097a:	8082                	ret
      kfree(mem);
    8000097c:	8526                	mv	a0,s1
    8000097e:	fffff097          	auipc	ra,0xfffff
    80000982:	69e080e7          	jalr	1694(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000986:	865e                	mv	a2,s7
    80000988:	85ca                	mv	a1,s2
    8000098a:	8556                	mv	a0,s5
    8000098c:	00000097          	auipc	ra,0x0
    80000990:	f12080e7          	jalr	-238(ra) # 8000089e <uvmdealloc>
      return 0;
    80000994:	4501                	li	a0,0
    80000996:	74e2                	ld	s1,56(sp)
    80000998:	79a2                	ld	s3,40(sp)
    8000099a:	6b42                	ld	s6,16(sp)
    8000099c:	bfc1                	j	8000096c <uvmalloc+0x86>
    return oldsz;
    8000099e:	852e                	mv	a0,a1
}
    800009a0:	8082                	ret
  return newsz;
    800009a2:	8532                	mv	a0,a2
    800009a4:	b7e1                	j	8000096c <uvmalloc+0x86>

00000000800009a6 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800009a6:	7179                	addi	sp,sp,-48
    800009a8:	f406                	sd	ra,40(sp)
    800009aa:	f022                	sd	s0,32(sp)
    800009ac:	ec26                	sd	s1,24(sp)
    800009ae:	e84a                	sd	s2,16(sp)
    800009b0:	e44e                	sd	s3,8(sp)
    800009b2:	1800                	addi	s0,sp,48
    800009b4:	89aa                	mv	s3,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800009b6:	84aa                	mv	s1,a0
    800009b8:	6905                	lui	s2,0x1
    800009ba:	992a                	add	s2,s2,a0
    800009bc:	a821                	j	800009d4 <freewalk+0x2e>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
      freewalk((pagetable_t)child);
      pagetable[i] = 0;
    } else if(pte & PTE_V){
      panic("freewalk: leaf");
    800009be:	00007517          	auipc	a0,0x7
    800009c2:	73a50513          	addi	a0,a0,1850 # 800080f8 <etext+0xf8>
    800009c6:	00005097          	auipc	ra,0x5
    800009ca:	2e8080e7          	jalr	744(ra) # 80005cae <panic>
  for(int i = 0; i < 512; i++){
    800009ce:	04a1                	addi	s1,s1,8
    800009d0:	03248363          	beq	s1,s2,800009f6 <freewalk+0x50>
    pte_t pte = pagetable[i];
    800009d4:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009d6:	0017f713          	andi	a4,a5,1
    800009da:	db75                	beqz	a4,800009ce <freewalk+0x28>
    800009dc:	00e7f713          	andi	a4,a5,14
    800009e0:	ff79                	bnez	a4,800009be <freewalk+0x18>
      uint64 child = PTE2PA(pte);
    800009e2:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    800009e4:	00c79513          	slli	a0,a5,0xc
    800009e8:	00000097          	auipc	ra,0x0
    800009ec:	fbe080e7          	jalr	-66(ra) # 800009a6 <freewalk>
      pagetable[i] = 0;
    800009f0:	0004b023          	sd	zero,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009f4:	bfe9                	j	800009ce <freewalk+0x28>
    }
  }
  kfree((void*)pagetable);
    800009f6:	854e                	mv	a0,s3
    800009f8:	fffff097          	auipc	ra,0xfffff
    800009fc:	624080e7          	jalr	1572(ra) # 8000001c <kfree>
}
    80000a00:	70a2                	ld	ra,40(sp)
    80000a02:	7402                	ld	s0,32(sp)
    80000a04:	64e2                	ld	s1,24(sp)
    80000a06:	6942                	ld	s2,16(sp)
    80000a08:	69a2                	ld	s3,8(sp)
    80000a0a:	6145                	addi	sp,sp,48
    80000a0c:	8082                	ret

0000000080000a0e <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000a0e:	1101                	addi	sp,sp,-32
    80000a10:	ec06                	sd	ra,24(sp)
    80000a12:	e822                	sd	s0,16(sp)
    80000a14:	e426                	sd	s1,8(sp)
    80000a16:	1000                	addi	s0,sp,32
    80000a18:	84aa                	mv	s1,a0
  if(sz > 0)
    80000a1a:	e999                	bnez	a1,80000a30 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000a1c:	8526                	mv	a0,s1
    80000a1e:	00000097          	auipc	ra,0x0
    80000a22:	f88080e7          	jalr	-120(ra) # 800009a6 <freewalk>
}
    80000a26:	60e2                	ld	ra,24(sp)
    80000a28:	6442                	ld	s0,16(sp)
    80000a2a:	64a2                	ld	s1,8(sp)
    80000a2c:	6105                	addi	sp,sp,32
    80000a2e:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000a30:	6785                	lui	a5,0x1
    80000a32:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000a34:	95be                	add	a1,a1,a5
    80000a36:	4685                	li	a3,1
    80000a38:	00c5d613          	srli	a2,a1,0xc
    80000a3c:	4581                	li	a1,0
    80000a3e:	00000097          	auipc	ra,0x0
    80000a42:	cec080e7          	jalr	-788(ra) # 8000072a <uvmunmap>
    80000a46:	bfd9                	j	80000a1c <uvmfree+0xe>

0000000080000a48 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a48:	c669                	beqz	a2,80000b12 <uvmcopy+0xca>
{
    80000a4a:	715d                	addi	sp,sp,-80
    80000a4c:	e486                	sd	ra,72(sp)
    80000a4e:	e0a2                	sd	s0,64(sp)
    80000a50:	fc26                	sd	s1,56(sp)
    80000a52:	f84a                	sd	s2,48(sp)
    80000a54:	f44e                	sd	s3,40(sp)
    80000a56:	f052                	sd	s4,32(sp)
    80000a58:	ec56                	sd	s5,24(sp)
    80000a5a:	e85a                	sd	s6,16(sp)
    80000a5c:	e45e                	sd	s7,8(sp)
    80000a5e:	0880                	addi	s0,sp,80
    80000a60:	8b2a                	mv	s6,a0
    80000a62:	8aae                	mv	s5,a1
    80000a64:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a66:	4901                	li	s2,0
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a68:	6985                	lui	s3,0x1
    if((pte = walk(old, i, 0)) == 0)
    80000a6a:	4601                	li	a2,0
    80000a6c:	85ca                	mv	a1,s2
    80000a6e:	855a                	mv	a0,s6
    80000a70:	00000097          	auipc	ra,0x0
    80000a74:	a12080e7          	jalr	-1518(ra) # 80000482 <walk>
    80000a78:	c139                	beqz	a0,80000abe <uvmcopy+0x76>
    if((*pte & PTE_V) == 0)
    80000a7a:	00053b83          	ld	s7,0(a0)
    80000a7e:	001bf793          	andi	a5,s7,1
    80000a82:	c7b1                	beqz	a5,80000ace <uvmcopy+0x86>
    if((mem = kalloc()) == 0)
    80000a84:	fffff097          	auipc	ra,0xfffff
    80000a88:	69c080e7          	jalr	1692(ra) # 80000120 <kalloc>
    80000a8c:	84aa                	mv	s1,a0
    80000a8e:	cd29                	beqz	a0,80000ae8 <uvmcopy+0xa0>
    pa = PTE2PA(*pte);
    80000a90:	00abd593          	srli	a1,s7,0xa
    memmove(mem, (char*)pa, PGSIZE);
    80000a94:	864e                	mv	a2,s3
    80000a96:	05b2                	slli	a1,a1,0xc
    80000a98:	fffff097          	auipc	ra,0xfffff
    80000a9c:	752080e7          	jalr	1874(ra) # 800001ea <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000aa0:	3ffbf713          	andi	a4,s7,1023
    80000aa4:	86a6                	mv	a3,s1
    80000aa6:	864e                	mv	a2,s3
    80000aa8:	85ca                	mv	a1,s2
    80000aaa:	8556                	mv	a0,s5
    80000aac:	00000097          	auipc	ra,0x0
    80000ab0:	aba080e7          	jalr	-1350(ra) # 80000566 <mappages>
    80000ab4:	e50d                	bnez	a0,80000ade <uvmcopy+0x96>
  for(i = 0; i < sz; i += PGSIZE){
    80000ab6:	994e                	add	s2,s2,s3
    80000ab8:	fb4969e3          	bltu	s2,s4,80000a6a <uvmcopy+0x22>
    80000abc:	a081                	j	80000afc <uvmcopy+0xb4>
      panic("uvmcopy: pte should exist");
    80000abe:	00007517          	auipc	a0,0x7
    80000ac2:	64a50513          	addi	a0,a0,1610 # 80008108 <etext+0x108>
    80000ac6:	00005097          	auipc	ra,0x5
    80000aca:	1e8080e7          	jalr	488(ra) # 80005cae <panic>
      panic("uvmcopy: page not present");
    80000ace:	00007517          	auipc	a0,0x7
    80000ad2:	65a50513          	addi	a0,a0,1626 # 80008128 <etext+0x128>
    80000ad6:	00005097          	auipc	ra,0x5
    80000ada:	1d8080e7          	jalr	472(ra) # 80005cae <panic>
      kfree(mem);
    80000ade:	8526                	mv	a0,s1
    80000ae0:	fffff097          	auipc	ra,0xfffff
    80000ae4:	53c080e7          	jalr	1340(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000ae8:	4685                	li	a3,1
    80000aea:	00c95613          	srli	a2,s2,0xc
    80000aee:	4581                	li	a1,0
    80000af0:	8556                	mv	a0,s5
    80000af2:	00000097          	auipc	ra,0x0
    80000af6:	c38080e7          	jalr	-968(ra) # 8000072a <uvmunmap>
  return -1;
    80000afa:	557d                	li	a0,-1
}
    80000afc:	60a6                	ld	ra,72(sp)
    80000afe:	6406                	ld	s0,64(sp)
    80000b00:	74e2                	ld	s1,56(sp)
    80000b02:	7942                	ld	s2,48(sp)
    80000b04:	79a2                	ld	s3,40(sp)
    80000b06:	7a02                	ld	s4,32(sp)
    80000b08:	6ae2                	ld	s5,24(sp)
    80000b0a:	6b42                	ld	s6,16(sp)
    80000b0c:	6ba2                	ld	s7,8(sp)
    80000b0e:	6161                	addi	sp,sp,80
    80000b10:	8082                	ret
  return 0;
    80000b12:	4501                	li	a0,0
}
    80000b14:	8082                	ret

0000000080000b16 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000b16:	1141                	addi	sp,sp,-16
    80000b18:	e406                	sd	ra,8(sp)
    80000b1a:	e022                	sd	s0,0(sp)
    80000b1c:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000b1e:	4601                	li	a2,0
    80000b20:	00000097          	auipc	ra,0x0
    80000b24:	962080e7          	jalr	-1694(ra) # 80000482 <walk>
  if(pte == 0)
    80000b28:	c901                	beqz	a0,80000b38 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000b2a:	611c                	ld	a5,0(a0)
    80000b2c:	9bbd                	andi	a5,a5,-17
    80000b2e:	e11c                	sd	a5,0(a0)
}
    80000b30:	60a2                	ld	ra,8(sp)
    80000b32:	6402                	ld	s0,0(sp)
    80000b34:	0141                	addi	sp,sp,16
    80000b36:	8082                	ret
    panic("uvmclear");
    80000b38:	00007517          	auipc	a0,0x7
    80000b3c:	61050513          	addi	a0,a0,1552 # 80008148 <etext+0x148>
    80000b40:	00005097          	auipc	ra,0x5
    80000b44:	16e080e7          	jalr	366(ra) # 80005cae <panic>

0000000080000b48 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b48:	c6bd                	beqz	a3,80000bb6 <copyout+0x6e>
{
    80000b4a:	715d                	addi	sp,sp,-80
    80000b4c:	e486                	sd	ra,72(sp)
    80000b4e:	e0a2                	sd	s0,64(sp)
    80000b50:	fc26                	sd	s1,56(sp)
    80000b52:	f84a                	sd	s2,48(sp)
    80000b54:	f44e                	sd	s3,40(sp)
    80000b56:	f052                	sd	s4,32(sp)
    80000b58:	ec56                	sd	s5,24(sp)
    80000b5a:	e85a                	sd	s6,16(sp)
    80000b5c:	e45e                	sd	s7,8(sp)
    80000b5e:	e062                	sd	s8,0(sp)
    80000b60:	0880                	addi	s0,sp,80
    80000b62:	8b2a                	mv	s6,a0
    80000b64:	8c2e                	mv	s8,a1
    80000b66:	8a32                	mv	s4,a2
    80000b68:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b6a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b6c:	6a85                	lui	s5,0x1
    80000b6e:	a015                	j	80000b92 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b70:	9562                	add	a0,a0,s8
    80000b72:	0004861b          	sext.w	a2,s1
    80000b76:	85d2                	mv	a1,s4
    80000b78:	41250533          	sub	a0,a0,s2
    80000b7c:	fffff097          	auipc	ra,0xfffff
    80000b80:	66e080e7          	jalr	1646(ra) # 800001ea <memmove>

    len -= n;
    80000b84:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b88:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b8a:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b8e:	02098263          	beqz	s3,80000bb2 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b92:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b96:	85ca                	mv	a1,s2
    80000b98:	855a                	mv	a0,s6
    80000b9a:	00000097          	auipc	ra,0x0
    80000b9e:	98e080e7          	jalr	-1650(ra) # 80000528 <walkaddr>
    if(pa0 == 0)
    80000ba2:	cd01                	beqz	a0,80000bba <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000ba4:	418904b3          	sub	s1,s2,s8
    80000ba8:	94d6                	add	s1,s1,s5
    if(n > len)
    80000baa:	fc99f3e3          	bgeu	s3,s1,80000b70 <copyout+0x28>
    80000bae:	84ce                	mv	s1,s3
    80000bb0:	b7c1                	j	80000b70 <copyout+0x28>
  }
  return 0;
    80000bb2:	4501                	li	a0,0
    80000bb4:	a021                	j	80000bbc <copyout+0x74>
    80000bb6:	4501                	li	a0,0
}
    80000bb8:	8082                	ret
      return -1;
    80000bba:	557d                	li	a0,-1
}
    80000bbc:	60a6                	ld	ra,72(sp)
    80000bbe:	6406                	ld	s0,64(sp)
    80000bc0:	74e2                	ld	s1,56(sp)
    80000bc2:	7942                	ld	s2,48(sp)
    80000bc4:	79a2                	ld	s3,40(sp)
    80000bc6:	7a02                	ld	s4,32(sp)
    80000bc8:	6ae2                	ld	s5,24(sp)
    80000bca:	6b42                	ld	s6,16(sp)
    80000bcc:	6ba2                	ld	s7,8(sp)
    80000bce:	6c02                	ld	s8,0(sp)
    80000bd0:	6161                	addi	sp,sp,80
    80000bd2:	8082                	ret

0000000080000bd4 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000bd4:	caa5                	beqz	a3,80000c44 <copyin+0x70>
{
    80000bd6:	715d                	addi	sp,sp,-80
    80000bd8:	e486                	sd	ra,72(sp)
    80000bda:	e0a2                	sd	s0,64(sp)
    80000bdc:	fc26                	sd	s1,56(sp)
    80000bde:	f84a                	sd	s2,48(sp)
    80000be0:	f44e                	sd	s3,40(sp)
    80000be2:	f052                	sd	s4,32(sp)
    80000be4:	ec56                	sd	s5,24(sp)
    80000be6:	e85a                	sd	s6,16(sp)
    80000be8:	e45e                	sd	s7,8(sp)
    80000bea:	e062                	sd	s8,0(sp)
    80000bec:	0880                	addi	s0,sp,80
    80000bee:	8b2a                	mv	s6,a0
    80000bf0:	8a2e                	mv	s4,a1
    80000bf2:	8c32                	mv	s8,a2
    80000bf4:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bf6:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bf8:	6a85                	lui	s5,0x1
    80000bfa:	a01d                	j	80000c20 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000bfc:	018505b3          	add	a1,a0,s8
    80000c00:	0004861b          	sext.w	a2,s1
    80000c04:	412585b3          	sub	a1,a1,s2
    80000c08:	8552                	mv	a0,s4
    80000c0a:	fffff097          	auipc	ra,0xfffff
    80000c0e:	5e0080e7          	jalr	1504(ra) # 800001ea <memmove>

    len -= n;
    80000c12:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000c16:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000c18:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000c1c:	02098263          	beqz	s3,80000c40 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000c20:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000c24:	85ca                	mv	a1,s2
    80000c26:	855a                	mv	a0,s6
    80000c28:	00000097          	auipc	ra,0x0
    80000c2c:	900080e7          	jalr	-1792(ra) # 80000528 <walkaddr>
    if(pa0 == 0)
    80000c30:	cd01                	beqz	a0,80000c48 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000c32:	418904b3          	sub	s1,s2,s8
    80000c36:	94d6                	add	s1,s1,s5
    if(n > len)
    80000c38:	fc99f2e3          	bgeu	s3,s1,80000bfc <copyin+0x28>
    80000c3c:	84ce                	mv	s1,s3
    80000c3e:	bf7d                	j	80000bfc <copyin+0x28>
  }
  return 0;
    80000c40:	4501                	li	a0,0
    80000c42:	a021                	j	80000c4a <copyin+0x76>
    80000c44:	4501                	li	a0,0
}
    80000c46:	8082                	ret
      return -1;
    80000c48:	557d                	li	a0,-1
}
    80000c4a:	60a6                	ld	ra,72(sp)
    80000c4c:	6406                	ld	s0,64(sp)
    80000c4e:	74e2                	ld	s1,56(sp)
    80000c50:	7942                	ld	s2,48(sp)
    80000c52:	79a2                	ld	s3,40(sp)
    80000c54:	7a02                	ld	s4,32(sp)
    80000c56:	6ae2                	ld	s5,24(sp)
    80000c58:	6b42                	ld	s6,16(sp)
    80000c5a:	6ba2                	ld	s7,8(sp)
    80000c5c:	6c02                	ld	s8,0(sp)
    80000c5e:	6161                	addi	sp,sp,80
    80000c60:	8082                	ret

0000000080000c62 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c62:	cad5                	beqz	a3,80000d16 <copyinstr+0xb4>
{
    80000c64:	715d                	addi	sp,sp,-80
    80000c66:	e486                	sd	ra,72(sp)
    80000c68:	e0a2                	sd	s0,64(sp)
    80000c6a:	fc26                	sd	s1,56(sp)
    80000c6c:	f84a                	sd	s2,48(sp)
    80000c6e:	f44e                	sd	s3,40(sp)
    80000c70:	f052                	sd	s4,32(sp)
    80000c72:	ec56                	sd	s5,24(sp)
    80000c74:	e85a                	sd	s6,16(sp)
    80000c76:	e45e                	sd	s7,8(sp)
    80000c78:	0880                	addi	s0,sp,80
    80000c7a:	8aaa                	mv	s5,a0
    80000c7c:	84ae                	mv	s1,a1
    80000c7e:	8bb2                	mv	s7,a2
    80000c80:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000c82:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c84:	6a05                	lui	s4,0x1
    80000c86:	a82d                	j	80000cc0 <copyinstr+0x5e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c88:	00078023          	sb	zero,0(a5)
        got_null = 1;
    80000c8c:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c8e:	0017c793          	xori	a5,a5,1
    80000c92:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c96:	60a6                	ld	ra,72(sp)
    80000c98:	6406                	ld	s0,64(sp)
    80000c9a:	74e2                	ld	s1,56(sp)
    80000c9c:	7942                	ld	s2,48(sp)
    80000c9e:	79a2                	ld	s3,40(sp)
    80000ca0:	7a02                	ld	s4,32(sp)
    80000ca2:	6ae2                	ld	s5,24(sp)
    80000ca4:	6b42                	ld	s6,16(sp)
    80000ca6:	6ba2                	ld	s7,8(sp)
    80000ca8:	6161                	addi	sp,sp,80
    80000caa:	8082                	ret
    80000cac:	fff98713          	addi	a4,s3,-1 # fff <_entry-0x7ffff001>
    80000cb0:	9726                	add	a4,a4,s1
      --max;
    80000cb2:	40b709b3          	sub	s3,a4,a1
    srcva = va0 + PGSIZE;
    80000cb6:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    80000cba:	04e58663          	beq	a1,a4,80000d06 <copyinstr+0xa4>
{
    80000cbe:	84be                	mv	s1,a5
    va0 = PGROUNDDOWN(srcva);
    80000cc0:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    80000cc4:	85ca                	mv	a1,s2
    80000cc6:	8556                	mv	a0,s5
    80000cc8:	00000097          	auipc	ra,0x0
    80000ccc:	860080e7          	jalr	-1952(ra) # 80000528 <walkaddr>
    if(pa0 == 0)
    80000cd0:	cd0d                	beqz	a0,80000d0a <copyinstr+0xa8>
    n = PGSIZE - (srcva - va0);
    80000cd2:	417906b3          	sub	a3,s2,s7
    80000cd6:	96d2                	add	a3,a3,s4
    if(n > max)
    80000cd8:	00d9f363          	bgeu	s3,a3,80000cde <copyinstr+0x7c>
    80000cdc:	86ce                	mv	a3,s3
    while(n > 0){
    80000cde:	ca85                	beqz	a3,80000d0e <copyinstr+0xac>
    char *p = (char *) (pa0 + (srcva - va0));
    80000ce0:	01750633          	add	a2,a0,s7
    80000ce4:	41260633          	sub	a2,a2,s2
    80000ce8:	87a6                	mv	a5,s1
      if(*p == '\0'){
    80000cea:	8e05                	sub	a2,a2,s1
    while(n > 0){
    80000cec:	96a6                	add	a3,a3,s1
    80000cee:	85be                	mv	a1,a5
      if(*p == '\0'){
    80000cf0:	00f60733          	add	a4,a2,a5
    80000cf4:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffdadc0>
    80000cf8:	db41                	beqz	a4,80000c88 <copyinstr+0x26>
        *dst = *p;
    80000cfa:	00e78023          	sb	a4,0(a5)
      dst++;
    80000cfe:	0785                	addi	a5,a5,1
    while(n > 0){
    80000d00:	fed797e3          	bne	a5,a3,80000cee <copyinstr+0x8c>
    80000d04:	b765                	j	80000cac <copyinstr+0x4a>
    80000d06:	4781                	li	a5,0
    80000d08:	b759                	j	80000c8e <copyinstr+0x2c>
      return -1;
    80000d0a:	557d                	li	a0,-1
    80000d0c:	b769                	j	80000c96 <copyinstr+0x34>
    srcva = va0 + PGSIZE;
    80000d0e:	6b85                	lui	s7,0x1
    80000d10:	9bca                	add	s7,s7,s2
    80000d12:	87a6                	mv	a5,s1
    80000d14:	b76d                	j	80000cbe <copyinstr+0x5c>
  int got_null = 0;
    80000d16:	4781                	li	a5,0
  if(got_null){
    80000d18:	0017c793          	xori	a5,a5,1
    80000d1c:	40f0053b          	negw	a0,a5
}
    80000d20:	8082                	ret

0000000080000d22 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000d22:	715d                	addi	sp,sp,-80
    80000d24:	e486                	sd	ra,72(sp)
    80000d26:	e0a2                	sd	s0,64(sp)
    80000d28:	fc26                	sd	s1,56(sp)
    80000d2a:	f84a                	sd	s2,48(sp)
    80000d2c:	f44e                	sd	s3,40(sp)
    80000d2e:	f052                	sd	s4,32(sp)
    80000d30:	ec56                	sd	s5,24(sp)
    80000d32:	e85a                	sd	s6,16(sp)
    80000d34:	e45e                	sd	s7,8(sp)
    80000d36:	e062                	sd	s8,0(sp)
    80000d38:	0880                	addi	s0,sp,80
    80000d3a:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d3c:	0000b497          	auipc	s1,0xb
    80000d40:	74448493          	addi	s1,s1,1860 # 8000c480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000d44:	8c26                	mv	s8,s1
    80000d46:	000a57b7          	lui	a5,0xa5
    80000d4a:	fa578793          	addi	a5,a5,-91 # a4fa5 <_entry-0x7ff5b05b>
    80000d4e:	07b2                	slli	a5,a5,0xc
    80000d50:	fa578793          	addi	a5,a5,-91
    80000d54:	4fa50937          	lui	s2,0x4fa50
    80000d58:	a4f90913          	addi	s2,s2,-1457 # 4fa4fa4f <_entry-0x305b05b1>
    80000d5c:	1902                	slli	s2,s2,0x20
    80000d5e:	993e                	add	s2,s2,a5
    80000d60:	040009b7          	lui	s3,0x4000
    80000d64:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000d66:	09b2                	slli	s3,s3,0xc
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d68:	4b99                	li	s7,6
    80000d6a:	6b05                	lui	s6,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d6c:	0000ca97          	auipc	s5,0xc
    80000d70:	524a8a93          	addi	s5,s5,1316 # 8000d290 <tickslock>
    char *pa = kalloc();
    80000d74:	fffff097          	auipc	ra,0xfffff
    80000d78:	3ac080e7          	jalr	940(ra) # 80000120 <kalloc>
    80000d7c:	862a                	mv	a2,a0
    if(pa == 0)
    80000d7e:	c131                	beqz	a0,80000dc2 <proc_mapstacks+0xa0>
    uint64 va = KSTACK((int) (p - proc));
    80000d80:	418485b3          	sub	a1,s1,s8
    80000d84:	858d                	srai	a1,a1,0x3
    80000d86:	032585b3          	mul	a1,a1,s2
    80000d8a:	05b6                	slli	a1,a1,0xd
    80000d8c:	6789                	lui	a5,0x2
    80000d8e:	9dbd                	addw	a1,a1,a5
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d90:	875e                	mv	a4,s7
    80000d92:	86da                	mv	a3,s6
    80000d94:	40b985b3          	sub	a1,s3,a1
    80000d98:	8552                	mv	a0,s4
    80000d9a:	00000097          	auipc	ra,0x0
    80000d9e:	86e080e7          	jalr	-1938(ra) # 80000608 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000da2:	16848493          	addi	s1,s1,360
    80000da6:	fd5497e3          	bne	s1,s5,80000d74 <proc_mapstacks+0x52>
  }
}
    80000daa:	60a6                	ld	ra,72(sp)
    80000dac:	6406                	ld	s0,64(sp)
    80000dae:	74e2                	ld	s1,56(sp)
    80000db0:	7942                	ld	s2,48(sp)
    80000db2:	79a2                	ld	s3,40(sp)
    80000db4:	7a02                	ld	s4,32(sp)
    80000db6:	6ae2                	ld	s5,24(sp)
    80000db8:	6b42                	ld	s6,16(sp)
    80000dba:	6ba2                	ld	s7,8(sp)
    80000dbc:	6c02                	ld	s8,0(sp)
    80000dbe:	6161                	addi	sp,sp,80
    80000dc0:	8082                	ret
      panic("kalloc");
    80000dc2:	00007517          	auipc	a0,0x7
    80000dc6:	39650513          	addi	a0,a0,918 # 80008158 <etext+0x158>
    80000dca:	00005097          	auipc	ra,0x5
    80000dce:	ee4080e7          	jalr	-284(ra) # 80005cae <panic>

0000000080000dd2 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80000dd2:	7139                	addi	sp,sp,-64
    80000dd4:	fc06                	sd	ra,56(sp)
    80000dd6:	f822                	sd	s0,48(sp)
    80000dd8:	f426                	sd	s1,40(sp)
    80000dda:	f04a                	sd	s2,32(sp)
    80000ddc:	ec4e                	sd	s3,24(sp)
    80000dde:	e852                	sd	s4,16(sp)
    80000de0:	e456                	sd	s5,8(sp)
    80000de2:	e05a                	sd	s6,0(sp)
    80000de4:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000de6:	00007597          	auipc	a1,0x7
    80000dea:	37a58593          	addi	a1,a1,890 # 80008160 <etext+0x160>
    80000dee:	0000b517          	auipc	a0,0xb
    80000df2:	26250513          	addi	a0,a0,610 # 8000c050 <pid_lock>
    80000df6:	00005097          	auipc	ra,0x5
    80000dfa:	3ae080e7          	jalr	942(ra) # 800061a4 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000dfe:	00007597          	auipc	a1,0x7
    80000e02:	36a58593          	addi	a1,a1,874 # 80008168 <etext+0x168>
    80000e06:	0000b517          	auipc	a0,0xb
    80000e0a:	26250513          	addi	a0,a0,610 # 8000c068 <wait_lock>
    80000e0e:	00005097          	auipc	ra,0x5
    80000e12:	396080e7          	jalr	918(ra) # 800061a4 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e16:	0000b497          	auipc	s1,0xb
    80000e1a:	66a48493          	addi	s1,s1,1642 # 8000c480 <proc>
      initlock(&p->lock, "proc");
    80000e1e:	00007b17          	auipc	s6,0x7
    80000e22:	35ab0b13          	addi	s6,s6,858 # 80008178 <etext+0x178>
      p->kstack = KSTACK((int) (p - proc));
    80000e26:	8aa6                	mv	s5,s1
    80000e28:	000a57b7          	lui	a5,0xa5
    80000e2c:	fa578793          	addi	a5,a5,-91 # a4fa5 <_entry-0x7ff5b05b>
    80000e30:	07b2                	slli	a5,a5,0xc
    80000e32:	fa578793          	addi	a5,a5,-91
    80000e36:	4fa50937          	lui	s2,0x4fa50
    80000e3a:	a4f90913          	addi	s2,s2,-1457 # 4fa4fa4f <_entry-0x305b05b1>
    80000e3e:	1902                	slli	s2,s2,0x20
    80000e40:	993e                	add	s2,s2,a5
    80000e42:	040009b7          	lui	s3,0x4000
    80000e46:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000e48:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e4a:	0000ca17          	auipc	s4,0xc
    80000e4e:	446a0a13          	addi	s4,s4,1094 # 8000d290 <tickslock>
      initlock(&p->lock, "proc");
    80000e52:	85da                	mv	a1,s6
    80000e54:	8526                	mv	a0,s1
    80000e56:	00005097          	auipc	ra,0x5
    80000e5a:	34e080e7          	jalr	846(ra) # 800061a4 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000e5e:	415487b3          	sub	a5,s1,s5
    80000e62:	878d                	srai	a5,a5,0x3
    80000e64:	032787b3          	mul	a5,a5,s2
    80000e68:	07b6                	slli	a5,a5,0xd
    80000e6a:	6709                	lui	a4,0x2
    80000e6c:	9fb9                	addw	a5,a5,a4
    80000e6e:	40f987b3          	sub	a5,s3,a5
    80000e72:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e74:	16848493          	addi	s1,s1,360
    80000e78:	fd449de3          	bne	s1,s4,80000e52 <procinit+0x80>
  }
}
    80000e7c:	70e2                	ld	ra,56(sp)
    80000e7e:	7442                	ld	s0,48(sp)
    80000e80:	74a2                	ld	s1,40(sp)
    80000e82:	7902                	ld	s2,32(sp)
    80000e84:	69e2                	ld	s3,24(sp)
    80000e86:	6a42                	ld	s4,16(sp)
    80000e88:	6aa2                	ld	s5,8(sp)
    80000e8a:	6b02                	ld	s6,0(sp)
    80000e8c:	6121                	addi	sp,sp,64
    80000e8e:	8082                	ret

0000000080000e90 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000e90:	1141                	addi	sp,sp,-16
    80000e92:	e406                	sd	ra,8(sp)
    80000e94:	e022                	sd	s0,0(sp)
    80000e96:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000e98:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000e9a:	2501                	sext.w	a0,a0
    80000e9c:	60a2                	ld	ra,8(sp)
    80000e9e:	6402                	ld	s0,0(sp)
    80000ea0:	0141                	addi	sp,sp,16
    80000ea2:	8082                	ret

0000000080000ea4 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80000ea4:	1141                	addi	sp,sp,-16
    80000ea6:	e406                	sd	ra,8(sp)
    80000ea8:	e022                	sd	s0,0(sp)
    80000eaa:	0800                	addi	s0,sp,16
    80000eac:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000eae:	2781                	sext.w	a5,a5
    80000eb0:	079e                	slli	a5,a5,0x7
  return c;
}
    80000eb2:	0000b517          	auipc	a0,0xb
    80000eb6:	1ce50513          	addi	a0,a0,462 # 8000c080 <cpus>
    80000eba:	953e                	add	a0,a0,a5
    80000ebc:	60a2                	ld	ra,8(sp)
    80000ebe:	6402                	ld	s0,0(sp)
    80000ec0:	0141                	addi	sp,sp,16
    80000ec2:	8082                	ret

0000000080000ec4 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80000ec4:	1101                	addi	sp,sp,-32
    80000ec6:	ec06                	sd	ra,24(sp)
    80000ec8:	e822                	sd	s0,16(sp)
    80000eca:	e426                	sd	s1,8(sp)
    80000ecc:	1000                	addi	s0,sp,32
  push_off();
    80000ece:	00005097          	auipc	ra,0x5
    80000ed2:	320080e7          	jalr	800(ra) # 800061ee <push_off>
    80000ed6:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000ed8:	2781                	sext.w	a5,a5
    80000eda:	079e                	slli	a5,a5,0x7
    80000edc:	0000b717          	auipc	a4,0xb
    80000ee0:	17470713          	addi	a4,a4,372 # 8000c050 <pid_lock>
    80000ee4:	97ba                	add	a5,a5,a4
    80000ee6:	7b9c                	ld	a5,48(a5)
    80000ee8:	84be                	mv	s1,a5
  pop_off();
    80000eea:	00005097          	auipc	ra,0x5
    80000eee:	3a8080e7          	jalr	936(ra) # 80006292 <pop_off>
  return p;
}
    80000ef2:	8526                	mv	a0,s1
    80000ef4:	60e2                	ld	ra,24(sp)
    80000ef6:	6442                	ld	s0,16(sp)
    80000ef8:	64a2                	ld	s1,8(sp)
    80000efa:	6105                	addi	sp,sp,32
    80000efc:	8082                	ret

0000000080000efe <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000efe:	1141                	addi	sp,sp,-16
    80000f00:	e406                	sd	ra,8(sp)
    80000f02:	e022                	sd	s0,0(sp)
    80000f04:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000f06:	00000097          	auipc	ra,0x0
    80000f0a:	fbe080e7          	jalr	-66(ra) # 80000ec4 <myproc>
    80000f0e:	00005097          	auipc	ra,0x5
    80000f12:	3e0080e7          	jalr	992(ra) # 800062ee <release>

  if (first) {
    80000f16:	0000a797          	auipc	a5,0xa
    80000f1a:	15a7a783          	lw	a5,346(a5) # 8000b070 <first.1>
    80000f1e:	eb89                	bnez	a5,80000f30 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000f20:	00001097          	auipc	ra,0x1
    80000f24:	c14080e7          	jalr	-1004(ra) # 80001b34 <usertrapret>
}
    80000f28:	60a2                	ld	ra,8(sp)
    80000f2a:	6402                	ld	s0,0(sp)
    80000f2c:	0141                	addi	sp,sp,16
    80000f2e:	8082                	ret
    first = 0;
    80000f30:	0000a797          	auipc	a5,0xa
    80000f34:	1407a023          	sw	zero,320(a5) # 8000b070 <first.1>
    fsinit(ROOTDEV);
    80000f38:	4505                	li	a0,1
    80000f3a:	00002097          	auipc	ra,0x2
    80000f3e:	926080e7          	jalr	-1754(ra) # 80002860 <fsinit>
    80000f42:	bff9                	j	80000f20 <forkret+0x22>

0000000080000f44 <allocpid>:
allocpid() {
    80000f44:	1101                	addi	sp,sp,-32
    80000f46:	ec06                	sd	ra,24(sp)
    80000f48:	e822                	sd	s0,16(sp)
    80000f4a:	e426                	sd	s1,8(sp)
    80000f4c:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000f4e:	0000b517          	auipc	a0,0xb
    80000f52:	10250513          	addi	a0,a0,258 # 8000c050 <pid_lock>
    80000f56:	00005097          	auipc	ra,0x5
    80000f5a:	2e8080e7          	jalr	744(ra) # 8000623e <acquire>
  pid = nextpid;
    80000f5e:	0000a797          	auipc	a5,0xa
    80000f62:	11678793          	addi	a5,a5,278 # 8000b074 <nextpid>
    80000f66:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000f68:	0014871b          	addiw	a4,s1,1
    80000f6c:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000f6e:	0000b517          	auipc	a0,0xb
    80000f72:	0e250513          	addi	a0,a0,226 # 8000c050 <pid_lock>
    80000f76:	00005097          	auipc	ra,0x5
    80000f7a:	378080e7          	jalr	888(ra) # 800062ee <release>
}
    80000f7e:	8526                	mv	a0,s1
    80000f80:	60e2                	ld	ra,24(sp)
    80000f82:	6442                	ld	s0,16(sp)
    80000f84:	64a2                	ld	s1,8(sp)
    80000f86:	6105                	addi	sp,sp,32
    80000f88:	8082                	ret

0000000080000f8a <proc_pagetable>:
{
    80000f8a:	1101                	addi	sp,sp,-32
    80000f8c:	ec06                	sd	ra,24(sp)
    80000f8e:	e822                	sd	s0,16(sp)
    80000f90:	e426                	sd	s1,8(sp)
    80000f92:	e04a                	sd	s2,0(sp)
    80000f94:	1000                	addi	s0,sp,32
    80000f96:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000f98:	00000097          	auipc	ra,0x0
    80000f9c:	866080e7          	jalr	-1946(ra) # 800007fe <uvmcreate>
    80000fa0:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000fa2:	c121                	beqz	a0,80000fe2 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000fa4:	4729                	li	a4,10
    80000fa6:	00006697          	auipc	a3,0x6
    80000faa:	05a68693          	addi	a3,a3,90 # 80007000 <_trampoline>
    80000fae:	6605                	lui	a2,0x1
    80000fb0:	040005b7          	lui	a1,0x4000
    80000fb4:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000fb6:	05b2                	slli	a1,a1,0xc
    80000fb8:	fffff097          	auipc	ra,0xfffff
    80000fbc:	5ae080e7          	jalr	1454(ra) # 80000566 <mappages>
    80000fc0:	02054863          	bltz	a0,80000ff0 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000fc4:	4719                	li	a4,6
    80000fc6:	05893683          	ld	a3,88(s2)
    80000fca:	6605                	lui	a2,0x1
    80000fcc:	020005b7          	lui	a1,0x2000
    80000fd0:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000fd2:	05b6                	slli	a1,a1,0xd
    80000fd4:	8526                	mv	a0,s1
    80000fd6:	fffff097          	auipc	ra,0xfffff
    80000fda:	590080e7          	jalr	1424(ra) # 80000566 <mappages>
    80000fde:	02054163          	bltz	a0,80001000 <proc_pagetable+0x76>
}
    80000fe2:	8526                	mv	a0,s1
    80000fe4:	60e2                	ld	ra,24(sp)
    80000fe6:	6442                	ld	s0,16(sp)
    80000fe8:	64a2                	ld	s1,8(sp)
    80000fea:	6902                	ld	s2,0(sp)
    80000fec:	6105                	addi	sp,sp,32
    80000fee:	8082                	ret
    uvmfree(pagetable, 0);
    80000ff0:	4581                	li	a1,0
    80000ff2:	8526                	mv	a0,s1
    80000ff4:	00000097          	auipc	ra,0x0
    80000ff8:	a1a080e7          	jalr	-1510(ra) # 80000a0e <uvmfree>
    return 0;
    80000ffc:	4481                	li	s1,0
    80000ffe:	b7d5                	j	80000fe2 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001000:	4681                	li	a3,0
    80001002:	4605                	li	a2,1
    80001004:	040005b7          	lui	a1,0x4000
    80001008:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    8000100a:	05b2                	slli	a1,a1,0xc
    8000100c:	8526                	mv	a0,s1
    8000100e:	fffff097          	auipc	ra,0xfffff
    80001012:	71c080e7          	jalr	1820(ra) # 8000072a <uvmunmap>
    uvmfree(pagetable, 0);
    80001016:	4581                	li	a1,0
    80001018:	8526                	mv	a0,s1
    8000101a:	00000097          	auipc	ra,0x0
    8000101e:	9f4080e7          	jalr	-1548(ra) # 80000a0e <uvmfree>
    return 0;
    80001022:	4481                	li	s1,0
    80001024:	bf7d                	j	80000fe2 <proc_pagetable+0x58>

0000000080001026 <proc_freepagetable>:
{
    80001026:	1101                	addi	sp,sp,-32
    80001028:	ec06                	sd	ra,24(sp)
    8000102a:	e822                	sd	s0,16(sp)
    8000102c:	e426                	sd	s1,8(sp)
    8000102e:	e04a                	sd	s2,0(sp)
    80001030:	1000                	addi	s0,sp,32
    80001032:	84aa                	mv	s1,a0
    80001034:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001036:	4681                	li	a3,0
    80001038:	4605                	li	a2,1
    8000103a:	040005b7          	lui	a1,0x4000
    8000103e:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80001040:	05b2                	slli	a1,a1,0xc
    80001042:	fffff097          	auipc	ra,0xfffff
    80001046:	6e8080e7          	jalr	1768(ra) # 8000072a <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    8000104a:	4681                	li	a3,0
    8000104c:	4605                	li	a2,1
    8000104e:	020005b7          	lui	a1,0x2000
    80001052:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80001054:	05b6                	slli	a1,a1,0xd
    80001056:	8526                	mv	a0,s1
    80001058:	fffff097          	auipc	ra,0xfffff
    8000105c:	6d2080e7          	jalr	1746(ra) # 8000072a <uvmunmap>
  uvmfree(pagetable, sz);
    80001060:	85ca                	mv	a1,s2
    80001062:	8526                	mv	a0,s1
    80001064:	00000097          	auipc	ra,0x0
    80001068:	9aa080e7          	jalr	-1622(ra) # 80000a0e <uvmfree>
}
    8000106c:	60e2                	ld	ra,24(sp)
    8000106e:	6442                	ld	s0,16(sp)
    80001070:	64a2                	ld	s1,8(sp)
    80001072:	6902                	ld	s2,0(sp)
    80001074:	6105                	addi	sp,sp,32
    80001076:	8082                	ret

0000000080001078 <freeproc>:
{
    80001078:	1101                	addi	sp,sp,-32
    8000107a:	ec06                	sd	ra,24(sp)
    8000107c:	e822                	sd	s0,16(sp)
    8000107e:	e426                	sd	s1,8(sp)
    80001080:	1000                	addi	s0,sp,32
    80001082:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001084:	6d28                	ld	a0,88(a0)
    80001086:	c509                	beqz	a0,80001090 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001088:	fffff097          	auipc	ra,0xfffff
    8000108c:	f94080e7          	jalr	-108(ra) # 8000001c <kfree>
  p->trapframe = 0;
    80001090:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001094:	68a8                	ld	a0,80(s1)
    80001096:	c511                	beqz	a0,800010a2 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001098:	64ac                	ld	a1,72(s1)
    8000109a:	00000097          	auipc	ra,0x0
    8000109e:	f8c080e7          	jalr	-116(ra) # 80001026 <proc_freepagetable>
  p->pagetable = 0;
    800010a2:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    800010a6:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    800010aa:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    800010ae:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    800010b2:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    800010b6:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    800010ba:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    800010be:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    800010c2:	0004ac23          	sw	zero,24(s1)
}
    800010c6:	60e2                	ld	ra,24(sp)
    800010c8:	6442                	ld	s0,16(sp)
    800010ca:	64a2                	ld	s1,8(sp)
    800010cc:	6105                	addi	sp,sp,32
    800010ce:	8082                	ret

00000000800010d0 <allocproc>:
{
    800010d0:	1101                	addi	sp,sp,-32
    800010d2:	ec06                	sd	ra,24(sp)
    800010d4:	e822                	sd	s0,16(sp)
    800010d6:	e426                	sd	s1,8(sp)
    800010d8:	e04a                	sd	s2,0(sp)
    800010da:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    800010dc:	0000b497          	auipc	s1,0xb
    800010e0:	3a448493          	addi	s1,s1,932 # 8000c480 <proc>
    800010e4:	0000c917          	auipc	s2,0xc
    800010e8:	1ac90913          	addi	s2,s2,428 # 8000d290 <tickslock>
    acquire(&p->lock);
    800010ec:	8526                	mv	a0,s1
    800010ee:	00005097          	auipc	ra,0x5
    800010f2:	150080e7          	jalr	336(ra) # 8000623e <acquire>
    if(p->state == UNUSED) {
    800010f6:	4c9c                	lw	a5,24(s1)
    800010f8:	c395                	beqz	a5,8000111c <allocproc+0x4c>
      release(&p->lock);
    800010fa:	8526                	mv	a0,s1
    800010fc:	00005097          	auipc	ra,0x5
    80001100:	1f2080e7          	jalr	498(ra) # 800062ee <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001104:	16848493          	addi	s1,s1,360
    80001108:	ff2492e3          	bne	s1,s2,800010ec <allocproc+0x1c>
  return 0;
    8000110c:	4481                	li	s1,0
}
    8000110e:	8526                	mv	a0,s1
    80001110:	60e2                	ld	ra,24(sp)
    80001112:	6442                	ld	s0,16(sp)
    80001114:	64a2                	ld	s1,8(sp)
    80001116:	6902                	ld	s2,0(sp)
    80001118:	6105                	addi	sp,sp,32
    8000111a:	8082                	ret
  p->pid = allocpid();
    8000111c:	00000097          	auipc	ra,0x0
    80001120:	e28080e7          	jalr	-472(ra) # 80000f44 <allocpid>
    80001124:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001126:	4785                	li	a5,1
    80001128:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000112a:	fffff097          	auipc	ra,0xfffff
    8000112e:	ff6080e7          	jalr	-10(ra) # 80000120 <kalloc>
    80001132:	892a                	mv	s2,a0
    80001134:	eca8                	sd	a0,88(s1)
    80001136:	cd05                	beqz	a0,8000116e <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    80001138:	8526                	mv	a0,s1
    8000113a:	00000097          	auipc	ra,0x0
    8000113e:	e50080e7          	jalr	-432(ra) # 80000f8a <proc_pagetable>
    80001142:	892a                	mv	s2,a0
    80001144:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001146:	c121                	beqz	a0,80001186 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001148:	07000613          	li	a2,112
    8000114c:	4581                	li	a1,0
    8000114e:	06048513          	addi	a0,s1,96
    80001152:	fffff097          	auipc	ra,0xfffff
    80001156:	038080e7          	jalr	56(ra) # 8000018a <memset>
  p->context.ra = (uint64)forkret;
    8000115a:	00000797          	auipc	a5,0x0
    8000115e:	da478793          	addi	a5,a5,-604 # 80000efe <forkret>
    80001162:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001164:	60bc                	ld	a5,64(s1)
    80001166:	6705                	lui	a4,0x1
    80001168:	97ba                	add	a5,a5,a4
    8000116a:	f4bc                	sd	a5,104(s1)
  return p;
    8000116c:	b74d                	j	8000110e <allocproc+0x3e>
    freeproc(p);
    8000116e:	8526                	mv	a0,s1
    80001170:	00000097          	auipc	ra,0x0
    80001174:	f08080e7          	jalr	-248(ra) # 80001078 <freeproc>
    release(&p->lock);
    80001178:	8526                	mv	a0,s1
    8000117a:	00005097          	auipc	ra,0x5
    8000117e:	174080e7          	jalr	372(ra) # 800062ee <release>
    return 0;
    80001182:	84ca                	mv	s1,s2
    80001184:	b769                	j	8000110e <allocproc+0x3e>
    freeproc(p);
    80001186:	8526                	mv	a0,s1
    80001188:	00000097          	auipc	ra,0x0
    8000118c:	ef0080e7          	jalr	-272(ra) # 80001078 <freeproc>
    release(&p->lock);
    80001190:	8526                	mv	a0,s1
    80001192:	00005097          	auipc	ra,0x5
    80001196:	15c080e7          	jalr	348(ra) # 800062ee <release>
    return 0;
    8000119a:	84ca                	mv	s1,s2
    8000119c:	bf8d                	j	8000110e <allocproc+0x3e>

000000008000119e <userinit>:
{
    8000119e:	1101                	addi	sp,sp,-32
    800011a0:	ec06                	sd	ra,24(sp)
    800011a2:	e822                	sd	s0,16(sp)
    800011a4:	e426                	sd	s1,8(sp)
    800011a6:	1000                	addi	s0,sp,32
  p = allocproc();
    800011a8:	00000097          	auipc	ra,0x0
    800011ac:	f28080e7          	jalr	-216(ra) # 800010d0 <allocproc>
    800011b0:	84aa                	mv	s1,a0
  initproc = p;
    800011b2:	0000b797          	auipc	a5,0xb
    800011b6:	e4a7bf23          	sd	a0,-418(a5) # 8000c010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    800011ba:	03400613          	li	a2,52
    800011be:	0000a597          	auipc	a1,0xa
    800011c2:	ec258593          	addi	a1,a1,-318 # 8000b080 <initcode>
    800011c6:	6928                	ld	a0,80(a0)
    800011c8:	fffff097          	auipc	ra,0xfffff
    800011cc:	664080e7          	jalr	1636(ra) # 8000082c <uvminit>
  p->sz = PGSIZE;
    800011d0:	6785                	lui	a5,0x1
    800011d2:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    800011d4:	6cb8                	ld	a4,88(s1)
    800011d6:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    800011da:	6cb8                	ld	a4,88(s1)
    800011dc:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    800011de:	4641                	li	a2,16
    800011e0:	00007597          	auipc	a1,0x7
    800011e4:	fa058593          	addi	a1,a1,-96 # 80008180 <etext+0x180>
    800011e8:	15848513          	addi	a0,s1,344
    800011ec:	fffff097          	auipc	ra,0xfffff
    800011f0:	0f6080e7          	jalr	246(ra) # 800002e2 <safestrcpy>
  p->cwd = namei("/");
    800011f4:	00007517          	auipc	a0,0x7
    800011f8:	f9c50513          	addi	a0,a0,-100 # 80008190 <etext+0x190>
    800011fc:	00002097          	auipc	ra,0x2
    80001200:	0c8080e7          	jalr	200(ra) # 800032c4 <namei>
    80001204:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001208:	478d                	li	a5,3
    8000120a:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000120c:	8526                	mv	a0,s1
    8000120e:	00005097          	auipc	ra,0x5
    80001212:	0e0080e7          	jalr	224(ra) # 800062ee <release>
}
    80001216:	60e2                	ld	ra,24(sp)
    80001218:	6442                	ld	s0,16(sp)
    8000121a:	64a2                	ld	s1,8(sp)
    8000121c:	6105                	addi	sp,sp,32
    8000121e:	8082                	ret

0000000080001220 <growproc>:
{
    80001220:	1101                	addi	sp,sp,-32
    80001222:	ec06                	sd	ra,24(sp)
    80001224:	e822                	sd	s0,16(sp)
    80001226:	e426                	sd	s1,8(sp)
    80001228:	e04a                	sd	s2,0(sp)
    8000122a:	1000                	addi	s0,sp,32
    8000122c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000122e:	00000097          	auipc	ra,0x0
    80001232:	c96080e7          	jalr	-874(ra) # 80000ec4 <myproc>
    80001236:	892a                	mv	s2,a0
  sz = p->sz;
    80001238:	652c                	ld	a1,72(a0)
    8000123a:	0005879b          	sext.w	a5,a1
  if(n > 0){
    8000123e:	00904f63          	bgtz	s1,8000125c <growproc+0x3c>
  } else if(n < 0){
    80001242:	0204cd63          	bltz	s1,8000127c <growproc+0x5c>
  p->sz = sz;
    80001246:	1782                	slli	a5,a5,0x20
    80001248:	9381                	srli	a5,a5,0x20
    8000124a:	04f93423          	sd	a5,72(s2)
  return 0;
    8000124e:	4501                	li	a0,0
}
    80001250:	60e2                	ld	ra,24(sp)
    80001252:	6442                	ld	s0,16(sp)
    80001254:	64a2                	ld	s1,8(sp)
    80001256:	6902                	ld	s2,0(sp)
    80001258:	6105                	addi	sp,sp,32
    8000125a:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    8000125c:	00f4863b          	addw	a2,s1,a5
    80001260:	1602                	slli	a2,a2,0x20
    80001262:	9201                	srli	a2,a2,0x20
    80001264:	1582                	slli	a1,a1,0x20
    80001266:	9181                	srli	a1,a1,0x20
    80001268:	6928                	ld	a0,80(a0)
    8000126a:	fffff097          	auipc	ra,0xfffff
    8000126e:	67c080e7          	jalr	1660(ra) # 800008e6 <uvmalloc>
    80001272:	0005079b          	sext.w	a5,a0
    80001276:	fbe1                	bnez	a5,80001246 <growproc+0x26>
      return -1;
    80001278:	557d                	li	a0,-1
    8000127a:	bfd9                	j	80001250 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    8000127c:	00f4863b          	addw	a2,s1,a5
    80001280:	1602                	slli	a2,a2,0x20
    80001282:	9201                	srli	a2,a2,0x20
    80001284:	1582                	slli	a1,a1,0x20
    80001286:	9181                	srli	a1,a1,0x20
    80001288:	6928                	ld	a0,80(a0)
    8000128a:	fffff097          	auipc	ra,0xfffff
    8000128e:	614080e7          	jalr	1556(ra) # 8000089e <uvmdealloc>
    80001292:	0005079b          	sext.w	a5,a0
    80001296:	bf45                	j	80001246 <growproc+0x26>

0000000080001298 <fork>:
{
    80001298:	7139                	addi	sp,sp,-64
    8000129a:	fc06                	sd	ra,56(sp)
    8000129c:	f822                	sd	s0,48(sp)
    8000129e:	f426                	sd	s1,40(sp)
    800012a0:	e456                	sd	s5,8(sp)
    800012a2:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    800012a4:	00000097          	auipc	ra,0x0
    800012a8:	c20080e7          	jalr	-992(ra) # 80000ec4 <myproc>
    800012ac:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    800012ae:	00000097          	auipc	ra,0x0
    800012b2:	e22080e7          	jalr	-478(ra) # 800010d0 <allocproc>
    800012b6:	12050063          	beqz	a0,800013d6 <fork+0x13e>
    800012ba:	e852                	sd	s4,16(sp)
    800012bc:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800012be:	048ab603          	ld	a2,72(s5)
    800012c2:	692c                	ld	a1,80(a0)
    800012c4:	050ab503          	ld	a0,80(s5)
    800012c8:	fffff097          	auipc	ra,0xfffff
    800012cc:	780080e7          	jalr	1920(ra) # 80000a48 <uvmcopy>
    800012d0:	04054863          	bltz	a0,80001320 <fork+0x88>
    800012d4:	f04a                	sd	s2,32(sp)
    800012d6:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    800012d8:	048ab783          	ld	a5,72(s5)
    800012dc:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    800012e0:	058ab683          	ld	a3,88(s5)
    800012e4:	87b6                	mv	a5,a3
    800012e6:	058a3703          	ld	a4,88(s4)
    800012ea:	12068693          	addi	a3,a3,288
    800012ee:	6388                	ld	a0,0(a5)
    800012f0:	678c                	ld	a1,8(a5)
    800012f2:	6b90                	ld	a2,16(a5)
    800012f4:	e308                	sd	a0,0(a4)
    800012f6:	e70c                	sd	a1,8(a4)
    800012f8:	eb10                	sd	a2,16(a4)
    800012fa:	6f90                	ld	a2,24(a5)
    800012fc:	ef10                	sd	a2,24(a4)
    800012fe:	02078793          	addi	a5,a5,32 # 1020 <_entry-0x7fffefe0>
    80001302:	02070713          	addi	a4,a4,32
    80001306:	fed794e3          	bne	a5,a3,800012ee <fork+0x56>
  np->trapframe->a0 = 0;
    8000130a:	058a3783          	ld	a5,88(s4)
    8000130e:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001312:	0d0a8493          	addi	s1,s5,208
    80001316:	0d0a0913          	addi	s2,s4,208
    8000131a:	150a8993          	addi	s3,s5,336
    8000131e:	a015                	j	80001342 <fork+0xaa>
    freeproc(np);
    80001320:	8552                	mv	a0,s4
    80001322:	00000097          	auipc	ra,0x0
    80001326:	d56080e7          	jalr	-682(ra) # 80001078 <freeproc>
    release(&np->lock);
    8000132a:	8552                	mv	a0,s4
    8000132c:	00005097          	auipc	ra,0x5
    80001330:	fc2080e7          	jalr	-62(ra) # 800062ee <release>
    return -1;
    80001334:	54fd                	li	s1,-1
    80001336:	6a42                	ld	s4,16(sp)
    80001338:	a841                	j	800013c8 <fork+0x130>
  for(i = 0; i < NOFILE; i++)
    8000133a:	04a1                	addi	s1,s1,8
    8000133c:	0921                	addi	s2,s2,8
    8000133e:	01348b63          	beq	s1,s3,80001354 <fork+0xbc>
    if(p->ofile[i])
    80001342:	6088                	ld	a0,0(s1)
    80001344:	d97d                	beqz	a0,8000133a <fork+0xa2>
      np->ofile[i] = filedup(p->ofile[i]);
    80001346:	00002097          	auipc	ra,0x2
    8000134a:	614080e7          	jalr	1556(ra) # 8000395a <filedup>
    8000134e:	00a93023          	sd	a0,0(s2)
    80001352:	b7e5                	j	8000133a <fork+0xa2>
  np->cwd = idup(p->cwd);
    80001354:	150ab503          	ld	a0,336(s5)
    80001358:	00001097          	auipc	ra,0x1
    8000135c:	73c080e7          	jalr	1852(ra) # 80002a94 <idup>
    80001360:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001364:	4641                	li	a2,16
    80001366:	158a8593          	addi	a1,s5,344
    8000136a:	158a0513          	addi	a0,s4,344
    8000136e:	fffff097          	auipc	ra,0xfffff
    80001372:	f74080e7          	jalr	-140(ra) # 800002e2 <safestrcpy>
  pid = np->pid;
    80001376:	030a2483          	lw	s1,48(s4)
  release(&np->lock);
    8000137a:	8552                	mv	a0,s4
    8000137c:	00005097          	auipc	ra,0x5
    80001380:	f72080e7          	jalr	-142(ra) # 800062ee <release>
  acquire(&wait_lock);
    80001384:	0000b517          	auipc	a0,0xb
    80001388:	ce450513          	addi	a0,a0,-796 # 8000c068 <wait_lock>
    8000138c:	00005097          	auipc	ra,0x5
    80001390:	eb2080e7          	jalr	-334(ra) # 8000623e <acquire>
  np->parent = p;
    80001394:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001398:	0000b517          	auipc	a0,0xb
    8000139c:	cd050513          	addi	a0,a0,-816 # 8000c068 <wait_lock>
    800013a0:	00005097          	auipc	ra,0x5
    800013a4:	f4e080e7          	jalr	-178(ra) # 800062ee <release>
  acquire(&np->lock);
    800013a8:	8552                	mv	a0,s4
    800013aa:	00005097          	auipc	ra,0x5
    800013ae:	e94080e7          	jalr	-364(ra) # 8000623e <acquire>
  np->state = RUNNABLE;
    800013b2:	478d                	li	a5,3
    800013b4:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    800013b8:	8552                	mv	a0,s4
    800013ba:	00005097          	auipc	ra,0x5
    800013be:	f34080e7          	jalr	-204(ra) # 800062ee <release>
  return pid;
    800013c2:	7902                	ld	s2,32(sp)
    800013c4:	69e2                	ld	s3,24(sp)
    800013c6:	6a42                	ld	s4,16(sp)
}
    800013c8:	8526                	mv	a0,s1
    800013ca:	70e2                	ld	ra,56(sp)
    800013cc:	7442                	ld	s0,48(sp)
    800013ce:	74a2                	ld	s1,40(sp)
    800013d0:	6aa2                	ld	s5,8(sp)
    800013d2:	6121                	addi	sp,sp,64
    800013d4:	8082                	ret
    return -1;
    800013d6:	54fd                	li	s1,-1
    800013d8:	bfc5                	j	800013c8 <fork+0x130>

00000000800013da <scheduler>:
{
    800013da:	7139                	addi	sp,sp,-64
    800013dc:	fc06                	sd	ra,56(sp)
    800013de:	f822                	sd	s0,48(sp)
    800013e0:	f426                	sd	s1,40(sp)
    800013e2:	f04a                	sd	s2,32(sp)
    800013e4:	ec4e                	sd	s3,24(sp)
    800013e6:	e852                	sd	s4,16(sp)
    800013e8:	e456                	sd	s5,8(sp)
    800013ea:	e05a                	sd	s6,0(sp)
    800013ec:	0080                	addi	s0,sp,64
    800013ee:	8792                	mv	a5,tp
  int id = r_tp();
    800013f0:	2781                	sext.w	a5,a5
  c->proc = 0;
    800013f2:	00779a93          	slli	s5,a5,0x7
    800013f6:	0000b717          	auipc	a4,0xb
    800013fa:	c5a70713          	addi	a4,a4,-934 # 8000c050 <pid_lock>
    800013fe:	9756                	add	a4,a4,s5
    80001400:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001404:	0000b717          	auipc	a4,0xb
    80001408:	c8470713          	addi	a4,a4,-892 # 8000c088 <cpus+0x8>
    8000140c:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    8000140e:	498d                	li	s3,3
        p->state = RUNNING;
    80001410:	4b11                	li	s6,4
        c->proc = p;
    80001412:	079e                	slli	a5,a5,0x7
    80001414:	0000ba17          	auipc	s4,0xb
    80001418:	c3ca0a13          	addi	s4,s4,-964 # 8000c050 <pid_lock>
    8000141c:	9a3e                	add	s4,s4,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000141e:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001422:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001426:	10079073          	csrw	sstatus,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    8000142a:	0000b497          	auipc	s1,0xb
    8000142e:	05648493          	addi	s1,s1,86 # 8000c480 <proc>
    80001432:	0000c917          	auipc	s2,0xc
    80001436:	e5e90913          	addi	s2,s2,-418 # 8000d290 <tickslock>
    8000143a:	a811                	j	8000144e <scheduler+0x74>
      release(&p->lock);
    8000143c:	8526                	mv	a0,s1
    8000143e:	00005097          	auipc	ra,0x5
    80001442:	eb0080e7          	jalr	-336(ra) # 800062ee <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001446:	16848493          	addi	s1,s1,360
    8000144a:	fd248ae3          	beq	s1,s2,8000141e <scheduler+0x44>
      acquire(&p->lock);
    8000144e:	8526                	mv	a0,s1
    80001450:	00005097          	auipc	ra,0x5
    80001454:	dee080e7          	jalr	-530(ra) # 8000623e <acquire>
      if(p->state == RUNNABLE) {
    80001458:	4c9c                	lw	a5,24(s1)
    8000145a:	ff3791e3          	bne	a5,s3,8000143c <scheduler+0x62>
        p->state = RUNNING;
    8000145e:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001462:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80001466:	06048593          	addi	a1,s1,96
    8000146a:	8556                	mv	a0,s5
    8000146c:	00000097          	auipc	ra,0x0
    80001470:	61a080e7          	jalr	1562(ra) # 80001a86 <swtch>
        c->proc = 0;
    80001474:	020a3823          	sd	zero,48(s4)
    80001478:	b7d1                	j	8000143c <scheduler+0x62>

000000008000147a <sched>:
{
    8000147a:	7179                	addi	sp,sp,-48
    8000147c:	f406                	sd	ra,40(sp)
    8000147e:	f022                	sd	s0,32(sp)
    80001480:	ec26                	sd	s1,24(sp)
    80001482:	e84a                	sd	s2,16(sp)
    80001484:	e44e                	sd	s3,8(sp)
    80001486:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001488:	00000097          	auipc	ra,0x0
    8000148c:	a3c080e7          	jalr	-1476(ra) # 80000ec4 <myproc>
    80001490:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001492:	00005097          	auipc	ra,0x5
    80001496:	d2c080e7          	jalr	-724(ra) # 800061be <holding>
    8000149a:	cd25                	beqz	a0,80001512 <sched+0x98>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000149c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000149e:	2781                	sext.w	a5,a5
    800014a0:	079e                	slli	a5,a5,0x7
    800014a2:	0000b717          	auipc	a4,0xb
    800014a6:	bae70713          	addi	a4,a4,-1106 # 8000c050 <pid_lock>
    800014aa:	97ba                	add	a5,a5,a4
    800014ac:	0a87a703          	lw	a4,168(a5)
    800014b0:	4785                	li	a5,1
    800014b2:	06f71863          	bne	a4,a5,80001522 <sched+0xa8>
  if(p->state == RUNNING)
    800014b6:	4c98                	lw	a4,24(s1)
    800014b8:	4791                	li	a5,4
    800014ba:	06f70c63          	beq	a4,a5,80001532 <sched+0xb8>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800014be:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800014c2:	8b89                	andi	a5,a5,2
  if(intr_get())
    800014c4:	efbd                	bnez	a5,80001542 <sched+0xc8>
  asm volatile("mv %0, tp" : "=r" (x) );
    800014c6:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800014c8:	0000b917          	auipc	s2,0xb
    800014cc:	b8890913          	addi	s2,s2,-1144 # 8000c050 <pid_lock>
    800014d0:	2781                	sext.w	a5,a5
    800014d2:	079e                	slli	a5,a5,0x7
    800014d4:	97ca                	add	a5,a5,s2
    800014d6:	0ac7a983          	lw	s3,172(a5)
    800014da:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800014dc:	2781                	sext.w	a5,a5
    800014de:	079e                	slli	a5,a5,0x7
    800014e0:	07a1                	addi	a5,a5,8
    800014e2:	0000b597          	auipc	a1,0xb
    800014e6:	b9e58593          	addi	a1,a1,-1122 # 8000c080 <cpus>
    800014ea:	95be                	add	a1,a1,a5
    800014ec:	06048513          	addi	a0,s1,96
    800014f0:	00000097          	auipc	ra,0x0
    800014f4:	596080e7          	jalr	1430(ra) # 80001a86 <swtch>
    800014f8:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800014fa:	2781                	sext.w	a5,a5
    800014fc:	079e                	slli	a5,a5,0x7
    800014fe:	993e                	add	s2,s2,a5
    80001500:	0b392623          	sw	s3,172(s2)
}
    80001504:	70a2                	ld	ra,40(sp)
    80001506:	7402                	ld	s0,32(sp)
    80001508:	64e2                	ld	s1,24(sp)
    8000150a:	6942                	ld	s2,16(sp)
    8000150c:	69a2                	ld	s3,8(sp)
    8000150e:	6145                	addi	sp,sp,48
    80001510:	8082                	ret
    panic("sched p->lock");
    80001512:	00007517          	auipc	a0,0x7
    80001516:	c8650513          	addi	a0,a0,-890 # 80008198 <etext+0x198>
    8000151a:	00004097          	auipc	ra,0x4
    8000151e:	794080e7          	jalr	1940(ra) # 80005cae <panic>
    panic("sched locks");
    80001522:	00007517          	auipc	a0,0x7
    80001526:	c8650513          	addi	a0,a0,-890 # 800081a8 <etext+0x1a8>
    8000152a:	00004097          	auipc	ra,0x4
    8000152e:	784080e7          	jalr	1924(ra) # 80005cae <panic>
    panic("sched running");
    80001532:	00007517          	auipc	a0,0x7
    80001536:	c8650513          	addi	a0,a0,-890 # 800081b8 <etext+0x1b8>
    8000153a:	00004097          	auipc	ra,0x4
    8000153e:	774080e7          	jalr	1908(ra) # 80005cae <panic>
    panic("sched interruptible");
    80001542:	00007517          	auipc	a0,0x7
    80001546:	c8650513          	addi	a0,a0,-890 # 800081c8 <etext+0x1c8>
    8000154a:	00004097          	auipc	ra,0x4
    8000154e:	764080e7          	jalr	1892(ra) # 80005cae <panic>

0000000080001552 <yield>:
{
    80001552:	1101                	addi	sp,sp,-32
    80001554:	ec06                	sd	ra,24(sp)
    80001556:	e822                	sd	s0,16(sp)
    80001558:	e426                	sd	s1,8(sp)
    8000155a:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    8000155c:	00000097          	auipc	ra,0x0
    80001560:	968080e7          	jalr	-1688(ra) # 80000ec4 <myproc>
    80001564:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001566:	00005097          	auipc	ra,0x5
    8000156a:	cd8080e7          	jalr	-808(ra) # 8000623e <acquire>
  p->state = RUNNABLE;
    8000156e:	478d                	li	a5,3
    80001570:	cc9c                	sw	a5,24(s1)
  sched();
    80001572:	00000097          	auipc	ra,0x0
    80001576:	f08080e7          	jalr	-248(ra) # 8000147a <sched>
  release(&p->lock);
    8000157a:	8526                	mv	a0,s1
    8000157c:	00005097          	auipc	ra,0x5
    80001580:	d72080e7          	jalr	-654(ra) # 800062ee <release>
}
    80001584:	60e2                	ld	ra,24(sp)
    80001586:	6442                	ld	s0,16(sp)
    80001588:	64a2                	ld	s1,8(sp)
    8000158a:	6105                	addi	sp,sp,32
    8000158c:	8082                	ret

000000008000158e <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    8000158e:	7179                	addi	sp,sp,-48
    80001590:	f406                	sd	ra,40(sp)
    80001592:	f022                	sd	s0,32(sp)
    80001594:	ec26                	sd	s1,24(sp)
    80001596:	e84a                	sd	s2,16(sp)
    80001598:	e44e                	sd	s3,8(sp)
    8000159a:	1800                	addi	s0,sp,48
    8000159c:	89aa                	mv	s3,a0
    8000159e:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800015a0:	00000097          	auipc	ra,0x0
    800015a4:	924080e7          	jalr	-1756(ra) # 80000ec4 <myproc>
    800015a8:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800015aa:	00005097          	auipc	ra,0x5
    800015ae:	c94080e7          	jalr	-876(ra) # 8000623e <acquire>
  release(lk);
    800015b2:	854a                	mv	a0,s2
    800015b4:	00005097          	auipc	ra,0x5
    800015b8:	d3a080e7          	jalr	-710(ra) # 800062ee <release>

  // Go to sleep.
  p->chan = chan;
    800015bc:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    800015c0:	4789                	li	a5,2
    800015c2:	cc9c                	sw	a5,24(s1)

  sched();
    800015c4:	00000097          	auipc	ra,0x0
    800015c8:	eb6080e7          	jalr	-330(ra) # 8000147a <sched>

  // Tidy up.
  p->chan = 0;
    800015cc:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    800015d0:	8526                	mv	a0,s1
    800015d2:	00005097          	auipc	ra,0x5
    800015d6:	d1c080e7          	jalr	-740(ra) # 800062ee <release>
  acquire(lk);
    800015da:	854a                	mv	a0,s2
    800015dc:	00005097          	auipc	ra,0x5
    800015e0:	c62080e7          	jalr	-926(ra) # 8000623e <acquire>
}
    800015e4:	70a2                	ld	ra,40(sp)
    800015e6:	7402                	ld	s0,32(sp)
    800015e8:	64e2                	ld	s1,24(sp)
    800015ea:	6942                	ld	s2,16(sp)
    800015ec:	69a2                	ld	s3,8(sp)
    800015ee:	6145                	addi	sp,sp,48
    800015f0:	8082                	ret

00000000800015f2 <wait>:
{
    800015f2:	715d                	addi	sp,sp,-80
    800015f4:	e486                	sd	ra,72(sp)
    800015f6:	e0a2                	sd	s0,64(sp)
    800015f8:	fc26                	sd	s1,56(sp)
    800015fa:	f84a                	sd	s2,48(sp)
    800015fc:	f44e                	sd	s3,40(sp)
    800015fe:	f052                	sd	s4,32(sp)
    80001600:	ec56                	sd	s5,24(sp)
    80001602:	e85a                	sd	s6,16(sp)
    80001604:	e45e                	sd	s7,8(sp)
    80001606:	0880                	addi	s0,sp,80
    80001608:	8baa                	mv	s7,a0
  struct proc *p = myproc();
    8000160a:	00000097          	auipc	ra,0x0
    8000160e:	8ba080e7          	jalr	-1862(ra) # 80000ec4 <myproc>
    80001612:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001614:	0000b517          	auipc	a0,0xb
    80001618:	a5450513          	addi	a0,a0,-1452 # 8000c068 <wait_lock>
    8000161c:	00005097          	auipc	ra,0x5
    80001620:	c22080e7          	jalr	-990(ra) # 8000623e <acquire>
        if(np->state == ZOMBIE){
    80001624:	4a15                	li	s4,5
        havekids = 1;
    80001626:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    80001628:	0000c997          	auipc	s3,0xc
    8000162c:	c6898993          	addi	s3,s3,-920 # 8000d290 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001630:	0000bb17          	auipc	s6,0xb
    80001634:	a38b0b13          	addi	s6,s6,-1480 # 8000c068 <wait_lock>
    80001638:	a875                	j	800016f4 <wait+0x102>
          pid = np->pid;
    8000163a:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    8000163e:	000b8e63          	beqz	s7,8000165a <wait+0x68>
    80001642:	4691                	li	a3,4
    80001644:	02c48613          	addi	a2,s1,44
    80001648:	85de                	mv	a1,s7
    8000164a:	05093503          	ld	a0,80(s2)
    8000164e:	fffff097          	auipc	ra,0xfffff
    80001652:	4fa080e7          	jalr	1274(ra) # 80000b48 <copyout>
    80001656:	04054063          	bltz	a0,80001696 <wait+0xa4>
          freeproc(np);
    8000165a:	8526                	mv	a0,s1
    8000165c:	00000097          	auipc	ra,0x0
    80001660:	a1c080e7          	jalr	-1508(ra) # 80001078 <freeproc>
          release(&np->lock);
    80001664:	8526                	mv	a0,s1
    80001666:	00005097          	auipc	ra,0x5
    8000166a:	c88080e7          	jalr	-888(ra) # 800062ee <release>
          release(&wait_lock);
    8000166e:	0000b517          	auipc	a0,0xb
    80001672:	9fa50513          	addi	a0,a0,-1542 # 8000c068 <wait_lock>
    80001676:	00005097          	auipc	ra,0x5
    8000167a:	c78080e7          	jalr	-904(ra) # 800062ee <release>
}
    8000167e:	854e                	mv	a0,s3
    80001680:	60a6                	ld	ra,72(sp)
    80001682:	6406                	ld	s0,64(sp)
    80001684:	74e2                	ld	s1,56(sp)
    80001686:	7942                	ld	s2,48(sp)
    80001688:	79a2                	ld	s3,40(sp)
    8000168a:	7a02                	ld	s4,32(sp)
    8000168c:	6ae2                	ld	s5,24(sp)
    8000168e:	6b42                	ld	s6,16(sp)
    80001690:	6ba2                	ld	s7,8(sp)
    80001692:	6161                	addi	sp,sp,80
    80001694:	8082                	ret
            release(&np->lock);
    80001696:	8526                	mv	a0,s1
    80001698:	00005097          	auipc	ra,0x5
    8000169c:	c56080e7          	jalr	-938(ra) # 800062ee <release>
            release(&wait_lock);
    800016a0:	0000b517          	auipc	a0,0xb
    800016a4:	9c850513          	addi	a0,a0,-1592 # 8000c068 <wait_lock>
    800016a8:	00005097          	auipc	ra,0x5
    800016ac:	c46080e7          	jalr	-954(ra) # 800062ee <release>
            return -1;
    800016b0:	59fd                	li	s3,-1
    800016b2:	b7f1                	j	8000167e <wait+0x8c>
    for(np = proc; np < &proc[NPROC]; np++){
    800016b4:	16848493          	addi	s1,s1,360
    800016b8:	03348463          	beq	s1,s3,800016e0 <wait+0xee>
      if(np->parent == p){
    800016bc:	7c9c                	ld	a5,56(s1)
    800016be:	ff279be3          	bne	a5,s2,800016b4 <wait+0xc2>
        acquire(&np->lock);
    800016c2:	8526                	mv	a0,s1
    800016c4:	00005097          	auipc	ra,0x5
    800016c8:	b7a080e7          	jalr	-1158(ra) # 8000623e <acquire>
        if(np->state == ZOMBIE){
    800016cc:	4c9c                	lw	a5,24(s1)
    800016ce:	f74786e3          	beq	a5,s4,8000163a <wait+0x48>
        release(&np->lock);
    800016d2:	8526                	mv	a0,s1
    800016d4:	00005097          	auipc	ra,0x5
    800016d8:	c1a080e7          	jalr	-998(ra) # 800062ee <release>
        havekids = 1;
    800016dc:	8756                	mv	a4,s5
    800016de:	bfd9                	j	800016b4 <wait+0xc2>
    if(!havekids || p->killed){
    800016e0:	c305                	beqz	a4,80001700 <wait+0x10e>
    800016e2:	02892783          	lw	a5,40(s2)
    800016e6:	ef89                	bnez	a5,80001700 <wait+0x10e>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800016e8:	85da                	mv	a1,s6
    800016ea:	854a                	mv	a0,s2
    800016ec:	00000097          	auipc	ra,0x0
    800016f0:	ea2080e7          	jalr	-350(ra) # 8000158e <sleep>
    havekids = 0;
    800016f4:	4701                	li	a4,0
    for(np = proc; np < &proc[NPROC]; np++){
    800016f6:	0000b497          	auipc	s1,0xb
    800016fa:	d8a48493          	addi	s1,s1,-630 # 8000c480 <proc>
    800016fe:	bf7d                	j	800016bc <wait+0xca>
      release(&wait_lock);
    80001700:	0000b517          	auipc	a0,0xb
    80001704:	96850513          	addi	a0,a0,-1688 # 8000c068 <wait_lock>
    80001708:	00005097          	auipc	ra,0x5
    8000170c:	be6080e7          	jalr	-1050(ra) # 800062ee <release>
      return -1;
    80001710:	59fd                	li	s3,-1
    80001712:	b7b5                	j	8000167e <wait+0x8c>

0000000080001714 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001714:	7179                	addi	sp,sp,-48
    80001716:	f406                	sd	ra,40(sp)
    80001718:	f022                	sd	s0,32(sp)
    8000171a:	ec26                	sd	s1,24(sp)
    8000171c:	e84a                	sd	s2,16(sp)
    8000171e:	e44e                	sd	s3,8(sp)
    80001720:	e052                	sd	s4,0(sp)
    80001722:	1800                	addi	s0,sp,48
    80001724:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001726:	0000b497          	auipc	s1,0xb
    8000172a:	d5a48493          	addi	s1,s1,-678 # 8000c480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000172e:	4989                	li	s3,2
  for(p = proc; p < &proc[NPROC]; p++) {
    80001730:	0000c917          	auipc	s2,0xc
    80001734:	b6090913          	addi	s2,s2,-1184 # 8000d290 <tickslock>
    80001738:	a811                	j	8000174c <wakeup+0x38>
        p->state = RUNNABLE;
      }
      release(&p->lock);
    8000173a:	8526                	mv	a0,s1
    8000173c:	00005097          	auipc	ra,0x5
    80001740:	bb2080e7          	jalr	-1102(ra) # 800062ee <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001744:	16848493          	addi	s1,s1,360
    80001748:	03248663          	beq	s1,s2,80001774 <wakeup+0x60>
    if(p != myproc()){
    8000174c:	fffff097          	auipc	ra,0xfffff
    80001750:	778080e7          	jalr	1912(ra) # 80000ec4 <myproc>
    80001754:	fe9508e3          	beq	a0,s1,80001744 <wakeup+0x30>
      acquire(&p->lock);
    80001758:	8526                	mv	a0,s1
    8000175a:	00005097          	auipc	ra,0x5
    8000175e:	ae4080e7          	jalr	-1308(ra) # 8000623e <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80001762:	4c9c                	lw	a5,24(s1)
    80001764:	fd379be3          	bne	a5,s3,8000173a <wakeup+0x26>
    80001768:	709c                	ld	a5,32(s1)
    8000176a:	fd4798e3          	bne	a5,s4,8000173a <wakeup+0x26>
        p->state = RUNNABLE;
    8000176e:	478d                	li	a5,3
    80001770:	cc9c                	sw	a5,24(s1)
    80001772:	b7e1                	j	8000173a <wakeup+0x26>
    }
  }
}
    80001774:	70a2                	ld	ra,40(sp)
    80001776:	7402                	ld	s0,32(sp)
    80001778:	64e2                	ld	s1,24(sp)
    8000177a:	6942                	ld	s2,16(sp)
    8000177c:	69a2                	ld	s3,8(sp)
    8000177e:	6a02                	ld	s4,0(sp)
    80001780:	6145                	addi	sp,sp,48
    80001782:	8082                	ret

0000000080001784 <reparent>:
{
    80001784:	7179                	addi	sp,sp,-48
    80001786:	f406                	sd	ra,40(sp)
    80001788:	f022                	sd	s0,32(sp)
    8000178a:	ec26                	sd	s1,24(sp)
    8000178c:	e84a                	sd	s2,16(sp)
    8000178e:	e44e                	sd	s3,8(sp)
    80001790:	e052                	sd	s4,0(sp)
    80001792:	1800                	addi	s0,sp,48
    80001794:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001796:	0000b497          	auipc	s1,0xb
    8000179a:	cea48493          	addi	s1,s1,-790 # 8000c480 <proc>
      pp->parent = initproc;
    8000179e:	0000ba17          	auipc	s4,0xb
    800017a2:	872a0a13          	addi	s4,s4,-1934 # 8000c010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800017a6:	0000c997          	auipc	s3,0xc
    800017aa:	aea98993          	addi	s3,s3,-1302 # 8000d290 <tickslock>
    800017ae:	a029                	j	800017b8 <reparent+0x34>
    800017b0:	16848493          	addi	s1,s1,360
    800017b4:	01348d63          	beq	s1,s3,800017ce <reparent+0x4a>
    if(pp->parent == p){
    800017b8:	7c9c                	ld	a5,56(s1)
    800017ba:	ff279be3          	bne	a5,s2,800017b0 <reparent+0x2c>
      pp->parent = initproc;
    800017be:	000a3503          	ld	a0,0(s4)
    800017c2:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    800017c4:	00000097          	auipc	ra,0x0
    800017c8:	f50080e7          	jalr	-176(ra) # 80001714 <wakeup>
    800017cc:	b7d5                	j	800017b0 <reparent+0x2c>
}
    800017ce:	70a2                	ld	ra,40(sp)
    800017d0:	7402                	ld	s0,32(sp)
    800017d2:	64e2                	ld	s1,24(sp)
    800017d4:	6942                	ld	s2,16(sp)
    800017d6:	69a2                	ld	s3,8(sp)
    800017d8:	6a02                	ld	s4,0(sp)
    800017da:	6145                	addi	sp,sp,48
    800017dc:	8082                	ret

00000000800017de <exit>:
{
    800017de:	7179                	addi	sp,sp,-48
    800017e0:	f406                	sd	ra,40(sp)
    800017e2:	f022                	sd	s0,32(sp)
    800017e4:	ec26                	sd	s1,24(sp)
    800017e6:	e84a                	sd	s2,16(sp)
    800017e8:	e44e                	sd	s3,8(sp)
    800017ea:	e052                	sd	s4,0(sp)
    800017ec:	1800                	addi	s0,sp,48
    800017ee:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    800017f0:	fffff097          	auipc	ra,0xfffff
    800017f4:	6d4080e7          	jalr	1748(ra) # 80000ec4 <myproc>
    800017f8:	89aa                	mv	s3,a0
  if(p == initproc)
    800017fa:	0000b797          	auipc	a5,0xb
    800017fe:	8167b783          	ld	a5,-2026(a5) # 8000c010 <initproc>
    80001802:	0d050493          	addi	s1,a0,208
    80001806:	15050913          	addi	s2,a0,336
    8000180a:	00a79d63          	bne	a5,a0,80001824 <exit+0x46>
    panic("init exiting");
    8000180e:	00007517          	auipc	a0,0x7
    80001812:	9d250513          	addi	a0,a0,-1582 # 800081e0 <etext+0x1e0>
    80001816:	00004097          	auipc	ra,0x4
    8000181a:	498080e7          	jalr	1176(ra) # 80005cae <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    8000181e:	04a1                	addi	s1,s1,8
    80001820:	01248b63          	beq	s1,s2,80001836 <exit+0x58>
    if(p->ofile[fd]){
    80001824:	6088                	ld	a0,0(s1)
    80001826:	dd65                	beqz	a0,8000181e <exit+0x40>
      fileclose(f);
    80001828:	00002097          	auipc	ra,0x2
    8000182c:	184080e7          	jalr	388(ra) # 800039ac <fileclose>
      p->ofile[fd] = 0;
    80001830:	0004b023          	sd	zero,0(s1)
    80001834:	b7ed                	j	8000181e <exit+0x40>
  begin_op();
    80001836:	00002097          	auipc	ra,0x2
    8000183a:	c94080e7          	jalr	-876(ra) # 800034ca <begin_op>
  iput(p->cwd);
    8000183e:	1509b503          	ld	a0,336(s3)
    80001842:	00001097          	auipc	ra,0x1
    80001846:	44e080e7          	jalr	1102(ra) # 80002c90 <iput>
  end_op();
    8000184a:	00002097          	auipc	ra,0x2
    8000184e:	d00080e7          	jalr	-768(ra) # 8000354a <end_op>
  p->cwd = 0;
    80001852:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    80001856:	0000b517          	auipc	a0,0xb
    8000185a:	81250513          	addi	a0,a0,-2030 # 8000c068 <wait_lock>
    8000185e:	00005097          	auipc	ra,0x5
    80001862:	9e0080e7          	jalr	-1568(ra) # 8000623e <acquire>
  reparent(p);
    80001866:	854e                	mv	a0,s3
    80001868:	00000097          	auipc	ra,0x0
    8000186c:	f1c080e7          	jalr	-228(ra) # 80001784 <reparent>
  wakeup(p->parent);
    80001870:	0389b503          	ld	a0,56(s3)
    80001874:	00000097          	auipc	ra,0x0
    80001878:	ea0080e7          	jalr	-352(ra) # 80001714 <wakeup>
  acquire(&p->lock);
    8000187c:	854e                	mv	a0,s3
    8000187e:	00005097          	auipc	ra,0x5
    80001882:	9c0080e7          	jalr	-1600(ra) # 8000623e <acquire>
  p->xstate = status;
    80001886:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    8000188a:	4795                	li	a5,5
    8000188c:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001890:	0000a517          	auipc	a0,0xa
    80001894:	7d850513          	addi	a0,a0,2008 # 8000c068 <wait_lock>
    80001898:	00005097          	auipc	ra,0x5
    8000189c:	a56080e7          	jalr	-1450(ra) # 800062ee <release>
  sched();
    800018a0:	00000097          	auipc	ra,0x0
    800018a4:	bda080e7          	jalr	-1062(ra) # 8000147a <sched>
  panic("zombie exit");
    800018a8:	00007517          	auipc	a0,0x7
    800018ac:	94850513          	addi	a0,a0,-1720 # 800081f0 <etext+0x1f0>
    800018b0:	00004097          	auipc	ra,0x4
    800018b4:	3fe080e7          	jalr	1022(ra) # 80005cae <panic>

00000000800018b8 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    800018b8:	7179                	addi	sp,sp,-48
    800018ba:	f406                	sd	ra,40(sp)
    800018bc:	f022                	sd	s0,32(sp)
    800018be:	ec26                	sd	s1,24(sp)
    800018c0:	e84a                	sd	s2,16(sp)
    800018c2:	e44e                	sd	s3,8(sp)
    800018c4:	1800                	addi	s0,sp,48
    800018c6:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    800018c8:	0000b497          	auipc	s1,0xb
    800018cc:	bb848493          	addi	s1,s1,-1096 # 8000c480 <proc>
    800018d0:	0000c997          	auipc	s3,0xc
    800018d4:	9c098993          	addi	s3,s3,-1600 # 8000d290 <tickslock>
    acquire(&p->lock);
    800018d8:	8526                	mv	a0,s1
    800018da:	00005097          	auipc	ra,0x5
    800018de:	964080e7          	jalr	-1692(ra) # 8000623e <acquire>
    if(p->pid == pid){
    800018e2:	589c                	lw	a5,48(s1)
    800018e4:	03278363          	beq	a5,s2,8000190a <kill+0x52>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    800018e8:	8526                	mv	a0,s1
    800018ea:	00005097          	auipc	ra,0x5
    800018ee:	a04080e7          	jalr	-1532(ra) # 800062ee <release>
  for(p = proc; p < &proc[NPROC]; p++){
    800018f2:	16848493          	addi	s1,s1,360
    800018f6:	ff3491e3          	bne	s1,s3,800018d8 <kill+0x20>
  }
  return -1;
    800018fa:	557d                	li	a0,-1
}
    800018fc:	70a2                	ld	ra,40(sp)
    800018fe:	7402                	ld	s0,32(sp)
    80001900:	64e2                	ld	s1,24(sp)
    80001902:	6942                	ld	s2,16(sp)
    80001904:	69a2                	ld	s3,8(sp)
    80001906:	6145                	addi	sp,sp,48
    80001908:	8082                	ret
      p->killed = 1;
    8000190a:	4785                	li	a5,1
    8000190c:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    8000190e:	4c98                	lw	a4,24(s1)
    80001910:	4789                	li	a5,2
    80001912:	00f70963          	beq	a4,a5,80001924 <kill+0x6c>
      release(&p->lock);
    80001916:	8526                	mv	a0,s1
    80001918:	00005097          	auipc	ra,0x5
    8000191c:	9d6080e7          	jalr	-1578(ra) # 800062ee <release>
      return 0;
    80001920:	4501                	li	a0,0
    80001922:	bfe9                	j	800018fc <kill+0x44>
        p->state = RUNNABLE;
    80001924:	478d                	li	a5,3
    80001926:	cc9c                	sw	a5,24(s1)
    80001928:	b7fd                	j	80001916 <kill+0x5e>

000000008000192a <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    8000192a:	7179                	addi	sp,sp,-48
    8000192c:	f406                	sd	ra,40(sp)
    8000192e:	f022                	sd	s0,32(sp)
    80001930:	ec26                	sd	s1,24(sp)
    80001932:	e84a                	sd	s2,16(sp)
    80001934:	e44e                	sd	s3,8(sp)
    80001936:	e052                	sd	s4,0(sp)
    80001938:	1800                	addi	s0,sp,48
    8000193a:	84aa                	mv	s1,a0
    8000193c:	8a2e                	mv	s4,a1
    8000193e:	89b2                	mv	s3,a2
    80001940:	8936                	mv	s2,a3
  struct proc *p = myproc();
    80001942:	fffff097          	auipc	ra,0xfffff
    80001946:	582080e7          	jalr	1410(ra) # 80000ec4 <myproc>
  if(user_dst){
    8000194a:	c08d                	beqz	s1,8000196c <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    8000194c:	86ca                	mv	a3,s2
    8000194e:	864e                	mv	a2,s3
    80001950:	85d2                	mv	a1,s4
    80001952:	6928                	ld	a0,80(a0)
    80001954:	fffff097          	auipc	ra,0xfffff
    80001958:	1f4080e7          	jalr	500(ra) # 80000b48 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    8000195c:	70a2                	ld	ra,40(sp)
    8000195e:	7402                	ld	s0,32(sp)
    80001960:	64e2                	ld	s1,24(sp)
    80001962:	6942                	ld	s2,16(sp)
    80001964:	69a2                	ld	s3,8(sp)
    80001966:	6a02                	ld	s4,0(sp)
    80001968:	6145                	addi	sp,sp,48
    8000196a:	8082                	ret
    memmove((char *)dst, src, len);
    8000196c:	0009061b          	sext.w	a2,s2
    80001970:	85ce                	mv	a1,s3
    80001972:	8552                	mv	a0,s4
    80001974:	fffff097          	auipc	ra,0xfffff
    80001978:	876080e7          	jalr	-1930(ra) # 800001ea <memmove>
    return 0;
    8000197c:	8526                	mv	a0,s1
    8000197e:	bff9                	j	8000195c <either_copyout+0x32>

0000000080001980 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001980:	7179                	addi	sp,sp,-48
    80001982:	f406                	sd	ra,40(sp)
    80001984:	f022                	sd	s0,32(sp)
    80001986:	ec26                	sd	s1,24(sp)
    80001988:	e84a                	sd	s2,16(sp)
    8000198a:	e44e                	sd	s3,8(sp)
    8000198c:	e052                	sd	s4,0(sp)
    8000198e:	1800                	addi	s0,sp,48
    80001990:	8a2a                	mv	s4,a0
    80001992:	84ae                	mv	s1,a1
    80001994:	89b2                	mv	s3,a2
    80001996:	8936                	mv	s2,a3
  struct proc *p = myproc();
    80001998:	fffff097          	auipc	ra,0xfffff
    8000199c:	52c080e7          	jalr	1324(ra) # 80000ec4 <myproc>
  if(user_src){
    800019a0:	c08d                	beqz	s1,800019c2 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    800019a2:	86ca                	mv	a3,s2
    800019a4:	864e                	mv	a2,s3
    800019a6:	85d2                	mv	a1,s4
    800019a8:	6928                	ld	a0,80(a0)
    800019aa:	fffff097          	auipc	ra,0xfffff
    800019ae:	22a080e7          	jalr	554(ra) # 80000bd4 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    800019b2:	70a2                	ld	ra,40(sp)
    800019b4:	7402                	ld	s0,32(sp)
    800019b6:	64e2                	ld	s1,24(sp)
    800019b8:	6942                	ld	s2,16(sp)
    800019ba:	69a2                	ld	s3,8(sp)
    800019bc:	6a02                	ld	s4,0(sp)
    800019be:	6145                	addi	sp,sp,48
    800019c0:	8082                	ret
    memmove(dst, (char*)src, len);
    800019c2:	0009061b          	sext.w	a2,s2
    800019c6:	85ce                	mv	a1,s3
    800019c8:	8552                	mv	a0,s4
    800019ca:	fffff097          	auipc	ra,0xfffff
    800019ce:	820080e7          	jalr	-2016(ra) # 800001ea <memmove>
    return 0;
    800019d2:	8526                	mv	a0,s1
    800019d4:	bff9                	j	800019b2 <either_copyin+0x32>

00000000800019d6 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800019d6:	715d                	addi	sp,sp,-80
    800019d8:	e486                	sd	ra,72(sp)
    800019da:	e0a2                	sd	s0,64(sp)
    800019dc:	fc26                	sd	s1,56(sp)
    800019de:	f84a                	sd	s2,48(sp)
    800019e0:	f44e                	sd	s3,40(sp)
    800019e2:	f052                	sd	s4,32(sp)
    800019e4:	ec56                	sd	s5,24(sp)
    800019e6:	e85a                	sd	s6,16(sp)
    800019e8:	e45e                	sd	s7,8(sp)
    800019ea:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800019ec:	00006517          	auipc	a0,0x6
    800019f0:	62c50513          	addi	a0,a0,1580 # 80008018 <etext+0x18>
    800019f4:	00004097          	auipc	ra,0x4
    800019f8:	304080e7          	jalr	772(ra) # 80005cf8 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800019fc:	0000b497          	auipc	s1,0xb
    80001a00:	bdc48493          	addi	s1,s1,-1060 # 8000c5d8 <proc+0x158>
    80001a04:	0000c917          	auipc	s2,0xc
    80001a08:	9e490913          	addi	s2,s2,-1564 # 8000d3e8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a0c:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001a0e:	00006997          	auipc	s3,0x6
    80001a12:	7f298993          	addi	s3,s3,2034 # 80008200 <etext+0x200>
    printf("%d %s %s", p->pid, state, p->name);
    80001a16:	00006a97          	auipc	s5,0x6
    80001a1a:	7f2a8a93          	addi	s5,s5,2034 # 80008208 <etext+0x208>
    printf("\n");
    80001a1e:	00006a17          	auipc	s4,0x6
    80001a22:	5faa0a13          	addi	s4,s4,1530 # 80008018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a26:	00007b97          	auipc	s7,0x7
    80001a2a:	cdab8b93          	addi	s7,s7,-806 # 80008700 <states.0>
    80001a2e:	a00d                	j	80001a50 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001a30:	ed86a583          	lw	a1,-296(a3)
    80001a34:	8556                	mv	a0,s5
    80001a36:	00004097          	auipc	ra,0x4
    80001a3a:	2c2080e7          	jalr	706(ra) # 80005cf8 <printf>
    printf("\n");
    80001a3e:	8552                	mv	a0,s4
    80001a40:	00004097          	auipc	ra,0x4
    80001a44:	2b8080e7          	jalr	696(ra) # 80005cf8 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a48:	16848493          	addi	s1,s1,360
    80001a4c:	03248263          	beq	s1,s2,80001a70 <procdump+0x9a>
    if(p->state == UNUSED)
    80001a50:	86a6                	mv	a3,s1
    80001a52:	ec04a783          	lw	a5,-320(s1)
    80001a56:	dbed                	beqz	a5,80001a48 <procdump+0x72>
      state = "???";
    80001a58:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a5a:	fcfb6be3          	bltu	s6,a5,80001a30 <procdump+0x5a>
    80001a5e:	02079713          	slli	a4,a5,0x20
    80001a62:	01d75793          	srli	a5,a4,0x1d
    80001a66:	97de                	add	a5,a5,s7
    80001a68:	6390                	ld	a2,0(a5)
    80001a6a:	f279                	bnez	a2,80001a30 <procdump+0x5a>
      state = "???";
    80001a6c:	864e                	mv	a2,s3
    80001a6e:	b7c9                	j	80001a30 <procdump+0x5a>
  }
}
    80001a70:	60a6                	ld	ra,72(sp)
    80001a72:	6406                	ld	s0,64(sp)
    80001a74:	74e2                	ld	s1,56(sp)
    80001a76:	7942                	ld	s2,48(sp)
    80001a78:	79a2                	ld	s3,40(sp)
    80001a7a:	7a02                	ld	s4,32(sp)
    80001a7c:	6ae2                	ld	s5,24(sp)
    80001a7e:	6b42                	ld	s6,16(sp)
    80001a80:	6ba2                	ld	s7,8(sp)
    80001a82:	6161                	addi	sp,sp,80
    80001a84:	8082                	ret

0000000080001a86 <swtch>:
    80001a86:	00153023          	sd	ra,0(a0)
    80001a8a:	00253423          	sd	sp,8(a0)
    80001a8e:	e900                	sd	s0,16(a0)
    80001a90:	ed04                	sd	s1,24(a0)
    80001a92:	03253023          	sd	s2,32(a0)
    80001a96:	03353423          	sd	s3,40(a0)
    80001a9a:	03453823          	sd	s4,48(a0)
    80001a9e:	03553c23          	sd	s5,56(a0)
    80001aa2:	05653023          	sd	s6,64(a0)
    80001aa6:	05753423          	sd	s7,72(a0)
    80001aaa:	05853823          	sd	s8,80(a0)
    80001aae:	05953c23          	sd	s9,88(a0)
    80001ab2:	07a53023          	sd	s10,96(a0)
    80001ab6:	07b53423          	sd	s11,104(a0)
    80001aba:	0005b083          	ld	ra,0(a1)
    80001abe:	0085b103          	ld	sp,8(a1)
    80001ac2:	6980                	ld	s0,16(a1)
    80001ac4:	6d84                	ld	s1,24(a1)
    80001ac6:	0205b903          	ld	s2,32(a1)
    80001aca:	0285b983          	ld	s3,40(a1)
    80001ace:	0305ba03          	ld	s4,48(a1)
    80001ad2:	0385ba83          	ld	s5,56(a1)
    80001ad6:	0405bb03          	ld	s6,64(a1)
    80001ada:	0485bb83          	ld	s7,72(a1)
    80001ade:	0505bc03          	ld	s8,80(a1)
    80001ae2:	0585bc83          	ld	s9,88(a1)
    80001ae6:	0605bd03          	ld	s10,96(a1)
    80001aea:	0685bd83          	ld	s11,104(a1)
    80001aee:	8082                	ret

0000000080001af0 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001af0:	1141                	addi	sp,sp,-16
    80001af2:	e406                	sd	ra,8(sp)
    80001af4:	e022                	sd	s0,0(sp)
    80001af6:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001af8:	00006597          	auipc	a1,0x6
    80001afc:	74858593          	addi	a1,a1,1864 # 80008240 <etext+0x240>
    80001b00:	0000b517          	auipc	a0,0xb
    80001b04:	79050513          	addi	a0,a0,1936 # 8000d290 <tickslock>
    80001b08:	00004097          	auipc	ra,0x4
    80001b0c:	69c080e7          	jalr	1692(ra) # 800061a4 <initlock>
}
    80001b10:	60a2                	ld	ra,8(sp)
    80001b12:	6402                	ld	s0,0(sp)
    80001b14:	0141                	addi	sp,sp,16
    80001b16:	8082                	ret

0000000080001b18 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001b18:	1141                	addi	sp,sp,-16
    80001b1a:	e406                	sd	ra,8(sp)
    80001b1c:	e022                	sd	s0,0(sp)
    80001b1e:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b20:	00003797          	auipc	a5,0x3
    80001b24:	5c078793          	addi	a5,a5,1472 # 800050e0 <kernelvec>
    80001b28:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001b2c:	60a2                	ld	ra,8(sp)
    80001b2e:	6402                	ld	s0,0(sp)
    80001b30:	0141                	addi	sp,sp,16
    80001b32:	8082                	ret

0000000080001b34 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001b34:	1141                	addi	sp,sp,-16
    80001b36:	e406                	sd	ra,8(sp)
    80001b38:	e022                	sd	s0,0(sp)
    80001b3a:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001b3c:	fffff097          	auipc	ra,0xfffff
    80001b40:	388080e7          	jalr	904(ra) # 80000ec4 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b44:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001b48:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b4a:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001b4e:	00005697          	auipc	a3,0x5
    80001b52:	4b268693          	addi	a3,a3,1202 # 80007000 <_trampoline>
    80001b56:	00005717          	auipc	a4,0x5
    80001b5a:	4aa70713          	addi	a4,a4,1194 # 80007000 <_trampoline>
    80001b5e:	8f15                	sub	a4,a4,a3
    80001b60:	040007b7          	lui	a5,0x4000
    80001b64:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001b66:	07b2                	slli	a5,a5,0xc
    80001b68:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b6a:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001b6e:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001b70:	18002673          	csrr	a2,satp
    80001b74:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001b76:	6d30                	ld	a2,88(a0)
    80001b78:	6138                	ld	a4,64(a0)
    80001b7a:	6585                	lui	a1,0x1
    80001b7c:	972e                	add	a4,a4,a1
    80001b7e:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001b80:	6d38                	ld	a4,88(a0)
    80001b82:	00000617          	auipc	a2,0x0
    80001b86:	14460613          	addi	a2,a2,324 # 80001cc6 <usertrap>
    80001b8a:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001b8c:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001b8e:	8612                	mv	a2,tp
    80001b90:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b92:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001b96:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001b9a:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b9e:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001ba2:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001ba4:	6f18                	ld	a4,24(a4)
    80001ba6:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001baa:	692c                	ld	a1,80(a0)
    80001bac:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001bae:	00005717          	auipc	a4,0x5
    80001bb2:	4e270713          	addi	a4,a4,1250 # 80007090 <userret>
    80001bb6:	8f15                	sub	a4,a4,a3
    80001bb8:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001bba:	577d                	li	a4,-1
    80001bbc:	177e                	slli	a4,a4,0x3f
    80001bbe:	8dd9                	or	a1,a1,a4
    80001bc0:	02000537          	lui	a0,0x2000
    80001bc4:	157d                	addi	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80001bc6:	0536                	slli	a0,a0,0xd
    80001bc8:	9782                	jalr	a5
}
    80001bca:	60a2                	ld	ra,8(sp)
    80001bcc:	6402                	ld	s0,0(sp)
    80001bce:	0141                	addi	sp,sp,16
    80001bd0:	8082                	ret

0000000080001bd2 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001bd2:	1141                	addi	sp,sp,-16
    80001bd4:	e406                	sd	ra,8(sp)
    80001bd6:	e022                	sd	s0,0(sp)
    80001bd8:	0800                	addi	s0,sp,16
  acquire(&tickslock);
    80001bda:	0000b517          	auipc	a0,0xb
    80001bde:	6b650513          	addi	a0,a0,1718 # 8000d290 <tickslock>
    80001be2:	00004097          	auipc	ra,0x4
    80001be6:	65c080e7          	jalr	1628(ra) # 8000623e <acquire>
  ticks++;
    80001bea:	0000a717          	auipc	a4,0xa
    80001bee:	42e70713          	addi	a4,a4,1070 # 8000c018 <ticks>
    80001bf2:	431c                	lw	a5,0(a4)
    80001bf4:	2785                	addiw	a5,a5,1
    80001bf6:	c31c                	sw	a5,0(a4)
  wakeup(&ticks);
    80001bf8:	853a                	mv	a0,a4
    80001bfa:	00000097          	auipc	ra,0x0
    80001bfe:	b1a080e7          	jalr	-1254(ra) # 80001714 <wakeup>
  release(&tickslock);
    80001c02:	0000b517          	auipc	a0,0xb
    80001c06:	68e50513          	addi	a0,a0,1678 # 8000d290 <tickslock>
    80001c0a:	00004097          	auipc	ra,0x4
    80001c0e:	6e4080e7          	jalr	1764(ra) # 800062ee <release>
}
    80001c12:	60a2                	ld	ra,8(sp)
    80001c14:	6402                	ld	s0,0(sp)
    80001c16:	0141                	addi	sp,sp,16
    80001c18:	8082                	ret

0000000080001c1a <devintr>:
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c1a:	142027f3          	csrr	a5,scause
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001c1e:	4501                	li	a0,0
  if((scause & 0x8000000000000000L) &&
    80001c20:	0a07d263          	bgez	a5,80001cc4 <devintr+0xaa>
{
    80001c24:	1101                	addi	sp,sp,-32
    80001c26:	ec06                	sd	ra,24(sp)
    80001c28:	e822                	sd	s0,16(sp)
    80001c2a:	1000                	addi	s0,sp,32
     (scause & 0xff) == 9){
    80001c2c:	0ff7f713          	zext.b	a4,a5
  if((scause & 0x8000000000000000L) &&
    80001c30:	46a5                	li	a3,9
    80001c32:	00d70c63          	beq	a4,a3,80001c4a <devintr+0x30>
  } else if(scause == 0x8000000000000001L){
    80001c36:	577d                	li	a4,-1
    80001c38:	177e                	slli	a4,a4,0x3f
    80001c3a:	0705                	addi	a4,a4,1
    return 0;
    80001c3c:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001c3e:	06e78263          	beq	a5,a4,80001ca2 <devintr+0x88>
  }
}
    80001c42:	60e2                	ld	ra,24(sp)
    80001c44:	6442                	ld	s0,16(sp)
    80001c46:	6105                	addi	sp,sp,32
    80001c48:	8082                	ret
    80001c4a:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    80001c4c:	00003097          	auipc	ra,0x3
    80001c50:	5a0080e7          	jalr	1440(ra) # 800051ec <plic_claim>
    80001c54:	872a                	mv	a4,a0
    80001c56:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001c58:	47a9                	li	a5,10
    80001c5a:	00f50963          	beq	a0,a5,80001c6c <devintr+0x52>
    } else if(irq == VIRTIO0_IRQ){
    80001c5e:	4785                	li	a5,1
    80001c60:	00f50b63          	beq	a0,a5,80001c76 <devintr+0x5c>
    return 1;
    80001c64:	4505                	li	a0,1
    } else if(irq){
    80001c66:	ef09                	bnez	a4,80001c80 <devintr+0x66>
    80001c68:	64a2                	ld	s1,8(sp)
    80001c6a:	bfe1                	j	80001c42 <devintr+0x28>
      uartintr();
    80001c6c:	00004097          	auipc	ra,0x4
    80001c70:	4e4080e7          	jalr	1252(ra) # 80006150 <uartintr>
    if(irq)
    80001c74:	a839                	j	80001c92 <devintr+0x78>
      virtio_disk_intr();
    80001c76:	00004097          	auipc	ra,0x4
    80001c7a:	a30080e7          	jalr	-1488(ra) # 800056a6 <virtio_disk_intr>
    if(irq)
    80001c7e:	a811                	j	80001c92 <devintr+0x78>
      printf("unexpected interrupt irq=%d\n", irq);
    80001c80:	85ba                	mv	a1,a4
    80001c82:	00006517          	auipc	a0,0x6
    80001c86:	5c650513          	addi	a0,a0,1478 # 80008248 <etext+0x248>
    80001c8a:	00004097          	auipc	ra,0x4
    80001c8e:	06e080e7          	jalr	110(ra) # 80005cf8 <printf>
      plic_complete(irq);
    80001c92:	8526                	mv	a0,s1
    80001c94:	00003097          	auipc	ra,0x3
    80001c98:	57c080e7          	jalr	1404(ra) # 80005210 <plic_complete>
    return 1;
    80001c9c:	4505                	li	a0,1
    80001c9e:	64a2                	ld	s1,8(sp)
    80001ca0:	b74d                	j	80001c42 <devintr+0x28>
    if(cpuid() == 0){
    80001ca2:	fffff097          	auipc	ra,0xfffff
    80001ca6:	1ee080e7          	jalr	494(ra) # 80000e90 <cpuid>
    80001caa:	c901                	beqz	a0,80001cba <devintr+0xa0>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001cac:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001cb0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001cb2:	14479073          	csrw	sip,a5
    return 2;
    80001cb6:	4509                	li	a0,2
    80001cb8:	b769                	j	80001c42 <devintr+0x28>
      clockintr();
    80001cba:	00000097          	auipc	ra,0x0
    80001cbe:	f18080e7          	jalr	-232(ra) # 80001bd2 <clockintr>
    80001cc2:	b7ed                	j	80001cac <devintr+0x92>
}
    80001cc4:	8082                	ret

0000000080001cc6 <usertrap>:
{
    80001cc6:	1101                	addi	sp,sp,-32
    80001cc8:	ec06                	sd	ra,24(sp)
    80001cca:	e822                	sd	s0,16(sp)
    80001ccc:	e426                	sd	s1,8(sp)
    80001cce:	e04a                	sd	s2,0(sp)
    80001cd0:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001cd2:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001cd6:	1007f793          	andi	a5,a5,256
    80001cda:	e3ad                	bnez	a5,80001d3c <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001cdc:	00003797          	auipc	a5,0x3
    80001ce0:	40478793          	addi	a5,a5,1028 # 800050e0 <kernelvec>
    80001ce4:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001ce8:	fffff097          	auipc	ra,0xfffff
    80001cec:	1dc080e7          	jalr	476(ra) # 80000ec4 <myproc>
    80001cf0:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001cf2:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001cf4:	14102773          	csrr	a4,sepc
    80001cf8:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001cfa:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001cfe:	47a1                	li	a5,8
    80001d00:	04f71c63          	bne	a4,a5,80001d58 <usertrap+0x92>
    if(p->killed)
    80001d04:	551c                	lw	a5,40(a0)
    80001d06:	e3b9                	bnez	a5,80001d4c <usertrap+0x86>
    p->trapframe->epc += 4;
    80001d08:	6cb8                	ld	a4,88(s1)
    80001d0a:	6f1c                	ld	a5,24(a4)
    80001d0c:	0791                	addi	a5,a5,4
    80001d0e:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d10:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001d14:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d18:	10079073          	csrw	sstatus,a5
    syscall();
    80001d1c:	00000097          	auipc	ra,0x0
    80001d20:	2e2080e7          	jalr	738(ra) # 80001ffe <syscall>
  if(p->killed)
    80001d24:	549c                	lw	a5,40(s1)
    80001d26:	ebc1                	bnez	a5,80001db6 <usertrap+0xf0>
  usertrapret();
    80001d28:	00000097          	auipc	ra,0x0
    80001d2c:	e0c080e7          	jalr	-500(ra) # 80001b34 <usertrapret>
}
    80001d30:	60e2                	ld	ra,24(sp)
    80001d32:	6442                	ld	s0,16(sp)
    80001d34:	64a2                	ld	s1,8(sp)
    80001d36:	6902                	ld	s2,0(sp)
    80001d38:	6105                	addi	sp,sp,32
    80001d3a:	8082                	ret
    panic("usertrap: not from user mode");
    80001d3c:	00006517          	auipc	a0,0x6
    80001d40:	52c50513          	addi	a0,a0,1324 # 80008268 <etext+0x268>
    80001d44:	00004097          	auipc	ra,0x4
    80001d48:	f6a080e7          	jalr	-150(ra) # 80005cae <panic>
      exit(-1);
    80001d4c:	557d                	li	a0,-1
    80001d4e:	00000097          	auipc	ra,0x0
    80001d52:	a90080e7          	jalr	-1392(ra) # 800017de <exit>
    80001d56:	bf4d                	j	80001d08 <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80001d58:	00000097          	auipc	ra,0x0
    80001d5c:	ec2080e7          	jalr	-318(ra) # 80001c1a <devintr>
    80001d60:	892a                	mv	s2,a0
    80001d62:	c501                	beqz	a0,80001d6a <usertrap+0xa4>
  if(p->killed)
    80001d64:	549c                	lw	a5,40(s1)
    80001d66:	c3a1                	beqz	a5,80001da6 <usertrap+0xe0>
    80001d68:	a815                	j	80001d9c <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d6a:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001d6e:	5890                	lw	a2,48(s1)
    80001d70:	00006517          	auipc	a0,0x6
    80001d74:	51850513          	addi	a0,a0,1304 # 80008288 <etext+0x288>
    80001d78:	00004097          	auipc	ra,0x4
    80001d7c:	f80080e7          	jalr	-128(ra) # 80005cf8 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d80:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001d84:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001d88:	00006517          	auipc	a0,0x6
    80001d8c:	53050513          	addi	a0,a0,1328 # 800082b8 <etext+0x2b8>
    80001d90:	00004097          	auipc	ra,0x4
    80001d94:	f68080e7          	jalr	-152(ra) # 80005cf8 <printf>
    p->killed = 1;
    80001d98:	4785                	li	a5,1
    80001d9a:	d49c                	sw	a5,40(s1)
    exit(-1);
    80001d9c:	557d                	li	a0,-1
    80001d9e:	00000097          	auipc	ra,0x0
    80001da2:	a40080e7          	jalr	-1472(ra) # 800017de <exit>
  if(which_dev == 2)
    80001da6:	4789                	li	a5,2
    80001da8:	f8f910e3          	bne	s2,a5,80001d28 <usertrap+0x62>
    yield();
    80001dac:	fffff097          	auipc	ra,0xfffff
    80001db0:	7a6080e7          	jalr	1958(ra) # 80001552 <yield>
    80001db4:	bf95                	j	80001d28 <usertrap+0x62>
  int which_dev = 0;
    80001db6:	4901                	li	s2,0
    80001db8:	b7d5                	j	80001d9c <usertrap+0xd6>

0000000080001dba <kerneltrap>:
{
    80001dba:	7179                	addi	sp,sp,-48
    80001dbc:	f406                	sd	ra,40(sp)
    80001dbe:	f022                	sd	s0,32(sp)
    80001dc0:	ec26                	sd	s1,24(sp)
    80001dc2:	e84a                	sd	s2,16(sp)
    80001dc4:	e44e                	sd	s3,8(sp)
    80001dc6:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001dc8:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001dcc:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001dd0:	142027f3          	csrr	a5,scause
    80001dd4:	89be                	mv	s3,a5
  if((sstatus & SSTATUS_SPP) == 0)
    80001dd6:	1004f793          	andi	a5,s1,256
    80001dda:	cb85                	beqz	a5,80001e0a <kerneltrap+0x50>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ddc:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001de0:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001de2:	ef85                	bnez	a5,80001e1a <kerneltrap+0x60>
  if((which_dev = devintr()) == 0){
    80001de4:	00000097          	auipc	ra,0x0
    80001de8:	e36080e7          	jalr	-458(ra) # 80001c1a <devintr>
    80001dec:	cd1d                	beqz	a0,80001e2a <kerneltrap+0x70>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001dee:	4789                	li	a5,2
    80001df0:	06f50a63          	beq	a0,a5,80001e64 <kerneltrap+0xaa>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001df4:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001df8:	10049073          	csrw	sstatus,s1
}
    80001dfc:	70a2                	ld	ra,40(sp)
    80001dfe:	7402                	ld	s0,32(sp)
    80001e00:	64e2                	ld	s1,24(sp)
    80001e02:	6942                	ld	s2,16(sp)
    80001e04:	69a2                	ld	s3,8(sp)
    80001e06:	6145                	addi	sp,sp,48
    80001e08:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001e0a:	00006517          	auipc	a0,0x6
    80001e0e:	4ce50513          	addi	a0,a0,1230 # 800082d8 <etext+0x2d8>
    80001e12:	00004097          	auipc	ra,0x4
    80001e16:	e9c080e7          	jalr	-356(ra) # 80005cae <panic>
    panic("kerneltrap: interrupts enabled");
    80001e1a:	00006517          	auipc	a0,0x6
    80001e1e:	4e650513          	addi	a0,a0,1254 # 80008300 <etext+0x300>
    80001e22:	00004097          	auipc	ra,0x4
    80001e26:	e8c080e7          	jalr	-372(ra) # 80005cae <panic>
    printf("scause %p\n", scause);
    80001e2a:	85ce                	mv	a1,s3
    80001e2c:	00006517          	auipc	a0,0x6
    80001e30:	4f450513          	addi	a0,a0,1268 # 80008320 <etext+0x320>
    80001e34:	00004097          	auipc	ra,0x4
    80001e38:	ec4080e7          	jalr	-316(ra) # 80005cf8 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e3c:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e40:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e44:	00006517          	auipc	a0,0x6
    80001e48:	4ec50513          	addi	a0,a0,1260 # 80008330 <etext+0x330>
    80001e4c:	00004097          	auipc	ra,0x4
    80001e50:	eac080e7          	jalr	-340(ra) # 80005cf8 <printf>
    panic("kerneltrap");
    80001e54:	00006517          	auipc	a0,0x6
    80001e58:	4f450513          	addi	a0,a0,1268 # 80008348 <etext+0x348>
    80001e5c:	00004097          	auipc	ra,0x4
    80001e60:	e52080e7          	jalr	-430(ra) # 80005cae <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e64:	fffff097          	auipc	ra,0xfffff
    80001e68:	060080e7          	jalr	96(ra) # 80000ec4 <myproc>
    80001e6c:	d541                	beqz	a0,80001df4 <kerneltrap+0x3a>
    80001e6e:	fffff097          	auipc	ra,0xfffff
    80001e72:	056080e7          	jalr	86(ra) # 80000ec4 <myproc>
    80001e76:	4d18                	lw	a4,24(a0)
    80001e78:	4791                	li	a5,4
    80001e7a:	f6f71de3          	bne	a4,a5,80001df4 <kerneltrap+0x3a>
    yield();
    80001e7e:	fffff097          	auipc	ra,0xfffff
    80001e82:	6d4080e7          	jalr	1748(ra) # 80001552 <yield>
    80001e86:	b7bd                	j	80001df4 <kerneltrap+0x3a>

0000000080001e88 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001e88:	1101                	addi	sp,sp,-32
    80001e8a:	ec06                	sd	ra,24(sp)
    80001e8c:	e822                	sd	s0,16(sp)
    80001e8e:	e426                	sd	s1,8(sp)
    80001e90:	1000                	addi	s0,sp,32
    80001e92:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001e94:	fffff097          	auipc	ra,0xfffff
    80001e98:	030080e7          	jalr	48(ra) # 80000ec4 <myproc>
  switch (n) {
    80001e9c:	4795                	li	a5,5
    80001e9e:	0497e163          	bltu	a5,s1,80001ee0 <argraw+0x58>
    80001ea2:	048a                	slli	s1,s1,0x2
    80001ea4:	00007717          	auipc	a4,0x7
    80001ea8:	88c70713          	addi	a4,a4,-1908 # 80008730 <states.0+0x30>
    80001eac:	94ba                	add	s1,s1,a4
    80001eae:	409c                	lw	a5,0(s1)
    80001eb0:	97ba                	add	a5,a5,a4
    80001eb2:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001eb4:	6d3c                	ld	a5,88(a0)
    80001eb6:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001eb8:	60e2                	ld	ra,24(sp)
    80001eba:	6442                	ld	s0,16(sp)
    80001ebc:	64a2                	ld	s1,8(sp)
    80001ebe:	6105                	addi	sp,sp,32
    80001ec0:	8082                	ret
    return p->trapframe->a1;
    80001ec2:	6d3c                	ld	a5,88(a0)
    80001ec4:	7fa8                	ld	a0,120(a5)
    80001ec6:	bfcd                	j	80001eb8 <argraw+0x30>
    return p->trapframe->a2;
    80001ec8:	6d3c                	ld	a5,88(a0)
    80001eca:	63c8                	ld	a0,128(a5)
    80001ecc:	b7f5                	j	80001eb8 <argraw+0x30>
    return p->trapframe->a3;
    80001ece:	6d3c                	ld	a5,88(a0)
    80001ed0:	67c8                	ld	a0,136(a5)
    80001ed2:	b7dd                	j	80001eb8 <argraw+0x30>
    return p->trapframe->a4;
    80001ed4:	6d3c                	ld	a5,88(a0)
    80001ed6:	6bc8                	ld	a0,144(a5)
    80001ed8:	b7c5                	j	80001eb8 <argraw+0x30>
    return p->trapframe->a5;
    80001eda:	6d3c                	ld	a5,88(a0)
    80001edc:	6fc8                	ld	a0,152(a5)
    80001ede:	bfe9                	j	80001eb8 <argraw+0x30>
  panic("argraw");
    80001ee0:	00006517          	auipc	a0,0x6
    80001ee4:	47850513          	addi	a0,a0,1144 # 80008358 <etext+0x358>
    80001ee8:	00004097          	auipc	ra,0x4
    80001eec:	dc6080e7          	jalr	-570(ra) # 80005cae <panic>

0000000080001ef0 <fetchaddr>:
{
    80001ef0:	1101                	addi	sp,sp,-32
    80001ef2:	ec06                	sd	ra,24(sp)
    80001ef4:	e822                	sd	s0,16(sp)
    80001ef6:	e426                	sd	s1,8(sp)
    80001ef8:	e04a                	sd	s2,0(sp)
    80001efa:	1000                	addi	s0,sp,32
    80001efc:	84aa                	mv	s1,a0
    80001efe:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001f00:	fffff097          	auipc	ra,0xfffff
    80001f04:	fc4080e7          	jalr	-60(ra) # 80000ec4 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80001f08:	653c                	ld	a5,72(a0)
    80001f0a:	02f4f863          	bgeu	s1,a5,80001f3a <fetchaddr+0x4a>
    80001f0e:	00848713          	addi	a4,s1,8
    80001f12:	02e7e663          	bltu	a5,a4,80001f3e <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001f16:	46a1                	li	a3,8
    80001f18:	8626                	mv	a2,s1
    80001f1a:	85ca                	mv	a1,s2
    80001f1c:	6928                	ld	a0,80(a0)
    80001f1e:	fffff097          	auipc	ra,0xfffff
    80001f22:	cb6080e7          	jalr	-842(ra) # 80000bd4 <copyin>
    80001f26:	00a03533          	snez	a0,a0
    80001f2a:	40a0053b          	negw	a0,a0
}
    80001f2e:	60e2                	ld	ra,24(sp)
    80001f30:	6442                	ld	s0,16(sp)
    80001f32:	64a2                	ld	s1,8(sp)
    80001f34:	6902                	ld	s2,0(sp)
    80001f36:	6105                	addi	sp,sp,32
    80001f38:	8082                	ret
    return -1;
    80001f3a:	557d                	li	a0,-1
    80001f3c:	bfcd                	j	80001f2e <fetchaddr+0x3e>
    80001f3e:	557d                	li	a0,-1
    80001f40:	b7fd                	j	80001f2e <fetchaddr+0x3e>

0000000080001f42 <fetchstr>:
{
    80001f42:	7179                	addi	sp,sp,-48
    80001f44:	f406                	sd	ra,40(sp)
    80001f46:	f022                	sd	s0,32(sp)
    80001f48:	ec26                	sd	s1,24(sp)
    80001f4a:	e84a                	sd	s2,16(sp)
    80001f4c:	e44e                	sd	s3,8(sp)
    80001f4e:	1800                	addi	s0,sp,48
    80001f50:	89aa                	mv	s3,a0
    80001f52:	84ae                	mv	s1,a1
    80001f54:	8932                	mv	s2,a2
  struct proc *p = myproc();
    80001f56:	fffff097          	auipc	ra,0xfffff
    80001f5a:	f6e080e7          	jalr	-146(ra) # 80000ec4 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80001f5e:	86ca                	mv	a3,s2
    80001f60:	864e                	mv	a2,s3
    80001f62:	85a6                	mv	a1,s1
    80001f64:	6928                	ld	a0,80(a0)
    80001f66:	fffff097          	auipc	ra,0xfffff
    80001f6a:	cfc080e7          	jalr	-772(ra) # 80000c62 <copyinstr>
  if(err < 0)
    80001f6e:	00054763          	bltz	a0,80001f7c <fetchstr+0x3a>
  return strlen(buf);
    80001f72:	8526                	mv	a0,s1
    80001f74:	ffffe097          	auipc	ra,0xffffe
    80001f78:	3a4080e7          	jalr	932(ra) # 80000318 <strlen>
}
    80001f7c:	70a2                	ld	ra,40(sp)
    80001f7e:	7402                	ld	s0,32(sp)
    80001f80:	64e2                	ld	s1,24(sp)
    80001f82:	6942                	ld	s2,16(sp)
    80001f84:	69a2                	ld	s3,8(sp)
    80001f86:	6145                	addi	sp,sp,48
    80001f88:	8082                	ret

0000000080001f8a <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80001f8a:	1101                	addi	sp,sp,-32
    80001f8c:	ec06                	sd	ra,24(sp)
    80001f8e:	e822                	sd	s0,16(sp)
    80001f90:	e426                	sd	s1,8(sp)
    80001f92:	1000                	addi	s0,sp,32
    80001f94:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f96:	00000097          	auipc	ra,0x0
    80001f9a:	ef2080e7          	jalr	-270(ra) # 80001e88 <argraw>
    80001f9e:	c088                	sw	a0,0(s1)
  return 0;
}
    80001fa0:	4501                	li	a0,0
    80001fa2:	60e2                	ld	ra,24(sp)
    80001fa4:	6442                	ld	s0,16(sp)
    80001fa6:	64a2                	ld	s1,8(sp)
    80001fa8:	6105                	addi	sp,sp,32
    80001faa:	8082                	ret

0000000080001fac <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80001fac:	1101                	addi	sp,sp,-32
    80001fae:	ec06                	sd	ra,24(sp)
    80001fb0:	e822                	sd	s0,16(sp)
    80001fb2:	e426                	sd	s1,8(sp)
    80001fb4:	1000                	addi	s0,sp,32
    80001fb6:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001fb8:	00000097          	auipc	ra,0x0
    80001fbc:	ed0080e7          	jalr	-304(ra) # 80001e88 <argraw>
    80001fc0:	e088                	sd	a0,0(s1)
  return 0;
}
    80001fc2:	4501                	li	a0,0
    80001fc4:	60e2                	ld	ra,24(sp)
    80001fc6:	6442                	ld	s0,16(sp)
    80001fc8:	64a2                	ld	s1,8(sp)
    80001fca:	6105                	addi	sp,sp,32
    80001fcc:	8082                	ret

0000000080001fce <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001fce:	1101                	addi	sp,sp,-32
    80001fd0:	ec06                	sd	ra,24(sp)
    80001fd2:	e822                	sd	s0,16(sp)
    80001fd4:	e426                	sd	s1,8(sp)
    80001fd6:	e04a                	sd	s2,0(sp)
    80001fd8:	1000                	addi	s0,sp,32
    80001fda:	892e                	mv	s2,a1
    80001fdc:	84b2                	mv	s1,a2
  *ip = argraw(n);
    80001fde:	00000097          	auipc	ra,0x0
    80001fe2:	eaa080e7          	jalr	-342(ra) # 80001e88 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80001fe6:	8626                	mv	a2,s1
    80001fe8:	85ca                	mv	a1,s2
    80001fea:	00000097          	auipc	ra,0x0
    80001fee:	f58080e7          	jalr	-168(ra) # 80001f42 <fetchstr>
}
    80001ff2:	60e2                	ld	ra,24(sp)
    80001ff4:	6442                	ld	s0,16(sp)
    80001ff6:	64a2                	ld	s1,8(sp)
    80001ff8:	6902                	ld	s2,0(sp)
    80001ffa:	6105                	addi	sp,sp,32
    80001ffc:	8082                	ret

0000000080001ffe <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80001ffe:	1101                	addi	sp,sp,-32
    80002000:	ec06                	sd	ra,24(sp)
    80002002:	e822                	sd	s0,16(sp)
    80002004:	e426                	sd	s1,8(sp)
    80002006:	e04a                	sd	s2,0(sp)
    80002008:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    8000200a:	fffff097          	auipc	ra,0xfffff
    8000200e:	eba080e7          	jalr	-326(ra) # 80000ec4 <myproc>
    80002012:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002014:	05853903          	ld	s2,88(a0)
    80002018:	0a893783          	ld	a5,168(s2)
    8000201c:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002020:	37fd                	addiw	a5,a5,-1
    80002022:	4751                	li	a4,20
    80002024:	00f76f63          	bltu	a4,a5,80002042 <syscall+0x44>
    80002028:	00369713          	slli	a4,a3,0x3
    8000202c:	00006797          	auipc	a5,0x6
    80002030:	71c78793          	addi	a5,a5,1820 # 80008748 <syscalls>
    80002034:	97ba                	add	a5,a5,a4
    80002036:	639c                	ld	a5,0(a5)
    80002038:	c789                	beqz	a5,80002042 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    8000203a:	9782                	jalr	a5
    8000203c:	06a93823          	sd	a0,112(s2)
    80002040:	a839                	j	8000205e <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002042:	15848613          	addi	a2,s1,344
    80002046:	588c                	lw	a1,48(s1)
    80002048:	00006517          	auipc	a0,0x6
    8000204c:	31850513          	addi	a0,a0,792 # 80008360 <etext+0x360>
    80002050:	00004097          	auipc	ra,0x4
    80002054:	ca8080e7          	jalr	-856(ra) # 80005cf8 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002058:	6cbc                	ld	a5,88(s1)
    8000205a:	577d                	li	a4,-1
    8000205c:	fbb8                	sd	a4,112(a5)
  }
}
    8000205e:	60e2                	ld	ra,24(sp)
    80002060:	6442                	ld	s0,16(sp)
    80002062:	64a2                	ld	s1,8(sp)
    80002064:	6902                	ld	s2,0(sp)
    80002066:	6105                	addi	sp,sp,32
    80002068:	8082                	ret

000000008000206a <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000206a:	1101                	addi	sp,sp,-32
    8000206c:	ec06                	sd	ra,24(sp)
    8000206e:	e822                	sd	s0,16(sp)
    80002070:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002072:	fec40593          	addi	a1,s0,-20
    80002076:	4501                	li	a0,0
    80002078:	00000097          	auipc	ra,0x0
    8000207c:	f12080e7          	jalr	-238(ra) # 80001f8a <argint>
    return -1;
    80002080:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002082:	00054963          	bltz	a0,80002094 <sys_exit+0x2a>
  exit(n);
    80002086:	fec42503          	lw	a0,-20(s0)
    8000208a:	fffff097          	auipc	ra,0xfffff
    8000208e:	754080e7          	jalr	1876(ra) # 800017de <exit>
  return 0;  // not reached
    80002092:	4781                	li	a5,0
}
    80002094:	853e                	mv	a0,a5
    80002096:	60e2                	ld	ra,24(sp)
    80002098:	6442                	ld	s0,16(sp)
    8000209a:	6105                	addi	sp,sp,32
    8000209c:	8082                	ret

000000008000209e <sys_getpid>:

uint64
sys_getpid(void)
{
    8000209e:	1141                	addi	sp,sp,-16
    800020a0:	e406                	sd	ra,8(sp)
    800020a2:	e022                	sd	s0,0(sp)
    800020a4:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800020a6:	fffff097          	auipc	ra,0xfffff
    800020aa:	e1e080e7          	jalr	-482(ra) # 80000ec4 <myproc>
}
    800020ae:	5908                	lw	a0,48(a0)
    800020b0:	60a2                	ld	ra,8(sp)
    800020b2:	6402                	ld	s0,0(sp)
    800020b4:	0141                	addi	sp,sp,16
    800020b6:	8082                	ret

00000000800020b8 <sys_fork>:

uint64
sys_fork(void)
{
    800020b8:	1141                	addi	sp,sp,-16
    800020ba:	e406                	sd	ra,8(sp)
    800020bc:	e022                	sd	s0,0(sp)
    800020be:	0800                	addi	s0,sp,16
  return fork();
    800020c0:	fffff097          	auipc	ra,0xfffff
    800020c4:	1d8080e7          	jalr	472(ra) # 80001298 <fork>
}
    800020c8:	60a2                	ld	ra,8(sp)
    800020ca:	6402                	ld	s0,0(sp)
    800020cc:	0141                	addi	sp,sp,16
    800020ce:	8082                	ret

00000000800020d0 <sys_wait>:

uint64
sys_wait(void)
{
    800020d0:	1101                	addi	sp,sp,-32
    800020d2:	ec06                	sd	ra,24(sp)
    800020d4:	e822                	sd	s0,16(sp)
    800020d6:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    800020d8:	fe840593          	addi	a1,s0,-24
    800020dc:	4501                	li	a0,0
    800020de:	00000097          	auipc	ra,0x0
    800020e2:	ece080e7          	jalr	-306(ra) # 80001fac <argaddr>
    800020e6:	87aa                	mv	a5,a0
    return -1;
    800020e8:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    800020ea:	0007c863          	bltz	a5,800020fa <sys_wait+0x2a>
  return wait(p);
    800020ee:	fe843503          	ld	a0,-24(s0)
    800020f2:	fffff097          	auipc	ra,0xfffff
    800020f6:	500080e7          	jalr	1280(ra) # 800015f2 <wait>
}
    800020fa:	60e2                	ld	ra,24(sp)
    800020fc:	6442                	ld	s0,16(sp)
    800020fe:	6105                	addi	sp,sp,32
    80002100:	8082                	ret

0000000080002102 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002102:	7179                	addi	sp,sp,-48
    80002104:	f406                	sd	ra,40(sp)
    80002106:	f022                	sd	s0,32(sp)
    80002108:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    8000210a:	fdc40593          	addi	a1,s0,-36
    8000210e:	4501                	li	a0,0
    80002110:	00000097          	auipc	ra,0x0
    80002114:	e7a080e7          	jalr	-390(ra) # 80001f8a <argint>
    return -1;
    80002118:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    8000211a:	02054363          	bltz	a0,80002140 <sys_sbrk+0x3e>
    8000211e:	ec26                	sd	s1,24(sp)
  addr = myproc()->sz;
    80002120:	fffff097          	auipc	ra,0xfffff
    80002124:	da4080e7          	jalr	-604(ra) # 80000ec4 <myproc>
    80002128:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    8000212a:	fdc42503          	lw	a0,-36(s0)
    8000212e:	fffff097          	auipc	ra,0xfffff
    80002132:	0f2080e7          	jalr	242(ra) # 80001220 <growproc>
    80002136:	00054a63          	bltz	a0,8000214a <sys_sbrk+0x48>
    return -1;
  return addr;
    8000213a:	0004879b          	sext.w	a5,s1
    8000213e:	64e2                	ld	s1,24(sp)
}
    80002140:	853e                	mv	a0,a5
    80002142:	70a2                	ld	ra,40(sp)
    80002144:	7402                	ld	s0,32(sp)
    80002146:	6145                	addi	sp,sp,48
    80002148:	8082                	ret
    return -1;
    8000214a:	57fd                	li	a5,-1
    8000214c:	64e2                	ld	s1,24(sp)
    8000214e:	bfcd                	j	80002140 <sys_sbrk+0x3e>

0000000080002150 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002150:	7139                	addi	sp,sp,-64
    80002152:	fc06                	sd	ra,56(sp)
    80002154:	f822                	sd	s0,48(sp)
    80002156:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002158:	fcc40593          	addi	a1,s0,-52
    8000215c:	4501                	li	a0,0
    8000215e:	00000097          	auipc	ra,0x0
    80002162:	e2c080e7          	jalr	-468(ra) # 80001f8a <argint>
    return -1;
    80002166:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002168:	06054b63          	bltz	a0,800021de <sys_sleep+0x8e>
  acquire(&tickslock);
    8000216c:	0000b517          	auipc	a0,0xb
    80002170:	12450513          	addi	a0,a0,292 # 8000d290 <tickslock>
    80002174:	00004097          	auipc	ra,0x4
    80002178:	0ca080e7          	jalr	202(ra) # 8000623e <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    8000217c:	fcc42783          	lw	a5,-52(s0)
    80002180:	c7b1                	beqz	a5,800021cc <sys_sleep+0x7c>
    80002182:	f426                	sd	s1,40(sp)
    80002184:	f04a                	sd	s2,32(sp)
    80002186:	ec4e                	sd	s3,24(sp)
  ticks0 = ticks;
    80002188:	0000a997          	auipc	s3,0xa
    8000218c:	e909a983          	lw	s3,-368(s3) # 8000c018 <ticks>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002190:	0000b917          	auipc	s2,0xb
    80002194:	10090913          	addi	s2,s2,256 # 8000d290 <tickslock>
    80002198:	0000a497          	auipc	s1,0xa
    8000219c:	e8048493          	addi	s1,s1,-384 # 8000c018 <ticks>
    if(myproc()->killed){
    800021a0:	fffff097          	auipc	ra,0xfffff
    800021a4:	d24080e7          	jalr	-732(ra) # 80000ec4 <myproc>
    800021a8:	551c                	lw	a5,40(a0)
    800021aa:	ef9d                	bnez	a5,800021e8 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    800021ac:	85ca                	mv	a1,s2
    800021ae:	8526                	mv	a0,s1
    800021b0:	fffff097          	auipc	ra,0xfffff
    800021b4:	3de080e7          	jalr	990(ra) # 8000158e <sleep>
  while(ticks - ticks0 < n){
    800021b8:	409c                	lw	a5,0(s1)
    800021ba:	413787bb          	subw	a5,a5,s3
    800021be:	fcc42703          	lw	a4,-52(s0)
    800021c2:	fce7efe3          	bltu	a5,a4,800021a0 <sys_sleep+0x50>
    800021c6:	74a2                	ld	s1,40(sp)
    800021c8:	7902                	ld	s2,32(sp)
    800021ca:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    800021cc:	0000b517          	auipc	a0,0xb
    800021d0:	0c450513          	addi	a0,a0,196 # 8000d290 <tickslock>
    800021d4:	00004097          	auipc	ra,0x4
    800021d8:	11a080e7          	jalr	282(ra) # 800062ee <release>
  return 0;
    800021dc:	4781                	li	a5,0
}
    800021de:	853e                	mv	a0,a5
    800021e0:	70e2                	ld	ra,56(sp)
    800021e2:	7442                	ld	s0,48(sp)
    800021e4:	6121                	addi	sp,sp,64
    800021e6:	8082                	ret
      release(&tickslock);
    800021e8:	0000b517          	auipc	a0,0xb
    800021ec:	0a850513          	addi	a0,a0,168 # 8000d290 <tickslock>
    800021f0:	00004097          	auipc	ra,0x4
    800021f4:	0fe080e7          	jalr	254(ra) # 800062ee <release>
      return -1;
    800021f8:	57fd                	li	a5,-1
    800021fa:	74a2                	ld	s1,40(sp)
    800021fc:	7902                	ld	s2,32(sp)
    800021fe:	69e2                	ld	s3,24(sp)
    80002200:	bff9                	j	800021de <sys_sleep+0x8e>

0000000080002202 <sys_kill>:

uint64
sys_kill(void)
{
    80002202:	1101                	addi	sp,sp,-32
    80002204:	ec06                	sd	ra,24(sp)
    80002206:	e822                	sd	s0,16(sp)
    80002208:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    8000220a:	fec40593          	addi	a1,s0,-20
    8000220e:	4501                	li	a0,0
    80002210:	00000097          	auipc	ra,0x0
    80002214:	d7a080e7          	jalr	-646(ra) # 80001f8a <argint>
    80002218:	87aa                	mv	a5,a0
    return -1;
    8000221a:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    8000221c:	0007c863          	bltz	a5,8000222c <sys_kill+0x2a>
  return kill(pid);
    80002220:	fec42503          	lw	a0,-20(s0)
    80002224:	fffff097          	auipc	ra,0xfffff
    80002228:	694080e7          	jalr	1684(ra) # 800018b8 <kill>
}
    8000222c:	60e2                	ld	ra,24(sp)
    8000222e:	6442                	ld	s0,16(sp)
    80002230:	6105                	addi	sp,sp,32
    80002232:	8082                	ret

0000000080002234 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002234:	1101                	addi	sp,sp,-32
    80002236:	ec06                	sd	ra,24(sp)
    80002238:	e822                	sd	s0,16(sp)
    8000223a:	e426                	sd	s1,8(sp)
    8000223c:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8000223e:	0000b517          	auipc	a0,0xb
    80002242:	05250513          	addi	a0,a0,82 # 8000d290 <tickslock>
    80002246:	00004097          	auipc	ra,0x4
    8000224a:	ff8080e7          	jalr	-8(ra) # 8000623e <acquire>
  xticks = ticks;
    8000224e:	0000a797          	auipc	a5,0xa
    80002252:	dca7a783          	lw	a5,-566(a5) # 8000c018 <ticks>
    80002256:	84be                	mv	s1,a5
  release(&tickslock);
    80002258:	0000b517          	auipc	a0,0xb
    8000225c:	03850513          	addi	a0,a0,56 # 8000d290 <tickslock>
    80002260:	00004097          	auipc	ra,0x4
    80002264:	08e080e7          	jalr	142(ra) # 800062ee <release>
  return xticks;
}
    80002268:	02049513          	slli	a0,s1,0x20
    8000226c:	9101                	srli	a0,a0,0x20
    8000226e:	60e2                	ld	ra,24(sp)
    80002270:	6442                	ld	s0,16(sp)
    80002272:	64a2                	ld	s1,8(sp)
    80002274:	6105                	addi	sp,sp,32
    80002276:	8082                	ret

0000000080002278 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002278:	7179                	addi	sp,sp,-48
    8000227a:	f406                	sd	ra,40(sp)
    8000227c:	f022                	sd	s0,32(sp)
    8000227e:	ec26                	sd	s1,24(sp)
    80002280:	e84a                	sd	s2,16(sp)
    80002282:	e44e                	sd	s3,8(sp)
    80002284:	e052                	sd	s4,0(sp)
    80002286:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002288:	00006597          	auipc	a1,0x6
    8000228c:	0f858593          	addi	a1,a1,248 # 80008380 <etext+0x380>
    80002290:	0000b517          	auipc	a0,0xb
    80002294:	01850513          	addi	a0,a0,24 # 8000d2a8 <bcache>
    80002298:	00004097          	auipc	ra,0x4
    8000229c:	f0c080e7          	jalr	-244(ra) # 800061a4 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    800022a0:	00013797          	auipc	a5,0x13
    800022a4:	00878793          	addi	a5,a5,8 # 800152a8 <bcache+0x8000>
    800022a8:	00013717          	auipc	a4,0x13
    800022ac:	26870713          	addi	a4,a4,616 # 80015510 <bcache+0x8268>
    800022b0:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    800022b4:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800022b8:	0000b497          	auipc	s1,0xb
    800022bc:	00848493          	addi	s1,s1,8 # 8000d2c0 <bcache+0x18>
    b->next = bcache.head.next;
    800022c0:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    800022c2:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800022c4:	00006a17          	auipc	s4,0x6
    800022c8:	0c4a0a13          	addi	s4,s4,196 # 80008388 <etext+0x388>
    b->next = bcache.head.next;
    800022cc:	2b893783          	ld	a5,696(s2)
    800022d0:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    800022d2:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    800022d6:	85d2                	mv	a1,s4
    800022d8:	01048513          	addi	a0,s1,16
    800022dc:	00001097          	auipc	ra,0x1
    800022e0:	4c2080e7          	jalr	1218(ra) # 8000379e <initsleeplock>
    bcache.head.next->prev = b;
    800022e4:	2b893783          	ld	a5,696(s2)
    800022e8:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    800022ea:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800022ee:	45848493          	addi	s1,s1,1112
    800022f2:	fd349de3          	bne	s1,s3,800022cc <binit+0x54>
  }
}
    800022f6:	70a2                	ld	ra,40(sp)
    800022f8:	7402                	ld	s0,32(sp)
    800022fa:	64e2                	ld	s1,24(sp)
    800022fc:	6942                	ld	s2,16(sp)
    800022fe:	69a2                	ld	s3,8(sp)
    80002300:	6a02                	ld	s4,0(sp)
    80002302:	6145                	addi	sp,sp,48
    80002304:	8082                	ret

0000000080002306 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002306:	7179                	addi	sp,sp,-48
    80002308:	f406                	sd	ra,40(sp)
    8000230a:	f022                	sd	s0,32(sp)
    8000230c:	ec26                	sd	s1,24(sp)
    8000230e:	e84a                	sd	s2,16(sp)
    80002310:	e44e                	sd	s3,8(sp)
    80002312:	1800                	addi	s0,sp,48
    80002314:	892a                	mv	s2,a0
    80002316:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002318:	0000b517          	auipc	a0,0xb
    8000231c:	f9050513          	addi	a0,a0,-112 # 8000d2a8 <bcache>
    80002320:	00004097          	auipc	ra,0x4
    80002324:	f1e080e7          	jalr	-226(ra) # 8000623e <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002328:	00013497          	auipc	s1,0x13
    8000232c:	2384b483          	ld	s1,568(s1) # 80015560 <bcache+0x82b8>
    80002330:	00013797          	auipc	a5,0x13
    80002334:	1e078793          	addi	a5,a5,480 # 80015510 <bcache+0x8268>
    80002338:	02f48f63          	beq	s1,a5,80002376 <bread+0x70>
    8000233c:	873e                	mv	a4,a5
    8000233e:	a021                	j	80002346 <bread+0x40>
    80002340:	68a4                	ld	s1,80(s1)
    80002342:	02e48a63          	beq	s1,a4,80002376 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002346:	449c                	lw	a5,8(s1)
    80002348:	ff279ce3          	bne	a5,s2,80002340 <bread+0x3a>
    8000234c:	44dc                	lw	a5,12(s1)
    8000234e:	ff3799e3          	bne	a5,s3,80002340 <bread+0x3a>
      b->refcnt++;
    80002352:	40bc                	lw	a5,64(s1)
    80002354:	2785                	addiw	a5,a5,1
    80002356:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002358:	0000b517          	auipc	a0,0xb
    8000235c:	f5050513          	addi	a0,a0,-176 # 8000d2a8 <bcache>
    80002360:	00004097          	auipc	ra,0x4
    80002364:	f8e080e7          	jalr	-114(ra) # 800062ee <release>
      acquiresleep(&b->lock);
    80002368:	01048513          	addi	a0,s1,16
    8000236c:	00001097          	auipc	ra,0x1
    80002370:	46c080e7          	jalr	1132(ra) # 800037d8 <acquiresleep>
      return b;
    80002374:	a8b9                	j	800023d2 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002376:	00013497          	auipc	s1,0x13
    8000237a:	1e24b483          	ld	s1,482(s1) # 80015558 <bcache+0x82b0>
    8000237e:	00013797          	auipc	a5,0x13
    80002382:	19278793          	addi	a5,a5,402 # 80015510 <bcache+0x8268>
    80002386:	00f48863          	beq	s1,a5,80002396 <bread+0x90>
    8000238a:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    8000238c:	40bc                	lw	a5,64(s1)
    8000238e:	cf81                	beqz	a5,800023a6 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002390:	64a4                	ld	s1,72(s1)
    80002392:	fee49de3          	bne	s1,a4,8000238c <bread+0x86>
  panic("bget: no buffers");
    80002396:	00006517          	auipc	a0,0x6
    8000239a:	ffa50513          	addi	a0,a0,-6 # 80008390 <etext+0x390>
    8000239e:	00004097          	auipc	ra,0x4
    800023a2:	910080e7          	jalr	-1776(ra) # 80005cae <panic>
      b->dev = dev;
    800023a6:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    800023aa:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    800023ae:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    800023b2:	4785                	li	a5,1
    800023b4:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800023b6:	0000b517          	auipc	a0,0xb
    800023ba:	ef250513          	addi	a0,a0,-270 # 8000d2a8 <bcache>
    800023be:	00004097          	auipc	ra,0x4
    800023c2:	f30080e7          	jalr	-208(ra) # 800062ee <release>
      acquiresleep(&b->lock);
    800023c6:	01048513          	addi	a0,s1,16
    800023ca:	00001097          	auipc	ra,0x1
    800023ce:	40e080e7          	jalr	1038(ra) # 800037d8 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    800023d2:	409c                	lw	a5,0(s1)
    800023d4:	cb89                	beqz	a5,800023e6 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    800023d6:	8526                	mv	a0,s1
    800023d8:	70a2                	ld	ra,40(sp)
    800023da:	7402                	ld	s0,32(sp)
    800023dc:	64e2                	ld	s1,24(sp)
    800023de:	6942                	ld	s2,16(sp)
    800023e0:	69a2                	ld	s3,8(sp)
    800023e2:	6145                	addi	sp,sp,48
    800023e4:	8082                	ret
    virtio_disk_rw(b, 0);
    800023e6:	4581                	li	a1,0
    800023e8:	8526                	mv	a0,s1
    800023ea:	00003097          	auipc	ra,0x3
    800023ee:	034080e7          	jalr	52(ra) # 8000541e <virtio_disk_rw>
    b->valid = 1;
    800023f2:	4785                	li	a5,1
    800023f4:	c09c                	sw	a5,0(s1)
  return b;
    800023f6:	b7c5                	j	800023d6 <bread+0xd0>

00000000800023f8 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800023f8:	1101                	addi	sp,sp,-32
    800023fa:	ec06                	sd	ra,24(sp)
    800023fc:	e822                	sd	s0,16(sp)
    800023fe:	e426                	sd	s1,8(sp)
    80002400:	1000                	addi	s0,sp,32
    80002402:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002404:	0541                	addi	a0,a0,16
    80002406:	00001097          	auipc	ra,0x1
    8000240a:	46c080e7          	jalr	1132(ra) # 80003872 <holdingsleep>
    8000240e:	cd01                	beqz	a0,80002426 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002410:	4585                	li	a1,1
    80002412:	8526                	mv	a0,s1
    80002414:	00003097          	auipc	ra,0x3
    80002418:	00a080e7          	jalr	10(ra) # 8000541e <virtio_disk_rw>
}
    8000241c:	60e2                	ld	ra,24(sp)
    8000241e:	6442                	ld	s0,16(sp)
    80002420:	64a2                	ld	s1,8(sp)
    80002422:	6105                	addi	sp,sp,32
    80002424:	8082                	ret
    panic("bwrite");
    80002426:	00006517          	auipc	a0,0x6
    8000242a:	f8250513          	addi	a0,a0,-126 # 800083a8 <etext+0x3a8>
    8000242e:	00004097          	auipc	ra,0x4
    80002432:	880080e7          	jalr	-1920(ra) # 80005cae <panic>

0000000080002436 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002436:	1101                	addi	sp,sp,-32
    80002438:	ec06                	sd	ra,24(sp)
    8000243a:	e822                	sd	s0,16(sp)
    8000243c:	e426                	sd	s1,8(sp)
    8000243e:	e04a                	sd	s2,0(sp)
    80002440:	1000                	addi	s0,sp,32
    80002442:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002444:	01050913          	addi	s2,a0,16
    80002448:	854a                	mv	a0,s2
    8000244a:	00001097          	auipc	ra,0x1
    8000244e:	428080e7          	jalr	1064(ra) # 80003872 <holdingsleep>
    80002452:	c535                	beqz	a0,800024be <brelse+0x88>
    panic("brelse");

  releasesleep(&b->lock);
    80002454:	854a                	mv	a0,s2
    80002456:	00001097          	auipc	ra,0x1
    8000245a:	3d8080e7          	jalr	984(ra) # 8000382e <releasesleep>

  acquire(&bcache.lock);
    8000245e:	0000b517          	auipc	a0,0xb
    80002462:	e4a50513          	addi	a0,a0,-438 # 8000d2a8 <bcache>
    80002466:	00004097          	auipc	ra,0x4
    8000246a:	dd8080e7          	jalr	-552(ra) # 8000623e <acquire>
  b->refcnt--;
    8000246e:	40bc                	lw	a5,64(s1)
    80002470:	37fd                	addiw	a5,a5,-1
    80002472:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002474:	e79d                	bnez	a5,800024a2 <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002476:	68b8                	ld	a4,80(s1)
    80002478:	64bc                	ld	a5,72(s1)
    8000247a:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    8000247c:	68b8                	ld	a4,80(s1)
    8000247e:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80002480:	00013797          	auipc	a5,0x13
    80002484:	e2878793          	addi	a5,a5,-472 # 800152a8 <bcache+0x8000>
    80002488:	2b87b703          	ld	a4,696(a5)
    8000248c:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    8000248e:	00013717          	auipc	a4,0x13
    80002492:	08270713          	addi	a4,a4,130 # 80015510 <bcache+0x8268>
    80002496:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002498:	2b87b703          	ld	a4,696(a5)
    8000249c:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8000249e:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800024a2:	0000b517          	auipc	a0,0xb
    800024a6:	e0650513          	addi	a0,a0,-506 # 8000d2a8 <bcache>
    800024aa:	00004097          	auipc	ra,0x4
    800024ae:	e44080e7          	jalr	-444(ra) # 800062ee <release>
}
    800024b2:	60e2                	ld	ra,24(sp)
    800024b4:	6442                	ld	s0,16(sp)
    800024b6:	64a2                	ld	s1,8(sp)
    800024b8:	6902                	ld	s2,0(sp)
    800024ba:	6105                	addi	sp,sp,32
    800024bc:	8082                	ret
    panic("brelse");
    800024be:	00006517          	auipc	a0,0x6
    800024c2:	ef250513          	addi	a0,a0,-270 # 800083b0 <etext+0x3b0>
    800024c6:	00003097          	auipc	ra,0x3
    800024ca:	7e8080e7          	jalr	2024(ra) # 80005cae <panic>

00000000800024ce <bpin>:

void
bpin(struct buf *b) {
    800024ce:	1101                	addi	sp,sp,-32
    800024d0:	ec06                	sd	ra,24(sp)
    800024d2:	e822                	sd	s0,16(sp)
    800024d4:	e426                	sd	s1,8(sp)
    800024d6:	1000                	addi	s0,sp,32
    800024d8:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800024da:	0000b517          	auipc	a0,0xb
    800024de:	dce50513          	addi	a0,a0,-562 # 8000d2a8 <bcache>
    800024e2:	00004097          	auipc	ra,0x4
    800024e6:	d5c080e7          	jalr	-676(ra) # 8000623e <acquire>
  b->refcnt++;
    800024ea:	40bc                	lw	a5,64(s1)
    800024ec:	2785                	addiw	a5,a5,1
    800024ee:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800024f0:	0000b517          	auipc	a0,0xb
    800024f4:	db850513          	addi	a0,a0,-584 # 8000d2a8 <bcache>
    800024f8:	00004097          	auipc	ra,0x4
    800024fc:	df6080e7          	jalr	-522(ra) # 800062ee <release>
}
    80002500:	60e2                	ld	ra,24(sp)
    80002502:	6442                	ld	s0,16(sp)
    80002504:	64a2                	ld	s1,8(sp)
    80002506:	6105                	addi	sp,sp,32
    80002508:	8082                	ret

000000008000250a <bunpin>:

void
bunpin(struct buf *b) {
    8000250a:	1101                	addi	sp,sp,-32
    8000250c:	ec06                	sd	ra,24(sp)
    8000250e:	e822                	sd	s0,16(sp)
    80002510:	e426                	sd	s1,8(sp)
    80002512:	1000                	addi	s0,sp,32
    80002514:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002516:	0000b517          	auipc	a0,0xb
    8000251a:	d9250513          	addi	a0,a0,-622 # 8000d2a8 <bcache>
    8000251e:	00004097          	auipc	ra,0x4
    80002522:	d20080e7          	jalr	-736(ra) # 8000623e <acquire>
  b->refcnt--;
    80002526:	40bc                	lw	a5,64(s1)
    80002528:	37fd                	addiw	a5,a5,-1
    8000252a:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000252c:	0000b517          	auipc	a0,0xb
    80002530:	d7c50513          	addi	a0,a0,-644 # 8000d2a8 <bcache>
    80002534:	00004097          	auipc	ra,0x4
    80002538:	dba080e7          	jalr	-582(ra) # 800062ee <release>
}
    8000253c:	60e2                	ld	ra,24(sp)
    8000253e:	6442                	ld	s0,16(sp)
    80002540:	64a2                	ld	s1,8(sp)
    80002542:	6105                	addi	sp,sp,32
    80002544:	8082                	ret

0000000080002546 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002546:	1101                	addi	sp,sp,-32
    80002548:	ec06                	sd	ra,24(sp)
    8000254a:	e822                	sd	s0,16(sp)
    8000254c:	e426                	sd	s1,8(sp)
    8000254e:	e04a                	sd	s2,0(sp)
    80002550:	1000                	addi	s0,sp,32
    80002552:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002554:	00d5d79b          	srliw	a5,a1,0xd
    80002558:	00013597          	auipc	a1,0x13
    8000255c:	42c5a583          	lw	a1,1068(a1) # 80015984 <sb+0x1c>
    80002560:	9dbd                	addw	a1,a1,a5
    80002562:	00000097          	auipc	ra,0x0
    80002566:	da4080e7          	jalr	-604(ra) # 80002306 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    8000256a:	0074f713          	andi	a4,s1,7
    8000256e:	4785                	li	a5,1
    80002570:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    80002574:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    80002576:	90d9                	srli	s1,s1,0x36
    80002578:	00950733          	add	a4,a0,s1
    8000257c:	05874703          	lbu	a4,88(a4)
    80002580:	00e7f6b3          	and	a3,a5,a4
    80002584:	c69d                	beqz	a3,800025b2 <bfree+0x6c>
    80002586:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002588:	94aa                	add	s1,s1,a0
    8000258a:	fff7c793          	not	a5,a5
    8000258e:	8f7d                	and	a4,a4,a5
    80002590:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    80002594:	00001097          	auipc	ra,0x1
    80002598:	124080e7          	jalr	292(ra) # 800036b8 <log_write>
  brelse(bp);
    8000259c:	854a                	mv	a0,s2
    8000259e:	00000097          	auipc	ra,0x0
    800025a2:	e98080e7          	jalr	-360(ra) # 80002436 <brelse>
}
    800025a6:	60e2                	ld	ra,24(sp)
    800025a8:	6442                	ld	s0,16(sp)
    800025aa:	64a2                	ld	s1,8(sp)
    800025ac:	6902                	ld	s2,0(sp)
    800025ae:	6105                	addi	sp,sp,32
    800025b0:	8082                	ret
    panic("freeing free block");
    800025b2:	00006517          	auipc	a0,0x6
    800025b6:	e0650513          	addi	a0,a0,-506 # 800083b8 <etext+0x3b8>
    800025ba:	00003097          	auipc	ra,0x3
    800025be:	6f4080e7          	jalr	1780(ra) # 80005cae <panic>

00000000800025c2 <balloc>:
{
    800025c2:	715d                	addi	sp,sp,-80
    800025c4:	e486                	sd	ra,72(sp)
    800025c6:	e0a2                	sd	s0,64(sp)
    800025c8:	fc26                	sd	s1,56(sp)
    800025ca:	f84a                	sd	s2,48(sp)
    800025cc:	f44e                	sd	s3,40(sp)
    800025ce:	f052                	sd	s4,32(sp)
    800025d0:	ec56                	sd	s5,24(sp)
    800025d2:	e85a                	sd	s6,16(sp)
    800025d4:	e45e                	sd	s7,8(sp)
    800025d6:	e062                	sd	s8,0(sp)
    800025d8:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    800025da:	00013797          	auipc	a5,0x13
    800025de:	3927a783          	lw	a5,914(a5) # 8001596c <sb+0x4>
    800025e2:	cfb5                	beqz	a5,8000265e <balloc+0x9c>
    800025e4:	8baa                	mv	s7,a0
    800025e6:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800025e8:	00013b17          	auipc	s6,0x13
    800025ec:	380b0b13          	addi	s6,s6,896 # 80015968 <sb>
      m = 1 << (bi % 8);
    800025f0:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800025f2:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800025f4:	6c09                	lui	s8,0x2
    800025f6:	a821                	j	8000260e <balloc+0x4c>
    brelse(bp);
    800025f8:	854a                	mv	a0,s2
    800025fa:	00000097          	auipc	ra,0x0
    800025fe:	e3c080e7          	jalr	-452(ra) # 80002436 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    80002602:	015c0abb          	addw	s5,s8,s5
    80002606:	004b2783          	lw	a5,4(s6)
    8000260a:	04fafa63          	bgeu	s5,a5,8000265e <balloc+0x9c>
    bp = bread(dev, BBLOCK(b, sb));
    8000260e:	40dad59b          	sraiw	a1,s5,0xd
    80002612:	01cb2783          	lw	a5,28(s6)
    80002616:	9dbd                	addw	a1,a1,a5
    80002618:	855e                	mv	a0,s7
    8000261a:	00000097          	auipc	ra,0x0
    8000261e:	cec080e7          	jalr	-788(ra) # 80002306 <bread>
    80002622:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002624:	004b2503          	lw	a0,4(s6)
    80002628:	84d6                	mv	s1,s5
    8000262a:	4701                	li	a4,0
    8000262c:	fca4f6e3          	bgeu	s1,a0,800025f8 <balloc+0x36>
      m = 1 << (bi % 8);
    80002630:	00777693          	andi	a3,a4,7
    80002634:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002638:	41f7579b          	sraiw	a5,a4,0x1f
    8000263c:	01d7d79b          	srliw	a5,a5,0x1d
    80002640:	9fb9                	addw	a5,a5,a4
    80002642:	4037d79b          	sraiw	a5,a5,0x3
    80002646:	00f90633          	add	a2,s2,a5
    8000264a:	05864603          	lbu	a2,88(a2)
    8000264e:	00c6f5b3          	and	a1,a3,a2
    80002652:	cd91                	beqz	a1,8000266e <balloc+0xac>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002654:	2705                	addiw	a4,a4,1
    80002656:	2485                	addiw	s1,s1,1
    80002658:	fd471ae3          	bne	a4,s4,8000262c <balloc+0x6a>
    8000265c:	bf71                	j	800025f8 <balloc+0x36>
  panic("balloc: out of blocks");
    8000265e:	00006517          	auipc	a0,0x6
    80002662:	d7250513          	addi	a0,a0,-654 # 800083d0 <etext+0x3d0>
    80002666:	00003097          	auipc	ra,0x3
    8000266a:	648080e7          	jalr	1608(ra) # 80005cae <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000266e:	97ca                	add	a5,a5,s2
    80002670:	8e55                	or	a2,a2,a3
    80002672:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    80002676:	854a                	mv	a0,s2
    80002678:	00001097          	auipc	ra,0x1
    8000267c:	040080e7          	jalr	64(ra) # 800036b8 <log_write>
        brelse(bp);
    80002680:	854a                	mv	a0,s2
    80002682:	00000097          	auipc	ra,0x0
    80002686:	db4080e7          	jalr	-588(ra) # 80002436 <brelse>
  bp = bread(dev, bno);
    8000268a:	85a6                	mv	a1,s1
    8000268c:	855e                	mv	a0,s7
    8000268e:	00000097          	auipc	ra,0x0
    80002692:	c78080e7          	jalr	-904(ra) # 80002306 <bread>
    80002696:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002698:	40000613          	li	a2,1024
    8000269c:	4581                	li	a1,0
    8000269e:	05850513          	addi	a0,a0,88
    800026a2:	ffffe097          	auipc	ra,0xffffe
    800026a6:	ae8080e7          	jalr	-1304(ra) # 8000018a <memset>
  log_write(bp);
    800026aa:	854a                	mv	a0,s2
    800026ac:	00001097          	auipc	ra,0x1
    800026b0:	00c080e7          	jalr	12(ra) # 800036b8 <log_write>
  brelse(bp);
    800026b4:	854a                	mv	a0,s2
    800026b6:	00000097          	auipc	ra,0x0
    800026ba:	d80080e7          	jalr	-640(ra) # 80002436 <brelse>
}
    800026be:	8526                	mv	a0,s1
    800026c0:	60a6                	ld	ra,72(sp)
    800026c2:	6406                	ld	s0,64(sp)
    800026c4:	74e2                	ld	s1,56(sp)
    800026c6:	7942                	ld	s2,48(sp)
    800026c8:	79a2                	ld	s3,40(sp)
    800026ca:	7a02                	ld	s4,32(sp)
    800026cc:	6ae2                	ld	s5,24(sp)
    800026ce:	6b42                	ld	s6,16(sp)
    800026d0:	6ba2                	ld	s7,8(sp)
    800026d2:	6c02                	ld	s8,0(sp)
    800026d4:	6161                	addi	sp,sp,80
    800026d6:	8082                	ret

00000000800026d8 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    800026d8:	7179                	addi	sp,sp,-48
    800026da:	f406                	sd	ra,40(sp)
    800026dc:	f022                	sd	s0,32(sp)
    800026de:	ec26                	sd	s1,24(sp)
    800026e0:	e84a                	sd	s2,16(sp)
    800026e2:	e44e                	sd	s3,8(sp)
    800026e4:	1800                	addi	s0,sp,48
    800026e6:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800026e8:	47ad                	li	a5,11
    800026ea:	04b7fd63          	bgeu	a5,a1,80002744 <bmap+0x6c>
    800026ee:	e052                	sd	s4,0(sp)
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    800026f0:	ff45849b          	addiw	s1,a1,-12

  if(bn < NINDIRECT){
    800026f4:	0ff00793          	li	a5,255
    800026f8:	0897ef63          	bltu	a5,s1,80002796 <bmap+0xbe>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    800026fc:	08052583          	lw	a1,128(a0)
    80002700:	c5a5                	beqz	a1,80002768 <bmap+0x90>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80002702:	00092503          	lw	a0,0(s2)
    80002706:	00000097          	auipc	ra,0x0
    8000270a:	c00080e7          	jalr	-1024(ra) # 80002306 <bread>
    8000270e:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002710:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002714:	02049713          	slli	a4,s1,0x20
    80002718:	01e75593          	srli	a1,a4,0x1e
    8000271c:	00b784b3          	add	s1,a5,a1
    80002720:	0004a983          	lw	s3,0(s1)
    80002724:	04098b63          	beqz	s3,8000277a <bmap+0xa2>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    80002728:	8552                	mv	a0,s4
    8000272a:	00000097          	auipc	ra,0x0
    8000272e:	d0c080e7          	jalr	-756(ra) # 80002436 <brelse>
    return addr;
    80002732:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    80002734:	854e                	mv	a0,s3
    80002736:	70a2                	ld	ra,40(sp)
    80002738:	7402                	ld	s0,32(sp)
    8000273a:	64e2                	ld	s1,24(sp)
    8000273c:	6942                	ld	s2,16(sp)
    8000273e:	69a2                	ld	s3,8(sp)
    80002740:	6145                	addi	sp,sp,48
    80002742:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    80002744:	02059793          	slli	a5,a1,0x20
    80002748:	01e7d593          	srli	a1,a5,0x1e
    8000274c:	00b504b3          	add	s1,a0,a1
    80002750:	0504a983          	lw	s3,80(s1)
    80002754:	fe0990e3          	bnez	s3,80002734 <bmap+0x5c>
      ip->addrs[bn] = addr = balloc(ip->dev);
    80002758:	4108                	lw	a0,0(a0)
    8000275a:	00000097          	auipc	ra,0x0
    8000275e:	e68080e7          	jalr	-408(ra) # 800025c2 <balloc>
    80002762:	89aa                	mv	s3,a0
    80002764:	c8a8                	sw	a0,80(s1)
    80002766:	b7f9                	j	80002734 <bmap+0x5c>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80002768:	4108                	lw	a0,0(a0)
    8000276a:	00000097          	auipc	ra,0x0
    8000276e:	e58080e7          	jalr	-424(ra) # 800025c2 <balloc>
    80002772:	85aa                	mv	a1,a0
    80002774:	08a92023          	sw	a0,128(s2)
    80002778:	b769                	j	80002702 <bmap+0x2a>
      a[bn] = addr = balloc(ip->dev);
    8000277a:	00092503          	lw	a0,0(s2)
    8000277e:	00000097          	auipc	ra,0x0
    80002782:	e44080e7          	jalr	-444(ra) # 800025c2 <balloc>
    80002786:	89aa                	mv	s3,a0
    80002788:	c088                	sw	a0,0(s1)
      log_write(bp);
    8000278a:	8552                	mv	a0,s4
    8000278c:	00001097          	auipc	ra,0x1
    80002790:	f2c080e7          	jalr	-212(ra) # 800036b8 <log_write>
    80002794:	bf51                	j	80002728 <bmap+0x50>
  panic("bmap: out of range");
    80002796:	00006517          	auipc	a0,0x6
    8000279a:	c5250513          	addi	a0,a0,-942 # 800083e8 <etext+0x3e8>
    8000279e:	00003097          	auipc	ra,0x3
    800027a2:	510080e7          	jalr	1296(ra) # 80005cae <panic>

00000000800027a6 <iget>:
{
    800027a6:	7179                	addi	sp,sp,-48
    800027a8:	f406                	sd	ra,40(sp)
    800027aa:	f022                	sd	s0,32(sp)
    800027ac:	ec26                	sd	s1,24(sp)
    800027ae:	e84a                	sd	s2,16(sp)
    800027b0:	e44e                	sd	s3,8(sp)
    800027b2:	e052                	sd	s4,0(sp)
    800027b4:	1800                	addi	s0,sp,48
    800027b6:	892a                	mv	s2,a0
    800027b8:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800027ba:	00013517          	auipc	a0,0x13
    800027be:	1ce50513          	addi	a0,a0,462 # 80015988 <itable>
    800027c2:	00004097          	auipc	ra,0x4
    800027c6:	a7c080e7          	jalr	-1412(ra) # 8000623e <acquire>
  empty = 0;
    800027ca:	4981                	li	s3,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800027cc:	00013497          	auipc	s1,0x13
    800027d0:	1d448493          	addi	s1,s1,468 # 800159a0 <itable+0x18>
    800027d4:	00015697          	auipc	a3,0x15
    800027d8:	c5c68693          	addi	a3,a3,-932 # 80017430 <log>
    800027dc:	a809                	j	800027ee <iget+0x48>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800027de:	e781                	bnez	a5,800027e6 <iget+0x40>
    800027e0:	00099363          	bnez	s3,800027e6 <iget+0x40>
      empty = ip;
    800027e4:	89a6                	mv	s3,s1
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800027e6:	08848493          	addi	s1,s1,136
    800027ea:	02d48763          	beq	s1,a3,80002818 <iget+0x72>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800027ee:	449c                	lw	a5,8(s1)
    800027f0:	fef057e3          	blez	a5,800027de <iget+0x38>
    800027f4:	4098                	lw	a4,0(s1)
    800027f6:	ff2718e3          	bne	a4,s2,800027e6 <iget+0x40>
    800027fa:	40d8                	lw	a4,4(s1)
    800027fc:	ff4715e3          	bne	a4,s4,800027e6 <iget+0x40>
      ip->ref++;
    80002800:	2785                	addiw	a5,a5,1
    80002802:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002804:	00013517          	auipc	a0,0x13
    80002808:	18450513          	addi	a0,a0,388 # 80015988 <itable>
    8000280c:	00004097          	auipc	ra,0x4
    80002810:	ae2080e7          	jalr	-1310(ra) # 800062ee <release>
      return ip;
    80002814:	89a6                	mv	s3,s1
    80002816:	a025                	j	8000283e <iget+0x98>
  if(empty == 0)
    80002818:	02098c63          	beqz	s3,80002850 <iget+0xaa>
  ip->dev = dev;
    8000281c:	0129a023          	sw	s2,0(s3)
  ip->inum = inum;
    80002820:	0149a223          	sw	s4,4(s3)
  ip->ref = 1;
    80002824:	4785                	li	a5,1
    80002826:	00f9a423          	sw	a5,8(s3)
  ip->valid = 0;
    8000282a:	0409a023          	sw	zero,64(s3)
  release(&itable.lock);
    8000282e:	00013517          	auipc	a0,0x13
    80002832:	15a50513          	addi	a0,a0,346 # 80015988 <itable>
    80002836:	00004097          	auipc	ra,0x4
    8000283a:	ab8080e7          	jalr	-1352(ra) # 800062ee <release>
}
    8000283e:	854e                	mv	a0,s3
    80002840:	70a2                	ld	ra,40(sp)
    80002842:	7402                	ld	s0,32(sp)
    80002844:	64e2                	ld	s1,24(sp)
    80002846:	6942                	ld	s2,16(sp)
    80002848:	69a2                	ld	s3,8(sp)
    8000284a:	6a02                	ld	s4,0(sp)
    8000284c:	6145                	addi	sp,sp,48
    8000284e:	8082                	ret
    panic("iget: no inodes");
    80002850:	00006517          	auipc	a0,0x6
    80002854:	bb050513          	addi	a0,a0,-1104 # 80008400 <etext+0x400>
    80002858:	00003097          	auipc	ra,0x3
    8000285c:	456080e7          	jalr	1110(ra) # 80005cae <panic>

0000000080002860 <fsinit>:
fsinit(int dev) {
    80002860:	1101                	addi	sp,sp,-32
    80002862:	ec06                	sd	ra,24(sp)
    80002864:	e822                	sd	s0,16(sp)
    80002866:	e426                	sd	s1,8(sp)
    80002868:	e04a                	sd	s2,0(sp)
    8000286a:	1000                	addi	s0,sp,32
    8000286c:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    8000286e:	4585                	li	a1,1
    80002870:	00000097          	auipc	ra,0x0
    80002874:	a96080e7          	jalr	-1386(ra) # 80002306 <bread>
    80002878:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    8000287a:	02000613          	li	a2,32
    8000287e:	05850593          	addi	a1,a0,88
    80002882:	00013517          	auipc	a0,0x13
    80002886:	0e650513          	addi	a0,a0,230 # 80015968 <sb>
    8000288a:	ffffe097          	auipc	ra,0xffffe
    8000288e:	960080e7          	jalr	-1696(ra) # 800001ea <memmove>
  brelse(bp);
    80002892:	8526                	mv	a0,s1
    80002894:	00000097          	auipc	ra,0x0
    80002898:	ba2080e7          	jalr	-1118(ra) # 80002436 <brelse>
  if(sb.magic != FSMAGIC)
    8000289c:	00013717          	auipc	a4,0x13
    800028a0:	0cc72703          	lw	a4,204(a4) # 80015968 <sb>
    800028a4:	102037b7          	lui	a5,0x10203
    800028a8:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800028ac:	02f71163          	bne	a4,a5,800028ce <fsinit+0x6e>
  initlog(dev, &sb);
    800028b0:	00013597          	auipc	a1,0x13
    800028b4:	0b858593          	addi	a1,a1,184 # 80015968 <sb>
    800028b8:	854a                	mv	a0,s2
    800028ba:	00001097          	auipc	ra,0x1
    800028be:	b78080e7          	jalr	-1160(ra) # 80003432 <initlog>
}
    800028c2:	60e2                	ld	ra,24(sp)
    800028c4:	6442                	ld	s0,16(sp)
    800028c6:	64a2                	ld	s1,8(sp)
    800028c8:	6902                	ld	s2,0(sp)
    800028ca:	6105                	addi	sp,sp,32
    800028cc:	8082                	ret
    panic("invalid file system");
    800028ce:	00006517          	auipc	a0,0x6
    800028d2:	b4250513          	addi	a0,a0,-1214 # 80008410 <etext+0x410>
    800028d6:	00003097          	auipc	ra,0x3
    800028da:	3d8080e7          	jalr	984(ra) # 80005cae <panic>

00000000800028de <iinit>:
{
    800028de:	7179                	addi	sp,sp,-48
    800028e0:	f406                	sd	ra,40(sp)
    800028e2:	f022                	sd	s0,32(sp)
    800028e4:	ec26                	sd	s1,24(sp)
    800028e6:	e84a                	sd	s2,16(sp)
    800028e8:	e44e                	sd	s3,8(sp)
    800028ea:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800028ec:	00006597          	auipc	a1,0x6
    800028f0:	b3c58593          	addi	a1,a1,-1220 # 80008428 <etext+0x428>
    800028f4:	00013517          	auipc	a0,0x13
    800028f8:	09450513          	addi	a0,a0,148 # 80015988 <itable>
    800028fc:	00004097          	auipc	ra,0x4
    80002900:	8a8080e7          	jalr	-1880(ra) # 800061a4 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002904:	00013497          	auipc	s1,0x13
    80002908:	0ac48493          	addi	s1,s1,172 # 800159b0 <itable+0x28>
    8000290c:	00015997          	auipc	s3,0x15
    80002910:	b3498993          	addi	s3,s3,-1228 # 80017440 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002914:	00006917          	auipc	s2,0x6
    80002918:	b1c90913          	addi	s2,s2,-1252 # 80008430 <etext+0x430>
    8000291c:	85ca                	mv	a1,s2
    8000291e:	8526                	mv	a0,s1
    80002920:	00001097          	auipc	ra,0x1
    80002924:	e7e080e7          	jalr	-386(ra) # 8000379e <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002928:	08848493          	addi	s1,s1,136
    8000292c:	ff3498e3          	bne	s1,s3,8000291c <iinit+0x3e>
}
    80002930:	70a2                	ld	ra,40(sp)
    80002932:	7402                	ld	s0,32(sp)
    80002934:	64e2                	ld	s1,24(sp)
    80002936:	6942                	ld	s2,16(sp)
    80002938:	69a2                	ld	s3,8(sp)
    8000293a:	6145                	addi	sp,sp,48
    8000293c:	8082                	ret

000000008000293e <ialloc>:
{
    8000293e:	7139                	addi	sp,sp,-64
    80002940:	fc06                	sd	ra,56(sp)
    80002942:	f822                	sd	s0,48(sp)
    80002944:	f426                	sd	s1,40(sp)
    80002946:	f04a                	sd	s2,32(sp)
    80002948:	ec4e                	sd	s3,24(sp)
    8000294a:	e852                	sd	s4,16(sp)
    8000294c:	e456                	sd	s5,8(sp)
    8000294e:	e05a                	sd	s6,0(sp)
    80002950:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    80002952:	00013717          	auipc	a4,0x13
    80002956:	02272703          	lw	a4,34(a4) # 80015974 <sb+0xc>
    8000295a:	4785                	li	a5,1
    8000295c:	04e7f863          	bgeu	a5,a4,800029ac <ialloc+0x6e>
    80002960:	8aaa                	mv	s5,a0
    80002962:	8b2e                	mv	s6,a1
    80002964:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    80002966:	00013a17          	auipc	s4,0x13
    8000296a:	002a0a13          	addi	s4,s4,2 # 80015968 <sb>
    8000296e:	00495593          	srli	a1,s2,0x4
    80002972:	018a2783          	lw	a5,24(s4)
    80002976:	9dbd                	addw	a1,a1,a5
    80002978:	8556                	mv	a0,s5
    8000297a:	00000097          	auipc	ra,0x0
    8000297e:	98c080e7          	jalr	-1652(ra) # 80002306 <bread>
    80002982:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002984:	05850993          	addi	s3,a0,88
    80002988:	00f97793          	andi	a5,s2,15
    8000298c:	079a                	slli	a5,a5,0x6
    8000298e:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002990:	00099783          	lh	a5,0(s3)
    80002994:	c785                	beqz	a5,800029bc <ialloc+0x7e>
    brelse(bp);
    80002996:	00000097          	auipc	ra,0x0
    8000299a:	aa0080e7          	jalr	-1376(ra) # 80002436 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000299e:	0905                	addi	s2,s2,1
    800029a0:	00ca2703          	lw	a4,12(s4)
    800029a4:	0009079b          	sext.w	a5,s2
    800029a8:	fce7e3e3          	bltu	a5,a4,8000296e <ialloc+0x30>
  panic("ialloc: no inodes");
    800029ac:	00006517          	auipc	a0,0x6
    800029b0:	a8c50513          	addi	a0,a0,-1396 # 80008438 <etext+0x438>
    800029b4:	00003097          	auipc	ra,0x3
    800029b8:	2fa080e7          	jalr	762(ra) # 80005cae <panic>
      memset(dip, 0, sizeof(*dip));
    800029bc:	04000613          	li	a2,64
    800029c0:	4581                	li	a1,0
    800029c2:	854e                	mv	a0,s3
    800029c4:	ffffd097          	auipc	ra,0xffffd
    800029c8:	7c6080e7          	jalr	1990(ra) # 8000018a <memset>
      dip->type = type;
    800029cc:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    800029d0:	8526                	mv	a0,s1
    800029d2:	00001097          	auipc	ra,0x1
    800029d6:	ce6080e7          	jalr	-794(ra) # 800036b8 <log_write>
      brelse(bp);
    800029da:	8526                	mv	a0,s1
    800029dc:	00000097          	auipc	ra,0x0
    800029e0:	a5a080e7          	jalr	-1446(ra) # 80002436 <brelse>
      return iget(dev, inum);
    800029e4:	0009059b          	sext.w	a1,s2
    800029e8:	8556                	mv	a0,s5
    800029ea:	00000097          	auipc	ra,0x0
    800029ee:	dbc080e7          	jalr	-580(ra) # 800027a6 <iget>
}
    800029f2:	70e2                	ld	ra,56(sp)
    800029f4:	7442                	ld	s0,48(sp)
    800029f6:	74a2                	ld	s1,40(sp)
    800029f8:	7902                	ld	s2,32(sp)
    800029fa:	69e2                	ld	s3,24(sp)
    800029fc:	6a42                	ld	s4,16(sp)
    800029fe:	6aa2                	ld	s5,8(sp)
    80002a00:	6b02                	ld	s6,0(sp)
    80002a02:	6121                	addi	sp,sp,64
    80002a04:	8082                	ret

0000000080002a06 <iupdate>:
{
    80002a06:	1101                	addi	sp,sp,-32
    80002a08:	ec06                	sd	ra,24(sp)
    80002a0a:	e822                	sd	s0,16(sp)
    80002a0c:	e426                	sd	s1,8(sp)
    80002a0e:	e04a                	sd	s2,0(sp)
    80002a10:	1000                	addi	s0,sp,32
    80002a12:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002a14:	415c                	lw	a5,4(a0)
    80002a16:	0047d79b          	srliw	a5,a5,0x4
    80002a1a:	00013597          	auipc	a1,0x13
    80002a1e:	f665a583          	lw	a1,-154(a1) # 80015980 <sb+0x18>
    80002a22:	9dbd                	addw	a1,a1,a5
    80002a24:	4108                	lw	a0,0(a0)
    80002a26:	00000097          	auipc	ra,0x0
    80002a2a:	8e0080e7          	jalr	-1824(ra) # 80002306 <bread>
    80002a2e:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002a30:	05850793          	addi	a5,a0,88
    80002a34:	40d8                	lw	a4,4(s1)
    80002a36:	8b3d                	andi	a4,a4,15
    80002a38:	071a                	slli	a4,a4,0x6
    80002a3a:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002a3c:	04449703          	lh	a4,68(s1)
    80002a40:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002a44:	04649703          	lh	a4,70(s1)
    80002a48:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002a4c:	04849703          	lh	a4,72(s1)
    80002a50:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002a54:	04a49703          	lh	a4,74(s1)
    80002a58:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002a5c:	44f8                	lw	a4,76(s1)
    80002a5e:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002a60:	03400613          	li	a2,52
    80002a64:	05048593          	addi	a1,s1,80
    80002a68:	00c78513          	addi	a0,a5,12
    80002a6c:	ffffd097          	auipc	ra,0xffffd
    80002a70:	77e080e7          	jalr	1918(ra) # 800001ea <memmove>
  log_write(bp);
    80002a74:	854a                	mv	a0,s2
    80002a76:	00001097          	auipc	ra,0x1
    80002a7a:	c42080e7          	jalr	-958(ra) # 800036b8 <log_write>
  brelse(bp);
    80002a7e:	854a                	mv	a0,s2
    80002a80:	00000097          	auipc	ra,0x0
    80002a84:	9b6080e7          	jalr	-1610(ra) # 80002436 <brelse>
}
    80002a88:	60e2                	ld	ra,24(sp)
    80002a8a:	6442                	ld	s0,16(sp)
    80002a8c:	64a2                	ld	s1,8(sp)
    80002a8e:	6902                	ld	s2,0(sp)
    80002a90:	6105                	addi	sp,sp,32
    80002a92:	8082                	ret

0000000080002a94 <idup>:
{
    80002a94:	1101                	addi	sp,sp,-32
    80002a96:	ec06                	sd	ra,24(sp)
    80002a98:	e822                	sd	s0,16(sp)
    80002a9a:	e426                	sd	s1,8(sp)
    80002a9c:	1000                	addi	s0,sp,32
    80002a9e:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002aa0:	00013517          	auipc	a0,0x13
    80002aa4:	ee850513          	addi	a0,a0,-280 # 80015988 <itable>
    80002aa8:	00003097          	auipc	ra,0x3
    80002aac:	796080e7          	jalr	1942(ra) # 8000623e <acquire>
  ip->ref++;
    80002ab0:	449c                	lw	a5,8(s1)
    80002ab2:	2785                	addiw	a5,a5,1
    80002ab4:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002ab6:	00013517          	auipc	a0,0x13
    80002aba:	ed250513          	addi	a0,a0,-302 # 80015988 <itable>
    80002abe:	00004097          	auipc	ra,0x4
    80002ac2:	830080e7          	jalr	-2000(ra) # 800062ee <release>
}
    80002ac6:	8526                	mv	a0,s1
    80002ac8:	60e2                	ld	ra,24(sp)
    80002aca:	6442                	ld	s0,16(sp)
    80002acc:	64a2                	ld	s1,8(sp)
    80002ace:	6105                	addi	sp,sp,32
    80002ad0:	8082                	ret

0000000080002ad2 <ilock>:
{
    80002ad2:	1101                	addi	sp,sp,-32
    80002ad4:	ec06                	sd	ra,24(sp)
    80002ad6:	e822                	sd	s0,16(sp)
    80002ad8:	e426                	sd	s1,8(sp)
    80002ada:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002adc:	c10d                	beqz	a0,80002afe <ilock+0x2c>
    80002ade:	84aa                	mv	s1,a0
    80002ae0:	451c                	lw	a5,8(a0)
    80002ae2:	00f05e63          	blez	a5,80002afe <ilock+0x2c>
  acquiresleep(&ip->lock);
    80002ae6:	0541                	addi	a0,a0,16
    80002ae8:	00001097          	auipc	ra,0x1
    80002aec:	cf0080e7          	jalr	-784(ra) # 800037d8 <acquiresleep>
  if(ip->valid == 0){
    80002af0:	40bc                	lw	a5,64(s1)
    80002af2:	cf99                	beqz	a5,80002b10 <ilock+0x3e>
}
    80002af4:	60e2                	ld	ra,24(sp)
    80002af6:	6442                	ld	s0,16(sp)
    80002af8:	64a2                	ld	s1,8(sp)
    80002afa:	6105                	addi	sp,sp,32
    80002afc:	8082                	ret
    80002afe:	e04a                	sd	s2,0(sp)
    panic("ilock");
    80002b00:	00006517          	auipc	a0,0x6
    80002b04:	95050513          	addi	a0,a0,-1712 # 80008450 <etext+0x450>
    80002b08:	00003097          	auipc	ra,0x3
    80002b0c:	1a6080e7          	jalr	422(ra) # 80005cae <panic>
    80002b10:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002b12:	40dc                	lw	a5,4(s1)
    80002b14:	0047d79b          	srliw	a5,a5,0x4
    80002b18:	00013597          	auipc	a1,0x13
    80002b1c:	e685a583          	lw	a1,-408(a1) # 80015980 <sb+0x18>
    80002b20:	9dbd                	addw	a1,a1,a5
    80002b22:	4088                	lw	a0,0(s1)
    80002b24:	fffff097          	auipc	ra,0xfffff
    80002b28:	7e2080e7          	jalr	2018(ra) # 80002306 <bread>
    80002b2c:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002b2e:	05850593          	addi	a1,a0,88
    80002b32:	40dc                	lw	a5,4(s1)
    80002b34:	8bbd                	andi	a5,a5,15
    80002b36:	079a                	slli	a5,a5,0x6
    80002b38:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002b3a:	00059783          	lh	a5,0(a1)
    80002b3e:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002b42:	00259783          	lh	a5,2(a1)
    80002b46:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002b4a:	00459783          	lh	a5,4(a1)
    80002b4e:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002b52:	00659783          	lh	a5,6(a1)
    80002b56:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002b5a:	459c                	lw	a5,8(a1)
    80002b5c:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002b5e:	03400613          	li	a2,52
    80002b62:	05b1                	addi	a1,a1,12
    80002b64:	05048513          	addi	a0,s1,80
    80002b68:	ffffd097          	auipc	ra,0xffffd
    80002b6c:	682080e7          	jalr	1666(ra) # 800001ea <memmove>
    brelse(bp);
    80002b70:	854a                	mv	a0,s2
    80002b72:	00000097          	auipc	ra,0x0
    80002b76:	8c4080e7          	jalr	-1852(ra) # 80002436 <brelse>
    ip->valid = 1;
    80002b7a:	4785                	li	a5,1
    80002b7c:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002b7e:	04449783          	lh	a5,68(s1)
    80002b82:	c399                	beqz	a5,80002b88 <ilock+0xb6>
    80002b84:	6902                	ld	s2,0(sp)
    80002b86:	b7bd                	j	80002af4 <ilock+0x22>
      panic("ilock: no type");
    80002b88:	00006517          	auipc	a0,0x6
    80002b8c:	8d050513          	addi	a0,a0,-1840 # 80008458 <etext+0x458>
    80002b90:	00003097          	auipc	ra,0x3
    80002b94:	11e080e7          	jalr	286(ra) # 80005cae <panic>

0000000080002b98 <iunlock>:
{
    80002b98:	1101                	addi	sp,sp,-32
    80002b9a:	ec06                	sd	ra,24(sp)
    80002b9c:	e822                	sd	s0,16(sp)
    80002b9e:	e426                	sd	s1,8(sp)
    80002ba0:	e04a                	sd	s2,0(sp)
    80002ba2:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002ba4:	c905                	beqz	a0,80002bd4 <iunlock+0x3c>
    80002ba6:	84aa                	mv	s1,a0
    80002ba8:	01050913          	addi	s2,a0,16
    80002bac:	854a                	mv	a0,s2
    80002bae:	00001097          	auipc	ra,0x1
    80002bb2:	cc4080e7          	jalr	-828(ra) # 80003872 <holdingsleep>
    80002bb6:	cd19                	beqz	a0,80002bd4 <iunlock+0x3c>
    80002bb8:	449c                	lw	a5,8(s1)
    80002bba:	00f05d63          	blez	a5,80002bd4 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002bbe:	854a                	mv	a0,s2
    80002bc0:	00001097          	auipc	ra,0x1
    80002bc4:	c6e080e7          	jalr	-914(ra) # 8000382e <releasesleep>
}
    80002bc8:	60e2                	ld	ra,24(sp)
    80002bca:	6442                	ld	s0,16(sp)
    80002bcc:	64a2                	ld	s1,8(sp)
    80002bce:	6902                	ld	s2,0(sp)
    80002bd0:	6105                	addi	sp,sp,32
    80002bd2:	8082                	ret
    panic("iunlock");
    80002bd4:	00006517          	auipc	a0,0x6
    80002bd8:	89450513          	addi	a0,a0,-1900 # 80008468 <etext+0x468>
    80002bdc:	00003097          	auipc	ra,0x3
    80002be0:	0d2080e7          	jalr	210(ra) # 80005cae <panic>

0000000080002be4 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002be4:	7179                	addi	sp,sp,-48
    80002be6:	f406                	sd	ra,40(sp)
    80002be8:	f022                	sd	s0,32(sp)
    80002bea:	ec26                	sd	s1,24(sp)
    80002bec:	e84a                	sd	s2,16(sp)
    80002bee:	e44e                	sd	s3,8(sp)
    80002bf0:	1800                	addi	s0,sp,48
    80002bf2:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002bf4:	05050493          	addi	s1,a0,80
    80002bf8:	08050913          	addi	s2,a0,128
    80002bfc:	a021                	j	80002c04 <itrunc+0x20>
    80002bfe:	0491                	addi	s1,s1,4
    80002c00:	01248d63          	beq	s1,s2,80002c1a <itrunc+0x36>
    if(ip->addrs[i]){
    80002c04:	408c                	lw	a1,0(s1)
    80002c06:	dde5                	beqz	a1,80002bfe <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    80002c08:	0009a503          	lw	a0,0(s3)
    80002c0c:	00000097          	auipc	ra,0x0
    80002c10:	93a080e7          	jalr	-1734(ra) # 80002546 <bfree>
      ip->addrs[i] = 0;
    80002c14:	0004a023          	sw	zero,0(s1)
    80002c18:	b7dd                	j	80002bfe <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002c1a:	0809a583          	lw	a1,128(s3)
    80002c1e:	ed99                	bnez	a1,80002c3c <itrunc+0x58>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002c20:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002c24:	854e                	mv	a0,s3
    80002c26:	00000097          	auipc	ra,0x0
    80002c2a:	de0080e7          	jalr	-544(ra) # 80002a06 <iupdate>
}
    80002c2e:	70a2                	ld	ra,40(sp)
    80002c30:	7402                	ld	s0,32(sp)
    80002c32:	64e2                	ld	s1,24(sp)
    80002c34:	6942                	ld	s2,16(sp)
    80002c36:	69a2                	ld	s3,8(sp)
    80002c38:	6145                	addi	sp,sp,48
    80002c3a:	8082                	ret
    80002c3c:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002c3e:	0009a503          	lw	a0,0(s3)
    80002c42:	fffff097          	auipc	ra,0xfffff
    80002c46:	6c4080e7          	jalr	1732(ra) # 80002306 <bread>
    80002c4a:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002c4c:	05850493          	addi	s1,a0,88
    80002c50:	45850913          	addi	s2,a0,1112
    80002c54:	a021                	j	80002c5c <itrunc+0x78>
    80002c56:	0491                	addi	s1,s1,4
    80002c58:	01248b63          	beq	s1,s2,80002c6e <itrunc+0x8a>
      if(a[j])
    80002c5c:	408c                	lw	a1,0(s1)
    80002c5e:	dde5                	beqz	a1,80002c56 <itrunc+0x72>
        bfree(ip->dev, a[j]);
    80002c60:	0009a503          	lw	a0,0(s3)
    80002c64:	00000097          	auipc	ra,0x0
    80002c68:	8e2080e7          	jalr	-1822(ra) # 80002546 <bfree>
    80002c6c:	b7ed                	j	80002c56 <itrunc+0x72>
    brelse(bp);
    80002c6e:	8552                	mv	a0,s4
    80002c70:	fffff097          	auipc	ra,0xfffff
    80002c74:	7c6080e7          	jalr	1990(ra) # 80002436 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002c78:	0809a583          	lw	a1,128(s3)
    80002c7c:	0009a503          	lw	a0,0(s3)
    80002c80:	00000097          	auipc	ra,0x0
    80002c84:	8c6080e7          	jalr	-1850(ra) # 80002546 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002c88:	0809a023          	sw	zero,128(s3)
    80002c8c:	6a02                	ld	s4,0(sp)
    80002c8e:	bf49                	j	80002c20 <itrunc+0x3c>

0000000080002c90 <iput>:
{
    80002c90:	1101                	addi	sp,sp,-32
    80002c92:	ec06                	sd	ra,24(sp)
    80002c94:	e822                	sd	s0,16(sp)
    80002c96:	e426                	sd	s1,8(sp)
    80002c98:	1000                	addi	s0,sp,32
    80002c9a:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002c9c:	00013517          	auipc	a0,0x13
    80002ca0:	cec50513          	addi	a0,a0,-788 # 80015988 <itable>
    80002ca4:	00003097          	auipc	ra,0x3
    80002ca8:	59a080e7          	jalr	1434(ra) # 8000623e <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002cac:	4498                	lw	a4,8(s1)
    80002cae:	4785                	li	a5,1
    80002cb0:	02f70263          	beq	a4,a5,80002cd4 <iput+0x44>
  ip->ref--;
    80002cb4:	449c                	lw	a5,8(s1)
    80002cb6:	37fd                	addiw	a5,a5,-1
    80002cb8:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002cba:	00013517          	auipc	a0,0x13
    80002cbe:	cce50513          	addi	a0,a0,-818 # 80015988 <itable>
    80002cc2:	00003097          	auipc	ra,0x3
    80002cc6:	62c080e7          	jalr	1580(ra) # 800062ee <release>
}
    80002cca:	60e2                	ld	ra,24(sp)
    80002ccc:	6442                	ld	s0,16(sp)
    80002cce:	64a2                	ld	s1,8(sp)
    80002cd0:	6105                	addi	sp,sp,32
    80002cd2:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002cd4:	40bc                	lw	a5,64(s1)
    80002cd6:	dff9                	beqz	a5,80002cb4 <iput+0x24>
    80002cd8:	04a49783          	lh	a5,74(s1)
    80002cdc:	ffe1                	bnez	a5,80002cb4 <iput+0x24>
    80002cde:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    80002ce0:	01048793          	addi	a5,s1,16
    80002ce4:	893e                	mv	s2,a5
    80002ce6:	853e                	mv	a0,a5
    80002ce8:	00001097          	auipc	ra,0x1
    80002cec:	af0080e7          	jalr	-1296(ra) # 800037d8 <acquiresleep>
    release(&itable.lock);
    80002cf0:	00013517          	auipc	a0,0x13
    80002cf4:	c9850513          	addi	a0,a0,-872 # 80015988 <itable>
    80002cf8:	00003097          	auipc	ra,0x3
    80002cfc:	5f6080e7          	jalr	1526(ra) # 800062ee <release>
    itrunc(ip);
    80002d00:	8526                	mv	a0,s1
    80002d02:	00000097          	auipc	ra,0x0
    80002d06:	ee2080e7          	jalr	-286(ra) # 80002be4 <itrunc>
    ip->type = 0;
    80002d0a:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002d0e:	8526                	mv	a0,s1
    80002d10:	00000097          	auipc	ra,0x0
    80002d14:	cf6080e7          	jalr	-778(ra) # 80002a06 <iupdate>
    ip->valid = 0;
    80002d18:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002d1c:	854a                	mv	a0,s2
    80002d1e:	00001097          	auipc	ra,0x1
    80002d22:	b10080e7          	jalr	-1264(ra) # 8000382e <releasesleep>
    acquire(&itable.lock);
    80002d26:	00013517          	auipc	a0,0x13
    80002d2a:	c6250513          	addi	a0,a0,-926 # 80015988 <itable>
    80002d2e:	00003097          	auipc	ra,0x3
    80002d32:	510080e7          	jalr	1296(ra) # 8000623e <acquire>
    80002d36:	6902                	ld	s2,0(sp)
    80002d38:	bfb5                	j	80002cb4 <iput+0x24>

0000000080002d3a <iunlockput>:
{
    80002d3a:	1101                	addi	sp,sp,-32
    80002d3c:	ec06                	sd	ra,24(sp)
    80002d3e:	e822                	sd	s0,16(sp)
    80002d40:	e426                	sd	s1,8(sp)
    80002d42:	1000                	addi	s0,sp,32
    80002d44:	84aa                	mv	s1,a0
  iunlock(ip);
    80002d46:	00000097          	auipc	ra,0x0
    80002d4a:	e52080e7          	jalr	-430(ra) # 80002b98 <iunlock>
  iput(ip);
    80002d4e:	8526                	mv	a0,s1
    80002d50:	00000097          	auipc	ra,0x0
    80002d54:	f40080e7          	jalr	-192(ra) # 80002c90 <iput>
}
    80002d58:	60e2                	ld	ra,24(sp)
    80002d5a:	6442                	ld	s0,16(sp)
    80002d5c:	64a2                	ld	s1,8(sp)
    80002d5e:	6105                	addi	sp,sp,32
    80002d60:	8082                	ret

0000000080002d62 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002d62:	1141                	addi	sp,sp,-16
    80002d64:	e406                	sd	ra,8(sp)
    80002d66:	e022                	sd	s0,0(sp)
    80002d68:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002d6a:	411c                	lw	a5,0(a0)
    80002d6c:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002d6e:	415c                	lw	a5,4(a0)
    80002d70:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002d72:	04451783          	lh	a5,68(a0)
    80002d76:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002d7a:	04a51783          	lh	a5,74(a0)
    80002d7e:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002d82:	04c56783          	lwu	a5,76(a0)
    80002d86:	e99c                	sd	a5,16(a1)
}
    80002d88:	60a2                	ld	ra,8(sp)
    80002d8a:	6402                	ld	s0,0(sp)
    80002d8c:	0141                	addi	sp,sp,16
    80002d8e:	8082                	ret

0000000080002d90 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002d90:	457c                	lw	a5,76(a0)
    80002d92:	0ed7ea63          	bltu	a5,a3,80002e86 <readi+0xf6>
{
    80002d96:	7159                	addi	sp,sp,-112
    80002d98:	f486                	sd	ra,104(sp)
    80002d9a:	f0a2                	sd	s0,96(sp)
    80002d9c:	eca6                	sd	s1,88(sp)
    80002d9e:	fc56                	sd	s5,56(sp)
    80002da0:	f85a                	sd	s6,48(sp)
    80002da2:	f45e                	sd	s7,40(sp)
    80002da4:	ec66                	sd	s9,24(sp)
    80002da6:	1880                	addi	s0,sp,112
    80002da8:	8baa                	mv	s7,a0
    80002daa:	8cae                	mv	s9,a1
    80002dac:	8ab2                	mv	s5,a2
    80002dae:	84b6                	mv	s1,a3
    80002db0:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002db2:	9f35                	addw	a4,a4,a3
    return 0;
    80002db4:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002db6:	0ad76763          	bltu	a4,a3,80002e64 <readi+0xd4>
    80002dba:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    80002dbc:	00e7f463          	bgeu	a5,a4,80002dc4 <readi+0x34>
    n = ip->size - off;
    80002dc0:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002dc4:	0a0b0f63          	beqz	s6,80002e82 <readi+0xf2>
    80002dc8:	e8ca                	sd	s2,80(sp)
    80002dca:	e0d2                	sd	s4,64(sp)
    80002dcc:	f062                	sd	s8,32(sp)
    80002dce:	e86a                	sd	s10,16(sp)
    80002dd0:	e46e                	sd	s11,8(sp)
    80002dd2:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002dd4:	40000d93          	li	s11,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002dd8:	5d7d                	li	s10,-1
    80002dda:	a82d                	j	80002e14 <readi+0x84>
    80002ddc:	020a1c13          	slli	s8,s4,0x20
    80002de0:	020c5c13          	srli	s8,s8,0x20
    80002de4:	05890613          	addi	a2,s2,88
    80002de8:	86e2                	mv	a3,s8
    80002dea:	963e                	add	a2,a2,a5
    80002dec:	85d6                	mv	a1,s5
    80002dee:	8566                	mv	a0,s9
    80002df0:	fffff097          	auipc	ra,0xfffff
    80002df4:	b3a080e7          	jalr	-1222(ra) # 8000192a <either_copyout>
    80002df8:	05a50963          	beq	a0,s10,80002e4a <readi+0xba>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002dfc:	854a                	mv	a0,s2
    80002dfe:	fffff097          	auipc	ra,0xfffff
    80002e02:	638080e7          	jalr	1592(ra) # 80002436 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002e06:	013a09bb          	addw	s3,s4,s3
    80002e0a:	009a04bb          	addw	s1,s4,s1
    80002e0e:	9ae2                	add	s5,s5,s8
    80002e10:	0769f363          	bgeu	s3,s6,80002e76 <readi+0xe6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002e14:	000ba903          	lw	s2,0(s7)
    80002e18:	00a4d59b          	srliw	a1,s1,0xa
    80002e1c:	855e                	mv	a0,s7
    80002e1e:	00000097          	auipc	ra,0x0
    80002e22:	8ba080e7          	jalr	-1862(ra) # 800026d8 <bmap>
    80002e26:	85aa                	mv	a1,a0
    80002e28:	854a                	mv	a0,s2
    80002e2a:	fffff097          	auipc	ra,0xfffff
    80002e2e:	4dc080e7          	jalr	1244(ra) # 80002306 <bread>
    80002e32:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002e34:	3ff4f793          	andi	a5,s1,1023
    80002e38:	40fd873b          	subw	a4,s11,a5
    80002e3c:	413b06bb          	subw	a3,s6,s3
    80002e40:	8a3a                	mv	s4,a4
    80002e42:	f8e6fde3          	bgeu	a3,a4,80002ddc <readi+0x4c>
    80002e46:	8a36                	mv	s4,a3
    80002e48:	bf51                	j	80002ddc <readi+0x4c>
      brelse(bp);
    80002e4a:	854a                	mv	a0,s2
    80002e4c:	fffff097          	auipc	ra,0xfffff
    80002e50:	5ea080e7          	jalr	1514(ra) # 80002436 <brelse>
      tot = -1;
    80002e54:	59fd                	li	s3,-1
      break;
    80002e56:	6946                	ld	s2,80(sp)
    80002e58:	6a06                	ld	s4,64(sp)
    80002e5a:	7c02                	ld	s8,32(sp)
    80002e5c:	6d42                	ld	s10,16(sp)
    80002e5e:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002e60:	854e                	mv	a0,s3
    80002e62:	69a6                	ld	s3,72(sp)
}
    80002e64:	70a6                	ld	ra,104(sp)
    80002e66:	7406                	ld	s0,96(sp)
    80002e68:	64e6                	ld	s1,88(sp)
    80002e6a:	7ae2                	ld	s5,56(sp)
    80002e6c:	7b42                	ld	s6,48(sp)
    80002e6e:	7ba2                	ld	s7,40(sp)
    80002e70:	6ce2                	ld	s9,24(sp)
    80002e72:	6165                	addi	sp,sp,112
    80002e74:	8082                	ret
    80002e76:	6946                	ld	s2,80(sp)
    80002e78:	6a06                	ld	s4,64(sp)
    80002e7a:	7c02                	ld	s8,32(sp)
    80002e7c:	6d42                	ld	s10,16(sp)
    80002e7e:	6da2                	ld	s11,8(sp)
    80002e80:	b7c5                	j	80002e60 <readi+0xd0>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002e82:	89da                	mv	s3,s6
    80002e84:	bff1                	j	80002e60 <readi+0xd0>
    return 0;
    80002e86:	4501                	li	a0,0
}
    80002e88:	8082                	ret

0000000080002e8a <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002e8a:	457c                	lw	a5,76(a0)
    80002e8c:	10d7e963          	bltu	a5,a3,80002f9e <writei+0x114>
{
    80002e90:	7159                	addi	sp,sp,-112
    80002e92:	f486                	sd	ra,104(sp)
    80002e94:	f0a2                	sd	s0,96(sp)
    80002e96:	e8ca                	sd	s2,80(sp)
    80002e98:	fc56                	sd	s5,56(sp)
    80002e9a:	f45e                	sd	s7,40(sp)
    80002e9c:	f062                	sd	s8,32(sp)
    80002e9e:	ec66                	sd	s9,24(sp)
    80002ea0:	1880                	addi	s0,sp,112
    80002ea2:	8baa                	mv	s7,a0
    80002ea4:	8cae                	mv	s9,a1
    80002ea6:	8ab2                	mv	s5,a2
    80002ea8:	8936                	mv	s2,a3
    80002eaa:	8c3a                	mv	s8,a4
  if(off > ip->size || off + n < off)
    80002eac:	00e687bb          	addw	a5,a3,a4
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002eb0:	00043737          	lui	a4,0x43
    80002eb4:	0ef76763          	bltu	a4,a5,80002fa2 <writei+0x118>
    80002eb8:	0ed7e563          	bltu	a5,a3,80002fa2 <writei+0x118>
    80002ebc:	e0d2                	sd	s4,64(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002ebe:	0c0c0863          	beqz	s8,80002f8e <writei+0x104>
    80002ec2:	eca6                	sd	s1,88(sp)
    80002ec4:	e4ce                	sd	s3,72(sp)
    80002ec6:	f85a                	sd	s6,48(sp)
    80002ec8:	e86a                	sd	s10,16(sp)
    80002eca:	e46e                	sd	s11,8(sp)
    80002ecc:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002ece:	40000d93          	li	s11,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002ed2:	5d7d                	li	s10,-1
    80002ed4:	a091                	j	80002f18 <writei+0x8e>
    80002ed6:	02099b13          	slli	s6,s3,0x20
    80002eda:	020b5b13          	srli	s6,s6,0x20
    80002ede:	05848513          	addi	a0,s1,88
    80002ee2:	86da                	mv	a3,s6
    80002ee4:	8656                	mv	a2,s5
    80002ee6:	85e6                	mv	a1,s9
    80002ee8:	953e                	add	a0,a0,a5
    80002eea:	fffff097          	auipc	ra,0xfffff
    80002eee:	a96080e7          	jalr	-1386(ra) # 80001980 <either_copyin>
    80002ef2:	05a50e63          	beq	a0,s10,80002f4e <writei+0xc4>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002ef6:	8526                	mv	a0,s1
    80002ef8:	00000097          	auipc	ra,0x0
    80002efc:	7c0080e7          	jalr	1984(ra) # 800036b8 <log_write>
    brelse(bp);
    80002f00:	8526                	mv	a0,s1
    80002f02:	fffff097          	auipc	ra,0xfffff
    80002f06:	534080e7          	jalr	1332(ra) # 80002436 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f0a:	01498a3b          	addw	s4,s3,s4
    80002f0e:	0129893b          	addw	s2,s3,s2
    80002f12:	9ada                	add	s5,s5,s6
    80002f14:	058a7263          	bgeu	s4,s8,80002f58 <writei+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002f18:	000ba483          	lw	s1,0(s7)
    80002f1c:	00a9559b          	srliw	a1,s2,0xa
    80002f20:	855e                	mv	a0,s7
    80002f22:	fffff097          	auipc	ra,0xfffff
    80002f26:	7b6080e7          	jalr	1974(ra) # 800026d8 <bmap>
    80002f2a:	85aa                	mv	a1,a0
    80002f2c:	8526                	mv	a0,s1
    80002f2e:	fffff097          	auipc	ra,0xfffff
    80002f32:	3d8080e7          	jalr	984(ra) # 80002306 <bread>
    80002f36:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f38:	3ff97793          	andi	a5,s2,1023
    80002f3c:	40fd873b          	subw	a4,s11,a5
    80002f40:	414c06bb          	subw	a3,s8,s4
    80002f44:	89ba                	mv	s3,a4
    80002f46:	f8e6f8e3          	bgeu	a3,a4,80002ed6 <writei+0x4c>
    80002f4a:	89b6                	mv	s3,a3
    80002f4c:	b769                	j	80002ed6 <writei+0x4c>
      brelse(bp);
    80002f4e:	8526                	mv	a0,s1
    80002f50:	fffff097          	auipc	ra,0xfffff
    80002f54:	4e6080e7          	jalr	1254(ra) # 80002436 <brelse>
  }

  if(off > ip->size)
    80002f58:	04cba783          	lw	a5,76(s7)
    80002f5c:	0327fb63          	bgeu	a5,s2,80002f92 <writei+0x108>
    ip->size = off;
    80002f60:	052ba623          	sw	s2,76(s7)
    80002f64:	64e6                	ld	s1,88(sp)
    80002f66:	69a6                	ld	s3,72(sp)
    80002f68:	7b42                	ld	s6,48(sp)
    80002f6a:	6d42                	ld	s10,16(sp)
    80002f6c:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002f6e:	855e                	mv	a0,s7
    80002f70:	00000097          	auipc	ra,0x0
    80002f74:	a96080e7          	jalr	-1386(ra) # 80002a06 <iupdate>

  return tot;
    80002f78:	8552                	mv	a0,s4
    80002f7a:	6a06                	ld	s4,64(sp)
}
    80002f7c:	70a6                	ld	ra,104(sp)
    80002f7e:	7406                	ld	s0,96(sp)
    80002f80:	6946                	ld	s2,80(sp)
    80002f82:	7ae2                	ld	s5,56(sp)
    80002f84:	7ba2                	ld	s7,40(sp)
    80002f86:	7c02                	ld	s8,32(sp)
    80002f88:	6ce2                	ld	s9,24(sp)
    80002f8a:	6165                	addi	sp,sp,112
    80002f8c:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f8e:	8a62                	mv	s4,s8
    80002f90:	bff9                	j	80002f6e <writei+0xe4>
    80002f92:	64e6                	ld	s1,88(sp)
    80002f94:	69a6                	ld	s3,72(sp)
    80002f96:	7b42                	ld	s6,48(sp)
    80002f98:	6d42                	ld	s10,16(sp)
    80002f9a:	6da2                	ld	s11,8(sp)
    80002f9c:	bfc9                	j	80002f6e <writei+0xe4>
    return -1;
    80002f9e:	557d                	li	a0,-1
}
    80002fa0:	8082                	ret
    return -1;
    80002fa2:	557d                	li	a0,-1
    80002fa4:	bfe1                	j	80002f7c <writei+0xf2>

0000000080002fa6 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002fa6:	1141                	addi	sp,sp,-16
    80002fa8:	e406                	sd	ra,8(sp)
    80002faa:	e022                	sd	s0,0(sp)
    80002fac:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002fae:	4639                	li	a2,14
    80002fb0:	ffffd097          	auipc	ra,0xffffd
    80002fb4:	2b2080e7          	jalr	690(ra) # 80000262 <strncmp>
}
    80002fb8:	60a2                	ld	ra,8(sp)
    80002fba:	6402                	ld	s0,0(sp)
    80002fbc:	0141                	addi	sp,sp,16
    80002fbe:	8082                	ret

0000000080002fc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002fc0:	711d                	addi	sp,sp,-96
    80002fc2:	ec86                	sd	ra,88(sp)
    80002fc4:	e8a2                	sd	s0,80(sp)
    80002fc6:	e4a6                	sd	s1,72(sp)
    80002fc8:	e0ca                	sd	s2,64(sp)
    80002fca:	fc4e                	sd	s3,56(sp)
    80002fcc:	f852                	sd	s4,48(sp)
    80002fce:	f456                	sd	s5,40(sp)
    80002fd0:	f05a                	sd	s6,32(sp)
    80002fd2:	ec5e                	sd	s7,24(sp)
    80002fd4:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002fd6:	04451703          	lh	a4,68(a0)
    80002fda:	4785                	li	a5,1
    80002fdc:	00f71f63          	bne	a4,a5,80002ffa <dirlookup+0x3a>
    80002fe0:	892a                	mv	s2,a0
    80002fe2:	8aae                	mv	s5,a1
    80002fe4:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002fe6:	457c                	lw	a5,76(a0)
    80002fe8:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002fea:	fa040a13          	addi	s4,s0,-96
    80002fee:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    80002ff0:	fa240b13          	addi	s6,s0,-94
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002ff4:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002ff6:	e79d                	bnez	a5,80003024 <dirlookup+0x64>
    80002ff8:	a88d                	j	8000306a <dirlookup+0xaa>
    panic("dirlookup not DIR");
    80002ffa:	00005517          	auipc	a0,0x5
    80002ffe:	47650513          	addi	a0,a0,1142 # 80008470 <etext+0x470>
    80003002:	00003097          	auipc	ra,0x3
    80003006:	cac080e7          	jalr	-852(ra) # 80005cae <panic>
      panic("dirlookup read");
    8000300a:	00005517          	auipc	a0,0x5
    8000300e:	47e50513          	addi	a0,a0,1150 # 80008488 <etext+0x488>
    80003012:	00003097          	auipc	ra,0x3
    80003016:	c9c080e7          	jalr	-868(ra) # 80005cae <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000301a:	24c1                	addiw	s1,s1,16
    8000301c:	04c92783          	lw	a5,76(s2)
    80003020:	04f4f463          	bgeu	s1,a5,80003068 <dirlookup+0xa8>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003024:	874e                	mv	a4,s3
    80003026:	86a6                	mv	a3,s1
    80003028:	8652                	mv	a2,s4
    8000302a:	4581                	li	a1,0
    8000302c:	854a                	mv	a0,s2
    8000302e:	00000097          	auipc	ra,0x0
    80003032:	d62080e7          	jalr	-670(ra) # 80002d90 <readi>
    80003036:	fd351ae3          	bne	a0,s3,8000300a <dirlookup+0x4a>
    if(de.inum == 0)
    8000303a:	fa045783          	lhu	a5,-96(s0)
    8000303e:	dff1                	beqz	a5,8000301a <dirlookup+0x5a>
    if(namecmp(name, de.name) == 0){
    80003040:	85da                	mv	a1,s6
    80003042:	8556                	mv	a0,s5
    80003044:	00000097          	auipc	ra,0x0
    80003048:	f62080e7          	jalr	-158(ra) # 80002fa6 <namecmp>
    8000304c:	f579                	bnez	a0,8000301a <dirlookup+0x5a>
      if(poff)
    8000304e:	000b8463          	beqz	s7,80003056 <dirlookup+0x96>
        *poff = off;
    80003052:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    80003056:	fa045583          	lhu	a1,-96(s0)
    8000305a:	00092503          	lw	a0,0(s2)
    8000305e:	fffff097          	auipc	ra,0xfffff
    80003062:	748080e7          	jalr	1864(ra) # 800027a6 <iget>
    80003066:	a011                	j	8000306a <dirlookup+0xaa>
  return 0;
    80003068:	4501                	li	a0,0
}
    8000306a:	60e6                	ld	ra,88(sp)
    8000306c:	6446                	ld	s0,80(sp)
    8000306e:	64a6                	ld	s1,72(sp)
    80003070:	6906                	ld	s2,64(sp)
    80003072:	79e2                	ld	s3,56(sp)
    80003074:	7a42                	ld	s4,48(sp)
    80003076:	7aa2                	ld	s5,40(sp)
    80003078:	7b02                	ld	s6,32(sp)
    8000307a:	6be2                	ld	s7,24(sp)
    8000307c:	6125                	addi	sp,sp,96
    8000307e:	8082                	ret

0000000080003080 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003080:	711d                	addi	sp,sp,-96
    80003082:	ec86                	sd	ra,88(sp)
    80003084:	e8a2                	sd	s0,80(sp)
    80003086:	e4a6                	sd	s1,72(sp)
    80003088:	e0ca                	sd	s2,64(sp)
    8000308a:	fc4e                	sd	s3,56(sp)
    8000308c:	f852                	sd	s4,48(sp)
    8000308e:	f456                	sd	s5,40(sp)
    80003090:	f05a                	sd	s6,32(sp)
    80003092:	ec5e                	sd	s7,24(sp)
    80003094:	e862                	sd	s8,16(sp)
    80003096:	e466                	sd	s9,8(sp)
    80003098:	e06a                	sd	s10,0(sp)
    8000309a:	1080                	addi	s0,sp,96
    8000309c:	84aa                	mv	s1,a0
    8000309e:	8b2e                	mv	s6,a1
    800030a0:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    800030a2:	00054703          	lbu	a4,0(a0)
    800030a6:	02f00793          	li	a5,47
    800030aa:	02f70363          	beq	a4,a5,800030d0 <namex+0x50>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    800030ae:	ffffe097          	auipc	ra,0xffffe
    800030b2:	e16080e7          	jalr	-490(ra) # 80000ec4 <myproc>
    800030b6:	15053503          	ld	a0,336(a0)
    800030ba:	00000097          	auipc	ra,0x0
    800030be:	9da080e7          	jalr	-1574(ra) # 80002a94 <idup>
    800030c2:	8a2a                	mv	s4,a0
  while(*path == '/')
    800030c4:	02f00993          	li	s3,47
  if(len >= DIRSIZ)
    800030c8:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    800030ca:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    800030cc:	4b85                	li	s7,1
    800030ce:	a87d                	j	8000318c <namex+0x10c>
    ip = iget(ROOTDEV, ROOTINO);
    800030d0:	4585                	li	a1,1
    800030d2:	852e                	mv	a0,a1
    800030d4:	fffff097          	auipc	ra,0xfffff
    800030d8:	6d2080e7          	jalr	1746(ra) # 800027a6 <iget>
    800030dc:	8a2a                	mv	s4,a0
    800030de:	b7dd                	j	800030c4 <namex+0x44>
      iunlockput(ip);
    800030e0:	8552                	mv	a0,s4
    800030e2:	00000097          	auipc	ra,0x0
    800030e6:	c58080e7          	jalr	-936(ra) # 80002d3a <iunlockput>
      return 0;
    800030ea:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    800030ec:	8552                	mv	a0,s4
    800030ee:	60e6                	ld	ra,88(sp)
    800030f0:	6446                	ld	s0,80(sp)
    800030f2:	64a6                	ld	s1,72(sp)
    800030f4:	6906                	ld	s2,64(sp)
    800030f6:	79e2                	ld	s3,56(sp)
    800030f8:	7a42                	ld	s4,48(sp)
    800030fa:	7aa2                	ld	s5,40(sp)
    800030fc:	7b02                	ld	s6,32(sp)
    800030fe:	6be2                	ld	s7,24(sp)
    80003100:	6c42                	ld	s8,16(sp)
    80003102:	6ca2                	ld	s9,8(sp)
    80003104:	6d02                	ld	s10,0(sp)
    80003106:	6125                	addi	sp,sp,96
    80003108:	8082                	ret
      iunlock(ip);
    8000310a:	8552                	mv	a0,s4
    8000310c:	00000097          	auipc	ra,0x0
    80003110:	a8c080e7          	jalr	-1396(ra) # 80002b98 <iunlock>
      return ip;
    80003114:	bfe1                	j	800030ec <namex+0x6c>
      iunlockput(ip);
    80003116:	8552                	mv	a0,s4
    80003118:	00000097          	auipc	ra,0x0
    8000311c:	c22080e7          	jalr	-990(ra) # 80002d3a <iunlockput>
      return 0;
    80003120:	8a4a                	mv	s4,s2
    80003122:	b7e9                	j	800030ec <namex+0x6c>
  len = path - s;
    80003124:	40990633          	sub	a2,s2,s1
    80003128:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    8000312c:	09ac5c63          	bge	s8,s10,800031c4 <namex+0x144>
    memmove(name, s, DIRSIZ);
    80003130:	8666                	mv	a2,s9
    80003132:	85a6                	mv	a1,s1
    80003134:	8556                	mv	a0,s5
    80003136:	ffffd097          	auipc	ra,0xffffd
    8000313a:	0b4080e7          	jalr	180(ra) # 800001ea <memmove>
    8000313e:	84ca                	mv	s1,s2
  while(*path == '/')
    80003140:	0004c783          	lbu	a5,0(s1)
    80003144:	01379763          	bne	a5,s3,80003152 <namex+0xd2>
    path++;
    80003148:	0485                	addi	s1,s1,1
  while(*path == '/')
    8000314a:	0004c783          	lbu	a5,0(s1)
    8000314e:	ff378de3          	beq	a5,s3,80003148 <namex+0xc8>
    ilock(ip);
    80003152:	8552                	mv	a0,s4
    80003154:	00000097          	auipc	ra,0x0
    80003158:	97e080e7          	jalr	-1666(ra) # 80002ad2 <ilock>
    if(ip->type != T_DIR){
    8000315c:	044a1783          	lh	a5,68(s4)
    80003160:	f97790e3          	bne	a5,s7,800030e0 <namex+0x60>
    if(nameiparent && *path == '\0'){
    80003164:	000b0563          	beqz	s6,8000316e <namex+0xee>
    80003168:	0004c783          	lbu	a5,0(s1)
    8000316c:	dfd9                	beqz	a5,8000310a <namex+0x8a>
    if((next = dirlookup(ip, name, 0)) == 0){
    8000316e:	4601                	li	a2,0
    80003170:	85d6                	mv	a1,s5
    80003172:	8552                	mv	a0,s4
    80003174:	00000097          	auipc	ra,0x0
    80003178:	e4c080e7          	jalr	-436(ra) # 80002fc0 <dirlookup>
    8000317c:	892a                	mv	s2,a0
    8000317e:	dd41                	beqz	a0,80003116 <namex+0x96>
    iunlockput(ip);
    80003180:	8552                	mv	a0,s4
    80003182:	00000097          	auipc	ra,0x0
    80003186:	bb8080e7          	jalr	-1096(ra) # 80002d3a <iunlockput>
    ip = next;
    8000318a:	8a4a                	mv	s4,s2
  while(*path == '/')
    8000318c:	0004c783          	lbu	a5,0(s1)
    80003190:	01379763          	bne	a5,s3,8000319e <namex+0x11e>
    path++;
    80003194:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003196:	0004c783          	lbu	a5,0(s1)
    8000319a:	ff378de3          	beq	a5,s3,80003194 <namex+0x114>
  if(*path == 0)
    8000319e:	cf9d                	beqz	a5,800031dc <namex+0x15c>
  while(*path != '/' && *path != 0)
    800031a0:	0004c783          	lbu	a5,0(s1)
    800031a4:	fd178713          	addi	a4,a5,-47
    800031a8:	cb19                	beqz	a4,800031be <namex+0x13e>
    800031aa:	cb91                	beqz	a5,800031be <namex+0x13e>
    800031ac:	8926                	mv	s2,s1
    path++;
    800031ae:	0905                	addi	s2,s2,1
  while(*path != '/' && *path != 0)
    800031b0:	00094783          	lbu	a5,0(s2)
    800031b4:	fd178713          	addi	a4,a5,-47
    800031b8:	d735                	beqz	a4,80003124 <namex+0xa4>
    800031ba:	fbf5                	bnez	a5,800031ae <namex+0x12e>
    800031bc:	b7a5                	j	80003124 <namex+0xa4>
    800031be:	8926                	mv	s2,s1
  len = path - s;
    800031c0:	4d01                	li	s10,0
    800031c2:	4601                	li	a2,0
    memmove(name, s, len);
    800031c4:	2601                	sext.w	a2,a2
    800031c6:	85a6                	mv	a1,s1
    800031c8:	8556                	mv	a0,s5
    800031ca:	ffffd097          	auipc	ra,0xffffd
    800031ce:	020080e7          	jalr	32(ra) # 800001ea <memmove>
    name[len] = 0;
    800031d2:	9d56                	add	s10,s10,s5
    800031d4:	000d0023          	sb	zero,0(s10)
    800031d8:	84ca                	mv	s1,s2
    800031da:	b79d                	j	80003140 <namex+0xc0>
  if(nameiparent){
    800031dc:	f00b08e3          	beqz	s6,800030ec <namex+0x6c>
    iput(ip);
    800031e0:	8552                	mv	a0,s4
    800031e2:	00000097          	auipc	ra,0x0
    800031e6:	aae080e7          	jalr	-1362(ra) # 80002c90 <iput>
    return 0;
    800031ea:	4a01                	li	s4,0
    800031ec:	b701                	j	800030ec <namex+0x6c>

00000000800031ee <dirlink>:
{
    800031ee:	715d                	addi	sp,sp,-80
    800031f0:	e486                	sd	ra,72(sp)
    800031f2:	e0a2                	sd	s0,64(sp)
    800031f4:	f84a                	sd	s2,48(sp)
    800031f6:	ec56                	sd	s5,24(sp)
    800031f8:	e85a                	sd	s6,16(sp)
    800031fa:	0880                	addi	s0,sp,80
    800031fc:	892a                	mv	s2,a0
    800031fe:	8aae                	mv	s5,a1
    80003200:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003202:	4601                	li	a2,0
    80003204:	00000097          	auipc	ra,0x0
    80003208:	dbc080e7          	jalr	-580(ra) # 80002fc0 <dirlookup>
    8000320c:	e129                	bnez	a0,8000324e <dirlink+0x60>
    8000320e:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003210:	04c92483          	lw	s1,76(s2)
    80003214:	cca9                	beqz	s1,8000326e <dirlink+0x80>
    80003216:	f44e                	sd	s3,40(sp)
    80003218:	f052                	sd	s4,32(sp)
    8000321a:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000321c:	fb040a13          	addi	s4,s0,-80
    80003220:	49c1                	li	s3,16
    80003222:	874e                	mv	a4,s3
    80003224:	86a6                	mv	a3,s1
    80003226:	8652                	mv	a2,s4
    80003228:	4581                	li	a1,0
    8000322a:	854a                	mv	a0,s2
    8000322c:	00000097          	auipc	ra,0x0
    80003230:	b64080e7          	jalr	-1180(ra) # 80002d90 <readi>
    80003234:	03351363          	bne	a0,s3,8000325a <dirlink+0x6c>
    if(de.inum == 0)
    80003238:	fb045783          	lhu	a5,-80(s0)
    8000323c:	c79d                	beqz	a5,8000326a <dirlink+0x7c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000323e:	24c1                	addiw	s1,s1,16
    80003240:	04c92783          	lw	a5,76(s2)
    80003244:	fcf4efe3          	bltu	s1,a5,80003222 <dirlink+0x34>
    80003248:	79a2                	ld	s3,40(sp)
    8000324a:	7a02                	ld	s4,32(sp)
    8000324c:	a00d                	j	8000326e <dirlink+0x80>
    iput(ip);
    8000324e:	00000097          	auipc	ra,0x0
    80003252:	a42080e7          	jalr	-1470(ra) # 80002c90 <iput>
    return -1;
    80003256:	557d                	li	a0,-1
    80003258:	a0a9                	j	800032a2 <dirlink+0xb4>
      panic("dirlink read");
    8000325a:	00005517          	auipc	a0,0x5
    8000325e:	23e50513          	addi	a0,a0,574 # 80008498 <etext+0x498>
    80003262:	00003097          	auipc	ra,0x3
    80003266:	a4c080e7          	jalr	-1460(ra) # 80005cae <panic>
    8000326a:	79a2                	ld	s3,40(sp)
    8000326c:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    8000326e:	4639                	li	a2,14
    80003270:	85d6                	mv	a1,s5
    80003272:	fb240513          	addi	a0,s0,-78
    80003276:	ffffd097          	auipc	ra,0xffffd
    8000327a:	026080e7          	jalr	38(ra) # 8000029c <strncpy>
  de.inum = inum;
    8000327e:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003282:	4741                	li	a4,16
    80003284:	86a6                	mv	a3,s1
    80003286:	fb040613          	addi	a2,s0,-80
    8000328a:	4581                	li	a1,0
    8000328c:	854a                	mv	a0,s2
    8000328e:	00000097          	auipc	ra,0x0
    80003292:	bfc080e7          	jalr	-1028(ra) # 80002e8a <writei>
    80003296:	872a                	mv	a4,a0
    80003298:	47c1                	li	a5,16
  return 0;
    8000329a:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000329c:	00f71a63          	bne	a4,a5,800032b0 <dirlink+0xc2>
    800032a0:	74e2                	ld	s1,56(sp)
}
    800032a2:	60a6                	ld	ra,72(sp)
    800032a4:	6406                	ld	s0,64(sp)
    800032a6:	7942                	ld	s2,48(sp)
    800032a8:	6ae2                	ld	s5,24(sp)
    800032aa:	6b42                	ld	s6,16(sp)
    800032ac:	6161                	addi	sp,sp,80
    800032ae:	8082                	ret
    800032b0:	f44e                	sd	s3,40(sp)
    800032b2:	f052                	sd	s4,32(sp)
    panic("dirlink");
    800032b4:	00005517          	auipc	a0,0x5
    800032b8:	2f450513          	addi	a0,a0,756 # 800085a8 <etext+0x5a8>
    800032bc:	00003097          	auipc	ra,0x3
    800032c0:	9f2080e7          	jalr	-1550(ra) # 80005cae <panic>

00000000800032c4 <namei>:

struct inode*
namei(char *path)
{
    800032c4:	1101                	addi	sp,sp,-32
    800032c6:	ec06                	sd	ra,24(sp)
    800032c8:	e822                	sd	s0,16(sp)
    800032ca:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800032cc:	fe040613          	addi	a2,s0,-32
    800032d0:	4581                	li	a1,0
    800032d2:	00000097          	auipc	ra,0x0
    800032d6:	dae080e7          	jalr	-594(ra) # 80003080 <namex>
}
    800032da:	60e2                	ld	ra,24(sp)
    800032dc:	6442                	ld	s0,16(sp)
    800032de:	6105                	addi	sp,sp,32
    800032e0:	8082                	ret

00000000800032e2 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    800032e2:	1141                	addi	sp,sp,-16
    800032e4:	e406                	sd	ra,8(sp)
    800032e6:	e022                	sd	s0,0(sp)
    800032e8:	0800                	addi	s0,sp,16
    800032ea:	862e                	mv	a2,a1
  return namex(path, 1, name);
    800032ec:	4585                	li	a1,1
    800032ee:	00000097          	auipc	ra,0x0
    800032f2:	d92080e7          	jalr	-622(ra) # 80003080 <namex>
}
    800032f6:	60a2                	ld	ra,8(sp)
    800032f8:	6402                	ld	s0,0(sp)
    800032fa:	0141                	addi	sp,sp,16
    800032fc:	8082                	ret

00000000800032fe <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800032fe:	1101                	addi	sp,sp,-32
    80003300:	ec06                	sd	ra,24(sp)
    80003302:	e822                	sd	s0,16(sp)
    80003304:	e426                	sd	s1,8(sp)
    80003306:	e04a                	sd	s2,0(sp)
    80003308:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    8000330a:	00014917          	auipc	s2,0x14
    8000330e:	12690913          	addi	s2,s2,294 # 80017430 <log>
    80003312:	01892583          	lw	a1,24(s2)
    80003316:	02892503          	lw	a0,40(s2)
    8000331a:	fffff097          	auipc	ra,0xfffff
    8000331e:	fec080e7          	jalr	-20(ra) # 80002306 <bread>
    80003322:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003324:	02c92603          	lw	a2,44(s2)
    80003328:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    8000332a:	00c05f63          	blez	a2,80003348 <write_head+0x4a>
    8000332e:	00014717          	auipc	a4,0x14
    80003332:	13270713          	addi	a4,a4,306 # 80017460 <log+0x30>
    80003336:	87aa                	mv	a5,a0
    80003338:	060a                	slli	a2,a2,0x2
    8000333a:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    8000333c:	4314                	lw	a3,0(a4)
    8000333e:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80003340:	0711                	addi	a4,a4,4
    80003342:	0791                	addi	a5,a5,4
    80003344:	fec79ce3          	bne	a5,a2,8000333c <write_head+0x3e>
  }
  bwrite(buf);
    80003348:	8526                	mv	a0,s1
    8000334a:	fffff097          	auipc	ra,0xfffff
    8000334e:	0ae080e7          	jalr	174(ra) # 800023f8 <bwrite>
  brelse(buf);
    80003352:	8526                	mv	a0,s1
    80003354:	fffff097          	auipc	ra,0xfffff
    80003358:	0e2080e7          	jalr	226(ra) # 80002436 <brelse>
}
    8000335c:	60e2                	ld	ra,24(sp)
    8000335e:	6442                	ld	s0,16(sp)
    80003360:	64a2                	ld	s1,8(sp)
    80003362:	6902                	ld	s2,0(sp)
    80003364:	6105                	addi	sp,sp,32
    80003366:	8082                	ret

0000000080003368 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003368:	00014797          	auipc	a5,0x14
    8000336c:	0f47a783          	lw	a5,244(a5) # 8001745c <log+0x2c>
    80003370:	0cf05063          	blez	a5,80003430 <install_trans+0xc8>
{
    80003374:	715d                	addi	sp,sp,-80
    80003376:	e486                	sd	ra,72(sp)
    80003378:	e0a2                	sd	s0,64(sp)
    8000337a:	fc26                	sd	s1,56(sp)
    8000337c:	f84a                	sd	s2,48(sp)
    8000337e:	f44e                	sd	s3,40(sp)
    80003380:	f052                	sd	s4,32(sp)
    80003382:	ec56                	sd	s5,24(sp)
    80003384:	e85a                	sd	s6,16(sp)
    80003386:	e45e                	sd	s7,8(sp)
    80003388:	0880                	addi	s0,sp,80
    8000338a:	8b2a                	mv	s6,a0
    8000338c:	00014a97          	auipc	s5,0x14
    80003390:	0d4a8a93          	addi	s5,s5,212 # 80017460 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003394:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003396:	00014997          	auipc	s3,0x14
    8000339a:	09a98993          	addi	s3,s3,154 # 80017430 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    8000339e:	40000b93          	li	s7,1024
    800033a2:	a00d                	j	800033c4 <install_trans+0x5c>
    brelse(lbuf);
    800033a4:	854a                	mv	a0,s2
    800033a6:	fffff097          	auipc	ra,0xfffff
    800033aa:	090080e7          	jalr	144(ra) # 80002436 <brelse>
    brelse(dbuf);
    800033ae:	8526                	mv	a0,s1
    800033b0:	fffff097          	auipc	ra,0xfffff
    800033b4:	086080e7          	jalr	134(ra) # 80002436 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    800033b8:	2a05                	addiw	s4,s4,1
    800033ba:	0a91                	addi	s5,s5,4
    800033bc:	02c9a783          	lw	a5,44(s3)
    800033c0:	04fa5d63          	bge	s4,a5,8000341a <install_trans+0xb2>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    800033c4:	0189a583          	lw	a1,24(s3)
    800033c8:	014585bb          	addw	a1,a1,s4
    800033cc:	2585                	addiw	a1,a1,1
    800033ce:	0289a503          	lw	a0,40(s3)
    800033d2:	fffff097          	auipc	ra,0xfffff
    800033d6:	f34080e7          	jalr	-204(ra) # 80002306 <bread>
    800033da:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800033dc:	000aa583          	lw	a1,0(s5)
    800033e0:	0289a503          	lw	a0,40(s3)
    800033e4:	fffff097          	auipc	ra,0xfffff
    800033e8:	f22080e7          	jalr	-222(ra) # 80002306 <bread>
    800033ec:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800033ee:	865e                	mv	a2,s7
    800033f0:	05890593          	addi	a1,s2,88
    800033f4:	05850513          	addi	a0,a0,88
    800033f8:	ffffd097          	auipc	ra,0xffffd
    800033fc:	df2080e7          	jalr	-526(ra) # 800001ea <memmove>
    bwrite(dbuf);  // write dst to disk
    80003400:	8526                	mv	a0,s1
    80003402:	fffff097          	auipc	ra,0xfffff
    80003406:	ff6080e7          	jalr	-10(ra) # 800023f8 <bwrite>
    if(recovering == 0)
    8000340a:	f80b1de3          	bnez	s6,800033a4 <install_trans+0x3c>
      bunpin(dbuf);
    8000340e:	8526                	mv	a0,s1
    80003410:	fffff097          	auipc	ra,0xfffff
    80003414:	0fa080e7          	jalr	250(ra) # 8000250a <bunpin>
    80003418:	b771                	j	800033a4 <install_trans+0x3c>
}
    8000341a:	60a6                	ld	ra,72(sp)
    8000341c:	6406                	ld	s0,64(sp)
    8000341e:	74e2                	ld	s1,56(sp)
    80003420:	7942                	ld	s2,48(sp)
    80003422:	79a2                	ld	s3,40(sp)
    80003424:	7a02                	ld	s4,32(sp)
    80003426:	6ae2                	ld	s5,24(sp)
    80003428:	6b42                	ld	s6,16(sp)
    8000342a:	6ba2                	ld	s7,8(sp)
    8000342c:	6161                	addi	sp,sp,80
    8000342e:	8082                	ret
    80003430:	8082                	ret

0000000080003432 <initlog>:
{
    80003432:	7179                	addi	sp,sp,-48
    80003434:	f406                	sd	ra,40(sp)
    80003436:	f022                	sd	s0,32(sp)
    80003438:	ec26                	sd	s1,24(sp)
    8000343a:	e84a                	sd	s2,16(sp)
    8000343c:	e44e                	sd	s3,8(sp)
    8000343e:	1800                	addi	s0,sp,48
    80003440:	892a                	mv	s2,a0
    80003442:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003444:	00014497          	auipc	s1,0x14
    80003448:	fec48493          	addi	s1,s1,-20 # 80017430 <log>
    8000344c:	00005597          	auipc	a1,0x5
    80003450:	05c58593          	addi	a1,a1,92 # 800084a8 <etext+0x4a8>
    80003454:	8526                	mv	a0,s1
    80003456:	00003097          	auipc	ra,0x3
    8000345a:	d4e080e7          	jalr	-690(ra) # 800061a4 <initlock>
  log.start = sb->logstart;
    8000345e:	0149a583          	lw	a1,20(s3)
    80003462:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003464:	0109a783          	lw	a5,16(s3)
    80003468:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    8000346a:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000346e:	854a                	mv	a0,s2
    80003470:	fffff097          	auipc	ra,0xfffff
    80003474:	e96080e7          	jalr	-362(ra) # 80002306 <bread>
  log.lh.n = lh->n;
    80003478:	4d30                	lw	a2,88(a0)
    8000347a:	d4d0                	sw	a2,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000347c:	00c05f63          	blez	a2,8000349a <initlog+0x68>
    80003480:	87aa                	mv	a5,a0
    80003482:	00014717          	auipc	a4,0x14
    80003486:	fde70713          	addi	a4,a4,-34 # 80017460 <log+0x30>
    8000348a:	060a                	slli	a2,a2,0x2
    8000348c:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    8000348e:	4ff4                	lw	a3,92(a5)
    80003490:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003492:	0791                	addi	a5,a5,4
    80003494:	0711                	addi	a4,a4,4
    80003496:	fec79ce3          	bne	a5,a2,8000348e <initlog+0x5c>
  brelse(buf);
    8000349a:	fffff097          	auipc	ra,0xfffff
    8000349e:	f9c080e7          	jalr	-100(ra) # 80002436 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    800034a2:	4505                	li	a0,1
    800034a4:	00000097          	auipc	ra,0x0
    800034a8:	ec4080e7          	jalr	-316(ra) # 80003368 <install_trans>
  log.lh.n = 0;
    800034ac:	00014797          	auipc	a5,0x14
    800034b0:	fa07a823          	sw	zero,-80(a5) # 8001745c <log+0x2c>
  write_head(); // clear the log
    800034b4:	00000097          	auipc	ra,0x0
    800034b8:	e4a080e7          	jalr	-438(ra) # 800032fe <write_head>
}
    800034bc:	70a2                	ld	ra,40(sp)
    800034be:	7402                	ld	s0,32(sp)
    800034c0:	64e2                	ld	s1,24(sp)
    800034c2:	6942                	ld	s2,16(sp)
    800034c4:	69a2                	ld	s3,8(sp)
    800034c6:	6145                	addi	sp,sp,48
    800034c8:	8082                	ret

00000000800034ca <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    800034ca:	1101                	addi	sp,sp,-32
    800034cc:	ec06                	sd	ra,24(sp)
    800034ce:	e822                	sd	s0,16(sp)
    800034d0:	e426                	sd	s1,8(sp)
    800034d2:	e04a                	sd	s2,0(sp)
    800034d4:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800034d6:	00014517          	auipc	a0,0x14
    800034da:	f5a50513          	addi	a0,a0,-166 # 80017430 <log>
    800034de:	00003097          	auipc	ra,0x3
    800034e2:	d60080e7          	jalr	-672(ra) # 8000623e <acquire>
  while(1){
    if(log.committing){
    800034e6:	00014497          	auipc	s1,0x14
    800034ea:	f4a48493          	addi	s1,s1,-182 # 80017430 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800034ee:	4979                	li	s2,30
    800034f0:	a039                	j	800034fe <begin_op+0x34>
      sleep(&log, &log.lock);
    800034f2:	85a6                	mv	a1,s1
    800034f4:	8526                	mv	a0,s1
    800034f6:	ffffe097          	auipc	ra,0xffffe
    800034fa:	098080e7          	jalr	152(ra) # 8000158e <sleep>
    if(log.committing){
    800034fe:	50dc                	lw	a5,36(s1)
    80003500:	fbed                	bnez	a5,800034f2 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80003502:	5098                	lw	a4,32(s1)
    80003504:	2705                	addiw	a4,a4,1
    80003506:	0027179b          	slliw	a5,a4,0x2
    8000350a:	9fb9                	addw	a5,a5,a4
    8000350c:	0017979b          	slliw	a5,a5,0x1
    80003510:	54d4                	lw	a3,44(s1)
    80003512:	9fb5                	addw	a5,a5,a3
    80003514:	00f95963          	bge	s2,a5,80003526 <begin_op+0x5c>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    80003518:	85a6                	mv	a1,s1
    8000351a:	8526                	mv	a0,s1
    8000351c:	ffffe097          	auipc	ra,0xffffe
    80003520:	072080e7          	jalr	114(ra) # 8000158e <sleep>
    80003524:	bfe9                	j	800034fe <begin_op+0x34>
    } else {
      log.outstanding += 1;
    80003526:	00014797          	auipc	a5,0x14
    8000352a:	f2e7a523          	sw	a4,-214(a5) # 80017450 <log+0x20>
      release(&log.lock);
    8000352e:	00014517          	auipc	a0,0x14
    80003532:	f0250513          	addi	a0,a0,-254 # 80017430 <log>
    80003536:	00003097          	auipc	ra,0x3
    8000353a:	db8080e7          	jalr	-584(ra) # 800062ee <release>
      break;
    }
  }
}
    8000353e:	60e2                	ld	ra,24(sp)
    80003540:	6442                	ld	s0,16(sp)
    80003542:	64a2                	ld	s1,8(sp)
    80003544:	6902                	ld	s2,0(sp)
    80003546:	6105                	addi	sp,sp,32
    80003548:	8082                	ret

000000008000354a <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    8000354a:	7139                	addi	sp,sp,-64
    8000354c:	fc06                	sd	ra,56(sp)
    8000354e:	f822                	sd	s0,48(sp)
    80003550:	f426                	sd	s1,40(sp)
    80003552:	f04a                	sd	s2,32(sp)
    80003554:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003556:	00014497          	auipc	s1,0x14
    8000355a:	eda48493          	addi	s1,s1,-294 # 80017430 <log>
    8000355e:	8526                	mv	a0,s1
    80003560:	00003097          	auipc	ra,0x3
    80003564:	cde080e7          	jalr	-802(ra) # 8000623e <acquire>
  log.outstanding -= 1;
    80003568:	509c                	lw	a5,32(s1)
    8000356a:	37fd                	addiw	a5,a5,-1
    8000356c:	893e                	mv	s2,a5
    8000356e:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003570:	50dc                	lw	a5,36(s1)
    80003572:	efb1                	bnez	a5,800035ce <end_op+0x84>
    panic("log.committing");
  if(log.outstanding == 0){
    80003574:	06091863          	bnez	s2,800035e4 <end_op+0x9a>
    do_commit = 1;
    log.committing = 1;
    80003578:	00014497          	auipc	s1,0x14
    8000357c:	eb848493          	addi	s1,s1,-328 # 80017430 <log>
    80003580:	4785                	li	a5,1
    80003582:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003584:	8526                	mv	a0,s1
    80003586:	00003097          	auipc	ra,0x3
    8000358a:	d68080e7          	jalr	-664(ra) # 800062ee <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    8000358e:	54dc                	lw	a5,44(s1)
    80003590:	08f04063          	bgtz	a5,80003610 <end_op+0xc6>
    acquire(&log.lock);
    80003594:	00014517          	auipc	a0,0x14
    80003598:	e9c50513          	addi	a0,a0,-356 # 80017430 <log>
    8000359c:	00003097          	auipc	ra,0x3
    800035a0:	ca2080e7          	jalr	-862(ra) # 8000623e <acquire>
    log.committing = 0;
    800035a4:	00014797          	auipc	a5,0x14
    800035a8:	ea07a823          	sw	zero,-336(a5) # 80017454 <log+0x24>
    wakeup(&log);
    800035ac:	00014517          	auipc	a0,0x14
    800035b0:	e8450513          	addi	a0,a0,-380 # 80017430 <log>
    800035b4:	ffffe097          	auipc	ra,0xffffe
    800035b8:	160080e7          	jalr	352(ra) # 80001714 <wakeup>
    release(&log.lock);
    800035bc:	00014517          	auipc	a0,0x14
    800035c0:	e7450513          	addi	a0,a0,-396 # 80017430 <log>
    800035c4:	00003097          	auipc	ra,0x3
    800035c8:	d2a080e7          	jalr	-726(ra) # 800062ee <release>
}
    800035cc:	a825                	j	80003604 <end_op+0xba>
    800035ce:	ec4e                	sd	s3,24(sp)
    800035d0:	e852                	sd	s4,16(sp)
    800035d2:	e456                	sd	s5,8(sp)
    panic("log.committing");
    800035d4:	00005517          	auipc	a0,0x5
    800035d8:	edc50513          	addi	a0,a0,-292 # 800084b0 <etext+0x4b0>
    800035dc:	00002097          	auipc	ra,0x2
    800035e0:	6d2080e7          	jalr	1746(ra) # 80005cae <panic>
    wakeup(&log);
    800035e4:	00014517          	auipc	a0,0x14
    800035e8:	e4c50513          	addi	a0,a0,-436 # 80017430 <log>
    800035ec:	ffffe097          	auipc	ra,0xffffe
    800035f0:	128080e7          	jalr	296(ra) # 80001714 <wakeup>
  release(&log.lock);
    800035f4:	00014517          	auipc	a0,0x14
    800035f8:	e3c50513          	addi	a0,a0,-452 # 80017430 <log>
    800035fc:	00003097          	auipc	ra,0x3
    80003600:	cf2080e7          	jalr	-782(ra) # 800062ee <release>
}
    80003604:	70e2                	ld	ra,56(sp)
    80003606:	7442                	ld	s0,48(sp)
    80003608:	74a2                	ld	s1,40(sp)
    8000360a:	7902                	ld	s2,32(sp)
    8000360c:	6121                	addi	sp,sp,64
    8000360e:	8082                	ret
    80003610:	ec4e                	sd	s3,24(sp)
    80003612:	e852                	sd	s4,16(sp)
    80003614:	e456                	sd	s5,8(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    80003616:	00014a97          	auipc	s5,0x14
    8000361a:	e4aa8a93          	addi	s5,s5,-438 # 80017460 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    8000361e:	00014a17          	auipc	s4,0x14
    80003622:	e12a0a13          	addi	s4,s4,-494 # 80017430 <log>
    80003626:	018a2583          	lw	a1,24(s4)
    8000362a:	012585bb          	addw	a1,a1,s2
    8000362e:	2585                	addiw	a1,a1,1
    80003630:	028a2503          	lw	a0,40(s4)
    80003634:	fffff097          	auipc	ra,0xfffff
    80003638:	cd2080e7          	jalr	-814(ra) # 80002306 <bread>
    8000363c:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    8000363e:	000aa583          	lw	a1,0(s5)
    80003642:	028a2503          	lw	a0,40(s4)
    80003646:	fffff097          	auipc	ra,0xfffff
    8000364a:	cc0080e7          	jalr	-832(ra) # 80002306 <bread>
    8000364e:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003650:	40000613          	li	a2,1024
    80003654:	05850593          	addi	a1,a0,88
    80003658:	05848513          	addi	a0,s1,88
    8000365c:	ffffd097          	auipc	ra,0xffffd
    80003660:	b8e080e7          	jalr	-1138(ra) # 800001ea <memmove>
    bwrite(to);  // write the log
    80003664:	8526                	mv	a0,s1
    80003666:	fffff097          	auipc	ra,0xfffff
    8000366a:	d92080e7          	jalr	-622(ra) # 800023f8 <bwrite>
    brelse(from);
    8000366e:	854e                	mv	a0,s3
    80003670:	fffff097          	auipc	ra,0xfffff
    80003674:	dc6080e7          	jalr	-570(ra) # 80002436 <brelse>
    brelse(to);
    80003678:	8526                	mv	a0,s1
    8000367a:	fffff097          	auipc	ra,0xfffff
    8000367e:	dbc080e7          	jalr	-580(ra) # 80002436 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003682:	2905                	addiw	s2,s2,1
    80003684:	0a91                	addi	s5,s5,4
    80003686:	02ca2783          	lw	a5,44(s4)
    8000368a:	f8f94ee3          	blt	s2,a5,80003626 <end_op+0xdc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    8000368e:	00000097          	auipc	ra,0x0
    80003692:	c70080e7          	jalr	-912(ra) # 800032fe <write_head>
    install_trans(0); // Now install writes to home locations
    80003696:	4501                	li	a0,0
    80003698:	00000097          	auipc	ra,0x0
    8000369c:	cd0080e7          	jalr	-816(ra) # 80003368 <install_trans>
    log.lh.n = 0;
    800036a0:	00014797          	auipc	a5,0x14
    800036a4:	da07ae23          	sw	zero,-580(a5) # 8001745c <log+0x2c>
    write_head();    // Erase the transaction from the log
    800036a8:	00000097          	auipc	ra,0x0
    800036ac:	c56080e7          	jalr	-938(ra) # 800032fe <write_head>
    800036b0:	69e2                	ld	s3,24(sp)
    800036b2:	6a42                	ld	s4,16(sp)
    800036b4:	6aa2                	ld	s5,8(sp)
    800036b6:	bdf9                	j	80003594 <end_op+0x4a>

00000000800036b8 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800036b8:	1101                	addi	sp,sp,-32
    800036ba:	ec06                	sd	ra,24(sp)
    800036bc:	e822                	sd	s0,16(sp)
    800036be:	e426                	sd	s1,8(sp)
    800036c0:	1000                	addi	s0,sp,32
    800036c2:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800036c4:	00014517          	auipc	a0,0x14
    800036c8:	d6c50513          	addi	a0,a0,-660 # 80017430 <log>
    800036cc:	00003097          	auipc	ra,0x3
    800036d0:	b72080e7          	jalr	-1166(ra) # 8000623e <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    800036d4:	00014617          	auipc	a2,0x14
    800036d8:	d8862603          	lw	a2,-632(a2) # 8001745c <log+0x2c>
    800036dc:	47f5                	li	a5,29
    800036de:	06c7c663          	blt	a5,a2,8000374a <log_write+0x92>
    800036e2:	00014797          	auipc	a5,0x14
    800036e6:	d6a7a783          	lw	a5,-662(a5) # 8001744c <log+0x1c>
    800036ea:	37fd                	addiw	a5,a5,-1
    800036ec:	04f65f63          	bge	a2,a5,8000374a <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800036f0:	00014797          	auipc	a5,0x14
    800036f4:	d607a783          	lw	a5,-672(a5) # 80017450 <log+0x20>
    800036f8:	06f05163          	blez	a5,8000375a <log_write+0xa2>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800036fc:	4781                	li	a5,0
    800036fe:	06c05663          	blez	a2,8000376a <log_write+0xb2>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003702:	44cc                	lw	a1,12(s1)
    80003704:	00014717          	auipc	a4,0x14
    80003708:	d5c70713          	addi	a4,a4,-676 # 80017460 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000370c:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    8000370e:	4314                	lw	a3,0(a4)
    80003710:	04b68d63          	beq	a3,a1,8000376a <log_write+0xb2>
  for (i = 0; i < log.lh.n; i++) {
    80003714:	2785                	addiw	a5,a5,1
    80003716:	0711                	addi	a4,a4,4
    80003718:	fef61be3          	bne	a2,a5,8000370e <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000371c:	060a                	slli	a2,a2,0x2
    8000371e:	02060613          	addi	a2,a2,32
    80003722:	00014797          	auipc	a5,0x14
    80003726:	d0e78793          	addi	a5,a5,-754 # 80017430 <log>
    8000372a:	97b2                	add	a5,a5,a2
    8000372c:	44d8                	lw	a4,12(s1)
    8000372e:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003730:	8526                	mv	a0,s1
    80003732:	fffff097          	auipc	ra,0xfffff
    80003736:	d9c080e7          	jalr	-612(ra) # 800024ce <bpin>
    log.lh.n++;
    8000373a:	00014717          	auipc	a4,0x14
    8000373e:	cf670713          	addi	a4,a4,-778 # 80017430 <log>
    80003742:	575c                	lw	a5,44(a4)
    80003744:	2785                	addiw	a5,a5,1
    80003746:	d75c                	sw	a5,44(a4)
    80003748:	a835                	j	80003784 <log_write+0xcc>
    panic("too big a transaction");
    8000374a:	00005517          	auipc	a0,0x5
    8000374e:	d7650513          	addi	a0,a0,-650 # 800084c0 <etext+0x4c0>
    80003752:	00002097          	auipc	ra,0x2
    80003756:	55c080e7          	jalr	1372(ra) # 80005cae <panic>
    panic("log_write outside of trans");
    8000375a:	00005517          	auipc	a0,0x5
    8000375e:	d7e50513          	addi	a0,a0,-642 # 800084d8 <etext+0x4d8>
    80003762:	00002097          	auipc	ra,0x2
    80003766:	54c080e7          	jalr	1356(ra) # 80005cae <panic>
  log.lh.block[i] = b->blockno;
    8000376a:	00279693          	slli	a3,a5,0x2
    8000376e:	02068693          	addi	a3,a3,32
    80003772:	00014717          	auipc	a4,0x14
    80003776:	cbe70713          	addi	a4,a4,-834 # 80017430 <log>
    8000377a:	9736                	add	a4,a4,a3
    8000377c:	44d4                	lw	a3,12(s1)
    8000377e:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003780:	faf608e3          	beq	a2,a5,80003730 <log_write+0x78>
  }
  release(&log.lock);
    80003784:	00014517          	auipc	a0,0x14
    80003788:	cac50513          	addi	a0,a0,-852 # 80017430 <log>
    8000378c:	00003097          	auipc	ra,0x3
    80003790:	b62080e7          	jalr	-1182(ra) # 800062ee <release>
}
    80003794:	60e2                	ld	ra,24(sp)
    80003796:	6442                	ld	s0,16(sp)
    80003798:	64a2                	ld	s1,8(sp)
    8000379a:	6105                	addi	sp,sp,32
    8000379c:	8082                	ret

000000008000379e <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000379e:	1101                	addi	sp,sp,-32
    800037a0:	ec06                	sd	ra,24(sp)
    800037a2:	e822                	sd	s0,16(sp)
    800037a4:	e426                	sd	s1,8(sp)
    800037a6:	e04a                	sd	s2,0(sp)
    800037a8:	1000                	addi	s0,sp,32
    800037aa:	84aa                	mv	s1,a0
    800037ac:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    800037ae:	00005597          	auipc	a1,0x5
    800037b2:	d4a58593          	addi	a1,a1,-694 # 800084f8 <etext+0x4f8>
    800037b6:	0521                	addi	a0,a0,8
    800037b8:	00003097          	auipc	ra,0x3
    800037bc:	9ec080e7          	jalr	-1556(ra) # 800061a4 <initlock>
  lk->name = name;
    800037c0:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800037c4:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800037c8:	0204a423          	sw	zero,40(s1)
}
    800037cc:	60e2                	ld	ra,24(sp)
    800037ce:	6442                	ld	s0,16(sp)
    800037d0:	64a2                	ld	s1,8(sp)
    800037d2:	6902                	ld	s2,0(sp)
    800037d4:	6105                	addi	sp,sp,32
    800037d6:	8082                	ret

00000000800037d8 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800037d8:	1101                	addi	sp,sp,-32
    800037da:	ec06                	sd	ra,24(sp)
    800037dc:	e822                	sd	s0,16(sp)
    800037de:	e426                	sd	s1,8(sp)
    800037e0:	e04a                	sd	s2,0(sp)
    800037e2:	1000                	addi	s0,sp,32
    800037e4:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800037e6:	00850913          	addi	s2,a0,8
    800037ea:	854a                	mv	a0,s2
    800037ec:	00003097          	auipc	ra,0x3
    800037f0:	a52080e7          	jalr	-1454(ra) # 8000623e <acquire>
  while (lk->locked) {
    800037f4:	409c                	lw	a5,0(s1)
    800037f6:	cb89                	beqz	a5,80003808 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800037f8:	85ca                	mv	a1,s2
    800037fa:	8526                	mv	a0,s1
    800037fc:	ffffe097          	auipc	ra,0xffffe
    80003800:	d92080e7          	jalr	-622(ra) # 8000158e <sleep>
  while (lk->locked) {
    80003804:	409c                	lw	a5,0(s1)
    80003806:	fbed                	bnez	a5,800037f8 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003808:	4785                	li	a5,1
    8000380a:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000380c:	ffffd097          	auipc	ra,0xffffd
    80003810:	6b8080e7          	jalr	1720(ra) # 80000ec4 <myproc>
    80003814:	591c                	lw	a5,48(a0)
    80003816:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003818:	854a                	mv	a0,s2
    8000381a:	00003097          	auipc	ra,0x3
    8000381e:	ad4080e7          	jalr	-1324(ra) # 800062ee <release>
}
    80003822:	60e2                	ld	ra,24(sp)
    80003824:	6442                	ld	s0,16(sp)
    80003826:	64a2                	ld	s1,8(sp)
    80003828:	6902                	ld	s2,0(sp)
    8000382a:	6105                	addi	sp,sp,32
    8000382c:	8082                	ret

000000008000382e <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    8000382e:	1101                	addi	sp,sp,-32
    80003830:	ec06                	sd	ra,24(sp)
    80003832:	e822                	sd	s0,16(sp)
    80003834:	e426                	sd	s1,8(sp)
    80003836:	e04a                	sd	s2,0(sp)
    80003838:	1000                	addi	s0,sp,32
    8000383a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000383c:	00850913          	addi	s2,a0,8
    80003840:	854a                	mv	a0,s2
    80003842:	00003097          	auipc	ra,0x3
    80003846:	9fc080e7          	jalr	-1540(ra) # 8000623e <acquire>
  lk->locked = 0;
    8000384a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000384e:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003852:	8526                	mv	a0,s1
    80003854:	ffffe097          	auipc	ra,0xffffe
    80003858:	ec0080e7          	jalr	-320(ra) # 80001714 <wakeup>
  release(&lk->lk);
    8000385c:	854a                	mv	a0,s2
    8000385e:	00003097          	auipc	ra,0x3
    80003862:	a90080e7          	jalr	-1392(ra) # 800062ee <release>
}
    80003866:	60e2                	ld	ra,24(sp)
    80003868:	6442                	ld	s0,16(sp)
    8000386a:	64a2                	ld	s1,8(sp)
    8000386c:	6902                	ld	s2,0(sp)
    8000386e:	6105                	addi	sp,sp,32
    80003870:	8082                	ret

0000000080003872 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003872:	7179                	addi	sp,sp,-48
    80003874:	f406                	sd	ra,40(sp)
    80003876:	f022                	sd	s0,32(sp)
    80003878:	ec26                	sd	s1,24(sp)
    8000387a:	e84a                	sd	s2,16(sp)
    8000387c:	1800                	addi	s0,sp,48
    8000387e:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003880:	00850913          	addi	s2,a0,8
    80003884:	854a                	mv	a0,s2
    80003886:	00003097          	auipc	ra,0x3
    8000388a:	9b8080e7          	jalr	-1608(ra) # 8000623e <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    8000388e:	409c                	lw	a5,0(s1)
    80003890:	ef91                	bnez	a5,800038ac <holdingsleep+0x3a>
    80003892:	4481                	li	s1,0
  release(&lk->lk);
    80003894:	854a                	mv	a0,s2
    80003896:	00003097          	auipc	ra,0x3
    8000389a:	a58080e7          	jalr	-1448(ra) # 800062ee <release>
  return r;
}
    8000389e:	8526                	mv	a0,s1
    800038a0:	70a2                	ld	ra,40(sp)
    800038a2:	7402                	ld	s0,32(sp)
    800038a4:	64e2                	ld	s1,24(sp)
    800038a6:	6942                	ld	s2,16(sp)
    800038a8:	6145                	addi	sp,sp,48
    800038aa:	8082                	ret
    800038ac:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    800038ae:	0284a983          	lw	s3,40(s1)
    800038b2:	ffffd097          	auipc	ra,0xffffd
    800038b6:	612080e7          	jalr	1554(ra) # 80000ec4 <myproc>
    800038ba:	5904                	lw	s1,48(a0)
    800038bc:	413484b3          	sub	s1,s1,s3
    800038c0:	0014b493          	seqz	s1,s1
    800038c4:	69a2                	ld	s3,8(sp)
    800038c6:	b7f9                	j	80003894 <holdingsleep+0x22>

00000000800038c8 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    800038c8:	1141                	addi	sp,sp,-16
    800038ca:	e406                	sd	ra,8(sp)
    800038cc:	e022                	sd	s0,0(sp)
    800038ce:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    800038d0:	00005597          	auipc	a1,0x5
    800038d4:	c3858593          	addi	a1,a1,-968 # 80008508 <etext+0x508>
    800038d8:	00014517          	auipc	a0,0x14
    800038dc:	ca050513          	addi	a0,a0,-864 # 80017578 <ftable>
    800038e0:	00003097          	auipc	ra,0x3
    800038e4:	8c4080e7          	jalr	-1852(ra) # 800061a4 <initlock>
}
    800038e8:	60a2                	ld	ra,8(sp)
    800038ea:	6402                	ld	s0,0(sp)
    800038ec:	0141                	addi	sp,sp,16
    800038ee:	8082                	ret

00000000800038f0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800038f0:	1101                	addi	sp,sp,-32
    800038f2:	ec06                	sd	ra,24(sp)
    800038f4:	e822                	sd	s0,16(sp)
    800038f6:	e426                	sd	s1,8(sp)
    800038f8:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800038fa:	00014517          	auipc	a0,0x14
    800038fe:	c7e50513          	addi	a0,a0,-898 # 80017578 <ftable>
    80003902:	00003097          	auipc	ra,0x3
    80003906:	93c080e7          	jalr	-1732(ra) # 8000623e <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000390a:	00014497          	auipc	s1,0x14
    8000390e:	c8648493          	addi	s1,s1,-890 # 80017590 <ftable+0x18>
    80003912:	00015717          	auipc	a4,0x15
    80003916:	c1e70713          	addi	a4,a4,-994 # 80018530 <ftable+0xfb8>
    if(f->ref == 0){
    8000391a:	40dc                	lw	a5,4(s1)
    8000391c:	cf99                	beqz	a5,8000393a <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000391e:	02848493          	addi	s1,s1,40
    80003922:	fee49ce3          	bne	s1,a4,8000391a <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003926:	00014517          	auipc	a0,0x14
    8000392a:	c5250513          	addi	a0,a0,-942 # 80017578 <ftable>
    8000392e:	00003097          	auipc	ra,0x3
    80003932:	9c0080e7          	jalr	-1600(ra) # 800062ee <release>
  return 0;
    80003936:	4481                	li	s1,0
    80003938:	a819                	j	8000394e <filealloc+0x5e>
      f->ref = 1;
    8000393a:	4785                	li	a5,1
    8000393c:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    8000393e:	00014517          	auipc	a0,0x14
    80003942:	c3a50513          	addi	a0,a0,-966 # 80017578 <ftable>
    80003946:	00003097          	auipc	ra,0x3
    8000394a:	9a8080e7          	jalr	-1624(ra) # 800062ee <release>
}
    8000394e:	8526                	mv	a0,s1
    80003950:	60e2                	ld	ra,24(sp)
    80003952:	6442                	ld	s0,16(sp)
    80003954:	64a2                	ld	s1,8(sp)
    80003956:	6105                	addi	sp,sp,32
    80003958:	8082                	ret

000000008000395a <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    8000395a:	1101                	addi	sp,sp,-32
    8000395c:	ec06                	sd	ra,24(sp)
    8000395e:	e822                	sd	s0,16(sp)
    80003960:	e426                	sd	s1,8(sp)
    80003962:	1000                	addi	s0,sp,32
    80003964:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003966:	00014517          	auipc	a0,0x14
    8000396a:	c1250513          	addi	a0,a0,-1006 # 80017578 <ftable>
    8000396e:	00003097          	auipc	ra,0x3
    80003972:	8d0080e7          	jalr	-1840(ra) # 8000623e <acquire>
  if(f->ref < 1)
    80003976:	40dc                	lw	a5,4(s1)
    80003978:	02f05263          	blez	a5,8000399c <filedup+0x42>
    panic("filedup");
  f->ref++;
    8000397c:	2785                	addiw	a5,a5,1
    8000397e:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003980:	00014517          	auipc	a0,0x14
    80003984:	bf850513          	addi	a0,a0,-1032 # 80017578 <ftable>
    80003988:	00003097          	auipc	ra,0x3
    8000398c:	966080e7          	jalr	-1690(ra) # 800062ee <release>
  return f;
}
    80003990:	8526                	mv	a0,s1
    80003992:	60e2                	ld	ra,24(sp)
    80003994:	6442                	ld	s0,16(sp)
    80003996:	64a2                	ld	s1,8(sp)
    80003998:	6105                	addi	sp,sp,32
    8000399a:	8082                	ret
    panic("filedup");
    8000399c:	00005517          	auipc	a0,0x5
    800039a0:	b7450513          	addi	a0,a0,-1164 # 80008510 <etext+0x510>
    800039a4:	00002097          	auipc	ra,0x2
    800039a8:	30a080e7          	jalr	778(ra) # 80005cae <panic>

00000000800039ac <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    800039ac:	7139                	addi	sp,sp,-64
    800039ae:	fc06                	sd	ra,56(sp)
    800039b0:	f822                	sd	s0,48(sp)
    800039b2:	f426                	sd	s1,40(sp)
    800039b4:	0080                	addi	s0,sp,64
    800039b6:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    800039b8:	00014517          	auipc	a0,0x14
    800039bc:	bc050513          	addi	a0,a0,-1088 # 80017578 <ftable>
    800039c0:	00003097          	auipc	ra,0x3
    800039c4:	87e080e7          	jalr	-1922(ra) # 8000623e <acquire>
  if(f->ref < 1)
    800039c8:	40dc                	lw	a5,4(s1)
    800039ca:	04f05c63          	blez	a5,80003a22 <fileclose+0x76>
    panic("fileclose");
  if(--f->ref > 0){
    800039ce:	37fd                	addiw	a5,a5,-1
    800039d0:	c0dc                	sw	a5,4(s1)
    800039d2:	06f04463          	bgtz	a5,80003a3a <fileclose+0x8e>
    800039d6:	f04a                	sd	s2,32(sp)
    800039d8:	ec4e                	sd	s3,24(sp)
    800039da:	e852                	sd	s4,16(sp)
    800039dc:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    800039de:	0004a903          	lw	s2,0(s1)
    800039e2:	0094c783          	lbu	a5,9(s1)
    800039e6:	89be                	mv	s3,a5
    800039e8:	689c                	ld	a5,16(s1)
    800039ea:	8a3e                	mv	s4,a5
    800039ec:	6c9c                	ld	a5,24(s1)
    800039ee:	8abe                	mv	s5,a5
  f->ref = 0;
    800039f0:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    800039f4:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800039f8:	00014517          	auipc	a0,0x14
    800039fc:	b8050513          	addi	a0,a0,-1152 # 80017578 <ftable>
    80003a00:	00003097          	auipc	ra,0x3
    80003a04:	8ee080e7          	jalr	-1810(ra) # 800062ee <release>

  if(ff.type == FD_PIPE){
    80003a08:	4785                	li	a5,1
    80003a0a:	04f90563          	beq	s2,a5,80003a54 <fileclose+0xa8>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003a0e:	ffe9079b          	addiw	a5,s2,-2
    80003a12:	4705                	li	a4,1
    80003a14:	04f77b63          	bgeu	a4,a5,80003a6a <fileclose+0xbe>
    80003a18:	7902                	ld	s2,32(sp)
    80003a1a:	69e2                	ld	s3,24(sp)
    80003a1c:	6a42                	ld	s4,16(sp)
    80003a1e:	6aa2                	ld	s5,8(sp)
    80003a20:	a02d                	j	80003a4a <fileclose+0x9e>
    80003a22:	f04a                	sd	s2,32(sp)
    80003a24:	ec4e                	sd	s3,24(sp)
    80003a26:	e852                	sd	s4,16(sp)
    80003a28:	e456                	sd	s5,8(sp)
    panic("fileclose");
    80003a2a:	00005517          	auipc	a0,0x5
    80003a2e:	aee50513          	addi	a0,a0,-1298 # 80008518 <etext+0x518>
    80003a32:	00002097          	auipc	ra,0x2
    80003a36:	27c080e7          	jalr	636(ra) # 80005cae <panic>
    release(&ftable.lock);
    80003a3a:	00014517          	auipc	a0,0x14
    80003a3e:	b3e50513          	addi	a0,a0,-1218 # 80017578 <ftable>
    80003a42:	00003097          	auipc	ra,0x3
    80003a46:	8ac080e7          	jalr	-1876(ra) # 800062ee <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    80003a4a:	70e2                	ld	ra,56(sp)
    80003a4c:	7442                	ld	s0,48(sp)
    80003a4e:	74a2                	ld	s1,40(sp)
    80003a50:	6121                	addi	sp,sp,64
    80003a52:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003a54:	85ce                	mv	a1,s3
    80003a56:	8552                	mv	a0,s4
    80003a58:	00000097          	auipc	ra,0x0
    80003a5c:	3b4080e7          	jalr	948(ra) # 80003e0c <pipeclose>
    80003a60:	7902                	ld	s2,32(sp)
    80003a62:	69e2                	ld	s3,24(sp)
    80003a64:	6a42                	ld	s4,16(sp)
    80003a66:	6aa2                	ld	s5,8(sp)
    80003a68:	b7cd                	j	80003a4a <fileclose+0x9e>
    begin_op();
    80003a6a:	00000097          	auipc	ra,0x0
    80003a6e:	a60080e7          	jalr	-1440(ra) # 800034ca <begin_op>
    iput(ff.ip);
    80003a72:	8556                	mv	a0,s5
    80003a74:	fffff097          	auipc	ra,0xfffff
    80003a78:	21c080e7          	jalr	540(ra) # 80002c90 <iput>
    end_op();
    80003a7c:	00000097          	auipc	ra,0x0
    80003a80:	ace080e7          	jalr	-1330(ra) # 8000354a <end_op>
    80003a84:	7902                	ld	s2,32(sp)
    80003a86:	69e2                	ld	s3,24(sp)
    80003a88:	6a42                	ld	s4,16(sp)
    80003a8a:	6aa2                	ld	s5,8(sp)
    80003a8c:	bf7d                	j	80003a4a <fileclose+0x9e>

0000000080003a8e <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003a8e:	715d                	addi	sp,sp,-80
    80003a90:	e486                	sd	ra,72(sp)
    80003a92:	e0a2                	sd	s0,64(sp)
    80003a94:	fc26                	sd	s1,56(sp)
    80003a96:	f052                	sd	s4,32(sp)
    80003a98:	0880                	addi	s0,sp,80
    80003a9a:	84aa                	mv	s1,a0
    80003a9c:	8a2e                	mv	s4,a1
  struct proc *p = myproc();
    80003a9e:	ffffd097          	auipc	ra,0xffffd
    80003aa2:	426080e7          	jalr	1062(ra) # 80000ec4 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003aa6:	409c                	lw	a5,0(s1)
    80003aa8:	37f9                	addiw	a5,a5,-2
    80003aaa:	4705                	li	a4,1
    80003aac:	04f76a63          	bltu	a4,a5,80003b00 <filestat+0x72>
    80003ab0:	f84a                	sd	s2,48(sp)
    80003ab2:	f44e                	sd	s3,40(sp)
    80003ab4:	89aa                	mv	s3,a0
    ilock(f->ip);
    80003ab6:	6c88                	ld	a0,24(s1)
    80003ab8:	fffff097          	auipc	ra,0xfffff
    80003abc:	01a080e7          	jalr	26(ra) # 80002ad2 <ilock>
    stati(f->ip, &st);
    80003ac0:	fb840913          	addi	s2,s0,-72
    80003ac4:	85ca                	mv	a1,s2
    80003ac6:	6c88                	ld	a0,24(s1)
    80003ac8:	fffff097          	auipc	ra,0xfffff
    80003acc:	29a080e7          	jalr	666(ra) # 80002d62 <stati>
    iunlock(f->ip);
    80003ad0:	6c88                	ld	a0,24(s1)
    80003ad2:	fffff097          	auipc	ra,0xfffff
    80003ad6:	0c6080e7          	jalr	198(ra) # 80002b98 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003ada:	46e1                	li	a3,24
    80003adc:	864a                	mv	a2,s2
    80003ade:	85d2                	mv	a1,s4
    80003ae0:	0509b503          	ld	a0,80(s3)
    80003ae4:	ffffd097          	auipc	ra,0xffffd
    80003ae8:	064080e7          	jalr	100(ra) # 80000b48 <copyout>
    80003aec:	41f5551b          	sraiw	a0,a0,0x1f
    80003af0:	7942                	ld	s2,48(sp)
    80003af2:	79a2                	ld	s3,40(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003af4:	60a6                	ld	ra,72(sp)
    80003af6:	6406                	ld	s0,64(sp)
    80003af8:	74e2                	ld	s1,56(sp)
    80003afa:	7a02                	ld	s4,32(sp)
    80003afc:	6161                	addi	sp,sp,80
    80003afe:	8082                	ret
  return -1;
    80003b00:	557d                	li	a0,-1
    80003b02:	bfcd                	j	80003af4 <filestat+0x66>

0000000080003b04 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003b04:	7179                	addi	sp,sp,-48
    80003b06:	f406                	sd	ra,40(sp)
    80003b08:	f022                	sd	s0,32(sp)
    80003b0a:	e84a                	sd	s2,16(sp)
    80003b0c:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003b0e:	00854783          	lbu	a5,8(a0)
    80003b12:	cbc5                	beqz	a5,80003bc2 <fileread+0xbe>
    80003b14:	ec26                	sd	s1,24(sp)
    80003b16:	e44e                	sd	s3,8(sp)
    80003b18:	84aa                	mv	s1,a0
    80003b1a:	892e                	mv	s2,a1
    80003b1c:	89b2                	mv	s3,a2
    return -1;

  if(f->type == FD_PIPE){
    80003b1e:	411c                	lw	a5,0(a0)
    80003b20:	4705                	li	a4,1
    80003b22:	04e78963          	beq	a5,a4,80003b74 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003b26:	470d                	li	a4,3
    80003b28:	04e78f63          	beq	a5,a4,80003b86 <fileread+0x82>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003b2c:	4709                	li	a4,2
    80003b2e:	08e79263          	bne	a5,a4,80003bb2 <fileread+0xae>
    ilock(f->ip);
    80003b32:	6d08                	ld	a0,24(a0)
    80003b34:	fffff097          	auipc	ra,0xfffff
    80003b38:	f9e080e7          	jalr	-98(ra) # 80002ad2 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003b3c:	874e                	mv	a4,s3
    80003b3e:	5094                	lw	a3,32(s1)
    80003b40:	864a                	mv	a2,s2
    80003b42:	4585                	li	a1,1
    80003b44:	6c88                	ld	a0,24(s1)
    80003b46:	fffff097          	auipc	ra,0xfffff
    80003b4a:	24a080e7          	jalr	586(ra) # 80002d90 <readi>
    80003b4e:	892a                	mv	s2,a0
    80003b50:	00a05563          	blez	a0,80003b5a <fileread+0x56>
      f->off += r;
    80003b54:	509c                	lw	a5,32(s1)
    80003b56:	9fa9                	addw	a5,a5,a0
    80003b58:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003b5a:	6c88                	ld	a0,24(s1)
    80003b5c:	fffff097          	auipc	ra,0xfffff
    80003b60:	03c080e7          	jalr	60(ra) # 80002b98 <iunlock>
    80003b64:	64e2                	ld	s1,24(sp)
    80003b66:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    80003b68:	854a                	mv	a0,s2
    80003b6a:	70a2                	ld	ra,40(sp)
    80003b6c:	7402                	ld	s0,32(sp)
    80003b6e:	6942                	ld	s2,16(sp)
    80003b70:	6145                	addi	sp,sp,48
    80003b72:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003b74:	6908                	ld	a0,16(a0)
    80003b76:	00000097          	auipc	ra,0x0
    80003b7a:	422080e7          	jalr	1058(ra) # 80003f98 <piperead>
    80003b7e:	892a                	mv	s2,a0
    80003b80:	64e2                	ld	s1,24(sp)
    80003b82:	69a2                	ld	s3,8(sp)
    80003b84:	b7d5                	j	80003b68 <fileread+0x64>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003b86:	02451783          	lh	a5,36(a0)
    80003b8a:	03079693          	slli	a3,a5,0x30
    80003b8e:	92c1                	srli	a3,a3,0x30
    80003b90:	4725                	li	a4,9
    80003b92:	02d76b63          	bltu	a4,a3,80003bc8 <fileread+0xc4>
    80003b96:	0792                	slli	a5,a5,0x4
    80003b98:	00014717          	auipc	a4,0x14
    80003b9c:	94070713          	addi	a4,a4,-1728 # 800174d8 <devsw>
    80003ba0:	97ba                	add	a5,a5,a4
    80003ba2:	639c                	ld	a5,0(a5)
    80003ba4:	c79d                	beqz	a5,80003bd2 <fileread+0xce>
    r = devsw[f->major].read(1, addr, n);
    80003ba6:	4505                	li	a0,1
    80003ba8:	9782                	jalr	a5
    80003baa:	892a                	mv	s2,a0
    80003bac:	64e2                	ld	s1,24(sp)
    80003bae:	69a2                	ld	s3,8(sp)
    80003bb0:	bf65                	j	80003b68 <fileread+0x64>
    panic("fileread");
    80003bb2:	00005517          	auipc	a0,0x5
    80003bb6:	97650513          	addi	a0,a0,-1674 # 80008528 <etext+0x528>
    80003bba:	00002097          	auipc	ra,0x2
    80003bbe:	0f4080e7          	jalr	244(ra) # 80005cae <panic>
    return -1;
    80003bc2:	57fd                	li	a5,-1
    80003bc4:	893e                	mv	s2,a5
    80003bc6:	b74d                	j	80003b68 <fileread+0x64>
      return -1;
    80003bc8:	57fd                	li	a5,-1
    80003bca:	893e                	mv	s2,a5
    80003bcc:	64e2                	ld	s1,24(sp)
    80003bce:	69a2                	ld	s3,8(sp)
    80003bd0:	bf61                	j	80003b68 <fileread+0x64>
    80003bd2:	57fd                	li	a5,-1
    80003bd4:	893e                	mv	s2,a5
    80003bd6:	64e2                	ld	s1,24(sp)
    80003bd8:	69a2                	ld	s3,8(sp)
    80003bda:	b779                	j	80003b68 <fileread+0x64>

0000000080003bdc <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003bdc:	00954783          	lbu	a5,9(a0)
    80003be0:	12078d63          	beqz	a5,80003d1a <filewrite+0x13e>
{
    80003be4:	711d                	addi	sp,sp,-96
    80003be6:	ec86                	sd	ra,88(sp)
    80003be8:	e8a2                	sd	s0,80(sp)
    80003bea:	e0ca                	sd	s2,64(sp)
    80003bec:	f456                	sd	s5,40(sp)
    80003bee:	f05a                	sd	s6,32(sp)
    80003bf0:	1080                	addi	s0,sp,96
    80003bf2:	892a                	mv	s2,a0
    80003bf4:	8b2e                	mv	s6,a1
    80003bf6:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    80003bf8:	411c                	lw	a5,0(a0)
    80003bfa:	4705                	li	a4,1
    80003bfc:	02e78a63          	beq	a5,a4,80003c30 <filewrite+0x54>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003c00:	470d                	li	a4,3
    80003c02:	02e78d63          	beq	a5,a4,80003c3c <filewrite+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003c06:	4709                	li	a4,2
    80003c08:	0ee79b63          	bne	a5,a4,80003cfe <filewrite+0x122>
    80003c0c:	f852                	sd	s4,48(sp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003c0e:	0cc05663          	blez	a2,80003cda <filewrite+0xfe>
    80003c12:	e4a6                	sd	s1,72(sp)
    80003c14:	fc4e                	sd	s3,56(sp)
    80003c16:	ec5e                	sd	s7,24(sp)
    80003c18:	e862                	sd	s8,16(sp)
    80003c1a:	e466                	sd	s9,8(sp)
    int i = 0;
    80003c1c:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    80003c1e:	6b85                	lui	s7,0x1
    80003c20:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003c24:	6785                	lui	a5,0x1
    80003c26:	c007879b          	addiw	a5,a5,-1024 # c00 <_entry-0x7ffff400>
    80003c2a:	8cbe                	mv	s9,a5
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003c2c:	4c05                	li	s8,1
    80003c2e:	a849                	j	80003cc0 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003c30:	6908                	ld	a0,16(a0)
    80003c32:	00000097          	auipc	ra,0x0
    80003c36:	250080e7          	jalr	592(ra) # 80003e82 <pipewrite>
    80003c3a:	a85d                	j	80003cf0 <filewrite+0x114>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003c3c:	02451783          	lh	a5,36(a0)
    80003c40:	03079693          	slli	a3,a5,0x30
    80003c44:	92c1                	srli	a3,a3,0x30
    80003c46:	4725                	li	a4,9
    80003c48:	0cd76b63          	bltu	a4,a3,80003d1e <filewrite+0x142>
    80003c4c:	0792                	slli	a5,a5,0x4
    80003c4e:	00014717          	auipc	a4,0x14
    80003c52:	88a70713          	addi	a4,a4,-1910 # 800174d8 <devsw>
    80003c56:	97ba                	add	a5,a5,a4
    80003c58:	679c                	ld	a5,8(a5)
    80003c5a:	c7e1                	beqz	a5,80003d22 <filewrite+0x146>
    ret = devsw[f->major].write(1, addr, n);
    80003c5c:	4505                	li	a0,1
    80003c5e:	9782                	jalr	a5
    80003c60:	a841                	j	80003cf0 <filewrite+0x114>
      if(n1 > max)
    80003c62:	2981                	sext.w	s3,s3
      begin_op();
    80003c64:	00000097          	auipc	ra,0x0
    80003c68:	866080e7          	jalr	-1946(ra) # 800034ca <begin_op>
      ilock(f->ip);
    80003c6c:	01893503          	ld	a0,24(s2)
    80003c70:	fffff097          	auipc	ra,0xfffff
    80003c74:	e62080e7          	jalr	-414(ra) # 80002ad2 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003c78:	874e                	mv	a4,s3
    80003c7a:	02092683          	lw	a3,32(s2)
    80003c7e:	016a0633          	add	a2,s4,s6
    80003c82:	85e2                	mv	a1,s8
    80003c84:	01893503          	ld	a0,24(s2)
    80003c88:	fffff097          	auipc	ra,0xfffff
    80003c8c:	202080e7          	jalr	514(ra) # 80002e8a <writei>
    80003c90:	84aa                	mv	s1,a0
    80003c92:	00a05763          	blez	a0,80003ca0 <filewrite+0xc4>
        f->off += r;
    80003c96:	02092783          	lw	a5,32(s2)
    80003c9a:	9fa9                	addw	a5,a5,a0
    80003c9c:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003ca0:	01893503          	ld	a0,24(s2)
    80003ca4:	fffff097          	auipc	ra,0xfffff
    80003ca8:	ef4080e7          	jalr	-268(ra) # 80002b98 <iunlock>
      end_op();
    80003cac:	00000097          	auipc	ra,0x0
    80003cb0:	89e080e7          	jalr	-1890(ra) # 8000354a <end_op>

      if(r != n1){
    80003cb4:	02999563          	bne	s3,s1,80003cde <filewrite+0x102>
        // error from writei
        break;
      }
      i += r;
    80003cb8:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    80003cbc:	015a5963          	bge	s4,s5,80003cce <filewrite+0xf2>
      int n1 = n - i;
    80003cc0:	414a87bb          	subw	a5,s5,s4
    80003cc4:	89be                	mv	s3,a5
      if(n1 > max)
    80003cc6:	f8fbdee3          	bge	s7,a5,80003c62 <filewrite+0x86>
    80003cca:	89e6                	mv	s3,s9
    80003ccc:	bf59                	j	80003c62 <filewrite+0x86>
    80003cce:	64a6                	ld	s1,72(sp)
    80003cd0:	79e2                	ld	s3,56(sp)
    80003cd2:	6be2                	ld	s7,24(sp)
    80003cd4:	6c42                	ld	s8,16(sp)
    80003cd6:	6ca2                	ld	s9,8(sp)
    80003cd8:	a801                	j	80003ce8 <filewrite+0x10c>
    int i = 0;
    80003cda:	4a01                	li	s4,0
    80003cdc:	a031                	j	80003ce8 <filewrite+0x10c>
    80003cde:	64a6                	ld	s1,72(sp)
    80003ce0:	79e2                	ld	s3,56(sp)
    80003ce2:	6be2                	ld	s7,24(sp)
    80003ce4:	6c42                	ld	s8,16(sp)
    80003ce6:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    80003ce8:	034a9f63          	bne	s5,s4,80003d26 <filewrite+0x14a>
    80003cec:	8556                	mv	a0,s5
    80003cee:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003cf0:	60e6                	ld	ra,88(sp)
    80003cf2:	6446                	ld	s0,80(sp)
    80003cf4:	6906                	ld	s2,64(sp)
    80003cf6:	7aa2                	ld	s5,40(sp)
    80003cf8:	7b02                	ld	s6,32(sp)
    80003cfa:	6125                	addi	sp,sp,96
    80003cfc:	8082                	ret
    80003cfe:	e4a6                	sd	s1,72(sp)
    80003d00:	fc4e                	sd	s3,56(sp)
    80003d02:	f852                	sd	s4,48(sp)
    80003d04:	ec5e                	sd	s7,24(sp)
    80003d06:	e862                	sd	s8,16(sp)
    80003d08:	e466                	sd	s9,8(sp)
    panic("filewrite");
    80003d0a:	00005517          	auipc	a0,0x5
    80003d0e:	82e50513          	addi	a0,a0,-2002 # 80008538 <etext+0x538>
    80003d12:	00002097          	auipc	ra,0x2
    80003d16:	f9c080e7          	jalr	-100(ra) # 80005cae <panic>
    return -1;
    80003d1a:	557d                	li	a0,-1
}
    80003d1c:	8082                	ret
      return -1;
    80003d1e:	557d                	li	a0,-1
    80003d20:	bfc1                	j	80003cf0 <filewrite+0x114>
    80003d22:	557d                	li	a0,-1
    80003d24:	b7f1                	j	80003cf0 <filewrite+0x114>
    ret = (i == n ? n : -1);
    80003d26:	557d                	li	a0,-1
    80003d28:	7a42                	ld	s4,48(sp)
    80003d2a:	b7d9                	j	80003cf0 <filewrite+0x114>

0000000080003d2c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003d2c:	7179                	addi	sp,sp,-48
    80003d2e:	f406                	sd	ra,40(sp)
    80003d30:	f022                	sd	s0,32(sp)
    80003d32:	ec26                	sd	s1,24(sp)
    80003d34:	e052                	sd	s4,0(sp)
    80003d36:	1800                	addi	s0,sp,48
    80003d38:	84aa                	mv	s1,a0
    80003d3a:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003d3c:	0005b023          	sd	zero,0(a1)
    80003d40:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003d44:	00000097          	auipc	ra,0x0
    80003d48:	bac080e7          	jalr	-1108(ra) # 800038f0 <filealloc>
    80003d4c:	e088                	sd	a0,0(s1)
    80003d4e:	cd49                	beqz	a0,80003de8 <pipealloc+0xbc>
    80003d50:	00000097          	auipc	ra,0x0
    80003d54:	ba0080e7          	jalr	-1120(ra) # 800038f0 <filealloc>
    80003d58:	00aa3023          	sd	a0,0(s4)
    80003d5c:	c141                	beqz	a0,80003ddc <pipealloc+0xb0>
    80003d5e:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003d60:	ffffc097          	auipc	ra,0xffffc
    80003d64:	3c0080e7          	jalr	960(ra) # 80000120 <kalloc>
    80003d68:	892a                	mv	s2,a0
    80003d6a:	c13d                	beqz	a0,80003dd0 <pipealloc+0xa4>
    80003d6c:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    80003d6e:	4985                	li	s3,1
    80003d70:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003d74:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003d78:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003d7c:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003d80:	00004597          	auipc	a1,0x4
    80003d84:	7c858593          	addi	a1,a1,1992 # 80008548 <etext+0x548>
    80003d88:	00002097          	auipc	ra,0x2
    80003d8c:	41c080e7          	jalr	1052(ra) # 800061a4 <initlock>
  (*f0)->type = FD_PIPE;
    80003d90:	609c                	ld	a5,0(s1)
    80003d92:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003d96:	609c                	ld	a5,0(s1)
    80003d98:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003d9c:	609c                	ld	a5,0(s1)
    80003d9e:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003da2:	609c                	ld	a5,0(s1)
    80003da4:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003da8:	000a3783          	ld	a5,0(s4)
    80003dac:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003db0:	000a3783          	ld	a5,0(s4)
    80003db4:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003db8:	000a3783          	ld	a5,0(s4)
    80003dbc:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003dc0:	000a3783          	ld	a5,0(s4)
    80003dc4:	0127b823          	sd	s2,16(a5)
  return 0;
    80003dc8:	4501                	li	a0,0
    80003dca:	6942                	ld	s2,16(sp)
    80003dcc:	69a2                	ld	s3,8(sp)
    80003dce:	a03d                	j	80003dfc <pipealloc+0xd0>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003dd0:	6088                	ld	a0,0(s1)
    80003dd2:	c119                	beqz	a0,80003dd8 <pipealloc+0xac>
    80003dd4:	6942                	ld	s2,16(sp)
    80003dd6:	a029                	j	80003de0 <pipealloc+0xb4>
    80003dd8:	6942                	ld	s2,16(sp)
    80003dda:	a039                	j	80003de8 <pipealloc+0xbc>
    80003ddc:	6088                	ld	a0,0(s1)
    80003dde:	c50d                	beqz	a0,80003e08 <pipealloc+0xdc>
    fileclose(*f0);
    80003de0:	00000097          	auipc	ra,0x0
    80003de4:	bcc080e7          	jalr	-1076(ra) # 800039ac <fileclose>
  if(*f1)
    80003de8:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003dec:	557d                	li	a0,-1
  if(*f1)
    80003dee:	c799                	beqz	a5,80003dfc <pipealloc+0xd0>
    fileclose(*f1);
    80003df0:	853e                	mv	a0,a5
    80003df2:	00000097          	auipc	ra,0x0
    80003df6:	bba080e7          	jalr	-1094(ra) # 800039ac <fileclose>
  return -1;
    80003dfa:	557d                	li	a0,-1
}
    80003dfc:	70a2                	ld	ra,40(sp)
    80003dfe:	7402                	ld	s0,32(sp)
    80003e00:	64e2                	ld	s1,24(sp)
    80003e02:	6a02                	ld	s4,0(sp)
    80003e04:	6145                	addi	sp,sp,48
    80003e06:	8082                	ret
  return -1;
    80003e08:	557d                	li	a0,-1
    80003e0a:	bfcd                	j	80003dfc <pipealloc+0xd0>

0000000080003e0c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003e0c:	1101                	addi	sp,sp,-32
    80003e0e:	ec06                	sd	ra,24(sp)
    80003e10:	e822                	sd	s0,16(sp)
    80003e12:	e426                	sd	s1,8(sp)
    80003e14:	e04a                	sd	s2,0(sp)
    80003e16:	1000                	addi	s0,sp,32
    80003e18:	84aa                	mv	s1,a0
    80003e1a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003e1c:	00002097          	auipc	ra,0x2
    80003e20:	422080e7          	jalr	1058(ra) # 8000623e <acquire>
  if(writable){
    80003e24:	02090b63          	beqz	s2,80003e5a <pipeclose+0x4e>
    pi->writeopen = 0;
    80003e28:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003e2c:	21848513          	addi	a0,s1,536
    80003e30:	ffffe097          	auipc	ra,0xffffe
    80003e34:	8e4080e7          	jalr	-1820(ra) # 80001714 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003e38:	2204a783          	lw	a5,544(s1)
    80003e3c:	e781                	bnez	a5,80003e44 <pipeclose+0x38>
    80003e3e:	2244a783          	lw	a5,548(s1)
    80003e42:	c78d                	beqz	a5,80003e6c <pipeclose+0x60>
    release(&pi->lock);
    kfree((char*)pi);
  } else
    release(&pi->lock);
    80003e44:	8526                	mv	a0,s1
    80003e46:	00002097          	auipc	ra,0x2
    80003e4a:	4a8080e7          	jalr	1192(ra) # 800062ee <release>
}
    80003e4e:	60e2                	ld	ra,24(sp)
    80003e50:	6442                	ld	s0,16(sp)
    80003e52:	64a2                	ld	s1,8(sp)
    80003e54:	6902                	ld	s2,0(sp)
    80003e56:	6105                	addi	sp,sp,32
    80003e58:	8082                	ret
    pi->readopen = 0;
    80003e5a:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003e5e:	21c48513          	addi	a0,s1,540
    80003e62:	ffffe097          	auipc	ra,0xffffe
    80003e66:	8b2080e7          	jalr	-1870(ra) # 80001714 <wakeup>
    80003e6a:	b7f9                	j	80003e38 <pipeclose+0x2c>
    release(&pi->lock);
    80003e6c:	8526                	mv	a0,s1
    80003e6e:	00002097          	auipc	ra,0x2
    80003e72:	480080e7          	jalr	1152(ra) # 800062ee <release>
    kfree((char*)pi);
    80003e76:	8526                	mv	a0,s1
    80003e78:	ffffc097          	auipc	ra,0xffffc
    80003e7c:	1a4080e7          	jalr	420(ra) # 8000001c <kfree>
    80003e80:	b7f9                	j	80003e4e <pipeclose+0x42>

0000000080003e82 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003e82:	7159                	addi	sp,sp,-112
    80003e84:	f486                	sd	ra,104(sp)
    80003e86:	f0a2                	sd	s0,96(sp)
    80003e88:	eca6                	sd	s1,88(sp)
    80003e8a:	e8ca                	sd	s2,80(sp)
    80003e8c:	e4ce                	sd	s3,72(sp)
    80003e8e:	e0d2                	sd	s4,64(sp)
    80003e90:	fc56                	sd	s5,56(sp)
    80003e92:	1880                	addi	s0,sp,112
    80003e94:	84aa                	mv	s1,a0
    80003e96:	8aae                	mv	s5,a1
    80003e98:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003e9a:	ffffd097          	auipc	ra,0xffffd
    80003e9e:	02a080e7          	jalr	42(ra) # 80000ec4 <myproc>
    80003ea2:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003ea4:	8526                	mv	a0,s1
    80003ea6:	00002097          	auipc	ra,0x2
    80003eaa:	398080e7          	jalr	920(ra) # 8000623e <acquire>
  while(i < n){
    80003eae:	0d405d63          	blez	s4,80003f88 <pipewrite+0x106>
    80003eb2:	f85a                	sd	s6,48(sp)
    80003eb4:	f45e                	sd	s7,40(sp)
    80003eb6:	f062                	sd	s8,32(sp)
    80003eb8:	ec66                	sd	s9,24(sp)
    80003eba:	e86a                	sd	s10,16(sp)
  int i = 0;
    80003ebc:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003ebe:	f9f40c13          	addi	s8,s0,-97
    80003ec2:	4b85                	li	s7,1
    80003ec4:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003ec6:	21848d13          	addi	s10,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003eca:	21c48c93          	addi	s9,s1,540
    80003ece:	a099                	j	80003f14 <pipewrite+0x92>
      release(&pi->lock);
    80003ed0:	8526                	mv	a0,s1
    80003ed2:	00002097          	auipc	ra,0x2
    80003ed6:	41c080e7          	jalr	1052(ra) # 800062ee <release>
      return -1;
    80003eda:	597d                	li	s2,-1
    80003edc:	7b42                	ld	s6,48(sp)
    80003ede:	7ba2                	ld	s7,40(sp)
    80003ee0:	7c02                	ld	s8,32(sp)
    80003ee2:	6ce2                	ld	s9,24(sp)
    80003ee4:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003ee6:	854a                	mv	a0,s2
    80003ee8:	70a6                	ld	ra,104(sp)
    80003eea:	7406                	ld	s0,96(sp)
    80003eec:	64e6                	ld	s1,88(sp)
    80003eee:	6946                	ld	s2,80(sp)
    80003ef0:	69a6                	ld	s3,72(sp)
    80003ef2:	6a06                	ld	s4,64(sp)
    80003ef4:	7ae2                	ld	s5,56(sp)
    80003ef6:	6165                	addi	sp,sp,112
    80003ef8:	8082                	ret
      wakeup(&pi->nread);
    80003efa:	856a                	mv	a0,s10
    80003efc:	ffffe097          	auipc	ra,0xffffe
    80003f00:	818080e7          	jalr	-2024(ra) # 80001714 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003f04:	85a6                	mv	a1,s1
    80003f06:	8566                	mv	a0,s9
    80003f08:	ffffd097          	auipc	ra,0xffffd
    80003f0c:	686080e7          	jalr	1670(ra) # 8000158e <sleep>
  while(i < n){
    80003f10:	05495b63          	bge	s2,s4,80003f66 <pipewrite+0xe4>
    if(pi->readopen == 0 || pr->killed){
    80003f14:	2204a783          	lw	a5,544(s1)
    80003f18:	dfc5                	beqz	a5,80003ed0 <pipewrite+0x4e>
    80003f1a:	0289a783          	lw	a5,40(s3)
    80003f1e:	fbcd                	bnez	a5,80003ed0 <pipewrite+0x4e>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003f20:	2184a783          	lw	a5,536(s1)
    80003f24:	21c4a703          	lw	a4,540(s1)
    80003f28:	2007879b          	addiw	a5,a5,512
    80003f2c:	fcf707e3          	beq	a4,a5,80003efa <pipewrite+0x78>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003f30:	86de                	mv	a3,s7
    80003f32:	01590633          	add	a2,s2,s5
    80003f36:	85e2                	mv	a1,s8
    80003f38:	0509b503          	ld	a0,80(s3)
    80003f3c:	ffffd097          	auipc	ra,0xffffd
    80003f40:	c98080e7          	jalr	-872(ra) # 80000bd4 <copyin>
    80003f44:	05650463          	beq	a0,s6,80003f8c <pipewrite+0x10a>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003f48:	21c4a783          	lw	a5,540(s1)
    80003f4c:	0017871b          	addiw	a4,a5,1
    80003f50:	20e4ae23          	sw	a4,540(s1)
    80003f54:	1ff7f793          	andi	a5,a5,511
    80003f58:	97a6                	add	a5,a5,s1
    80003f5a:	f9f44703          	lbu	a4,-97(s0)
    80003f5e:	00e78c23          	sb	a4,24(a5)
      i++;
    80003f62:	2905                	addiw	s2,s2,1
    80003f64:	b775                	j	80003f10 <pipewrite+0x8e>
    80003f66:	7b42                	ld	s6,48(sp)
    80003f68:	7ba2                	ld	s7,40(sp)
    80003f6a:	7c02                	ld	s8,32(sp)
    80003f6c:	6ce2                	ld	s9,24(sp)
    80003f6e:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    80003f70:	21848513          	addi	a0,s1,536
    80003f74:	ffffd097          	auipc	ra,0xffffd
    80003f78:	7a0080e7          	jalr	1952(ra) # 80001714 <wakeup>
  release(&pi->lock);
    80003f7c:	8526                	mv	a0,s1
    80003f7e:	00002097          	auipc	ra,0x2
    80003f82:	370080e7          	jalr	880(ra) # 800062ee <release>
  return i;
    80003f86:	b785                	j	80003ee6 <pipewrite+0x64>
  int i = 0;
    80003f88:	4901                	li	s2,0
    80003f8a:	b7dd                	j	80003f70 <pipewrite+0xee>
    80003f8c:	7b42                	ld	s6,48(sp)
    80003f8e:	7ba2                	ld	s7,40(sp)
    80003f90:	7c02                	ld	s8,32(sp)
    80003f92:	6ce2                	ld	s9,24(sp)
    80003f94:	6d42                	ld	s10,16(sp)
    80003f96:	bfe9                	j	80003f70 <pipewrite+0xee>

0000000080003f98 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003f98:	711d                	addi	sp,sp,-96
    80003f9a:	ec86                	sd	ra,88(sp)
    80003f9c:	e8a2                	sd	s0,80(sp)
    80003f9e:	e4a6                	sd	s1,72(sp)
    80003fa0:	e0ca                	sd	s2,64(sp)
    80003fa2:	fc4e                	sd	s3,56(sp)
    80003fa4:	f852                	sd	s4,48(sp)
    80003fa6:	f456                	sd	s5,40(sp)
    80003fa8:	1080                	addi	s0,sp,96
    80003faa:	84aa                	mv	s1,a0
    80003fac:	892e                	mv	s2,a1
    80003fae:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003fb0:	ffffd097          	auipc	ra,0xffffd
    80003fb4:	f14080e7          	jalr	-236(ra) # 80000ec4 <myproc>
    80003fb8:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003fba:	8526                	mv	a0,s1
    80003fbc:	00002097          	auipc	ra,0x2
    80003fc0:	282080e7          	jalr	642(ra) # 8000623e <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003fc4:	2184a703          	lw	a4,536(s1)
    80003fc8:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003fcc:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003fd0:	02f71863          	bne	a4,a5,80004000 <piperead+0x68>
    80003fd4:	2244a783          	lw	a5,548(s1)
    80003fd8:	cf9d                	beqz	a5,80004016 <piperead+0x7e>
    if(pr->killed){
    80003fda:	028a2783          	lw	a5,40(s4)
    80003fde:	e78d                	bnez	a5,80004008 <piperead+0x70>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003fe0:	85a6                	mv	a1,s1
    80003fe2:	854e                	mv	a0,s3
    80003fe4:	ffffd097          	auipc	ra,0xffffd
    80003fe8:	5aa080e7          	jalr	1450(ra) # 8000158e <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003fec:	2184a703          	lw	a4,536(s1)
    80003ff0:	21c4a783          	lw	a5,540(s1)
    80003ff4:	fef700e3          	beq	a4,a5,80003fd4 <piperead+0x3c>
    80003ff8:	f05a                	sd	s6,32(sp)
    80003ffa:	ec5e                	sd	s7,24(sp)
    80003ffc:	e862                	sd	s8,16(sp)
    80003ffe:	a839                	j	8000401c <piperead+0x84>
    80004000:	f05a                	sd	s6,32(sp)
    80004002:	ec5e                	sd	s7,24(sp)
    80004004:	e862                	sd	s8,16(sp)
    80004006:	a819                	j	8000401c <piperead+0x84>
      release(&pi->lock);
    80004008:	8526                	mv	a0,s1
    8000400a:	00002097          	auipc	ra,0x2
    8000400e:	2e4080e7          	jalr	740(ra) # 800062ee <release>
      return -1;
    80004012:	59fd                	li	s3,-1
    80004014:	a88d                	j	80004086 <piperead+0xee>
    80004016:	f05a                	sd	s6,32(sp)
    80004018:	ec5e                	sd	s7,24(sp)
    8000401a:	e862                	sd	s8,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000401c:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000401e:	faf40c13          	addi	s8,s0,-81
    80004022:	4b85                	li	s7,1
    80004024:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004026:	05505263          	blez	s5,8000406a <piperead+0xd2>
    if(pi->nread == pi->nwrite)
    8000402a:	2184a783          	lw	a5,536(s1)
    8000402e:	21c4a703          	lw	a4,540(s1)
    80004032:	02f70c63          	beq	a4,a5,8000406a <piperead+0xd2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004036:	0017871b          	addiw	a4,a5,1
    8000403a:	20e4ac23          	sw	a4,536(s1)
    8000403e:	1ff7f793          	andi	a5,a5,511
    80004042:	97a6                	add	a5,a5,s1
    80004044:	0187c783          	lbu	a5,24(a5)
    80004048:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    8000404c:	86de                	mv	a3,s7
    8000404e:	8662                	mv	a2,s8
    80004050:	85ca                	mv	a1,s2
    80004052:	050a3503          	ld	a0,80(s4)
    80004056:	ffffd097          	auipc	ra,0xffffd
    8000405a:	af2080e7          	jalr	-1294(ra) # 80000b48 <copyout>
    8000405e:	01650663          	beq	a0,s6,8000406a <piperead+0xd2>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004062:	2985                	addiw	s3,s3,1
    80004064:	0905                	addi	s2,s2,1
    80004066:	fd3a92e3          	bne	s5,s3,8000402a <piperead+0x92>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    8000406a:	21c48513          	addi	a0,s1,540
    8000406e:	ffffd097          	auipc	ra,0xffffd
    80004072:	6a6080e7          	jalr	1702(ra) # 80001714 <wakeup>
  release(&pi->lock);
    80004076:	8526                	mv	a0,s1
    80004078:	00002097          	auipc	ra,0x2
    8000407c:	276080e7          	jalr	630(ra) # 800062ee <release>
    80004080:	7b02                	ld	s6,32(sp)
    80004082:	6be2                	ld	s7,24(sp)
    80004084:	6c42                	ld	s8,16(sp)
  return i;
}
    80004086:	854e                	mv	a0,s3
    80004088:	60e6                	ld	ra,88(sp)
    8000408a:	6446                	ld	s0,80(sp)
    8000408c:	64a6                	ld	s1,72(sp)
    8000408e:	6906                	ld	s2,64(sp)
    80004090:	79e2                	ld	s3,56(sp)
    80004092:	7a42                	ld	s4,48(sp)
    80004094:	7aa2                	ld	s5,40(sp)
    80004096:	6125                	addi	sp,sp,96
    80004098:	8082                	ret

000000008000409a <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    8000409a:	de010113          	addi	sp,sp,-544
    8000409e:	20113c23          	sd	ra,536(sp)
    800040a2:	20813823          	sd	s0,528(sp)
    800040a6:	20913423          	sd	s1,520(sp)
    800040aa:	21213023          	sd	s2,512(sp)
    800040ae:	1400                	addi	s0,sp,544
    800040b0:	892a                	mv	s2,a0
    800040b2:	dea43823          	sd	a0,-528(s0)
    800040b6:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800040ba:	ffffd097          	auipc	ra,0xffffd
    800040be:	e0a080e7          	jalr	-502(ra) # 80000ec4 <myproc>
    800040c2:	84aa                	mv	s1,a0

  begin_op();
    800040c4:	fffff097          	auipc	ra,0xfffff
    800040c8:	406080e7          	jalr	1030(ra) # 800034ca <begin_op>

  if((ip = namei(path)) == 0){
    800040cc:	854a                	mv	a0,s2
    800040ce:	fffff097          	auipc	ra,0xfffff
    800040d2:	1f6080e7          	jalr	502(ra) # 800032c4 <namei>
    800040d6:	c525                	beqz	a0,8000413e <exec+0xa4>
    800040d8:	fbd2                	sd	s4,496(sp)
    800040da:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800040dc:	fffff097          	auipc	ra,0xfffff
    800040e0:	9f6080e7          	jalr	-1546(ra) # 80002ad2 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800040e4:	04000713          	li	a4,64
    800040e8:	4681                	li	a3,0
    800040ea:	e5040613          	addi	a2,s0,-432
    800040ee:	4581                	li	a1,0
    800040f0:	8552                	mv	a0,s4
    800040f2:	fffff097          	auipc	ra,0xfffff
    800040f6:	c9e080e7          	jalr	-866(ra) # 80002d90 <readi>
    800040fa:	04000793          	li	a5,64
    800040fe:	00f51a63          	bne	a0,a5,80004112 <exec+0x78>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004102:	e5042703          	lw	a4,-432(s0)
    80004106:	464c47b7          	lui	a5,0x464c4
    8000410a:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000410e:	02f70e63          	beq	a4,a5,8000414a <exec+0xb0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004112:	8552                	mv	a0,s4
    80004114:	fffff097          	auipc	ra,0xfffff
    80004118:	c26080e7          	jalr	-986(ra) # 80002d3a <iunlockput>
    end_op();
    8000411c:	fffff097          	auipc	ra,0xfffff
    80004120:	42e080e7          	jalr	1070(ra) # 8000354a <end_op>
  }
  return -1;
    80004124:	557d                	li	a0,-1
    80004126:	7a5e                	ld	s4,496(sp)
}
    80004128:	21813083          	ld	ra,536(sp)
    8000412c:	21013403          	ld	s0,528(sp)
    80004130:	20813483          	ld	s1,520(sp)
    80004134:	20013903          	ld	s2,512(sp)
    80004138:	22010113          	addi	sp,sp,544
    8000413c:	8082                	ret
    end_op();
    8000413e:	fffff097          	auipc	ra,0xfffff
    80004142:	40c080e7          	jalr	1036(ra) # 8000354a <end_op>
    return -1;
    80004146:	557d                	li	a0,-1
    80004148:	b7c5                	j	80004128 <exec+0x8e>
    8000414a:	f3da                	sd	s6,480(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    8000414c:	8526                	mv	a0,s1
    8000414e:	ffffd097          	auipc	ra,0xffffd
    80004152:	e3c080e7          	jalr	-452(ra) # 80000f8a <proc_pagetable>
    80004156:	8b2a                	mv	s6,a0
    80004158:	2a050a63          	beqz	a0,8000440c <exec+0x372>
    8000415c:	ffce                	sd	s3,504(sp)
    8000415e:	f7d6                	sd	s5,488(sp)
    80004160:	efde                	sd	s7,472(sp)
    80004162:	ebe2                	sd	s8,464(sp)
    80004164:	e7e6                	sd	s9,456(sp)
    80004166:	e3ea                	sd	s10,448(sp)
    80004168:	ff6e                	sd	s11,440(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000416a:	e8845783          	lhu	a5,-376(s0)
    8000416e:	cfed                	beqz	a5,80004268 <exec+0x1ce>
    80004170:	e7042683          	lw	a3,-400(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004174:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004176:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004178:	03800d93          	li	s11,56
    if((ph.vaddr % PGSIZE) != 0)
    8000417c:	6c85                	lui	s9,0x1
    8000417e:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    80004182:	def43423          	sd	a5,-536(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80004186:	6a85                	lui	s5,0x1
    80004188:	a0b5                	j	800041f4 <exec+0x15a>
      panic("loadseg: address should exist");
    8000418a:	00004517          	auipc	a0,0x4
    8000418e:	3c650513          	addi	a0,a0,966 # 80008550 <etext+0x550>
    80004192:	00002097          	auipc	ra,0x2
    80004196:	b1c080e7          	jalr	-1252(ra) # 80005cae <panic>
    if(sz - i < PGSIZE)
    8000419a:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    8000419c:	874a                	mv	a4,s2
    8000419e:	009c06bb          	addw	a3,s8,s1
    800041a2:	4581                	li	a1,0
    800041a4:	8552                	mv	a0,s4
    800041a6:	fffff097          	auipc	ra,0xfffff
    800041aa:	bea080e7          	jalr	-1046(ra) # 80002d90 <readi>
    800041ae:	26a91363          	bne	s2,a0,80004414 <exec+0x37a>
  for(i = 0; i < sz; i += PGSIZE){
    800041b2:	009a84bb          	addw	s1,s5,s1
    800041b6:	0334f463          	bgeu	s1,s3,800041de <exec+0x144>
    pa = walkaddr(pagetable, va + i);
    800041ba:	02049593          	slli	a1,s1,0x20
    800041be:	9181                	srli	a1,a1,0x20
    800041c0:	95de                	add	a1,a1,s7
    800041c2:	855a                	mv	a0,s6
    800041c4:	ffffc097          	auipc	ra,0xffffc
    800041c8:	364080e7          	jalr	868(ra) # 80000528 <walkaddr>
    800041cc:	862a                	mv	a2,a0
    if(pa == 0)
    800041ce:	dd55                	beqz	a0,8000418a <exec+0xf0>
    if(sz - i < PGSIZE)
    800041d0:	409987bb          	subw	a5,s3,s1
    800041d4:	893e                	mv	s2,a5
    800041d6:	fcfcf2e3          	bgeu	s9,a5,8000419a <exec+0x100>
    800041da:	8956                	mv	s2,s5
    800041dc:	bf7d                	j	8000419a <exec+0x100>
    sz = sz1;
    800041de:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800041e2:	2d05                	addiw	s10,s10,1
    800041e4:	e0843783          	ld	a5,-504(s0)
    800041e8:	0387869b          	addiw	a3,a5,56
    800041ec:	e8845783          	lhu	a5,-376(s0)
    800041f0:	06fd5d63          	bge	s10,a5,8000426a <exec+0x1d0>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800041f4:	e0d43423          	sd	a3,-504(s0)
    800041f8:	876e                	mv	a4,s11
    800041fa:	e1840613          	addi	a2,s0,-488
    800041fe:	4581                	li	a1,0
    80004200:	8552                	mv	a0,s4
    80004202:	fffff097          	auipc	ra,0xfffff
    80004206:	b8e080e7          	jalr	-1138(ra) # 80002d90 <readi>
    8000420a:	21b51363          	bne	a0,s11,80004410 <exec+0x376>
    if(ph.type != ELF_PROG_LOAD)
    8000420e:	e1842783          	lw	a5,-488(s0)
    80004212:	4705                	li	a4,1
    80004214:	fce797e3          	bne	a5,a4,800041e2 <exec+0x148>
    if(ph.memsz < ph.filesz)
    80004218:	e4043603          	ld	a2,-448(s0)
    8000421c:	e3843783          	ld	a5,-456(s0)
    80004220:	20f66a63          	bltu	a2,a5,80004434 <exec+0x39a>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004224:	e2843783          	ld	a5,-472(s0)
    80004228:	963e                	add	a2,a2,a5
    8000422a:	20f66863          	bltu	a2,a5,8000443a <exec+0x3a0>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000422e:	85a6                	mv	a1,s1
    80004230:	855a                	mv	a0,s6
    80004232:	ffffc097          	auipc	ra,0xffffc
    80004236:	6b4080e7          	jalr	1716(ra) # 800008e6 <uvmalloc>
    8000423a:	dea43c23          	sd	a0,-520(s0)
    8000423e:	20050163          	beqz	a0,80004440 <exec+0x3a6>
    if((ph.vaddr % PGSIZE) != 0)
    80004242:	e2843b83          	ld	s7,-472(s0)
    80004246:	de843783          	ld	a5,-536(s0)
    8000424a:	00fbf7b3          	and	a5,s7,a5
    8000424e:	1c079363          	bnez	a5,80004414 <exec+0x37a>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004252:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004256:	00098663          	beqz	s3,80004262 <exec+0x1c8>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000425a:	e2042c03          	lw	s8,-480(s0)
  for(i = 0; i < sz; i += PGSIZE){
    8000425e:	4481                	li	s1,0
    80004260:	bfa9                	j	800041ba <exec+0x120>
    sz = sz1;
    80004262:	df843483          	ld	s1,-520(s0)
    80004266:	bfb5                	j	800041e2 <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004268:	4481                	li	s1,0
  iunlockput(ip);
    8000426a:	8552                	mv	a0,s4
    8000426c:	fffff097          	auipc	ra,0xfffff
    80004270:	ace080e7          	jalr	-1330(ra) # 80002d3a <iunlockput>
  end_op();
    80004274:	fffff097          	auipc	ra,0xfffff
    80004278:	2d6080e7          	jalr	726(ra) # 8000354a <end_op>
  p = myproc();
    8000427c:	ffffd097          	auipc	ra,0xffffd
    80004280:	c48080e7          	jalr	-952(ra) # 80000ec4 <myproc>
    80004284:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80004286:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    8000428a:	6985                	lui	s3,0x1
    8000428c:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    8000428e:	99a6                	add	s3,s3,s1
    80004290:	77fd                	lui	a5,0xfffff
    80004292:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004296:	6609                	lui	a2,0x2
    80004298:	964e                	add	a2,a2,s3
    8000429a:	85ce                	mv	a1,s3
    8000429c:	855a                	mv	a0,s6
    8000429e:	ffffc097          	auipc	ra,0xffffc
    800042a2:	648080e7          	jalr	1608(ra) # 800008e6 <uvmalloc>
    800042a6:	8a2a                	mv	s4,a0
    800042a8:	e115                	bnez	a0,800042cc <exec+0x232>
    proc_freepagetable(pagetable, sz);
    800042aa:	85ce                	mv	a1,s3
    800042ac:	855a                	mv	a0,s6
    800042ae:	ffffd097          	auipc	ra,0xffffd
    800042b2:	d78080e7          	jalr	-648(ra) # 80001026 <proc_freepagetable>
  return -1;
    800042b6:	557d                	li	a0,-1
    800042b8:	79fe                	ld	s3,504(sp)
    800042ba:	7a5e                	ld	s4,496(sp)
    800042bc:	7abe                	ld	s5,488(sp)
    800042be:	7b1e                	ld	s6,480(sp)
    800042c0:	6bfe                	ld	s7,472(sp)
    800042c2:	6c5e                	ld	s8,464(sp)
    800042c4:	6cbe                	ld	s9,456(sp)
    800042c6:	6d1e                	ld	s10,448(sp)
    800042c8:	7dfa                	ld	s11,440(sp)
    800042ca:	bdb9                	j	80004128 <exec+0x8e>
  uvmclear(pagetable, sz-2*PGSIZE);
    800042cc:	75f9                	lui	a1,0xffffe
    800042ce:	95aa                	add	a1,a1,a0
    800042d0:	855a                	mv	a0,s6
    800042d2:	ffffd097          	auipc	ra,0xffffd
    800042d6:	844080e7          	jalr	-1980(ra) # 80000b16 <uvmclear>
  stackbase = sp - PGSIZE;
    800042da:	800a0b93          	addi	s7,s4,-2048
    800042de:	800b8b93          	addi	s7,s7,-2048
  for(argc = 0; argv[argc]; argc++) {
    800042e2:	e0043783          	ld	a5,-512(s0)
    800042e6:	6388                	ld	a0,0(a5)
  sp = sz;
    800042e8:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    800042ea:	4481                	li	s1,0
    ustack[argc] = sp;
    800042ec:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    800042f0:	02000c13          	li	s8,32
  for(argc = 0; argv[argc]; argc++) {
    800042f4:	c135                	beqz	a0,80004358 <exec+0x2be>
    sp -= strlen(argv[argc]) + 1;
    800042f6:	ffffc097          	auipc	ra,0xffffc
    800042fa:	022080e7          	jalr	34(ra) # 80000318 <strlen>
    800042fe:	0015079b          	addiw	a5,a0,1
    80004302:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004306:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    8000430a:	13796e63          	bltu	s2,s7,80004446 <exec+0x3ac>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8000430e:	e0043d83          	ld	s11,-512(s0)
    80004312:	000db983          	ld	s3,0(s11)
    80004316:	854e                	mv	a0,s3
    80004318:	ffffc097          	auipc	ra,0xffffc
    8000431c:	000080e7          	jalr	ra # 80000318 <strlen>
    80004320:	0015069b          	addiw	a3,a0,1
    80004324:	864e                	mv	a2,s3
    80004326:	85ca                	mv	a1,s2
    80004328:	855a                	mv	a0,s6
    8000432a:	ffffd097          	auipc	ra,0xffffd
    8000432e:	81e080e7          	jalr	-2018(ra) # 80000b48 <copyout>
    80004332:	10054c63          	bltz	a0,8000444a <exec+0x3b0>
    ustack[argc] = sp;
    80004336:	00349793          	slli	a5,s1,0x3
    8000433a:	97e6                	add	a5,a5,s9
    8000433c:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffdadc0>
  for(argc = 0; argv[argc]; argc++) {
    80004340:	0485                	addi	s1,s1,1
    80004342:	008d8793          	addi	a5,s11,8
    80004346:	e0f43023          	sd	a5,-512(s0)
    8000434a:	008db503          	ld	a0,8(s11)
    8000434e:	c509                	beqz	a0,80004358 <exec+0x2be>
    if(argc >= MAXARG)
    80004350:	fb8493e3          	bne	s1,s8,800042f6 <exec+0x25c>
  sz = sz1;
    80004354:	89d2                	mv	s3,s4
    80004356:	bf91                	j	800042aa <exec+0x210>
  ustack[argc] = 0;
    80004358:	00349793          	slli	a5,s1,0x3
    8000435c:	f9078793          	addi	a5,a5,-112
    80004360:	97a2                	add	a5,a5,s0
    80004362:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004366:	00349693          	slli	a3,s1,0x3
    8000436a:	06a1                	addi	a3,a3,8
    8000436c:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004370:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    80004374:	89d2                	mv	s3,s4
  if(sp < stackbase)
    80004376:	f3796ae3          	bltu	s2,s7,800042aa <exec+0x210>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000437a:	e9040613          	addi	a2,s0,-368
    8000437e:	85ca                	mv	a1,s2
    80004380:	855a                	mv	a0,s6
    80004382:	ffffc097          	auipc	ra,0xffffc
    80004386:	7c6080e7          	jalr	1990(ra) # 80000b48 <copyout>
    8000438a:	f20540e3          	bltz	a0,800042aa <exec+0x210>
  p->trapframe->a1 = sp;
    8000438e:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    80004392:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004396:	df043783          	ld	a5,-528(s0)
    8000439a:	0007c703          	lbu	a4,0(a5)
    8000439e:	cf11                	beqz	a4,800043ba <exec+0x320>
    800043a0:	0785                	addi	a5,a5,1
    if(*s == '/')
    800043a2:	02f00693          	li	a3,47
    800043a6:	a029                	j	800043b0 <exec+0x316>
  for(last=s=path; *s; s++)
    800043a8:	0785                	addi	a5,a5,1
    800043aa:	fff7c703          	lbu	a4,-1(a5)
    800043ae:	c711                	beqz	a4,800043ba <exec+0x320>
    if(*s == '/')
    800043b0:	fed71ce3          	bne	a4,a3,800043a8 <exec+0x30e>
      last = s+1;
    800043b4:	def43823          	sd	a5,-528(s0)
    800043b8:	bfc5                	j	800043a8 <exec+0x30e>
  safestrcpy(p->name, last, sizeof(p->name));
    800043ba:	4641                	li	a2,16
    800043bc:	df043583          	ld	a1,-528(s0)
    800043c0:	158a8513          	addi	a0,s5,344
    800043c4:	ffffc097          	auipc	ra,0xffffc
    800043c8:	f1e080e7          	jalr	-226(ra) # 800002e2 <safestrcpy>
  oldpagetable = p->pagetable;
    800043cc:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    800043d0:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    800043d4:	054ab423          	sd	s4,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800043d8:	058ab783          	ld	a5,88(s5)
    800043dc:	e6843703          	ld	a4,-408(s0)
    800043e0:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800043e2:	058ab783          	ld	a5,88(s5)
    800043e6:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800043ea:	85ea                	mv	a1,s10
    800043ec:	ffffd097          	auipc	ra,0xffffd
    800043f0:	c3a080e7          	jalr	-966(ra) # 80001026 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800043f4:	0004851b          	sext.w	a0,s1
    800043f8:	79fe                	ld	s3,504(sp)
    800043fa:	7a5e                	ld	s4,496(sp)
    800043fc:	7abe                	ld	s5,488(sp)
    800043fe:	7b1e                	ld	s6,480(sp)
    80004400:	6bfe                	ld	s7,472(sp)
    80004402:	6c5e                	ld	s8,464(sp)
    80004404:	6cbe                	ld	s9,456(sp)
    80004406:	6d1e                	ld	s10,448(sp)
    80004408:	7dfa                	ld	s11,440(sp)
    8000440a:	bb39                	j	80004128 <exec+0x8e>
    8000440c:	7b1e                	ld	s6,480(sp)
    8000440e:	b311                	j	80004112 <exec+0x78>
    80004410:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004414:	df843583          	ld	a1,-520(s0)
    80004418:	855a                	mv	a0,s6
    8000441a:	ffffd097          	auipc	ra,0xffffd
    8000441e:	c0c080e7          	jalr	-1012(ra) # 80001026 <proc_freepagetable>
  if(ip){
    80004422:	79fe                	ld	s3,504(sp)
    80004424:	7abe                	ld	s5,488(sp)
    80004426:	7b1e                	ld	s6,480(sp)
    80004428:	6bfe                	ld	s7,472(sp)
    8000442a:	6c5e                	ld	s8,464(sp)
    8000442c:	6cbe                	ld	s9,456(sp)
    8000442e:	6d1e                	ld	s10,448(sp)
    80004430:	7dfa                	ld	s11,440(sp)
    80004432:	b1c5                	j	80004112 <exec+0x78>
    80004434:	de943c23          	sd	s1,-520(s0)
    80004438:	bff1                	j	80004414 <exec+0x37a>
    8000443a:	de943c23          	sd	s1,-520(s0)
    8000443e:	bfd9                	j	80004414 <exec+0x37a>
    80004440:	de943c23          	sd	s1,-520(s0)
    80004444:	bfc1                	j	80004414 <exec+0x37a>
  sz = sz1;
    80004446:	89d2                	mv	s3,s4
    80004448:	b58d                	j	800042aa <exec+0x210>
    8000444a:	89d2                	mv	s3,s4
    8000444c:	bdb9                	j	800042aa <exec+0x210>

000000008000444e <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000444e:	7179                	addi	sp,sp,-48
    80004450:	f406                	sd	ra,40(sp)
    80004452:	f022                	sd	s0,32(sp)
    80004454:	ec26                	sd	s1,24(sp)
    80004456:	e84a                	sd	s2,16(sp)
    80004458:	1800                	addi	s0,sp,48
    8000445a:	892e                	mv	s2,a1
    8000445c:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    8000445e:	fdc40593          	addi	a1,s0,-36
    80004462:	ffffe097          	auipc	ra,0xffffe
    80004466:	b28080e7          	jalr	-1240(ra) # 80001f8a <argint>
    8000446a:	04054163          	bltz	a0,800044ac <argfd+0x5e>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000446e:	fdc42703          	lw	a4,-36(s0)
    80004472:	47bd                	li	a5,15
    80004474:	02e7ee63          	bltu	a5,a4,800044b0 <argfd+0x62>
    80004478:	ffffd097          	auipc	ra,0xffffd
    8000447c:	a4c080e7          	jalr	-1460(ra) # 80000ec4 <myproc>
    80004480:	fdc42703          	lw	a4,-36(s0)
    80004484:	00371793          	slli	a5,a4,0x3
    80004488:	0d078793          	addi	a5,a5,208
    8000448c:	953e                	add	a0,a0,a5
    8000448e:	611c                	ld	a5,0(a0)
    80004490:	c395                	beqz	a5,800044b4 <argfd+0x66>
    return -1;
  if(pfd)
    80004492:	00090463          	beqz	s2,8000449a <argfd+0x4c>
    *pfd = fd;
    80004496:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    8000449a:	4501                	li	a0,0
  if(pf)
    8000449c:	c091                	beqz	s1,800044a0 <argfd+0x52>
    *pf = f;
    8000449e:	e09c                	sd	a5,0(s1)
}
    800044a0:	70a2                	ld	ra,40(sp)
    800044a2:	7402                	ld	s0,32(sp)
    800044a4:	64e2                	ld	s1,24(sp)
    800044a6:	6942                	ld	s2,16(sp)
    800044a8:	6145                	addi	sp,sp,48
    800044aa:	8082                	ret
    return -1;
    800044ac:	557d                	li	a0,-1
    800044ae:	bfcd                	j	800044a0 <argfd+0x52>
    return -1;
    800044b0:	557d                	li	a0,-1
    800044b2:	b7fd                	j	800044a0 <argfd+0x52>
    800044b4:	557d                	li	a0,-1
    800044b6:	b7ed                	j	800044a0 <argfd+0x52>

00000000800044b8 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800044b8:	1101                	addi	sp,sp,-32
    800044ba:	ec06                	sd	ra,24(sp)
    800044bc:	e822                	sd	s0,16(sp)
    800044be:	e426                	sd	s1,8(sp)
    800044c0:	1000                	addi	s0,sp,32
    800044c2:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800044c4:	ffffd097          	auipc	ra,0xffffd
    800044c8:	a00080e7          	jalr	-1536(ra) # 80000ec4 <myproc>
    800044cc:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    800044ce:	0d050793          	addi	a5,a0,208
    800044d2:	4501                	li	a0,0
    800044d4:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800044d6:	6398                	ld	a4,0(a5)
    800044d8:	cb19                	beqz	a4,800044ee <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800044da:	2505                	addiw	a0,a0,1
    800044dc:	07a1                	addi	a5,a5,8
    800044de:	fed51ce3          	bne	a0,a3,800044d6 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800044e2:	557d                	li	a0,-1
}
    800044e4:	60e2                	ld	ra,24(sp)
    800044e6:	6442                	ld	s0,16(sp)
    800044e8:	64a2                	ld	s1,8(sp)
    800044ea:	6105                	addi	sp,sp,32
    800044ec:	8082                	ret
      p->ofile[fd] = f;
    800044ee:	00351793          	slli	a5,a0,0x3
    800044f2:	0d078793          	addi	a5,a5,208
    800044f6:	963e                	add	a2,a2,a5
    800044f8:	e204                	sd	s1,0(a2)
      return fd;
    800044fa:	b7ed                	j	800044e4 <fdalloc+0x2c>

00000000800044fc <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800044fc:	715d                	addi	sp,sp,-80
    800044fe:	e486                	sd	ra,72(sp)
    80004500:	e0a2                	sd	s0,64(sp)
    80004502:	fc26                	sd	s1,56(sp)
    80004504:	f84a                	sd	s2,48(sp)
    80004506:	f44e                	sd	s3,40(sp)
    80004508:	f052                	sd	s4,32(sp)
    8000450a:	ec56                	sd	s5,24(sp)
    8000450c:	0880                	addi	s0,sp,80
    8000450e:	89ae                	mv	s3,a1
    80004510:	8a32                	mv	s4,a2
    80004512:	8ab6                	mv	s5,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004514:	fb040593          	addi	a1,s0,-80
    80004518:	fffff097          	auipc	ra,0xfffff
    8000451c:	dca080e7          	jalr	-566(ra) # 800032e2 <nameiparent>
    80004520:	892a                	mv	s2,a0
    80004522:	12050d63          	beqz	a0,8000465c <create+0x160>
    return 0;

  ilock(dp);
    80004526:	ffffe097          	auipc	ra,0xffffe
    8000452a:	5ac080e7          	jalr	1452(ra) # 80002ad2 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    8000452e:	4601                	li	a2,0
    80004530:	fb040593          	addi	a1,s0,-80
    80004534:	854a                	mv	a0,s2
    80004536:	fffff097          	auipc	ra,0xfffff
    8000453a:	a8a080e7          	jalr	-1398(ra) # 80002fc0 <dirlookup>
    8000453e:	84aa                	mv	s1,a0
    80004540:	c539                	beqz	a0,8000458e <create+0x92>
    iunlockput(dp);
    80004542:	854a                	mv	a0,s2
    80004544:	ffffe097          	auipc	ra,0xffffe
    80004548:	7f6080e7          	jalr	2038(ra) # 80002d3a <iunlockput>
    ilock(ip);
    8000454c:	8526                	mv	a0,s1
    8000454e:	ffffe097          	auipc	ra,0xffffe
    80004552:	584080e7          	jalr	1412(ra) # 80002ad2 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004556:	4789                	li	a5,2
    80004558:	02f99463          	bne	s3,a5,80004580 <create+0x84>
    8000455c:	0444d783          	lhu	a5,68(s1)
    80004560:	37f9                	addiw	a5,a5,-2
    80004562:	17c2                	slli	a5,a5,0x30
    80004564:	93c1                	srli	a5,a5,0x30
    80004566:	4705                	li	a4,1
    80004568:	00f76c63          	bltu	a4,a5,80004580 <create+0x84>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    8000456c:	8526                	mv	a0,s1
    8000456e:	60a6                	ld	ra,72(sp)
    80004570:	6406                	ld	s0,64(sp)
    80004572:	74e2                	ld	s1,56(sp)
    80004574:	7942                	ld	s2,48(sp)
    80004576:	79a2                	ld	s3,40(sp)
    80004578:	7a02                	ld	s4,32(sp)
    8000457a:	6ae2                	ld	s5,24(sp)
    8000457c:	6161                	addi	sp,sp,80
    8000457e:	8082                	ret
    iunlockput(ip);
    80004580:	8526                	mv	a0,s1
    80004582:	ffffe097          	auipc	ra,0xffffe
    80004586:	7b8080e7          	jalr	1976(ra) # 80002d3a <iunlockput>
    return 0;
    8000458a:	4481                	li	s1,0
    8000458c:	b7c5                	j	8000456c <create+0x70>
  if((ip = ialloc(dp->dev, type)) == 0)
    8000458e:	85ce                	mv	a1,s3
    80004590:	00092503          	lw	a0,0(s2)
    80004594:	ffffe097          	auipc	ra,0xffffe
    80004598:	3aa080e7          	jalr	938(ra) # 8000293e <ialloc>
    8000459c:	84aa                	mv	s1,a0
    8000459e:	c521                	beqz	a0,800045e6 <create+0xea>
  ilock(ip);
    800045a0:	ffffe097          	auipc	ra,0xffffe
    800045a4:	532080e7          	jalr	1330(ra) # 80002ad2 <ilock>
  ip->major = major;
    800045a8:	05449323          	sh	s4,70(s1)
  ip->minor = minor;
    800045ac:	05549423          	sh	s5,72(s1)
  ip->nlink = 1;
    800045b0:	4785                	li	a5,1
    800045b2:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800045b6:	8526                	mv	a0,s1
    800045b8:	ffffe097          	auipc	ra,0xffffe
    800045bc:	44e080e7          	jalr	1102(ra) # 80002a06 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800045c0:	4705                	li	a4,1
    800045c2:	02e98a63          	beq	s3,a4,800045f6 <create+0xfa>
  if(dirlink(dp, name, ip->inum) < 0)
    800045c6:	40d0                	lw	a2,4(s1)
    800045c8:	fb040593          	addi	a1,s0,-80
    800045cc:	854a                	mv	a0,s2
    800045ce:	fffff097          	auipc	ra,0xfffff
    800045d2:	c20080e7          	jalr	-992(ra) # 800031ee <dirlink>
    800045d6:	06054b63          	bltz	a0,8000464c <create+0x150>
  iunlockput(dp);
    800045da:	854a                	mv	a0,s2
    800045dc:	ffffe097          	auipc	ra,0xffffe
    800045e0:	75e080e7          	jalr	1886(ra) # 80002d3a <iunlockput>
  return ip;
    800045e4:	b761                	j	8000456c <create+0x70>
    panic("create: ialloc");
    800045e6:	00004517          	auipc	a0,0x4
    800045ea:	f8a50513          	addi	a0,a0,-118 # 80008570 <etext+0x570>
    800045ee:	00001097          	auipc	ra,0x1
    800045f2:	6c0080e7          	jalr	1728(ra) # 80005cae <panic>
    dp->nlink++;  // for ".."
    800045f6:	04a95783          	lhu	a5,74(s2)
    800045fa:	2785                	addiw	a5,a5,1
    800045fc:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    80004600:	854a                	mv	a0,s2
    80004602:	ffffe097          	auipc	ra,0xffffe
    80004606:	404080e7          	jalr	1028(ra) # 80002a06 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    8000460a:	40d0                	lw	a2,4(s1)
    8000460c:	00004597          	auipc	a1,0x4
    80004610:	f7458593          	addi	a1,a1,-140 # 80008580 <etext+0x580>
    80004614:	8526                	mv	a0,s1
    80004616:	fffff097          	auipc	ra,0xfffff
    8000461a:	bd8080e7          	jalr	-1064(ra) # 800031ee <dirlink>
    8000461e:	00054f63          	bltz	a0,8000463c <create+0x140>
    80004622:	00492603          	lw	a2,4(s2)
    80004626:	00004597          	auipc	a1,0x4
    8000462a:	f6258593          	addi	a1,a1,-158 # 80008588 <etext+0x588>
    8000462e:	8526                	mv	a0,s1
    80004630:	fffff097          	auipc	ra,0xfffff
    80004634:	bbe080e7          	jalr	-1090(ra) # 800031ee <dirlink>
    80004638:	f80557e3          	bgez	a0,800045c6 <create+0xca>
      panic("create dots");
    8000463c:	00004517          	auipc	a0,0x4
    80004640:	f5450513          	addi	a0,a0,-172 # 80008590 <etext+0x590>
    80004644:	00001097          	auipc	ra,0x1
    80004648:	66a080e7          	jalr	1642(ra) # 80005cae <panic>
    panic("create: dirlink");
    8000464c:	00004517          	auipc	a0,0x4
    80004650:	f5450513          	addi	a0,a0,-172 # 800085a0 <etext+0x5a0>
    80004654:	00001097          	auipc	ra,0x1
    80004658:	65a080e7          	jalr	1626(ra) # 80005cae <panic>
    return 0;
    8000465c:	84aa                	mv	s1,a0
    8000465e:	b739                	j	8000456c <create+0x70>

0000000080004660 <sys_dup>:
{
    80004660:	7179                	addi	sp,sp,-48
    80004662:	f406                	sd	ra,40(sp)
    80004664:	f022                	sd	s0,32(sp)
    80004666:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004668:	fd840613          	addi	a2,s0,-40
    8000466c:	4581                	li	a1,0
    8000466e:	4501                	li	a0,0
    80004670:	00000097          	auipc	ra,0x0
    80004674:	dde080e7          	jalr	-546(ra) # 8000444e <argfd>
    return -1;
    80004678:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    8000467a:	02054763          	bltz	a0,800046a8 <sys_dup+0x48>
    8000467e:	ec26                	sd	s1,24(sp)
    80004680:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    80004682:	fd843483          	ld	s1,-40(s0)
    80004686:	8526                	mv	a0,s1
    80004688:	00000097          	auipc	ra,0x0
    8000468c:	e30080e7          	jalr	-464(ra) # 800044b8 <fdalloc>
    80004690:	892a                	mv	s2,a0
    return -1;
    80004692:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80004694:	00054f63          	bltz	a0,800046b2 <sys_dup+0x52>
  filedup(f);
    80004698:	8526                	mv	a0,s1
    8000469a:	fffff097          	auipc	ra,0xfffff
    8000469e:	2c0080e7          	jalr	704(ra) # 8000395a <filedup>
  return fd;
    800046a2:	87ca                	mv	a5,s2
    800046a4:	64e2                	ld	s1,24(sp)
    800046a6:	6942                	ld	s2,16(sp)
}
    800046a8:	853e                	mv	a0,a5
    800046aa:	70a2                	ld	ra,40(sp)
    800046ac:	7402                	ld	s0,32(sp)
    800046ae:	6145                	addi	sp,sp,48
    800046b0:	8082                	ret
    800046b2:	64e2                	ld	s1,24(sp)
    800046b4:	6942                	ld	s2,16(sp)
    800046b6:	bfcd                	j	800046a8 <sys_dup+0x48>

00000000800046b8 <sys_read>:
{
    800046b8:	7179                	addi	sp,sp,-48
    800046ba:	f406                	sd	ra,40(sp)
    800046bc:	f022                	sd	s0,32(sp)
    800046be:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046c0:	fe840613          	addi	a2,s0,-24
    800046c4:	4581                	li	a1,0
    800046c6:	4501                	li	a0,0
    800046c8:	00000097          	auipc	ra,0x0
    800046cc:	d86080e7          	jalr	-634(ra) # 8000444e <argfd>
    return -1;
    800046d0:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046d2:	04054163          	bltz	a0,80004714 <sys_read+0x5c>
    800046d6:	fe440593          	addi	a1,s0,-28
    800046da:	4509                	li	a0,2
    800046dc:	ffffe097          	auipc	ra,0xffffe
    800046e0:	8ae080e7          	jalr	-1874(ra) # 80001f8a <argint>
    return -1;
    800046e4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046e6:	02054763          	bltz	a0,80004714 <sys_read+0x5c>
    800046ea:	fd840593          	addi	a1,s0,-40
    800046ee:	4505                	li	a0,1
    800046f0:	ffffe097          	auipc	ra,0xffffe
    800046f4:	8bc080e7          	jalr	-1860(ra) # 80001fac <argaddr>
    return -1;
    800046f8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800046fa:	00054d63          	bltz	a0,80004714 <sys_read+0x5c>
  return fileread(f, p, n);
    800046fe:	fe442603          	lw	a2,-28(s0)
    80004702:	fd843583          	ld	a1,-40(s0)
    80004706:	fe843503          	ld	a0,-24(s0)
    8000470a:	fffff097          	auipc	ra,0xfffff
    8000470e:	3fa080e7          	jalr	1018(ra) # 80003b04 <fileread>
    80004712:	87aa                	mv	a5,a0
}
    80004714:	853e                	mv	a0,a5
    80004716:	70a2                	ld	ra,40(sp)
    80004718:	7402                	ld	s0,32(sp)
    8000471a:	6145                	addi	sp,sp,48
    8000471c:	8082                	ret

000000008000471e <sys_write>:
{
    8000471e:	7179                	addi	sp,sp,-48
    80004720:	f406                	sd	ra,40(sp)
    80004722:	f022                	sd	s0,32(sp)
    80004724:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004726:	fe840613          	addi	a2,s0,-24
    8000472a:	4581                	li	a1,0
    8000472c:	4501                	li	a0,0
    8000472e:	00000097          	auipc	ra,0x0
    80004732:	d20080e7          	jalr	-736(ra) # 8000444e <argfd>
    return -1;
    80004736:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004738:	04054163          	bltz	a0,8000477a <sys_write+0x5c>
    8000473c:	fe440593          	addi	a1,s0,-28
    80004740:	4509                	li	a0,2
    80004742:	ffffe097          	auipc	ra,0xffffe
    80004746:	848080e7          	jalr	-1976(ra) # 80001f8a <argint>
    return -1;
    8000474a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000474c:	02054763          	bltz	a0,8000477a <sys_write+0x5c>
    80004750:	fd840593          	addi	a1,s0,-40
    80004754:	4505                	li	a0,1
    80004756:	ffffe097          	auipc	ra,0xffffe
    8000475a:	856080e7          	jalr	-1962(ra) # 80001fac <argaddr>
    return -1;
    8000475e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004760:	00054d63          	bltz	a0,8000477a <sys_write+0x5c>
  return filewrite(f, p, n);
    80004764:	fe442603          	lw	a2,-28(s0)
    80004768:	fd843583          	ld	a1,-40(s0)
    8000476c:	fe843503          	ld	a0,-24(s0)
    80004770:	fffff097          	auipc	ra,0xfffff
    80004774:	46c080e7          	jalr	1132(ra) # 80003bdc <filewrite>
    80004778:	87aa                	mv	a5,a0
}
    8000477a:	853e                	mv	a0,a5
    8000477c:	70a2                	ld	ra,40(sp)
    8000477e:	7402                	ld	s0,32(sp)
    80004780:	6145                	addi	sp,sp,48
    80004782:	8082                	ret

0000000080004784 <sys_close>:
{
    80004784:	1101                	addi	sp,sp,-32
    80004786:	ec06                	sd	ra,24(sp)
    80004788:	e822                	sd	s0,16(sp)
    8000478a:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    8000478c:	fe040613          	addi	a2,s0,-32
    80004790:	fec40593          	addi	a1,s0,-20
    80004794:	4501                	li	a0,0
    80004796:	00000097          	auipc	ra,0x0
    8000479a:	cb8080e7          	jalr	-840(ra) # 8000444e <argfd>
    return -1;
    8000479e:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800047a0:	02054563          	bltz	a0,800047ca <sys_close+0x46>
  myproc()->ofile[fd] = 0;
    800047a4:	ffffc097          	auipc	ra,0xffffc
    800047a8:	720080e7          	jalr	1824(ra) # 80000ec4 <myproc>
    800047ac:	fec42783          	lw	a5,-20(s0)
    800047b0:	078e                	slli	a5,a5,0x3
    800047b2:	0d078793          	addi	a5,a5,208
    800047b6:	953e                	add	a0,a0,a5
    800047b8:	00053023          	sd	zero,0(a0)
  fileclose(f);
    800047bc:	fe043503          	ld	a0,-32(s0)
    800047c0:	fffff097          	auipc	ra,0xfffff
    800047c4:	1ec080e7          	jalr	492(ra) # 800039ac <fileclose>
  return 0;
    800047c8:	4781                	li	a5,0
}
    800047ca:	853e                	mv	a0,a5
    800047cc:	60e2                	ld	ra,24(sp)
    800047ce:	6442                	ld	s0,16(sp)
    800047d0:	6105                	addi	sp,sp,32
    800047d2:	8082                	ret

00000000800047d4 <sys_fstat>:
{
    800047d4:	1101                	addi	sp,sp,-32
    800047d6:	ec06                	sd	ra,24(sp)
    800047d8:	e822                	sd	s0,16(sp)
    800047da:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800047dc:	fe840613          	addi	a2,s0,-24
    800047e0:	4581                	li	a1,0
    800047e2:	4501                	li	a0,0
    800047e4:	00000097          	auipc	ra,0x0
    800047e8:	c6a080e7          	jalr	-918(ra) # 8000444e <argfd>
    return -1;
    800047ec:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800047ee:	02054563          	bltz	a0,80004818 <sys_fstat+0x44>
    800047f2:	fe040593          	addi	a1,s0,-32
    800047f6:	4505                	li	a0,1
    800047f8:	ffffd097          	auipc	ra,0xffffd
    800047fc:	7b4080e7          	jalr	1972(ra) # 80001fac <argaddr>
    return -1;
    80004800:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004802:	00054b63          	bltz	a0,80004818 <sys_fstat+0x44>
  return filestat(f, st);
    80004806:	fe043583          	ld	a1,-32(s0)
    8000480a:	fe843503          	ld	a0,-24(s0)
    8000480e:	fffff097          	auipc	ra,0xfffff
    80004812:	280080e7          	jalr	640(ra) # 80003a8e <filestat>
    80004816:	87aa                	mv	a5,a0
}
    80004818:	853e                	mv	a0,a5
    8000481a:	60e2                	ld	ra,24(sp)
    8000481c:	6442                	ld	s0,16(sp)
    8000481e:	6105                	addi	sp,sp,32
    80004820:	8082                	ret

0000000080004822 <sys_link>:
{
    80004822:	7169                	addi	sp,sp,-304
    80004824:	f606                	sd	ra,296(sp)
    80004826:	f222                	sd	s0,288(sp)
    80004828:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000482a:	08000613          	li	a2,128
    8000482e:	ed040593          	addi	a1,s0,-304
    80004832:	4501                	li	a0,0
    80004834:	ffffd097          	auipc	ra,0xffffd
    80004838:	79a080e7          	jalr	1946(ra) # 80001fce <argstr>
    return -1;
    8000483c:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000483e:	12054663          	bltz	a0,8000496a <sys_link+0x148>
    80004842:	08000613          	li	a2,128
    80004846:	f5040593          	addi	a1,s0,-176
    8000484a:	4505                	li	a0,1
    8000484c:	ffffd097          	auipc	ra,0xffffd
    80004850:	782080e7          	jalr	1922(ra) # 80001fce <argstr>
    return -1;
    80004854:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004856:	10054a63          	bltz	a0,8000496a <sys_link+0x148>
    8000485a:	ee26                	sd	s1,280(sp)
  begin_op();
    8000485c:	fffff097          	auipc	ra,0xfffff
    80004860:	c6e080e7          	jalr	-914(ra) # 800034ca <begin_op>
  if((ip = namei(old)) == 0){
    80004864:	ed040513          	addi	a0,s0,-304
    80004868:	fffff097          	auipc	ra,0xfffff
    8000486c:	a5c080e7          	jalr	-1444(ra) # 800032c4 <namei>
    80004870:	84aa                	mv	s1,a0
    80004872:	c949                	beqz	a0,80004904 <sys_link+0xe2>
  ilock(ip);
    80004874:	ffffe097          	auipc	ra,0xffffe
    80004878:	25e080e7          	jalr	606(ra) # 80002ad2 <ilock>
  if(ip->type == T_DIR){
    8000487c:	04449703          	lh	a4,68(s1)
    80004880:	4785                	li	a5,1
    80004882:	08f70863          	beq	a4,a5,80004912 <sys_link+0xf0>
    80004886:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    80004888:	04a4d783          	lhu	a5,74(s1)
    8000488c:	2785                	addiw	a5,a5,1
    8000488e:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004892:	8526                	mv	a0,s1
    80004894:	ffffe097          	auipc	ra,0xffffe
    80004898:	172080e7          	jalr	370(ra) # 80002a06 <iupdate>
  iunlock(ip);
    8000489c:	8526                	mv	a0,s1
    8000489e:	ffffe097          	auipc	ra,0xffffe
    800048a2:	2fa080e7          	jalr	762(ra) # 80002b98 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800048a6:	fd040593          	addi	a1,s0,-48
    800048aa:	f5040513          	addi	a0,s0,-176
    800048ae:	fffff097          	auipc	ra,0xfffff
    800048b2:	a34080e7          	jalr	-1484(ra) # 800032e2 <nameiparent>
    800048b6:	892a                	mv	s2,a0
    800048b8:	cd35                	beqz	a0,80004934 <sys_link+0x112>
  ilock(dp);
    800048ba:	ffffe097          	auipc	ra,0xffffe
    800048be:	218080e7          	jalr	536(ra) # 80002ad2 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800048c2:	854a                	mv	a0,s2
    800048c4:	00092703          	lw	a4,0(s2)
    800048c8:	409c                	lw	a5,0(s1)
    800048ca:	06f71063          	bne	a4,a5,8000492a <sys_link+0x108>
    800048ce:	40d0                	lw	a2,4(s1)
    800048d0:	fd040593          	addi	a1,s0,-48
    800048d4:	fffff097          	auipc	ra,0xfffff
    800048d8:	91a080e7          	jalr	-1766(ra) # 800031ee <dirlink>
    800048dc:	04054763          	bltz	a0,8000492a <sys_link+0x108>
  iunlockput(dp);
    800048e0:	854a                	mv	a0,s2
    800048e2:	ffffe097          	auipc	ra,0xffffe
    800048e6:	458080e7          	jalr	1112(ra) # 80002d3a <iunlockput>
  iput(ip);
    800048ea:	8526                	mv	a0,s1
    800048ec:	ffffe097          	auipc	ra,0xffffe
    800048f0:	3a4080e7          	jalr	932(ra) # 80002c90 <iput>
  end_op();
    800048f4:	fffff097          	auipc	ra,0xfffff
    800048f8:	c56080e7          	jalr	-938(ra) # 8000354a <end_op>
  return 0;
    800048fc:	4781                	li	a5,0
    800048fe:	64f2                	ld	s1,280(sp)
    80004900:	6952                	ld	s2,272(sp)
    80004902:	a0a5                	j	8000496a <sys_link+0x148>
    end_op();
    80004904:	fffff097          	auipc	ra,0xfffff
    80004908:	c46080e7          	jalr	-954(ra) # 8000354a <end_op>
    return -1;
    8000490c:	57fd                	li	a5,-1
    8000490e:	64f2                	ld	s1,280(sp)
    80004910:	a8a9                	j	8000496a <sys_link+0x148>
    iunlockput(ip);
    80004912:	8526                	mv	a0,s1
    80004914:	ffffe097          	auipc	ra,0xffffe
    80004918:	426080e7          	jalr	1062(ra) # 80002d3a <iunlockput>
    end_op();
    8000491c:	fffff097          	auipc	ra,0xfffff
    80004920:	c2e080e7          	jalr	-978(ra) # 8000354a <end_op>
    return -1;
    80004924:	57fd                	li	a5,-1
    80004926:	64f2                	ld	s1,280(sp)
    80004928:	a089                	j	8000496a <sys_link+0x148>
    iunlockput(dp);
    8000492a:	854a                	mv	a0,s2
    8000492c:	ffffe097          	auipc	ra,0xffffe
    80004930:	40e080e7          	jalr	1038(ra) # 80002d3a <iunlockput>
  ilock(ip);
    80004934:	8526                	mv	a0,s1
    80004936:	ffffe097          	auipc	ra,0xffffe
    8000493a:	19c080e7          	jalr	412(ra) # 80002ad2 <ilock>
  ip->nlink--;
    8000493e:	04a4d783          	lhu	a5,74(s1)
    80004942:	37fd                	addiw	a5,a5,-1
    80004944:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004948:	8526                	mv	a0,s1
    8000494a:	ffffe097          	auipc	ra,0xffffe
    8000494e:	0bc080e7          	jalr	188(ra) # 80002a06 <iupdate>
  iunlockput(ip);
    80004952:	8526                	mv	a0,s1
    80004954:	ffffe097          	auipc	ra,0xffffe
    80004958:	3e6080e7          	jalr	998(ra) # 80002d3a <iunlockput>
  end_op();
    8000495c:	fffff097          	auipc	ra,0xfffff
    80004960:	bee080e7          	jalr	-1042(ra) # 8000354a <end_op>
  return -1;
    80004964:	57fd                	li	a5,-1
    80004966:	64f2                	ld	s1,280(sp)
    80004968:	6952                	ld	s2,272(sp)
}
    8000496a:	853e                	mv	a0,a5
    8000496c:	70b2                	ld	ra,296(sp)
    8000496e:	7412                	ld	s0,288(sp)
    80004970:	6155                	addi	sp,sp,304
    80004972:	8082                	ret

0000000080004974 <sys_unlink>:
{
    80004974:	7151                	addi	sp,sp,-240
    80004976:	f586                	sd	ra,232(sp)
    80004978:	f1a2                	sd	s0,224(sp)
    8000497a:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    8000497c:	08000613          	li	a2,128
    80004980:	f3040593          	addi	a1,s0,-208
    80004984:	4501                	li	a0,0
    80004986:	ffffd097          	auipc	ra,0xffffd
    8000498a:	648080e7          	jalr	1608(ra) # 80001fce <argstr>
    8000498e:	1a054763          	bltz	a0,80004b3c <sys_unlink+0x1c8>
    80004992:	eda6                	sd	s1,216(sp)
  begin_op();
    80004994:	fffff097          	auipc	ra,0xfffff
    80004998:	b36080e7          	jalr	-1226(ra) # 800034ca <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    8000499c:	fb040593          	addi	a1,s0,-80
    800049a0:	f3040513          	addi	a0,s0,-208
    800049a4:	fffff097          	auipc	ra,0xfffff
    800049a8:	93e080e7          	jalr	-1730(ra) # 800032e2 <nameiparent>
    800049ac:	84aa                	mv	s1,a0
    800049ae:	c165                	beqz	a0,80004a8e <sys_unlink+0x11a>
  ilock(dp);
    800049b0:	ffffe097          	auipc	ra,0xffffe
    800049b4:	122080e7          	jalr	290(ra) # 80002ad2 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800049b8:	00004597          	auipc	a1,0x4
    800049bc:	bc858593          	addi	a1,a1,-1080 # 80008580 <etext+0x580>
    800049c0:	fb040513          	addi	a0,s0,-80
    800049c4:	ffffe097          	auipc	ra,0xffffe
    800049c8:	5e2080e7          	jalr	1506(ra) # 80002fa6 <namecmp>
    800049cc:	14050963          	beqz	a0,80004b1e <sys_unlink+0x1aa>
    800049d0:	00004597          	auipc	a1,0x4
    800049d4:	bb858593          	addi	a1,a1,-1096 # 80008588 <etext+0x588>
    800049d8:	fb040513          	addi	a0,s0,-80
    800049dc:	ffffe097          	auipc	ra,0xffffe
    800049e0:	5ca080e7          	jalr	1482(ra) # 80002fa6 <namecmp>
    800049e4:	12050d63          	beqz	a0,80004b1e <sys_unlink+0x1aa>
    800049e8:	e9ca                	sd	s2,208(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    800049ea:	f2c40613          	addi	a2,s0,-212
    800049ee:	fb040593          	addi	a1,s0,-80
    800049f2:	8526                	mv	a0,s1
    800049f4:	ffffe097          	auipc	ra,0xffffe
    800049f8:	5cc080e7          	jalr	1484(ra) # 80002fc0 <dirlookup>
    800049fc:	892a                	mv	s2,a0
    800049fe:	10050f63          	beqz	a0,80004b1c <sys_unlink+0x1a8>
    80004a02:	e5ce                	sd	s3,200(sp)
  ilock(ip);
    80004a04:	ffffe097          	auipc	ra,0xffffe
    80004a08:	0ce080e7          	jalr	206(ra) # 80002ad2 <ilock>
  if(ip->nlink < 1)
    80004a0c:	04a91783          	lh	a5,74(s2)
    80004a10:	08f05663          	blez	a5,80004a9c <sys_unlink+0x128>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004a14:	04491703          	lh	a4,68(s2)
    80004a18:	4785                	li	a5,1
    80004a1a:	08f70963          	beq	a4,a5,80004aac <sys_unlink+0x138>
  memset(&de, 0, sizeof(de));
    80004a1e:	fc040993          	addi	s3,s0,-64
    80004a22:	4641                	li	a2,16
    80004a24:	4581                	li	a1,0
    80004a26:	854e                	mv	a0,s3
    80004a28:	ffffb097          	auipc	ra,0xffffb
    80004a2c:	762080e7          	jalr	1890(ra) # 8000018a <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004a30:	4741                	li	a4,16
    80004a32:	f2c42683          	lw	a3,-212(s0)
    80004a36:	864e                	mv	a2,s3
    80004a38:	4581                	li	a1,0
    80004a3a:	8526                	mv	a0,s1
    80004a3c:	ffffe097          	auipc	ra,0xffffe
    80004a40:	44e080e7          	jalr	1102(ra) # 80002e8a <writei>
    80004a44:	47c1                	li	a5,16
    80004a46:	0af51863          	bne	a0,a5,80004af6 <sys_unlink+0x182>
  if(ip->type == T_DIR){
    80004a4a:	04491703          	lh	a4,68(s2)
    80004a4e:	4785                	li	a5,1
    80004a50:	0af70b63          	beq	a4,a5,80004b06 <sys_unlink+0x192>
  iunlockput(dp);
    80004a54:	8526                	mv	a0,s1
    80004a56:	ffffe097          	auipc	ra,0xffffe
    80004a5a:	2e4080e7          	jalr	740(ra) # 80002d3a <iunlockput>
  ip->nlink--;
    80004a5e:	04a95783          	lhu	a5,74(s2)
    80004a62:	37fd                	addiw	a5,a5,-1
    80004a64:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004a68:	854a                	mv	a0,s2
    80004a6a:	ffffe097          	auipc	ra,0xffffe
    80004a6e:	f9c080e7          	jalr	-100(ra) # 80002a06 <iupdate>
  iunlockput(ip);
    80004a72:	854a                	mv	a0,s2
    80004a74:	ffffe097          	auipc	ra,0xffffe
    80004a78:	2c6080e7          	jalr	710(ra) # 80002d3a <iunlockput>
  end_op();
    80004a7c:	fffff097          	auipc	ra,0xfffff
    80004a80:	ace080e7          	jalr	-1330(ra) # 8000354a <end_op>
  return 0;
    80004a84:	4501                	li	a0,0
    80004a86:	64ee                	ld	s1,216(sp)
    80004a88:	694e                	ld	s2,208(sp)
    80004a8a:	69ae                	ld	s3,200(sp)
    80004a8c:	a065                	j	80004b34 <sys_unlink+0x1c0>
    end_op();
    80004a8e:	fffff097          	auipc	ra,0xfffff
    80004a92:	abc080e7          	jalr	-1348(ra) # 8000354a <end_op>
    return -1;
    80004a96:	557d                	li	a0,-1
    80004a98:	64ee                	ld	s1,216(sp)
    80004a9a:	a869                	j	80004b34 <sys_unlink+0x1c0>
    panic("unlink: nlink < 1");
    80004a9c:	00004517          	auipc	a0,0x4
    80004aa0:	b1450513          	addi	a0,a0,-1260 # 800085b0 <etext+0x5b0>
    80004aa4:	00001097          	auipc	ra,0x1
    80004aa8:	20a080e7          	jalr	522(ra) # 80005cae <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004aac:	04c92703          	lw	a4,76(s2)
    80004ab0:	02000793          	li	a5,32
    80004ab4:	f6e7f5e3          	bgeu	a5,a4,80004a1e <sys_unlink+0xaa>
    80004ab8:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004aba:	4741                	li	a4,16
    80004abc:	86ce                	mv	a3,s3
    80004abe:	f1840613          	addi	a2,s0,-232
    80004ac2:	4581                	li	a1,0
    80004ac4:	854a                	mv	a0,s2
    80004ac6:	ffffe097          	auipc	ra,0xffffe
    80004aca:	2ca080e7          	jalr	714(ra) # 80002d90 <readi>
    80004ace:	47c1                	li	a5,16
    80004ad0:	00f51b63          	bne	a0,a5,80004ae6 <sys_unlink+0x172>
    if(de.inum != 0)
    80004ad4:	f1845783          	lhu	a5,-232(s0)
    80004ad8:	e7a5                	bnez	a5,80004b40 <sys_unlink+0x1cc>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004ada:	29c1                	addiw	s3,s3,16
    80004adc:	04c92783          	lw	a5,76(s2)
    80004ae0:	fcf9ede3          	bltu	s3,a5,80004aba <sys_unlink+0x146>
    80004ae4:	bf2d                	j	80004a1e <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004ae6:	00004517          	auipc	a0,0x4
    80004aea:	ae250513          	addi	a0,a0,-1310 # 800085c8 <etext+0x5c8>
    80004aee:	00001097          	auipc	ra,0x1
    80004af2:	1c0080e7          	jalr	448(ra) # 80005cae <panic>
    panic("unlink: writei");
    80004af6:	00004517          	auipc	a0,0x4
    80004afa:	aea50513          	addi	a0,a0,-1302 # 800085e0 <etext+0x5e0>
    80004afe:	00001097          	auipc	ra,0x1
    80004b02:	1b0080e7          	jalr	432(ra) # 80005cae <panic>
    dp->nlink--;
    80004b06:	04a4d783          	lhu	a5,74(s1)
    80004b0a:	37fd                	addiw	a5,a5,-1
    80004b0c:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004b10:	8526                	mv	a0,s1
    80004b12:	ffffe097          	auipc	ra,0xffffe
    80004b16:	ef4080e7          	jalr	-268(ra) # 80002a06 <iupdate>
    80004b1a:	bf2d                	j	80004a54 <sys_unlink+0xe0>
    80004b1c:	694e                	ld	s2,208(sp)
  iunlockput(dp);
    80004b1e:	8526                	mv	a0,s1
    80004b20:	ffffe097          	auipc	ra,0xffffe
    80004b24:	21a080e7          	jalr	538(ra) # 80002d3a <iunlockput>
  end_op();
    80004b28:	fffff097          	auipc	ra,0xfffff
    80004b2c:	a22080e7          	jalr	-1502(ra) # 8000354a <end_op>
  return -1;
    80004b30:	557d                	li	a0,-1
    80004b32:	64ee                	ld	s1,216(sp)
}
    80004b34:	70ae                	ld	ra,232(sp)
    80004b36:	740e                	ld	s0,224(sp)
    80004b38:	616d                	addi	sp,sp,240
    80004b3a:	8082                	ret
    return -1;
    80004b3c:	557d                	li	a0,-1
    80004b3e:	bfdd                	j	80004b34 <sys_unlink+0x1c0>
    iunlockput(ip);
    80004b40:	854a                	mv	a0,s2
    80004b42:	ffffe097          	auipc	ra,0xffffe
    80004b46:	1f8080e7          	jalr	504(ra) # 80002d3a <iunlockput>
    goto bad;
    80004b4a:	694e                	ld	s2,208(sp)
    80004b4c:	69ae                	ld	s3,200(sp)
    80004b4e:	bfc1                	j	80004b1e <sys_unlink+0x1aa>

0000000080004b50 <sys_open>:

uint64
sys_open(void)
{
    80004b50:	7131                	addi	sp,sp,-192
    80004b52:	fd06                	sd	ra,184(sp)
    80004b54:	f922                	sd	s0,176(sp)
    80004b56:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004b58:	08000613          	li	a2,128
    80004b5c:	f5040593          	addi	a1,s0,-176
    80004b60:	4501                	li	a0,0
    80004b62:	ffffd097          	auipc	ra,0xffffd
    80004b66:	46c080e7          	jalr	1132(ra) # 80001fce <argstr>
    return -1;
    80004b6a:	57fd                	li	a5,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004b6c:	0c054963          	bltz	a0,80004c3e <sys_open+0xee>
    80004b70:	f4c40593          	addi	a1,s0,-180
    80004b74:	4505                	li	a0,1
    80004b76:	ffffd097          	auipc	ra,0xffffd
    80004b7a:	414080e7          	jalr	1044(ra) # 80001f8a <argint>
    return -1;
    80004b7e:	57fd                	li	a5,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004b80:	0a054f63          	bltz	a0,80004c3e <sys_open+0xee>
    80004b84:	f526                	sd	s1,168(sp)

  begin_op();
    80004b86:	fffff097          	auipc	ra,0xfffff
    80004b8a:	944080e7          	jalr	-1724(ra) # 800034ca <begin_op>

  if(omode & O_CREATE){
    80004b8e:	f4c42783          	lw	a5,-180(s0)
    80004b92:	2007f793          	andi	a5,a5,512
    80004b96:	c3e1                	beqz	a5,80004c56 <sys_open+0x106>
    ip = create(path, T_FILE, 0, 0);
    80004b98:	4681                	li	a3,0
    80004b9a:	4601                	li	a2,0
    80004b9c:	4589                	li	a1,2
    80004b9e:	f5040513          	addi	a0,s0,-176
    80004ba2:	00000097          	auipc	ra,0x0
    80004ba6:	95a080e7          	jalr	-1702(ra) # 800044fc <create>
    80004baa:	84aa                	mv	s1,a0
    if(ip == 0){
    80004bac:	cd51                	beqz	a0,80004c48 <sys_open+0xf8>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004bae:	04449703          	lh	a4,68(s1)
    80004bb2:	478d                	li	a5,3
    80004bb4:	00f71763          	bne	a4,a5,80004bc2 <sys_open+0x72>
    80004bb8:	0464d703          	lhu	a4,70(s1)
    80004bbc:	47a5                	li	a5,9
    80004bbe:	0ee7e363          	bltu	a5,a4,80004ca4 <sys_open+0x154>
    80004bc2:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004bc4:	fffff097          	auipc	ra,0xfffff
    80004bc8:	d2c080e7          	jalr	-724(ra) # 800038f0 <filealloc>
    80004bcc:	892a                	mv	s2,a0
    80004bce:	cd6d                	beqz	a0,80004cc8 <sys_open+0x178>
    80004bd0:	ed4e                	sd	s3,152(sp)
    80004bd2:	00000097          	auipc	ra,0x0
    80004bd6:	8e6080e7          	jalr	-1818(ra) # 800044b8 <fdalloc>
    80004bda:	89aa                	mv	s3,a0
    80004bdc:	0e054063          	bltz	a0,80004cbc <sys_open+0x16c>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004be0:	04449703          	lh	a4,68(s1)
    80004be4:	478d                	li	a5,3
    80004be6:	0ef70e63          	beq	a4,a5,80004ce2 <sys_open+0x192>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004bea:	4789                	li	a5,2
    80004bec:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004bf0:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80004bf4:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    80004bf8:	f4c42783          	lw	a5,-180(s0)
    80004bfc:	0017f713          	andi	a4,a5,1
    80004c00:	00174713          	xori	a4,a4,1
    80004c04:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004c08:	0037f713          	andi	a4,a5,3
    80004c0c:	00e03733          	snez	a4,a4
    80004c10:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004c14:	4007f793          	andi	a5,a5,1024
    80004c18:	c791                	beqz	a5,80004c24 <sys_open+0xd4>
    80004c1a:	04449703          	lh	a4,68(s1)
    80004c1e:	4789                	li	a5,2
    80004c20:	0cf70863          	beq	a4,a5,80004cf0 <sys_open+0x1a0>
    itrunc(ip);
  }

  iunlock(ip);
    80004c24:	8526                	mv	a0,s1
    80004c26:	ffffe097          	auipc	ra,0xffffe
    80004c2a:	f72080e7          	jalr	-142(ra) # 80002b98 <iunlock>
  end_op();
    80004c2e:	fffff097          	auipc	ra,0xfffff
    80004c32:	91c080e7          	jalr	-1764(ra) # 8000354a <end_op>

  return fd;
    80004c36:	87ce                	mv	a5,s3
    80004c38:	74aa                	ld	s1,168(sp)
    80004c3a:	790a                	ld	s2,160(sp)
    80004c3c:	69ea                	ld	s3,152(sp)
}
    80004c3e:	853e                	mv	a0,a5
    80004c40:	70ea                	ld	ra,184(sp)
    80004c42:	744a                	ld	s0,176(sp)
    80004c44:	6129                	addi	sp,sp,192
    80004c46:	8082                	ret
      end_op();
    80004c48:	fffff097          	auipc	ra,0xfffff
    80004c4c:	902080e7          	jalr	-1790(ra) # 8000354a <end_op>
      return -1;
    80004c50:	57fd                	li	a5,-1
    80004c52:	74aa                	ld	s1,168(sp)
    80004c54:	b7ed                	j	80004c3e <sys_open+0xee>
    if((ip = namei(path)) == 0){
    80004c56:	f5040513          	addi	a0,s0,-176
    80004c5a:	ffffe097          	auipc	ra,0xffffe
    80004c5e:	66a080e7          	jalr	1642(ra) # 800032c4 <namei>
    80004c62:	84aa                	mv	s1,a0
    80004c64:	c90d                	beqz	a0,80004c96 <sys_open+0x146>
    ilock(ip);
    80004c66:	ffffe097          	auipc	ra,0xffffe
    80004c6a:	e6c080e7          	jalr	-404(ra) # 80002ad2 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004c6e:	04449703          	lh	a4,68(s1)
    80004c72:	4785                	li	a5,1
    80004c74:	f2f71de3          	bne	a4,a5,80004bae <sys_open+0x5e>
    80004c78:	f4c42783          	lw	a5,-180(s0)
    80004c7c:	d3b9                	beqz	a5,80004bc2 <sys_open+0x72>
      iunlockput(ip);
    80004c7e:	8526                	mv	a0,s1
    80004c80:	ffffe097          	auipc	ra,0xffffe
    80004c84:	0ba080e7          	jalr	186(ra) # 80002d3a <iunlockput>
      end_op();
    80004c88:	fffff097          	auipc	ra,0xfffff
    80004c8c:	8c2080e7          	jalr	-1854(ra) # 8000354a <end_op>
      return -1;
    80004c90:	57fd                	li	a5,-1
    80004c92:	74aa                	ld	s1,168(sp)
    80004c94:	b76d                	j	80004c3e <sys_open+0xee>
      end_op();
    80004c96:	fffff097          	auipc	ra,0xfffff
    80004c9a:	8b4080e7          	jalr	-1868(ra) # 8000354a <end_op>
      return -1;
    80004c9e:	57fd                	li	a5,-1
    80004ca0:	74aa                	ld	s1,168(sp)
    80004ca2:	bf71                	j	80004c3e <sys_open+0xee>
    iunlockput(ip);
    80004ca4:	8526                	mv	a0,s1
    80004ca6:	ffffe097          	auipc	ra,0xffffe
    80004caa:	094080e7          	jalr	148(ra) # 80002d3a <iunlockput>
    end_op();
    80004cae:	fffff097          	auipc	ra,0xfffff
    80004cb2:	89c080e7          	jalr	-1892(ra) # 8000354a <end_op>
    return -1;
    80004cb6:	57fd                	li	a5,-1
    80004cb8:	74aa                	ld	s1,168(sp)
    80004cba:	b751                	j	80004c3e <sys_open+0xee>
      fileclose(f);
    80004cbc:	854a                	mv	a0,s2
    80004cbe:	fffff097          	auipc	ra,0xfffff
    80004cc2:	cee080e7          	jalr	-786(ra) # 800039ac <fileclose>
    80004cc6:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    80004cc8:	8526                	mv	a0,s1
    80004cca:	ffffe097          	auipc	ra,0xffffe
    80004cce:	070080e7          	jalr	112(ra) # 80002d3a <iunlockput>
    end_op();
    80004cd2:	fffff097          	auipc	ra,0xfffff
    80004cd6:	878080e7          	jalr	-1928(ra) # 8000354a <end_op>
    return -1;
    80004cda:	57fd                	li	a5,-1
    80004cdc:	74aa                	ld	s1,168(sp)
    80004cde:	790a                	ld	s2,160(sp)
    80004ce0:	bfb9                	j	80004c3e <sys_open+0xee>
    f->type = FD_DEVICE;
    80004ce2:	00e92023          	sw	a4,0(s2)
    f->major = ip->major;
    80004ce6:	04649783          	lh	a5,70(s1)
    80004cea:	02f91223          	sh	a5,36(s2)
    80004cee:	b719                	j	80004bf4 <sys_open+0xa4>
    itrunc(ip);
    80004cf0:	8526                	mv	a0,s1
    80004cf2:	ffffe097          	auipc	ra,0xffffe
    80004cf6:	ef2080e7          	jalr	-270(ra) # 80002be4 <itrunc>
    80004cfa:	b72d                	j	80004c24 <sys_open+0xd4>

0000000080004cfc <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004cfc:	7175                	addi	sp,sp,-144
    80004cfe:	e506                	sd	ra,136(sp)
    80004d00:	e122                	sd	s0,128(sp)
    80004d02:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004d04:	ffffe097          	auipc	ra,0xffffe
    80004d08:	7c6080e7          	jalr	1990(ra) # 800034ca <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004d0c:	08000613          	li	a2,128
    80004d10:	f7040593          	addi	a1,s0,-144
    80004d14:	4501                	li	a0,0
    80004d16:	ffffd097          	auipc	ra,0xffffd
    80004d1a:	2b8080e7          	jalr	696(ra) # 80001fce <argstr>
    80004d1e:	02054963          	bltz	a0,80004d50 <sys_mkdir+0x54>
    80004d22:	4681                	li	a3,0
    80004d24:	4601                	li	a2,0
    80004d26:	4585                	li	a1,1
    80004d28:	f7040513          	addi	a0,s0,-144
    80004d2c:	fffff097          	auipc	ra,0xfffff
    80004d30:	7d0080e7          	jalr	2000(ra) # 800044fc <create>
    80004d34:	cd11                	beqz	a0,80004d50 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004d36:	ffffe097          	auipc	ra,0xffffe
    80004d3a:	004080e7          	jalr	4(ra) # 80002d3a <iunlockput>
  end_op();
    80004d3e:	fffff097          	auipc	ra,0xfffff
    80004d42:	80c080e7          	jalr	-2036(ra) # 8000354a <end_op>
  return 0;
    80004d46:	4501                	li	a0,0
}
    80004d48:	60aa                	ld	ra,136(sp)
    80004d4a:	640a                	ld	s0,128(sp)
    80004d4c:	6149                	addi	sp,sp,144
    80004d4e:	8082                	ret
    end_op();
    80004d50:	ffffe097          	auipc	ra,0xffffe
    80004d54:	7fa080e7          	jalr	2042(ra) # 8000354a <end_op>
    return -1;
    80004d58:	557d                	li	a0,-1
    80004d5a:	b7fd                	j	80004d48 <sys_mkdir+0x4c>

0000000080004d5c <sys_mknod>:

uint64
sys_mknod(void)
{
    80004d5c:	7135                	addi	sp,sp,-160
    80004d5e:	ed06                	sd	ra,152(sp)
    80004d60:	e922                	sd	s0,144(sp)
    80004d62:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004d64:	ffffe097          	auipc	ra,0xffffe
    80004d68:	766080e7          	jalr	1894(ra) # 800034ca <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004d6c:	08000613          	li	a2,128
    80004d70:	f7040593          	addi	a1,s0,-144
    80004d74:	4501                	li	a0,0
    80004d76:	ffffd097          	auipc	ra,0xffffd
    80004d7a:	258080e7          	jalr	600(ra) # 80001fce <argstr>
    80004d7e:	04054a63          	bltz	a0,80004dd2 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004d82:	f6c40593          	addi	a1,s0,-148
    80004d86:	4505                	li	a0,1
    80004d88:	ffffd097          	auipc	ra,0xffffd
    80004d8c:	202080e7          	jalr	514(ra) # 80001f8a <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004d90:	04054163          	bltz	a0,80004dd2 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004d94:	f6840593          	addi	a1,s0,-152
    80004d98:	4509                	li	a0,2
    80004d9a:	ffffd097          	auipc	ra,0xffffd
    80004d9e:	1f0080e7          	jalr	496(ra) # 80001f8a <argint>
     argint(1, &major) < 0 ||
    80004da2:	02054863          	bltz	a0,80004dd2 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004da6:	f6841683          	lh	a3,-152(s0)
    80004daa:	f6c41603          	lh	a2,-148(s0)
    80004dae:	458d                	li	a1,3
    80004db0:	f7040513          	addi	a0,s0,-144
    80004db4:	fffff097          	auipc	ra,0xfffff
    80004db8:	748080e7          	jalr	1864(ra) # 800044fc <create>
     argint(2, &minor) < 0 ||
    80004dbc:	c919                	beqz	a0,80004dd2 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004dbe:	ffffe097          	auipc	ra,0xffffe
    80004dc2:	f7c080e7          	jalr	-132(ra) # 80002d3a <iunlockput>
  end_op();
    80004dc6:	ffffe097          	auipc	ra,0xffffe
    80004dca:	784080e7          	jalr	1924(ra) # 8000354a <end_op>
  return 0;
    80004dce:	4501                	li	a0,0
    80004dd0:	a031                	j	80004ddc <sys_mknod+0x80>
    end_op();
    80004dd2:	ffffe097          	auipc	ra,0xffffe
    80004dd6:	778080e7          	jalr	1912(ra) # 8000354a <end_op>
    return -1;
    80004dda:	557d                	li	a0,-1
}
    80004ddc:	60ea                	ld	ra,152(sp)
    80004dde:	644a                	ld	s0,144(sp)
    80004de0:	610d                	addi	sp,sp,160
    80004de2:	8082                	ret

0000000080004de4 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004de4:	7135                	addi	sp,sp,-160
    80004de6:	ed06                	sd	ra,152(sp)
    80004de8:	e922                	sd	s0,144(sp)
    80004dea:	e14a                	sd	s2,128(sp)
    80004dec:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004dee:	ffffc097          	auipc	ra,0xffffc
    80004df2:	0d6080e7          	jalr	214(ra) # 80000ec4 <myproc>
    80004df6:	892a                	mv	s2,a0
  
  begin_op();
    80004df8:	ffffe097          	auipc	ra,0xffffe
    80004dfc:	6d2080e7          	jalr	1746(ra) # 800034ca <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004e00:	08000613          	li	a2,128
    80004e04:	f6040593          	addi	a1,s0,-160
    80004e08:	4501                	li	a0,0
    80004e0a:	ffffd097          	auipc	ra,0xffffd
    80004e0e:	1c4080e7          	jalr	452(ra) # 80001fce <argstr>
    80004e12:	04054d63          	bltz	a0,80004e6c <sys_chdir+0x88>
    80004e16:	e526                	sd	s1,136(sp)
    80004e18:	f6040513          	addi	a0,s0,-160
    80004e1c:	ffffe097          	auipc	ra,0xffffe
    80004e20:	4a8080e7          	jalr	1192(ra) # 800032c4 <namei>
    80004e24:	84aa                	mv	s1,a0
    80004e26:	c131                	beqz	a0,80004e6a <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004e28:	ffffe097          	auipc	ra,0xffffe
    80004e2c:	caa080e7          	jalr	-854(ra) # 80002ad2 <ilock>
  if(ip->type != T_DIR){
    80004e30:	04449703          	lh	a4,68(s1)
    80004e34:	4785                	li	a5,1
    80004e36:	04f71163          	bne	a4,a5,80004e78 <sys_chdir+0x94>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004e3a:	8526                	mv	a0,s1
    80004e3c:	ffffe097          	auipc	ra,0xffffe
    80004e40:	d5c080e7          	jalr	-676(ra) # 80002b98 <iunlock>
  iput(p->cwd);
    80004e44:	15093503          	ld	a0,336(s2)
    80004e48:	ffffe097          	auipc	ra,0xffffe
    80004e4c:	e48080e7          	jalr	-440(ra) # 80002c90 <iput>
  end_op();
    80004e50:	ffffe097          	auipc	ra,0xffffe
    80004e54:	6fa080e7          	jalr	1786(ra) # 8000354a <end_op>
  p->cwd = ip;
    80004e58:	14993823          	sd	s1,336(s2)
  return 0;
    80004e5c:	4501                	li	a0,0
    80004e5e:	64aa                	ld	s1,136(sp)
}
    80004e60:	60ea                	ld	ra,152(sp)
    80004e62:	644a                	ld	s0,144(sp)
    80004e64:	690a                	ld	s2,128(sp)
    80004e66:	610d                	addi	sp,sp,160
    80004e68:	8082                	ret
    80004e6a:	64aa                	ld	s1,136(sp)
    end_op();
    80004e6c:	ffffe097          	auipc	ra,0xffffe
    80004e70:	6de080e7          	jalr	1758(ra) # 8000354a <end_op>
    return -1;
    80004e74:	557d                	li	a0,-1
    80004e76:	b7ed                	j	80004e60 <sys_chdir+0x7c>
    iunlockput(ip);
    80004e78:	8526                	mv	a0,s1
    80004e7a:	ffffe097          	auipc	ra,0xffffe
    80004e7e:	ec0080e7          	jalr	-320(ra) # 80002d3a <iunlockput>
    end_op();
    80004e82:	ffffe097          	auipc	ra,0xffffe
    80004e86:	6c8080e7          	jalr	1736(ra) # 8000354a <end_op>
    return -1;
    80004e8a:	557d                	li	a0,-1
    80004e8c:	64aa                	ld	s1,136(sp)
    80004e8e:	bfc9                	j	80004e60 <sys_chdir+0x7c>

0000000080004e90 <sys_exec>:

uint64
sys_exec(void)
{
    80004e90:	7145                	addi	sp,sp,-464
    80004e92:	e786                	sd	ra,456(sp)
    80004e94:	e3a2                	sd	s0,448(sp)
    80004e96:	fb4a                	sd	s2,432(sp)
    80004e98:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004e9a:	08000613          	li	a2,128
    80004e9e:	f4040593          	addi	a1,s0,-192
    80004ea2:	4501                	li	a0,0
    80004ea4:	ffffd097          	auipc	ra,0xffffd
    80004ea8:	12a080e7          	jalr	298(ra) # 80001fce <argstr>
    return -1;
    80004eac:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004eae:	10054463          	bltz	a0,80004fb6 <sys_exec+0x126>
    80004eb2:	e3840593          	addi	a1,s0,-456
    80004eb6:	4505                	li	a0,1
    80004eb8:	ffffd097          	auipc	ra,0xffffd
    80004ebc:	0f4080e7          	jalr	244(ra) # 80001fac <argaddr>
    80004ec0:	0e054b63          	bltz	a0,80004fb6 <sys_exec+0x126>
    80004ec4:	ff26                	sd	s1,440(sp)
    80004ec6:	f74e                	sd	s3,424(sp)
    80004ec8:	f352                	sd	s4,416(sp)
    80004eca:	ef56                	sd	s5,408(sp)
    80004ecc:	eb5a                	sd	s6,400(sp)
  }
  memset(argv, 0, sizeof(argv));
    80004ece:	10000613          	li	a2,256
    80004ed2:	4581                	li	a1,0
    80004ed4:	e4040513          	addi	a0,s0,-448
    80004ed8:	ffffb097          	auipc	ra,0xffffb
    80004edc:	2b2080e7          	jalr	690(ra) # 8000018a <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004ee0:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80004ee4:	89a6                	mv	s3,s1
    80004ee6:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004ee8:	e3040a13          	addi	s4,s0,-464
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004eec:	6a85                	lui	s5,0x1
    if(i >= NELEM(argv)){
    80004eee:	02000b13          	li	s6,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004ef2:	00391513          	slli	a0,s2,0x3
    80004ef6:	85d2                	mv	a1,s4
    80004ef8:	e3843783          	ld	a5,-456(s0)
    80004efc:	953e                	add	a0,a0,a5
    80004efe:	ffffd097          	auipc	ra,0xffffd
    80004f02:	ff2080e7          	jalr	-14(ra) # 80001ef0 <fetchaddr>
    80004f06:	02054a63          	bltz	a0,80004f3a <sys_exec+0xaa>
    if(uarg == 0){
    80004f0a:	e3043783          	ld	a5,-464(s0)
    80004f0e:	cba1                	beqz	a5,80004f5e <sys_exec+0xce>
    argv[i] = kalloc();
    80004f10:	ffffb097          	auipc	ra,0xffffb
    80004f14:	210080e7          	jalr	528(ra) # 80000120 <kalloc>
    80004f18:	85aa                	mv	a1,a0
    80004f1a:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004f1e:	cd11                	beqz	a0,80004f3a <sys_exec+0xaa>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004f20:	8656                	mv	a2,s5
    80004f22:	e3043503          	ld	a0,-464(s0)
    80004f26:	ffffd097          	auipc	ra,0xffffd
    80004f2a:	01c080e7          	jalr	28(ra) # 80001f42 <fetchstr>
    80004f2e:	00054663          	bltz	a0,80004f3a <sys_exec+0xaa>
    if(i >= NELEM(argv)){
    80004f32:	0905                	addi	s2,s2,1
    80004f34:	09a1                	addi	s3,s3,8
    80004f36:	fb691ee3          	bne	s2,s6,80004ef2 <sys_exec+0x62>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f3a:	f4040913          	addi	s2,s0,-192
    80004f3e:	6088                	ld	a0,0(s1)
    80004f40:	c52d                	beqz	a0,80004faa <sys_exec+0x11a>
    kfree(argv[i]);
    80004f42:	ffffb097          	auipc	ra,0xffffb
    80004f46:	0da080e7          	jalr	218(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f4a:	04a1                	addi	s1,s1,8
    80004f4c:	ff2499e3          	bne	s1,s2,80004f3e <sys_exec+0xae>
  return -1;
    80004f50:	597d                	li	s2,-1
    80004f52:	74fa                	ld	s1,440(sp)
    80004f54:	79ba                	ld	s3,424(sp)
    80004f56:	7a1a                	ld	s4,416(sp)
    80004f58:	6afa                	ld	s5,408(sp)
    80004f5a:	6b5a                	ld	s6,400(sp)
    80004f5c:	a8a9                	j	80004fb6 <sys_exec+0x126>
      argv[i] = 0;
    80004f5e:	0009079b          	sext.w	a5,s2
    80004f62:	e4040593          	addi	a1,s0,-448
    80004f66:	078e                	slli	a5,a5,0x3
    80004f68:	97ae                	add	a5,a5,a1
    80004f6a:	0007b023          	sd	zero,0(a5)
  int ret = exec(path, argv);
    80004f6e:	f4040513          	addi	a0,s0,-192
    80004f72:	fffff097          	auipc	ra,0xfffff
    80004f76:	128080e7          	jalr	296(ra) # 8000409a <exec>
    80004f7a:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f7c:	f4040993          	addi	s3,s0,-192
    80004f80:	6088                	ld	a0,0(s1)
    80004f82:	cd11                	beqz	a0,80004f9e <sys_exec+0x10e>
    kfree(argv[i]);
    80004f84:	ffffb097          	auipc	ra,0xffffb
    80004f88:	098080e7          	jalr	152(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f8c:	04a1                	addi	s1,s1,8
    80004f8e:	ff3499e3          	bne	s1,s3,80004f80 <sys_exec+0xf0>
    80004f92:	74fa                	ld	s1,440(sp)
    80004f94:	79ba                	ld	s3,424(sp)
    80004f96:	7a1a                	ld	s4,416(sp)
    80004f98:	6afa                	ld	s5,408(sp)
    80004f9a:	6b5a                	ld	s6,400(sp)
    80004f9c:	a829                	j	80004fb6 <sys_exec+0x126>
  return ret;
    80004f9e:	74fa                	ld	s1,440(sp)
    80004fa0:	79ba                	ld	s3,424(sp)
    80004fa2:	7a1a                	ld	s4,416(sp)
    80004fa4:	6afa                	ld	s5,408(sp)
    80004fa6:	6b5a                	ld	s6,400(sp)
    80004fa8:	a039                	j	80004fb6 <sys_exec+0x126>
  return -1;
    80004faa:	597d                	li	s2,-1
    80004fac:	74fa                	ld	s1,440(sp)
    80004fae:	79ba                	ld	s3,424(sp)
    80004fb0:	7a1a                	ld	s4,416(sp)
    80004fb2:	6afa                	ld	s5,408(sp)
    80004fb4:	6b5a                	ld	s6,400(sp)
}
    80004fb6:	854a                	mv	a0,s2
    80004fb8:	60be                	ld	ra,456(sp)
    80004fba:	641e                	ld	s0,448(sp)
    80004fbc:	795a                	ld	s2,432(sp)
    80004fbe:	6179                	addi	sp,sp,464
    80004fc0:	8082                	ret

0000000080004fc2 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004fc2:	7139                	addi	sp,sp,-64
    80004fc4:	fc06                	sd	ra,56(sp)
    80004fc6:	f822                	sd	s0,48(sp)
    80004fc8:	f426                	sd	s1,40(sp)
    80004fca:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004fcc:	ffffc097          	auipc	ra,0xffffc
    80004fd0:	ef8080e7          	jalr	-264(ra) # 80000ec4 <myproc>
    80004fd4:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80004fd6:	fd840593          	addi	a1,s0,-40
    80004fda:	4501                	li	a0,0
    80004fdc:	ffffd097          	auipc	ra,0xffffd
    80004fe0:	fd0080e7          	jalr	-48(ra) # 80001fac <argaddr>
    return -1;
    80004fe4:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80004fe6:	0e054363          	bltz	a0,800050cc <sys_pipe+0x10a>
  if(pipealloc(&rf, &wf) < 0)
    80004fea:	fc840593          	addi	a1,s0,-56
    80004fee:	fd040513          	addi	a0,s0,-48
    80004ff2:	fffff097          	auipc	ra,0xfffff
    80004ff6:	d3a080e7          	jalr	-710(ra) # 80003d2c <pipealloc>
    return -1;
    80004ffa:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80004ffc:	0c054863          	bltz	a0,800050cc <sys_pipe+0x10a>
  fd0 = -1;
    80005000:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005004:	fd043503          	ld	a0,-48(s0)
    80005008:	fffff097          	auipc	ra,0xfffff
    8000500c:	4b0080e7          	jalr	1200(ra) # 800044b8 <fdalloc>
    80005010:	fca42223          	sw	a0,-60(s0)
    80005014:	08054f63          	bltz	a0,800050b2 <sys_pipe+0xf0>
    80005018:	fc843503          	ld	a0,-56(s0)
    8000501c:	fffff097          	auipc	ra,0xfffff
    80005020:	49c080e7          	jalr	1180(ra) # 800044b8 <fdalloc>
    80005024:	fca42023          	sw	a0,-64(s0)
    80005028:	06054b63          	bltz	a0,8000509e <sys_pipe+0xdc>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000502c:	4691                	li	a3,4
    8000502e:	fc440613          	addi	a2,s0,-60
    80005032:	fd843583          	ld	a1,-40(s0)
    80005036:	68a8                	ld	a0,80(s1)
    80005038:	ffffc097          	auipc	ra,0xffffc
    8000503c:	b10080e7          	jalr	-1264(ra) # 80000b48 <copyout>
    80005040:	02054063          	bltz	a0,80005060 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005044:	4691                	li	a3,4
    80005046:	fc040613          	addi	a2,s0,-64
    8000504a:	fd843583          	ld	a1,-40(s0)
    8000504e:	95b6                	add	a1,a1,a3
    80005050:	68a8                	ld	a0,80(s1)
    80005052:	ffffc097          	auipc	ra,0xffffc
    80005056:	af6080e7          	jalr	-1290(ra) # 80000b48 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    8000505a:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    8000505c:	06055863          	bgez	a0,800050cc <sys_pipe+0x10a>
    p->ofile[fd0] = 0;
    80005060:	fc442783          	lw	a5,-60(s0)
    80005064:	078e                	slli	a5,a5,0x3
    80005066:	0d078793          	addi	a5,a5,208
    8000506a:	97a6                	add	a5,a5,s1
    8000506c:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005070:	fc042783          	lw	a5,-64(s0)
    80005074:	078e                	slli	a5,a5,0x3
    80005076:	0d078793          	addi	a5,a5,208
    8000507a:	00f48533          	add	a0,s1,a5
    8000507e:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005082:	fd043503          	ld	a0,-48(s0)
    80005086:	fffff097          	auipc	ra,0xfffff
    8000508a:	926080e7          	jalr	-1754(ra) # 800039ac <fileclose>
    fileclose(wf);
    8000508e:	fc843503          	ld	a0,-56(s0)
    80005092:	fffff097          	auipc	ra,0xfffff
    80005096:	91a080e7          	jalr	-1766(ra) # 800039ac <fileclose>
    return -1;
    8000509a:	57fd                	li	a5,-1
    8000509c:	a805                	j	800050cc <sys_pipe+0x10a>
    if(fd0 >= 0)
    8000509e:	fc442783          	lw	a5,-60(s0)
    800050a2:	0007c863          	bltz	a5,800050b2 <sys_pipe+0xf0>
      p->ofile[fd0] = 0;
    800050a6:	078e                	slli	a5,a5,0x3
    800050a8:	0d078793          	addi	a5,a5,208
    800050ac:	97a6                	add	a5,a5,s1
    800050ae:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800050b2:	fd043503          	ld	a0,-48(s0)
    800050b6:	fffff097          	auipc	ra,0xfffff
    800050ba:	8f6080e7          	jalr	-1802(ra) # 800039ac <fileclose>
    fileclose(wf);
    800050be:	fc843503          	ld	a0,-56(s0)
    800050c2:	fffff097          	auipc	ra,0xfffff
    800050c6:	8ea080e7          	jalr	-1814(ra) # 800039ac <fileclose>
    return -1;
    800050ca:	57fd                	li	a5,-1
}
    800050cc:	853e                	mv	a0,a5
    800050ce:	70e2                	ld	ra,56(sp)
    800050d0:	7442                	ld	s0,48(sp)
    800050d2:	74a2                	ld	s1,40(sp)
    800050d4:	6121                	addi	sp,sp,64
    800050d6:	8082                	ret
	...

00000000800050e0 <kernelvec>:
    800050e0:	7111                	addi	sp,sp,-256
    800050e2:	e006                	sd	ra,0(sp)
    800050e4:	e40a                	sd	sp,8(sp)
    800050e6:	e80e                	sd	gp,16(sp)
    800050e8:	ec12                	sd	tp,24(sp)
    800050ea:	f016                	sd	t0,32(sp)
    800050ec:	f41a                	sd	t1,40(sp)
    800050ee:	f81e                	sd	t2,48(sp)
    800050f0:	fc22                	sd	s0,56(sp)
    800050f2:	e0a6                	sd	s1,64(sp)
    800050f4:	e4aa                	sd	a0,72(sp)
    800050f6:	e8ae                	sd	a1,80(sp)
    800050f8:	ecb2                	sd	a2,88(sp)
    800050fa:	f0b6                	sd	a3,96(sp)
    800050fc:	f4ba                	sd	a4,104(sp)
    800050fe:	f8be                	sd	a5,112(sp)
    80005100:	fcc2                	sd	a6,120(sp)
    80005102:	e146                	sd	a7,128(sp)
    80005104:	e54a                	sd	s2,136(sp)
    80005106:	e94e                	sd	s3,144(sp)
    80005108:	ed52                	sd	s4,152(sp)
    8000510a:	f156                	sd	s5,160(sp)
    8000510c:	f55a                	sd	s6,168(sp)
    8000510e:	f95e                	sd	s7,176(sp)
    80005110:	fd62                	sd	s8,184(sp)
    80005112:	e1e6                	sd	s9,192(sp)
    80005114:	e5ea                	sd	s10,200(sp)
    80005116:	e9ee                	sd	s11,208(sp)
    80005118:	edf2                	sd	t3,216(sp)
    8000511a:	f1f6                	sd	t4,224(sp)
    8000511c:	f5fa                	sd	t5,232(sp)
    8000511e:	f9fe                	sd	t6,240(sp)
    80005120:	c9bfc0ef          	jal	80001dba <kerneltrap>
    80005124:	6082                	ld	ra,0(sp)
    80005126:	6122                	ld	sp,8(sp)
    80005128:	61c2                	ld	gp,16(sp)
    8000512a:	7282                	ld	t0,32(sp)
    8000512c:	7322                	ld	t1,40(sp)
    8000512e:	73c2                	ld	t2,48(sp)
    80005130:	7462                	ld	s0,56(sp)
    80005132:	6486                	ld	s1,64(sp)
    80005134:	6526                	ld	a0,72(sp)
    80005136:	65c6                	ld	a1,80(sp)
    80005138:	6666                	ld	a2,88(sp)
    8000513a:	7686                	ld	a3,96(sp)
    8000513c:	7726                	ld	a4,104(sp)
    8000513e:	77c6                	ld	a5,112(sp)
    80005140:	7866                	ld	a6,120(sp)
    80005142:	688a                	ld	a7,128(sp)
    80005144:	692a                	ld	s2,136(sp)
    80005146:	69ca                	ld	s3,144(sp)
    80005148:	6a6a                	ld	s4,152(sp)
    8000514a:	7a8a                	ld	s5,160(sp)
    8000514c:	7b2a                	ld	s6,168(sp)
    8000514e:	7bca                	ld	s7,176(sp)
    80005150:	7c6a                	ld	s8,184(sp)
    80005152:	6c8e                	ld	s9,192(sp)
    80005154:	6d2e                	ld	s10,200(sp)
    80005156:	6dce                	ld	s11,208(sp)
    80005158:	6e6e                	ld	t3,216(sp)
    8000515a:	7e8e                	ld	t4,224(sp)
    8000515c:	7f2e                	ld	t5,232(sp)
    8000515e:	7fce                	ld	t6,240(sp)
    80005160:	6111                	addi	sp,sp,256
    80005162:	10200073          	sret
    80005166:	00000013          	nop
    8000516a:	00000013          	nop
    8000516e:	0001                	nop

0000000080005170 <timervec>:
    80005170:	34051573          	csrrw	a0,mscratch,a0
    80005174:	e10c                	sd	a1,0(a0)
    80005176:	e510                	sd	a2,8(a0)
    80005178:	e914                	sd	a3,16(a0)
    8000517a:	6d0c                	ld	a1,24(a0)
    8000517c:	7110                	ld	a2,32(a0)
    8000517e:	6194                	ld	a3,0(a1)
    80005180:	96b2                	add	a3,a3,a2
    80005182:	e194                	sd	a3,0(a1)
    80005184:	4589                	li	a1,2
    80005186:	14459073          	csrw	sip,a1
    8000518a:	6914                	ld	a3,16(a0)
    8000518c:	6510                	ld	a2,8(a0)
    8000518e:	610c                	ld	a1,0(a0)
    80005190:	34051573          	csrrw	a0,mscratch,a0
    80005194:	30200073          	mret
    80005198:	0001                	nop

000000008000519a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000519a:	1141                	addi	sp,sp,-16
    8000519c:	e406                	sd	ra,8(sp)
    8000519e:	e022                	sd	s0,0(sp)
    800051a0:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    800051a2:	0c000737          	lui	a4,0xc000
    800051a6:	4785                	li	a5,1
    800051a8:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    800051aa:	c35c                	sw	a5,4(a4)
}
    800051ac:	60a2                	ld	ra,8(sp)
    800051ae:	6402                	ld	s0,0(sp)
    800051b0:	0141                	addi	sp,sp,16
    800051b2:	8082                	ret

00000000800051b4 <plicinithart>:

void
plicinithart(void)
{
    800051b4:	1141                	addi	sp,sp,-16
    800051b6:	e406                	sd	ra,8(sp)
    800051b8:	e022                	sd	s0,0(sp)
    800051ba:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800051bc:	ffffc097          	auipc	ra,0xffffc
    800051c0:	cd4080e7          	jalr	-812(ra) # 80000e90 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800051c4:	0085171b          	slliw	a4,a0,0x8
    800051c8:	0c0027b7          	lui	a5,0xc002
    800051cc:	97ba                	add	a5,a5,a4
    800051ce:	40200713          	li	a4,1026
    800051d2:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800051d6:	00d5151b          	slliw	a0,a0,0xd
    800051da:	0c2017b7          	lui	a5,0xc201
    800051de:	97aa                	add	a5,a5,a0
    800051e0:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800051e4:	60a2                	ld	ra,8(sp)
    800051e6:	6402                	ld	s0,0(sp)
    800051e8:	0141                	addi	sp,sp,16
    800051ea:	8082                	ret

00000000800051ec <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800051ec:	1141                	addi	sp,sp,-16
    800051ee:	e406                	sd	ra,8(sp)
    800051f0:	e022                	sd	s0,0(sp)
    800051f2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800051f4:	ffffc097          	auipc	ra,0xffffc
    800051f8:	c9c080e7          	jalr	-868(ra) # 80000e90 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800051fc:	00d5151b          	slliw	a0,a0,0xd
    80005200:	0c2017b7          	lui	a5,0xc201
    80005204:	97aa                	add	a5,a5,a0
  return irq;
}
    80005206:	43c8                	lw	a0,4(a5)
    80005208:	60a2                	ld	ra,8(sp)
    8000520a:	6402                	ld	s0,0(sp)
    8000520c:	0141                	addi	sp,sp,16
    8000520e:	8082                	ret

0000000080005210 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005210:	1101                	addi	sp,sp,-32
    80005212:	ec06                	sd	ra,24(sp)
    80005214:	e822                	sd	s0,16(sp)
    80005216:	e426                	sd	s1,8(sp)
    80005218:	1000                	addi	s0,sp,32
    8000521a:	84aa                	mv	s1,a0
  int hart = cpuid();
    8000521c:	ffffc097          	auipc	ra,0xffffc
    80005220:	c74080e7          	jalr	-908(ra) # 80000e90 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005224:	00d5179b          	slliw	a5,a0,0xd
    80005228:	0c201737          	lui	a4,0xc201
    8000522c:	97ba                	add	a5,a5,a4
    8000522e:	c3c4                	sw	s1,4(a5)
}
    80005230:	60e2                	ld	ra,24(sp)
    80005232:	6442                	ld	s0,16(sp)
    80005234:	64a2                	ld	s1,8(sp)
    80005236:	6105                	addi	sp,sp,32
    80005238:	8082                	ret

000000008000523a <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    8000523a:	1141                	addi	sp,sp,-16
    8000523c:	e406                	sd	ra,8(sp)
    8000523e:	e022                	sd	s0,0(sp)
    80005240:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005242:	479d                	li	a5,7
    80005244:	06a7c863          	blt	a5,a0,800052b4 <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    80005248:	00014717          	auipc	a4,0x14
    8000524c:	db870713          	addi	a4,a4,-584 # 80019000 <disk>
    80005250:	972a                	add	a4,a4,a0
    80005252:	6789                	lui	a5,0x2
    80005254:	97ba                	add	a5,a5,a4
    80005256:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    8000525a:	e7ad                	bnez	a5,800052c4 <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    8000525c:	00451793          	slli	a5,a0,0x4
    80005260:	00016717          	auipc	a4,0x16
    80005264:	da070713          	addi	a4,a4,-608 # 8001b000 <disk+0x2000>
    80005268:	6314                	ld	a3,0(a4)
    8000526a:	96be                	add	a3,a3,a5
    8000526c:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005270:	6314                	ld	a3,0(a4)
    80005272:	96be                	add	a3,a3,a5
    80005274:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005278:	6314                	ld	a3,0(a4)
    8000527a:	96be                	add	a3,a3,a5
    8000527c:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    80005280:	6318                	ld	a4,0(a4)
    80005282:	97ba                	add	a5,a5,a4
    80005284:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005288:	00014717          	auipc	a4,0x14
    8000528c:	d7870713          	addi	a4,a4,-648 # 80019000 <disk>
    80005290:	972a                	add	a4,a4,a0
    80005292:	6789                	lui	a5,0x2
    80005294:	97ba                	add	a5,a5,a4
    80005296:	4705                	li	a4,1
    80005298:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    8000529c:	00016517          	auipc	a0,0x16
    800052a0:	d7c50513          	addi	a0,a0,-644 # 8001b018 <disk+0x2018>
    800052a4:	ffffc097          	auipc	ra,0xffffc
    800052a8:	470080e7          	jalr	1136(ra) # 80001714 <wakeup>
}
    800052ac:	60a2                	ld	ra,8(sp)
    800052ae:	6402                	ld	s0,0(sp)
    800052b0:	0141                	addi	sp,sp,16
    800052b2:	8082                	ret
    panic("free_desc 1");
    800052b4:	00003517          	auipc	a0,0x3
    800052b8:	33c50513          	addi	a0,a0,828 # 800085f0 <etext+0x5f0>
    800052bc:	00001097          	auipc	ra,0x1
    800052c0:	9f2080e7          	jalr	-1550(ra) # 80005cae <panic>
    panic("free_desc 2");
    800052c4:	00003517          	auipc	a0,0x3
    800052c8:	33c50513          	addi	a0,a0,828 # 80008600 <etext+0x600>
    800052cc:	00001097          	auipc	ra,0x1
    800052d0:	9e2080e7          	jalr	-1566(ra) # 80005cae <panic>

00000000800052d4 <virtio_disk_init>:
{
    800052d4:	1141                	addi	sp,sp,-16
    800052d6:	e406                	sd	ra,8(sp)
    800052d8:	e022                	sd	s0,0(sp)
    800052da:	0800                	addi	s0,sp,16
  initlock(&disk.vdisk_lock, "virtio_disk");
    800052dc:	00003597          	auipc	a1,0x3
    800052e0:	33458593          	addi	a1,a1,820 # 80008610 <etext+0x610>
    800052e4:	00016517          	auipc	a0,0x16
    800052e8:	e4450513          	addi	a0,a0,-444 # 8001b128 <disk+0x2128>
    800052ec:	00001097          	auipc	ra,0x1
    800052f0:	eb8080e7          	jalr	-328(ra) # 800061a4 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800052f4:	100017b7          	lui	a5,0x10001
    800052f8:	4398                	lw	a4,0(a5)
    800052fa:	2701                	sext.w	a4,a4
    800052fc:	747277b7          	lui	a5,0x74727
    80005300:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005304:	0ef71563          	bne	a4,a5,800053ee <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005308:	100017b7          	lui	a5,0x10001
    8000530c:	43dc                	lw	a5,4(a5)
    8000530e:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005310:	4705                	li	a4,1
    80005312:	0ce79e63          	bne	a5,a4,800053ee <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005316:	100017b7          	lui	a5,0x10001
    8000531a:	479c                	lw	a5,8(a5)
    8000531c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000531e:	4709                	li	a4,2
    80005320:	0ce79763          	bne	a5,a4,800053ee <virtio_disk_init+0x11a>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005324:	100017b7          	lui	a5,0x10001
    80005328:	47d8                	lw	a4,12(a5)
    8000532a:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000532c:	554d47b7          	lui	a5,0x554d4
    80005330:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005334:	0af71d63          	bne	a4,a5,800053ee <virtio_disk_init+0x11a>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005338:	100017b7          	lui	a5,0x10001
    8000533c:	4705                	li	a4,1
    8000533e:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005340:	470d                	li	a4,3
    80005342:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005344:	10001737          	lui	a4,0x10001
    80005348:	4b18                	lw	a4,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    8000534a:	c7ffe6b7          	lui	a3,0xc7ffe
    8000534e:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fda51f>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005352:	8f75                	and	a4,a4,a3
    80005354:	100016b7          	lui	a3,0x10001
    80005358:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000535a:	472d                	li	a4,11
    8000535c:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000535e:	473d                	li	a4,15
    80005360:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80005362:	6705                	lui	a4,0x1
    80005364:	d698                	sw	a4,40(a3)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005366:	0206a823          	sw	zero,48(a3) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    8000536a:	5adc                	lw	a5,52(a3)
    8000536c:	2781                	sext.w	a5,a5
  if(max == 0)
    8000536e:	cbc1                	beqz	a5,800053fe <virtio_disk_init+0x12a>
  if(max < NUM)
    80005370:	471d                	li	a4,7
    80005372:	08f77e63          	bgeu	a4,a5,8000540e <virtio_disk_init+0x13a>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005376:	100017b7          	lui	a5,0x10001
    8000537a:	4721                	li	a4,8
    8000537c:	df98                	sw	a4,56(a5)
  memset(disk.pages, 0, sizeof(disk.pages));
    8000537e:	6609                	lui	a2,0x2
    80005380:	4581                	li	a1,0
    80005382:	00014517          	auipc	a0,0x14
    80005386:	c7e50513          	addi	a0,a0,-898 # 80019000 <disk>
    8000538a:	ffffb097          	auipc	ra,0xffffb
    8000538e:	e00080e7          	jalr	-512(ra) # 8000018a <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005392:	00014717          	auipc	a4,0x14
    80005396:	c6e70713          	addi	a4,a4,-914 # 80019000 <disk>
    8000539a:	00c75793          	srli	a5,a4,0xc
    8000539e:	2781                	sext.w	a5,a5
    800053a0:	100016b7          	lui	a3,0x10001
    800053a4:	c2bc                	sw	a5,64(a3)
  disk.desc = (struct virtq_desc *) disk.pages;
    800053a6:	00016797          	auipc	a5,0x16
    800053aa:	c5a78793          	addi	a5,a5,-934 # 8001b000 <disk+0x2000>
    800053ae:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    800053b0:	00014717          	auipc	a4,0x14
    800053b4:	cd070713          	addi	a4,a4,-816 # 80019080 <disk+0x80>
    800053b8:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    800053ba:	00015717          	auipc	a4,0x15
    800053be:	c4670713          	addi	a4,a4,-954 # 8001a000 <disk+0x1000>
    800053c2:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    800053c4:	4705                	li	a4,1
    800053c6:	00e78c23          	sb	a4,24(a5)
    800053ca:	00e78ca3          	sb	a4,25(a5)
    800053ce:	00e78d23          	sb	a4,26(a5)
    800053d2:	00e78da3          	sb	a4,27(a5)
    800053d6:	00e78e23          	sb	a4,28(a5)
    800053da:	00e78ea3          	sb	a4,29(a5)
    800053de:	00e78f23          	sb	a4,30(a5)
    800053e2:	00e78fa3          	sb	a4,31(a5)
}
    800053e6:	60a2                	ld	ra,8(sp)
    800053e8:	6402                	ld	s0,0(sp)
    800053ea:	0141                	addi	sp,sp,16
    800053ec:	8082                	ret
    panic("could not find virtio disk");
    800053ee:	00003517          	auipc	a0,0x3
    800053f2:	23250513          	addi	a0,a0,562 # 80008620 <etext+0x620>
    800053f6:	00001097          	auipc	ra,0x1
    800053fa:	8b8080e7          	jalr	-1864(ra) # 80005cae <panic>
    panic("virtio disk has no queue 0");
    800053fe:	00003517          	auipc	a0,0x3
    80005402:	24250513          	addi	a0,a0,578 # 80008640 <etext+0x640>
    80005406:	00001097          	auipc	ra,0x1
    8000540a:	8a8080e7          	jalr	-1880(ra) # 80005cae <panic>
    panic("virtio disk max queue too short");
    8000540e:	00003517          	auipc	a0,0x3
    80005412:	25250513          	addi	a0,a0,594 # 80008660 <etext+0x660>
    80005416:	00001097          	auipc	ra,0x1
    8000541a:	898080e7          	jalr	-1896(ra) # 80005cae <panic>

000000008000541e <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    8000541e:	711d                	addi	sp,sp,-96
    80005420:	ec86                	sd	ra,88(sp)
    80005422:	e8a2                	sd	s0,80(sp)
    80005424:	e4a6                	sd	s1,72(sp)
    80005426:	e0ca                	sd	s2,64(sp)
    80005428:	fc4e                	sd	s3,56(sp)
    8000542a:	f852                	sd	s4,48(sp)
    8000542c:	f456                	sd	s5,40(sp)
    8000542e:	f05a                	sd	s6,32(sp)
    80005430:	ec5e                	sd	s7,24(sp)
    80005432:	e862                	sd	s8,16(sp)
    80005434:	1080                	addi	s0,sp,96
    80005436:	89aa                	mv	s3,a0
    80005438:	8c2e                	mv	s8,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    8000543a:	00c52b83          	lw	s7,12(a0)
    8000543e:	001b9b9b          	slliw	s7,s7,0x1
    80005442:	1b82                	slli	s7,s7,0x20
    80005444:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    80005448:	00016517          	auipc	a0,0x16
    8000544c:	ce050513          	addi	a0,a0,-800 # 8001b128 <disk+0x2128>
    80005450:	00001097          	auipc	ra,0x1
    80005454:	dee080e7          	jalr	-530(ra) # 8000623e <acquire>
  for(int i = 0; i < NUM; i++){
    80005458:	44a1                	li	s1,8
      disk.free[i] = 0;
    8000545a:	00014b17          	auipc	s6,0x14
    8000545e:	ba6b0b13          	addi	s6,s6,-1114 # 80019000 <disk>
    80005462:	6a89                	lui	s5,0x2
  for(int i = 0; i < 3; i++){
    80005464:	4a0d                	li	s4,3
    80005466:	a88d                	j	800054d8 <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    80005468:	00fb0733          	add	a4,s6,a5
    8000546c:	9756                	add	a4,a4,s5
    8000546e:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80005472:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80005474:	0207c563          	bltz	a5,8000549e <virtio_disk_rw+0x80>
  for(int i = 0; i < 3; i++){
    80005478:	2905                	addiw	s2,s2,1
    8000547a:	0611                	addi	a2,a2,4 # 2004 <_entry-0x7fffdffc>
    8000547c:	1b490063          	beq	s2,s4,8000561c <virtio_disk_rw+0x1fe>
    idx[i] = alloc_desc();
    80005480:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80005482:	00016717          	auipc	a4,0x16
    80005486:	b9670713          	addi	a4,a4,-1130 # 8001b018 <disk+0x2018>
    8000548a:	4781                	li	a5,0
    if(disk.free[i]){
    8000548c:	00074683          	lbu	a3,0(a4)
    80005490:	fee1                	bnez	a3,80005468 <virtio_disk_rw+0x4a>
  for(int i = 0; i < NUM; i++){
    80005492:	2785                	addiw	a5,a5,1
    80005494:	0705                	addi	a4,a4,1
    80005496:	fe979be3          	bne	a5,s1,8000548c <virtio_disk_rw+0x6e>
    idx[i] = alloc_desc();
    8000549a:	57fd                	li	a5,-1
    8000549c:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    8000549e:	03205163          	blez	s2,800054c0 <virtio_disk_rw+0xa2>
        free_desc(idx[j]);
    800054a2:	fa042503          	lw	a0,-96(s0)
    800054a6:	00000097          	auipc	ra,0x0
    800054aa:	d94080e7          	jalr	-620(ra) # 8000523a <free_desc>
      for(int j = 0; j < i; j++)
    800054ae:	4785                	li	a5,1
    800054b0:	0127d863          	bge	a5,s2,800054c0 <virtio_disk_rw+0xa2>
        free_desc(idx[j]);
    800054b4:	fa442503          	lw	a0,-92(s0)
    800054b8:	00000097          	auipc	ra,0x0
    800054bc:	d82080e7          	jalr	-638(ra) # 8000523a <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800054c0:	00016597          	auipc	a1,0x16
    800054c4:	c6858593          	addi	a1,a1,-920 # 8001b128 <disk+0x2128>
    800054c8:	00016517          	auipc	a0,0x16
    800054cc:	b5050513          	addi	a0,a0,-1200 # 8001b018 <disk+0x2018>
    800054d0:	ffffc097          	auipc	ra,0xffffc
    800054d4:	0be080e7          	jalr	190(ra) # 8000158e <sleep>
  for(int i = 0; i < 3; i++){
    800054d8:	fa040613          	addi	a2,s0,-96
    800054dc:	4901                	li	s2,0
    800054de:	b74d                	j	80005480 <virtio_disk_rw+0x62>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800054e0:	00016717          	auipc	a4,0x16
    800054e4:	b2073703          	ld	a4,-1248(a4) # 8001b000 <disk+0x2000>
    800054e8:	973e                	add	a4,a4,a5
    800054ea:	00071623          	sh	zero,12(a4)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800054ee:	00014897          	auipc	a7,0x14
    800054f2:	b1288893          	addi	a7,a7,-1262 # 80019000 <disk>
    800054f6:	00016717          	auipc	a4,0x16
    800054fa:	b0a70713          	addi	a4,a4,-1270 # 8001b000 <disk+0x2000>
    800054fe:	6314                	ld	a3,0(a4)
    80005500:	96be                	add	a3,a3,a5
    80005502:	00c6d583          	lhu	a1,12(a3) # 1000100c <_entry-0x6fffeff4>
    80005506:	0015e593          	ori	a1,a1,1
    8000550a:	00b69623          	sh	a1,12(a3)
  disk.desc[idx[1]].next = idx[2];
    8000550e:	fa842683          	lw	a3,-88(s0)
    80005512:	630c                	ld	a1,0(a4)
    80005514:	97ae                	add	a5,a5,a1
    80005516:	00d79723          	sh	a3,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    8000551a:	20050593          	addi	a1,a0,512
    8000551e:	0592                	slli	a1,a1,0x4
    80005520:	95c6                	add	a1,a1,a7
    80005522:	57fd                	li	a5,-1
    80005524:	02f58823          	sb	a5,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005528:	00469793          	slli	a5,a3,0x4
    8000552c:	00073803          	ld	a6,0(a4)
    80005530:	983e                	add	a6,a6,a5
    80005532:	6689                	lui	a3,0x2
    80005534:	03068693          	addi	a3,a3,48 # 2030 <_entry-0x7fffdfd0>
    80005538:	96b2                	add	a3,a3,a2
    8000553a:	96c6                	add	a3,a3,a7
    8000553c:	00d83023          	sd	a3,0(a6)
  disk.desc[idx[2]].len = 1;
    80005540:	6314                	ld	a3,0(a4)
    80005542:	96be                	add	a3,a3,a5
    80005544:	4605                	li	a2,1
    80005546:	c690                	sw	a2,8(a3)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005548:	6314                	ld	a3,0(a4)
    8000554a:	96be                	add	a3,a3,a5
    8000554c:	4809                	li	a6,2
    8000554e:	01069623          	sh	a6,12(a3)
  disk.desc[idx[2]].next = 0;
    80005552:	6314                	ld	a3,0(a4)
    80005554:	97b6                	add	a5,a5,a3
    80005556:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    8000555a:	00c9a223          	sw	a2,4(s3)
  disk.info[idx[0]].b = b;
    8000555e:	0335b423          	sd	s3,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005562:	6714                	ld	a3,8(a4)
    80005564:	0026d783          	lhu	a5,2(a3)
    80005568:	8b9d                	andi	a5,a5,7
    8000556a:	0786                	slli	a5,a5,0x1
    8000556c:	96be                	add	a3,a3,a5
    8000556e:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80005572:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005576:	6718                	ld	a4,8(a4)
    80005578:	00275783          	lhu	a5,2(a4)
    8000557c:	2785                	addiw	a5,a5,1
    8000557e:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005582:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005586:	100017b7          	lui	a5,0x10001
    8000558a:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    8000558e:	0049a783          	lw	a5,4(s3)
    80005592:	02c79163          	bne	a5,a2,800055b4 <virtio_disk_rw+0x196>
    sleep(b, &disk.vdisk_lock);
    80005596:	00016917          	auipc	s2,0x16
    8000559a:	b9290913          	addi	s2,s2,-1134 # 8001b128 <disk+0x2128>
  while(b->disk == 1) {
    8000559e:	84be                	mv	s1,a5
    sleep(b, &disk.vdisk_lock);
    800055a0:	85ca                	mv	a1,s2
    800055a2:	854e                	mv	a0,s3
    800055a4:	ffffc097          	auipc	ra,0xffffc
    800055a8:	fea080e7          	jalr	-22(ra) # 8000158e <sleep>
  while(b->disk == 1) {
    800055ac:	0049a783          	lw	a5,4(s3)
    800055b0:	fe9788e3          	beq	a5,s1,800055a0 <virtio_disk_rw+0x182>
  }

  disk.info[idx[0]].b = 0;
    800055b4:	fa042903          	lw	s2,-96(s0)
    800055b8:	20090713          	addi	a4,s2,512
    800055bc:	0712                	slli	a4,a4,0x4
    800055be:	00014797          	auipc	a5,0x14
    800055c2:	a4278793          	addi	a5,a5,-1470 # 80019000 <disk>
    800055c6:	97ba                	add	a5,a5,a4
    800055c8:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    800055cc:	00016997          	auipc	s3,0x16
    800055d0:	a3498993          	addi	s3,s3,-1484 # 8001b000 <disk+0x2000>
    800055d4:	00491713          	slli	a4,s2,0x4
    800055d8:	0009b783          	ld	a5,0(s3)
    800055dc:	97ba                	add	a5,a5,a4
    800055de:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800055e2:	854a                	mv	a0,s2
    800055e4:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800055e8:	00000097          	auipc	ra,0x0
    800055ec:	c52080e7          	jalr	-942(ra) # 8000523a <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800055f0:	8885                	andi	s1,s1,1
    800055f2:	f0ed                	bnez	s1,800055d4 <virtio_disk_rw+0x1b6>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800055f4:	00016517          	auipc	a0,0x16
    800055f8:	b3450513          	addi	a0,a0,-1228 # 8001b128 <disk+0x2128>
    800055fc:	00001097          	auipc	ra,0x1
    80005600:	cf2080e7          	jalr	-782(ra) # 800062ee <release>
}
    80005604:	60e6                	ld	ra,88(sp)
    80005606:	6446                	ld	s0,80(sp)
    80005608:	64a6                	ld	s1,72(sp)
    8000560a:	6906                	ld	s2,64(sp)
    8000560c:	79e2                	ld	s3,56(sp)
    8000560e:	7a42                	ld	s4,48(sp)
    80005610:	7aa2                	ld	s5,40(sp)
    80005612:	7b02                	ld	s6,32(sp)
    80005614:	6be2                	ld	s7,24(sp)
    80005616:	6c42                	ld	s8,16(sp)
    80005618:	6125                	addi	sp,sp,96
    8000561a:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000561c:	fa042503          	lw	a0,-96(s0)
    80005620:	00451613          	slli	a2,a0,0x4
  if(write)
    80005624:	00014597          	auipc	a1,0x14
    80005628:	9dc58593          	addi	a1,a1,-1572 # 80019000 <disk>
    8000562c:	20050793          	addi	a5,a0,512
    80005630:	0792                	slli	a5,a5,0x4
    80005632:	97ae                	add	a5,a5,a1
    80005634:	01803733          	snez	a4,s8
    80005638:	0ae7a423          	sw	a4,168(a5)
  buf0->reserved = 0;
    8000563c:	0a07a623          	sw	zero,172(a5)
  buf0->sector = sector;
    80005640:	0b77b823          	sd	s7,176(a5)
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005644:	00016717          	auipc	a4,0x16
    80005648:	9bc70713          	addi	a4,a4,-1604 # 8001b000 <disk+0x2000>
    8000564c:	6314                	ld	a3,0(a4)
    8000564e:	96b2                	add	a3,a3,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005650:	6789                	lui	a5,0x2
    80005652:	0a878793          	addi	a5,a5,168 # 20a8 <_entry-0x7fffdf58>
    80005656:	97b2                	add	a5,a5,a2
    80005658:	97ae                	add	a5,a5,a1
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000565a:	e29c                	sd	a5,0(a3)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000565c:	631c                	ld	a5,0(a4)
    8000565e:	97b2                	add	a5,a5,a2
    80005660:	46c1                	li	a3,16
    80005662:	c794                	sw	a3,8(a5)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005664:	631c                	ld	a5,0(a4)
    80005666:	97b2                	add	a5,a5,a2
    80005668:	4685                	li	a3,1
    8000566a:	00d79623          	sh	a3,12(a5)
  disk.desc[idx[0]].next = idx[1];
    8000566e:	fa442783          	lw	a5,-92(s0)
    80005672:	6314                	ld	a3,0(a4)
    80005674:	96b2                	add	a3,a3,a2
    80005676:	00f69723          	sh	a5,14(a3)
  disk.desc[idx[1]].addr = (uint64) b->data;
    8000567a:	0792                	slli	a5,a5,0x4
    8000567c:	6314                	ld	a3,0(a4)
    8000567e:	96be                	add	a3,a3,a5
    80005680:	05898593          	addi	a1,s3,88
    80005684:	e28c                	sd	a1,0(a3)
  disk.desc[idx[1]].len = BSIZE;
    80005686:	6318                	ld	a4,0(a4)
    80005688:	973e                	add	a4,a4,a5
    8000568a:	40000693          	li	a3,1024
    8000568e:	c714                	sw	a3,8(a4)
  if(write)
    80005690:	e40c18e3          	bnez	s8,800054e0 <virtio_disk_rw+0xc2>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005694:	00016717          	auipc	a4,0x16
    80005698:	96c73703          	ld	a4,-1684(a4) # 8001b000 <disk+0x2000>
    8000569c:	973e                	add	a4,a4,a5
    8000569e:	4689                	li	a3,2
    800056a0:	00d71623          	sh	a3,12(a4)
    800056a4:	b5a9                	j	800054ee <virtio_disk_rw+0xd0>

00000000800056a6 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800056a6:	1101                	addi	sp,sp,-32
    800056a8:	ec06                	sd	ra,24(sp)
    800056aa:	e822                	sd	s0,16(sp)
    800056ac:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800056ae:	00016517          	auipc	a0,0x16
    800056b2:	a7a50513          	addi	a0,a0,-1414 # 8001b128 <disk+0x2128>
    800056b6:	00001097          	auipc	ra,0x1
    800056ba:	b88080e7          	jalr	-1144(ra) # 8000623e <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800056be:	100017b7          	lui	a5,0x10001
    800056c2:	53bc                	lw	a5,96(a5)
    800056c4:	8b8d                	andi	a5,a5,3
    800056c6:	10001737          	lui	a4,0x10001
    800056ca:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800056cc:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800056d0:	00016797          	auipc	a5,0x16
    800056d4:	93078793          	addi	a5,a5,-1744 # 8001b000 <disk+0x2000>
    800056d8:	6b94                	ld	a3,16(a5)
    800056da:	0207d703          	lhu	a4,32(a5)
    800056de:	0026d783          	lhu	a5,2(a3)
    800056e2:	06f70563          	beq	a4,a5,8000574c <virtio_disk_intr+0xa6>
    800056e6:	e426                	sd	s1,8(sp)
    800056e8:	e04a                	sd	s2,0(sp)
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800056ea:	00014917          	auipc	s2,0x14
    800056ee:	91690913          	addi	s2,s2,-1770 # 80019000 <disk>
    800056f2:	00016497          	auipc	s1,0x16
    800056f6:	90e48493          	addi	s1,s1,-1778 # 8001b000 <disk+0x2000>
    __sync_synchronize();
    800056fa:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800056fe:	6898                	ld	a4,16(s1)
    80005700:	0204d783          	lhu	a5,32(s1)
    80005704:	8b9d                	andi	a5,a5,7
    80005706:	078e                	slli	a5,a5,0x3
    80005708:	97ba                	add	a5,a5,a4
    8000570a:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000570c:	20078713          	addi	a4,a5,512
    80005710:	0712                	slli	a4,a4,0x4
    80005712:	974a                	add	a4,a4,s2
    80005714:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80005718:	e731                	bnez	a4,80005764 <virtio_disk_intr+0xbe>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000571a:	20078793          	addi	a5,a5,512
    8000571e:	0792                	slli	a5,a5,0x4
    80005720:	97ca                	add	a5,a5,s2
    80005722:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005724:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005728:	ffffc097          	auipc	ra,0xffffc
    8000572c:	fec080e7          	jalr	-20(ra) # 80001714 <wakeup>

    disk.used_idx += 1;
    80005730:	0204d783          	lhu	a5,32(s1)
    80005734:	2785                	addiw	a5,a5,1
    80005736:	17c2                	slli	a5,a5,0x30
    80005738:	93c1                	srli	a5,a5,0x30
    8000573a:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    8000573e:	6898                	ld	a4,16(s1)
    80005740:	00275703          	lhu	a4,2(a4)
    80005744:	faf71be3          	bne	a4,a5,800056fa <virtio_disk_intr+0x54>
    80005748:	64a2                	ld	s1,8(sp)
    8000574a:	6902                	ld	s2,0(sp)
  }

  release(&disk.vdisk_lock);
    8000574c:	00016517          	auipc	a0,0x16
    80005750:	9dc50513          	addi	a0,a0,-1572 # 8001b128 <disk+0x2128>
    80005754:	00001097          	auipc	ra,0x1
    80005758:	b9a080e7          	jalr	-1126(ra) # 800062ee <release>
}
    8000575c:	60e2                	ld	ra,24(sp)
    8000575e:	6442                	ld	s0,16(sp)
    80005760:	6105                	addi	sp,sp,32
    80005762:	8082                	ret
      panic("virtio_disk_intr status");
    80005764:	00003517          	auipc	a0,0x3
    80005768:	f1c50513          	addi	a0,a0,-228 # 80008680 <etext+0x680>
    8000576c:	00000097          	auipc	ra,0x0
    80005770:	542080e7          	jalr	1346(ra) # 80005cae <panic>

0000000080005774 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005774:	1141                	addi	sp,sp,-16
    80005776:	e406                	sd	ra,8(sp)
    80005778:	e022                	sd	s0,0(sp)
    8000577a:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    8000577c:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005780:	2781                	sext.w	a5,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005782:	0037961b          	slliw	a2,a5,0x3
    80005786:	02004737          	lui	a4,0x2004
    8000578a:	963a                	add	a2,a2,a4
    8000578c:	0200c737          	lui	a4,0x200c
    80005790:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005794:	000f46b7          	lui	a3,0xf4
    80005798:	24068693          	addi	a3,a3,576 # f4240 <_entry-0x7ff0bdc0>
    8000579c:	9736                	add	a4,a4,a3
    8000579e:	e218                	sd	a4,0(a2)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800057a0:	00279713          	slli	a4,a5,0x2
    800057a4:	973e                	add	a4,a4,a5
    800057a6:	070e                	slli	a4,a4,0x3
    800057a8:	00017797          	auipc	a5,0x17
    800057ac:	85878793          	addi	a5,a5,-1960 # 8001c000 <timer_scratch>
    800057b0:	97ba                	add	a5,a5,a4
  scratch[3] = CLINT_MTIMECMP(id);
    800057b2:	ef90                	sd	a2,24(a5)
  scratch[4] = interval;
    800057b4:	f394                	sd	a3,32(a5)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    800057b6:	34079073          	csrw	mscratch,a5
  asm volatile("csrw mtvec, %0" : : "r" (x));
    800057ba:	00000797          	auipc	a5,0x0
    800057be:	9b678793          	addi	a5,a5,-1610 # 80005170 <timervec>
    800057c2:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800057c6:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    800057ca:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800057ce:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    800057d2:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    800057d6:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    800057da:	30479073          	csrw	mie,a5
}
    800057de:	60a2                	ld	ra,8(sp)
    800057e0:	6402                	ld	s0,0(sp)
    800057e2:	0141                	addi	sp,sp,16
    800057e4:	8082                	ret

00000000800057e6 <start>:
{
    800057e6:	1141                	addi	sp,sp,-16
    800057e8:	e406                	sd	ra,8(sp)
    800057ea:	e022                	sd	s0,0(sp)
    800057ec:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800057ee:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    800057f2:	7779                	lui	a4,0xffffe
    800057f4:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffda5bf>
    800057f8:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800057fa:	6705                	lui	a4,0x1
    800057fc:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005800:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005802:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005806:	ffffb797          	auipc	a5,0xffffb
    8000580a:	b3e78793          	addi	a5,a5,-1218 # 80000344 <main>
    8000580e:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005812:	4781                	li	a5,0
    80005814:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005818:	67c1                	lui	a5,0x10
    8000581a:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    8000581c:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005820:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005824:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005828:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    8000582c:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005830:	57fd                	li	a5,-1
    80005832:	83a9                	srli	a5,a5,0xa
    80005834:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005838:	47bd                	li	a5,15
    8000583a:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    8000583e:	00000097          	auipc	ra,0x0
    80005842:	f36080e7          	jalr	-202(ra) # 80005774 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005846:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    8000584a:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    8000584c:	823e                	mv	tp,a5
  asm volatile("mret");
    8000584e:	30200073          	mret
}
    80005852:	60a2                	ld	ra,8(sp)
    80005854:	6402                	ld	s0,0(sp)
    80005856:	0141                	addi	sp,sp,16
    80005858:	8082                	ret

000000008000585a <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    8000585a:	711d                	addi	sp,sp,-96
    8000585c:	ec86                	sd	ra,88(sp)
    8000585e:	e8a2                	sd	s0,80(sp)
    80005860:	e0ca                	sd	s2,64(sp)
    80005862:	1080                	addi	s0,sp,96
  int i;

  for(i = 0; i < n; i++){
    80005864:	04c05b63          	blez	a2,800058ba <consolewrite+0x60>
    80005868:	e4a6                	sd	s1,72(sp)
    8000586a:	fc4e                	sd	s3,56(sp)
    8000586c:	f852                	sd	s4,48(sp)
    8000586e:	f456                	sd	s5,40(sp)
    80005870:	f05a                	sd	s6,32(sp)
    80005872:	ec5e                	sd	s7,24(sp)
    80005874:	8a2a                	mv	s4,a0
    80005876:	84ae                	mv	s1,a1
    80005878:	89b2                	mv	s3,a2
    8000587a:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    8000587c:	faf40b93          	addi	s7,s0,-81
    80005880:	4b05                	li	s6,1
    80005882:	5afd                	li	s5,-1
    80005884:	86da                	mv	a3,s6
    80005886:	8626                	mv	a2,s1
    80005888:	85d2                	mv	a1,s4
    8000588a:	855e                	mv	a0,s7
    8000588c:	ffffc097          	auipc	ra,0xffffc
    80005890:	0f4080e7          	jalr	244(ra) # 80001980 <either_copyin>
    80005894:	03550563          	beq	a0,s5,800058be <consolewrite+0x64>
      break;
    uartputc(c);
    80005898:	faf44503          	lbu	a0,-81(s0)
    8000589c:	00000097          	auipc	ra,0x0
    800058a0:	7d0080e7          	jalr	2000(ra) # 8000606c <uartputc>
  for(i = 0; i < n; i++){
    800058a4:	2905                	addiw	s2,s2,1
    800058a6:	0485                	addi	s1,s1,1
    800058a8:	fd299ee3          	bne	s3,s2,80005884 <consolewrite+0x2a>
    800058ac:	64a6                	ld	s1,72(sp)
    800058ae:	79e2                	ld	s3,56(sp)
    800058b0:	7a42                	ld	s4,48(sp)
    800058b2:	7aa2                	ld	s5,40(sp)
    800058b4:	7b02                	ld	s6,32(sp)
    800058b6:	6be2                	ld	s7,24(sp)
    800058b8:	a809                	j	800058ca <consolewrite+0x70>
    800058ba:	4901                	li	s2,0
    800058bc:	a039                	j	800058ca <consolewrite+0x70>
    800058be:	64a6                	ld	s1,72(sp)
    800058c0:	79e2                	ld	s3,56(sp)
    800058c2:	7a42                	ld	s4,48(sp)
    800058c4:	7aa2                	ld	s5,40(sp)
    800058c6:	7b02                	ld	s6,32(sp)
    800058c8:	6be2                	ld	s7,24(sp)
  }

  return i;
}
    800058ca:	854a                	mv	a0,s2
    800058cc:	60e6                	ld	ra,88(sp)
    800058ce:	6446                	ld	s0,80(sp)
    800058d0:	6906                	ld	s2,64(sp)
    800058d2:	6125                	addi	sp,sp,96
    800058d4:	8082                	ret

00000000800058d6 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    800058d6:	711d                	addi	sp,sp,-96
    800058d8:	ec86                	sd	ra,88(sp)
    800058da:	e8a2                	sd	s0,80(sp)
    800058dc:	e4a6                	sd	s1,72(sp)
    800058de:	e0ca                	sd	s2,64(sp)
    800058e0:	fc4e                	sd	s3,56(sp)
    800058e2:	f852                	sd	s4,48(sp)
    800058e4:	f05a                	sd	s6,32(sp)
    800058e6:	ec5e                	sd	s7,24(sp)
    800058e8:	1080                	addi	s0,sp,96
    800058ea:	8b2a                	mv	s6,a0
    800058ec:	8a2e                	mv	s4,a1
    800058ee:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    800058f0:	8bb2                	mv	s7,a2
  acquire(&cons.lock);
    800058f2:	0001f517          	auipc	a0,0x1f
    800058f6:	84e50513          	addi	a0,a0,-1970 # 80024140 <cons>
    800058fa:	00001097          	auipc	ra,0x1
    800058fe:	944080e7          	jalr	-1724(ra) # 8000623e <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005902:	0001f497          	auipc	s1,0x1f
    80005906:	83e48493          	addi	s1,s1,-1986 # 80024140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    8000590a:	0001f917          	auipc	s2,0x1f
    8000590e:	8ce90913          	addi	s2,s2,-1842 # 800241d8 <cons+0x98>
  while(n > 0){
    80005912:	0d305263          	blez	s3,800059d6 <consoleread+0x100>
    while(cons.r == cons.w){
    80005916:	0984a783          	lw	a5,152(s1)
    8000591a:	09c4a703          	lw	a4,156(s1)
    8000591e:	0af71763          	bne	a4,a5,800059cc <consoleread+0xf6>
      if(myproc()->killed){
    80005922:	ffffb097          	auipc	ra,0xffffb
    80005926:	5a2080e7          	jalr	1442(ra) # 80000ec4 <myproc>
    8000592a:	551c                	lw	a5,40(a0)
    8000592c:	e7ad                	bnez	a5,80005996 <consoleread+0xc0>
      sleep(&cons.r, &cons.lock);
    8000592e:	85a6                	mv	a1,s1
    80005930:	854a                	mv	a0,s2
    80005932:	ffffc097          	auipc	ra,0xffffc
    80005936:	c5c080e7          	jalr	-932(ra) # 8000158e <sleep>
    while(cons.r == cons.w){
    8000593a:	0984a783          	lw	a5,152(s1)
    8000593e:	09c4a703          	lw	a4,156(s1)
    80005942:	fef700e3          	beq	a4,a5,80005922 <consoleread+0x4c>
    80005946:	f456                	sd	s5,40(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF];
    80005948:	0001e717          	auipc	a4,0x1e
    8000594c:	7f870713          	addi	a4,a4,2040 # 80024140 <cons>
    80005950:	0017869b          	addiw	a3,a5,1
    80005954:	08d72c23          	sw	a3,152(a4)
    80005958:	07f7f693          	andi	a3,a5,127
    8000595c:	9736                	add	a4,a4,a3
    8000595e:	01874703          	lbu	a4,24(a4)
    80005962:	00070a9b          	sext.w	s5,a4

    if(c == C('D')){  // end-of-file
    80005966:	4691                	li	a3,4
    80005968:	04da8a63          	beq	s5,a3,800059bc <consoleread+0xe6>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    8000596c:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005970:	4685                	li	a3,1
    80005972:	faf40613          	addi	a2,s0,-81
    80005976:	85d2                	mv	a1,s4
    80005978:	855a                	mv	a0,s6
    8000597a:	ffffc097          	auipc	ra,0xffffc
    8000597e:	fb0080e7          	jalr	-80(ra) # 8000192a <either_copyout>
    80005982:	57fd                	li	a5,-1
    80005984:	04f50863          	beq	a0,a5,800059d4 <consoleread+0xfe>
      break;

    dst++;
    80005988:	0a05                	addi	s4,s4,1
    --n;
    8000598a:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    8000598c:	47a9                	li	a5,10
    8000598e:	04fa8f63          	beq	s5,a5,800059ec <consoleread+0x116>
    80005992:	7aa2                	ld	s5,40(sp)
    80005994:	bfbd                	j	80005912 <consoleread+0x3c>
        release(&cons.lock);
    80005996:	0001e517          	auipc	a0,0x1e
    8000599a:	7aa50513          	addi	a0,a0,1962 # 80024140 <cons>
    8000599e:	00001097          	auipc	ra,0x1
    800059a2:	950080e7          	jalr	-1712(ra) # 800062ee <release>
        return -1;
    800059a6:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    800059a8:	60e6                	ld	ra,88(sp)
    800059aa:	6446                	ld	s0,80(sp)
    800059ac:	64a6                	ld	s1,72(sp)
    800059ae:	6906                	ld	s2,64(sp)
    800059b0:	79e2                	ld	s3,56(sp)
    800059b2:	7a42                	ld	s4,48(sp)
    800059b4:	7b02                	ld	s6,32(sp)
    800059b6:	6be2                	ld	s7,24(sp)
    800059b8:	6125                	addi	sp,sp,96
    800059ba:	8082                	ret
      if(n < target){
    800059bc:	0179fa63          	bgeu	s3,s7,800059d0 <consoleread+0xfa>
        cons.r--;
    800059c0:	0001f717          	auipc	a4,0x1f
    800059c4:	80f72c23          	sw	a5,-2024(a4) # 800241d8 <cons+0x98>
    800059c8:	7aa2                	ld	s5,40(sp)
    800059ca:	a031                	j	800059d6 <consoleread+0x100>
    800059cc:	f456                	sd	s5,40(sp)
    800059ce:	bfad                	j	80005948 <consoleread+0x72>
    800059d0:	7aa2                	ld	s5,40(sp)
    800059d2:	a011                	j	800059d6 <consoleread+0x100>
    800059d4:	7aa2                	ld	s5,40(sp)
  release(&cons.lock);
    800059d6:	0001e517          	auipc	a0,0x1e
    800059da:	76a50513          	addi	a0,a0,1898 # 80024140 <cons>
    800059de:	00001097          	auipc	ra,0x1
    800059e2:	910080e7          	jalr	-1776(ra) # 800062ee <release>
  return target - n;
    800059e6:	413b853b          	subw	a0,s7,s3
    800059ea:	bf7d                	j	800059a8 <consoleread+0xd2>
    800059ec:	7aa2                	ld	s5,40(sp)
    800059ee:	b7e5                	j	800059d6 <consoleread+0x100>

00000000800059f0 <consputc>:
{
    800059f0:	1141                	addi	sp,sp,-16
    800059f2:	e406                	sd	ra,8(sp)
    800059f4:	e022                	sd	s0,0(sp)
    800059f6:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    800059f8:	10000793          	li	a5,256
    800059fc:	00f50a63          	beq	a0,a5,80005a10 <consputc+0x20>
    uartputc_sync(c);
    80005a00:	00000097          	auipc	ra,0x0
    80005a04:	58e080e7          	jalr	1422(ra) # 80005f8e <uartputc_sync>
}
    80005a08:	60a2                	ld	ra,8(sp)
    80005a0a:	6402                	ld	s0,0(sp)
    80005a0c:	0141                	addi	sp,sp,16
    80005a0e:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005a10:	4521                	li	a0,8
    80005a12:	00000097          	auipc	ra,0x0
    80005a16:	57c080e7          	jalr	1404(ra) # 80005f8e <uartputc_sync>
    80005a1a:	02000513          	li	a0,32
    80005a1e:	00000097          	auipc	ra,0x0
    80005a22:	570080e7          	jalr	1392(ra) # 80005f8e <uartputc_sync>
    80005a26:	4521                	li	a0,8
    80005a28:	00000097          	auipc	ra,0x0
    80005a2c:	566080e7          	jalr	1382(ra) # 80005f8e <uartputc_sync>
    80005a30:	bfe1                	j	80005a08 <consputc+0x18>

0000000080005a32 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005a32:	1101                	addi	sp,sp,-32
    80005a34:	ec06                	sd	ra,24(sp)
    80005a36:	e822                	sd	s0,16(sp)
    80005a38:	e426                	sd	s1,8(sp)
    80005a3a:	1000                	addi	s0,sp,32
    80005a3c:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005a3e:	0001e517          	auipc	a0,0x1e
    80005a42:	70250513          	addi	a0,a0,1794 # 80024140 <cons>
    80005a46:	00000097          	auipc	ra,0x0
    80005a4a:	7f8080e7          	jalr	2040(ra) # 8000623e <acquire>

  switch(c){
    80005a4e:	47d5                	li	a5,21
    80005a50:	0af48263          	beq	s1,a5,80005af4 <consoleintr+0xc2>
    80005a54:	0297c963          	blt	a5,s1,80005a86 <consoleintr+0x54>
    80005a58:	47a1                	li	a5,8
    80005a5a:	0ef48963          	beq	s1,a5,80005b4c <consoleintr+0x11a>
    80005a5e:	47c1                	li	a5,16
    80005a60:	10f49c63          	bne	s1,a5,80005b78 <consoleintr+0x146>
  case C('P'):  // Print process list.
    procdump();
    80005a64:	ffffc097          	auipc	ra,0xffffc
    80005a68:	f72080e7          	jalr	-142(ra) # 800019d6 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005a6c:	0001e517          	auipc	a0,0x1e
    80005a70:	6d450513          	addi	a0,a0,1748 # 80024140 <cons>
    80005a74:	00001097          	auipc	ra,0x1
    80005a78:	87a080e7          	jalr	-1926(ra) # 800062ee <release>
}
    80005a7c:	60e2                	ld	ra,24(sp)
    80005a7e:	6442                	ld	s0,16(sp)
    80005a80:	64a2                	ld	s1,8(sp)
    80005a82:	6105                	addi	sp,sp,32
    80005a84:	8082                	ret
  switch(c){
    80005a86:	07f00793          	li	a5,127
    80005a8a:	0cf48163          	beq	s1,a5,80005b4c <consoleintr+0x11a>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005a8e:	0001e717          	auipc	a4,0x1e
    80005a92:	6b270713          	addi	a4,a4,1714 # 80024140 <cons>
    80005a96:	0a072783          	lw	a5,160(a4)
    80005a9a:	09872703          	lw	a4,152(a4)
    80005a9e:	9f99                	subw	a5,a5,a4
    80005aa0:	07f00713          	li	a4,127
    80005aa4:	fcf764e3          	bltu	a4,a5,80005a6c <consoleintr+0x3a>
      c = (c == '\r') ? '\n' : c;
    80005aa8:	47b5                	li	a5,13
    80005aaa:	0cf48a63          	beq	s1,a5,80005b7e <consoleintr+0x14c>
      consputc(c);
    80005aae:	8526                	mv	a0,s1
    80005ab0:	00000097          	auipc	ra,0x0
    80005ab4:	f40080e7          	jalr	-192(ra) # 800059f0 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005ab8:	0001e717          	auipc	a4,0x1e
    80005abc:	68870713          	addi	a4,a4,1672 # 80024140 <cons>
    80005ac0:	0a072683          	lw	a3,160(a4)
    80005ac4:	0016879b          	addiw	a5,a3,1
    80005ac8:	863e                	mv	a2,a5
    80005aca:	0af72023          	sw	a5,160(a4)
    80005ace:	07f6f693          	andi	a3,a3,127
    80005ad2:	9736                	add	a4,a4,a3
    80005ad4:	00970c23          	sb	s1,24(a4)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80005ad8:	ff648713          	addi	a4,s1,-10
    80005adc:	c779                	beqz	a4,80005baa <consoleintr+0x178>
    80005ade:	14f1                	addi	s1,s1,-4
    80005ae0:	c4e9                	beqz	s1,80005baa <consoleintr+0x178>
    80005ae2:	0001e797          	auipc	a5,0x1e
    80005ae6:	6f67a783          	lw	a5,1782(a5) # 800241d8 <cons+0x98>
    80005aea:	0807879b          	addiw	a5,a5,128
    80005aee:	f6f61fe3          	bne	a2,a5,80005a6c <consoleintr+0x3a>
    80005af2:	a865                	j	80005baa <consoleintr+0x178>
    80005af4:	e04a                	sd	s2,0(sp)
    while(cons.e != cons.w &&
    80005af6:	0001e717          	auipc	a4,0x1e
    80005afa:	64a70713          	addi	a4,a4,1610 # 80024140 <cons>
    80005afe:	0a072783          	lw	a5,160(a4)
    80005b02:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005b06:	0001e497          	auipc	s1,0x1e
    80005b0a:	63a48493          	addi	s1,s1,1594 # 80024140 <cons>
    while(cons.e != cons.w &&
    80005b0e:	4929                	li	s2,10
    80005b10:	02f70a63          	beq	a4,a5,80005b44 <consoleintr+0x112>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005b14:	37fd                	addiw	a5,a5,-1
    80005b16:	07f7f713          	andi	a4,a5,127
    80005b1a:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005b1c:	01874703          	lbu	a4,24(a4)
    80005b20:	03270463          	beq	a4,s2,80005b48 <consoleintr+0x116>
      cons.e--;
    80005b24:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005b28:	10000513          	li	a0,256
    80005b2c:	00000097          	auipc	ra,0x0
    80005b30:	ec4080e7          	jalr	-316(ra) # 800059f0 <consputc>
    while(cons.e != cons.w &&
    80005b34:	0a04a783          	lw	a5,160(s1)
    80005b38:	09c4a703          	lw	a4,156(s1)
    80005b3c:	fcf71ce3          	bne	a4,a5,80005b14 <consoleintr+0xe2>
    80005b40:	6902                	ld	s2,0(sp)
    80005b42:	b72d                	j	80005a6c <consoleintr+0x3a>
    80005b44:	6902                	ld	s2,0(sp)
    80005b46:	b71d                	j	80005a6c <consoleintr+0x3a>
    80005b48:	6902                	ld	s2,0(sp)
    80005b4a:	b70d                	j	80005a6c <consoleintr+0x3a>
    if(cons.e != cons.w){
    80005b4c:	0001e717          	auipc	a4,0x1e
    80005b50:	5f470713          	addi	a4,a4,1524 # 80024140 <cons>
    80005b54:	0a072783          	lw	a5,160(a4)
    80005b58:	09c72703          	lw	a4,156(a4)
    80005b5c:	f0f708e3          	beq	a4,a5,80005a6c <consoleintr+0x3a>
      cons.e--;
    80005b60:	37fd                	addiw	a5,a5,-1
    80005b62:	0001e717          	auipc	a4,0x1e
    80005b66:	66f72f23          	sw	a5,1662(a4) # 800241e0 <cons+0xa0>
      consputc(BACKSPACE);
    80005b6a:	10000513          	li	a0,256
    80005b6e:	00000097          	auipc	ra,0x0
    80005b72:	e82080e7          	jalr	-382(ra) # 800059f0 <consputc>
    80005b76:	bddd                	j	80005a6c <consoleintr+0x3a>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005b78:	ee048ae3          	beqz	s1,80005a6c <consoleintr+0x3a>
    80005b7c:	bf09                	j	80005a8e <consoleintr+0x5c>
      consputc(c);
    80005b7e:	4529                	li	a0,10
    80005b80:	00000097          	auipc	ra,0x0
    80005b84:	e70080e7          	jalr	-400(ra) # 800059f0 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005b88:	0001e717          	auipc	a4,0x1e
    80005b8c:	5b870713          	addi	a4,a4,1464 # 80024140 <cons>
    80005b90:	0a072683          	lw	a3,160(a4)
    80005b94:	0016861b          	addiw	a2,a3,1
    80005b98:	87b2                	mv	a5,a2
    80005b9a:	0ac72023          	sw	a2,160(a4)
    80005b9e:	07f6f693          	andi	a3,a3,127
    80005ba2:	9736                	add	a4,a4,a3
    80005ba4:	46a9                	li	a3,10
    80005ba6:	00d70c23          	sb	a3,24(a4)
        cons.w = cons.e;
    80005baa:	0001e717          	auipc	a4,0x1e
    80005bae:	62f72923          	sw	a5,1586(a4) # 800241dc <cons+0x9c>
        wakeup(&cons.r);
    80005bb2:	0001e517          	auipc	a0,0x1e
    80005bb6:	62650513          	addi	a0,a0,1574 # 800241d8 <cons+0x98>
    80005bba:	ffffc097          	auipc	ra,0xffffc
    80005bbe:	b5a080e7          	jalr	-1190(ra) # 80001714 <wakeup>
    80005bc2:	b56d                	j	80005a6c <consoleintr+0x3a>

0000000080005bc4 <consoleinit>:

void
consoleinit(void)
{
    80005bc4:	1141                	addi	sp,sp,-16
    80005bc6:	e406                	sd	ra,8(sp)
    80005bc8:	e022                	sd	s0,0(sp)
    80005bca:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005bcc:	00003597          	auipc	a1,0x3
    80005bd0:	acc58593          	addi	a1,a1,-1332 # 80008698 <etext+0x698>
    80005bd4:	0001e517          	auipc	a0,0x1e
    80005bd8:	56c50513          	addi	a0,a0,1388 # 80024140 <cons>
    80005bdc:	00000097          	auipc	ra,0x0
    80005be0:	5c8080e7          	jalr	1480(ra) # 800061a4 <initlock>

  uartinit();
    80005be4:	00000097          	auipc	ra,0x0
    80005be8:	350080e7          	jalr	848(ra) # 80005f34 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005bec:	00012797          	auipc	a5,0x12
    80005bf0:	8ec78793          	addi	a5,a5,-1812 # 800174d8 <devsw>
    80005bf4:	00000717          	auipc	a4,0x0
    80005bf8:	ce270713          	addi	a4,a4,-798 # 800058d6 <consoleread>
    80005bfc:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005bfe:	00000717          	auipc	a4,0x0
    80005c02:	c5c70713          	addi	a4,a4,-932 # 8000585a <consolewrite>
    80005c06:	ef98                	sd	a4,24(a5)
}
    80005c08:	60a2                	ld	ra,8(sp)
    80005c0a:	6402                	ld	s0,0(sp)
    80005c0c:	0141                	addi	sp,sp,16
    80005c0e:	8082                	ret

0000000080005c10 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005c10:	7179                	addi	sp,sp,-48
    80005c12:	f406                	sd	ra,40(sp)
    80005c14:	f022                	sd	s0,32(sp)
    80005c16:	e84a                	sd	s2,16(sp)
    80005c18:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005c1a:	c219                	beqz	a2,80005c20 <printint+0x10>
    80005c1c:	08054563          	bltz	a0,80005ca6 <printint+0x96>
    x = -xx;
  else
    x = xx;
    80005c20:	4301                	li	t1,0

  i = 0;
    80005c22:	fd040913          	addi	s2,s0,-48
    x = xx;
    80005c26:	86ca                	mv	a3,s2
  i = 0;
    80005c28:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005c2a:	00003817          	auipc	a6,0x3
    80005c2e:	bce80813          	addi	a6,a6,-1074 # 800087f8 <digits>
    80005c32:	88ba                	mv	a7,a4
    80005c34:	0017061b          	addiw	a2,a4,1
    80005c38:	8732                	mv	a4,a2
    80005c3a:	02b577bb          	remuw	a5,a0,a1
    80005c3e:	1782                	slli	a5,a5,0x20
    80005c40:	9381                	srli	a5,a5,0x20
    80005c42:	97c2                	add	a5,a5,a6
    80005c44:	0007c783          	lbu	a5,0(a5)
    80005c48:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005c4c:	87aa                	mv	a5,a0
    80005c4e:	02b5553b          	divuw	a0,a0,a1
    80005c52:	0685                	addi	a3,a3,1
    80005c54:	fcb7ffe3          	bgeu	a5,a1,80005c32 <printint+0x22>

  if(sign)
    80005c58:	00030c63          	beqz	t1,80005c70 <printint+0x60>
    buf[i++] = '-';
    80005c5c:	fe060793          	addi	a5,a2,-32
    80005c60:	00878633          	add	a2,a5,s0
    80005c64:	02d00793          	li	a5,45
    80005c68:	fef60823          	sb	a5,-16(a2)
    80005c6c:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    80005c70:	02e05663          	blez	a4,80005c9c <printint+0x8c>
    80005c74:	ec26                	sd	s1,24(sp)
    80005c76:	377d                	addiw	a4,a4,-1
    80005c78:	00e904b3          	add	s1,s2,a4
    80005c7c:	197d                	addi	s2,s2,-1
    80005c7e:	993a                	add	s2,s2,a4
    80005c80:	1702                	slli	a4,a4,0x20
    80005c82:	9301                	srli	a4,a4,0x20
    80005c84:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005c88:	0004c503          	lbu	a0,0(s1)
    80005c8c:	00000097          	auipc	ra,0x0
    80005c90:	d64080e7          	jalr	-668(ra) # 800059f0 <consputc>
  while(--i >= 0)
    80005c94:	14fd                	addi	s1,s1,-1
    80005c96:	ff2499e3          	bne	s1,s2,80005c88 <printint+0x78>
    80005c9a:	64e2                	ld	s1,24(sp)
}
    80005c9c:	70a2                	ld	ra,40(sp)
    80005c9e:	7402                	ld	s0,32(sp)
    80005ca0:	6942                	ld	s2,16(sp)
    80005ca2:	6145                	addi	sp,sp,48
    80005ca4:	8082                	ret
    x = -xx;
    80005ca6:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005caa:	4305                	li	t1,1
    x = -xx;
    80005cac:	bf9d                	j	80005c22 <printint+0x12>

0000000080005cae <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005cae:	1101                	addi	sp,sp,-32
    80005cb0:	ec06                	sd	ra,24(sp)
    80005cb2:	e822                	sd	s0,16(sp)
    80005cb4:	e426                	sd	s1,8(sp)
    80005cb6:	1000                	addi	s0,sp,32
    80005cb8:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005cba:	0001e797          	auipc	a5,0x1e
    80005cbe:	5407a323          	sw	zero,1350(a5) # 80024200 <pr+0x18>
  printf("panic: ");
    80005cc2:	00003517          	auipc	a0,0x3
    80005cc6:	9de50513          	addi	a0,a0,-1570 # 800086a0 <etext+0x6a0>
    80005cca:	00000097          	auipc	ra,0x0
    80005cce:	02e080e7          	jalr	46(ra) # 80005cf8 <printf>
  printf(s);
    80005cd2:	8526                	mv	a0,s1
    80005cd4:	00000097          	auipc	ra,0x0
    80005cd8:	024080e7          	jalr	36(ra) # 80005cf8 <printf>
  printf("\n");
    80005cdc:	00002517          	auipc	a0,0x2
    80005ce0:	33c50513          	addi	a0,a0,828 # 80008018 <etext+0x18>
    80005ce4:	00000097          	auipc	ra,0x0
    80005ce8:	014080e7          	jalr	20(ra) # 80005cf8 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005cec:	4785                	li	a5,1
    80005cee:	00006717          	auipc	a4,0x6
    80005cf2:	32f72723          	sw	a5,814(a4) # 8000c01c <panicked>
  for(;;)
    80005cf6:	a001                	j	80005cf6 <panic+0x48>

0000000080005cf8 <printf>:
{
    80005cf8:	7131                	addi	sp,sp,-192
    80005cfa:	fc86                	sd	ra,120(sp)
    80005cfc:	f8a2                	sd	s0,112(sp)
    80005cfe:	e8d2                	sd	s4,80(sp)
    80005d00:	ec6e                	sd	s11,24(sp)
    80005d02:	0100                	addi	s0,sp,128
    80005d04:	8a2a                	mv	s4,a0
    80005d06:	e40c                	sd	a1,8(s0)
    80005d08:	e810                	sd	a2,16(s0)
    80005d0a:	ec14                	sd	a3,24(s0)
    80005d0c:	f018                	sd	a4,32(s0)
    80005d0e:	f41c                	sd	a5,40(s0)
    80005d10:	03043823          	sd	a6,48(s0)
    80005d14:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005d18:	0001ed97          	auipc	s11,0x1e
    80005d1c:	4e8dad83          	lw	s11,1256(s11) # 80024200 <pr+0x18>
  if(locking)
    80005d20:	040d9463          	bnez	s11,80005d68 <printf+0x70>
  if (fmt == 0)
    80005d24:	040a0b63          	beqz	s4,80005d7a <printf+0x82>
  va_start(ap, fmt);
    80005d28:	00840793          	addi	a5,s0,8
    80005d2c:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005d30:	000a4503          	lbu	a0,0(s4)
    80005d34:	18050c63          	beqz	a0,80005ecc <printf+0x1d4>
    80005d38:	f4a6                	sd	s1,104(sp)
    80005d3a:	f0ca                	sd	s2,96(sp)
    80005d3c:	ecce                	sd	s3,88(sp)
    80005d3e:	e4d6                	sd	s5,72(sp)
    80005d40:	e0da                	sd	s6,64(sp)
    80005d42:	fc5e                	sd	s7,56(sp)
    80005d44:	f862                	sd	s8,48(sp)
    80005d46:	f466                	sd	s9,40(sp)
    80005d48:	f06a                	sd	s10,32(sp)
    80005d4a:	4981                	li	s3,0
    if(c != '%'){
    80005d4c:	02500b13          	li	s6,37
    switch(c){
    80005d50:	07000b93          	li	s7,112
  consputc('x');
    80005d54:	07800c93          	li	s9,120
    80005d58:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005d5a:	00003a97          	auipc	s5,0x3
    80005d5e:	a9ea8a93          	addi	s5,s5,-1378 # 800087f8 <digits>
    switch(c){
    80005d62:	07300c13          	li	s8,115
    80005d66:	a0b9                	j	80005db4 <printf+0xbc>
    acquire(&pr.lock);
    80005d68:	0001e517          	auipc	a0,0x1e
    80005d6c:	48050513          	addi	a0,a0,1152 # 800241e8 <pr>
    80005d70:	00000097          	auipc	ra,0x0
    80005d74:	4ce080e7          	jalr	1230(ra) # 8000623e <acquire>
    80005d78:	b775                	j	80005d24 <printf+0x2c>
    80005d7a:	f4a6                	sd	s1,104(sp)
    80005d7c:	f0ca                	sd	s2,96(sp)
    80005d7e:	ecce                	sd	s3,88(sp)
    80005d80:	e4d6                	sd	s5,72(sp)
    80005d82:	e0da                	sd	s6,64(sp)
    80005d84:	fc5e                	sd	s7,56(sp)
    80005d86:	f862                	sd	s8,48(sp)
    80005d88:	f466                	sd	s9,40(sp)
    80005d8a:	f06a                	sd	s10,32(sp)
    panic("null fmt");
    80005d8c:	00003517          	auipc	a0,0x3
    80005d90:	92450513          	addi	a0,a0,-1756 # 800086b0 <etext+0x6b0>
    80005d94:	00000097          	auipc	ra,0x0
    80005d98:	f1a080e7          	jalr	-230(ra) # 80005cae <panic>
      consputc(c);
    80005d9c:	00000097          	auipc	ra,0x0
    80005da0:	c54080e7          	jalr	-940(ra) # 800059f0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005da4:	0019879b          	addiw	a5,s3,1
    80005da8:	89be                	mv	s3,a5
    80005daa:	97d2                	add	a5,a5,s4
    80005dac:	0007c503          	lbu	a0,0(a5)
    80005db0:	10050563          	beqz	a0,80005eba <printf+0x1c2>
    if(c != '%'){
    80005db4:	ff6514e3          	bne	a0,s6,80005d9c <printf+0xa4>
    c = fmt[++i] & 0xff;
    80005db8:	0019879b          	addiw	a5,s3,1
    80005dbc:	89be                	mv	s3,a5
    80005dbe:	97d2                	add	a5,a5,s4
    80005dc0:	0007c783          	lbu	a5,0(a5)
    80005dc4:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80005dc8:	10078a63          	beqz	a5,80005edc <printf+0x1e4>
    switch(c){
    80005dcc:	05778a63          	beq	a5,s7,80005e20 <printf+0x128>
    80005dd0:	02fbf463          	bgeu	s7,a5,80005df8 <printf+0x100>
    80005dd4:	09878763          	beq	a5,s8,80005e62 <printf+0x16a>
    80005dd8:	0d979663          	bne	a5,s9,80005ea4 <printf+0x1ac>
      printint(va_arg(ap, int), 16, 1);
    80005ddc:	f8843783          	ld	a5,-120(s0)
    80005de0:	00878713          	addi	a4,a5,8
    80005de4:	f8e43423          	sd	a4,-120(s0)
    80005de8:	4605                	li	a2,1
    80005dea:	85ea                	mv	a1,s10
    80005dec:	4388                	lw	a0,0(a5)
    80005dee:	00000097          	auipc	ra,0x0
    80005df2:	e22080e7          	jalr	-478(ra) # 80005c10 <printint>
      break;
    80005df6:	b77d                	j	80005da4 <printf+0xac>
    switch(c){
    80005df8:	0b678063          	beq	a5,s6,80005e98 <printf+0x1a0>
    80005dfc:	06400713          	li	a4,100
    80005e00:	0ae79263          	bne	a5,a4,80005ea4 <printf+0x1ac>
      printint(va_arg(ap, int), 10, 1);
    80005e04:	f8843783          	ld	a5,-120(s0)
    80005e08:	00878713          	addi	a4,a5,8
    80005e0c:	f8e43423          	sd	a4,-120(s0)
    80005e10:	4605                	li	a2,1
    80005e12:	45a9                	li	a1,10
    80005e14:	4388                	lw	a0,0(a5)
    80005e16:	00000097          	auipc	ra,0x0
    80005e1a:	dfa080e7          	jalr	-518(ra) # 80005c10 <printint>
      break;
    80005e1e:	b759                	j	80005da4 <printf+0xac>
      printptr(va_arg(ap, uint64));
    80005e20:	f8843783          	ld	a5,-120(s0)
    80005e24:	00878713          	addi	a4,a5,8
    80005e28:	f8e43423          	sd	a4,-120(s0)
    80005e2c:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80005e30:	03000513          	li	a0,48
    80005e34:	00000097          	auipc	ra,0x0
    80005e38:	bbc080e7          	jalr	-1092(ra) # 800059f0 <consputc>
  consputc('x');
    80005e3c:	8566                	mv	a0,s9
    80005e3e:	00000097          	auipc	ra,0x0
    80005e42:	bb2080e7          	jalr	-1102(ra) # 800059f0 <consputc>
    80005e46:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005e48:	03c95793          	srli	a5,s2,0x3c
    80005e4c:	97d6                	add	a5,a5,s5
    80005e4e:	0007c503          	lbu	a0,0(a5)
    80005e52:	00000097          	auipc	ra,0x0
    80005e56:	b9e080e7          	jalr	-1122(ra) # 800059f0 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005e5a:	0912                	slli	s2,s2,0x4
    80005e5c:	34fd                	addiw	s1,s1,-1
    80005e5e:	f4ed                	bnez	s1,80005e48 <printf+0x150>
    80005e60:	b791                	j	80005da4 <printf+0xac>
      if((s = va_arg(ap, char*)) == 0)
    80005e62:	f8843783          	ld	a5,-120(s0)
    80005e66:	00878713          	addi	a4,a5,8
    80005e6a:	f8e43423          	sd	a4,-120(s0)
    80005e6e:	6384                	ld	s1,0(a5)
    80005e70:	cc89                	beqz	s1,80005e8a <printf+0x192>
      for(; *s; s++)
    80005e72:	0004c503          	lbu	a0,0(s1)
    80005e76:	d51d                	beqz	a0,80005da4 <printf+0xac>
        consputc(*s);
    80005e78:	00000097          	auipc	ra,0x0
    80005e7c:	b78080e7          	jalr	-1160(ra) # 800059f0 <consputc>
      for(; *s; s++)
    80005e80:	0485                	addi	s1,s1,1
    80005e82:	0004c503          	lbu	a0,0(s1)
    80005e86:	f96d                	bnez	a0,80005e78 <printf+0x180>
    80005e88:	bf31                	j	80005da4 <printf+0xac>
        s = "(null)";
    80005e8a:	00003497          	auipc	s1,0x3
    80005e8e:	81e48493          	addi	s1,s1,-2018 # 800086a8 <etext+0x6a8>
      for(; *s; s++)
    80005e92:	02800513          	li	a0,40
    80005e96:	b7cd                	j	80005e78 <printf+0x180>
      consputc('%');
    80005e98:	855a                	mv	a0,s6
    80005e9a:	00000097          	auipc	ra,0x0
    80005e9e:	b56080e7          	jalr	-1194(ra) # 800059f0 <consputc>
      break;
    80005ea2:	b709                	j	80005da4 <printf+0xac>
      consputc('%');
    80005ea4:	855a                	mv	a0,s6
    80005ea6:	00000097          	auipc	ra,0x0
    80005eaa:	b4a080e7          	jalr	-1206(ra) # 800059f0 <consputc>
      consputc(c);
    80005eae:	8526                	mv	a0,s1
    80005eb0:	00000097          	auipc	ra,0x0
    80005eb4:	b40080e7          	jalr	-1216(ra) # 800059f0 <consputc>
      break;
    80005eb8:	b5f5                	j	80005da4 <printf+0xac>
    80005eba:	74a6                	ld	s1,104(sp)
    80005ebc:	7906                	ld	s2,96(sp)
    80005ebe:	69e6                	ld	s3,88(sp)
    80005ec0:	6aa6                	ld	s5,72(sp)
    80005ec2:	6b06                	ld	s6,64(sp)
    80005ec4:	7be2                	ld	s7,56(sp)
    80005ec6:	7c42                	ld	s8,48(sp)
    80005ec8:	7ca2                	ld	s9,40(sp)
    80005eca:	7d02                	ld	s10,32(sp)
  if(locking)
    80005ecc:	020d9263          	bnez	s11,80005ef0 <printf+0x1f8>
}
    80005ed0:	70e6                	ld	ra,120(sp)
    80005ed2:	7446                	ld	s0,112(sp)
    80005ed4:	6a46                	ld	s4,80(sp)
    80005ed6:	6de2                	ld	s11,24(sp)
    80005ed8:	6129                	addi	sp,sp,192
    80005eda:	8082                	ret
    80005edc:	74a6                	ld	s1,104(sp)
    80005ede:	7906                	ld	s2,96(sp)
    80005ee0:	69e6                	ld	s3,88(sp)
    80005ee2:	6aa6                	ld	s5,72(sp)
    80005ee4:	6b06                	ld	s6,64(sp)
    80005ee6:	7be2                	ld	s7,56(sp)
    80005ee8:	7c42                	ld	s8,48(sp)
    80005eea:	7ca2                	ld	s9,40(sp)
    80005eec:	7d02                	ld	s10,32(sp)
    80005eee:	bff9                	j	80005ecc <printf+0x1d4>
    release(&pr.lock);
    80005ef0:	0001e517          	auipc	a0,0x1e
    80005ef4:	2f850513          	addi	a0,a0,760 # 800241e8 <pr>
    80005ef8:	00000097          	auipc	ra,0x0
    80005efc:	3f6080e7          	jalr	1014(ra) # 800062ee <release>
}
    80005f00:	bfc1                	j	80005ed0 <printf+0x1d8>

0000000080005f02 <printfinit>:
    ;
}

void
printfinit(void)
{
    80005f02:	1141                	addi	sp,sp,-16
    80005f04:	e406                	sd	ra,8(sp)
    80005f06:	e022                	sd	s0,0(sp)
    80005f08:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    80005f0a:	00002597          	auipc	a1,0x2
    80005f0e:	7b658593          	addi	a1,a1,1974 # 800086c0 <etext+0x6c0>
    80005f12:	0001e517          	auipc	a0,0x1e
    80005f16:	2d650513          	addi	a0,a0,726 # 800241e8 <pr>
    80005f1a:	00000097          	auipc	ra,0x0
    80005f1e:	28a080e7          	jalr	650(ra) # 800061a4 <initlock>
  pr.locking = 1;
    80005f22:	4785                	li	a5,1
    80005f24:	0001e717          	auipc	a4,0x1e
    80005f28:	2cf72e23          	sw	a5,732(a4) # 80024200 <pr+0x18>
}
    80005f2c:	60a2                	ld	ra,8(sp)
    80005f2e:	6402                	ld	s0,0(sp)
    80005f30:	0141                	addi	sp,sp,16
    80005f32:	8082                	ret

0000000080005f34 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80005f34:	1141                	addi	sp,sp,-16
    80005f36:	e406                	sd	ra,8(sp)
    80005f38:	e022                	sd	s0,0(sp)
    80005f3a:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005f3c:	100007b7          	lui	a5,0x10000
    80005f40:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005f44:	10000737          	lui	a4,0x10000
    80005f48:	f8000693          	li	a3,-128
    80005f4c:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005f50:	468d                	li	a3,3
    80005f52:	10000637          	lui	a2,0x10000
    80005f56:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005f5a:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005f5e:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005f62:	8732                	mv	a4,a2
    80005f64:	461d                	li	a2,7
    80005f66:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80005f6a:	00d780a3          	sb	a3,1(a5)

  initlock(&uart_tx_lock, "uart");
    80005f6e:	00002597          	auipc	a1,0x2
    80005f72:	75a58593          	addi	a1,a1,1882 # 800086c8 <etext+0x6c8>
    80005f76:	0001e517          	auipc	a0,0x1e
    80005f7a:	29250513          	addi	a0,a0,658 # 80024208 <uart_tx_lock>
    80005f7e:	00000097          	auipc	ra,0x0
    80005f82:	226080e7          	jalr	550(ra) # 800061a4 <initlock>
}
    80005f86:	60a2                	ld	ra,8(sp)
    80005f88:	6402                	ld	s0,0(sp)
    80005f8a:	0141                	addi	sp,sp,16
    80005f8c:	8082                	ret

0000000080005f8e <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80005f8e:	1101                	addi	sp,sp,-32
    80005f90:	ec06                	sd	ra,24(sp)
    80005f92:	e822                	sd	s0,16(sp)
    80005f94:	e426                	sd	s1,8(sp)
    80005f96:	1000                	addi	s0,sp,32
    80005f98:	84aa                	mv	s1,a0
  push_off();
    80005f9a:	00000097          	auipc	ra,0x0
    80005f9e:	254080e7          	jalr	596(ra) # 800061ee <push_off>

  if(panicked){
    80005fa2:	00006797          	auipc	a5,0x6
    80005fa6:	07a7a783          	lw	a5,122(a5) # 8000c01c <panicked>
    80005faa:	eb85                	bnez	a5,80005fda <uartputc_sync+0x4c>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005fac:	10000737          	lui	a4,0x10000
    80005fb0:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    80005fb2:	00074783          	lbu	a5,0(a4)
    80005fb6:	0207f793          	andi	a5,a5,32
    80005fba:	dfe5                	beqz	a5,80005fb2 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80005fbc:	0ff4f513          	zext.b	a0,s1
    80005fc0:	100007b7          	lui	a5,0x10000
    80005fc4:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80005fc8:	00000097          	auipc	ra,0x0
    80005fcc:	2ca080e7          	jalr	714(ra) # 80006292 <pop_off>
}
    80005fd0:	60e2                	ld	ra,24(sp)
    80005fd2:	6442                	ld	s0,16(sp)
    80005fd4:	64a2                	ld	s1,8(sp)
    80005fd6:	6105                	addi	sp,sp,32
    80005fd8:	8082                	ret
    for(;;)
    80005fda:	a001                	j	80005fda <uartputc_sync+0x4c>

0000000080005fdc <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80005fdc:	00006797          	auipc	a5,0x6
    80005fe0:	0447b783          	ld	a5,68(a5) # 8000c020 <uart_tx_r>
    80005fe4:	00006717          	auipc	a4,0x6
    80005fe8:	04473703          	ld	a4,68(a4) # 8000c028 <uart_tx_w>
    80005fec:	06f70f63          	beq	a4,a5,8000606a <uartstart+0x8e>
{
    80005ff0:	7139                	addi	sp,sp,-64
    80005ff2:	fc06                	sd	ra,56(sp)
    80005ff4:	f822                	sd	s0,48(sp)
    80005ff6:	f426                	sd	s1,40(sp)
    80005ff8:	f04a                	sd	s2,32(sp)
    80005ffa:	ec4e                	sd	s3,24(sp)
    80005ffc:	e852                	sd	s4,16(sp)
    80005ffe:	e456                	sd	s5,8(sp)
    80006000:	e05a                	sd	s6,0(sp)
    80006002:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006004:	10000937          	lui	s2,0x10000
    80006008:	0915                	addi	s2,s2,5 # 10000005 <_entry-0x6ffffffb>
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000600a:	0001ea97          	auipc	s5,0x1e
    8000600e:	1fea8a93          	addi	s5,s5,510 # 80024208 <uart_tx_lock>
    uart_tx_r += 1;
    80006012:	00006497          	auipc	s1,0x6
    80006016:	00e48493          	addi	s1,s1,14 # 8000c020 <uart_tx_r>
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    
    WriteReg(THR, c);
    8000601a:	10000a37          	lui	s4,0x10000
    if(uart_tx_w == uart_tx_r){
    8000601e:	00006997          	auipc	s3,0x6
    80006022:	00a98993          	addi	s3,s3,10 # 8000c028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006026:	00094703          	lbu	a4,0(s2)
    8000602a:	02077713          	andi	a4,a4,32
    8000602e:	c705                	beqz	a4,80006056 <uartstart+0x7a>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006030:	01f7f713          	andi	a4,a5,31
    80006034:	9756                	add	a4,a4,s5
    80006036:	01874b03          	lbu	s6,24(a4)
    uart_tx_r += 1;
    8000603a:	0785                	addi	a5,a5,1
    8000603c:	e09c                	sd	a5,0(s1)
    wakeup(&uart_tx_r);
    8000603e:	8526                	mv	a0,s1
    80006040:	ffffb097          	auipc	ra,0xffffb
    80006044:	6d4080e7          	jalr	1748(ra) # 80001714 <wakeup>
    WriteReg(THR, c);
    80006048:	016a0023          	sb	s6,0(s4) # 10000000 <_entry-0x70000000>
    if(uart_tx_w == uart_tx_r){
    8000604c:	609c                	ld	a5,0(s1)
    8000604e:	0009b703          	ld	a4,0(s3)
    80006052:	fcf71ae3          	bne	a4,a5,80006026 <uartstart+0x4a>
  }
}
    80006056:	70e2                	ld	ra,56(sp)
    80006058:	7442                	ld	s0,48(sp)
    8000605a:	74a2                	ld	s1,40(sp)
    8000605c:	7902                	ld	s2,32(sp)
    8000605e:	69e2                	ld	s3,24(sp)
    80006060:	6a42                	ld	s4,16(sp)
    80006062:	6aa2                	ld	s5,8(sp)
    80006064:	6b02                	ld	s6,0(sp)
    80006066:	6121                	addi	sp,sp,64
    80006068:	8082                	ret
    8000606a:	8082                	ret

000000008000606c <uartputc>:
{
    8000606c:	7179                	addi	sp,sp,-48
    8000606e:	f406                	sd	ra,40(sp)
    80006070:	f022                	sd	s0,32(sp)
    80006072:	e052                	sd	s4,0(sp)
    80006074:	1800                	addi	s0,sp,48
    80006076:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80006078:	0001e517          	auipc	a0,0x1e
    8000607c:	19050513          	addi	a0,a0,400 # 80024208 <uart_tx_lock>
    80006080:	00000097          	auipc	ra,0x0
    80006084:	1be080e7          	jalr	446(ra) # 8000623e <acquire>
  if(panicked){
    80006088:	00006797          	auipc	a5,0x6
    8000608c:	f947a783          	lw	a5,-108(a5) # 8000c01c <panicked>
    80006090:	c391                	beqz	a5,80006094 <uartputc+0x28>
    for(;;)
    80006092:	a001                	j	80006092 <uartputc+0x26>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006094:	00006717          	auipc	a4,0x6
    80006098:	f9473703          	ld	a4,-108(a4) # 8000c028 <uart_tx_w>
    8000609c:	00006797          	auipc	a5,0x6
    800060a0:	f847b783          	ld	a5,-124(a5) # 8000c020 <uart_tx_r>
    800060a4:	02078793          	addi	a5,a5,32
    800060a8:	04e79163          	bne	a5,a4,800060ea <uartputc+0x7e>
    800060ac:	ec26                	sd	s1,24(sp)
    800060ae:	e84a                	sd	s2,16(sp)
    800060b0:	e44e                	sd	s3,8(sp)
      sleep(&uart_tx_r, &uart_tx_lock);
    800060b2:	0001e997          	auipc	s3,0x1e
    800060b6:	15698993          	addi	s3,s3,342 # 80024208 <uart_tx_lock>
    800060ba:	00006497          	auipc	s1,0x6
    800060be:	f6648493          	addi	s1,s1,-154 # 8000c020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800060c2:	00006917          	auipc	s2,0x6
    800060c6:	f6690913          	addi	s2,s2,-154 # 8000c028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    800060ca:	85ce                	mv	a1,s3
    800060cc:	8526                	mv	a0,s1
    800060ce:	ffffb097          	auipc	ra,0xffffb
    800060d2:	4c0080e7          	jalr	1216(ra) # 8000158e <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800060d6:	00093703          	ld	a4,0(s2)
    800060da:	609c                	ld	a5,0(s1)
    800060dc:	02078793          	addi	a5,a5,32
    800060e0:	fee785e3          	beq	a5,a4,800060ca <uartputc+0x5e>
    800060e4:	64e2                	ld	s1,24(sp)
    800060e6:	6942                	ld	s2,16(sp)
    800060e8:	69a2                	ld	s3,8(sp)
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    800060ea:	01f77693          	andi	a3,a4,31
    800060ee:	0001e797          	auipc	a5,0x1e
    800060f2:	11a78793          	addi	a5,a5,282 # 80024208 <uart_tx_lock>
    800060f6:	97b6                	add	a5,a5,a3
    800060f8:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    800060fc:	0705                	addi	a4,a4,1
    800060fe:	00006797          	auipc	a5,0x6
    80006102:	f2e7b523          	sd	a4,-214(a5) # 8000c028 <uart_tx_w>
      uartstart();
    80006106:	00000097          	auipc	ra,0x0
    8000610a:	ed6080e7          	jalr	-298(ra) # 80005fdc <uartstart>
      release(&uart_tx_lock);
    8000610e:	0001e517          	auipc	a0,0x1e
    80006112:	0fa50513          	addi	a0,a0,250 # 80024208 <uart_tx_lock>
    80006116:	00000097          	auipc	ra,0x0
    8000611a:	1d8080e7          	jalr	472(ra) # 800062ee <release>
}
    8000611e:	70a2                	ld	ra,40(sp)
    80006120:	7402                	ld	s0,32(sp)
    80006122:	6a02                	ld	s4,0(sp)
    80006124:	6145                	addi	sp,sp,48
    80006126:	8082                	ret

0000000080006128 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006128:	1141                	addi	sp,sp,-16
    8000612a:	e406                	sd	ra,8(sp)
    8000612c:	e022                	sd	s0,0(sp)
    8000612e:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80006130:	100007b7          	lui	a5,0x10000
    80006134:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006138:	8b85                	andi	a5,a5,1
    8000613a:	cb89                	beqz	a5,8000614c <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000613c:	100007b7          	lui	a5,0x10000
    80006140:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    80006144:	60a2                	ld	ra,8(sp)
    80006146:	6402                	ld	s0,0(sp)
    80006148:	0141                	addi	sp,sp,16
    8000614a:	8082                	ret
    return -1;
    8000614c:	557d                	li	a0,-1
    8000614e:	bfdd                	j	80006144 <uartgetc+0x1c>

0000000080006150 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80006150:	1101                	addi	sp,sp,-32
    80006152:	ec06                	sd	ra,24(sp)
    80006154:	e822                	sd	s0,16(sp)
    80006156:	e426                	sd	s1,8(sp)
    80006158:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000615a:	54fd                	li	s1,-1
    int c = uartgetc();
    8000615c:	00000097          	auipc	ra,0x0
    80006160:	fcc080e7          	jalr	-52(ra) # 80006128 <uartgetc>
    if(c == -1)
    80006164:	00950763          	beq	a0,s1,80006172 <uartintr+0x22>
      break;
    consoleintr(c);
    80006168:	00000097          	auipc	ra,0x0
    8000616c:	8ca080e7          	jalr	-1846(ra) # 80005a32 <consoleintr>
  while(1){
    80006170:	b7f5                	j	8000615c <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    80006172:	0001e517          	auipc	a0,0x1e
    80006176:	09650513          	addi	a0,a0,150 # 80024208 <uart_tx_lock>
    8000617a:	00000097          	auipc	ra,0x0
    8000617e:	0c4080e7          	jalr	196(ra) # 8000623e <acquire>
  uartstart();
    80006182:	00000097          	auipc	ra,0x0
    80006186:	e5a080e7          	jalr	-422(ra) # 80005fdc <uartstart>
  release(&uart_tx_lock);
    8000618a:	0001e517          	auipc	a0,0x1e
    8000618e:	07e50513          	addi	a0,a0,126 # 80024208 <uart_tx_lock>
    80006192:	00000097          	auipc	ra,0x0
    80006196:	15c080e7          	jalr	348(ra) # 800062ee <release>
}
    8000619a:	60e2                	ld	ra,24(sp)
    8000619c:	6442                	ld	s0,16(sp)
    8000619e:	64a2                	ld	s1,8(sp)
    800061a0:	6105                	addi	sp,sp,32
    800061a2:	8082                	ret

00000000800061a4 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800061a4:	1141                	addi	sp,sp,-16
    800061a6:	e406                	sd	ra,8(sp)
    800061a8:	e022                	sd	s0,0(sp)
    800061aa:	0800                	addi	s0,sp,16
  lk->name = name;
    800061ac:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800061ae:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800061b2:	00053823          	sd	zero,16(a0)
}
    800061b6:	60a2                	ld	ra,8(sp)
    800061b8:	6402                	ld	s0,0(sp)
    800061ba:	0141                	addi	sp,sp,16
    800061bc:	8082                	ret

00000000800061be <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800061be:	411c                	lw	a5,0(a0)
    800061c0:	e399                	bnez	a5,800061c6 <holding+0x8>
    800061c2:	4501                	li	a0,0
  return r;
}
    800061c4:	8082                	ret
{
    800061c6:	1101                	addi	sp,sp,-32
    800061c8:	ec06                	sd	ra,24(sp)
    800061ca:	e822                	sd	s0,16(sp)
    800061cc:	e426                	sd	s1,8(sp)
    800061ce:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800061d0:	691c                	ld	a5,16(a0)
    800061d2:	84be                	mv	s1,a5
    800061d4:	ffffb097          	auipc	ra,0xffffb
    800061d8:	cd0080e7          	jalr	-816(ra) # 80000ea4 <mycpu>
    800061dc:	40a48533          	sub	a0,s1,a0
    800061e0:	00153513          	seqz	a0,a0
}
    800061e4:	60e2                	ld	ra,24(sp)
    800061e6:	6442                	ld	s0,16(sp)
    800061e8:	64a2                	ld	s1,8(sp)
    800061ea:	6105                	addi	sp,sp,32
    800061ec:	8082                	ret

00000000800061ee <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800061ee:	1101                	addi	sp,sp,-32
    800061f0:	ec06                	sd	ra,24(sp)
    800061f2:	e822                	sd	s0,16(sp)
    800061f4:	e426                	sd	s1,8(sp)
    800061f6:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800061f8:	100027f3          	csrr	a5,sstatus
    800061fc:	84be                	mv	s1,a5
    800061fe:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006202:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006204:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80006208:	ffffb097          	auipc	ra,0xffffb
    8000620c:	c9c080e7          	jalr	-868(ra) # 80000ea4 <mycpu>
    80006210:	5d3c                	lw	a5,120(a0)
    80006212:	cf89                	beqz	a5,8000622c <push_off+0x3e>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80006214:	ffffb097          	auipc	ra,0xffffb
    80006218:	c90080e7          	jalr	-880(ra) # 80000ea4 <mycpu>
    8000621c:	5d3c                	lw	a5,120(a0)
    8000621e:	2785                	addiw	a5,a5,1
    80006220:	dd3c                	sw	a5,120(a0)
}
    80006222:	60e2                	ld	ra,24(sp)
    80006224:	6442                	ld	s0,16(sp)
    80006226:	64a2                	ld	s1,8(sp)
    80006228:	6105                	addi	sp,sp,32
    8000622a:	8082                	ret
    mycpu()->intena = old;
    8000622c:	ffffb097          	auipc	ra,0xffffb
    80006230:	c78080e7          	jalr	-904(ra) # 80000ea4 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006234:	0014d793          	srli	a5,s1,0x1
    80006238:	8b85                	andi	a5,a5,1
    8000623a:	dd7c                	sw	a5,124(a0)
    8000623c:	bfe1                	j	80006214 <push_off+0x26>

000000008000623e <acquire>:
{
    8000623e:	1101                	addi	sp,sp,-32
    80006240:	ec06                	sd	ra,24(sp)
    80006242:	e822                	sd	s0,16(sp)
    80006244:	e426                	sd	s1,8(sp)
    80006246:	1000                	addi	s0,sp,32
    80006248:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000624a:	00000097          	auipc	ra,0x0
    8000624e:	fa4080e7          	jalr	-92(ra) # 800061ee <push_off>
  if(holding(lk))
    80006252:	8526                	mv	a0,s1
    80006254:	00000097          	auipc	ra,0x0
    80006258:	f6a080e7          	jalr	-150(ra) # 800061be <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000625c:	4705                	li	a4,1
  if(holding(lk))
    8000625e:	e115                	bnez	a0,80006282 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80006260:	87ba                	mv	a5,a4
    80006262:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006266:	2781                	sext.w	a5,a5
    80006268:	ffe5                	bnez	a5,80006260 <acquire+0x22>
  __sync_synchronize();
    8000626a:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    8000626e:	ffffb097          	auipc	ra,0xffffb
    80006272:	c36080e7          	jalr	-970(ra) # 80000ea4 <mycpu>
    80006276:	e888                	sd	a0,16(s1)
}
    80006278:	60e2                	ld	ra,24(sp)
    8000627a:	6442                	ld	s0,16(sp)
    8000627c:	64a2                	ld	s1,8(sp)
    8000627e:	6105                	addi	sp,sp,32
    80006280:	8082                	ret
    panic("acquire");
    80006282:	00002517          	auipc	a0,0x2
    80006286:	44e50513          	addi	a0,a0,1102 # 800086d0 <etext+0x6d0>
    8000628a:	00000097          	auipc	ra,0x0
    8000628e:	a24080e7          	jalr	-1500(ra) # 80005cae <panic>

0000000080006292 <pop_off>:

void
pop_off(void)
{
    80006292:	1141                	addi	sp,sp,-16
    80006294:	e406                	sd	ra,8(sp)
    80006296:	e022                	sd	s0,0(sp)
    80006298:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    8000629a:	ffffb097          	auipc	ra,0xffffb
    8000629e:	c0a080e7          	jalr	-1014(ra) # 80000ea4 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800062a2:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800062a6:	8b89                	andi	a5,a5,2
  if(intr_get())
    800062a8:	e39d                	bnez	a5,800062ce <pop_off+0x3c>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800062aa:	5d3c                	lw	a5,120(a0)
    800062ac:	02f05963          	blez	a5,800062de <pop_off+0x4c>
    panic("pop_off");
  c->noff -= 1;
    800062b0:	37fd                	addiw	a5,a5,-1
    800062b2:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800062b4:	eb89                	bnez	a5,800062c6 <pop_off+0x34>
    800062b6:	5d7c                	lw	a5,124(a0)
    800062b8:	c799                	beqz	a5,800062c6 <pop_off+0x34>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800062ba:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800062be:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800062c2:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800062c6:	60a2                	ld	ra,8(sp)
    800062c8:	6402                	ld	s0,0(sp)
    800062ca:	0141                	addi	sp,sp,16
    800062cc:	8082                	ret
    panic("pop_off - interruptible");
    800062ce:	00002517          	auipc	a0,0x2
    800062d2:	40a50513          	addi	a0,a0,1034 # 800086d8 <etext+0x6d8>
    800062d6:	00000097          	auipc	ra,0x0
    800062da:	9d8080e7          	jalr	-1576(ra) # 80005cae <panic>
    panic("pop_off");
    800062de:	00002517          	auipc	a0,0x2
    800062e2:	41250513          	addi	a0,a0,1042 # 800086f0 <etext+0x6f0>
    800062e6:	00000097          	auipc	ra,0x0
    800062ea:	9c8080e7          	jalr	-1592(ra) # 80005cae <panic>

00000000800062ee <release>:
{
    800062ee:	1101                	addi	sp,sp,-32
    800062f0:	ec06                	sd	ra,24(sp)
    800062f2:	e822                	sd	s0,16(sp)
    800062f4:	e426                	sd	s1,8(sp)
    800062f6:	1000                	addi	s0,sp,32
    800062f8:	84aa                	mv	s1,a0
  if(!holding(lk))
    800062fa:	00000097          	auipc	ra,0x0
    800062fe:	ec4080e7          	jalr	-316(ra) # 800061be <holding>
    80006302:	c115                	beqz	a0,80006326 <release+0x38>
  lk->cpu = 0;
    80006304:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006308:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    8000630c:	0310000f          	fence	rw,w
    80006310:	0004a023          	sw	zero,0(s1)
  pop_off();
    80006314:	00000097          	auipc	ra,0x0
    80006318:	f7e080e7          	jalr	-130(ra) # 80006292 <pop_off>
}
    8000631c:	60e2                	ld	ra,24(sp)
    8000631e:	6442                	ld	s0,16(sp)
    80006320:	64a2                	ld	s1,8(sp)
    80006322:	6105                	addi	sp,sp,32
    80006324:	8082                	ret
    panic("release");
    80006326:	00002517          	auipc	a0,0x2
    8000632a:	3d250513          	addi	a0,a0,978 # 800086f8 <etext+0x6f8>
    8000632e:	00000097          	auipc	ra,0x0
    80006332:	980080e7          	jalr	-1664(ra) # 80005cae <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
