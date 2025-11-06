
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	20000d93          	li	s11,512
  32:	00001d17          	auipc	s10,0x1
  36:	e1ed0d13          	addi	s10,s10,-482 # e50 <buf>
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  3a:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  3c:	00001a17          	auipc	s4,0x1
  40:	904a0a13          	addi	s4,s4,-1788 # 940 <malloc+0x100>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  44:	a805                	j	74 <wc+0x74>
      if(strchr(" \r\t\n\v", buf[i]))
  46:	8552                	mv	a0,s4
  48:	00000097          	auipc	ra,0x0
  4c:	1ea080e7          	jalr	490(ra) # 232 <strchr>
  50:	c919                	beqz	a0,66 <wc+0x66>
        inword = 0;
  52:	4901                	li	s2,0
    for(i=0; i<n; i++){
  54:	0485                	addi	s1,s1,1
  56:	01348d63          	beq	s1,s3,70 <wc+0x70>
      if(buf[i] == '\n')
  5a:	0004c583          	lbu	a1,0(s1)
  5e:	ff5594e3          	bne	a1,s5,46 <wc+0x46>
        l++;
  62:	2b85                	addiw	s7,s7,1
  64:	b7cd                	j	46 <wc+0x46>
      else if(!inword){
  66:	fe0917e3          	bnez	s2,54 <wc+0x54>
        w++;
  6a:	2c05                	addiw	s8,s8,1
        inword = 1;
  6c:	4905                	li	s2,1
  6e:	b7dd                	j	54 <wc+0x54>
  70:	019b0cbb          	addw	s9,s6,s9
  while((n = read(fd, buf, sizeof(buf))) > 0){
  74:	866e                	mv	a2,s11
  76:	85ea                	mv	a1,s10
  78:	f8843503          	ld	a0,-120(s0)
  7c:	00000097          	auipc	ra,0x0
  80:	3ba080e7          	jalr	954(ra) # 436 <read>
  84:	8b2a                	mv	s6,a0
  86:	00a05963          	blez	a0,98 <wc+0x98>
  8a:	00001497          	auipc	s1,0x1
  8e:	dc648493          	addi	s1,s1,-570 # e50 <buf>
  92:	009b09b3          	add	s3,s6,s1
  96:	b7d1                	j	5a <wc+0x5a>
      }
    }
  }
  if(n < 0){
  98:	02054e63          	bltz	a0,d4 <wc+0xd4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  9c:	f8043703          	ld	a4,-128(s0)
  a0:	86e6                	mv	a3,s9
  a2:	8662                	mv	a2,s8
  a4:	85de                	mv	a1,s7
  a6:	00001517          	auipc	a0,0x1
  aa:	8ba50513          	addi	a0,a0,-1862 # 960 <malloc+0x120>
  ae:	00000097          	auipc	ra,0x0
  b2:	6d6080e7          	jalr	1750(ra) # 784 <printf>
}
  b6:	70e6                	ld	ra,120(sp)
  b8:	7446                	ld	s0,112(sp)
  ba:	74a6                	ld	s1,104(sp)
  bc:	7906                	ld	s2,96(sp)
  be:	69e6                	ld	s3,88(sp)
  c0:	6a46                	ld	s4,80(sp)
  c2:	6aa6                	ld	s5,72(sp)
  c4:	6b06                	ld	s6,64(sp)
  c6:	7be2                	ld	s7,56(sp)
  c8:	7c42                	ld	s8,48(sp)
  ca:	7ca2                	ld	s9,40(sp)
  cc:	7d02                	ld	s10,32(sp)
  ce:	6de2                	ld	s11,24(sp)
  d0:	6109                	addi	sp,sp,128
  d2:	8082                	ret
    printf("wc: read error\n");
  d4:	00001517          	auipc	a0,0x1
  d8:	87c50513          	addi	a0,a0,-1924 # 950 <malloc+0x110>
  dc:	00000097          	auipc	ra,0x0
  e0:	6a8080e7          	jalr	1704(ra) # 784 <printf>
    exit(1);
  e4:	4505                	li	a0,1
  e6:	00000097          	auipc	ra,0x0
  ea:	338080e7          	jalr	824(ra) # 41e <exit>

00000000000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	7179                	addi	sp,sp,-48
  f0:	f406                	sd	ra,40(sp)
  f2:	f022                	sd	s0,32(sp)
  f4:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  f6:	4785                	li	a5,1
  f8:	04a7dc63          	bge	a5,a0,150 <main+0x62>
  fc:	ec26                	sd	s1,24(sp)
  fe:	e84a                	sd	s2,16(sp)
 100:	e44e                	sd	s3,8(sp)
 102:	00858913          	addi	s2,a1,8
 106:	ffe5099b          	addiw	s3,a0,-2
 10a:	02099793          	slli	a5,s3,0x20
 10e:	01d7d993          	srli	s3,a5,0x1d
 112:	05c1                	addi	a1,a1,16
 114:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 116:	4581                	li	a1,0
 118:	00093503          	ld	a0,0(s2)
 11c:	00000097          	auipc	ra,0x0
 120:	342080e7          	jalr	834(ra) # 45e <open>
 124:	84aa                	mv	s1,a0
 126:	04054663          	bltz	a0,172 <main+0x84>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 12a:	00093583          	ld	a1,0(s2)
 12e:	00000097          	auipc	ra,0x0
 132:	ed2080e7          	jalr	-302(ra) # 0 <wc>
    close(fd);
 136:	8526                	mv	a0,s1
 138:	00000097          	auipc	ra,0x0
 13c:	30e080e7          	jalr	782(ra) # 446 <close>
  for(i = 1; i < argc; i++){
 140:	0921                	addi	s2,s2,8
 142:	fd391ae3          	bne	s2,s3,116 <main+0x28>
  }
  exit(0);
 146:	4501                	li	a0,0
 148:	00000097          	auipc	ra,0x0
 14c:	2d6080e7          	jalr	726(ra) # 41e <exit>
 150:	ec26                	sd	s1,24(sp)
 152:	e84a                	sd	s2,16(sp)
 154:	e44e                	sd	s3,8(sp)
    wc(0, "");
 156:	00000597          	auipc	a1,0x0
 15a:	7f258593          	addi	a1,a1,2034 # 948 <malloc+0x108>
 15e:	4501                	li	a0,0
 160:	00000097          	auipc	ra,0x0
 164:	ea0080e7          	jalr	-352(ra) # 0 <wc>
    exit(0);
 168:	4501                	li	a0,0
 16a:	00000097          	auipc	ra,0x0
 16e:	2b4080e7          	jalr	692(ra) # 41e <exit>
      printf("wc: cannot open %s\n", argv[i]);
 172:	00093583          	ld	a1,0(s2)
 176:	00000517          	auipc	a0,0x0
 17a:	7fa50513          	addi	a0,a0,2042 # 970 <malloc+0x130>
 17e:	00000097          	auipc	ra,0x0
 182:	606080e7          	jalr	1542(ra) # 784 <printf>
      exit(1);
 186:	4505                	li	a0,1
 188:	00000097          	auipc	ra,0x0
 18c:	296080e7          	jalr	662(ra) # 41e <exit>

0000000000000190 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 190:	1141                	addi	sp,sp,-16
 192:	e406                	sd	ra,8(sp)
 194:	e022                	sd	s0,0(sp)
 196:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 198:	87aa                	mv	a5,a0
 19a:	0585                	addi	a1,a1,1
 19c:	0785                	addi	a5,a5,1
 19e:	fff5c703          	lbu	a4,-1(a1)
 1a2:	fee78fa3          	sb	a4,-1(a5)
 1a6:	fb75                	bnez	a4,19a <strcpy+0xa>
    ;
  return os;
}
 1a8:	60a2                	ld	ra,8(sp)
 1aa:	6402                	ld	s0,0(sp)
 1ac:	0141                	addi	sp,sp,16
 1ae:	8082                	ret

00000000000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	1141                	addi	sp,sp,-16
 1b2:	e406                	sd	ra,8(sp)
 1b4:	e022                	sd	s0,0(sp)
 1b6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1b8:	00054783          	lbu	a5,0(a0)
 1bc:	cb91                	beqz	a5,1d0 <strcmp+0x20>
 1be:	0005c703          	lbu	a4,0(a1)
 1c2:	00f71763          	bne	a4,a5,1d0 <strcmp+0x20>
    p++, q++;
 1c6:	0505                	addi	a0,a0,1
 1c8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1ca:	00054783          	lbu	a5,0(a0)
 1ce:	fbe5                	bnez	a5,1be <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1d0:	0005c503          	lbu	a0,0(a1)
}
 1d4:	40a7853b          	subw	a0,a5,a0
 1d8:	60a2                	ld	ra,8(sp)
 1da:	6402                	ld	s0,0(sp)
 1dc:	0141                	addi	sp,sp,16
 1de:	8082                	ret

00000000000001e0 <strlen>:

uint
strlen(const char *s)
{
 1e0:	1141                	addi	sp,sp,-16
 1e2:	e406                	sd	ra,8(sp)
 1e4:	e022                	sd	s0,0(sp)
 1e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1e8:	00054783          	lbu	a5,0(a0)
 1ec:	cf91                	beqz	a5,208 <strlen+0x28>
 1ee:	00150793          	addi	a5,a0,1
 1f2:	86be                	mv	a3,a5
 1f4:	0785                	addi	a5,a5,1
 1f6:	fff7c703          	lbu	a4,-1(a5)
 1fa:	ff65                	bnez	a4,1f2 <strlen+0x12>
 1fc:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 200:	60a2                	ld	ra,8(sp)
 202:	6402                	ld	s0,0(sp)
 204:	0141                	addi	sp,sp,16
 206:	8082                	ret
  for(n = 0; s[n]; n++)
 208:	4501                	li	a0,0
 20a:	bfdd                	j	200 <strlen+0x20>

000000000000020c <memset>:

void*
memset(void *dst, int c, uint n)
{
 20c:	1141                	addi	sp,sp,-16
 20e:	e406                	sd	ra,8(sp)
 210:	e022                	sd	s0,0(sp)
 212:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 214:	ca19                	beqz	a2,22a <memset+0x1e>
 216:	87aa                	mv	a5,a0
 218:	1602                	slli	a2,a2,0x20
 21a:	9201                	srli	a2,a2,0x20
 21c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 220:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 224:	0785                	addi	a5,a5,1
 226:	fee79de3          	bne	a5,a4,220 <memset+0x14>
  }
  return dst;
}
 22a:	60a2                	ld	ra,8(sp)
 22c:	6402                	ld	s0,0(sp)
 22e:	0141                	addi	sp,sp,16
 230:	8082                	ret

0000000000000232 <strchr>:

char*
strchr(const char *s, char c)
{
 232:	1141                	addi	sp,sp,-16
 234:	e406                	sd	ra,8(sp)
 236:	e022                	sd	s0,0(sp)
 238:	0800                	addi	s0,sp,16
  for(; *s; s++)
 23a:	00054783          	lbu	a5,0(a0)
 23e:	cf81                	beqz	a5,256 <strchr+0x24>
    if(*s == c)
 240:	00f58763          	beq	a1,a5,24e <strchr+0x1c>
  for(; *s; s++)
 244:	0505                	addi	a0,a0,1
 246:	00054783          	lbu	a5,0(a0)
 24a:	fbfd                	bnez	a5,240 <strchr+0xe>
      return (char*)s;
  return 0;
 24c:	4501                	li	a0,0
}
 24e:	60a2                	ld	ra,8(sp)
 250:	6402                	ld	s0,0(sp)
 252:	0141                	addi	sp,sp,16
 254:	8082                	ret
  return 0;
 256:	4501                	li	a0,0
 258:	bfdd                	j	24e <strchr+0x1c>

000000000000025a <gets>:

char*
gets(char *buf, int max)
{
 25a:	711d                	addi	sp,sp,-96
 25c:	ec86                	sd	ra,88(sp)
 25e:	e8a2                	sd	s0,80(sp)
 260:	e4a6                	sd	s1,72(sp)
 262:	e0ca                	sd	s2,64(sp)
 264:	fc4e                	sd	s3,56(sp)
 266:	f852                	sd	s4,48(sp)
 268:	f456                	sd	s5,40(sp)
 26a:	f05a                	sd	s6,32(sp)
 26c:	ec5e                	sd	s7,24(sp)
 26e:	e862                	sd	s8,16(sp)
 270:	1080                	addi	s0,sp,96
 272:	8baa                	mv	s7,a0
 274:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 276:	892a                	mv	s2,a0
 278:	4481                	li	s1,0
    cc = read(0, &c, 1);
 27a:	faf40b13          	addi	s6,s0,-81
 27e:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 280:	8c26                	mv	s8,s1
 282:	0014899b          	addiw	s3,s1,1
 286:	84ce                	mv	s1,s3
 288:	0349d663          	bge	s3,s4,2b4 <gets+0x5a>
    cc = read(0, &c, 1);
 28c:	8656                	mv	a2,s5
 28e:	85da                	mv	a1,s6
 290:	4501                	li	a0,0
 292:	00000097          	auipc	ra,0x0
 296:	1a4080e7          	jalr	420(ra) # 436 <read>
    if(cc < 1)
 29a:	00a05d63          	blez	a0,2b4 <gets+0x5a>
      break;
    buf[i++] = c;
 29e:	faf44783          	lbu	a5,-81(s0)
 2a2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2a6:	0905                	addi	s2,s2,1
 2a8:	ff678713          	addi	a4,a5,-10
 2ac:	c319                	beqz	a4,2b2 <gets+0x58>
 2ae:	17cd                	addi	a5,a5,-13
 2b0:	fbe1                	bnez	a5,280 <gets+0x26>
    buf[i++] = c;
 2b2:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 2b4:	9c5e                	add	s8,s8,s7
 2b6:	000c0023          	sb	zero,0(s8)
  return buf;
}
 2ba:	855e                	mv	a0,s7
 2bc:	60e6                	ld	ra,88(sp)
 2be:	6446                	ld	s0,80(sp)
 2c0:	64a6                	ld	s1,72(sp)
 2c2:	6906                	ld	s2,64(sp)
 2c4:	79e2                	ld	s3,56(sp)
 2c6:	7a42                	ld	s4,48(sp)
 2c8:	7aa2                	ld	s5,40(sp)
 2ca:	7b02                	ld	s6,32(sp)
 2cc:	6be2                	ld	s7,24(sp)
 2ce:	6c42                	ld	s8,16(sp)
 2d0:	6125                	addi	sp,sp,96
 2d2:	8082                	ret

00000000000002d4 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d4:	1101                	addi	sp,sp,-32
 2d6:	ec06                	sd	ra,24(sp)
 2d8:	e822                	sd	s0,16(sp)
 2da:	e04a                	sd	s2,0(sp)
 2dc:	1000                	addi	s0,sp,32
 2de:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2e0:	4581                	li	a1,0
 2e2:	00000097          	auipc	ra,0x0
 2e6:	17c080e7          	jalr	380(ra) # 45e <open>
  if(fd < 0)
 2ea:	02054663          	bltz	a0,316 <stat+0x42>
 2ee:	e426                	sd	s1,8(sp)
 2f0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2f2:	85ca                	mv	a1,s2
 2f4:	00000097          	auipc	ra,0x0
 2f8:	182080e7          	jalr	386(ra) # 476 <fstat>
 2fc:	892a                	mv	s2,a0
  close(fd);
 2fe:	8526                	mv	a0,s1
 300:	00000097          	auipc	ra,0x0
 304:	146080e7          	jalr	326(ra) # 446 <close>
  return r;
 308:	64a2                	ld	s1,8(sp)
}
 30a:	854a                	mv	a0,s2
 30c:	60e2                	ld	ra,24(sp)
 30e:	6442                	ld	s0,16(sp)
 310:	6902                	ld	s2,0(sp)
 312:	6105                	addi	sp,sp,32
 314:	8082                	ret
    return -1;
 316:	57fd                	li	a5,-1
 318:	893e                	mv	s2,a5
 31a:	bfc5                	j	30a <stat+0x36>

000000000000031c <atoi>:

int
atoi(const char *s)
{
 31c:	1141                	addi	sp,sp,-16
 31e:	e406                	sd	ra,8(sp)
 320:	e022                	sd	s0,0(sp)
 322:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 324:	00054683          	lbu	a3,0(a0)
 328:	fd06879b          	addiw	a5,a3,-48
 32c:	0ff7f793          	zext.b	a5,a5
 330:	4625                	li	a2,9
 332:	02f66963          	bltu	a2,a5,364 <atoi+0x48>
 336:	872a                	mv	a4,a0
  n = 0;
 338:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 33a:	0705                	addi	a4,a4,1
 33c:	0025179b          	slliw	a5,a0,0x2
 340:	9fa9                	addw	a5,a5,a0
 342:	0017979b          	slliw	a5,a5,0x1
 346:	9fb5                	addw	a5,a5,a3
 348:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 34c:	00074683          	lbu	a3,0(a4)
 350:	fd06879b          	addiw	a5,a3,-48
 354:	0ff7f793          	zext.b	a5,a5
 358:	fef671e3          	bgeu	a2,a5,33a <atoi+0x1e>
  return n;
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret
  n = 0;
 364:	4501                	li	a0,0
 366:	bfdd                	j	35c <atoi+0x40>

0000000000000368 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 368:	1141                	addi	sp,sp,-16
 36a:	e406                	sd	ra,8(sp)
 36c:	e022                	sd	s0,0(sp)
 36e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 370:	02b57563          	bgeu	a0,a1,39a <memmove+0x32>
    while(n-- > 0)
 374:	00c05f63          	blez	a2,392 <memmove+0x2a>
 378:	1602                	slli	a2,a2,0x20
 37a:	9201                	srli	a2,a2,0x20
 37c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 380:	872a                	mv	a4,a0
      *dst++ = *src++;
 382:	0585                	addi	a1,a1,1
 384:	0705                	addi	a4,a4,1
 386:	fff5c683          	lbu	a3,-1(a1)
 38a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 38e:	fee79ae3          	bne	a5,a4,382 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 392:	60a2                	ld	ra,8(sp)
 394:	6402                	ld	s0,0(sp)
 396:	0141                	addi	sp,sp,16
 398:	8082                	ret
    while(n-- > 0)
 39a:	fec05ce3          	blez	a2,392 <memmove+0x2a>
    dst += n;
 39e:	00c50733          	add	a4,a0,a2
    src += n;
 3a2:	95b2                	add	a1,a1,a2
 3a4:	fff6079b          	addiw	a5,a2,-1
 3a8:	1782                	slli	a5,a5,0x20
 3aa:	9381                	srli	a5,a5,0x20
 3ac:	fff7c793          	not	a5,a5
 3b0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3b2:	15fd                	addi	a1,a1,-1
 3b4:	177d                	addi	a4,a4,-1
 3b6:	0005c683          	lbu	a3,0(a1)
 3ba:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3be:	fef71ae3          	bne	a4,a5,3b2 <memmove+0x4a>
 3c2:	bfc1                	j	392 <memmove+0x2a>

00000000000003c4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3c4:	1141                	addi	sp,sp,-16
 3c6:	e406                	sd	ra,8(sp)
 3c8:	e022                	sd	s0,0(sp)
 3ca:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3cc:	c61d                	beqz	a2,3fa <memcmp+0x36>
 3ce:	1602                	slli	a2,a2,0x20
 3d0:	9201                	srli	a2,a2,0x20
 3d2:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 3d6:	00054783          	lbu	a5,0(a0)
 3da:	0005c703          	lbu	a4,0(a1)
 3de:	00e79863          	bne	a5,a4,3ee <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 3e2:	0505                	addi	a0,a0,1
    p2++;
 3e4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3e6:	fed518e3          	bne	a0,a3,3d6 <memcmp+0x12>
  }
  return 0;
 3ea:	4501                	li	a0,0
 3ec:	a019                	j	3f2 <memcmp+0x2e>
      return *p1 - *p2;
 3ee:	40e7853b          	subw	a0,a5,a4
}
 3f2:	60a2                	ld	ra,8(sp)
 3f4:	6402                	ld	s0,0(sp)
 3f6:	0141                	addi	sp,sp,16
 3f8:	8082                	ret
  return 0;
 3fa:	4501                	li	a0,0
 3fc:	bfdd                	j	3f2 <memcmp+0x2e>

00000000000003fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3fe:	1141                	addi	sp,sp,-16
 400:	e406                	sd	ra,8(sp)
 402:	e022                	sd	s0,0(sp)
 404:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 406:	00000097          	auipc	ra,0x0
 40a:	f62080e7          	jalr	-158(ra) # 368 <memmove>
}
 40e:	60a2                	ld	ra,8(sp)
 410:	6402                	ld	s0,0(sp)
 412:	0141                	addi	sp,sp,16
 414:	8082                	ret

0000000000000416 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 416:	4885                	li	a7,1
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <exit>:
.global exit
exit:
 li a7, SYS_exit
 41e:	4889                	li	a7,2
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <wait>:
.global wait
wait:
 li a7, SYS_wait
 426:	488d                	li	a7,3
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 42e:	4891                	li	a7,4
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <read>:
.global read
read:
 li a7, SYS_read
 436:	4895                	li	a7,5
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <write>:
.global write
write:
 li a7, SYS_write
 43e:	48c1                	li	a7,16
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <close>:
.global close
close:
 li a7, SYS_close
 446:	48d5                	li	a7,21
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <kill>:
.global kill
kill:
 li a7, SYS_kill
 44e:	4899                	li	a7,6
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <exec>:
.global exec
exec:
 li a7, SYS_exec
 456:	489d                	li	a7,7
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <open>:
.global open
open:
 li a7, SYS_open
 45e:	48bd                	li	a7,15
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 466:	48c5                	li	a7,17
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 46e:	48c9                	li	a7,18
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 476:	48a1                	li	a7,8
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <link>:
.global link
link:
 li a7, SYS_link
 47e:	48cd                	li	a7,19
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 486:	48d1                	li	a7,20
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 48e:	48a5                	li	a7,9
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <dup>:
.global dup
dup:
 li a7, SYS_dup
 496:	48a9                	li	a7,10
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 49e:	48ad                	li	a7,11
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4a6:	48b1                	li	a7,12
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4ae:	48b5                	li	a7,13
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4b6:	48b9                	li	a7,14
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4be:	1101                	addi	sp,sp,-32
 4c0:	ec06                	sd	ra,24(sp)
 4c2:	e822                	sd	s0,16(sp)
 4c4:	1000                	addi	s0,sp,32
 4c6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4ca:	4605                	li	a2,1
 4cc:	fef40593          	addi	a1,s0,-17
 4d0:	00000097          	auipc	ra,0x0
 4d4:	f6e080e7          	jalr	-146(ra) # 43e <write>
}
 4d8:	60e2                	ld	ra,24(sp)
 4da:	6442                	ld	s0,16(sp)
 4dc:	6105                	addi	sp,sp,32
 4de:	8082                	ret

00000000000004e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	7139                	addi	sp,sp,-64
 4e2:	fc06                	sd	ra,56(sp)
 4e4:	f822                	sd	s0,48(sp)
 4e6:	f04a                	sd	s2,32(sp)
 4e8:	ec4e                	sd	s3,24(sp)
 4ea:	0080                	addi	s0,sp,64
 4ec:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4ee:	cad9                	beqz	a3,584 <printint+0xa4>
 4f0:	01f5d79b          	srliw	a5,a1,0x1f
 4f4:	cbc1                	beqz	a5,584 <printint+0xa4>
    neg = 1;
    x = -xx;
 4f6:	40b005bb          	negw	a1,a1
    neg = 1;
 4fa:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 4fc:	fc040993          	addi	s3,s0,-64
  neg = 0;
 500:	86ce                	mv	a3,s3
  i = 0;
 502:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 504:	00000817          	auipc	a6,0x0
 508:	4e480813          	addi	a6,a6,1252 # 9e8 <digits>
 50c:	88ba                	mv	a7,a4
 50e:	0017051b          	addiw	a0,a4,1
 512:	872a                	mv	a4,a0
 514:	02c5f7bb          	remuw	a5,a1,a2
 518:	1782                	slli	a5,a5,0x20
 51a:	9381                	srli	a5,a5,0x20
 51c:	97c2                	add	a5,a5,a6
 51e:	0007c783          	lbu	a5,0(a5)
 522:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 526:	87ae                	mv	a5,a1
 528:	02c5d5bb          	divuw	a1,a1,a2
 52c:	0685                	addi	a3,a3,1
 52e:	fcc7ffe3          	bgeu	a5,a2,50c <printint+0x2c>
  if(neg)
 532:	00030c63          	beqz	t1,54a <printint+0x6a>
    buf[i++] = '-';
 536:	fd050793          	addi	a5,a0,-48
 53a:	00878533          	add	a0,a5,s0
 53e:	02d00793          	li	a5,45
 542:	fef50823          	sb	a5,-16(a0)
 546:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 54a:	02e05763          	blez	a4,578 <printint+0x98>
 54e:	f426                	sd	s1,40(sp)
 550:	377d                	addiw	a4,a4,-1
 552:	00e984b3          	add	s1,s3,a4
 556:	19fd                	addi	s3,s3,-1
 558:	99ba                	add	s3,s3,a4
 55a:	1702                	slli	a4,a4,0x20
 55c:	9301                	srli	a4,a4,0x20
 55e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 562:	0004c583          	lbu	a1,0(s1)
 566:	854a                	mv	a0,s2
 568:	00000097          	auipc	ra,0x0
 56c:	f56080e7          	jalr	-170(ra) # 4be <putc>
  while(--i >= 0)
 570:	14fd                	addi	s1,s1,-1
 572:	ff3498e3          	bne	s1,s3,562 <printint+0x82>
 576:	74a2                	ld	s1,40(sp)
}
 578:	70e2                	ld	ra,56(sp)
 57a:	7442                	ld	s0,48(sp)
 57c:	7902                	ld	s2,32(sp)
 57e:	69e2                	ld	s3,24(sp)
 580:	6121                	addi	sp,sp,64
 582:	8082                	ret
  neg = 0;
 584:	4301                	li	t1,0
 586:	bf9d                	j	4fc <printint+0x1c>

0000000000000588 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 588:	715d                	addi	sp,sp,-80
 58a:	e486                	sd	ra,72(sp)
 58c:	e0a2                	sd	s0,64(sp)
 58e:	f84a                	sd	s2,48(sp)
 590:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 592:	0005c903          	lbu	s2,0(a1)
 596:	1a090b63          	beqz	s2,74c <vprintf+0x1c4>
 59a:	fc26                	sd	s1,56(sp)
 59c:	f44e                	sd	s3,40(sp)
 59e:	f052                	sd	s4,32(sp)
 5a0:	ec56                	sd	s5,24(sp)
 5a2:	e85a                	sd	s6,16(sp)
 5a4:	e45e                	sd	s7,8(sp)
 5a6:	8aaa                	mv	s5,a0
 5a8:	8bb2                	mv	s7,a2
 5aa:	00158493          	addi	s1,a1,1
  state = 0;
 5ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5b0:	02500a13          	li	s4,37
 5b4:	4b55                	li	s6,21
 5b6:	a839                	j	5d4 <vprintf+0x4c>
        putc(fd, c);
 5b8:	85ca                	mv	a1,s2
 5ba:	8556                	mv	a0,s5
 5bc:	00000097          	auipc	ra,0x0
 5c0:	f02080e7          	jalr	-254(ra) # 4be <putc>
 5c4:	a019                	j	5ca <vprintf+0x42>
    } else if(state == '%'){
 5c6:	01498d63          	beq	s3,s4,5e0 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 5ca:	0485                	addi	s1,s1,1
 5cc:	fff4c903          	lbu	s2,-1(s1)
 5d0:	16090863          	beqz	s2,740 <vprintf+0x1b8>
    if(state == 0){
 5d4:	fe0999e3          	bnez	s3,5c6 <vprintf+0x3e>
      if(c == '%'){
 5d8:	ff4910e3          	bne	s2,s4,5b8 <vprintf+0x30>
        state = '%';
 5dc:	89d2                	mv	s3,s4
 5de:	b7f5                	j	5ca <vprintf+0x42>
      if(c == 'd'){
 5e0:	13490563          	beq	s2,s4,70a <vprintf+0x182>
 5e4:	f9d9079b          	addiw	a5,s2,-99
 5e8:	0ff7f793          	zext.b	a5,a5
 5ec:	12fb6863          	bltu	s6,a5,71c <vprintf+0x194>
 5f0:	f9d9079b          	addiw	a5,s2,-99
 5f4:	0ff7f713          	zext.b	a4,a5
 5f8:	12eb6263          	bltu	s6,a4,71c <vprintf+0x194>
 5fc:	00271793          	slli	a5,a4,0x2
 600:	00000717          	auipc	a4,0x0
 604:	39070713          	addi	a4,a4,912 # 990 <malloc+0x150>
 608:	97ba                	add	a5,a5,a4
 60a:	439c                	lw	a5,0(a5)
 60c:	97ba                	add	a5,a5,a4
 60e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 610:	008b8913          	addi	s2,s7,8
 614:	4685                	li	a3,1
 616:	4629                	li	a2,10
 618:	000ba583          	lw	a1,0(s7)
 61c:	8556                	mv	a0,s5
 61e:	00000097          	auipc	ra,0x0
 622:	ec2080e7          	jalr	-318(ra) # 4e0 <printint>
 626:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 628:	4981                	li	s3,0
 62a:	b745                	j	5ca <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 62c:	008b8913          	addi	s2,s7,8
 630:	4681                	li	a3,0
 632:	4629                	li	a2,10
 634:	000ba583          	lw	a1,0(s7)
 638:	8556                	mv	a0,s5
 63a:	00000097          	auipc	ra,0x0
 63e:	ea6080e7          	jalr	-346(ra) # 4e0 <printint>
 642:	8bca                	mv	s7,s2
      state = 0;
 644:	4981                	li	s3,0
 646:	b751                	j	5ca <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 648:	008b8913          	addi	s2,s7,8
 64c:	4681                	li	a3,0
 64e:	4641                	li	a2,16
 650:	000ba583          	lw	a1,0(s7)
 654:	8556                	mv	a0,s5
 656:	00000097          	auipc	ra,0x0
 65a:	e8a080e7          	jalr	-374(ra) # 4e0 <printint>
 65e:	8bca                	mv	s7,s2
      state = 0;
 660:	4981                	li	s3,0
 662:	b7a5                	j	5ca <vprintf+0x42>
 664:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 666:	008b8793          	addi	a5,s7,8
 66a:	8c3e                	mv	s8,a5
 66c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 670:	03000593          	li	a1,48
 674:	8556                	mv	a0,s5
 676:	00000097          	auipc	ra,0x0
 67a:	e48080e7          	jalr	-440(ra) # 4be <putc>
  putc(fd, 'x');
 67e:	07800593          	li	a1,120
 682:	8556                	mv	a0,s5
 684:	00000097          	auipc	ra,0x0
 688:	e3a080e7          	jalr	-454(ra) # 4be <putc>
 68c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 68e:	00000b97          	auipc	s7,0x0
 692:	35ab8b93          	addi	s7,s7,858 # 9e8 <digits>
 696:	03c9d793          	srli	a5,s3,0x3c
 69a:	97de                	add	a5,a5,s7
 69c:	0007c583          	lbu	a1,0(a5)
 6a0:	8556                	mv	a0,s5
 6a2:	00000097          	auipc	ra,0x0
 6a6:	e1c080e7          	jalr	-484(ra) # 4be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6aa:	0992                	slli	s3,s3,0x4
 6ac:	397d                	addiw	s2,s2,-1
 6ae:	fe0914e3          	bnez	s2,696 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 6b2:	8be2                	mv	s7,s8
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	6c02                	ld	s8,0(sp)
 6b8:	bf09                	j	5ca <vprintf+0x42>
        s = va_arg(ap, char*);
 6ba:	008b8993          	addi	s3,s7,8
 6be:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6c2:	02090163          	beqz	s2,6e4 <vprintf+0x15c>
        while(*s != 0){
 6c6:	00094583          	lbu	a1,0(s2)
 6ca:	c9a5                	beqz	a1,73a <vprintf+0x1b2>
          putc(fd, *s);
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	df0080e7          	jalr	-528(ra) # 4be <putc>
          s++;
 6d6:	0905                	addi	s2,s2,1
        while(*s != 0){
 6d8:	00094583          	lbu	a1,0(s2)
 6dc:	f9e5                	bnez	a1,6cc <vprintf+0x144>
        s = va_arg(ap, char*);
 6de:	8bce                	mv	s7,s3
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	b5e5                	j	5ca <vprintf+0x42>
          s = "(null)";
 6e4:	00000917          	auipc	s2,0x0
 6e8:	2a490913          	addi	s2,s2,676 # 988 <malloc+0x148>
        while(*s != 0){
 6ec:	02800593          	li	a1,40
 6f0:	bff1                	j	6cc <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 6f2:	008b8913          	addi	s2,s7,8
 6f6:	000bc583          	lbu	a1,0(s7)
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	dc2080e7          	jalr	-574(ra) # 4be <putc>
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
 708:	b5c9                	j	5ca <vprintf+0x42>
        putc(fd, c);
 70a:	02500593          	li	a1,37
 70e:	8556                	mv	a0,s5
 710:	00000097          	auipc	ra,0x0
 714:	dae080e7          	jalr	-594(ra) # 4be <putc>
      state = 0;
 718:	4981                	li	s3,0
 71a:	bd45                	j	5ca <vprintf+0x42>
        putc(fd, '%');
 71c:	02500593          	li	a1,37
 720:	8556                	mv	a0,s5
 722:	00000097          	auipc	ra,0x0
 726:	d9c080e7          	jalr	-612(ra) # 4be <putc>
        putc(fd, c);
 72a:	85ca                	mv	a1,s2
 72c:	8556                	mv	a0,s5
 72e:	00000097          	auipc	ra,0x0
 732:	d90080e7          	jalr	-624(ra) # 4be <putc>
      state = 0;
 736:	4981                	li	s3,0
 738:	bd49                	j	5ca <vprintf+0x42>
        s = va_arg(ap, char*);
 73a:	8bce                	mv	s7,s3
      state = 0;
 73c:	4981                	li	s3,0
 73e:	b571                	j	5ca <vprintf+0x42>
 740:	74e2                	ld	s1,56(sp)
 742:	79a2                	ld	s3,40(sp)
 744:	7a02                	ld	s4,32(sp)
 746:	6ae2                	ld	s5,24(sp)
 748:	6b42                	ld	s6,16(sp)
 74a:	6ba2                	ld	s7,8(sp)
    }
  }
}
 74c:	60a6                	ld	ra,72(sp)
 74e:	6406                	ld	s0,64(sp)
 750:	7942                	ld	s2,48(sp)
 752:	6161                	addi	sp,sp,80
 754:	8082                	ret

0000000000000756 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 756:	715d                	addi	sp,sp,-80
 758:	ec06                	sd	ra,24(sp)
 75a:	e822                	sd	s0,16(sp)
 75c:	1000                	addi	s0,sp,32
 75e:	e010                	sd	a2,0(s0)
 760:	e414                	sd	a3,8(s0)
 762:	e818                	sd	a4,16(s0)
 764:	ec1c                	sd	a5,24(s0)
 766:	03043023          	sd	a6,32(s0)
 76a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 76e:	8622                	mv	a2,s0
 770:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 774:	00000097          	auipc	ra,0x0
 778:	e14080e7          	jalr	-492(ra) # 588 <vprintf>
}
 77c:	60e2                	ld	ra,24(sp)
 77e:	6442                	ld	s0,16(sp)
 780:	6161                	addi	sp,sp,80
 782:	8082                	ret

0000000000000784 <printf>:

void
printf(const char *fmt, ...)
{
 784:	711d                	addi	sp,sp,-96
 786:	ec06                	sd	ra,24(sp)
 788:	e822                	sd	s0,16(sp)
 78a:	1000                	addi	s0,sp,32
 78c:	e40c                	sd	a1,8(s0)
 78e:	e810                	sd	a2,16(s0)
 790:	ec14                	sd	a3,24(s0)
 792:	f018                	sd	a4,32(s0)
 794:	f41c                	sd	a5,40(s0)
 796:	03043823          	sd	a6,48(s0)
 79a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 79e:	00840613          	addi	a2,s0,8
 7a2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7a6:	85aa                	mv	a1,a0
 7a8:	4505                	li	a0,1
 7aa:	00000097          	auipc	ra,0x0
 7ae:	dde080e7          	jalr	-546(ra) # 588 <vprintf>
}
 7b2:	60e2                	ld	ra,24(sp)
 7b4:	6442                	ld	s0,16(sp)
 7b6:	6125                	addi	sp,sp,96
 7b8:	8082                	ret

00000000000007ba <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7ba:	1141                	addi	sp,sp,-16
 7bc:	e406                	sd	ra,8(sp)
 7be:	e022                	sd	s0,0(sp)
 7c0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7c2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c6:	00000797          	auipc	a5,0x0
 7ca:	6827b783          	ld	a5,1666(a5) # e48 <freep>
 7ce:	a039                	j	7dc <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	6398                	ld	a4,0(a5)
 7d2:	00e7e463          	bltu	a5,a4,7da <free+0x20>
 7d6:	00e6ea63          	bltu	a3,a4,7ea <free+0x30>
{
 7da:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7dc:	fed7fae3          	bgeu	a5,a3,7d0 <free+0x16>
 7e0:	6398                	ld	a4,0(a5)
 7e2:	00e6e463          	bltu	a3,a4,7ea <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e6:	fee7eae3          	bltu	a5,a4,7da <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7ea:	ff852583          	lw	a1,-8(a0)
 7ee:	6390                	ld	a2,0(a5)
 7f0:	02059813          	slli	a6,a1,0x20
 7f4:	01c85713          	srli	a4,a6,0x1c
 7f8:	9736                	add	a4,a4,a3
 7fa:	02e60563          	beq	a2,a4,824 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 7fe:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 802:	4790                	lw	a2,8(a5)
 804:	02061593          	slli	a1,a2,0x20
 808:	01c5d713          	srli	a4,a1,0x1c
 80c:	973e                	add	a4,a4,a5
 80e:	02e68263          	beq	a3,a4,832 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 812:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 814:	00000717          	auipc	a4,0x0
 818:	62f73a23          	sd	a5,1588(a4) # e48 <freep>
}
 81c:	60a2                	ld	ra,8(sp)
 81e:	6402                	ld	s0,0(sp)
 820:	0141                	addi	sp,sp,16
 822:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 824:	4618                	lw	a4,8(a2)
 826:	9f2d                	addw	a4,a4,a1
 828:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 82c:	6398                	ld	a4,0(a5)
 82e:	6310                	ld	a2,0(a4)
 830:	b7f9                	j	7fe <free+0x44>
    p->s.size += bp->s.size;
 832:	ff852703          	lw	a4,-8(a0)
 836:	9f31                	addw	a4,a4,a2
 838:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 83a:	ff053683          	ld	a3,-16(a0)
 83e:	bfd1                	j	812 <free+0x58>

0000000000000840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 840:	7139                	addi	sp,sp,-64
 842:	fc06                	sd	ra,56(sp)
 844:	f822                	sd	s0,48(sp)
 846:	f04a                	sd	s2,32(sp)
 848:	ec4e                	sd	s3,24(sp)
 84a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84c:	02051993          	slli	s3,a0,0x20
 850:	0209d993          	srli	s3,s3,0x20
 854:	09bd                	addi	s3,s3,15
 856:	0049d993          	srli	s3,s3,0x4
 85a:	2985                	addiw	s3,s3,1
 85c:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 85e:	00000517          	auipc	a0,0x0
 862:	5ea53503          	ld	a0,1514(a0) # e48 <freep>
 866:	c905                	beqz	a0,896 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 868:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 86a:	4798                	lw	a4,8(a5)
 86c:	09377a63          	bgeu	a4,s3,900 <malloc+0xc0>
 870:	f426                	sd	s1,40(sp)
 872:	e852                	sd	s4,16(sp)
 874:	e456                	sd	s5,8(sp)
 876:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 878:	8a4e                	mv	s4,s3
 87a:	6705                	lui	a4,0x1
 87c:	00e9f363          	bgeu	s3,a4,882 <malloc+0x42>
 880:	6a05                	lui	s4,0x1
 882:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 886:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 88a:	00000497          	auipc	s1,0x0
 88e:	5be48493          	addi	s1,s1,1470 # e48 <freep>
  if(p == (char*)-1)
 892:	5afd                	li	s5,-1
 894:	a089                	j	8d6 <malloc+0x96>
 896:	f426                	sd	s1,40(sp)
 898:	e852                	sd	s4,16(sp)
 89a:	e456                	sd	s5,8(sp)
 89c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 89e:	00000797          	auipc	a5,0x0
 8a2:	7b278793          	addi	a5,a5,1970 # 1050 <base>
 8a6:	00000717          	auipc	a4,0x0
 8aa:	5af73123          	sd	a5,1442(a4) # e48 <freep>
 8ae:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8b0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8b4:	b7d1                	j	878 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8b6:	6398                	ld	a4,0(a5)
 8b8:	e118                	sd	a4,0(a0)
 8ba:	a8b9                	j	918 <malloc+0xd8>
  hp->s.size = nu;
 8bc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8c0:	0541                	addi	a0,a0,16
 8c2:	00000097          	auipc	ra,0x0
 8c6:	ef8080e7          	jalr	-264(ra) # 7ba <free>
  return freep;
 8ca:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8cc:	c135                	beqz	a0,930 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ce:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d0:	4798                	lw	a4,8(a5)
 8d2:	03277363          	bgeu	a4,s2,8f8 <malloc+0xb8>
    if(p == freep)
 8d6:	6098                	ld	a4,0(s1)
 8d8:	853e                	mv	a0,a5
 8da:	fef71ae3          	bne	a4,a5,8ce <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 8de:	8552                	mv	a0,s4
 8e0:	00000097          	auipc	ra,0x0
 8e4:	bc6080e7          	jalr	-1082(ra) # 4a6 <sbrk>
  if(p == (char*)-1)
 8e8:	fd551ae3          	bne	a0,s5,8bc <malloc+0x7c>
        return 0;
 8ec:	4501                	li	a0,0
 8ee:	74a2                	ld	s1,40(sp)
 8f0:	6a42                	ld	s4,16(sp)
 8f2:	6aa2                	ld	s5,8(sp)
 8f4:	6b02                	ld	s6,0(sp)
 8f6:	a03d                	j	924 <malloc+0xe4>
 8f8:	74a2                	ld	s1,40(sp)
 8fa:	6a42                	ld	s4,16(sp)
 8fc:	6aa2                	ld	s5,8(sp)
 8fe:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 900:	fae90be3          	beq	s2,a4,8b6 <malloc+0x76>
        p->s.size -= nunits;
 904:	4137073b          	subw	a4,a4,s3
 908:	c798                	sw	a4,8(a5)
        p += p->s.size;
 90a:	02071693          	slli	a3,a4,0x20
 90e:	01c6d713          	srli	a4,a3,0x1c
 912:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 914:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 918:	00000717          	auipc	a4,0x0
 91c:	52a73823          	sd	a0,1328(a4) # e48 <freep>
      return (void*)(p + 1);
 920:	01078513          	addi	a0,a5,16
  }
}
 924:	70e2                	ld	ra,56(sp)
 926:	7442                	ld	s0,48(sp)
 928:	7902                	ld	s2,32(sp)
 92a:	69e2                	ld	s3,24(sp)
 92c:	6121                	addi	sp,sp,64
 92e:	8082                	ret
 930:	74a2                	ld	s1,40(sp)
 932:	6a42                	ld	s4,16(sp)
 934:	6aa2                	ld	s5,8(sp)
 936:	6b02                	ld	s6,0(sp)
 938:	b7f5                	j	924 <malloc+0xe4>
