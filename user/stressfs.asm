
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dc010113          	addi	sp,sp,-576
   4:	22113c23          	sd	ra,568(sp)
   8:	22813823          	sd	s0,560(sp)
   c:	22913423          	sd	s1,552(sp)
  10:	23213023          	sd	s2,544(sp)
  14:	21313c23          	sd	s3,536(sp)
  18:	21413823          	sd	s4,528(sp)
  1c:	0480                	addi	s0,sp,576
  int fd, i;
  char path[] = "stressfs0";
  1e:	00001797          	auipc	a5,0x1
  22:	8da78793          	addi	a5,a5,-1830 # 8f8 <malloc+0x12c>
  26:	6398                	ld	a4,0(a5)
  28:	fce43023          	sd	a4,-64(s0)
  2c:	0087d783          	lhu	a5,8(a5)
  30:	fcf41423          	sh	a5,-56(s0)
  char data[512];

  printf("stressfs starting\n");
  34:	00001517          	auipc	a0,0x1
  38:	89450513          	addi	a0,a0,-1900 # 8c8 <malloc+0xfc>
  3c:	00000097          	auipc	ra,0x0
  40:	6d4080e7          	jalr	1748(ra) # 710 <printf>
  memset(data, 'a', sizeof(data));
  44:	20000613          	li	a2,512
  48:	06100593          	li	a1,97
  4c:	dc040513          	addi	a0,s0,-576
  50:	00000097          	auipc	ra,0x0
  54:	148080e7          	jalr	328(ra) # 198 <memset>

  for(i = 0; i < 4; i++)
  58:	4481                	li	s1,0
  5a:	4911                	li	s2,4
    if(fork() > 0)
  5c:	00000097          	auipc	ra,0x0
  60:	346080e7          	jalr	838(ra) # 3a2 <fork>
  64:	00a04563          	bgtz	a0,6e <main+0x6e>
  for(i = 0; i < 4; i++)
  68:	2485                	addiw	s1,s1,1
  6a:	ff2499e3          	bne	s1,s2,5c <main+0x5c>
      break;

  printf("write %d\n", i);
  6e:	85a6                	mv	a1,s1
  70:	00001517          	auipc	a0,0x1
  74:	87050513          	addi	a0,a0,-1936 # 8e0 <malloc+0x114>
  78:	00000097          	auipc	ra,0x0
  7c:	698080e7          	jalr	1688(ra) # 710 <printf>

  path[8] += i;
  80:	fc844783          	lbu	a5,-56(s0)
  84:	9fa5                	addw	a5,a5,s1
  86:	fcf40423          	sb	a5,-56(s0)
  fd = open(path, O_CREATE | O_RDWR);
  8a:	20200593          	li	a1,514
  8e:	fc040513          	addi	a0,s0,-64
  92:	00000097          	auipc	ra,0x0
  96:	358080e7          	jalr	856(ra) # 3ea <open>
  9a:	892a                	mv	s2,a0
  9c:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  9e:	dc040a13          	addi	s4,s0,-576
  a2:	20000993          	li	s3,512
  a6:	864e                	mv	a2,s3
  a8:	85d2                	mv	a1,s4
  aa:	854a                	mv	a0,s2
  ac:	00000097          	auipc	ra,0x0
  b0:	31e080e7          	jalr	798(ra) # 3ca <write>
  for(i = 0; i < 20; i++)
  b4:	34fd                	addiw	s1,s1,-1
  b6:	f8e5                	bnez	s1,a6 <main+0xa6>
  close(fd);
  b8:	854a                	mv	a0,s2
  ba:	00000097          	auipc	ra,0x0
  be:	318080e7          	jalr	792(ra) # 3d2 <close>

  printf("read\n");
  c2:	00001517          	auipc	a0,0x1
  c6:	82e50513          	addi	a0,a0,-2002 # 8f0 <malloc+0x124>
  ca:	00000097          	auipc	ra,0x0
  ce:	646080e7          	jalr	1606(ra) # 710 <printf>

  fd = open(path, O_RDONLY);
  d2:	4581                	li	a1,0
  d4:	fc040513          	addi	a0,s0,-64
  d8:	00000097          	auipc	ra,0x0
  dc:	312080e7          	jalr	786(ra) # 3ea <open>
  e0:	892a                	mv	s2,a0
  e2:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  e4:	dc040a13          	addi	s4,s0,-576
  e8:	20000993          	li	s3,512
  ec:	864e                	mv	a2,s3
  ee:	85d2                	mv	a1,s4
  f0:	854a                	mv	a0,s2
  f2:	00000097          	auipc	ra,0x0
  f6:	2d0080e7          	jalr	720(ra) # 3c2 <read>
  for (i = 0; i < 20; i++)
  fa:	34fd                	addiw	s1,s1,-1
  fc:	f8e5                	bnez	s1,ec <main+0xec>
  close(fd);
  fe:	854a                	mv	a0,s2
 100:	00000097          	auipc	ra,0x0
 104:	2d2080e7          	jalr	722(ra) # 3d2 <close>

  wait(0);
 108:	4501                	li	a0,0
 10a:	00000097          	auipc	ra,0x0
 10e:	2a8080e7          	jalr	680(ra) # 3b2 <wait>

  exit(0);
 112:	4501                	li	a0,0
 114:	00000097          	auipc	ra,0x0
 118:	296080e7          	jalr	662(ra) # 3aa <exit>

000000000000011c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e406                	sd	ra,8(sp)
 120:	e022                	sd	s0,0(sp)
 122:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 124:	87aa                	mv	a5,a0
 126:	0585                	addi	a1,a1,1
 128:	0785                	addi	a5,a5,1
 12a:	fff5c703          	lbu	a4,-1(a1)
 12e:	fee78fa3          	sb	a4,-1(a5)
 132:	fb75                	bnez	a4,126 <strcpy+0xa>
    ;
  return os;
}
 134:	60a2                	ld	ra,8(sp)
 136:	6402                	ld	s0,0(sp)
 138:	0141                	addi	sp,sp,16
 13a:	8082                	ret

000000000000013c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13c:	1141                	addi	sp,sp,-16
 13e:	e406                	sd	ra,8(sp)
 140:	e022                	sd	s0,0(sp)
 142:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 144:	00054783          	lbu	a5,0(a0)
 148:	cb91                	beqz	a5,15c <strcmp+0x20>
 14a:	0005c703          	lbu	a4,0(a1)
 14e:	00f71763          	bne	a4,a5,15c <strcmp+0x20>
    p++, q++;
 152:	0505                	addi	a0,a0,1
 154:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 156:	00054783          	lbu	a5,0(a0)
 15a:	fbe5                	bnez	a5,14a <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 15c:	0005c503          	lbu	a0,0(a1)
}
 160:	40a7853b          	subw	a0,a5,a0
 164:	60a2                	ld	ra,8(sp)
 166:	6402                	ld	s0,0(sp)
 168:	0141                	addi	sp,sp,16
 16a:	8082                	ret

000000000000016c <strlen>:

uint
strlen(const char *s)
{
 16c:	1141                	addi	sp,sp,-16
 16e:	e406                	sd	ra,8(sp)
 170:	e022                	sd	s0,0(sp)
 172:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 174:	00054783          	lbu	a5,0(a0)
 178:	cf91                	beqz	a5,194 <strlen+0x28>
 17a:	00150793          	addi	a5,a0,1
 17e:	86be                	mv	a3,a5
 180:	0785                	addi	a5,a5,1
 182:	fff7c703          	lbu	a4,-1(a5)
 186:	ff65                	bnez	a4,17e <strlen+0x12>
 188:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 18c:	60a2                	ld	ra,8(sp)
 18e:	6402                	ld	s0,0(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret
  for(n = 0; s[n]; n++)
 194:	4501                	li	a0,0
 196:	bfdd                	j	18c <strlen+0x20>

0000000000000198 <memset>:

void*
memset(void *dst, int c, uint n)
{
 198:	1141                	addi	sp,sp,-16
 19a:	e406                	sd	ra,8(sp)
 19c:	e022                	sd	s0,0(sp)
 19e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1a0:	ca19                	beqz	a2,1b6 <memset+0x1e>
 1a2:	87aa                	mv	a5,a0
 1a4:	1602                	slli	a2,a2,0x20
 1a6:	9201                	srli	a2,a2,0x20
 1a8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1ac:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1b0:	0785                	addi	a5,a5,1
 1b2:	fee79de3          	bne	a5,a4,1ac <memset+0x14>
  }
  return dst;
}
 1b6:	60a2                	ld	ra,8(sp)
 1b8:	6402                	ld	s0,0(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strchr>:

char*
strchr(const char *s, char c)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e406                	sd	ra,8(sp)
 1c2:	e022                	sd	s0,0(sp)
 1c4:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cf81                	beqz	a5,1e2 <strchr+0x24>
    if(*s == c)
 1cc:	00f58763          	beq	a1,a5,1da <strchr+0x1c>
  for(; *s; s++)
 1d0:	0505                	addi	a0,a0,1
 1d2:	00054783          	lbu	a5,0(a0)
 1d6:	fbfd                	bnez	a5,1cc <strchr+0xe>
      return (char*)s;
  return 0;
 1d8:	4501                	li	a0,0
}
 1da:	60a2                	ld	ra,8(sp)
 1dc:	6402                	ld	s0,0(sp)
 1de:	0141                	addi	sp,sp,16
 1e0:	8082                	ret
  return 0;
 1e2:	4501                	li	a0,0
 1e4:	bfdd                	j	1da <strchr+0x1c>

00000000000001e6 <gets>:

char*
gets(char *buf, int max)
{
 1e6:	711d                	addi	sp,sp,-96
 1e8:	ec86                	sd	ra,88(sp)
 1ea:	e8a2                	sd	s0,80(sp)
 1ec:	e4a6                	sd	s1,72(sp)
 1ee:	e0ca                	sd	s2,64(sp)
 1f0:	fc4e                	sd	s3,56(sp)
 1f2:	f852                	sd	s4,48(sp)
 1f4:	f456                	sd	s5,40(sp)
 1f6:	f05a                	sd	s6,32(sp)
 1f8:	ec5e                	sd	s7,24(sp)
 1fa:	e862                	sd	s8,16(sp)
 1fc:	1080                	addi	s0,sp,96
 1fe:	8baa                	mv	s7,a0
 200:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 202:	892a                	mv	s2,a0
 204:	4481                	li	s1,0
    cc = read(0, &c, 1);
 206:	faf40b13          	addi	s6,s0,-81
 20a:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 20c:	8c26                	mv	s8,s1
 20e:	0014899b          	addiw	s3,s1,1
 212:	84ce                	mv	s1,s3
 214:	0349d663          	bge	s3,s4,240 <gets+0x5a>
    cc = read(0, &c, 1);
 218:	8656                	mv	a2,s5
 21a:	85da                	mv	a1,s6
 21c:	4501                	li	a0,0
 21e:	00000097          	auipc	ra,0x0
 222:	1a4080e7          	jalr	420(ra) # 3c2 <read>
    if(cc < 1)
 226:	00a05d63          	blez	a0,240 <gets+0x5a>
      break;
    buf[i++] = c;
 22a:	faf44783          	lbu	a5,-81(s0)
 22e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 232:	0905                	addi	s2,s2,1
 234:	ff678713          	addi	a4,a5,-10
 238:	c319                	beqz	a4,23e <gets+0x58>
 23a:	17cd                	addi	a5,a5,-13
 23c:	fbe1                	bnez	a5,20c <gets+0x26>
    buf[i++] = c;
 23e:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 240:	9c5e                	add	s8,s8,s7
 242:	000c0023          	sb	zero,0(s8)
  return buf;
}
 246:	855e                	mv	a0,s7
 248:	60e6                	ld	ra,88(sp)
 24a:	6446                	ld	s0,80(sp)
 24c:	64a6                	ld	s1,72(sp)
 24e:	6906                	ld	s2,64(sp)
 250:	79e2                	ld	s3,56(sp)
 252:	7a42                	ld	s4,48(sp)
 254:	7aa2                	ld	s5,40(sp)
 256:	7b02                	ld	s6,32(sp)
 258:	6be2                	ld	s7,24(sp)
 25a:	6c42                	ld	s8,16(sp)
 25c:	6125                	addi	sp,sp,96
 25e:	8082                	ret

0000000000000260 <stat>:

int
stat(const char *n, struct stat *st)
{
 260:	1101                	addi	sp,sp,-32
 262:	ec06                	sd	ra,24(sp)
 264:	e822                	sd	s0,16(sp)
 266:	e04a                	sd	s2,0(sp)
 268:	1000                	addi	s0,sp,32
 26a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 26c:	4581                	li	a1,0
 26e:	00000097          	auipc	ra,0x0
 272:	17c080e7          	jalr	380(ra) # 3ea <open>
  if(fd < 0)
 276:	02054663          	bltz	a0,2a2 <stat+0x42>
 27a:	e426                	sd	s1,8(sp)
 27c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 27e:	85ca                	mv	a1,s2
 280:	00000097          	auipc	ra,0x0
 284:	182080e7          	jalr	386(ra) # 402 <fstat>
 288:	892a                	mv	s2,a0
  close(fd);
 28a:	8526                	mv	a0,s1
 28c:	00000097          	auipc	ra,0x0
 290:	146080e7          	jalr	326(ra) # 3d2 <close>
  return r;
 294:	64a2                	ld	s1,8(sp)
}
 296:	854a                	mv	a0,s2
 298:	60e2                	ld	ra,24(sp)
 29a:	6442                	ld	s0,16(sp)
 29c:	6902                	ld	s2,0(sp)
 29e:	6105                	addi	sp,sp,32
 2a0:	8082                	ret
    return -1;
 2a2:	57fd                	li	a5,-1
 2a4:	893e                	mv	s2,a5
 2a6:	bfc5                	j	296 <stat+0x36>

00000000000002a8 <atoi>:

int
atoi(const char *s)
{
 2a8:	1141                	addi	sp,sp,-16
 2aa:	e406                	sd	ra,8(sp)
 2ac:	e022                	sd	s0,0(sp)
 2ae:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b0:	00054683          	lbu	a3,0(a0)
 2b4:	fd06879b          	addiw	a5,a3,-48
 2b8:	0ff7f793          	zext.b	a5,a5
 2bc:	4625                	li	a2,9
 2be:	02f66963          	bltu	a2,a5,2f0 <atoi+0x48>
 2c2:	872a                	mv	a4,a0
  n = 0;
 2c4:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2c6:	0705                	addi	a4,a4,1
 2c8:	0025179b          	slliw	a5,a0,0x2
 2cc:	9fa9                	addw	a5,a5,a0
 2ce:	0017979b          	slliw	a5,a5,0x1
 2d2:	9fb5                	addw	a5,a5,a3
 2d4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2d8:	00074683          	lbu	a3,0(a4)
 2dc:	fd06879b          	addiw	a5,a3,-48
 2e0:	0ff7f793          	zext.b	a5,a5
 2e4:	fef671e3          	bgeu	a2,a5,2c6 <atoi+0x1e>
  return n;
}
 2e8:	60a2                	ld	ra,8(sp)
 2ea:	6402                	ld	s0,0(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret
  n = 0;
 2f0:	4501                	li	a0,0
 2f2:	bfdd                	j	2e8 <atoi+0x40>

00000000000002f4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f4:	1141                	addi	sp,sp,-16
 2f6:	e406                	sd	ra,8(sp)
 2f8:	e022                	sd	s0,0(sp)
 2fa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2fc:	02b57563          	bgeu	a0,a1,326 <memmove+0x32>
    while(n-- > 0)
 300:	00c05f63          	blez	a2,31e <memmove+0x2a>
 304:	1602                	slli	a2,a2,0x20
 306:	9201                	srli	a2,a2,0x20
 308:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 30c:	872a                	mv	a4,a0
      *dst++ = *src++;
 30e:	0585                	addi	a1,a1,1
 310:	0705                	addi	a4,a4,1
 312:	fff5c683          	lbu	a3,-1(a1)
 316:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 31a:	fee79ae3          	bne	a5,a4,30e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 31e:	60a2                	ld	ra,8(sp)
 320:	6402                	ld	s0,0(sp)
 322:	0141                	addi	sp,sp,16
 324:	8082                	ret
    while(n-- > 0)
 326:	fec05ce3          	blez	a2,31e <memmove+0x2a>
    dst += n;
 32a:	00c50733          	add	a4,a0,a2
    src += n;
 32e:	95b2                	add	a1,a1,a2
 330:	fff6079b          	addiw	a5,a2,-1
 334:	1782                	slli	a5,a5,0x20
 336:	9381                	srli	a5,a5,0x20
 338:	fff7c793          	not	a5,a5
 33c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 33e:	15fd                	addi	a1,a1,-1
 340:	177d                	addi	a4,a4,-1
 342:	0005c683          	lbu	a3,0(a1)
 346:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 34a:	fef71ae3          	bne	a4,a5,33e <memmove+0x4a>
 34e:	bfc1                	j	31e <memmove+0x2a>

0000000000000350 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 350:	1141                	addi	sp,sp,-16
 352:	e406                	sd	ra,8(sp)
 354:	e022                	sd	s0,0(sp)
 356:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 358:	c61d                	beqz	a2,386 <memcmp+0x36>
 35a:	1602                	slli	a2,a2,0x20
 35c:	9201                	srli	a2,a2,0x20
 35e:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 362:	00054783          	lbu	a5,0(a0)
 366:	0005c703          	lbu	a4,0(a1)
 36a:	00e79863          	bne	a5,a4,37a <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 36e:	0505                	addi	a0,a0,1
    p2++;
 370:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 372:	fed518e3          	bne	a0,a3,362 <memcmp+0x12>
  }
  return 0;
 376:	4501                	li	a0,0
 378:	a019                	j	37e <memcmp+0x2e>
      return *p1 - *p2;
 37a:	40e7853b          	subw	a0,a5,a4
}
 37e:	60a2                	ld	ra,8(sp)
 380:	6402                	ld	s0,0(sp)
 382:	0141                	addi	sp,sp,16
 384:	8082                	ret
  return 0;
 386:	4501                	li	a0,0
 388:	bfdd                	j	37e <memcmp+0x2e>

000000000000038a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 38a:	1141                	addi	sp,sp,-16
 38c:	e406                	sd	ra,8(sp)
 38e:	e022                	sd	s0,0(sp)
 390:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 392:	00000097          	auipc	ra,0x0
 396:	f62080e7          	jalr	-158(ra) # 2f4 <memmove>
}
 39a:	60a2                	ld	ra,8(sp)
 39c:	6402                	ld	s0,0(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret

00000000000003a2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3a2:	4885                	li	a7,1
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <exit>:
.global exit
exit:
 li a7, SYS_exit
 3aa:	4889                	li	a7,2
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b2:	488d                	li	a7,3
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ba:	4891                	li	a7,4
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <read>:
.global read
read:
 li a7, SYS_read
 3c2:	4895                	li	a7,5
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <write>:
.global write
write:
 li a7, SYS_write
 3ca:	48c1                	li	a7,16
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <close>:
.global close
close:
 li a7, SYS_close
 3d2:	48d5                	li	a7,21
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <kill>:
.global kill
kill:
 li a7, SYS_kill
 3da:	4899                	li	a7,6
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3e2:	489d                	li	a7,7
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <open>:
.global open
open:
 li a7, SYS_open
 3ea:	48bd                	li	a7,15
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3f2:	48c5                	li	a7,17
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3fa:	48c9                	li	a7,18
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 402:	48a1                	li	a7,8
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <link>:
.global link
link:
 li a7, SYS_link
 40a:	48cd                	li	a7,19
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 412:	48d1                	li	a7,20
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 41a:	48a5                	li	a7,9
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <dup>:
.global dup
dup:
 li a7, SYS_dup
 422:	48a9                	li	a7,10
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 42a:	48ad                	li	a7,11
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 432:	48b1                	li	a7,12
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 43a:	48b5                	li	a7,13
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 442:	48b9                	li	a7,14
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 44a:	1101                	addi	sp,sp,-32
 44c:	ec06                	sd	ra,24(sp)
 44e:	e822                	sd	s0,16(sp)
 450:	1000                	addi	s0,sp,32
 452:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 456:	4605                	li	a2,1
 458:	fef40593          	addi	a1,s0,-17
 45c:	00000097          	auipc	ra,0x0
 460:	f6e080e7          	jalr	-146(ra) # 3ca <write>
}
 464:	60e2                	ld	ra,24(sp)
 466:	6442                	ld	s0,16(sp)
 468:	6105                	addi	sp,sp,32
 46a:	8082                	ret

000000000000046c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 46c:	7139                	addi	sp,sp,-64
 46e:	fc06                	sd	ra,56(sp)
 470:	f822                	sd	s0,48(sp)
 472:	f04a                	sd	s2,32(sp)
 474:	ec4e                	sd	s3,24(sp)
 476:	0080                	addi	s0,sp,64
 478:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 47a:	cad9                	beqz	a3,510 <printint+0xa4>
 47c:	01f5d79b          	srliw	a5,a1,0x1f
 480:	cbc1                	beqz	a5,510 <printint+0xa4>
    neg = 1;
    x = -xx;
 482:	40b005bb          	negw	a1,a1
    neg = 1;
 486:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 488:	fc040993          	addi	s3,s0,-64
  neg = 0;
 48c:	86ce                	mv	a3,s3
  i = 0;
 48e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 490:	00000817          	auipc	a6,0x0
 494:	4d880813          	addi	a6,a6,1240 # 968 <digits>
 498:	88ba                	mv	a7,a4
 49a:	0017051b          	addiw	a0,a4,1
 49e:	872a                	mv	a4,a0
 4a0:	02c5f7bb          	remuw	a5,a1,a2
 4a4:	1782                	slli	a5,a5,0x20
 4a6:	9381                	srli	a5,a5,0x20
 4a8:	97c2                	add	a5,a5,a6
 4aa:	0007c783          	lbu	a5,0(a5)
 4ae:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 4b2:	87ae                	mv	a5,a1
 4b4:	02c5d5bb          	divuw	a1,a1,a2
 4b8:	0685                	addi	a3,a3,1
 4ba:	fcc7ffe3          	bgeu	a5,a2,498 <printint+0x2c>
  if(neg)
 4be:	00030c63          	beqz	t1,4d6 <printint+0x6a>
    buf[i++] = '-';
 4c2:	fd050793          	addi	a5,a0,-48
 4c6:	00878533          	add	a0,a5,s0
 4ca:	02d00793          	li	a5,45
 4ce:	fef50823          	sb	a5,-16(a0)
 4d2:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 4d6:	02e05763          	blez	a4,504 <printint+0x98>
 4da:	f426                	sd	s1,40(sp)
 4dc:	377d                	addiw	a4,a4,-1
 4de:	00e984b3          	add	s1,s3,a4
 4e2:	19fd                	addi	s3,s3,-1
 4e4:	99ba                	add	s3,s3,a4
 4e6:	1702                	slli	a4,a4,0x20
 4e8:	9301                	srli	a4,a4,0x20
 4ea:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4ee:	0004c583          	lbu	a1,0(s1)
 4f2:	854a                	mv	a0,s2
 4f4:	00000097          	auipc	ra,0x0
 4f8:	f56080e7          	jalr	-170(ra) # 44a <putc>
  while(--i >= 0)
 4fc:	14fd                	addi	s1,s1,-1
 4fe:	ff3498e3          	bne	s1,s3,4ee <printint+0x82>
 502:	74a2                	ld	s1,40(sp)
}
 504:	70e2                	ld	ra,56(sp)
 506:	7442                	ld	s0,48(sp)
 508:	7902                	ld	s2,32(sp)
 50a:	69e2                	ld	s3,24(sp)
 50c:	6121                	addi	sp,sp,64
 50e:	8082                	ret
  neg = 0;
 510:	4301                	li	t1,0
 512:	bf9d                	j	488 <printint+0x1c>

0000000000000514 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 514:	715d                	addi	sp,sp,-80
 516:	e486                	sd	ra,72(sp)
 518:	e0a2                	sd	s0,64(sp)
 51a:	f84a                	sd	s2,48(sp)
 51c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 51e:	0005c903          	lbu	s2,0(a1)
 522:	1a090b63          	beqz	s2,6d8 <vprintf+0x1c4>
 526:	fc26                	sd	s1,56(sp)
 528:	f44e                	sd	s3,40(sp)
 52a:	f052                	sd	s4,32(sp)
 52c:	ec56                	sd	s5,24(sp)
 52e:	e85a                	sd	s6,16(sp)
 530:	e45e                	sd	s7,8(sp)
 532:	8aaa                	mv	s5,a0
 534:	8bb2                	mv	s7,a2
 536:	00158493          	addi	s1,a1,1
  state = 0;
 53a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 53c:	02500a13          	li	s4,37
 540:	4b55                	li	s6,21
 542:	a839                	j	560 <vprintf+0x4c>
        putc(fd, c);
 544:	85ca                	mv	a1,s2
 546:	8556                	mv	a0,s5
 548:	00000097          	auipc	ra,0x0
 54c:	f02080e7          	jalr	-254(ra) # 44a <putc>
 550:	a019                	j	556 <vprintf+0x42>
    } else if(state == '%'){
 552:	01498d63          	beq	s3,s4,56c <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 556:	0485                	addi	s1,s1,1
 558:	fff4c903          	lbu	s2,-1(s1)
 55c:	16090863          	beqz	s2,6cc <vprintf+0x1b8>
    if(state == 0){
 560:	fe0999e3          	bnez	s3,552 <vprintf+0x3e>
      if(c == '%'){
 564:	ff4910e3          	bne	s2,s4,544 <vprintf+0x30>
        state = '%';
 568:	89d2                	mv	s3,s4
 56a:	b7f5                	j	556 <vprintf+0x42>
      if(c == 'd'){
 56c:	13490563          	beq	s2,s4,696 <vprintf+0x182>
 570:	f9d9079b          	addiw	a5,s2,-99
 574:	0ff7f793          	zext.b	a5,a5
 578:	12fb6863          	bltu	s6,a5,6a8 <vprintf+0x194>
 57c:	f9d9079b          	addiw	a5,s2,-99
 580:	0ff7f713          	zext.b	a4,a5
 584:	12eb6263          	bltu	s6,a4,6a8 <vprintf+0x194>
 588:	00271793          	slli	a5,a4,0x2
 58c:	00000717          	auipc	a4,0x0
 590:	38470713          	addi	a4,a4,900 # 910 <malloc+0x144>
 594:	97ba                	add	a5,a5,a4
 596:	439c                	lw	a5,0(a5)
 598:	97ba                	add	a5,a5,a4
 59a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 59c:	008b8913          	addi	s2,s7,8
 5a0:	4685                	li	a3,1
 5a2:	4629                	li	a2,10
 5a4:	000ba583          	lw	a1,0(s7)
 5a8:	8556                	mv	a0,s5
 5aa:	00000097          	auipc	ra,0x0
 5ae:	ec2080e7          	jalr	-318(ra) # 46c <printint>
 5b2:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	b745                	j	556 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5b8:	008b8913          	addi	s2,s7,8
 5bc:	4681                	li	a3,0
 5be:	4629                	li	a2,10
 5c0:	000ba583          	lw	a1,0(s7)
 5c4:	8556                	mv	a0,s5
 5c6:	00000097          	auipc	ra,0x0
 5ca:	ea6080e7          	jalr	-346(ra) # 46c <printint>
 5ce:	8bca                	mv	s7,s2
      state = 0;
 5d0:	4981                	li	s3,0
 5d2:	b751                	j	556 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 5d4:	008b8913          	addi	s2,s7,8
 5d8:	4681                	li	a3,0
 5da:	4641                	li	a2,16
 5dc:	000ba583          	lw	a1,0(s7)
 5e0:	8556                	mv	a0,s5
 5e2:	00000097          	auipc	ra,0x0
 5e6:	e8a080e7          	jalr	-374(ra) # 46c <printint>
 5ea:	8bca                	mv	s7,s2
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	b7a5                	j	556 <vprintf+0x42>
 5f0:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 5f2:	008b8793          	addi	a5,s7,8
 5f6:	8c3e                	mv	s8,a5
 5f8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 5fc:	03000593          	li	a1,48
 600:	8556                	mv	a0,s5
 602:	00000097          	auipc	ra,0x0
 606:	e48080e7          	jalr	-440(ra) # 44a <putc>
  putc(fd, 'x');
 60a:	07800593          	li	a1,120
 60e:	8556                	mv	a0,s5
 610:	00000097          	auipc	ra,0x0
 614:	e3a080e7          	jalr	-454(ra) # 44a <putc>
 618:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 61a:	00000b97          	auipc	s7,0x0
 61e:	34eb8b93          	addi	s7,s7,846 # 968 <digits>
 622:	03c9d793          	srli	a5,s3,0x3c
 626:	97de                	add	a5,a5,s7
 628:	0007c583          	lbu	a1,0(a5)
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	e1c080e7          	jalr	-484(ra) # 44a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 636:	0992                	slli	s3,s3,0x4
 638:	397d                	addiw	s2,s2,-1
 63a:	fe0914e3          	bnez	s2,622 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 63e:	8be2                	mv	s7,s8
      state = 0;
 640:	4981                	li	s3,0
 642:	6c02                	ld	s8,0(sp)
 644:	bf09                	j	556 <vprintf+0x42>
        s = va_arg(ap, char*);
 646:	008b8993          	addi	s3,s7,8
 64a:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 64e:	02090163          	beqz	s2,670 <vprintf+0x15c>
        while(*s != 0){
 652:	00094583          	lbu	a1,0(s2)
 656:	c9a5                	beqz	a1,6c6 <vprintf+0x1b2>
          putc(fd, *s);
 658:	8556                	mv	a0,s5
 65a:	00000097          	auipc	ra,0x0
 65e:	df0080e7          	jalr	-528(ra) # 44a <putc>
          s++;
 662:	0905                	addi	s2,s2,1
        while(*s != 0){
 664:	00094583          	lbu	a1,0(s2)
 668:	f9e5                	bnez	a1,658 <vprintf+0x144>
        s = va_arg(ap, char*);
 66a:	8bce                	mv	s7,s3
      state = 0;
 66c:	4981                	li	s3,0
 66e:	b5e5                	j	556 <vprintf+0x42>
          s = "(null)";
 670:	00000917          	auipc	s2,0x0
 674:	29890913          	addi	s2,s2,664 # 908 <malloc+0x13c>
        while(*s != 0){
 678:	02800593          	li	a1,40
 67c:	bff1                	j	658 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 67e:	008b8913          	addi	s2,s7,8
 682:	000bc583          	lbu	a1,0(s7)
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	dc2080e7          	jalr	-574(ra) # 44a <putc>
 690:	8bca                	mv	s7,s2
      state = 0;
 692:	4981                	li	s3,0
 694:	b5c9                	j	556 <vprintf+0x42>
        putc(fd, c);
 696:	02500593          	li	a1,37
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	dae080e7          	jalr	-594(ra) # 44a <putc>
      state = 0;
 6a4:	4981                	li	s3,0
 6a6:	bd45                	j	556 <vprintf+0x42>
        putc(fd, '%');
 6a8:	02500593          	li	a1,37
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	d9c080e7          	jalr	-612(ra) # 44a <putc>
        putc(fd, c);
 6b6:	85ca                	mv	a1,s2
 6b8:	8556                	mv	a0,s5
 6ba:	00000097          	auipc	ra,0x0
 6be:	d90080e7          	jalr	-624(ra) # 44a <putc>
      state = 0;
 6c2:	4981                	li	s3,0
 6c4:	bd49                	j	556 <vprintf+0x42>
        s = va_arg(ap, char*);
 6c6:	8bce                	mv	s7,s3
      state = 0;
 6c8:	4981                	li	s3,0
 6ca:	b571                	j	556 <vprintf+0x42>
 6cc:	74e2                	ld	s1,56(sp)
 6ce:	79a2                	ld	s3,40(sp)
 6d0:	7a02                	ld	s4,32(sp)
 6d2:	6ae2                	ld	s5,24(sp)
 6d4:	6b42                	ld	s6,16(sp)
 6d6:	6ba2                	ld	s7,8(sp)
    }
  }
}
 6d8:	60a6                	ld	ra,72(sp)
 6da:	6406                	ld	s0,64(sp)
 6dc:	7942                	ld	s2,48(sp)
 6de:	6161                	addi	sp,sp,80
 6e0:	8082                	ret

00000000000006e2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6e2:	715d                	addi	sp,sp,-80
 6e4:	ec06                	sd	ra,24(sp)
 6e6:	e822                	sd	s0,16(sp)
 6e8:	1000                	addi	s0,sp,32
 6ea:	e010                	sd	a2,0(s0)
 6ec:	e414                	sd	a3,8(s0)
 6ee:	e818                	sd	a4,16(s0)
 6f0:	ec1c                	sd	a5,24(s0)
 6f2:	03043023          	sd	a6,32(s0)
 6f6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6fa:	8622                	mv	a2,s0
 6fc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 700:	00000097          	auipc	ra,0x0
 704:	e14080e7          	jalr	-492(ra) # 514 <vprintf>
}
 708:	60e2                	ld	ra,24(sp)
 70a:	6442                	ld	s0,16(sp)
 70c:	6161                	addi	sp,sp,80
 70e:	8082                	ret

0000000000000710 <printf>:

void
printf(const char *fmt, ...)
{
 710:	711d                	addi	sp,sp,-96
 712:	ec06                	sd	ra,24(sp)
 714:	e822                	sd	s0,16(sp)
 716:	1000                	addi	s0,sp,32
 718:	e40c                	sd	a1,8(s0)
 71a:	e810                	sd	a2,16(s0)
 71c:	ec14                	sd	a3,24(s0)
 71e:	f018                	sd	a4,32(s0)
 720:	f41c                	sd	a5,40(s0)
 722:	03043823          	sd	a6,48(s0)
 726:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 72a:	00840613          	addi	a2,s0,8
 72e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 732:	85aa                	mv	a1,a0
 734:	4505                	li	a0,1
 736:	00000097          	auipc	ra,0x0
 73a:	dde080e7          	jalr	-546(ra) # 514 <vprintf>
}
 73e:	60e2                	ld	ra,24(sp)
 740:	6442                	ld	s0,16(sp)
 742:	6125                	addi	sp,sp,96
 744:	8082                	ret

0000000000000746 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 746:	1141                	addi	sp,sp,-16
 748:	e406                	sd	ra,8(sp)
 74a:	e022                	sd	s0,0(sp)
 74c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 74e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 752:	00000797          	auipc	a5,0x0
 756:	6167b783          	ld	a5,1558(a5) # d68 <freep>
 75a:	a039                	j	768 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75c:	6398                	ld	a4,0(a5)
 75e:	00e7e463          	bltu	a5,a4,766 <free+0x20>
 762:	00e6ea63          	bltu	a3,a4,776 <free+0x30>
{
 766:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 768:	fed7fae3          	bgeu	a5,a3,75c <free+0x16>
 76c:	6398                	ld	a4,0(a5)
 76e:	00e6e463          	bltu	a3,a4,776 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 772:	fee7eae3          	bltu	a5,a4,766 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 776:	ff852583          	lw	a1,-8(a0)
 77a:	6390                	ld	a2,0(a5)
 77c:	02059813          	slli	a6,a1,0x20
 780:	01c85713          	srli	a4,a6,0x1c
 784:	9736                	add	a4,a4,a3
 786:	02e60563          	beq	a2,a4,7b0 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 78a:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 78e:	4790                	lw	a2,8(a5)
 790:	02061593          	slli	a1,a2,0x20
 794:	01c5d713          	srli	a4,a1,0x1c
 798:	973e                	add	a4,a4,a5
 79a:	02e68263          	beq	a3,a4,7be <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 79e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7a0:	00000717          	auipc	a4,0x0
 7a4:	5cf73423          	sd	a5,1480(a4) # d68 <freep>
}
 7a8:	60a2                	ld	ra,8(sp)
 7aa:	6402                	ld	s0,0(sp)
 7ac:	0141                	addi	sp,sp,16
 7ae:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 7b0:	4618                	lw	a4,8(a2)
 7b2:	9f2d                	addw	a4,a4,a1
 7b4:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b8:	6398                	ld	a4,0(a5)
 7ba:	6310                	ld	a2,0(a4)
 7bc:	b7f9                	j	78a <free+0x44>
    p->s.size += bp->s.size;
 7be:	ff852703          	lw	a4,-8(a0)
 7c2:	9f31                	addw	a4,a4,a2
 7c4:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7c6:	ff053683          	ld	a3,-16(a0)
 7ca:	bfd1                	j	79e <free+0x58>

00000000000007cc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7cc:	7139                	addi	sp,sp,-64
 7ce:	fc06                	sd	ra,56(sp)
 7d0:	f822                	sd	s0,48(sp)
 7d2:	f04a                	sd	s2,32(sp)
 7d4:	ec4e                	sd	s3,24(sp)
 7d6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d8:	02051993          	slli	s3,a0,0x20
 7dc:	0209d993          	srli	s3,s3,0x20
 7e0:	09bd                	addi	s3,s3,15
 7e2:	0049d993          	srli	s3,s3,0x4
 7e6:	2985                	addiw	s3,s3,1
 7e8:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 7ea:	00000517          	auipc	a0,0x0
 7ee:	57e53503          	ld	a0,1406(a0) # d68 <freep>
 7f2:	c905                	beqz	a0,822 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7f6:	4798                	lw	a4,8(a5)
 7f8:	09377a63          	bgeu	a4,s3,88c <malloc+0xc0>
 7fc:	f426                	sd	s1,40(sp)
 7fe:	e852                	sd	s4,16(sp)
 800:	e456                	sd	s5,8(sp)
 802:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 804:	8a4e                	mv	s4,s3
 806:	6705                	lui	a4,0x1
 808:	00e9f363          	bgeu	s3,a4,80e <malloc+0x42>
 80c:	6a05                	lui	s4,0x1
 80e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 812:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 816:	00000497          	auipc	s1,0x0
 81a:	55248493          	addi	s1,s1,1362 # d68 <freep>
  if(p == (char*)-1)
 81e:	5afd                	li	s5,-1
 820:	a089                	j	862 <malloc+0x96>
 822:	f426                	sd	s1,40(sp)
 824:	e852                	sd	s4,16(sp)
 826:	e456                	sd	s5,8(sp)
 828:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 82a:	00000797          	auipc	a5,0x0
 82e:	54678793          	addi	a5,a5,1350 # d70 <base>
 832:	00000717          	auipc	a4,0x0
 836:	52f73b23          	sd	a5,1334(a4) # d68 <freep>
 83a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 83c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 840:	b7d1                	j	804 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 842:	6398                	ld	a4,0(a5)
 844:	e118                	sd	a4,0(a0)
 846:	a8b9                	j	8a4 <malloc+0xd8>
  hp->s.size = nu;
 848:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 84c:	0541                	addi	a0,a0,16
 84e:	00000097          	auipc	ra,0x0
 852:	ef8080e7          	jalr	-264(ra) # 746 <free>
  return freep;
 856:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 858:	c135                	beqz	a0,8bc <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 85c:	4798                	lw	a4,8(a5)
 85e:	03277363          	bgeu	a4,s2,884 <malloc+0xb8>
    if(p == freep)
 862:	6098                	ld	a4,0(s1)
 864:	853e                	mv	a0,a5
 866:	fef71ae3          	bne	a4,a5,85a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 86a:	8552                	mv	a0,s4
 86c:	00000097          	auipc	ra,0x0
 870:	bc6080e7          	jalr	-1082(ra) # 432 <sbrk>
  if(p == (char*)-1)
 874:	fd551ae3          	bne	a0,s5,848 <malloc+0x7c>
        return 0;
 878:	4501                	li	a0,0
 87a:	74a2                	ld	s1,40(sp)
 87c:	6a42                	ld	s4,16(sp)
 87e:	6aa2                	ld	s5,8(sp)
 880:	6b02                	ld	s6,0(sp)
 882:	a03d                	j	8b0 <malloc+0xe4>
 884:	74a2                	ld	s1,40(sp)
 886:	6a42                	ld	s4,16(sp)
 888:	6aa2                	ld	s5,8(sp)
 88a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 88c:	fae90be3          	beq	s2,a4,842 <malloc+0x76>
        p->s.size -= nunits;
 890:	4137073b          	subw	a4,a4,s3
 894:	c798                	sw	a4,8(a5)
        p += p->s.size;
 896:	02071693          	slli	a3,a4,0x20
 89a:	01c6d713          	srli	a4,a3,0x1c
 89e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8a0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8a4:	00000717          	auipc	a4,0x0
 8a8:	4ca73223          	sd	a0,1220(a4) # d68 <freep>
      return (void*)(p + 1);
 8ac:	01078513          	addi	a0,a5,16
  }
}
 8b0:	70e2                	ld	ra,56(sp)
 8b2:	7442                	ld	s0,48(sp)
 8b4:	7902                	ld	s2,32(sp)
 8b6:	69e2                	ld	s3,24(sp)
 8b8:	6121                	addi	sp,sp,64
 8ba:	8082                	ret
 8bc:	74a2                	ld	s1,40(sp)
 8be:	6a42                	ld	s4,16(sp)
 8c0:	6aa2                	ld	s5,8(sp)
 8c2:	6b02                	ld	s6,0(sp)
 8c4:	b7f5                	j	8b0 <malloc+0xe4>
