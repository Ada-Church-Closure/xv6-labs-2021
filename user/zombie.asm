
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	2a8080e7          	jalr	680(ra) # 2b0 <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	2a2080e7          	jalr	674(ra) # 2b8 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	328080e7          	jalr	808(ra) # 348 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  2a:	1141                	addi	sp,sp,-16
  2c:	e406                	sd	ra,8(sp)
  2e:	e022                	sd	s0,0(sp)
  30:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  32:	87aa                	mv	a5,a0
  34:	0585                	addi	a1,a1,1
  36:	0785                	addi	a5,a5,1
  38:	fff5c703          	lbu	a4,-1(a1)
  3c:	fee78fa3          	sb	a4,-1(a5)
  40:	fb75                	bnez	a4,34 <strcpy+0xa>
    ;
  return os;
}
  42:	60a2                	ld	ra,8(sp)
  44:	6402                	ld	s0,0(sp)
  46:	0141                	addi	sp,sp,16
  48:	8082                	ret

000000000000004a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e406                	sd	ra,8(sp)
  4e:	e022                	sd	s0,0(sp)
  50:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  52:	00054783          	lbu	a5,0(a0)
  56:	cb91                	beqz	a5,6a <strcmp+0x20>
  58:	0005c703          	lbu	a4,0(a1)
  5c:	00f71763          	bne	a4,a5,6a <strcmp+0x20>
    p++, q++;
  60:	0505                	addi	a0,a0,1
  62:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  64:	00054783          	lbu	a5,0(a0)
  68:	fbe5                	bnez	a5,58 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  6a:	0005c503          	lbu	a0,0(a1)
}
  6e:	40a7853b          	subw	a0,a5,a0
  72:	60a2                	ld	ra,8(sp)
  74:	6402                	ld	s0,0(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strlen>:

uint
strlen(const char *s)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  82:	00054783          	lbu	a5,0(a0)
  86:	cf91                	beqz	a5,a2 <strlen+0x28>
  88:	00150793          	addi	a5,a0,1
  8c:	86be                	mv	a3,a5
  8e:	0785                	addi	a5,a5,1
  90:	fff7c703          	lbu	a4,-1(a5)
  94:	ff65                	bnez	a4,8c <strlen+0x12>
  96:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  9a:	60a2                	ld	ra,8(sp)
  9c:	6402                	ld	s0,0(sp)
  9e:	0141                	addi	sp,sp,16
  a0:	8082                	ret
  for(n = 0; s[n]; n++)
  a2:	4501                	li	a0,0
  a4:	bfdd                	j	9a <strlen+0x20>

00000000000000a6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a6:	1141                	addi	sp,sp,-16
  a8:	e406                	sd	ra,8(sp)
  aa:	e022                	sd	s0,0(sp)
  ac:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ae:	ca19                	beqz	a2,c4 <memset+0x1e>
  b0:	87aa                	mv	a5,a0
  b2:	1602                	slli	a2,a2,0x20
  b4:	9201                	srli	a2,a2,0x20
  b6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  ba:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  be:	0785                	addi	a5,a5,1
  c0:	fee79de3          	bne	a5,a4,ba <memset+0x14>
  }
  return dst;
}
  c4:	60a2                	ld	ra,8(sp)
  c6:	6402                	ld	s0,0(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret

00000000000000cc <strchr>:

char*
strchr(const char *s, char c)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e406                	sd	ra,8(sp)
  d0:	e022                	sd	s0,0(sp)
  d2:	0800                	addi	s0,sp,16
  for(; *s; s++)
  d4:	00054783          	lbu	a5,0(a0)
  d8:	cf81                	beqz	a5,f0 <strchr+0x24>
    if(*s == c)
  da:	00f58763          	beq	a1,a5,e8 <strchr+0x1c>
  for(; *s; s++)
  de:	0505                	addi	a0,a0,1
  e0:	00054783          	lbu	a5,0(a0)
  e4:	fbfd                	bnez	a5,da <strchr+0xe>
      return (char*)s;
  return 0;
  e6:	4501                	li	a0,0
}
  e8:	60a2                	ld	ra,8(sp)
  ea:	6402                	ld	s0,0(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret
  return 0;
  f0:	4501                	li	a0,0
  f2:	bfdd                	j	e8 <strchr+0x1c>

00000000000000f4 <gets>:

char*
gets(char *buf, int max)
{
  f4:	711d                	addi	sp,sp,-96
  f6:	ec86                	sd	ra,88(sp)
  f8:	e8a2                	sd	s0,80(sp)
  fa:	e4a6                	sd	s1,72(sp)
  fc:	e0ca                	sd	s2,64(sp)
  fe:	fc4e                	sd	s3,56(sp)
 100:	f852                	sd	s4,48(sp)
 102:	f456                	sd	s5,40(sp)
 104:	f05a                	sd	s6,32(sp)
 106:	ec5e                	sd	s7,24(sp)
 108:	e862                	sd	s8,16(sp)
 10a:	1080                	addi	s0,sp,96
 10c:	8baa                	mv	s7,a0
 10e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 110:	892a                	mv	s2,a0
 112:	4481                	li	s1,0
    cc = read(0, &c, 1);
 114:	faf40b13          	addi	s6,s0,-81
 118:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 11a:	8c26                	mv	s8,s1
 11c:	0014899b          	addiw	s3,s1,1
 120:	84ce                	mv	s1,s3
 122:	0349d663          	bge	s3,s4,14e <gets+0x5a>
    cc = read(0, &c, 1);
 126:	8656                	mv	a2,s5
 128:	85da                	mv	a1,s6
 12a:	4501                	li	a0,0
 12c:	00000097          	auipc	ra,0x0
 130:	1a4080e7          	jalr	420(ra) # 2d0 <read>
    if(cc < 1)
 134:	00a05d63          	blez	a0,14e <gets+0x5a>
      break;
    buf[i++] = c;
 138:	faf44783          	lbu	a5,-81(s0)
 13c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 140:	0905                	addi	s2,s2,1
 142:	ff678713          	addi	a4,a5,-10
 146:	c319                	beqz	a4,14c <gets+0x58>
 148:	17cd                	addi	a5,a5,-13
 14a:	fbe1                	bnez	a5,11a <gets+0x26>
    buf[i++] = c;
 14c:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 14e:	9c5e                	add	s8,s8,s7
 150:	000c0023          	sb	zero,0(s8)
  return buf;
}
 154:	855e                	mv	a0,s7
 156:	60e6                	ld	ra,88(sp)
 158:	6446                	ld	s0,80(sp)
 15a:	64a6                	ld	s1,72(sp)
 15c:	6906                	ld	s2,64(sp)
 15e:	79e2                	ld	s3,56(sp)
 160:	7a42                	ld	s4,48(sp)
 162:	7aa2                	ld	s5,40(sp)
 164:	7b02                	ld	s6,32(sp)
 166:	6be2                	ld	s7,24(sp)
 168:	6c42                	ld	s8,16(sp)
 16a:	6125                	addi	sp,sp,96
 16c:	8082                	ret

000000000000016e <stat>:

int
stat(const char *n, struct stat *st)
{
 16e:	1101                	addi	sp,sp,-32
 170:	ec06                	sd	ra,24(sp)
 172:	e822                	sd	s0,16(sp)
 174:	e04a                	sd	s2,0(sp)
 176:	1000                	addi	s0,sp,32
 178:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 17a:	4581                	li	a1,0
 17c:	00000097          	auipc	ra,0x0
 180:	17c080e7          	jalr	380(ra) # 2f8 <open>
  if(fd < 0)
 184:	02054663          	bltz	a0,1b0 <stat+0x42>
 188:	e426                	sd	s1,8(sp)
 18a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 18c:	85ca                	mv	a1,s2
 18e:	00000097          	auipc	ra,0x0
 192:	182080e7          	jalr	386(ra) # 310 <fstat>
 196:	892a                	mv	s2,a0
  close(fd);
 198:	8526                	mv	a0,s1
 19a:	00000097          	auipc	ra,0x0
 19e:	146080e7          	jalr	326(ra) # 2e0 <close>
  return r;
 1a2:	64a2                	ld	s1,8(sp)
}
 1a4:	854a                	mv	a0,s2
 1a6:	60e2                	ld	ra,24(sp)
 1a8:	6442                	ld	s0,16(sp)
 1aa:	6902                	ld	s2,0(sp)
 1ac:	6105                	addi	sp,sp,32
 1ae:	8082                	ret
    return -1;
 1b0:	57fd                	li	a5,-1
 1b2:	893e                	mv	s2,a5
 1b4:	bfc5                	j	1a4 <stat+0x36>

00000000000001b6 <atoi>:

int
atoi(const char *s)
{
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e406                	sd	ra,8(sp)
 1ba:	e022                	sd	s0,0(sp)
 1bc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1be:	00054683          	lbu	a3,0(a0)
 1c2:	fd06879b          	addiw	a5,a3,-48
 1c6:	0ff7f793          	zext.b	a5,a5
 1ca:	4625                	li	a2,9
 1cc:	02f66963          	bltu	a2,a5,1fe <atoi+0x48>
 1d0:	872a                	mv	a4,a0
  n = 0;
 1d2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1d4:	0705                	addi	a4,a4,1
 1d6:	0025179b          	slliw	a5,a0,0x2
 1da:	9fa9                	addw	a5,a5,a0
 1dc:	0017979b          	slliw	a5,a5,0x1
 1e0:	9fb5                	addw	a5,a5,a3
 1e2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1e6:	00074683          	lbu	a3,0(a4)
 1ea:	fd06879b          	addiw	a5,a3,-48
 1ee:	0ff7f793          	zext.b	a5,a5
 1f2:	fef671e3          	bgeu	a2,a5,1d4 <atoi+0x1e>
  return n;
}
 1f6:	60a2                	ld	ra,8(sp)
 1f8:	6402                	ld	s0,0(sp)
 1fa:	0141                	addi	sp,sp,16
 1fc:	8082                	ret
  n = 0;
 1fe:	4501                	li	a0,0
 200:	bfdd                	j	1f6 <atoi+0x40>

0000000000000202 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 202:	1141                	addi	sp,sp,-16
 204:	e406                	sd	ra,8(sp)
 206:	e022                	sd	s0,0(sp)
 208:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 20a:	02b57563          	bgeu	a0,a1,234 <memmove+0x32>
    while(n-- > 0)
 20e:	00c05f63          	blez	a2,22c <memmove+0x2a>
 212:	1602                	slli	a2,a2,0x20
 214:	9201                	srli	a2,a2,0x20
 216:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 21a:	872a                	mv	a4,a0
      *dst++ = *src++;
 21c:	0585                	addi	a1,a1,1
 21e:	0705                	addi	a4,a4,1
 220:	fff5c683          	lbu	a3,-1(a1)
 224:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 228:	fee79ae3          	bne	a5,a4,21c <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 22c:	60a2                	ld	ra,8(sp)
 22e:	6402                	ld	s0,0(sp)
 230:	0141                	addi	sp,sp,16
 232:	8082                	ret
    while(n-- > 0)
 234:	fec05ce3          	blez	a2,22c <memmove+0x2a>
    dst += n;
 238:	00c50733          	add	a4,a0,a2
    src += n;
 23c:	95b2                	add	a1,a1,a2
 23e:	fff6079b          	addiw	a5,a2,-1
 242:	1782                	slli	a5,a5,0x20
 244:	9381                	srli	a5,a5,0x20
 246:	fff7c793          	not	a5,a5
 24a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 24c:	15fd                	addi	a1,a1,-1
 24e:	177d                	addi	a4,a4,-1
 250:	0005c683          	lbu	a3,0(a1)
 254:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 258:	fef71ae3          	bne	a4,a5,24c <memmove+0x4a>
 25c:	bfc1                	j	22c <memmove+0x2a>

000000000000025e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e406                	sd	ra,8(sp)
 262:	e022                	sd	s0,0(sp)
 264:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 266:	c61d                	beqz	a2,294 <memcmp+0x36>
 268:	1602                	slli	a2,a2,0x20
 26a:	9201                	srli	a2,a2,0x20
 26c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 270:	00054783          	lbu	a5,0(a0)
 274:	0005c703          	lbu	a4,0(a1)
 278:	00e79863          	bne	a5,a4,288 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 27c:	0505                	addi	a0,a0,1
    p2++;
 27e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 280:	fed518e3          	bne	a0,a3,270 <memcmp+0x12>
  }
  return 0;
 284:	4501                	li	a0,0
 286:	a019                	j	28c <memcmp+0x2e>
      return *p1 - *p2;
 288:	40e7853b          	subw	a0,a5,a4
}
 28c:	60a2                	ld	ra,8(sp)
 28e:	6402                	ld	s0,0(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret
  return 0;
 294:	4501                	li	a0,0
 296:	bfdd                	j	28c <memcmp+0x2e>

0000000000000298 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e406                	sd	ra,8(sp)
 29c:	e022                	sd	s0,0(sp)
 29e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a0:	00000097          	auipc	ra,0x0
 2a4:	f62080e7          	jalr	-158(ra) # 202 <memmove>
}
 2a8:	60a2                	ld	ra,8(sp)
 2aa:	6402                	ld	s0,0(sp)
 2ac:	0141                	addi	sp,sp,16
 2ae:	8082                	ret

00000000000002b0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2b0:	4885                	li	a7,1
 ecall
 2b2:	00000073          	ecall
 ret
 2b6:	8082                	ret

00000000000002b8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2b8:	4889                	li	a7,2
 ecall
 2ba:	00000073          	ecall
 ret
 2be:	8082                	ret

00000000000002c0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 2c0:	488d                	li	a7,3
 ecall
 2c2:	00000073          	ecall
 ret
 2c6:	8082                	ret

00000000000002c8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 2c8:	4891                	li	a7,4
 ecall
 2ca:	00000073          	ecall
 ret
 2ce:	8082                	ret

00000000000002d0 <read>:
.global read
read:
 li a7, SYS_read
 2d0:	4895                	li	a7,5
 ecall
 2d2:	00000073          	ecall
 ret
 2d6:	8082                	ret

00000000000002d8 <write>:
.global write
write:
 li a7, SYS_write
 2d8:	48c1                	li	a7,16
 ecall
 2da:	00000073          	ecall
 ret
 2de:	8082                	ret

00000000000002e0 <close>:
.global close
close:
 li a7, SYS_close
 2e0:	48d5                	li	a7,21
 ecall
 2e2:	00000073          	ecall
 ret
 2e6:	8082                	ret

00000000000002e8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2e8:	4899                	li	a7,6
 ecall
 2ea:	00000073          	ecall
 ret
 2ee:	8082                	ret

00000000000002f0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 2f0:	489d                	li	a7,7
 ecall
 2f2:	00000073          	ecall
 ret
 2f6:	8082                	ret

00000000000002f8 <open>:
.global open
open:
 li a7, SYS_open
 2f8:	48bd                	li	a7,15
 ecall
 2fa:	00000073          	ecall
 ret
 2fe:	8082                	ret

0000000000000300 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 300:	48c5                	li	a7,17
 ecall
 302:	00000073          	ecall
 ret
 306:	8082                	ret

0000000000000308 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 308:	48c9                	li	a7,18
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 310:	48a1                	li	a7,8
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <link>:
.global link
link:
 li a7, SYS_link
 318:	48cd                	li	a7,19
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 320:	48d1                	li	a7,20
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 328:	48a5                	li	a7,9
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <dup>:
.global dup
dup:
 li a7, SYS_dup
 330:	48a9                	li	a7,10
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 338:	48ad                	li	a7,11
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 340:	48b1                	li	a7,12
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 348:	48b5                	li	a7,13
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 350:	48b9                	li	a7,14
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 358:	1101                	addi	sp,sp,-32
 35a:	ec06                	sd	ra,24(sp)
 35c:	e822                	sd	s0,16(sp)
 35e:	1000                	addi	s0,sp,32
 360:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 364:	4605                	li	a2,1
 366:	fef40593          	addi	a1,s0,-17
 36a:	00000097          	auipc	ra,0x0
 36e:	f6e080e7          	jalr	-146(ra) # 2d8 <write>
}
 372:	60e2                	ld	ra,24(sp)
 374:	6442                	ld	s0,16(sp)
 376:	6105                	addi	sp,sp,32
 378:	8082                	ret

000000000000037a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 37a:	7139                	addi	sp,sp,-64
 37c:	fc06                	sd	ra,56(sp)
 37e:	f822                	sd	s0,48(sp)
 380:	f04a                	sd	s2,32(sp)
 382:	ec4e                	sd	s3,24(sp)
 384:	0080                	addi	s0,sp,64
 386:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 388:	cad9                	beqz	a3,41e <printint+0xa4>
 38a:	01f5d79b          	srliw	a5,a1,0x1f
 38e:	cbc1                	beqz	a5,41e <printint+0xa4>
    neg = 1;
    x = -xx;
 390:	40b005bb          	negw	a1,a1
    neg = 1;
 394:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 396:	fc040993          	addi	s3,s0,-64
  neg = 0;
 39a:	86ce                	mv	a3,s3
  i = 0;
 39c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 39e:	00000817          	auipc	a6,0x0
 3a2:	49a80813          	addi	a6,a6,1178 # 838 <digits>
 3a6:	88ba                	mv	a7,a4
 3a8:	0017051b          	addiw	a0,a4,1
 3ac:	872a                	mv	a4,a0
 3ae:	02c5f7bb          	remuw	a5,a1,a2
 3b2:	1782                	slli	a5,a5,0x20
 3b4:	9381                	srli	a5,a5,0x20
 3b6:	97c2                	add	a5,a5,a6
 3b8:	0007c783          	lbu	a5,0(a5)
 3bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3c0:	87ae                	mv	a5,a1
 3c2:	02c5d5bb          	divuw	a1,a1,a2
 3c6:	0685                	addi	a3,a3,1
 3c8:	fcc7ffe3          	bgeu	a5,a2,3a6 <printint+0x2c>
  if(neg)
 3cc:	00030c63          	beqz	t1,3e4 <printint+0x6a>
    buf[i++] = '-';
 3d0:	fd050793          	addi	a5,a0,-48
 3d4:	00878533          	add	a0,a5,s0
 3d8:	02d00793          	li	a5,45
 3dc:	fef50823          	sb	a5,-16(a0)
 3e0:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 3e4:	02e05763          	blez	a4,412 <printint+0x98>
 3e8:	f426                	sd	s1,40(sp)
 3ea:	377d                	addiw	a4,a4,-1
 3ec:	00e984b3          	add	s1,s3,a4
 3f0:	19fd                	addi	s3,s3,-1
 3f2:	99ba                	add	s3,s3,a4
 3f4:	1702                	slli	a4,a4,0x20
 3f6:	9301                	srli	a4,a4,0x20
 3f8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 3fc:	0004c583          	lbu	a1,0(s1)
 400:	854a                	mv	a0,s2
 402:	00000097          	auipc	ra,0x0
 406:	f56080e7          	jalr	-170(ra) # 358 <putc>
  while(--i >= 0)
 40a:	14fd                	addi	s1,s1,-1
 40c:	ff3498e3          	bne	s1,s3,3fc <printint+0x82>
 410:	74a2                	ld	s1,40(sp)
}
 412:	70e2                	ld	ra,56(sp)
 414:	7442                	ld	s0,48(sp)
 416:	7902                	ld	s2,32(sp)
 418:	69e2                	ld	s3,24(sp)
 41a:	6121                	addi	sp,sp,64
 41c:	8082                	ret
  neg = 0;
 41e:	4301                	li	t1,0
 420:	bf9d                	j	396 <printint+0x1c>

0000000000000422 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 422:	715d                	addi	sp,sp,-80
 424:	e486                	sd	ra,72(sp)
 426:	e0a2                	sd	s0,64(sp)
 428:	f84a                	sd	s2,48(sp)
 42a:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 42c:	0005c903          	lbu	s2,0(a1)
 430:	1a090b63          	beqz	s2,5e6 <vprintf+0x1c4>
 434:	fc26                	sd	s1,56(sp)
 436:	f44e                	sd	s3,40(sp)
 438:	f052                	sd	s4,32(sp)
 43a:	ec56                	sd	s5,24(sp)
 43c:	e85a                	sd	s6,16(sp)
 43e:	e45e                	sd	s7,8(sp)
 440:	8aaa                	mv	s5,a0
 442:	8bb2                	mv	s7,a2
 444:	00158493          	addi	s1,a1,1
  state = 0;
 448:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 44a:	02500a13          	li	s4,37
 44e:	4b55                	li	s6,21
 450:	a839                	j	46e <vprintf+0x4c>
        putc(fd, c);
 452:	85ca                	mv	a1,s2
 454:	8556                	mv	a0,s5
 456:	00000097          	auipc	ra,0x0
 45a:	f02080e7          	jalr	-254(ra) # 358 <putc>
 45e:	a019                	j	464 <vprintf+0x42>
    } else if(state == '%'){
 460:	01498d63          	beq	s3,s4,47a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 464:	0485                	addi	s1,s1,1
 466:	fff4c903          	lbu	s2,-1(s1)
 46a:	16090863          	beqz	s2,5da <vprintf+0x1b8>
    if(state == 0){
 46e:	fe0999e3          	bnez	s3,460 <vprintf+0x3e>
      if(c == '%'){
 472:	ff4910e3          	bne	s2,s4,452 <vprintf+0x30>
        state = '%';
 476:	89d2                	mv	s3,s4
 478:	b7f5                	j	464 <vprintf+0x42>
      if(c == 'd'){
 47a:	13490563          	beq	s2,s4,5a4 <vprintf+0x182>
 47e:	f9d9079b          	addiw	a5,s2,-99
 482:	0ff7f793          	zext.b	a5,a5
 486:	12fb6863          	bltu	s6,a5,5b6 <vprintf+0x194>
 48a:	f9d9079b          	addiw	a5,s2,-99
 48e:	0ff7f713          	zext.b	a4,a5
 492:	12eb6263          	bltu	s6,a4,5b6 <vprintf+0x194>
 496:	00271793          	slli	a5,a4,0x2
 49a:	00000717          	auipc	a4,0x0
 49e:	34670713          	addi	a4,a4,838 # 7e0 <malloc+0x106>
 4a2:	97ba                	add	a5,a5,a4
 4a4:	439c                	lw	a5,0(a5)
 4a6:	97ba                	add	a5,a5,a4
 4a8:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4aa:	008b8913          	addi	s2,s7,8
 4ae:	4685                	li	a3,1
 4b0:	4629                	li	a2,10
 4b2:	000ba583          	lw	a1,0(s7)
 4b6:	8556                	mv	a0,s5
 4b8:	00000097          	auipc	ra,0x0
 4bc:	ec2080e7          	jalr	-318(ra) # 37a <printint>
 4c0:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4c2:	4981                	li	s3,0
 4c4:	b745                	j	464 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4c6:	008b8913          	addi	s2,s7,8
 4ca:	4681                	li	a3,0
 4cc:	4629                	li	a2,10
 4ce:	000ba583          	lw	a1,0(s7)
 4d2:	8556                	mv	a0,s5
 4d4:	00000097          	auipc	ra,0x0
 4d8:	ea6080e7          	jalr	-346(ra) # 37a <printint>
 4dc:	8bca                	mv	s7,s2
      state = 0;
 4de:	4981                	li	s3,0
 4e0:	b751                	j	464 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 4e2:	008b8913          	addi	s2,s7,8
 4e6:	4681                	li	a3,0
 4e8:	4641                	li	a2,16
 4ea:	000ba583          	lw	a1,0(s7)
 4ee:	8556                	mv	a0,s5
 4f0:	00000097          	auipc	ra,0x0
 4f4:	e8a080e7          	jalr	-374(ra) # 37a <printint>
 4f8:	8bca                	mv	s7,s2
      state = 0;
 4fa:	4981                	li	s3,0
 4fc:	b7a5                	j	464 <vprintf+0x42>
 4fe:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 500:	008b8793          	addi	a5,s7,8
 504:	8c3e                	mv	s8,a5
 506:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 50a:	03000593          	li	a1,48
 50e:	8556                	mv	a0,s5
 510:	00000097          	auipc	ra,0x0
 514:	e48080e7          	jalr	-440(ra) # 358 <putc>
  putc(fd, 'x');
 518:	07800593          	li	a1,120
 51c:	8556                	mv	a0,s5
 51e:	00000097          	auipc	ra,0x0
 522:	e3a080e7          	jalr	-454(ra) # 358 <putc>
 526:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 528:	00000b97          	auipc	s7,0x0
 52c:	310b8b93          	addi	s7,s7,784 # 838 <digits>
 530:	03c9d793          	srli	a5,s3,0x3c
 534:	97de                	add	a5,a5,s7
 536:	0007c583          	lbu	a1,0(a5)
 53a:	8556                	mv	a0,s5
 53c:	00000097          	auipc	ra,0x0
 540:	e1c080e7          	jalr	-484(ra) # 358 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 544:	0992                	slli	s3,s3,0x4
 546:	397d                	addiw	s2,s2,-1
 548:	fe0914e3          	bnez	s2,530 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 54c:	8be2                	mv	s7,s8
      state = 0;
 54e:	4981                	li	s3,0
 550:	6c02                	ld	s8,0(sp)
 552:	bf09                	j	464 <vprintf+0x42>
        s = va_arg(ap, char*);
 554:	008b8993          	addi	s3,s7,8
 558:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 55c:	02090163          	beqz	s2,57e <vprintf+0x15c>
        while(*s != 0){
 560:	00094583          	lbu	a1,0(s2)
 564:	c9a5                	beqz	a1,5d4 <vprintf+0x1b2>
          putc(fd, *s);
 566:	8556                	mv	a0,s5
 568:	00000097          	auipc	ra,0x0
 56c:	df0080e7          	jalr	-528(ra) # 358 <putc>
          s++;
 570:	0905                	addi	s2,s2,1
        while(*s != 0){
 572:	00094583          	lbu	a1,0(s2)
 576:	f9e5                	bnez	a1,566 <vprintf+0x144>
        s = va_arg(ap, char*);
 578:	8bce                	mv	s7,s3
      state = 0;
 57a:	4981                	li	s3,0
 57c:	b5e5                	j	464 <vprintf+0x42>
          s = "(null)";
 57e:	00000917          	auipc	s2,0x0
 582:	25a90913          	addi	s2,s2,602 # 7d8 <malloc+0xfe>
        while(*s != 0){
 586:	02800593          	li	a1,40
 58a:	bff1                	j	566 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 58c:	008b8913          	addi	s2,s7,8
 590:	000bc583          	lbu	a1,0(s7)
 594:	8556                	mv	a0,s5
 596:	00000097          	auipc	ra,0x0
 59a:	dc2080e7          	jalr	-574(ra) # 358 <putc>
 59e:	8bca                	mv	s7,s2
      state = 0;
 5a0:	4981                	li	s3,0
 5a2:	b5c9                	j	464 <vprintf+0x42>
        putc(fd, c);
 5a4:	02500593          	li	a1,37
 5a8:	8556                	mv	a0,s5
 5aa:	00000097          	auipc	ra,0x0
 5ae:	dae080e7          	jalr	-594(ra) # 358 <putc>
      state = 0;
 5b2:	4981                	li	s3,0
 5b4:	bd45                	j	464 <vprintf+0x42>
        putc(fd, '%');
 5b6:	02500593          	li	a1,37
 5ba:	8556                	mv	a0,s5
 5bc:	00000097          	auipc	ra,0x0
 5c0:	d9c080e7          	jalr	-612(ra) # 358 <putc>
        putc(fd, c);
 5c4:	85ca                	mv	a1,s2
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	d90080e7          	jalr	-624(ra) # 358 <putc>
      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	bd49                	j	464 <vprintf+0x42>
        s = va_arg(ap, char*);
 5d4:	8bce                	mv	s7,s3
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	b571                	j	464 <vprintf+0x42>
 5da:	74e2                	ld	s1,56(sp)
 5dc:	79a2                	ld	s3,40(sp)
 5de:	7a02                	ld	s4,32(sp)
 5e0:	6ae2                	ld	s5,24(sp)
 5e2:	6b42                	ld	s6,16(sp)
 5e4:	6ba2                	ld	s7,8(sp)
    }
  }
}
 5e6:	60a6                	ld	ra,72(sp)
 5e8:	6406                	ld	s0,64(sp)
 5ea:	7942                	ld	s2,48(sp)
 5ec:	6161                	addi	sp,sp,80
 5ee:	8082                	ret

00000000000005f0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5f0:	715d                	addi	sp,sp,-80
 5f2:	ec06                	sd	ra,24(sp)
 5f4:	e822                	sd	s0,16(sp)
 5f6:	1000                	addi	s0,sp,32
 5f8:	e010                	sd	a2,0(s0)
 5fa:	e414                	sd	a3,8(s0)
 5fc:	e818                	sd	a4,16(s0)
 5fe:	ec1c                	sd	a5,24(s0)
 600:	03043023          	sd	a6,32(s0)
 604:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 608:	8622                	mv	a2,s0
 60a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 60e:	00000097          	auipc	ra,0x0
 612:	e14080e7          	jalr	-492(ra) # 422 <vprintf>
}
 616:	60e2                	ld	ra,24(sp)
 618:	6442                	ld	s0,16(sp)
 61a:	6161                	addi	sp,sp,80
 61c:	8082                	ret

000000000000061e <printf>:

void
printf(const char *fmt, ...)
{
 61e:	711d                	addi	sp,sp,-96
 620:	ec06                	sd	ra,24(sp)
 622:	e822                	sd	s0,16(sp)
 624:	1000                	addi	s0,sp,32
 626:	e40c                	sd	a1,8(s0)
 628:	e810                	sd	a2,16(s0)
 62a:	ec14                	sd	a3,24(s0)
 62c:	f018                	sd	a4,32(s0)
 62e:	f41c                	sd	a5,40(s0)
 630:	03043823          	sd	a6,48(s0)
 634:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 638:	00840613          	addi	a2,s0,8
 63c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 640:	85aa                	mv	a1,a0
 642:	4505                	li	a0,1
 644:	00000097          	auipc	ra,0x0
 648:	dde080e7          	jalr	-546(ra) # 422 <vprintf>
}
 64c:	60e2                	ld	ra,24(sp)
 64e:	6442                	ld	s0,16(sp)
 650:	6125                	addi	sp,sp,96
 652:	8082                	ret

0000000000000654 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 654:	1141                	addi	sp,sp,-16
 656:	e406                	sd	ra,8(sp)
 658:	e022                	sd	s0,0(sp)
 65a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 660:	00000797          	auipc	a5,0x0
 664:	5d07b783          	ld	a5,1488(a5) # c30 <freep>
 668:	a039                	j	676 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66a:	6398                	ld	a4,0(a5)
 66c:	00e7e463          	bltu	a5,a4,674 <free+0x20>
 670:	00e6ea63          	bltu	a3,a4,684 <free+0x30>
{
 674:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 676:	fed7fae3          	bgeu	a5,a3,66a <free+0x16>
 67a:	6398                	ld	a4,0(a5)
 67c:	00e6e463          	bltu	a3,a4,684 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	fee7eae3          	bltu	a5,a4,674 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 684:	ff852583          	lw	a1,-8(a0)
 688:	6390                	ld	a2,0(a5)
 68a:	02059813          	slli	a6,a1,0x20
 68e:	01c85713          	srli	a4,a6,0x1c
 692:	9736                	add	a4,a4,a3
 694:	02e60563          	beq	a2,a4,6be <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 698:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 69c:	4790                	lw	a2,8(a5)
 69e:	02061593          	slli	a1,a2,0x20
 6a2:	01c5d713          	srli	a4,a1,0x1c
 6a6:	973e                	add	a4,a4,a5
 6a8:	02e68263          	beq	a3,a4,6cc <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6ac:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 6ae:	00000717          	auipc	a4,0x0
 6b2:	58f73123          	sd	a5,1410(a4) # c30 <freep>
}
 6b6:	60a2                	ld	ra,8(sp)
 6b8:	6402                	ld	s0,0(sp)
 6ba:	0141                	addi	sp,sp,16
 6bc:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 6be:	4618                	lw	a4,8(a2)
 6c0:	9f2d                	addw	a4,a4,a1
 6c2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c6:	6398                	ld	a4,0(a5)
 6c8:	6310                	ld	a2,0(a4)
 6ca:	b7f9                	j	698 <free+0x44>
    p->s.size += bp->s.size;
 6cc:	ff852703          	lw	a4,-8(a0)
 6d0:	9f31                	addw	a4,a4,a2
 6d2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 6d4:	ff053683          	ld	a3,-16(a0)
 6d8:	bfd1                	j	6ac <free+0x58>

00000000000006da <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6da:	7139                	addi	sp,sp,-64
 6dc:	fc06                	sd	ra,56(sp)
 6de:	f822                	sd	s0,48(sp)
 6e0:	f04a                	sd	s2,32(sp)
 6e2:	ec4e                	sd	s3,24(sp)
 6e4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e6:	02051993          	slli	s3,a0,0x20
 6ea:	0209d993          	srli	s3,s3,0x20
 6ee:	09bd                	addi	s3,s3,15
 6f0:	0049d993          	srli	s3,s3,0x4
 6f4:	2985                	addiw	s3,s3,1
 6f6:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 6f8:	00000517          	auipc	a0,0x0
 6fc:	53853503          	ld	a0,1336(a0) # c30 <freep>
 700:	c905                	beqz	a0,730 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 702:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 704:	4798                	lw	a4,8(a5)
 706:	09377a63          	bgeu	a4,s3,79a <malloc+0xc0>
 70a:	f426                	sd	s1,40(sp)
 70c:	e852                	sd	s4,16(sp)
 70e:	e456                	sd	s5,8(sp)
 710:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 712:	8a4e                	mv	s4,s3
 714:	6705                	lui	a4,0x1
 716:	00e9f363          	bgeu	s3,a4,71c <malloc+0x42>
 71a:	6a05                	lui	s4,0x1
 71c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 720:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 724:	00000497          	auipc	s1,0x0
 728:	50c48493          	addi	s1,s1,1292 # c30 <freep>
  if(p == (char*)-1)
 72c:	5afd                	li	s5,-1
 72e:	a089                	j	770 <malloc+0x96>
 730:	f426                	sd	s1,40(sp)
 732:	e852                	sd	s4,16(sp)
 734:	e456                	sd	s5,8(sp)
 736:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 738:	00000797          	auipc	a5,0x0
 73c:	50078793          	addi	a5,a5,1280 # c38 <base>
 740:	00000717          	auipc	a4,0x0
 744:	4ef73823          	sd	a5,1264(a4) # c30 <freep>
 748:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 74a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 74e:	b7d1                	j	712 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 750:	6398                	ld	a4,0(a5)
 752:	e118                	sd	a4,0(a0)
 754:	a8b9                	j	7b2 <malloc+0xd8>
  hp->s.size = nu;
 756:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 75a:	0541                	addi	a0,a0,16
 75c:	00000097          	auipc	ra,0x0
 760:	ef8080e7          	jalr	-264(ra) # 654 <free>
  return freep;
 764:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 766:	c135                	beqz	a0,7ca <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 768:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 76a:	4798                	lw	a4,8(a5)
 76c:	03277363          	bgeu	a4,s2,792 <malloc+0xb8>
    if(p == freep)
 770:	6098                	ld	a4,0(s1)
 772:	853e                	mv	a0,a5
 774:	fef71ae3          	bne	a4,a5,768 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 778:	8552                	mv	a0,s4
 77a:	00000097          	auipc	ra,0x0
 77e:	bc6080e7          	jalr	-1082(ra) # 340 <sbrk>
  if(p == (char*)-1)
 782:	fd551ae3          	bne	a0,s5,756 <malloc+0x7c>
        return 0;
 786:	4501                	li	a0,0
 788:	74a2                	ld	s1,40(sp)
 78a:	6a42                	ld	s4,16(sp)
 78c:	6aa2                	ld	s5,8(sp)
 78e:	6b02                	ld	s6,0(sp)
 790:	a03d                	j	7be <malloc+0xe4>
 792:	74a2                	ld	s1,40(sp)
 794:	6a42                	ld	s4,16(sp)
 796:	6aa2                	ld	s5,8(sp)
 798:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 79a:	fae90be3          	beq	s2,a4,750 <malloc+0x76>
        p->s.size -= nunits;
 79e:	4137073b          	subw	a4,a4,s3
 7a2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7a4:	02071693          	slli	a3,a4,0x20
 7a8:	01c6d713          	srli	a4,a3,0x1c
 7ac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7ae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7b2:	00000717          	auipc	a4,0x0
 7b6:	46a73f23          	sd	a0,1150(a4) # c30 <freep>
      return (void*)(p + 1);
 7ba:	01078513          	addi	a0,a5,16
  }
}
 7be:	70e2                	ld	ra,56(sp)
 7c0:	7442                	ld	s0,48(sp)
 7c2:	7902                	ld	s2,32(sp)
 7c4:	69e2                	ld	s3,24(sp)
 7c6:	6121                	addi	sp,sp,64
 7c8:	8082                	ret
 7ca:	74a2                	ld	s1,40(sp)
 7cc:	6a42                	ld	s4,16(sp)
 7ce:	6aa2                	ld	s5,8(sp)
 7d0:	6b02                	ld	s6,0(sp)
 7d2:	b7f5                	j	7be <malloc+0xe4>
