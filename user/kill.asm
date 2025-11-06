
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7df63          	bge	a5,a0,48 <main+0x48>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	1cc080e7          	jalr	460(ra) # 1f4 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	2f6080e7          	jalr	758(ra) # 326 <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	addi	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	2b6080e7          	jalr	694(ra) # 2f6 <exit>
  48:	e426                	sd	s1,8(sp)
  4a:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  4c:	00000597          	auipc	a1,0x0
  50:	7cc58593          	addi	a1,a1,1996 # 818 <malloc+0x100>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	5d8080e7          	jalr	1496(ra) # 62e <fprintf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	00000097          	auipc	ra,0x0
  64:	296080e7          	jalr	662(ra) # 2f6 <exit>

0000000000000068 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
  68:	1141                	addi	sp,sp,-16
  6a:	e406                	sd	ra,8(sp)
  6c:	e022                	sd	s0,0(sp)
  6e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  70:	87aa                	mv	a5,a0
  72:	0585                	addi	a1,a1,1
  74:	0785                	addi	a5,a5,1
  76:	fff5c703          	lbu	a4,-1(a1)
  7a:	fee78fa3          	sb	a4,-1(a5)
  7e:	fb75                	bnez	a4,72 <strcpy+0xa>
    ;
  return os;
}
  80:	60a2                	ld	ra,8(sp)
  82:	6402                	ld	s0,0(sp)
  84:	0141                	addi	sp,sp,16
  86:	8082                	ret

0000000000000088 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  88:	1141                	addi	sp,sp,-16
  8a:	e406                	sd	ra,8(sp)
  8c:	e022                	sd	s0,0(sp)
  8e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  90:	00054783          	lbu	a5,0(a0)
  94:	cb91                	beqz	a5,a8 <strcmp+0x20>
  96:	0005c703          	lbu	a4,0(a1)
  9a:	00f71763          	bne	a4,a5,a8 <strcmp+0x20>
    p++, q++;
  9e:	0505                	addi	a0,a0,1
  a0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a2:	00054783          	lbu	a5,0(a0)
  a6:	fbe5                	bnez	a5,96 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a8:	0005c503          	lbu	a0,0(a1)
}
  ac:	40a7853b          	subw	a0,a5,a0
  b0:	60a2                	ld	ra,8(sp)
  b2:	6402                	ld	s0,0(sp)
  b4:	0141                	addi	sp,sp,16
  b6:	8082                	ret

00000000000000b8 <strlen>:

uint
strlen(const char *s)
{
  b8:	1141                	addi	sp,sp,-16
  ba:	e406                	sd	ra,8(sp)
  bc:	e022                	sd	s0,0(sp)
  be:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	cf91                	beqz	a5,e0 <strlen+0x28>
  c6:	00150793          	addi	a5,a0,1
  ca:	86be                	mv	a3,a5
  cc:	0785                	addi	a5,a5,1
  ce:	fff7c703          	lbu	a4,-1(a5)
  d2:	ff65                	bnez	a4,ca <strlen+0x12>
  d4:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
  d8:	60a2                	ld	ra,8(sp)
  da:	6402                	ld	s0,0(sp)
  dc:	0141                	addi	sp,sp,16
  de:	8082                	ret
  for(n = 0; s[n]; n++)
  e0:	4501                	li	a0,0
  e2:	bfdd                	j	d8 <strlen+0x20>

00000000000000e4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e4:	1141                	addi	sp,sp,-16
  e6:	e406                	sd	ra,8(sp)
  e8:	e022                	sd	s0,0(sp)
  ea:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ec:	ca19                	beqz	a2,102 <memset+0x1e>
  ee:	87aa                	mv	a5,a0
  f0:	1602                	slli	a2,a2,0x20
  f2:	9201                	srli	a2,a2,0x20
  f4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fc:	0785                	addi	a5,a5,1
  fe:	fee79de3          	bne	a5,a4,f8 <memset+0x14>
  }
  return dst;
}
 102:	60a2                	ld	ra,8(sp)
 104:	6402                	ld	s0,0(sp)
 106:	0141                	addi	sp,sp,16
 108:	8082                	ret

000000000000010a <strchr>:

char*
strchr(const char *s, char c)
{
 10a:	1141                	addi	sp,sp,-16
 10c:	e406                	sd	ra,8(sp)
 10e:	e022                	sd	s0,0(sp)
 110:	0800                	addi	s0,sp,16
  for(; *s; s++)
 112:	00054783          	lbu	a5,0(a0)
 116:	cf81                	beqz	a5,12e <strchr+0x24>
    if(*s == c)
 118:	00f58763          	beq	a1,a5,126 <strchr+0x1c>
  for(; *s; s++)
 11c:	0505                	addi	a0,a0,1
 11e:	00054783          	lbu	a5,0(a0)
 122:	fbfd                	bnez	a5,118 <strchr+0xe>
      return (char*)s;
  return 0;
 124:	4501                	li	a0,0
}
 126:	60a2                	ld	ra,8(sp)
 128:	6402                	ld	s0,0(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret
  return 0;
 12e:	4501                	li	a0,0
 130:	bfdd                	j	126 <strchr+0x1c>

0000000000000132 <gets>:

char*
gets(char *buf, int max)
{
 132:	711d                	addi	sp,sp,-96
 134:	ec86                	sd	ra,88(sp)
 136:	e8a2                	sd	s0,80(sp)
 138:	e4a6                	sd	s1,72(sp)
 13a:	e0ca                	sd	s2,64(sp)
 13c:	fc4e                	sd	s3,56(sp)
 13e:	f852                	sd	s4,48(sp)
 140:	f456                	sd	s5,40(sp)
 142:	f05a                	sd	s6,32(sp)
 144:	ec5e                	sd	s7,24(sp)
 146:	e862                	sd	s8,16(sp)
 148:	1080                	addi	s0,sp,96
 14a:	8baa                	mv	s7,a0
 14c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14e:	892a                	mv	s2,a0
 150:	4481                	li	s1,0
    cc = read(0, &c, 1);
 152:	faf40b13          	addi	s6,s0,-81
 156:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 158:	8c26                	mv	s8,s1
 15a:	0014899b          	addiw	s3,s1,1
 15e:	84ce                	mv	s1,s3
 160:	0349d663          	bge	s3,s4,18c <gets+0x5a>
    cc = read(0, &c, 1);
 164:	8656                	mv	a2,s5
 166:	85da                	mv	a1,s6
 168:	4501                	li	a0,0
 16a:	00000097          	auipc	ra,0x0
 16e:	1a4080e7          	jalr	420(ra) # 30e <read>
    if(cc < 1)
 172:	00a05d63          	blez	a0,18c <gets+0x5a>
      break;
    buf[i++] = c;
 176:	faf44783          	lbu	a5,-81(s0)
 17a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 17e:	0905                	addi	s2,s2,1
 180:	ff678713          	addi	a4,a5,-10
 184:	c319                	beqz	a4,18a <gets+0x58>
 186:	17cd                	addi	a5,a5,-13
 188:	fbe1                	bnez	a5,158 <gets+0x26>
    buf[i++] = c;
 18a:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 18c:	9c5e                	add	s8,s8,s7
 18e:	000c0023          	sb	zero,0(s8)
  return buf;
}
 192:	855e                	mv	a0,s7
 194:	60e6                	ld	ra,88(sp)
 196:	6446                	ld	s0,80(sp)
 198:	64a6                	ld	s1,72(sp)
 19a:	6906                	ld	s2,64(sp)
 19c:	79e2                	ld	s3,56(sp)
 19e:	7a42                	ld	s4,48(sp)
 1a0:	7aa2                	ld	s5,40(sp)
 1a2:	7b02                	ld	s6,32(sp)
 1a4:	6be2                	ld	s7,24(sp)
 1a6:	6c42                	ld	s8,16(sp)
 1a8:	6125                	addi	sp,sp,96
 1aa:	8082                	ret

00000000000001ac <stat>:

int
stat(const char *n, struct stat *st)
{
 1ac:	1101                	addi	sp,sp,-32
 1ae:	ec06                	sd	ra,24(sp)
 1b0:	e822                	sd	s0,16(sp)
 1b2:	e04a                	sd	s2,0(sp)
 1b4:	1000                	addi	s0,sp,32
 1b6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b8:	4581                	li	a1,0
 1ba:	00000097          	auipc	ra,0x0
 1be:	17c080e7          	jalr	380(ra) # 336 <open>
  if(fd < 0)
 1c2:	02054663          	bltz	a0,1ee <stat+0x42>
 1c6:	e426                	sd	s1,8(sp)
 1c8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ca:	85ca                	mv	a1,s2
 1cc:	00000097          	auipc	ra,0x0
 1d0:	182080e7          	jalr	386(ra) # 34e <fstat>
 1d4:	892a                	mv	s2,a0
  close(fd);
 1d6:	8526                	mv	a0,s1
 1d8:	00000097          	auipc	ra,0x0
 1dc:	146080e7          	jalr	326(ra) # 31e <close>
  return r;
 1e0:	64a2                	ld	s1,8(sp)
}
 1e2:	854a                	mv	a0,s2
 1e4:	60e2                	ld	ra,24(sp)
 1e6:	6442                	ld	s0,16(sp)
 1e8:	6902                	ld	s2,0(sp)
 1ea:	6105                	addi	sp,sp,32
 1ec:	8082                	ret
    return -1;
 1ee:	57fd                	li	a5,-1
 1f0:	893e                	mv	s2,a5
 1f2:	bfc5                	j	1e2 <stat+0x36>

00000000000001f4 <atoi>:

int
atoi(const char *s)
{
 1f4:	1141                	addi	sp,sp,-16
 1f6:	e406                	sd	ra,8(sp)
 1f8:	e022                	sd	s0,0(sp)
 1fa:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1fc:	00054683          	lbu	a3,0(a0)
 200:	fd06879b          	addiw	a5,a3,-48
 204:	0ff7f793          	zext.b	a5,a5
 208:	4625                	li	a2,9
 20a:	02f66963          	bltu	a2,a5,23c <atoi+0x48>
 20e:	872a                	mv	a4,a0
  n = 0;
 210:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 212:	0705                	addi	a4,a4,1
 214:	0025179b          	slliw	a5,a0,0x2
 218:	9fa9                	addw	a5,a5,a0
 21a:	0017979b          	slliw	a5,a5,0x1
 21e:	9fb5                	addw	a5,a5,a3
 220:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 224:	00074683          	lbu	a3,0(a4)
 228:	fd06879b          	addiw	a5,a3,-48
 22c:	0ff7f793          	zext.b	a5,a5
 230:	fef671e3          	bgeu	a2,a5,212 <atoi+0x1e>
  return n;
}
 234:	60a2                	ld	ra,8(sp)
 236:	6402                	ld	s0,0(sp)
 238:	0141                	addi	sp,sp,16
 23a:	8082                	ret
  n = 0;
 23c:	4501                	li	a0,0
 23e:	bfdd                	j	234 <atoi+0x40>

0000000000000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	1141                	addi	sp,sp,-16
 242:	e406                	sd	ra,8(sp)
 244:	e022                	sd	s0,0(sp)
 246:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 248:	02b57563          	bgeu	a0,a1,272 <memmove+0x32>
    while(n-- > 0)
 24c:	00c05f63          	blez	a2,26a <memmove+0x2a>
 250:	1602                	slli	a2,a2,0x20
 252:	9201                	srli	a2,a2,0x20
 254:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 258:	872a                	mv	a4,a0
      *dst++ = *src++;
 25a:	0585                	addi	a1,a1,1
 25c:	0705                	addi	a4,a4,1
 25e:	fff5c683          	lbu	a3,-1(a1)
 262:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 266:	fee79ae3          	bne	a5,a4,25a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 26a:	60a2                	ld	ra,8(sp)
 26c:	6402                	ld	s0,0(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
    while(n-- > 0)
 272:	fec05ce3          	blez	a2,26a <memmove+0x2a>
    dst += n;
 276:	00c50733          	add	a4,a0,a2
    src += n;
 27a:	95b2                	add	a1,a1,a2
 27c:	fff6079b          	addiw	a5,a2,-1
 280:	1782                	slli	a5,a5,0x20
 282:	9381                	srli	a5,a5,0x20
 284:	fff7c793          	not	a5,a5
 288:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 28a:	15fd                	addi	a1,a1,-1
 28c:	177d                	addi	a4,a4,-1
 28e:	0005c683          	lbu	a3,0(a1)
 292:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 296:	fef71ae3          	bne	a4,a5,28a <memmove+0x4a>
 29a:	bfc1                	j	26a <memmove+0x2a>

000000000000029c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e406                	sd	ra,8(sp)
 2a0:	e022                	sd	s0,0(sp)
 2a2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a4:	c61d                	beqz	a2,2d2 <memcmp+0x36>
 2a6:	1602                	slli	a2,a2,0x20
 2a8:	9201                	srli	a2,a2,0x20
 2aa:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	0005c703          	lbu	a4,0(a1)
 2b6:	00e79863          	bne	a5,a4,2c6 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 2ba:	0505                	addi	a0,a0,1
    p2++;
 2bc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2be:	fed518e3          	bne	a0,a3,2ae <memcmp+0x12>
  }
  return 0;
 2c2:	4501                	li	a0,0
 2c4:	a019                	j	2ca <memcmp+0x2e>
      return *p1 - *p2;
 2c6:	40e7853b          	subw	a0,a5,a4
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
  return 0;
 2d2:	4501                	li	a0,0
 2d4:	bfdd                	j	2ca <memcmp+0x2e>

00000000000002d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2de:	00000097          	auipc	ra,0x0
 2e2:	f62080e7          	jalr	-158(ra) # 240 <memmove>
}
 2e6:	60a2                	ld	ra,8(sp)
 2e8:	6402                	ld	s0,0(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 2ee:	4885                	li	a7,1
 ecall
 2f0:	00000073          	ecall
 ret
 2f4:	8082                	ret

00000000000002f6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 2f6:	4889                	li	a7,2
 ecall
 2f8:	00000073          	ecall
 ret
 2fc:	8082                	ret

00000000000002fe <wait>:
.global wait
wait:
 li a7, SYS_wait
 2fe:	488d                	li	a7,3
 ecall
 300:	00000073          	ecall
 ret
 304:	8082                	ret

0000000000000306 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 306:	4891                	li	a7,4
 ecall
 308:	00000073          	ecall
 ret
 30c:	8082                	ret

000000000000030e <read>:
.global read
read:
 li a7, SYS_read
 30e:	4895                	li	a7,5
 ecall
 310:	00000073          	ecall
 ret
 314:	8082                	ret

0000000000000316 <write>:
.global write
write:
 li a7, SYS_write
 316:	48c1                	li	a7,16
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <close>:
.global close
close:
 li a7, SYS_close
 31e:	48d5                	li	a7,21
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <kill>:
.global kill
kill:
 li a7, SYS_kill
 326:	4899                	li	a7,6
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <exec>:
.global exec
exec:
 li a7, SYS_exec
 32e:	489d                	li	a7,7
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <open>:
.global open
open:
 li a7, SYS_open
 336:	48bd                	li	a7,15
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 33e:	48c5                	li	a7,17
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 346:	48c9                	li	a7,18
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 34e:	48a1                	li	a7,8
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <link>:
.global link
link:
 li a7, SYS_link
 356:	48cd                	li	a7,19
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 35e:	48d1                	li	a7,20
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 366:	48a5                	li	a7,9
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <dup>:
.global dup
dup:
 li a7, SYS_dup
 36e:	48a9                	li	a7,10
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 376:	48ad                	li	a7,11
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 37e:	48b1                	li	a7,12
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 386:	48b5                	li	a7,13
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 38e:	48b9                	li	a7,14
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 396:	1101                	addi	sp,sp,-32
 398:	ec06                	sd	ra,24(sp)
 39a:	e822                	sd	s0,16(sp)
 39c:	1000                	addi	s0,sp,32
 39e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3a2:	4605                	li	a2,1
 3a4:	fef40593          	addi	a1,s0,-17
 3a8:	00000097          	auipc	ra,0x0
 3ac:	f6e080e7          	jalr	-146(ra) # 316 <write>
}
 3b0:	60e2                	ld	ra,24(sp)
 3b2:	6442                	ld	s0,16(sp)
 3b4:	6105                	addi	sp,sp,32
 3b6:	8082                	ret

00000000000003b8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b8:	7139                	addi	sp,sp,-64
 3ba:	fc06                	sd	ra,56(sp)
 3bc:	f822                	sd	s0,48(sp)
 3be:	f04a                	sd	s2,32(sp)
 3c0:	ec4e                	sd	s3,24(sp)
 3c2:	0080                	addi	s0,sp,64
 3c4:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3c6:	cad9                	beqz	a3,45c <printint+0xa4>
 3c8:	01f5d79b          	srliw	a5,a1,0x1f
 3cc:	cbc1                	beqz	a5,45c <printint+0xa4>
    neg = 1;
    x = -xx;
 3ce:	40b005bb          	negw	a1,a1
    neg = 1;
 3d2:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 3d4:	fc040993          	addi	s3,s0,-64
  neg = 0;
 3d8:	86ce                	mv	a3,s3
  i = 0;
 3da:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3dc:	00000817          	auipc	a6,0x0
 3e0:	4b480813          	addi	a6,a6,1204 # 890 <digits>
 3e4:	88ba                	mv	a7,a4
 3e6:	0017051b          	addiw	a0,a4,1
 3ea:	872a                	mv	a4,a0
 3ec:	02c5f7bb          	remuw	a5,a1,a2
 3f0:	1782                	slli	a5,a5,0x20
 3f2:	9381                	srli	a5,a5,0x20
 3f4:	97c2                	add	a5,a5,a6
 3f6:	0007c783          	lbu	a5,0(a5)
 3fa:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 3fe:	87ae                	mv	a5,a1
 400:	02c5d5bb          	divuw	a1,a1,a2
 404:	0685                	addi	a3,a3,1
 406:	fcc7ffe3          	bgeu	a5,a2,3e4 <printint+0x2c>
  if(neg)
 40a:	00030c63          	beqz	t1,422 <printint+0x6a>
    buf[i++] = '-';
 40e:	fd050793          	addi	a5,a0,-48
 412:	00878533          	add	a0,a5,s0
 416:	02d00793          	li	a5,45
 41a:	fef50823          	sb	a5,-16(a0)
 41e:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 422:	02e05763          	blez	a4,450 <printint+0x98>
 426:	f426                	sd	s1,40(sp)
 428:	377d                	addiw	a4,a4,-1
 42a:	00e984b3          	add	s1,s3,a4
 42e:	19fd                	addi	s3,s3,-1
 430:	99ba                	add	s3,s3,a4
 432:	1702                	slli	a4,a4,0x20
 434:	9301                	srli	a4,a4,0x20
 436:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 43a:	0004c583          	lbu	a1,0(s1)
 43e:	854a                	mv	a0,s2
 440:	00000097          	auipc	ra,0x0
 444:	f56080e7          	jalr	-170(ra) # 396 <putc>
  while(--i >= 0)
 448:	14fd                	addi	s1,s1,-1
 44a:	ff3498e3          	bne	s1,s3,43a <printint+0x82>
 44e:	74a2                	ld	s1,40(sp)
}
 450:	70e2                	ld	ra,56(sp)
 452:	7442                	ld	s0,48(sp)
 454:	7902                	ld	s2,32(sp)
 456:	69e2                	ld	s3,24(sp)
 458:	6121                	addi	sp,sp,64
 45a:	8082                	ret
  neg = 0;
 45c:	4301                	li	t1,0
 45e:	bf9d                	j	3d4 <printint+0x1c>

0000000000000460 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 460:	715d                	addi	sp,sp,-80
 462:	e486                	sd	ra,72(sp)
 464:	e0a2                	sd	s0,64(sp)
 466:	f84a                	sd	s2,48(sp)
 468:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 46a:	0005c903          	lbu	s2,0(a1)
 46e:	1a090b63          	beqz	s2,624 <vprintf+0x1c4>
 472:	fc26                	sd	s1,56(sp)
 474:	f44e                	sd	s3,40(sp)
 476:	f052                	sd	s4,32(sp)
 478:	ec56                	sd	s5,24(sp)
 47a:	e85a                	sd	s6,16(sp)
 47c:	e45e                	sd	s7,8(sp)
 47e:	8aaa                	mv	s5,a0
 480:	8bb2                	mv	s7,a2
 482:	00158493          	addi	s1,a1,1
  state = 0;
 486:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 488:	02500a13          	li	s4,37
 48c:	4b55                	li	s6,21
 48e:	a839                	j	4ac <vprintf+0x4c>
        putc(fd, c);
 490:	85ca                	mv	a1,s2
 492:	8556                	mv	a0,s5
 494:	00000097          	auipc	ra,0x0
 498:	f02080e7          	jalr	-254(ra) # 396 <putc>
 49c:	a019                	j	4a2 <vprintf+0x42>
    } else if(state == '%'){
 49e:	01498d63          	beq	s3,s4,4b8 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 4a2:	0485                	addi	s1,s1,1
 4a4:	fff4c903          	lbu	s2,-1(s1)
 4a8:	16090863          	beqz	s2,618 <vprintf+0x1b8>
    if(state == 0){
 4ac:	fe0999e3          	bnez	s3,49e <vprintf+0x3e>
      if(c == '%'){
 4b0:	ff4910e3          	bne	s2,s4,490 <vprintf+0x30>
        state = '%';
 4b4:	89d2                	mv	s3,s4
 4b6:	b7f5                	j	4a2 <vprintf+0x42>
      if(c == 'd'){
 4b8:	13490563          	beq	s2,s4,5e2 <vprintf+0x182>
 4bc:	f9d9079b          	addiw	a5,s2,-99
 4c0:	0ff7f793          	zext.b	a5,a5
 4c4:	12fb6863          	bltu	s6,a5,5f4 <vprintf+0x194>
 4c8:	f9d9079b          	addiw	a5,s2,-99
 4cc:	0ff7f713          	zext.b	a4,a5
 4d0:	12eb6263          	bltu	s6,a4,5f4 <vprintf+0x194>
 4d4:	00271793          	slli	a5,a4,0x2
 4d8:	00000717          	auipc	a4,0x0
 4dc:	36070713          	addi	a4,a4,864 # 838 <malloc+0x120>
 4e0:	97ba                	add	a5,a5,a4
 4e2:	439c                	lw	a5,0(a5)
 4e4:	97ba                	add	a5,a5,a4
 4e6:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 4e8:	008b8913          	addi	s2,s7,8
 4ec:	4685                	li	a3,1
 4ee:	4629                	li	a2,10
 4f0:	000ba583          	lw	a1,0(s7)
 4f4:	8556                	mv	a0,s5
 4f6:	00000097          	auipc	ra,0x0
 4fa:	ec2080e7          	jalr	-318(ra) # 3b8 <printint>
 4fe:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 500:	4981                	li	s3,0
 502:	b745                	j	4a2 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 504:	008b8913          	addi	s2,s7,8
 508:	4681                	li	a3,0
 50a:	4629                	li	a2,10
 50c:	000ba583          	lw	a1,0(s7)
 510:	8556                	mv	a0,s5
 512:	00000097          	auipc	ra,0x0
 516:	ea6080e7          	jalr	-346(ra) # 3b8 <printint>
 51a:	8bca                	mv	s7,s2
      state = 0;
 51c:	4981                	li	s3,0
 51e:	b751                	j	4a2 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 520:	008b8913          	addi	s2,s7,8
 524:	4681                	li	a3,0
 526:	4641                	li	a2,16
 528:	000ba583          	lw	a1,0(s7)
 52c:	8556                	mv	a0,s5
 52e:	00000097          	auipc	ra,0x0
 532:	e8a080e7          	jalr	-374(ra) # 3b8 <printint>
 536:	8bca                	mv	s7,s2
      state = 0;
 538:	4981                	li	s3,0
 53a:	b7a5                	j	4a2 <vprintf+0x42>
 53c:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 53e:	008b8793          	addi	a5,s7,8
 542:	8c3e                	mv	s8,a5
 544:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 548:	03000593          	li	a1,48
 54c:	8556                	mv	a0,s5
 54e:	00000097          	auipc	ra,0x0
 552:	e48080e7          	jalr	-440(ra) # 396 <putc>
  putc(fd, 'x');
 556:	07800593          	li	a1,120
 55a:	8556                	mv	a0,s5
 55c:	00000097          	auipc	ra,0x0
 560:	e3a080e7          	jalr	-454(ra) # 396 <putc>
 564:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 566:	00000b97          	auipc	s7,0x0
 56a:	32ab8b93          	addi	s7,s7,810 # 890 <digits>
 56e:	03c9d793          	srli	a5,s3,0x3c
 572:	97de                	add	a5,a5,s7
 574:	0007c583          	lbu	a1,0(a5)
 578:	8556                	mv	a0,s5
 57a:	00000097          	auipc	ra,0x0
 57e:	e1c080e7          	jalr	-484(ra) # 396 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 582:	0992                	slli	s3,s3,0x4
 584:	397d                	addiw	s2,s2,-1
 586:	fe0914e3          	bnez	s2,56e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 58a:	8be2                	mv	s7,s8
      state = 0;
 58c:	4981                	li	s3,0
 58e:	6c02                	ld	s8,0(sp)
 590:	bf09                	j	4a2 <vprintf+0x42>
        s = va_arg(ap, char*);
 592:	008b8993          	addi	s3,s7,8
 596:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 59a:	02090163          	beqz	s2,5bc <vprintf+0x15c>
        while(*s != 0){
 59e:	00094583          	lbu	a1,0(s2)
 5a2:	c9a5                	beqz	a1,612 <vprintf+0x1b2>
          putc(fd, *s);
 5a4:	8556                	mv	a0,s5
 5a6:	00000097          	auipc	ra,0x0
 5aa:	df0080e7          	jalr	-528(ra) # 396 <putc>
          s++;
 5ae:	0905                	addi	s2,s2,1
        while(*s != 0){
 5b0:	00094583          	lbu	a1,0(s2)
 5b4:	f9e5                	bnez	a1,5a4 <vprintf+0x144>
        s = va_arg(ap, char*);
 5b6:	8bce                	mv	s7,s3
      state = 0;
 5b8:	4981                	li	s3,0
 5ba:	b5e5                	j	4a2 <vprintf+0x42>
          s = "(null)";
 5bc:	00000917          	auipc	s2,0x0
 5c0:	27490913          	addi	s2,s2,628 # 830 <malloc+0x118>
        while(*s != 0){
 5c4:	02800593          	li	a1,40
 5c8:	bff1                	j	5a4 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 5ca:	008b8913          	addi	s2,s7,8
 5ce:	000bc583          	lbu	a1,0(s7)
 5d2:	8556                	mv	a0,s5
 5d4:	00000097          	auipc	ra,0x0
 5d8:	dc2080e7          	jalr	-574(ra) # 396 <putc>
 5dc:	8bca                	mv	s7,s2
      state = 0;
 5de:	4981                	li	s3,0
 5e0:	b5c9                	j	4a2 <vprintf+0x42>
        putc(fd, c);
 5e2:	02500593          	li	a1,37
 5e6:	8556                	mv	a0,s5
 5e8:	00000097          	auipc	ra,0x0
 5ec:	dae080e7          	jalr	-594(ra) # 396 <putc>
      state = 0;
 5f0:	4981                	li	s3,0
 5f2:	bd45                	j	4a2 <vprintf+0x42>
        putc(fd, '%');
 5f4:	02500593          	li	a1,37
 5f8:	8556                	mv	a0,s5
 5fa:	00000097          	auipc	ra,0x0
 5fe:	d9c080e7          	jalr	-612(ra) # 396 <putc>
        putc(fd, c);
 602:	85ca                	mv	a1,s2
 604:	8556                	mv	a0,s5
 606:	00000097          	auipc	ra,0x0
 60a:	d90080e7          	jalr	-624(ra) # 396 <putc>
      state = 0;
 60e:	4981                	li	s3,0
 610:	bd49                	j	4a2 <vprintf+0x42>
        s = va_arg(ap, char*);
 612:	8bce                	mv	s7,s3
      state = 0;
 614:	4981                	li	s3,0
 616:	b571                	j	4a2 <vprintf+0x42>
 618:	74e2                	ld	s1,56(sp)
 61a:	79a2                	ld	s3,40(sp)
 61c:	7a02                	ld	s4,32(sp)
 61e:	6ae2                	ld	s5,24(sp)
 620:	6b42                	ld	s6,16(sp)
 622:	6ba2                	ld	s7,8(sp)
    }
  }
}
 624:	60a6                	ld	ra,72(sp)
 626:	6406                	ld	s0,64(sp)
 628:	7942                	ld	s2,48(sp)
 62a:	6161                	addi	sp,sp,80
 62c:	8082                	ret

000000000000062e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 62e:	715d                	addi	sp,sp,-80
 630:	ec06                	sd	ra,24(sp)
 632:	e822                	sd	s0,16(sp)
 634:	1000                	addi	s0,sp,32
 636:	e010                	sd	a2,0(s0)
 638:	e414                	sd	a3,8(s0)
 63a:	e818                	sd	a4,16(s0)
 63c:	ec1c                	sd	a5,24(s0)
 63e:	03043023          	sd	a6,32(s0)
 642:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 646:	8622                	mv	a2,s0
 648:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 64c:	00000097          	auipc	ra,0x0
 650:	e14080e7          	jalr	-492(ra) # 460 <vprintf>
}
 654:	60e2                	ld	ra,24(sp)
 656:	6442                	ld	s0,16(sp)
 658:	6161                	addi	sp,sp,80
 65a:	8082                	ret

000000000000065c <printf>:

void
printf(const char *fmt, ...)
{
 65c:	711d                	addi	sp,sp,-96
 65e:	ec06                	sd	ra,24(sp)
 660:	e822                	sd	s0,16(sp)
 662:	1000                	addi	s0,sp,32
 664:	e40c                	sd	a1,8(s0)
 666:	e810                	sd	a2,16(s0)
 668:	ec14                	sd	a3,24(s0)
 66a:	f018                	sd	a4,32(s0)
 66c:	f41c                	sd	a5,40(s0)
 66e:	03043823          	sd	a6,48(s0)
 672:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 676:	00840613          	addi	a2,s0,8
 67a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 67e:	85aa                	mv	a1,a0
 680:	4505                	li	a0,1
 682:	00000097          	auipc	ra,0x0
 686:	dde080e7          	jalr	-546(ra) # 460 <vprintf>
}
 68a:	60e2                	ld	ra,24(sp)
 68c:	6442                	ld	s0,16(sp)
 68e:	6125                	addi	sp,sp,96
 690:	8082                	ret

0000000000000692 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 692:	1141                	addi	sp,sp,-16
 694:	e406                	sd	ra,8(sp)
 696:	e022                	sd	s0,0(sp)
 698:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 69a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 69e:	00000797          	auipc	a5,0x0
 6a2:	5f27b783          	ld	a5,1522(a5) # c90 <freep>
 6a6:	a039                	j	6b4 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a8:	6398                	ld	a4,0(a5)
 6aa:	00e7e463          	bltu	a5,a4,6b2 <free+0x20>
 6ae:	00e6ea63          	bltu	a3,a4,6c2 <free+0x30>
{
 6b2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b4:	fed7fae3          	bgeu	a5,a3,6a8 <free+0x16>
 6b8:	6398                	ld	a4,0(a5)
 6ba:	00e6e463          	bltu	a3,a4,6c2 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6be:	fee7eae3          	bltu	a5,a4,6b2 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c2:	ff852583          	lw	a1,-8(a0)
 6c6:	6390                	ld	a2,0(a5)
 6c8:	02059813          	slli	a6,a1,0x20
 6cc:	01c85713          	srli	a4,a6,0x1c
 6d0:	9736                	add	a4,a4,a3
 6d2:	02e60563          	beq	a2,a4,6fc <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 6d6:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6da:	4790                	lw	a2,8(a5)
 6dc:	02061593          	slli	a1,a2,0x20
 6e0:	01c5d713          	srli	a4,a1,0x1c
 6e4:	973e                	add	a4,a4,a5
 6e6:	02e68263          	beq	a3,a4,70a <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 6ea:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 6ec:	00000717          	auipc	a4,0x0
 6f0:	5af73223          	sd	a5,1444(a4) # c90 <freep>
}
 6f4:	60a2                	ld	ra,8(sp)
 6f6:	6402                	ld	s0,0(sp)
 6f8:	0141                	addi	sp,sp,16
 6fa:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 6fc:	4618                	lw	a4,8(a2)
 6fe:	9f2d                	addw	a4,a4,a1
 700:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 704:	6398                	ld	a4,0(a5)
 706:	6310                	ld	a2,0(a4)
 708:	b7f9                	j	6d6 <free+0x44>
    p->s.size += bp->s.size;
 70a:	ff852703          	lw	a4,-8(a0)
 70e:	9f31                	addw	a4,a4,a2
 710:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 712:	ff053683          	ld	a3,-16(a0)
 716:	bfd1                	j	6ea <free+0x58>

0000000000000718 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 718:	7139                	addi	sp,sp,-64
 71a:	fc06                	sd	ra,56(sp)
 71c:	f822                	sd	s0,48(sp)
 71e:	f04a                	sd	s2,32(sp)
 720:	ec4e                	sd	s3,24(sp)
 722:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 724:	02051993          	slli	s3,a0,0x20
 728:	0209d993          	srli	s3,s3,0x20
 72c:	09bd                	addi	s3,s3,15
 72e:	0049d993          	srli	s3,s3,0x4
 732:	2985                	addiw	s3,s3,1
 734:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 736:	00000517          	auipc	a0,0x0
 73a:	55a53503          	ld	a0,1370(a0) # c90 <freep>
 73e:	c905                	beqz	a0,76e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 740:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 742:	4798                	lw	a4,8(a5)
 744:	09377a63          	bgeu	a4,s3,7d8 <malloc+0xc0>
 748:	f426                	sd	s1,40(sp)
 74a:	e852                	sd	s4,16(sp)
 74c:	e456                	sd	s5,8(sp)
 74e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 750:	8a4e                	mv	s4,s3
 752:	6705                	lui	a4,0x1
 754:	00e9f363          	bgeu	s3,a4,75a <malloc+0x42>
 758:	6a05                	lui	s4,0x1
 75a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 75e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 762:	00000497          	auipc	s1,0x0
 766:	52e48493          	addi	s1,s1,1326 # c90 <freep>
  if(p == (char*)-1)
 76a:	5afd                	li	s5,-1
 76c:	a089                	j	7ae <malloc+0x96>
 76e:	f426                	sd	s1,40(sp)
 770:	e852                	sd	s4,16(sp)
 772:	e456                	sd	s5,8(sp)
 774:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 776:	00000797          	auipc	a5,0x0
 77a:	52278793          	addi	a5,a5,1314 # c98 <base>
 77e:	00000717          	auipc	a4,0x0
 782:	50f73923          	sd	a5,1298(a4) # c90 <freep>
 786:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 788:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 78c:	b7d1                	j	750 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 78e:	6398                	ld	a4,0(a5)
 790:	e118                	sd	a4,0(a0)
 792:	a8b9                	j	7f0 <malloc+0xd8>
  hp->s.size = nu;
 794:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 798:	0541                	addi	a0,a0,16
 79a:	00000097          	auipc	ra,0x0
 79e:	ef8080e7          	jalr	-264(ra) # 692 <free>
  return freep;
 7a2:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 7a4:	c135                	beqz	a0,808 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7a8:	4798                	lw	a4,8(a5)
 7aa:	03277363          	bgeu	a4,s2,7d0 <malloc+0xb8>
    if(p == freep)
 7ae:	6098                	ld	a4,0(s1)
 7b0:	853e                	mv	a0,a5
 7b2:	fef71ae3          	bne	a4,a5,7a6 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 7b6:	8552                	mv	a0,s4
 7b8:	00000097          	auipc	ra,0x0
 7bc:	bc6080e7          	jalr	-1082(ra) # 37e <sbrk>
  if(p == (char*)-1)
 7c0:	fd551ae3          	bne	a0,s5,794 <malloc+0x7c>
        return 0;
 7c4:	4501                	li	a0,0
 7c6:	74a2                	ld	s1,40(sp)
 7c8:	6a42                	ld	s4,16(sp)
 7ca:	6aa2                	ld	s5,8(sp)
 7cc:	6b02                	ld	s6,0(sp)
 7ce:	a03d                	j	7fc <malloc+0xe4>
 7d0:	74a2                	ld	s1,40(sp)
 7d2:	6a42                	ld	s4,16(sp)
 7d4:	6aa2                	ld	s5,8(sp)
 7d6:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 7d8:	fae90be3          	beq	s2,a4,78e <malloc+0x76>
        p->s.size -= nunits;
 7dc:	4137073b          	subw	a4,a4,s3
 7e0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7e2:	02071693          	slli	a3,a4,0x20
 7e6:	01c6d713          	srli	a4,a3,0x1c
 7ea:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7ec:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7f0:	00000717          	auipc	a4,0x0
 7f4:	4aa73023          	sd	a0,1184(a4) # c90 <freep>
      return (void*)(p + 1);
 7f8:	01078513          	addi	a0,a5,16
  }
}
 7fc:	70e2                	ld	ra,56(sp)
 7fe:	7442                	ld	s0,48(sp)
 800:	7902                	ld	s2,32(sp)
 802:	69e2                	ld	s3,24(sp)
 804:	6121                	addi	sp,sp,64
 806:	8082                	ret
 808:	74a2                	ld	s1,40(sp)
 80a:	6a42                	ld	s4,16(sp)
 80c:	6aa2                	ld	s5,8(sp)
 80e:	6b02                	ld	s6,0(sp)
 810:	b7f5                	j	7fc <malloc+0xe4>
