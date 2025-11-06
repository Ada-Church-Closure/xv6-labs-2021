
user/_bigfile:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fcntl.h"
#include "kernel/fs.h"

int
main()
{
   0:	bb010113          	addi	sp,sp,-1104
   4:	44113423          	sd	ra,1096(sp)
   8:	44813023          	sd	s0,1088(sp)
   c:	45010413          	addi	s0,sp,1104
  char buf[BSIZE];
  int fd, i, blocks;

  fd = open("big.file", O_CREATE | O_WRONLY);
  10:	20100593          	li	a1,513
  14:	00001517          	auipc	a0,0x1
  18:	96450513          	addi	a0,a0,-1692 # 978 <malloc+0xfe>
  1c:	00000097          	auipc	ra,0x0
  20:	47c080e7          	jalr	1148(ra) # 498 <open>
  if(fd < 0){
  24:	06054e63          	bltz	a0,a0 <main+0xa0>
  28:	42913c23          	sd	s1,1080(sp)
  2c:	43213823          	sd	s2,1072(sp)
  30:	43313423          	sd	s3,1064(sp)
  34:	43413023          	sd	s4,1056(sp)
  38:	41513c23          	sd	s5,1048(sp)
  3c:	41613823          	sd	s6,1040(sp)
  40:	41713423          	sd	s7,1032(sp)
  44:	892a                	mv	s2,a0
  46:	4481                	li	s1,0
  }

  blocks = 0;
  while(1){
    *(int*)buf = blocks;
    int cc = write(fd, buf, sizeof(buf));
  48:	bb040a93          	addi	s5,s0,-1104
  4c:	40000a13          	li	s4,1024
    if(cc <= 0)
      break;
    blocks++;
    if (blocks % 100 == 0)
  50:	51eb89b7          	lui	s3,0x51eb8
  54:	51f98993          	addi	s3,s3,1311 # 51eb851f <__global_pointer$+0x51eb6e0b>
  58:	06400b13          	li	s6,100
      printf(".");
  5c:	00001b97          	auipc	s7,0x1
  60:	95cb8b93          	addi	s7,s7,-1700 # 9b8 <malloc+0x13e>
    *(int*)buf = blocks;
  64:	ba942823          	sw	s1,-1104(s0)
    int cc = write(fd, buf, sizeof(buf));
  68:	8652                	mv	a2,s4
  6a:	85d6                	mv	a1,s5
  6c:	854a                	mv	a0,s2
  6e:	00000097          	auipc	ra,0x0
  72:	40a080e7          	jalr	1034(ra) # 478 <write>
    if(cc <= 0)
  76:	06a05063          	blez	a0,d6 <main+0xd6>
    blocks++;
  7a:	0014871b          	addiw	a4,s1,1
  7e:	84ba                	mv	s1,a4
    if (blocks % 100 == 0)
  80:	033707b3          	mul	a5,a4,s3
  84:	9795                	srai	a5,a5,0x25
  86:	41f7569b          	sraiw	a3,a4,0x1f
  8a:	9f95                	subw	a5,a5,a3
  8c:	02fb07bb          	mulw	a5,s6,a5
  90:	9f1d                	subw	a4,a4,a5
  92:	fb69                	bnez	a4,64 <main+0x64>
      printf(".");
  94:	855e                	mv	a0,s7
  96:	00000097          	auipc	ra,0x0
  9a:	728080e7          	jalr	1832(ra) # 7be <printf>
  9e:	b7d9                	j	64 <main+0x64>
  a0:	42913c23          	sd	s1,1080(sp)
  a4:	43213823          	sd	s2,1072(sp)
  a8:	43313423          	sd	s3,1064(sp)
  ac:	43413023          	sd	s4,1056(sp)
  b0:	41513c23          	sd	s5,1048(sp)
  b4:	41613823          	sd	s6,1040(sp)
  b8:	41713423          	sd	s7,1032(sp)
    printf("bigfile: cannot open big.file for writing\n");
  bc:	00001517          	auipc	a0,0x1
  c0:	8cc50513          	addi	a0,a0,-1844 # 988 <malloc+0x10e>
  c4:	00000097          	auipc	ra,0x0
  c8:	6fa080e7          	jalr	1786(ra) # 7be <printf>
    exit(-1);
  cc:	557d                	li	a0,-1
  ce:	00000097          	auipc	ra,0x0
  d2:	38a080e7          	jalr	906(ra) # 458 <exit>
  }

  printf("\nwrote %d blocks\n", blocks);
  d6:	85a6                	mv	a1,s1
  d8:	00001517          	auipc	a0,0x1
  dc:	8e850513          	addi	a0,a0,-1816 # 9c0 <malloc+0x146>
  e0:	00000097          	auipc	ra,0x0
  e4:	6de080e7          	jalr	1758(ra) # 7be <printf>
  if(blocks != 65803) {
  e8:	67c1                	lui	a5,0x10
  ea:	10b78793          	addi	a5,a5,267 # 1010b <__global_pointer$+0xe9f7>
  ee:	00f48f63          	beq	s1,a5,10c <main+0x10c>
    printf("bigfile: file is too small\n");
  f2:	00001517          	auipc	a0,0x1
  f6:	8e650513          	addi	a0,a0,-1818 # 9d8 <malloc+0x15e>
  fa:	00000097          	auipc	ra,0x0
  fe:	6c4080e7          	jalr	1732(ra) # 7be <printf>
    exit(-1);
 102:	557d                	li	a0,-1
 104:	00000097          	auipc	ra,0x0
 108:	354080e7          	jalr	852(ra) # 458 <exit>
  }
  
  close(fd);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	372080e7          	jalr	882(ra) # 480 <close>
  fd = open("big.file", O_RDONLY);
 116:	4581                	li	a1,0
 118:	00001517          	auipc	a0,0x1
 11c:	86050513          	addi	a0,a0,-1952 # 978 <malloc+0xfe>
 120:	00000097          	auipc	ra,0x0
 124:	378080e7          	jalr	888(ra) # 498 <open>
 128:	892a                	mv	s2,a0
  if(fd < 0){
    printf("bigfile: cannot re-open big.file for reading\n");
    exit(-1);
  }
  for(i = 0; i < blocks; i++){
 12a:	4481                	li	s1,0
  if(fd < 0){
 12c:	04054663          	bltz	a0,178 <main+0x178>
    int cc = read(fd, buf, sizeof(buf));
 130:	bb040a93          	addi	s5,s0,-1104
 134:	40000a13          	li	s4,1024
  for(i = 0; i < blocks; i++){
 138:	69c1                	lui	s3,0x10
 13a:	10b98993          	addi	s3,s3,267 # 1010b <__global_pointer$+0xe9f7>
    int cc = read(fd, buf, sizeof(buf));
 13e:	8652                	mv	a2,s4
 140:	85d6                	mv	a1,s5
 142:	854a                	mv	a0,s2
 144:	00000097          	auipc	ra,0x0
 148:	32c080e7          	jalr	812(ra) # 470 <read>
    if(cc <= 0){
 14c:	04a05363          	blez	a0,192 <main+0x192>
      printf("bigfile: read error at block %d\n", i);
      exit(-1);
    }
    if(*(int*)buf != i){
 150:	bb042583          	lw	a1,-1104(s0)
 154:	04959d63          	bne	a1,s1,1ae <main+0x1ae>
  for(i = 0; i < blocks; i++){
 158:	2485                	addiw	s1,s1,1
 15a:	ff3492e3          	bne	s1,s3,13e <main+0x13e>
             *(int*)buf, i);
      exit(-1);
    }
  }

  printf("bigfile done; ok\n"); 
 15e:	00001517          	auipc	a0,0x1
 162:	92250513          	addi	a0,a0,-1758 # a80 <malloc+0x206>
 166:	00000097          	auipc	ra,0x0
 16a:	658080e7          	jalr	1624(ra) # 7be <printf>

  exit(0);
 16e:	4501                	li	a0,0
 170:	00000097          	auipc	ra,0x0
 174:	2e8080e7          	jalr	744(ra) # 458 <exit>
    printf("bigfile: cannot re-open big.file for reading\n");
 178:	00001517          	auipc	a0,0x1
 17c:	88050513          	addi	a0,a0,-1920 # 9f8 <malloc+0x17e>
 180:	00000097          	auipc	ra,0x0
 184:	63e080e7          	jalr	1598(ra) # 7be <printf>
    exit(-1);
 188:	557d                	li	a0,-1
 18a:	00000097          	auipc	ra,0x0
 18e:	2ce080e7          	jalr	718(ra) # 458 <exit>
      printf("bigfile: read error at block %d\n", i);
 192:	85a6                	mv	a1,s1
 194:	00001517          	auipc	a0,0x1
 198:	89450513          	addi	a0,a0,-1900 # a28 <malloc+0x1ae>
 19c:	00000097          	auipc	ra,0x0
 1a0:	622080e7          	jalr	1570(ra) # 7be <printf>
      exit(-1);
 1a4:	557d                	li	a0,-1
 1a6:	00000097          	auipc	ra,0x0
 1aa:	2b2080e7          	jalr	690(ra) # 458 <exit>
      printf("bigfile: read the wrong data (%d) for block %d\n",
 1ae:	8626                	mv	a2,s1
 1b0:	00001517          	auipc	a0,0x1
 1b4:	8a050513          	addi	a0,a0,-1888 # a50 <malloc+0x1d6>
 1b8:	00000097          	auipc	ra,0x0
 1bc:	606080e7          	jalr	1542(ra) # 7be <printf>
      exit(-1);
 1c0:	557d                	li	a0,-1
 1c2:	00000097          	auipc	ra,0x0
 1c6:	296080e7          	jalr	662(ra) # 458 <exit>

00000000000001ca <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 1ca:	1141                	addi	sp,sp,-16
 1cc:	e406                	sd	ra,8(sp)
 1ce:	e022                	sd	s0,0(sp)
 1d0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d2:	87aa                	mv	a5,a0
 1d4:	0585                	addi	a1,a1,1
 1d6:	0785                	addi	a5,a5,1
 1d8:	fff5c703          	lbu	a4,-1(a1)
 1dc:	fee78fa3          	sb	a4,-1(a5)
 1e0:	fb75                	bnez	a4,1d4 <strcpy+0xa>
    ;
  return os;
}
 1e2:	60a2                	ld	ra,8(sp)
 1e4:	6402                	ld	s0,0(sp)
 1e6:	0141                	addi	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e406                	sd	ra,8(sp)
 1ee:	e022                	sd	s0,0(sp)
 1f0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	cb91                	beqz	a5,20a <strcmp+0x20>
 1f8:	0005c703          	lbu	a4,0(a1)
 1fc:	00f71763          	bne	a4,a5,20a <strcmp+0x20>
    p++, q++;
 200:	0505                	addi	a0,a0,1
 202:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 204:	00054783          	lbu	a5,0(a0)
 208:	fbe5                	bnez	a5,1f8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 20a:	0005c503          	lbu	a0,0(a1)
}
 20e:	40a7853b          	subw	a0,a5,a0
 212:	60a2                	ld	ra,8(sp)
 214:	6402                	ld	s0,0(sp)
 216:	0141                	addi	sp,sp,16
 218:	8082                	ret

000000000000021a <strlen>:

uint
strlen(const char *s)
{
 21a:	1141                	addi	sp,sp,-16
 21c:	e406                	sd	ra,8(sp)
 21e:	e022                	sd	s0,0(sp)
 220:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 222:	00054783          	lbu	a5,0(a0)
 226:	cf91                	beqz	a5,242 <strlen+0x28>
 228:	00150793          	addi	a5,a0,1
 22c:	86be                	mv	a3,a5
 22e:	0785                	addi	a5,a5,1
 230:	fff7c703          	lbu	a4,-1(a5)
 234:	ff65                	bnez	a4,22c <strlen+0x12>
 236:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 23a:	60a2                	ld	ra,8(sp)
 23c:	6402                	ld	s0,0(sp)
 23e:	0141                	addi	sp,sp,16
 240:	8082                	ret
  for(n = 0; s[n]; n++)
 242:	4501                	li	a0,0
 244:	bfdd                	j	23a <strlen+0x20>

0000000000000246 <memset>:

void*
memset(void *dst, int c, uint n)
{
 246:	1141                	addi	sp,sp,-16
 248:	e406                	sd	ra,8(sp)
 24a:	e022                	sd	s0,0(sp)
 24c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 24e:	ca19                	beqz	a2,264 <memset+0x1e>
 250:	87aa                	mv	a5,a0
 252:	1602                	slli	a2,a2,0x20
 254:	9201                	srli	a2,a2,0x20
 256:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 25a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 25e:	0785                	addi	a5,a5,1
 260:	fee79de3          	bne	a5,a4,25a <memset+0x14>
  }
  return dst;
}
 264:	60a2                	ld	ra,8(sp)
 266:	6402                	ld	s0,0(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret

000000000000026c <strchr>:

char*
strchr(const char *s, char c)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e406                	sd	ra,8(sp)
 270:	e022                	sd	s0,0(sp)
 272:	0800                	addi	s0,sp,16
  for(; *s; s++)
 274:	00054783          	lbu	a5,0(a0)
 278:	cf81                	beqz	a5,290 <strchr+0x24>
    if(*s == c)
 27a:	00f58763          	beq	a1,a5,288 <strchr+0x1c>
  for(; *s; s++)
 27e:	0505                	addi	a0,a0,1
 280:	00054783          	lbu	a5,0(a0)
 284:	fbfd                	bnez	a5,27a <strchr+0xe>
      return (char*)s;
  return 0;
 286:	4501                	li	a0,0
}
 288:	60a2                	ld	ra,8(sp)
 28a:	6402                	ld	s0,0(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret
  return 0;
 290:	4501                	li	a0,0
 292:	bfdd                	j	288 <strchr+0x1c>

0000000000000294 <gets>:

char*
gets(char *buf, int max)
{
 294:	711d                	addi	sp,sp,-96
 296:	ec86                	sd	ra,88(sp)
 298:	e8a2                	sd	s0,80(sp)
 29a:	e4a6                	sd	s1,72(sp)
 29c:	e0ca                	sd	s2,64(sp)
 29e:	fc4e                	sd	s3,56(sp)
 2a0:	f852                	sd	s4,48(sp)
 2a2:	f456                	sd	s5,40(sp)
 2a4:	f05a                	sd	s6,32(sp)
 2a6:	ec5e                	sd	s7,24(sp)
 2a8:	e862                	sd	s8,16(sp)
 2aa:	1080                	addi	s0,sp,96
 2ac:	8baa                	mv	s7,a0
 2ae:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b0:	892a                	mv	s2,a0
 2b2:	4481                	li	s1,0
    cc = read(0, &c, 1);
 2b4:	faf40b13          	addi	s6,s0,-81
 2b8:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 2ba:	8c26                	mv	s8,s1
 2bc:	0014899b          	addiw	s3,s1,1
 2c0:	84ce                	mv	s1,s3
 2c2:	0349d663          	bge	s3,s4,2ee <gets+0x5a>
    cc = read(0, &c, 1);
 2c6:	8656                	mv	a2,s5
 2c8:	85da                	mv	a1,s6
 2ca:	4501                	li	a0,0
 2cc:	00000097          	auipc	ra,0x0
 2d0:	1a4080e7          	jalr	420(ra) # 470 <read>
    if(cc < 1)
 2d4:	00a05d63          	blez	a0,2ee <gets+0x5a>
      break;
    buf[i++] = c;
 2d8:	faf44783          	lbu	a5,-81(s0)
 2dc:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2e0:	0905                	addi	s2,s2,1
 2e2:	ff678713          	addi	a4,a5,-10
 2e6:	c319                	beqz	a4,2ec <gets+0x58>
 2e8:	17cd                	addi	a5,a5,-13
 2ea:	fbe1                	bnez	a5,2ba <gets+0x26>
    buf[i++] = c;
 2ec:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 2ee:	9c5e                	add	s8,s8,s7
 2f0:	000c0023          	sb	zero,0(s8)
  return buf;
}
 2f4:	855e                	mv	a0,s7
 2f6:	60e6                	ld	ra,88(sp)
 2f8:	6446                	ld	s0,80(sp)
 2fa:	64a6                	ld	s1,72(sp)
 2fc:	6906                	ld	s2,64(sp)
 2fe:	79e2                	ld	s3,56(sp)
 300:	7a42                	ld	s4,48(sp)
 302:	7aa2                	ld	s5,40(sp)
 304:	7b02                	ld	s6,32(sp)
 306:	6be2                	ld	s7,24(sp)
 308:	6c42                	ld	s8,16(sp)
 30a:	6125                	addi	sp,sp,96
 30c:	8082                	ret

000000000000030e <stat>:

int
stat(const char *n, struct stat *st)
{
 30e:	1101                	addi	sp,sp,-32
 310:	ec06                	sd	ra,24(sp)
 312:	e822                	sd	s0,16(sp)
 314:	e04a                	sd	s2,0(sp)
 316:	1000                	addi	s0,sp,32
 318:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 31a:	4581                	li	a1,0
 31c:	00000097          	auipc	ra,0x0
 320:	17c080e7          	jalr	380(ra) # 498 <open>
  if(fd < 0)
 324:	02054663          	bltz	a0,350 <stat+0x42>
 328:	e426                	sd	s1,8(sp)
 32a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 32c:	85ca                	mv	a1,s2
 32e:	00000097          	auipc	ra,0x0
 332:	182080e7          	jalr	386(ra) # 4b0 <fstat>
 336:	892a                	mv	s2,a0
  close(fd);
 338:	8526                	mv	a0,s1
 33a:	00000097          	auipc	ra,0x0
 33e:	146080e7          	jalr	326(ra) # 480 <close>
  return r;
 342:	64a2                	ld	s1,8(sp)
}
 344:	854a                	mv	a0,s2
 346:	60e2                	ld	ra,24(sp)
 348:	6442                	ld	s0,16(sp)
 34a:	6902                	ld	s2,0(sp)
 34c:	6105                	addi	sp,sp,32
 34e:	8082                	ret
    return -1;
 350:	57fd                	li	a5,-1
 352:	893e                	mv	s2,a5
 354:	bfc5                	j	344 <stat+0x36>

0000000000000356 <atoi>:

int
atoi(const char *s)
{
 356:	1141                	addi	sp,sp,-16
 358:	e406                	sd	ra,8(sp)
 35a:	e022                	sd	s0,0(sp)
 35c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 35e:	00054683          	lbu	a3,0(a0)
 362:	fd06879b          	addiw	a5,a3,-48
 366:	0ff7f793          	zext.b	a5,a5
 36a:	4625                	li	a2,9
 36c:	02f66963          	bltu	a2,a5,39e <atoi+0x48>
 370:	872a                	mv	a4,a0
  n = 0;
 372:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 374:	0705                	addi	a4,a4,1
 376:	0025179b          	slliw	a5,a0,0x2
 37a:	9fa9                	addw	a5,a5,a0
 37c:	0017979b          	slliw	a5,a5,0x1
 380:	9fb5                	addw	a5,a5,a3
 382:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 386:	00074683          	lbu	a3,0(a4)
 38a:	fd06879b          	addiw	a5,a3,-48
 38e:	0ff7f793          	zext.b	a5,a5
 392:	fef671e3          	bgeu	a2,a5,374 <atoi+0x1e>
  return n;
}
 396:	60a2                	ld	ra,8(sp)
 398:	6402                	ld	s0,0(sp)
 39a:	0141                	addi	sp,sp,16
 39c:	8082                	ret
  n = 0;
 39e:	4501                	li	a0,0
 3a0:	bfdd                	j	396 <atoi+0x40>

00000000000003a2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a2:	1141                	addi	sp,sp,-16
 3a4:	e406                	sd	ra,8(sp)
 3a6:	e022                	sd	s0,0(sp)
 3a8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 3aa:	02b57563          	bgeu	a0,a1,3d4 <memmove+0x32>
    while(n-- > 0)
 3ae:	00c05f63          	blez	a2,3cc <memmove+0x2a>
 3b2:	1602                	slli	a2,a2,0x20
 3b4:	9201                	srli	a2,a2,0x20
 3b6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 3ba:	872a                	mv	a4,a0
      *dst++ = *src++;
 3bc:	0585                	addi	a1,a1,1
 3be:	0705                	addi	a4,a4,1
 3c0:	fff5c683          	lbu	a3,-1(a1)
 3c4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 3c8:	fee79ae3          	bne	a5,a4,3bc <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3cc:	60a2                	ld	ra,8(sp)
 3ce:	6402                	ld	s0,0(sp)
 3d0:	0141                	addi	sp,sp,16
 3d2:	8082                	ret
    while(n-- > 0)
 3d4:	fec05ce3          	blez	a2,3cc <memmove+0x2a>
    dst += n;
 3d8:	00c50733          	add	a4,a0,a2
    src += n;
 3dc:	95b2                	add	a1,a1,a2
 3de:	fff6079b          	addiw	a5,a2,-1
 3e2:	1782                	slli	a5,a5,0x20
 3e4:	9381                	srli	a5,a5,0x20
 3e6:	fff7c793          	not	a5,a5
 3ea:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3ec:	15fd                	addi	a1,a1,-1
 3ee:	177d                	addi	a4,a4,-1
 3f0:	0005c683          	lbu	a3,0(a1)
 3f4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3f8:	fef71ae3          	bne	a4,a5,3ec <memmove+0x4a>
 3fc:	bfc1                	j	3cc <memmove+0x2a>

00000000000003fe <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3fe:	1141                	addi	sp,sp,-16
 400:	e406                	sd	ra,8(sp)
 402:	e022                	sd	s0,0(sp)
 404:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 406:	c61d                	beqz	a2,434 <memcmp+0x36>
 408:	1602                	slli	a2,a2,0x20
 40a:	9201                	srli	a2,a2,0x20
 40c:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 410:	00054783          	lbu	a5,0(a0)
 414:	0005c703          	lbu	a4,0(a1)
 418:	00e79863          	bne	a5,a4,428 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 41c:	0505                	addi	a0,a0,1
    p2++;
 41e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 420:	fed518e3          	bne	a0,a3,410 <memcmp+0x12>
  }
  return 0;
 424:	4501                	li	a0,0
 426:	a019                	j	42c <memcmp+0x2e>
      return *p1 - *p2;
 428:	40e7853b          	subw	a0,a5,a4
}
 42c:	60a2                	ld	ra,8(sp)
 42e:	6402                	ld	s0,0(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret
  return 0;
 434:	4501                	li	a0,0
 436:	bfdd                	j	42c <memcmp+0x2e>

0000000000000438 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e406                	sd	ra,8(sp)
 43c:	e022                	sd	s0,0(sp)
 43e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 440:	00000097          	auipc	ra,0x0
 444:	f62080e7          	jalr	-158(ra) # 3a2 <memmove>
}
 448:	60a2                	ld	ra,8(sp)
 44a:	6402                	ld	s0,0(sp)
 44c:	0141                	addi	sp,sp,16
 44e:	8082                	ret

0000000000000450 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 450:	4885                	li	a7,1
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <exit>:
.global exit
exit:
 li a7, SYS_exit
 458:	4889                	li	a7,2
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <wait>:
.global wait
wait:
 li a7, SYS_wait
 460:	488d                	li	a7,3
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 468:	4891                	li	a7,4
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <read>:
.global read
read:
 li a7, SYS_read
 470:	4895                	li	a7,5
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <write>:
.global write
write:
 li a7, SYS_write
 478:	48c1                	li	a7,16
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <close>:
.global close
close:
 li a7, SYS_close
 480:	48d5                	li	a7,21
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <kill>:
.global kill
kill:
 li a7, SYS_kill
 488:	4899                	li	a7,6
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <exec>:
.global exec
exec:
 li a7, SYS_exec
 490:	489d                	li	a7,7
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <open>:
.global open
open:
 li a7, SYS_open
 498:	48bd                	li	a7,15
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 4a0:	48c5                	li	a7,17
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4a8:	48c9                	li	a7,18
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4b0:	48a1                	li	a7,8
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <link>:
.global link
link:
 li a7, SYS_link
 4b8:	48cd                	li	a7,19
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4c0:	48d1                	li	a7,20
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4c8:	48a5                	li	a7,9
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4d0:	48a9                	li	a7,10
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4d8:	48ad                	li	a7,11
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4e0:	48b1                	li	a7,12
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4e8:	48b5                	li	a7,13
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4f0:	48b9                	li	a7,14
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4f8:	1101                	addi	sp,sp,-32
 4fa:	ec06                	sd	ra,24(sp)
 4fc:	e822                	sd	s0,16(sp)
 4fe:	1000                	addi	s0,sp,32
 500:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 504:	4605                	li	a2,1
 506:	fef40593          	addi	a1,s0,-17
 50a:	00000097          	auipc	ra,0x0
 50e:	f6e080e7          	jalr	-146(ra) # 478 <write>
}
 512:	60e2                	ld	ra,24(sp)
 514:	6442                	ld	s0,16(sp)
 516:	6105                	addi	sp,sp,32
 518:	8082                	ret

000000000000051a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 51a:	7139                	addi	sp,sp,-64
 51c:	fc06                	sd	ra,56(sp)
 51e:	f822                	sd	s0,48(sp)
 520:	f04a                	sd	s2,32(sp)
 522:	ec4e                	sd	s3,24(sp)
 524:	0080                	addi	s0,sp,64
 526:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 528:	cad9                	beqz	a3,5be <printint+0xa4>
 52a:	01f5d79b          	srliw	a5,a1,0x1f
 52e:	cbc1                	beqz	a5,5be <printint+0xa4>
    neg = 1;
    x = -xx;
 530:	40b005bb          	negw	a1,a1
    neg = 1;
 534:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 536:	fc040993          	addi	s3,s0,-64
  neg = 0;
 53a:	86ce                	mv	a3,s3
  i = 0;
 53c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 53e:	00000817          	auipc	a6,0x0
 542:	5ba80813          	addi	a6,a6,1466 # af8 <digits>
 546:	88ba                	mv	a7,a4
 548:	0017051b          	addiw	a0,a4,1
 54c:	872a                	mv	a4,a0
 54e:	02c5f7bb          	remuw	a5,a1,a2
 552:	1782                	slli	a5,a5,0x20
 554:	9381                	srli	a5,a5,0x20
 556:	97c2                	add	a5,a5,a6
 558:	0007c783          	lbu	a5,0(a5)
 55c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 560:	87ae                	mv	a5,a1
 562:	02c5d5bb          	divuw	a1,a1,a2
 566:	0685                	addi	a3,a3,1
 568:	fcc7ffe3          	bgeu	a5,a2,546 <printint+0x2c>
  if(neg)
 56c:	00030c63          	beqz	t1,584 <printint+0x6a>
    buf[i++] = '-';
 570:	fd050793          	addi	a5,a0,-48
 574:	00878533          	add	a0,a5,s0
 578:	02d00793          	li	a5,45
 57c:	fef50823          	sb	a5,-16(a0)
 580:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 584:	02e05763          	blez	a4,5b2 <printint+0x98>
 588:	f426                	sd	s1,40(sp)
 58a:	377d                	addiw	a4,a4,-1
 58c:	00e984b3          	add	s1,s3,a4
 590:	19fd                	addi	s3,s3,-1
 592:	99ba                	add	s3,s3,a4
 594:	1702                	slli	a4,a4,0x20
 596:	9301                	srli	a4,a4,0x20
 598:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 59c:	0004c583          	lbu	a1,0(s1)
 5a0:	854a                	mv	a0,s2
 5a2:	00000097          	auipc	ra,0x0
 5a6:	f56080e7          	jalr	-170(ra) # 4f8 <putc>
  while(--i >= 0)
 5aa:	14fd                	addi	s1,s1,-1
 5ac:	ff3498e3          	bne	s1,s3,59c <printint+0x82>
 5b0:	74a2                	ld	s1,40(sp)
}
 5b2:	70e2                	ld	ra,56(sp)
 5b4:	7442                	ld	s0,48(sp)
 5b6:	7902                	ld	s2,32(sp)
 5b8:	69e2                	ld	s3,24(sp)
 5ba:	6121                	addi	sp,sp,64
 5bc:	8082                	ret
  neg = 0;
 5be:	4301                	li	t1,0
 5c0:	bf9d                	j	536 <printint+0x1c>

00000000000005c2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5c2:	715d                	addi	sp,sp,-80
 5c4:	e486                	sd	ra,72(sp)
 5c6:	e0a2                	sd	s0,64(sp)
 5c8:	f84a                	sd	s2,48(sp)
 5ca:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5cc:	0005c903          	lbu	s2,0(a1)
 5d0:	1a090b63          	beqz	s2,786 <vprintf+0x1c4>
 5d4:	fc26                	sd	s1,56(sp)
 5d6:	f44e                	sd	s3,40(sp)
 5d8:	f052                	sd	s4,32(sp)
 5da:	ec56                	sd	s5,24(sp)
 5dc:	e85a                	sd	s6,16(sp)
 5de:	e45e                	sd	s7,8(sp)
 5e0:	8aaa                	mv	s5,a0
 5e2:	8bb2                	mv	s7,a2
 5e4:	00158493          	addi	s1,a1,1
  state = 0;
 5e8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5ea:	02500a13          	li	s4,37
 5ee:	4b55                	li	s6,21
 5f0:	a839                	j	60e <vprintf+0x4c>
        putc(fd, c);
 5f2:	85ca                	mv	a1,s2
 5f4:	8556                	mv	a0,s5
 5f6:	00000097          	auipc	ra,0x0
 5fa:	f02080e7          	jalr	-254(ra) # 4f8 <putc>
 5fe:	a019                	j	604 <vprintf+0x42>
    } else if(state == '%'){
 600:	01498d63          	beq	s3,s4,61a <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 604:	0485                	addi	s1,s1,1
 606:	fff4c903          	lbu	s2,-1(s1)
 60a:	16090863          	beqz	s2,77a <vprintf+0x1b8>
    if(state == 0){
 60e:	fe0999e3          	bnez	s3,600 <vprintf+0x3e>
      if(c == '%'){
 612:	ff4910e3          	bne	s2,s4,5f2 <vprintf+0x30>
        state = '%';
 616:	89d2                	mv	s3,s4
 618:	b7f5                	j	604 <vprintf+0x42>
      if(c == 'd'){
 61a:	13490563          	beq	s2,s4,744 <vprintf+0x182>
 61e:	f9d9079b          	addiw	a5,s2,-99
 622:	0ff7f793          	zext.b	a5,a5
 626:	12fb6863          	bltu	s6,a5,756 <vprintf+0x194>
 62a:	f9d9079b          	addiw	a5,s2,-99
 62e:	0ff7f713          	zext.b	a4,a5
 632:	12eb6263          	bltu	s6,a4,756 <vprintf+0x194>
 636:	00271793          	slli	a5,a4,0x2
 63a:	00000717          	auipc	a4,0x0
 63e:	46670713          	addi	a4,a4,1126 # aa0 <malloc+0x226>
 642:	97ba                	add	a5,a5,a4
 644:	439c                	lw	a5,0(a5)
 646:	97ba                	add	a5,a5,a4
 648:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 64a:	008b8913          	addi	s2,s7,8
 64e:	4685                	li	a3,1
 650:	4629                	li	a2,10
 652:	000ba583          	lw	a1,0(s7)
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	ec2080e7          	jalr	-318(ra) # 51a <printint>
 660:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 662:	4981                	li	s3,0
 664:	b745                	j	604 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 666:	008b8913          	addi	s2,s7,8
 66a:	4681                	li	a3,0
 66c:	4629                	li	a2,10
 66e:	000ba583          	lw	a1,0(s7)
 672:	8556                	mv	a0,s5
 674:	00000097          	auipc	ra,0x0
 678:	ea6080e7          	jalr	-346(ra) # 51a <printint>
 67c:	8bca                	mv	s7,s2
      state = 0;
 67e:	4981                	li	s3,0
 680:	b751                	j	604 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 682:	008b8913          	addi	s2,s7,8
 686:	4681                	li	a3,0
 688:	4641                	li	a2,16
 68a:	000ba583          	lw	a1,0(s7)
 68e:	8556                	mv	a0,s5
 690:	00000097          	auipc	ra,0x0
 694:	e8a080e7          	jalr	-374(ra) # 51a <printint>
 698:	8bca                	mv	s7,s2
      state = 0;
 69a:	4981                	li	s3,0
 69c:	b7a5                	j	604 <vprintf+0x42>
 69e:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6a0:	008b8793          	addi	a5,s7,8
 6a4:	8c3e                	mv	s8,a5
 6a6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6aa:	03000593          	li	a1,48
 6ae:	8556                	mv	a0,s5
 6b0:	00000097          	auipc	ra,0x0
 6b4:	e48080e7          	jalr	-440(ra) # 4f8 <putc>
  putc(fd, 'x');
 6b8:	07800593          	li	a1,120
 6bc:	8556                	mv	a0,s5
 6be:	00000097          	auipc	ra,0x0
 6c2:	e3a080e7          	jalr	-454(ra) # 4f8 <putc>
 6c6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6c8:	00000b97          	auipc	s7,0x0
 6cc:	430b8b93          	addi	s7,s7,1072 # af8 <digits>
 6d0:	03c9d793          	srli	a5,s3,0x3c
 6d4:	97de                	add	a5,a5,s7
 6d6:	0007c583          	lbu	a1,0(a5)
 6da:	8556                	mv	a0,s5
 6dc:	00000097          	auipc	ra,0x0
 6e0:	e1c080e7          	jalr	-484(ra) # 4f8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6e4:	0992                	slli	s3,s3,0x4
 6e6:	397d                	addiw	s2,s2,-1
 6e8:	fe0914e3          	bnez	s2,6d0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 6ec:	8be2                	mv	s7,s8
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	6c02                	ld	s8,0(sp)
 6f2:	bf09                	j	604 <vprintf+0x42>
        s = va_arg(ap, char*);
 6f4:	008b8993          	addi	s3,s7,8
 6f8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6fc:	02090163          	beqz	s2,71e <vprintf+0x15c>
        while(*s != 0){
 700:	00094583          	lbu	a1,0(s2)
 704:	c9a5                	beqz	a1,774 <vprintf+0x1b2>
          putc(fd, *s);
 706:	8556                	mv	a0,s5
 708:	00000097          	auipc	ra,0x0
 70c:	df0080e7          	jalr	-528(ra) # 4f8 <putc>
          s++;
 710:	0905                	addi	s2,s2,1
        while(*s != 0){
 712:	00094583          	lbu	a1,0(s2)
 716:	f9e5                	bnez	a1,706 <vprintf+0x144>
        s = va_arg(ap, char*);
 718:	8bce                	mv	s7,s3
      state = 0;
 71a:	4981                	li	s3,0
 71c:	b5e5                	j	604 <vprintf+0x42>
          s = "(null)";
 71e:	00000917          	auipc	s2,0x0
 722:	37a90913          	addi	s2,s2,890 # a98 <malloc+0x21e>
        while(*s != 0){
 726:	02800593          	li	a1,40
 72a:	bff1                	j	706 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 72c:	008b8913          	addi	s2,s7,8
 730:	000bc583          	lbu	a1,0(s7)
 734:	8556                	mv	a0,s5
 736:	00000097          	auipc	ra,0x0
 73a:	dc2080e7          	jalr	-574(ra) # 4f8 <putc>
 73e:	8bca                	mv	s7,s2
      state = 0;
 740:	4981                	li	s3,0
 742:	b5c9                	j	604 <vprintf+0x42>
        putc(fd, c);
 744:	02500593          	li	a1,37
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	dae080e7          	jalr	-594(ra) # 4f8 <putc>
      state = 0;
 752:	4981                	li	s3,0
 754:	bd45                	j	604 <vprintf+0x42>
        putc(fd, '%');
 756:	02500593          	li	a1,37
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	d9c080e7          	jalr	-612(ra) # 4f8 <putc>
        putc(fd, c);
 764:	85ca                	mv	a1,s2
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	d90080e7          	jalr	-624(ra) # 4f8 <putc>
      state = 0;
 770:	4981                	li	s3,0
 772:	bd49                	j	604 <vprintf+0x42>
        s = va_arg(ap, char*);
 774:	8bce                	mv	s7,s3
      state = 0;
 776:	4981                	li	s3,0
 778:	b571                	j	604 <vprintf+0x42>
 77a:	74e2                	ld	s1,56(sp)
 77c:	79a2                	ld	s3,40(sp)
 77e:	7a02                	ld	s4,32(sp)
 780:	6ae2                	ld	s5,24(sp)
 782:	6b42                	ld	s6,16(sp)
 784:	6ba2                	ld	s7,8(sp)
    }
  }
}
 786:	60a6                	ld	ra,72(sp)
 788:	6406                	ld	s0,64(sp)
 78a:	7942                	ld	s2,48(sp)
 78c:	6161                	addi	sp,sp,80
 78e:	8082                	ret

0000000000000790 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 790:	715d                	addi	sp,sp,-80
 792:	ec06                	sd	ra,24(sp)
 794:	e822                	sd	s0,16(sp)
 796:	1000                	addi	s0,sp,32
 798:	e010                	sd	a2,0(s0)
 79a:	e414                	sd	a3,8(s0)
 79c:	e818                	sd	a4,16(s0)
 79e:	ec1c                	sd	a5,24(s0)
 7a0:	03043023          	sd	a6,32(s0)
 7a4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7a8:	8622                	mv	a2,s0
 7aa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7ae:	00000097          	auipc	ra,0x0
 7b2:	e14080e7          	jalr	-492(ra) # 5c2 <vprintf>
}
 7b6:	60e2                	ld	ra,24(sp)
 7b8:	6442                	ld	s0,16(sp)
 7ba:	6161                	addi	sp,sp,80
 7bc:	8082                	ret

00000000000007be <printf>:

void
printf(const char *fmt, ...)
{
 7be:	711d                	addi	sp,sp,-96
 7c0:	ec06                	sd	ra,24(sp)
 7c2:	e822                	sd	s0,16(sp)
 7c4:	1000                	addi	s0,sp,32
 7c6:	e40c                	sd	a1,8(s0)
 7c8:	e810                	sd	a2,16(s0)
 7ca:	ec14                	sd	a3,24(s0)
 7cc:	f018                	sd	a4,32(s0)
 7ce:	f41c                	sd	a5,40(s0)
 7d0:	03043823          	sd	a6,48(s0)
 7d4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7d8:	00840613          	addi	a2,s0,8
 7dc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7e0:	85aa                	mv	a1,a0
 7e2:	4505                	li	a0,1
 7e4:	00000097          	auipc	ra,0x0
 7e8:	dde080e7          	jalr	-546(ra) # 5c2 <vprintf>
}
 7ec:	60e2                	ld	ra,24(sp)
 7ee:	6442                	ld	s0,16(sp)
 7f0:	6125                	addi	sp,sp,96
 7f2:	8082                	ret

00000000000007f4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f4:	1141                	addi	sp,sp,-16
 7f6:	e406                	sd	ra,8(sp)
 7f8:	e022                	sd	s0,0(sp)
 7fa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7fc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 800:	00000797          	auipc	a5,0x0
 804:	7187b783          	ld	a5,1816(a5) # f18 <freep>
 808:	a039                	j	816 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80a:	6398                	ld	a4,0(a5)
 80c:	00e7e463          	bltu	a5,a4,814 <free+0x20>
 810:	00e6ea63          	bltu	a3,a4,824 <free+0x30>
{
 814:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 816:	fed7fae3          	bgeu	a5,a3,80a <free+0x16>
 81a:	6398                	ld	a4,0(a5)
 81c:	00e6e463          	bltu	a3,a4,824 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 820:	fee7eae3          	bltu	a5,a4,814 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 824:	ff852583          	lw	a1,-8(a0)
 828:	6390                	ld	a2,0(a5)
 82a:	02059813          	slli	a6,a1,0x20
 82e:	01c85713          	srli	a4,a6,0x1c
 832:	9736                	add	a4,a4,a3
 834:	02e60563          	beq	a2,a4,85e <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 838:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 83c:	4790                	lw	a2,8(a5)
 83e:	02061593          	slli	a1,a2,0x20
 842:	01c5d713          	srli	a4,a1,0x1c
 846:	973e                	add	a4,a4,a5
 848:	02e68263          	beq	a3,a4,86c <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 84c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 84e:	00000717          	auipc	a4,0x0
 852:	6cf73523          	sd	a5,1738(a4) # f18 <freep>
}
 856:	60a2                	ld	ra,8(sp)
 858:	6402                	ld	s0,0(sp)
 85a:	0141                	addi	sp,sp,16
 85c:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 85e:	4618                	lw	a4,8(a2)
 860:	9f2d                	addw	a4,a4,a1
 862:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 866:	6398                	ld	a4,0(a5)
 868:	6310                	ld	a2,0(a4)
 86a:	b7f9                	j	838 <free+0x44>
    p->s.size += bp->s.size;
 86c:	ff852703          	lw	a4,-8(a0)
 870:	9f31                	addw	a4,a4,a2
 872:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 874:	ff053683          	ld	a3,-16(a0)
 878:	bfd1                	j	84c <free+0x58>

000000000000087a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 87a:	7139                	addi	sp,sp,-64
 87c:	fc06                	sd	ra,56(sp)
 87e:	f822                	sd	s0,48(sp)
 880:	f04a                	sd	s2,32(sp)
 882:	ec4e                	sd	s3,24(sp)
 884:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 886:	02051993          	slli	s3,a0,0x20
 88a:	0209d993          	srli	s3,s3,0x20
 88e:	09bd                	addi	s3,s3,15
 890:	0049d993          	srli	s3,s3,0x4
 894:	2985                	addiw	s3,s3,1
 896:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 898:	00000517          	auipc	a0,0x0
 89c:	68053503          	ld	a0,1664(a0) # f18 <freep>
 8a0:	c905                	beqz	a0,8d0 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8a4:	4798                	lw	a4,8(a5)
 8a6:	09377a63          	bgeu	a4,s3,93a <malloc+0xc0>
 8aa:	f426                	sd	s1,40(sp)
 8ac:	e852                	sd	s4,16(sp)
 8ae:	e456                	sd	s5,8(sp)
 8b0:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8b2:	8a4e                	mv	s4,s3
 8b4:	6705                	lui	a4,0x1
 8b6:	00e9f363          	bgeu	s3,a4,8bc <malloc+0x42>
 8ba:	6a05                	lui	s4,0x1
 8bc:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8c0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8c4:	00000497          	auipc	s1,0x0
 8c8:	65448493          	addi	s1,s1,1620 # f18 <freep>
  if(p == (char*)-1)
 8cc:	5afd                	li	s5,-1
 8ce:	a089                	j	910 <malloc+0x96>
 8d0:	f426                	sd	s1,40(sp)
 8d2:	e852                	sd	s4,16(sp)
 8d4:	e456                	sd	s5,8(sp)
 8d6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8d8:	00000797          	auipc	a5,0x0
 8dc:	64878793          	addi	a5,a5,1608 # f20 <base>
 8e0:	00000717          	auipc	a4,0x0
 8e4:	62f73c23          	sd	a5,1592(a4) # f18 <freep>
 8e8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8ea:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8ee:	b7d1                	j	8b2 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8f0:	6398                	ld	a4,0(a5)
 8f2:	e118                	sd	a4,0(a0)
 8f4:	a8b9                	j	952 <malloc+0xd8>
  hp->s.size = nu;
 8f6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8fa:	0541                	addi	a0,a0,16
 8fc:	00000097          	auipc	ra,0x0
 900:	ef8080e7          	jalr	-264(ra) # 7f4 <free>
  return freep;
 904:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 906:	c135                	beqz	a0,96a <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 908:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 90a:	4798                	lw	a4,8(a5)
 90c:	03277363          	bgeu	a4,s2,932 <malloc+0xb8>
    if(p == freep)
 910:	6098                	ld	a4,0(s1)
 912:	853e                	mv	a0,a5
 914:	fef71ae3          	bne	a4,a5,908 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 918:	8552                	mv	a0,s4
 91a:	00000097          	auipc	ra,0x0
 91e:	bc6080e7          	jalr	-1082(ra) # 4e0 <sbrk>
  if(p == (char*)-1)
 922:	fd551ae3          	bne	a0,s5,8f6 <malloc+0x7c>
        return 0;
 926:	4501                	li	a0,0
 928:	74a2                	ld	s1,40(sp)
 92a:	6a42                	ld	s4,16(sp)
 92c:	6aa2                	ld	s5,8(sp)
 92e:	6b02                	ld	s6,0(sp)
 930:	a03d                	j	95e <malloc+0xe4>
 932:	74a2                	ld	s1,40(sp)
 934:	6a42                	ld	s4,16(sp)
 936:	6aa2                	ld	s5,8(sp)
 938:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 93a:	fae90be3          	beq	s2,a4,8f0 <malloc+0x76>
        p->s.size -= nunits;
 93e:	4137073b          	subw	a4,a4,s3
 942:	c798                	sw	a4,8(a5)
        p += p->s.size;
 944:	02071693          	slli	a3,a4,0x20
 948:	01c6d713          	srli	a4,a3,0x1c
 94c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 94e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 952:	00000717          	auipc	a4,0x0
 956:	5ca73323          	sd	a0,1478(a4) # f18 <freep>
      return (void*)(p + 1);
 95a:	01078513          	addi	a0,a5,16
  }
}
 95e:	70e2                	ld	ra,56(sp)
 960:	7442                	ld	s0,48(sp)
 962:	7902                	ld	s2,32(sp)
 964:	69e2                	ld	s3,24(sp)
 966:	6121                	addi	sp,sp,64
 968:	8082                	ret
 96a:	74a2                	ld	s1,40(sp)
 96c:	6a42                	ld	s4,16(sp)
 96e:	6aa2                	ld	s5,8(sp)
 970:	6b02                	ld	s6,0(sp)
 972:	b7f5                	j	95e <malloc+0xe4>
