
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	02f50163          	beq	a0,a5,2c <main+0x2c>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	80058593          	addi	a1,a1,-2048 # 810 <malloc+0xfe>
  18:	4509                	li	a0,2
  1a:	00000097          	auipc	ra,0x0
  1e:	60e080e7          	jalr	1550(ra) # 628 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	2cc080e7          	jalr	716(ra) # 2f0 <exit>
  2c:	e426                	sd	s1,8(sp)
  2e:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  30:	698c                	ld	a1,16(a1)
  32:	6488                	ld	a0,8(s1)
  34:	00000097          	auipc	ra,0x0
  38:	31c080e7          	jalr	796(ra) # 350 <link>
  3c:	00054763          	bltz	a0,4a <main+0x4a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  40:	4501                	li	a0,0
  42:	00000097          	auipc	ra,0x0
  46:	2ae080e7          	jalr	686(ra) # 2f0 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4a:	6894                	ld	a3,16(s1)
  4c:	6490                	ld	a2,8(s1)
  4e:	00000597          	auipc	a1,0x0
  52:	7da58593          	addi	a1,a1,2010 # 828 <malloc+0x116>
  56:	4509                	li	a0,2
  58:	00000097          	auipc	ra,0x0
  5c:	5d0080e7          	jalr	1488(ra) # 628 <fprintf>
  60:	b7c5                	j	40 <main+0x40>

0000000000000062 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  62:	1141                	addi	sp,sp,-16
  64:	e406                	sd	ra,8(sp)
  66:	e022                	sd	s0,0(sp)
  68:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	addi	a1,a1,1
  6e:	0785                	addi	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0xa>
    ;
  return os;
}
  7a:	60a2                	ld	ra,8(sp)
  7c:	6402                	ld	s0,0(sp)
  7e:	0141                	addi	sp,sp,16
  80:	8082                	ret

0000000000000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	1141                	addi	sp,sp,-16
  84:	e406                	sd	ra,8(sp)
  86:	e022                	sd	s0,0(sp)
  88:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  8a:	00054783          	lbu	a5,0(a0)
  8e:	cb91                	beqz	a5,a2 <strcmp+0x20>
  90:	0005c703          	lbu	a4,0(a1)
  94:	00f71763          	bne	a4,a5,a2 <strcmp+0x20>
    p++, q++;
  98:	0505                	addi	a0,a0,1
  9a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  9c:	00054783          	lbu	a5,0(a0)
  a0:	fbe5                	bnez	a5,90 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a2:	0005c503          	lbu	a0,0(a1)
}
  a6:	40a7853b          	subw	a0,a5,a0
  aa:	60a2                	ld	ra,8(sp)
  ac:	6402                	ld	s0,0(sp)
  ae:	0141                	addi	sp,sp,16
  b0:	8082                	ret

00000000000000b2 <strlen>:

uint
strlen(const char *s)
{
  b2:	1141                	addi	sp,sp,-16
  b4:	e406                	sd	ra,8(sp)
  b6:	e022                	sd	s0,0(sp)
  b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ba:	00054783          	lbu	a5,0(a0)
  be:	cf91                	beqz	a5,da <strlen+0x28>
  c0:	00150793          	addi	a5,a0,1
  c4:	86be                	mv	a3,a5
  c6:	0785                	addi	a5,a5,1
  c8:	fff7c703          	lbu	a4,-1(a5)
  cc:	ff65                	bnez	a4,c4 <strlen+0x12>
  ce:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  d2:	60a2                	ld	ra,8(sp)
  d4:	6402                	ld	s0,0(sp)
  d6:	0141                	addi	sp,sp,16
  d8:	8082                	ret
  for(n = 0; s[n]; n++)
  da:	4501                	li	a0,0
  dc:	bfdd                	j	d2 <strlen+0x20>

00000000000000de <memset>:

void*
memset(void *dst, int c, uint n)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e406                	sd	ra,8(sp)
  e2:	e022                	sd	s0,0(sp)
  e4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  e6:	ca19                	beqz	a2,fc <memset+0x1e>
  e8:	87aa                	mv	a5,a0
  ea:	1602                	slli	a2,a2,0x20
  ec:	9201                	srli	a2,a2,0x20
  ee:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  f6:	0785                	addi	a5,a5,1
  f8:	fee79de3          	bne	a5,a4,f2 <memset+0x14>
  }
  return dst;
}
  fc:	60a2                	ld	ra,8(sp)
  fe:	6402                	ld	s0,0(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret

0000000000000104 <strchr>:

char*
strchr(const char *s, char c)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 10c:	00054783          	lbu	a5,0(a0)
 110:	cf81                	beqz	a5,128 <strchr+0x24>
    if(*s == c)
 112:	00f58763          	beq	a1,a5,120 <strchr+0x1c>
  for(; *s; s++)
 116:	0505                	addi	a0,a0,1
 118:	00054783          	lbu	a5,0(a0)
 11c:	fbfd                	bnez	a5,112 <strchr+0xe>
      return (char*)s;
  return 0;
 11e:	4501                	li	a0,0
}
 120:	60a2                	ld	ra,8(sp)
 122:	6402                	ld	s0,0(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret
  return 0;
 128:	4501                	li	a0,0
 12a:	bfdd                	j	120 <strchr+0x1c>

000000000000012c <gets>:

char*
gets(char *buf, int max)
{
 12c:	711d                	addi	sp,sp,-96
 12e:	ec86                	sd	ra,88(sp)
 130:	e8a2                	sd	s0,80(sp)
 132:	e4a6                	sd	s1,72(sp)
 134:	e0ca                	sd	s2,64(sp)
 136:	fc4e                	sd	s3,56(sp)
 138:	f852                	sd	s4,48(sp)
 13a:	f456                	sd	s5,40(sp)
 13c:	f05a                	sd	s6,32(sp)
 13e:	ec5e                	sd	s7,24(sp)
 140:	e862                	sd	s8,16(sp)
 142:	1080                	addi	s0,sp,96
 144:	8baa                	mv	s7,a0
 146:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 148:	892a                	mv	s2,a0
 14a:	4481                	li	s1,0
    cc = read(0, &c, 1);
 14c:	faf40b13          	addi	s6,s0,-81
 150:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 152:	8c26                	mv	s8,s1
 154:	0014899b          	addiw	s3,s1,1
 158:	84ce                	mv	s1,s3
 15a:	0349d663          	bge	s3,s4,186 <gets+0x5a>
    cc = read(0, &c, 1);
 15e:	8656                	mv	a2,s5
 160:	85da                	mv	a1,s6
 162:	4501                	li	a0,0
 164:	00000097          	auipc	ra,0x0
 168:	1a4080e7          	jalr	420(ra) # 308 <read>
    if(cc < 1)
 16c:	00a05d63          	blez	a0,186 <gets+0x5a>
      break;
    buf[i++] = c;
 170:	faf44783          	lbu	a5,-81(s0)
 174:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 178:	0905                	addi	s2,s2,1
 17a:	ff678713          	addi	a4,a5,-10
 17e:	c319                	beqz	a4,184 <gets+0x58>
 180:	17cd                	addi	a5,a5,-13
 182:	fbe1                	bnez	a5,152 <gets+0x26>
    buf[i++] = c;
 184:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 186:	9c5e                	add	s8,s8,s7
 188:	000c0023          	sb	zero,0(s8)
  return buf;
}
 18c:	855e                	mv	a0,s7
 18e:	60e6                	ld	ra,88(sp)
 190:	6446                	ld	s0,80(sp)
 192:	64a6                	ld	s1,72(sp)
 194:	6906                	ld	s2,64(sp)
 196:	79e2                	ld	s3,56(sp)
 198:	7a42                	ld	s4,48(sp)
 19a:	7aa2                	ld	s5,40(sp)
 19c:	7b02                	ld	s6,32(sp)
 19e:	6be2                	ld	s7,24(sp)
 1a0:	6c42                	ld	s8,16(sp)
 1a2:	6125                	addi	sp,sp,96
 1a4:	8082                	ret

00000000000001a6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a6:	1101                	addi	sp,sp,-32
 1a8:	ec06                	sd	ra,24(sp)
 1aa:	e822                	sd	s0,16(sp)
 1ac:	e04a                	sd	s2,0(sp)
 1ae:	1000                	addi	s0,sp,32
 1b0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b2:	4581                	li	a1,0
 1b4:	00000097          	auipc	ra,0x0
 1b8:	17c080e7          	jalr	380(ra) # 330 <open>
  if(fd < 0)
 1bc:	02054663          	bltz	a0,1e8 <stat+0x42>
 1c0:	e426                	sd	s1,8(sp)
 1c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c4:	85ca                	mv	a1,s2
 1c6:	00000097          	auipc	ra,0x0
 1ca:	182080e7          	jalr	386(ra) # 348 <fstat>
 1ce:	892a                	mv	s2,a0
  close(fd);
 1d0:	8526                	mv	a0,s1
 1d2:	00000097          	auipc	ra,0x0
 1d6:	146080e7          	jalr	326(ra) # 318 <close>
  return r;
 1da:	64a2                	ld	s1,8(sp)
}
 1dc:	854a                	mv	a0,s2
 1de:	60e2                	ld	ra,24(sp)
 1e0:	6442                	ld	s0,16(sp)
 1e2:	6902                	ld	s2,0(sp)
 1e4:	6105                	addi	sp,sp,32
 1e6:	8082                	ret
    return -1;
 1e8:	57fd                	li	a5,-1
 1ea:	893e                	mv	s2,a5
 1ec:	bfc5                	j	1dc <stat+0x36>

00000000000001ee <atoi>:

int
atoi(const char *s)
{
 1ee:	1141                	addi	sp,sp,-16
 1f0:	e406                	sd	ra,8(sp)
 1f2:	e022                	sd	s0,0(sp)
 1f4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f6:	00054683          	lbu	a3,0(a0)
 1fa:	fd06879b          	addiw	a5,a3,-48
 1fe:	0ff7f793          	zext.b	a5,a5
 202:	4625                	li	a2,9
 204:	02f66963          	bltu	a2,a5,236 <atoi+0x48>
 208:	872a                	mv	a4,a0
  n = 0;
 20a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 20c:	0705                	addi	a4,a4,1
 20e:	0025179b          	slliw	a5,a0,0x2
 212:	9fa9                	addw	a5,a5,a0
 214:	0017979b          	slliw	a5,a5,0x1
 218:	9fb5                	addw	a5,a5,a3
 21a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 21e:	00074683          	lbu	a3,0(a4)
 222:	fd06879b          	addiw	a5,a3,-48
 226:	0ff7f793          	zext.b	a5,a5
 22a:	fef671e3          	bgeu	a2,a5,20c <atoi+0x1e>
  return n;
}
 22e:	60a2                	ld	ra,8(sp)
 230:	6402                	ld	s0,0(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret
  n = 0;
 236:	4501                	li	a0,0
 238:	bfdd                	j	22e <atoi+0x40>

000000000000023a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 23a:	1141                	addi	sp,sp,-16
 23c:	e406                	sd	ra,8(sp)
 23e:	e022                	sd	s0,0(sp)
 240:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 242:	02b57563          	bgeu	a0,a1,26c <memmove+0x32>
    while(n-- > 0)
 246:	00c05f63          	blez	a2,264 <memmove+0x2a>
 24a:	1602                	slli	a2,a2,0x20
 24c:	9201                	srli	a2,a2,0x20
 24e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 252:	872a                	mv	a4,a0
      *dst++ = *src++;
 254:	0585                	addi	a1,a1,1
 256:	0705                	addi	a4,a4,1
 258:	fff5c683          	lbu	a3,-1(a1)
 25c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 260:	fee79ae3          	bne	a5,a4,254 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 264:	60a2                	ld	ra,8(sp)
 266:	6402                	ld	s0,0(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret
    while(n-- > 0)
 26c:	fec05ce3          	blez	a2,264 <memmove+0x2a>
    dst += n;
 270:	00c50733          	add	a4,a0,a2
    src += n;
 274:	95b2                	add	a1,a1,a2
 276:	fff6079b          	addiw	a5,a2,-1
 27a:	1782                	slli	a5,a5,0x20
 27c:	9381                	srli	a5,a5,0x20
 27e:	fff7c793          	not	a5,a5
 282:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 284:	15fd                	addi	a1,a1,-1
 286:	177d                	addi	a4,a4,-1
 288:	0005c683          	lbu	a3,0(a1)
 28c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 290:	fef71ae3          	bne	a4,a5,284 <memmove+0x4a>
 294:	bfc1                	j	264 <memmove+0x2a>

0000000000000296 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 296:	1141                	addi	sp,sp,-16
 298:	e406                	sd	ra,8(sp)
 29a:	e022                	sd	s0,0(sp)
 29c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 29e:	c61d                	beqz	a2,2cc <memcmp+0x36>
 2a0:	1602                	slli	a2,a2,0x20
 2a2:	9201                	srli	a2,a2,0x20
 2a4:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2a8:	00054783          	lbu	a5,0(a0)
 2ac:	0005c703          	lbu	a4,0(a1)
 2b0:	00e79863          	bne	a5,a4,2c0 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 2b4:	0505                	addi	a0,a0,1
    p2++;
 2b6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b8:	fed518e3          	bne	a0,a3,2a8 <memcmp+0x12>
  }
  return 0;
 2bc:	4501                	li	a0,0
 2be:	a019                	j	2c4 <memcmp+0x2e>
      return *p1 - *p2;
 2c0:	40e7853b          	subw	a0,a5,a4
}
 2c4:	60a2                	ld	ra,8(sp)
 2c6:	6402                	ld	s0,0(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  return 0;
 2cc:	4501                	li	a0,0
 2ce:	bfdd                	j	2c4 <memcmp+0x2e>

00000000000002d0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d8:	00000097          	auipc	ra,0x0
 2dc:	f62080e7          	jalr	-158(ra) # 23a <memmove>
}
 2e0:	60a2                	ld	ra,8(sp)
 2e2:	6402                	ld	s0,0(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret

00000000000002e8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2e8:	4885                	li	a7,1
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2f0:	4889                	li	a7,2
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2f8:	488d                	li	a7,3
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 300:	4891                	li	a7,4
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <read>:
.global read
read:
 li a7, SYS_read
 308:	4895                	li	a7,5
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <write>:
.global write
write:
 li a7, SYS_write
 310:	48c1                	li	a7,16
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <close>:
.global close
close:
 li a7, SYS_close
 318:	48d5                	li	a7,21
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <kill>:
.global kill
kill:
 li a7, SYS_kill
 320:	4899                	li	a7,6
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <exec>:
.global exec
exec:
 li a7, SYS_exec
 328:	489d                	li	a7,7
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <open>:
.global open
open:
 li a7, SYS_open
 330:	48bd                	li	a7,15
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 338:	48c5                	li	a7,17
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 340:	48c9                	li	a7,18
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 348:	48a1                	li	a7,8
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <link>:
.global link
link:
 li a7, SYS_link
 350:	48cd                	li	a7,19
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 358:	48d1                	li	a7,20
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 360:	48a5                	li	a7,9
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <dup>:
.global dup
dup:
 li a7, SYS_dup
 368:	48a9                	li	a7,10
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 370:	48ad                	li	a7,11
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 378:	48b1                	li	a7,12
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 380:	48b5                	li	a7,13
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 388:	48b9                	li	a7,14
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 390:	1101                	addi	sp,sp,-32
 392:	ec06                	sd	ra,24(sp)
 394:	e822                	sd	s0,16(sp)
 396:	1000                	addi	s0,sp,32
 398:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 39c:	4605                	li	a2,1
 39e:	fef40593          	addi	a1,s0,-17
 3a2:	00000097          	auipc	ra,0x0
 3a6:	f6e080e7          	jalr	-146(ra) # 310 <write>
}
 3aa:	60e2                	ld	ra,24(sp)
 3ac:	6442                	ld	s0,16(sp)
 3ae:	6105                	addi	sp,sp,32
 3b0:	8082                	ret

00000000000003b2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b2:	7139                	addi	sp,sp,-64
 3b4:	fc06                	sd	ra,56(sp)
 3b6:	f822                	sd	s0,48(sp)
 3b8:	f04a                	sd	s2,32(sp)
 3ba:	ec4e                	sd	s3,24(sp)
 3bc:	0080                	addi	s0,sp,64
 3be:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3c0:	cad9                	beqz	a3,456 <printint+0xa4>
 3c2:	01f5d79b          	srliw	a5,a1,0x1f
 3c6:	cbc1                	beqz	a5,456 <printint+0xa4>
    neg = 1;
    x = -xx;
 3c8:	40b005bb          	negw	a1,a1
    neg = 1;
 3cc:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3ce:	fc040993          	addi	s3,s0,-64
  neg = 0;
 3d2:	86ce                	mv	a3,s3
  i = 0;
 3d4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3d6:	00000817          	auipc	a6,0x0
 3da:	4ca80813          	addi	a6,a6,1226 # 8a0 <digits>
 3de:	88ba                	mv	a7,a4
 3e0:	0017051b          	addiw	a0,a4,1
 3e4:	872a                	mv	a4,a0
 3e6:	02c5f7bb          	remuw	a5,a1,a2
 3ea:	1782                	slli	a5,a5,0x20
 3ec:	9381                	srli	a5,a5,0x20
 3ee:	97c2                	add	a5,a5,a6
 3f0:	0007c783          	lbu	a5,0(a5)
 3f4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3f8:	87ae                	mv	a5,a1
 3fa:	02c5d5bb          	divuw	a1,a1,a2
 3fe:	0685                	addi	a3,a3,1
 400:	fcc7ffe3          	bgeu	a5,a2,3de <printint+0x2c>
  if(neg)
 404:	00030c63          	beqz	t1,41c <printint+0x6a>
    buf[i++] = '-';
 408:	fd050793          	addi	a5,a0,-48
 40c:	00878533          	add	a0,a5,s0
 410:	02d00793          	li	a5,45
 414:	fef50823          	sb	a5,-16(a0)
 418:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 41c:	02e05763          	blez	a4,44a <printint+0x98>
 420:	f426                	sd	s1,40(sp)
 422:	377d                	addiw	a4,a4,-1
 424:	00e984b3          	add	s1,s3,a4
 428:	19fd                	addi	s3,s3,-1
 42a:	99ba                	add	s3,s3,a4
 42c:	1702                	slli	a4,a4,0x20
 42e:	9301                	srli	a4,a4,0x20
 430:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 434:	0004c583          	lbu	a1,0(s1)
 438:	854a                	mv	a0,s2
 43a:	00000097          	auipc	ra,0x0
 43e:	f56080e7          	jalr	-170(ra) # 390 <putc>
  while(--i >= 0)
 442:	14fd                	addi	s1,s1,-1
 444:	ff3498e3          	bne	s1,s3,434 <printint+0x82>
 448:	74a2                	ld	s1,40(sp)
}
 44a:	70e2                	ld	ra,56(sp)
 44c:	7442                	ld	s0,48(sp)
 44e:	7902                	ld	s2,32(sp)
 450:	69e2                	ld	s3,24(sp)
 452:	6121                	addi	sp,sp,64
 454:	8082                	ret
  neg = 0;
 456:	4301                	li	t1,0
 458:	bf9d                	j	3ce <printint+0x1c>

000000000000045a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 45a:	715d                	addi	sp,sp,-80
 45c:	e486                	sd	ra,72(sp)
 45e:	e0a2                	sd	s0,64(sp)
 460:	f84a                	sd	s2,48(sp)
 462:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 464:	0005c903          	lbu	s2,0(a1)
 468:	1a090b63          	beqz	s2,61e <vprintf+0x1c4>
 46c:	fc26                	sd	s1,56(sp)
 46e:	f44e                	sd	s3,40(sp)
 470:	f052                	sd	s4,32(sp)
 472:	ec56                	sd	s5,24(sp)
 474:	e85a                	sd	s6,16(sp)
 476:	e45e                	sd	s7,8(sp)
 478:	8aaa                	mv	s5,a0
 47a:	8bb2                	mv	s7,a2
 47c:	00158493          	addi	s1,a1,1
  state = 0;
 480:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 482:	02500a13          	li	s4,37
 486:	4b55                	li	s6,21
 488:	a839                	j	4a6 <vprintf+0x4c>
        putc(fd, c);
 48a:	85ca                	mv	a1,s2
 48c:	8556                	mv	a0,s5
 48e:	00000097          	auipc	ra,0x0
 492:	f02080e7          	jalr	-254(ra) # 390 <putc>
 496:	a019                	j	49c <vprintf+0x42>
    } else if(state == '%'){
 498:	01498d63          	beq	s3,s4,4b2 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 49c:	0485                	addi	s1,s1,1
 49e:	fff4c903          	lbu	s2,-1(s1)
 4a2:	16090863          	beqz	s2,612 <vprintf+0x1b8>
    if(state == 0){
 4a6:	fe0999e3          	bnez	s3,498 <vprintf+0x3e>
      if(c == '%'){
 4aa:	ff4910e3          	bne	s2,s4,48a <vprintf+0x30>
        state = '%';
 4ae:	89d2                	mv	s3,s4
 4b0:	b7f5                	j	49c <vprintf+0x42>
      if(c == 'd'){
 4b2:	13490563          	beq	s2,s4,5dc <vprintf+0x182>
 4b6:	f9d9079b          	addiw	a5,s2,-99
 4ba:	0ff7f793          	zext.b	a5,a5
 4be:	12fb6863          	bltu	s6,a5,5ee <vprintf+0x194>
 4c2:	f9d9079b          	addiw	a5,s2,-99
 4c6:	0ff7f713          	zext.b	a4,a5
 4ca:	12eb6263          	bltu	s6,a4,5ee <vprintf+0x194>
 4ce:	00271793          	slli	a5,a4,0x2
 4d2:	00000717          	auipc	a4,0x0
 4d6:	37670713          	addi	a4,a4,886 # 848 <malloc+0x136>
 4da:	97ba                	add	a5,a5,a4
 4dc:	439c                	lw	a5,0(a5)
 4de:	97ba                	add	a5,a5,a4
 4e0:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4e2:	008b8913          	addi	s2,s7,8
 4e6:	4685                	li	a3,1
 4e8:	4629                	li	a2,10
 4ea:	000ba583          	lw	a1,0(s7)
 4ee:	8556                	mv	a0,s5
 4f0:	00000097          	auipc	ra,0x0
 4f4:	ec2080e7          	jalr	-318(ra) # 3b2 <printint>
 4f8:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4fa:	4981                	li	s3,0
 4fc:	b745                	j	49c <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4fe:	008b8913          	addi	s2,s7,8
 502:	4681                	li	a3,0
 504:	4629                	li	a2,10
 506:	000ba583          	lw	a1,0(s7)
 50a:	8556                	mv	a0,s5
 50c:	00000097          	auipc	ra,0x0
 510:	ea6080e7          	jalr	-346(ra) # 3b2 <printint>
 514:	8bca                	mv	s7,s2
      state = 0;
 516:	4981                	li	s3,0
 518:	b751                	j	49c <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 51a:	008b8913          	addi	s2,s7,8
 51e:	4681                	li	a3,0
 520:	4641                	li	a2,16
 522:	000ba583          	lw	a1,0(s7)
 526:	8556                	mv	a0,s5
 528:	00000097          	auipc	ra,0x0
 52c:	e8a080e7          	jalr	-374(ra) # 3b2 <printint>
 530:	8bca                	mv	s7,s2
      state = 0;
 532:	4981                	li	s3,0
 534:	b7a5                	j	49c <vprintf+0x42>
 536:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 538:	008b8793          	addi	a5,s7,8
 53c:	8c3e                	mv	s8,a5
 53e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 542:	03000593          	li	a1,48
 546:	8556                	mv	a0,s5
 548:	00000097          	auipc	ra,0x0
 54c:	e48080e7          	jalr	-440(ra) # 390 <putc>
  putc(fd, 'x');
 550:	07800593          	li	a1,120
 554:	8556                	mv	a0,s5
 556:	00000097          	auipc	ra,0x0
 55a:	e3a080e7          	jalr	-454(ra) # 390 <putc>
 55e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 560:	00000b97          	auipc	s7,0x0
 564:	340b8b93          	addi	s7,s7,832 # 8a0 <digits>
 568:	03c9d793          	srli	a5,s3,0x3c
 56c:	97de                	add	a5,a5,s7
 56e:	0007c583          	lbu	a1,0(a5)
 572:	8556                	mv	a0,s5
 574:	00000097          	auipc	ra,0x0
 578:	e1c080e7          	jalr	-484(ra) # 390 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 57c:	0992                	slli	s3,s3,0x4
 57e:	397d                	addiw	s2,s2,-1
 580:	fe0914e3          	bnez	s2,568 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 584:	8be2                	mv	s7,s8
      state = 0;
 586:	4981                	li	s3,0
 588:	6c02                	ld	s8,0(sp)
 58a:	bf09                	j	49c <vprintf+0x42>
        s = va_arg(ap, char*);
 58c:	008b8993          	addi	s3,s7,8
 590:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 594:	02090163          	beqz	s2,5b6 <vprintf+0x15c>
        while(*s != 0){
 598:	00094583          	lbu	a1,0(s2)
 59c:	c9a5                	beqz	a1,60c <vprintf+0x1b2>
          putc(fd, *s);
 59e:	8556                	mv	a0,s5
 5a0:	00000097          	auipc	ra,0x0
 5a4:	df0080e7          	jalr	-528(ra) # 390 <putc>
          s++;
 5a8:	0905                	addi	s2,s2,1
        while(*s != 0){
 5aa:	00094583          	lbu	a1,0(s2)
 5ae:	f9e5                	bnez	a1,59e <vprintf+0x144>
        s = va_arg(ap, char*);
 5b0:	8bce                	mv	s7,s3
      state = 0;
 5b2:	4981                	li	s3,0
 5b4:	b5e5                	j	49c <vprintf+0x42>
          s = "(null)";
 5b6:	00000917          	auipc	s2,0x0
 5ba:	28a90913          	addi	s2,s2,650 # 840 <malloc+0x12e>
        while(*s != 0){
 5be:	02800593          	li	a1,40
 5c2:	bff1                	j	59e <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 5c4:	008b8913          	addi	s2,s7,8
 5c8:	000bc583          	lbu	a1,0(s7)
 5cc:	8556                	mv	a0,s5
 5ce:	00000097          	auipc	ra,0x0
 5d2:	dc2080e7          	jalr	-574(ra) # 390 <putc>
 5d6:	8bca                	mv	s7,s2
      state = 0;
 5d8:	4981                	li	s3,0
 5da:	b5c9                	j	49c <vprintf+0x42>
        putc(fd, c);
 5dc:	02500593          	li	a1,37
 5e0:	8556                	mv	a0,s5
 5e2:	00000097          	auipc	ra,0x0
 5e6:	dae080e7          	jalr	-594(ra) # 390 <putc>
      state = 0;
 5ea:	4981                	li	s3,0
 5ec:	bd45                	j	49c <vprintf+0x42>
        putc(fd, '%');
 5ee:	02500593          	li	a1,37
 5f2:	8556                	mv	a0,s5
 5f4:	00000097          	auipc	ra,0x0
 5f8:	d9c080e7          	jalr	-612(ra) # 390 <putc>
        putc(fd, c);
 5fc:	85ca                	mv	a1,s2
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	d90080e7          	jalr	-624(ra) # 390 <putc>
      state = 0;
 608:	4981                	li	s3,0
 60a:	bd49                	j	49c <vprintf+0x42>
        s = va_arg(ap, char*);
 60c:	8bce                	mv	s7,s3
      state = 0;
 60e:	4981                	li	s3,0
 610:	b571                	j	49c <vprintf+0x42>
 612:	74e2                	ld	s1,56(sp)
 614:	79a2                	ld	s3,40(sp)
 616:	7a02                	ld	s4,32(sp)
 618:	6ae2                	ld	s5,24(sp)
 61a:	6b42                	ld	s6,16(sp)
 61c:	6ba2                	ld	s7,8(sp)
    }
  }
}
 61e:	60a6                	ld	ra,72(sp)
 620:	6406                	ld	s0,64(sp)
 622:	7942                	ld	s2,48(sp)
 624:	6161                	addi	sp,sp,80
 626:	8082                	ret

0000000000000628 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 628:	715d                	addi	sp,sp,-80
 62a:	ec06                	sd	ra,24(sp)
 62c:	e822                	sd	s0,16(sp)
 62e:	1000                	addi	s0,sp,32
 630:	e010                	sd	a2,0(s0)
 632:	e414                	sd	a3,8(s0)
 634:	e818                	sd	a4,16(s0)
 636:	ec1c                	sd	a5,24(s0)
 638:	03043023          	sd	a6,32(s0)
 63c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 640:	8622                	mv	a2,s0
 642:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 646:	00000097          	auipc	ra,0x0
 64a:	e14080e7          	jalr	-492(ra) # 45a <vprintf>
}
 64e:	60e2                	ld	ra,24(sp)
 650:	6442                	ld	s0,16(sp)
 652:	6161                	addi	sp,sp,80
 654:	8082                	ret

0000000000000656 <printf>:

void
printf(const char *fmt, ...)
{
 656:	711d                	addi	sp,sp,-96
 658:	ec06                	sd	ra,24(sp)
 65a:	e822                	sd	s0,16(sp)
 65c:	1000                	addi	s0,sp,32
 65e:	e40c                	sd	a1,8(s0)
 660:	e810                	sd	a2,16(s0)
 662:	ec14                	sd	a3,24(s0)
 664:	f018                	sd	a4,32(s0)
 666:	f41c                	sd	a5,40(s0)
 668:	03043823          	sd	a6,48(s0)
 66c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 670:	00840613          	addi	a2,s0,8
 674:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 678:	85aa                	mv	a1,a0
 67a:	4505                	li	a0,1
 67c:	00000097          	auipc	ra,0x0
 680:	dde080e7          	jalr	-546(ra) # 45a <vprintf>
}
 684:	60e2                	ld	ra,24(sp)
 686:	6442                	ld	s0,16(sp)
 688:	6125                	addi	sp,sp,96
 68a:	8082                	ret

000000000000068c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 68c:	1141                	addi	sp,sp,-16
 68e:	e406                	sd	ra,8(sp)
 690:	e022                	sd	s0,0(sp)
 692:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 694:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 698:	00000797          	auipc	a5,0x0
 69c:	6087b783          	ld	a5,1544(a5) # ca0 <freep>
 6a0:	a039                	j	6ae <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a2:	6398                	ld	a4,0(a5)
 6a4:	00e7e463          	bltu	a5,a4,6ac <free+0x20>
 6a8:	00e6ea63          	bltu	a3,a4,6bc <free+0x30>
{
 6ac:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ae:	fed7fae3          	bgeu	a5,a3,6a2 <free+0x16>
 6b2:	6398                	ld	a4,0(a5)
 6b4:	00e6e463          	bltu	a3,a4,6bc <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b8:	fee7eae3          	bltu	a5,a4,6ac <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6bc:	ff852583          	lw	a1,-8(a0)
 6c0:	6390                	ld	a2,0(a5)
 6c2:	02059813          	slli	a6,a1,0x20
 6c6:	01c85713          	srli	a4,a6,0x1c
 6ca:	9736                	add	a4,a4,a3
 6cc:	02e60563          	beq	a2,a4,6f6 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6d0:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6d4:	4790                	lw	a2,8(a5)
 6d6:	02061593          	slli	a1,a2,0x20
 6da:	01c5d713          	srli	a4,a1,0x1c
 6de:	973e                	add	a4,a4,a5
 6e0:	02e68263          	beq	a3,a4,704 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6e4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 6e6:	00000717          	auipc	a4,0x0
 6ea:	5af73d23          	sd	a5,1466(a4) # ca0 <freep>
}
 6ee:	60a2                	ld	ra,8(sp)
 6f0:	6402                	ld	s0,0(sp)
 6f2:	0141                	addi	sp,sp,16
 6f4:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 6f6:	4618                	lw	a4,8(a2)
 6f8:	9f2d                	addw	a4,a4,a1
 6fa:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6fe:	6398                	ld	a4,0(a5)
 700:	6310                	ld	a2,0(a4)
 702:	b7f9                	j	6d0 <free+0x44>
    p->s.size += bp->s.size;
 704:	ff852703          	lw	a4,-8(a0)
 708:	9f31                	addw	a4,a4,a2
 70a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 70c:	ff053683          	ld	a3,-16(a0)
 710:	bfd1                	j	6e4 <free+0x58>

0000000000000712 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 712:	7139                	addi	sp,sp,-64
 714:	fc06                	sd	ra,56(sp)
 716:	f822                	sd	s0,48(sp)
 718:	f04a                	sd	s2,32(sp)
 71a:	ec4e                	sd	s3,24(sp)
 71c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 71e:	02051993          	slli	s3,a0,0x20
 722:	0209d993          	srli	s3,s3,0x20
 726:	09bd                	addi	s3,s3,15
 728:	0049d993          	srli	s3,s3,0x4
 72c:	2985                	addiw	s3,s3,1
 72e:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 730:	00000517          	auipc	a0,0x0
 734:	57053503          	ld	a0,1392(a0) # ca0 <freep>
 738:	c905                	beqz	a0,768 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 73a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 73c:	4798                	lw	a4,8(a5)
 73e:	09377a63          	bgeu	a4,s3,7d2 <malloc+0xc0>
 742:	f426                	sd	s1,40(sp)
 744:	e852                	sd	s4,16(sp)
 746:	e456                	sd	s5,8(sp)
 748:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 74a:	8a4e                	mv	s4,s3
 74c:	6705                	lui	a4,0x1
 74e:	00e9f363          	bgeu	s3,a4,754 <malloc+0x42>
 752:	6a05                	lui	s4,0x1
 754:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 758:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 75c:	00000497          	auipc	s1,0x0
 760:	54448493          	addi	s1,s1,1348 # ca0 <freep>
  if(p == (char*)-1)
 764:	5afd                	li	s5,-1
 766:	a089                	j	7a8 <malloc+0x96>
 768:	f426                	sd	s1,40(sp)
 76a:	e852                	sd	s4,16(sp)
 76c:	e456                	sd	s5,8(sp)
 76e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 770:	00000797          	auipc	a5,0x0
 774:	53878793          	addi	a5,a5,1336 # ca8 <base>
 778:	00000717          	auipc	a4,0x0
 77c:	52f73423          	sd	a5,1320(a4) # ca0 <freep>
 780:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 782:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 786:	b7d1                	j	74a <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 788:	6398                	ld	a4,0(a5)
 78a:	e118                	sd	a4,0(a0)
 78c:	a8b9                	j	7ea <malloc+0xd8>
  hp->s.size = nu;
 78e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 792:	0541                	addi	a0,a0,16
 794:	00000097          	auipc	ra,0x0
 798:	ef8080e7          	jalr	-264(ra) # 68c <free>
  return freep;
 79c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 79e:	c135                	beqz	a0,802 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7a2:	4798                	lw	a4,8(a5)
 7a4:	03277363          	bgeu	a4,s2,7ca <malloc+0xb8>
    if(p == freep)
 7a8:	6098                	ld	a4,0(s1)
 7aa:	853e                	mv	a0,a5
 7ac:	fef71ae3          	bne	a4,a5,7a0 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7b0:	8552                	mv	a0,s4
 7b2:	00000097          	auipc	ra,0x0
 7b6:	bc6080e7          	jalr	-1082(ra) # 378 <sbrk>
  if(p == (char*)-1)
 7ba:	fd551ae3          	bne	a0,s5,78e <malloc+0x7c>
        return 0;
 7be:	4501                	li	a0,0
 7c0:	74a2                	ld	s1,40(sp)
 7c2:	6a42                	ld	s4,16(sp)
 7c4:	6aa2                	ld	s5,8(sp)
 7c6:	6b02                	ld	s6,0(sp)
 7c8:	a03d                	j	7f6 <malloc+0xe4>
 7ca:	74a2                	ld	s1,40(sp)
 7cc:	6a42                	ld	s4,16(sp)
 7ce:	6aa2                	ld	s5,8(sp)
 7d0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7d2:	fae90be3          	beq	s2,a4,788 <malloc+0x76>
        p->s.size -= nunits;
 7d6:	4137073b          	subw	a4,a4,s3
 7da:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7dc:	02071693          	slli	a3,a4,0x20
 7e0:	01c6d713          	srli	a4,a3,0x1c
 7e4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7e6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7ea:	00000717          	auipc	a4,0x0
 7ee:	4aa73b23          	sd	a0,1206(a4) # ca0 <freep>
      return (void*)(p + 1);
 7f2:	01078513          	addi	a0,a5,16
  }
}
 7f6:	70e2                	ld	ra,56(sp)
 7f8:	7442                	ld	s0,48(sp)
 7fa:	7902                	ld	s2,32(sp)
 7fc:	69e2                	ld	s3,24(sp)
 7fe:	6121                	addi	sp,sp,64
 800:	8082                	ret
 802:	74a2                	ld	s1,40(sp)
 804:	6a42                	ld	s4,16(sp)
 806:	6aa2                	ld	s5,8(sp)
 808:	6b02                	ld	s6,0(sp)
 80a:	b7f5                	j	7f6 <malloc+0xe4>
