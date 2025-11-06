
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	fd250a13          	addi	s4,a0,-46
  1a:	001a3a13          	seqz	s4,s4
    if(matchhere(re, text))
  1e:	85a6                	mv	a1,s1
  20:	854e                	mv	a0,s3
  22:	00000097          	auipc	ra,0x0
  26:	02e080e7          	jalr	46(ra) # 50 <matchhere>
  2a:	e911                	bnez	a0,3e <matchstar+0x3e>
  }while(*text!='\0' && (*text++==c || c=='.'));
  2c:	0004c783          	lbu	a5,0(s1)
  30:	cb81                	beqz	a5,40 <matchstar+0x40>
  32:	0485                	addi	s1,s1,1
  34:	ff2785e3          	beq	a5,s2,1e <matchstar+0x1e>
  38:	fe0a13e3          	bnez	s4,1e <matchstar+0x1e>
  3c:	a011                	j	40 <matchstar+0x40>
      return 1;
  3e:	4505                	li	a0,1
  return 0;
}
  40:	70a2                	ld	ra,40(sp)
  42:	7402                	ld	s0,32(sp)
  44:	64e2                	ld	s1,24(sp)
  46:	6942                	ld	s2,16(sp)
  48:	69a2                	ld	s3,8(sp)
  4a:	6a02                	ld	s4,0(sp)
  4c:	6145                	addi	sp,sp,48
  4e:	8082                	ret

0000000000000050 <matchhere>:
  if(re[0] == '\0')
  50:	00054703          	lbu	a4,0(a0)
  54:	c33d                	beqz	a4,ba <matchhere+0x6a>
{
  56:	1141                	addi	sp,sp,-16
  58:	e406                	sd	ra,8(sp)
  5a:	e022                	sd	s0,0(sp)
  5c:	0800                	addi	s0,sp,16
  5e:	87aa                	mv	a5,a0
  if(re[1] == '*')
  60:	00154683          	lbu	a3,1(a0)
  64:	02a00613          	li	a2,42
  68:	02c68363          	beq	a3,a2,8e <matchhere+0x3e>
  if(re[0] == '$' && re[1] == '\0')
  6c:	e681                	bnez	a3,74 <matchhere+0x24>
  6e:	fdc70693          	addi	a3,a4,-36
  72:	c69d                	beqz	a3,a0 <matchhere+0x50>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  74:	0005c683          	lbu	a3,0(a1)
  return 0;
  78:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  7a:	c691                	beqz	a3,86 <matchhere+0x36>
  7c:	02d70763          	beq	a4,a3,aa <matchhere+0x5a>
  80:	fd270713          	addi	a4,a4,-46
  84:	c31d                	beqz	a4,aa <matchhere+0x5a>
}
  86:	60a2                	ld	ra,8(sp)
  88:	6402                	ld	s0,0(sp)
  8a:	0141                	addi	sp,sp,16
  8c:	8082                	ret
    return matchstar(re[0], re+2, text);
  8e:	862e                	mv	a2,a1
  90:	00250593          	addi	a1,a0,2
  94:	853a                	mv	a0,a4
  96:	00000097          	auipc	ra,0x0
  9a:	f6a080e7          	jalr	-150(ra) # 0 <matchstar>
  9e:	b7e5                	j	86 <matchhere+0x36>
    return *text == '\0';
  a0:	0005c503          	lbu	a0,0(a1)
  a4:	00153513          	seqz	a0,a0
  a8:	bff9                	j	86 <matchhere+0x36>
    return matchhere(re+1, text+1);
  aa:	0585                	addi	a1,a1,1
  ac:	00178513          	addi	a0,a5,1
  b0:	00000097          	auipc	ra,0x0
  b4:	fa0080e7          	jalr	-96(ra) # 50 <matchhere>
  b8:	b7f9                	j	86 <matchhere+0x36>
    return 1;
  ba:	4505                	li	a0,1
}
  bc:	8082                	ret

00000000000000be <match>:
{
  be:	1101                	addi	sp,sp,-32
  c0:	ec06                	sd	ra,24(sp)
  c2:	e822                	sd	s0,16(sp)
  c4:	e426                	sd	s1,8(sp)
  c6:	e04a                	sd	s2,0(sp)
  c8:	1000                	addi	s0,sp,32
  ca:	892a                	mv	s2,a0
  cc:	84ae                	mv	s1,a1
  if(re[0] == '^')
  ce:	00054703          	lbu	a4,0(a0)
  d2:	05e00793          	li	a5,94
  d6:	00f70e63          	beq	a4,a5,f2 <match+0x34>
    if(matchhere(re, text))
  da:	85a6                	mv	a1,s1
  dc:	854a                	mv	a0,s2
  de:	00000097          	auipc	ra,0x0
  e2:	f72080e7          	jalr	-142(ra) # 50 <matchhere>
  e6:	ed01                	bnez	a0,fe <match+0x40>
  }while(*text++ != '\0');
  e8:	0485                	addi	s1,s1,1
  ea:	fff4c783          	lbu	a5,-1(s1)
  ee:	f7f5                	bnez	a5,da <match+0x1c>
  f0:	a801                	j	100 <match+0x42>
    return matchhere(re+1, text);
  f2:	0505                	addi	a0,a0,1
  f4:	00000097          	auipc	ra,0x0
  f8:	f5c080e7          	jalr	-164(ra) # 50 <matchhere>
  fc:	a011                	j	100 <match+0x42>
      return 1;
  fe:	4505                	li	a0,1
}
 100:	60e2                	ld	ra,24(sp)
 102:	6442                	ld	s0,16(sp)
 104:	64a2                	ld	s1,8(sp)
 106:	6902                	ld	s2,0(sp)
 108:	6105                	addi	sp,sp,32
 10a:	8082                	ret

000000000000010c <grep>:
{
 10c:	711d                	addi	sp,sp,-96
 10e:	ec86                	sd	ra,88(sp)
 110:	e8a2                	sd	s0,80(sp)
 112:	e4a6                	sd	s1,72(sp)
 114:	e0ca                	sd	s2,64(sp)
 116:	fc4e                	sd	s3,56(sp)
 118:	f852                	sd	s4,48(sp)
 11a:	f456                	sd	s5,40(sp)
 11c:	f05a                	sd	s6,32(sp)
 11e:	ec5e                	sd	s7,24(sp)
 120:	e862                	sd	s8,16(sp)
 122:	e466                	sd	s9,8(sp)
 124:	e06a                	sd	s10,0(sp)
 126:	1080                	addi	s0,sp,96
 128:	8aaa                	mv	s5,a0
 12a:	8cae                	mv	s9,a1
  m = 0;
 12c:	4b01                	li	s6,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 12e:	3ff00d13          	li	s10,1023
 132:	00001b97          	auipc	s7,0x1
 136:	eaeb8b93          	addi	s7,s7,-338 # fe0 <buf>
    while((q = strchr(p, '\n')) != 0){
 13a:	49a9                	li	s3,10
        write(1, p, q+1 - p);
 13c:	4c05                	li	s8,1
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 13e:	a099                	j	184 <grep+0x78>
      p = q+1;
 140:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 144:	85ce                	mv	a1,s3
 146:	854a                	mv	a0,s2
 148:	00000097          	auipc	ra,0x0
 14c:	206080e7          	jalr	518(ra) # 34e <strchr>
 150:	84aa                	mv	s1,a0
 152:	c51d                	beqz	a0,180 <grep+0x74>
      *q = 0;
 154:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 158:	85ca                	mv	a1,s2
 15a:	8556                	mv	a0,s5
 15c:	00000097          	auipc	ra,0x0
 160:	f62080e7          	jalr	-158(ra) # be <match>
 164:	dd71                	beqz	a0,140 <grep+0x34>
        *q = '\n';
 166:	01348023          	sb	s3,0(s1)
        write(1, p, q+1 - p);
 16a:	00148613          	addi	a2,s1,1
 16e:	4126063b          	subw	a2,a2,s2
 172:	85ca                	mv	a1,s2
 174:	8562                	mv	a0,s8
 176:	00000097          	auipc	ra,0x0
 17a:	3e4080e7          	jalr	996(ra) # 55a <write>
 17e:	b7c9                	j	140 <grep+0x34>
    if(m > 0){
 180:	03604663          	bgtz	s6,1ac <grep+0xa0>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 184:	416d063b          	subw	a2,s10,s6
 188:	016b85b3          	add	a1,s7,s6
 18c:	8566                	mv	a0,s9
 18e:	00000097          	auipc	ra,0x0
 192:	3c4080e7          	jalr	964(ra) # 552 <read>
 196:	02a05e63          	blez	a0,1d2 <grep+0xc6>
    m += n;
 19a:	00ab0a3b          	addw	s4,s6,a0
 19e:	8b52                	mv	s6,s4
    buf[m] = '\0';
 1a0:	014b87b3          	add	a5,s7,s4
 1a4:	00078023          	sb	zero,0(a5)
    p = buf;
 1a8:	895e                	mv	s2,s7
    while((q = strchr(p, '\n')) != 0){
 1aa:	bf69                	j	144 <grep+0x38>
      m -= p - buf;
 1ac:	00001797          	auipc	a5,0x1
 1b0:	e3478793          	addi	a5,a5,-460 # fe0 <buf>
 1b4:	40f907b3          	sub	a5,s2,a5
 1b8:	40fa063b          	subw	a2,s4,a5
 1bc:	8b32                	mv	s6,a2
      memmove(buf, p, m);
 1be:	85ca                	mv	a1,s2
 1c0:	00001517          	auipc	a0,0x1
 1c4:	e2050513          	addi	a0,a0,-480 # fe0 <buf>
 1c8:	00000097          	auipc	ra,0x0
 1cc:	2bc080e7          	jalr	700(ra) # 484 <memmove>
 1d0:	bf55                	j	184 <grep+0x78>
}
 1d2:	60e6                	ld	ra,88(sp)
 1d4:	6446                	ld	s0,80(sp)
 1d6:	64a6                	ld	s1,72(sp)
 1d8:	6906                	ld	s2,64(sp)
 1da:	79e2                	ld	s3,56(sp)
 1dc:	7a42                	ld	s4,48(sp)
 1de:	7aa2                	ld	s5,40(sp)
 1e0:	7b02                	ld	s6,32(sp)
 1e2:	6be2                	ld	s7,24(sp)
 1e4:	6c42                	ld	s8,16(sp)
 1e6:	6ca2                	ld	s9,8(sp)
 1e8:	6d02                	ld	s10,0(sp)
 1ea:	6125                	addi	sp,sp,96
 1ec:	8082                	ret

00000000000001ee <main>:
{
 1ee:	7179                	addi	sp,sp,-48
 1f0:	f406                	sd	ra,40(sp)
 1f2:	f022                	sd	s0,32(sp)
 1f4:	ec26                	sd	s1,24(sp)
 1f6:	e84a                	sd	s2,16(sp)
 1f8:	e44e                	sd	s3,8(sp)
 1fa:	e052                	sd	s4,0(sp)
 1fc:	1800                	addi	s0,sp,48
  if(argc <= 1){
 1fe:	4785                	li	a5,1
 200:	04a7de63          	bge	a5,a0,25c <main+0x6e>
  pattern = argv[1];
 204:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 208:	4789                	li	a5,2
 20a:	06a7d763          	bge	a5,a0,278 <main+0x8a>
 20e:	01058913          	addi	s2,a1,16
 212:	ffd5099b          	addiw	s3,a0,-3
 216:	02099793          	slli	a5,s3,0x20
 21a:	01d7d993          	srli	s3,a5,0x1d
 21e:	05e1                	addi	a1,a1,24
 220:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 222:	4581                	li	a1,0
 224:	00093503          	ld	a0,0(s2)
 228:	00000097          	auipc	ra,0x0
 22c:	352080e7          	jalr	850(ra) # 57a <open>
 230:	84aa                	mv	s1,a0
 232:	04054e63          	bltz	a0,28e <main+0xa0>
    grep(pattern, fd);
 236:	85aa                	mv	a1,a0
 238:	8552                	mv	a0,s4
 23a:	00000097          	auipc	ra,0x0
 23e:	ed2080e7          	jalr	-302(ra) # 10c <grep>
    close(fd);
 242:	8526                	mv	a0,s1
 244:	00000097          	auipc	ra,0x0
 248:	31e080e7          	jalr	798(ra) # 562 <close>
  for(i = 2; i < argc; i++){
 24c:	0921                	addi	s2,s2,8
 24e:	fd391ae3          	bne	s2,s3,222 <main+0x34>
  exit(0);
 252:	4501                	li	a0,0
 254:	00000097          	auipc	ra,0x0
 258:	2e6080e7          	jalr	742(ra) # 53a <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 25c:	00000597          	auipc	a1,0x0
 260:	7fc58593          	addi	a1,a1,2044 # a58 <malloc+0xfc>
 264:	4509                	li	a0,2
 266:	00000097          	auipc	ra,0x0
 26a:	60c080e7          	jalr	1548(ra) # 872 <fprintf>
    exit(1);
 26e:	4505                	li	a0,1
 270:	00000097          	auipc	ra,0x0
 274:	2ca080e7          	jalr	714(ra) # 53a <exit>
    grep(pattern, 0);
 278:	4581                	li	a1,0
 27a:	8552                	mv	a0,s4
 27c:	00000097          	auipc	ra,0x0
 280:	e90080e7          	jalr	-368(ra) # 10c <grep>
    exit(0);
 284:	4501                	li	a0,0
 286:	00000097          	auipc	ra,0x0
 28a:	2b4080e7          	jalr	692(ra) # 53a <exit>
      printf("grep: cannot open %s\n", argv[i]);
 28e:	00093583          	ld	a1,0(s2)
 292:	00000517          	auipc	a0,0x0
 296:	7e650513          	addi	a0,a0,2022 # a78 <malloc+0x11c>
 29a:	00000097          	auipc	ra,0x0
 29e:	606080e7          	jalr	1542(ra) # 8a0 <printf>
      exit(1);
 2a2:	4505                	li	a0,1
 2a4:	00000097          	auipc	ra,0x0
 2a8:	296080e7          	jalr	662(ra) # 53a <exit>

00000000000002ac <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2ac:	1141                	addi	sp,sp,-16
 2ae:	e406                	sd	ra,8(sp)
 2b0:	e022                	sd	s0,0(sp)
 2b2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b4:	87aa                	mv	a5,a0
 2b6:	0585                	addi	a1,a1,1
 2b8:	0785                	addi	a5,a5,1
 2ba:	fff5c703          	lbu	a4,-1(a1)
 2be:	fee78fa3          	sb	a4,-1(a5)
 2c2:	fb75                	bnez	a4,2b6 <strcpy+0xa>
    ;
  return os;
}
 2c4:	60a2                	ld	ra,8(sp)
 2c6:	6402                	ld	s0,0(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret

00000000000002cc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2cc:	1141                	addi	sp,sp,-16
 2ce:	e406                	sd	ra,8(sp)
 2d0:	e022                	sd	s0,0(sp)
 2d2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2d4:	00054783          	lbu	a5,0(a0)
 2d8:	cb91                	beqz	a5,2ec <strcmp+0x20>
 2da:	0005c703          	lbu	a4,0(a1)
 2de:	00f71763          	bne	a4,a5,2ec <strcmp+0x20>
    p++, q++;
 2e2:	0505                	addi	a0,a0,1
 2e4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	fbe5                	bnez	a5,2da <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2ec:	0005c503          	lbu	a0,0(a1)
}
 2f0:	40a7853b          	subw	a0,a5,a0
 2f4:	60a2                	ld	ra,8(sp)
 2f6:	6402                	ld	s0,0(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret

00000000000002fc <strlen>:

uint
strlen(const char *s)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e406                	sd	ra,8(sp)
 300:	e022                	sd	s0,0(sp)
 302:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 304:	00054783          	lbu	a5,0(a0)
 308:	cf91                	beqz	a5,324 <strlen+0x28>
 30a:	00150793          	addi	a5,a0,1
 30e:	86be                	mv	a3,a5
 310:	0785                	addi	a5,a5,1
 312:	fff7c703          	lbu	a4,-1(a5)
 316:	ff65                	bnez	a4,30e <strlen+0x12>
 318:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret
  for(n = 0; s[n]; n++)
 324:	4501                	li	a0,0
 326:	bfdd                	j	31c <strlen+0x20>

0000000000000328 <memset>:

void*
memset(void *dst, int c, uint n)
{
 328:	1141                	addi	sp,sp,-16
 32a:	e406                	sd	ra,8(sp)
 32c:	e022                	sd	s0,0(sp)
 32e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 330:	ca19                	beqz	a2,346 <memset+0x1e>
 332:	87aa                	mv	a5,a0
 334:	1602                	slli	a2,a2,0x20
 336:	9201                	srli	a2,a2,0x20
 338:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 33c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 340:	0785                	addi	a5,a5,1
 342:	fee79de3          	bne	a5,a4,33c <memset+0x14>
  }
  return dst;
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <strchr>:

char*
strchr(const char *s, char c)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	addi	s0,sp,16
  for(; *s; s++)
 356:	00054783          	lbu	a5,0(a0)
 35a:	cf81                	beqz	a5,372 <strchr+0x24>
    if(*s == c)
 35c:	00f58763          	beq	a1,a5,36a <strchr+0x1c>
  for(; *s; s++)
 360:	0505                	addi	a0,a0,1
 362:	00054783          	lbu	a5,0(a0)
 366:	fbfd                	bnez	a5,35c <strchr+0xe>
      return (char*)s;
  return 0;
 368:	4501                	li	a0,0
}
 36a:	60a2                	ld	ra,8(sp)
 36c:	6402                	ld	s0,0(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret
  return 0;
 372:	4501                	li	a0,0
 374:	bfdd                	j	36a <strchr+0x1c>

0000000000000376 <gets>:

char*
gets(char *buf, int max)
{
 376:	711d                	addi	sp,sp,-96
 378:	ec86                	sd	ra,88(sp)
 37a:	e8a2                	sd	s0,80(sp)
 37c:	e4a6                	sd	s1,72(sp)
 37e:	e0ca                	sd	s2,64(sp)
 380:	fc4e                	sd	s3,56(sp)
 382:	f852                	sd	s4,48(sp)
 384:	f456                	sd	s5,40(sp)
 386:	f05a                	sd	s6,32(sp)
 388:	ec5e                	sd	s7,24(sp)
 38a:	e862                	sd	s8,16(sp)
 38c:	1080                	addi	s0,sp,96
 38e:	8baa                	mv	s7,a0
 390:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 392:	892a                	mv	s2,a0
 394:	4481                	li	s1,0
    cc = read(0, &c, 1);
 396:	faf40b13          	addi	s6,s0,-81
 39a:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
 39c:	8c26                	mv	s8,s1
 39e:	0014899b          	addiw	s3,s1,1
 3a2:	84ce                	mv	s1,s3
 3a4:	0349d663          	bge	s3,s4,3d0 <gets+0x5a>
    cc = read(0, &c, 1);
 3a8:	8656                	mv	a2,s5
 3aa:	85da                	mv	a1,s6
 3ac:	4501                	li	a0,0
 3ae:	00000097          	auipc	ra,0x0
 3b2:	1a4080e7          	jalr	420(ra) # 552 <read>
    if(cc < 1)
 3b6:	00a05d63          	blez	a0,3d0 <gets+0x5a>
      break;
    buf[i++] = c;
 3ba:	faf44783          	lbu	a5,-81(s0)
 3be:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3c2:	0905                	addi	s2,s2,1
 3c4:	ff678713          	addi	a4,a5,-10
 3c8:	c319                	beqz	a4,3ce <gets+0x58>
 3ca:	17cd                	addi	a5,a5,-13
 3cc:	fbe1                	bnez	a5,39c <gets+0x26>
    buf[i++] = c;
 3ce:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
 3d0:	9c5e                	add	s8,s8,s7
 3d2:	000c0023          	sb	zero,0(s8)
  return buf;
}
 3d6:	855e                	mv	a0,s7
 3d8:	60e6                	ld	ra,88(sp)
 3da:	6446                	ld	s0,80(sp)
 3dc:	64a6                	ld	s1,72(sp)
 3de:	6906                	ld	s2,64(sp)
 3e0:	79e2                	ld	s3,56(sp)
 3e2:	7a42                	ld	s4,48(sp)
 3e4:	7aa2                	ld	s5,40(sp)
 3e6:	7b02                	ld	s6,32(sp)
 3e8:	6be2                	ld	s7,24(sp)
 3ea:	6c42                	ld	s8,16(sp)
 3ec:	6125                	addi	sp,sp,96
 3ee:	8082                	ret

00000000000003f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3f0:	1101                	addi	sp,sp,-32
 3f2:	ec06                	sd	ra,24(sp)
 3f4:	e822                	sd	s0,16(sp)
 3f6:	e04a                	sd	s2,0(sp)
 3f8:	1000                	addi	s0,sp,32
 3fa:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3fc:	4581                	li	a1,0
 3fe:	00000097          	auipc	ra,0x0
 402:	17c080e7          	jalr	380(ra) # 57a <open>
  if(fd < 0)
 406:	02054663          	bltz	a0,432 <stat+0x42>
 40a:	e426                	sd	s1,8(sp)
 40c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 40e:	85ca                	mv	a1,s2
 410:	00000097          	auipc	ra,0x0
 414:	182080e7          	jalr	386(ra) # 592 <fstat>
 418:	892a                	mv	s2,a0
  close(fd);
 41a:	8526                	mv	a0,s1
 41c:	00000097          	auipc	ra,0x0
 420:	146080e7          	jalr	326(ra) # 562 <close>
  return r;
 424:	64a2                	ld	s1,8(sp)
}
 426:	854a                	mv	a0,s2
 428:	60e2                	ld	ra,24(sp)
 42a:	6442                	ld	s0,16(sp)
 42c:	6902                	ld	s2,0(sp)
 42e:	6105                	addi	sp,sp,32
 430:	8082                	ret
    return -1;
 432:	57fd                	li	a5,-1
 434:	893e                	mv	s2,a5
 436:	bfc5                	j	426 <stat+0x36>

0000000000000438 <atoi>:

int
atoi(const char *s)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e406                	sd	ra,8(sp)
 43c:	e022                	sd	s0,0(sp)
 43e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 440:	00054683          	lbu	a3,0(a0)
 444:	fd06879b          	addiw	a5,a3,-48
 448:	0ff7f793          	zext.b	a5,a5
 44c:	4625                	li	a2,9
 44e:	02f66963          	bltu	a2,a5,480 <atoi+0x48>
 452:	872a                	mv	a4,a0
  n = 0;
 454:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 456:	0705                	addi	a4,a4,1
 458:	0025179b          	slliw	a5,a0,0x2
 45c:	9fa9                	addw	a5,a5,a0
 45e:	0017979b          	slliw	a5,a5,0x1
 462:	9fb5                	addw	a5,a5,a3
 464:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 468:	00074683          	lbu	a3,0(a4)
 46c:	fd06879b          	addiw	a5,a3,-48
 470:	0ff7f793          	zext.b	a5,a5
 474:	fef671e3          	bgeu	a2,a5,456 <atoi+0x1e>
  return n;
}
 478:	60a2                	ld	ra,8(sp)
 47a:	6402                	ld	s0,0(sp)
 47c:	0141                	addi	sp,sp,16
 47e:	8082                	ret
  n = 0;
 480:	4501                	li	a0,0
 482:	bfdd                	j	478 <atoi+0x40>

0000000000000484 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 484:	1141                	addi	sp,sp,-16
 486:	e406                	sd	ra,8(sp)
 488:	e022                	sd	s0,0(sp)
 48a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 48c:	02b57563          	bgeu	a0,a1,4b6 <memmove+0x32>
    while(n-- > 0)
 490:	00c05f63          	blez	a2,4ae <memmove+0x2a>
 494:	1602                	slli	a2,a2,0x20
 496:	9201                	srli	a2,a2,0x20
 498:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 49c:	872a                	mv	a4,a0
      *dst++ = *src++;
 49e:	0585                	addi	a1,a1,1
 4a0:	0705                	addi	a4,a4,1
 4a2:	fff5c683          	lbu	a3,-1(a1)
 4a6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4aa:	fee79ae3          	bne	a5,a4,49e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4ae:	60a2                	ld	ra,8(sp)
 4b0:	6402                	ld	s0,0(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret
    while(n-- > 0)
 4b6:	fec05ce3          	blez	a2,4ae <memmove+0x2a>
    dst += n;
 4ba:	00c50733          	add	a4,a0,a2
    src += n;
 4be:	95b2                	add	a1,a1,a2
 4c0:	fff6079b          	addiw	a5,a2,-1
 4c4:	1782                	slli	a5,a5,0x20
 4c6:	9381                	srli	a5,a5,0x20
 4c8:	fff7c793          	not	a5,a5
 4cc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4ce:	15fd                	addi	a1,a1,-1
 4d0:	177d                	addi	a4,a4,-1
 4d2:	0005c683          	lbu	a3,0(a1)
 4d6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4da:	fef71ae3          	bne	a4,a5,4ce <memmove+0x4a>
 4de:	bfc1                	j	4ae <memmove+0x2a>

00000000000004e0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4e0:	1141                	addi	sp,sp,-16
 4e2:	e406                	sd	ra,8(sp)
 4e4:	e022                	sd	s0,0(sp)
 4e6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4e8:	c61d                	beqz	a2,516 <memcmp+0x36>
 4ea:	1602                	slli	a2,a2,0x20
 4ec:	9201                	srli	a2,a2,0x20
 4ee:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
 4f2:	00054783          	lbu	a5,0(a0)
 4f6:	0005c703          	lbu	a4,0(a1)
 4fa:	00e79863          	bne	a5,a4,50a <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
 4fe:	0505                	addi	a0,a0,1
    p2++;
 500:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 502:	fed518e3          	bne	a0,a3,4f2 <memcmp+0x12>
  }
  return 0;
 506:	4501                	li	a0,0
 508:	a019                	j	50e <memcmp+0x2e>
      return *p1 - *p2;
 50a:	40e7853b          	subw	a0,a5,a4
}
 50e:	60a2                	ld	ra,8(sp)
 510:	6402                	ld	s0,0(sp)
 512:	0141                	addi	sp,sp,16
 514:	8082                	ret
  return 0;
 516:	4501                	li	a0,0
 518:	bfdd                	j	50e <memcmp+0x2e>

000000000000051a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 51a:	1141                	addi	sp,sp,-16
 51c:	e406                	sd	ra,8(sp)
 51e:	e022                	sd	s0,0(sp)
 520:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 522:	00000097          	auipc	ra,0x0
 526:	f62080e7          	jalr	-158(ra) # 484 <memmove>
}
 52a:	60a2                	ld	ra,8(sp)
 52c:	6402                	ld	s0,0(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret

0000000000000532 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 532:	4885                	li	a7,1
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <exit>:
.global exit
exit:
 li a7, SYS_exit
 53a:	4889                	li	a7,2
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <wait>:
.global wait
wait:
 li a7, SYS_wait
 542:	488d                	li	a7,3
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 54a:	4891                	li	a7,4
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <read>:
.global read
read:
 li a7, SYS_read
 552:	4895                	li	a7,5
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <write>:
.global write
write:
 li a7, SYS_write
 55a:	48c1                	li	a7,16
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <close>:
.global close
close:
 li a7, SYS_close
 562:	48d5                	li	a7,21
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <kill>:
.global kill
kill:
 li a7, SYS_kill
 56a:	4899                	li	a7,6
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <exec>:
.global exec
exec:
 li a7, SYS_exec
 572:	489d                	li	a7,7
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <open>:
.global open
open:
 li a7, SYS_open
 57a:	48bd                	li	a7,15
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 582:	48c5                	li	a7,17
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 58a:	48c9                	li	a7,18
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 592:	48a1                	li	a7,8
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <link>:
.global link
link:
 li a7, SYS_link
 59a:	48cd                	li	a7,19
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5a2:	48d1                	li	a7,20
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5aa:	48a5                	li	a7,9
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5b2:	48a9                	li	a7,10
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ba:	48ad                	li	a7,11
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5c2:	48b1                	li	a7,12
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ca:	48b5                	li	a7,13
 ecall
 5cc:	00000073          	ecall
 ret
 5d0:	8082                	ret

00000000000005d2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5d2:	48b9                	li	a7,14
 ecall
 5d4:	00000073          	ecall
 ret
 5d8:	8082                	ret

00000000000005da <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5da:	1101                	addi	sp,sp,-32
 5dc:	ec06                	sd	ra,24(sp)
 5de:	e822                	sd	s0,16(sp)
 5e0:	1000                	addi	s0,sp,32
 5e2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5e6:	4605                	li	a2,1
 5e8:	fef40593          	addi	a1,s0,-17
 5ec:	00000097          	auipc	ra,0x0
 5f0:	f6e080e7          	jalr	-146(ra) # 55a <write>
}
 5f4:	60e2                	ld	ra,24(sp)
 5f6:	6442                	ld	s0,16(sp)
 5f8:	6105                	addi	sp,sp,32
 5fa:	8082                	ret

00000000000005fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5fc:	7139                	addi	sp,sp,-64
 5fe:	fc06                	sd	ra,56(sp)
 600:	f822                	sd	s0,48(sp)
 602:	f04a                	sd	s2,32(sp)
 604:	ec4e                	sd	s3,24(sp)
 606:	0080                	addi	s0,sp,64
 608:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 60a:	cad9                	beqz	a3,6a0 <printint+0xa4>
 60c:	01f5d79b          	srliw	a5,a1,0x1f
 610:	cbc1                	beqz	a5,6a0 <printint+0xa4>
    neg = 1;
    x = -xx;
 612:	40b005bb          	negw	a1,a1
    neg = 1;
 616:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
 618:	fc040993          	addi	s3,s0,-64
  neg = 0;
 61c:	86ce                	mv	a3,s3
  i = 0;
 61e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 620:	00000817          	auipc	a6,0x0
 624:	4d080813          	addi	a6,a6,1232 # af0 <digits>
 628:	88ba                	mv	a7,a4
 62a:	0017051b          	addiw	a0,a4,1
 62e:	872a                	mv	a4,a0
 630:	02c5f7bb          	remuw	a5,a1,a2
 634:	1782                	slli	a5,a5,0x20
 636:	9381                	srli	a5,a5,0x20
 638:	97c2                	add	a5,a5,a6
 63a:	0007c783          	lbu	a5,0(a5)
 63e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 642:	87ae                	mv	a5,a1
 644:	02c5d5bb          	divuw	a1,a1,a2
 648:	0685                	addi	a3,a3,1
 64a:	fcc7ffe3          	bgeu	a5,a2,628 <printint+0x2c>
  if(neg)
 64e:	00030c63          	beqz	t1,666 <printint+0x6a>
    buf[i++] = '-';
 652:	fd050793          	addi	a5,a0,-48
 656:	00878533          	add	a0,a5,s0
 65a:	02d00793          	li	a5,45
 65e:	fef50823          	sb	a5,-16(a0)
 662:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
 666:	02e05763          	blez	a4,694 <printint+0x98>
 66a:	f426                	sd	s1,40(sp)
 66c:	377d                	addiw	a4,a4,-1
 66e:	00e984b3          	add	s1,s3,a4
 672:	19fd                	addi	s3,s3,-1
 674:	99ba                	add	s3,s3,a4
 676:	1702                	slli	a4,a4,0x20
 678:	9301                	srli	a4,a4,0x20
 67a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 67e:	0004c583          	lbu	a1,0(s1)
 682:	854a                	mv	a0,s2
 684:	00000097          	auipc	ra,0x0
 688:	f56080e7          	jalr	-170(ra) # 5da <putc>
  while(--i >= 0)
 68c:	14fd                	addi	s1,s1,-1
 68e:	ff3498e3          	bne	s1,s3,67e <printint+0x82>
 692:	74a2                	ld	s1,40(sp)
}
 694:	70e2                	ld	ra,56(sp)
 696:	7442                	ld	s0,48(sp)
 698:	7902                	ld	s2,32(sp)
 69a:	69e2                	ld	s3,24(sp)
 69c:	6121                	addi	sp,sp,64
 69e:	8082                	ret
  neg = 0;
 6a0:	4301                	li	t1,0
 6a2:	bf9d                	j	618 <printint+0x1c>

00000000000006a4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6a4:	715d                	addi	sp,sp,-80
 6a6:	e486                	sd	ra,72(sp)
 6a8:	e0a2                	sd	s0,64(sp)
 6aa:	f84a                	sd	s2,48(sp)
 6ac:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6ae:	0005c903          	lbu	s2,0(a1)
 6b2:	1a090b63          	beqz	s2,868 <vprintf+0x1c4>
 6b6:	fc26                	sd	s1,56(sp)
 6b8:	f44e                	sd	s3,40(sp)
 6ba:	f052                	sd	s4,32(sp)
 6bc:	ec56                	sd	s5,24(sp)
 6be:	e85a                	sd	s6,16(sp)
 6c0:	e45e                	sd	s7,8(sp)
 6c2:	8aaa                	mv	s5,a0
 6c4:	8bb2                	mv	s7,a2
 6c6:	00158493          	addi	s1,a1,1
  state = 0;
 6ca:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6cc:	02500a13          	li	s4,37
 6d0:	4b55                	li	s6,21
 6d2:	a839                	j	6f0 <vprintf+0x4c>
        putc(fd, c);
 6d4:	85ca                	mv	a1,s2
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	f02080e7          	jalr	-254(ra) # 5da <putc>
 6e0:	a019                	j	6e6 <vprintf+0x42>
    } else if(state == '%'){
 6e2:	01498d63          	beq	s3,s4,6fc <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 6e6:	0485                	addi	s1,s1,1
 6e8:	fff4c903          	lbu	s2,-1(s1)
 6ec:	16090863          	beqz	s2,85c <vprintf+0x1b8>
    if(state == 0){
 6f0:	fe0999e3          	bnez	s3,6e2 <vprintf+0x3e>
      if(c == '%'){
 6f4:	ff4910e3          	bne	s2,s4,6d4 <vprintf+0x30>
        state = '%';
 6f8:	89d2                	mv	s3,s4
 6fa:	b7f5                	j	6e6 <vprintf+0x42>
      if(c == 'd'){
 6fc:	13490563          	beq	s2,s4,826 <vprintf+0x182>
 700:	f9d9079b          	addiw	a5,s2,-99
 704:	0ff7f793          	zext.b	a5,a5
 708:	12fb6863          	bltu	s6,a5,838 <vprintf+0x194>
 70c:	f9d9079b          	addiw	a5,s2,-99
 710:	0ff7f713          	zext.b	a4,a5
 714:	12eb6263          	bltu	s6,a4,838 <vprintf+0x194>
 718:	00271793          	slli	a5,a4,0x2
 71c:	00000717          	auipc	a4,0x0
 720:	37c70713          	addi	a4,a4,892 # a98 <malloc+0x13c>
 724:	97ba                	add	a5,a5,a4
 726:	439c                	lw	a5,0(a5)
 728:	97ba                	add	a5,a5,a4
 72a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 72c:	008b8913          	addi	s2,s7,8
 730:	4685                	li	a3,1
 732:	4629                	li	a2,10
 734:	000ba583          	lw	a1,0(s7)
 738:	8556                	mv	a0,s5
 73a:	00000097          	auipc	ra,0x0
 73e:	ec2080e7          	jalr	-318(ra) # 5fc <printint>
 742:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 744:	4981                	li	s3,0
 746:	b745                	j	6e6 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 748:	008b8913          	addi	s2,s7,8
 74c:	4681                	li	a3,0
 74e:	4629                	li	a2,10
 750:	000ba583          	lw	a1,0(s7)
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	ea6080e7          	jalr	-346(ra) # 5fc <printint>
 75e:	8bca                	mv	s7,s2
      state = 0;
 760:	4981                	li	s3,0
 762:	b751                	j	6e6 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 764:	008b8913          	addi	s2,s7,8
 768:	4681                	li	a3,0
 76a:	4641                	li	a2,16
 76c:	000ba583          	lw	a1,0(s7)
 770:	8556                	mv	a0,s5
 772:	00000097          	auipc	ra,0x0
 776:	e8a080e7          	jalr	-374(ra) # 5fc <printint>
 77a:	8bca                	mv	s7,s2
      state = 0;
 77c:	4981                	li	s3,0
 77e:	b7a5                	j	6e6 <vprintf+0x42>
 780:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 782:	008b8793          	addi	a5,s7,8
 786:	8c3e                	mv	s8,a5
 788:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 78c:	03000593          	li	a1,48
 790:	8556                	mv	a0,s5
 792:	00000097          	auipc	ra,0x0
 796:	e48080e7          	jalr	-440(ra) # 5da <putc>
  putc(fd, 'x');
 79a:	07800593          	li	a1,120
 79e:	8556                	mv	a0,s5
 7a0:	00000097          	auipc	ra,0x0
 7a4:	e3a080e7          	jalr	-454(ra) # 5da <putc>
 7a8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7aa:	00000b97          	auipc	s7,0x0
 7ae:	346b8b93          	addi	s7,s7,838 # af0 <digits>
 7b2:	03c9d793          	srli	a5,s3,0x3c
 7b6:	97de                	add	a5,a5,s7
 7b8:	0007c583          	lbu	a1,0(a5)
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	e1c080e7          	jalr	-484(ra) # 5da <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c6:	0992                	slli	s3,s3,0x4
 7c8:	397d                	addiw	s2,s2,-1
 7ca:	fe0914e3          	bnez	s2,7b2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
 7ce:	8be2                	mv	s7,s8
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	6c02                	ld	s8,0(sp)
 7d4:	bf09                	j	6e6 <vprintf+0x42>
        s = va_arg(ap, char*);
 7d6:	008b8993          	addi	s3,s7,8
 7da:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 7de:	02090163          	beqz	s2,800 <vprintf+0x15c>
        while(*s != 0){
 7e2:	00094583          	lbu	a1,0(s2)
 7e6:	c9a5                	beqz	a1,856 <vprintf+0x1b2>
          putc(fd, *s);
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	df0080e7          	jalr	-528(ra) # 5da <putc>
          s++;
 7f2:	0905                	addi	s2,s2,1
        while(*s != 0){
 7f4:	00094583          	lbu	a1,0(s2)
 7f8:	f9e5                	bnez	a1,7e8 <vprintf+0x144>
        s = va_arg(ap, char*);
 7fa:	8bce                	mv	s7,s3
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	b5e5                	j	6e6 <vprintf+0x42>
          s = "(null)";
 800:	00000917          	auipc	s2,0x0
 804:	29090913          	addi	s2,s2,656 # a90 <malloc+0x134>
        while(*s != 0){
 808:	02800593          	li	a1,40
 80c:	bff1                	j	7e8 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
 80e:	008b8913          	addi	s2,s7,8
 812:	000bc583          	lbu	a1,0(s7)
 816:	8556                	mv	a0,s5
 818:	00000097          	auipc	ra,0x0
 81c:	dc2080e7          	jalr	-574(ra) # 5da <putc>
 820:	8bca                	mv	s7,s2
      state = 0;
 822:	4981                	li	s3,0
 824:	b5c9                	j	6e6 <vprintf+0x42>
        putc(fd, c);
 826:	02500593          	li	a1,37
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	dae080e7          	jalr	-594(ra) # 5da <putc>
      state = 0;
 834:	4981                	li	s3,0
 836:	bd45                	j	6e6 <vprintf+0x42>
        putc(fd, '%');
 838:	02500593          	li	a1,37
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	d9c080e7          	jalr	-612(ra) # 5da <putc>
        putc(fd, c);
 846:	85ca                	mv	a1,s2
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	d90080e7          	jalr	-624(ra) # 5da <putc>
      state = 0;
 852:	4981                	li	s3,0
 854:	bd49                	j	6e6 <vprintf+0x42>
        s = va_arg(ap, char*);
 856:	8bce                	mv	s7,s3
      state = 0;
 858:	4981                	li	s3,0
 85a:	b571                	j	6e6 <vprintf+0x42>
 85c:	74e2                	ld	s1,56(sp)
 85e:	79a2                	ld	s3,40(sp)
 860:	7a02                	ld	s4,32(sp)
 862:	6ae2                	ld	s5,24(sp)
 864:	6b42                	ld	s6,16(sp)
 866:	6ba2                	ld	s7,8(sp)
    }
  }
}
 868:	60a6                	ld	ra,72(sp)
 86a:	6406                	ld	s0,64(sp)
 86c:	7942                	ld	s2,48(sp)
 86e:	6161                	addi	sp,sp,80
 870:	8082                	ret

0000000000000872 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 872:	715d                	addi	sp,sp,-80
 874:	ec06                	sd	ra,24(sp)
 876:	e822                	sd	s0,16(sp)
 878:	1000                	addi	s0,sp,32
 87a:	e010                	sd	a2,0(s0)
 87c:	e414                	sd	a3,8(s0)
 87e:	e818                	sd	a4,16(s0)
 880:	ec1c                	sd	a5,24(s0)
 882:	03043023          	sd	a6,32(s0)
 886:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 88a:	8622                	mv	a2,s0
 88c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 890:	00000097          	auipc	ra,0x0
 894:	e14080e7          	jalr	-492(ra) # 6a4 <vprintf>
}
 898:	60e2                	ld	ra,24(sp)
 89a:	6442                	ld	s0,16(sp)
 89c:	6161                	addi	sp,sp,80
 89e:	8082                	ret

00000000000008a0 <printf>:

void
printf(const char *fmt, ...)
{
 8a0:	711d                	addi	sp,sp,-96
 8a2:	ec06                	sd	ra,24(sp)
 8a4:	e822                	sd	s0,16(sp)
 8a6:	1000                	addi	s0,sp,32
 8a8:	e40c                	sd	a1,8(s0)
 8aa:	e810                	sd	a2,16(s0)
 8ac:	ec14                	sd	a3,24(s0)
 8ae:	f018                	sd	a4,32(s0)
 8b0:	f41c                	sd	a5,40(s0)
 8b2:	03043823          	sd	a6,48(s0)
 8b6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ba:	00840613          	addi	a2,s0,8
 8be:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8c2:	85aa                	mv	a1,a0
 8c4:	4505                	li	a0,1
 8c6:	00000097          	auipc	ra,0x0
 8ca:	dde080e7          	jalr	-546(ra) # 6a4 <vprintf>
}
 8ce:	60e2                	ld	ra,24(sp)
 8d0:	6442                	ld	s0,16(sp)
 8d2:	6125                	addi	sp,sp,96
 8d4:	8082                	ret

00000000000008d6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d6:	1141                	addi	sp,sp,-16
 8d8:	e406                	sd	ra,8(sp)
 8da:	e022                	sd	s0,0(sp)
 8dc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8de:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e2:	00000797          	auipc	a5,0x0
 8e6:	6f67b783          	ld	a5,1782(a5) # fd8 <freep>
 8ea:	a039                	j	8f8 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ec:	6398                	ld	a4,0(a5)
 8ee:	00e7e463          	bltu	a5,a4,8f6 <free+0x20>
 8f2:	00e6ea63          	bltu	a3,a4,906 <free+0x30>
{
 8f6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f8:	fed7fae3          	bgeu	a5,a3,8ec <free+0x16>
 8fc:	6398                	ld	a4,0(a5)
 8fe:	00e6e463          	bltu	a3,a4,906 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 902:	fee7eae3          	bltu	a5,a4,8f6 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 906:	ff852583          	lw	a1,-8(a0)
 90a:	6390                	ld	a2,0(a5)
 90c:	02059813          	slli	a6,a1,0x20
 910:	01c85713          	srli	a4,a6,0x1c
 914:	9736                	add	a4,a4,a3
 916:	02e60563          	beq	a2,a4,940 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 91a:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 91e:	4790                	lw	a2,8(a5)
 920:	02061593          	slli	a1,a2,0x20
 924:	01c5d713          	srli	a4,a1,0x1c
 928:	973e                	add	a4,a4,a5
 92a:	02e68263          	beq	a3,a4,94e <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 92e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 930:	00000717          	auipc	a4,0x0
 934:	6af73423          	sd	a5,1704(a4) # fd8 <freep>
}
 938:	60a2                	ld	ra,8(sp)
 93a:	6402                	ld	s0,0(sp)
 93c:	0141                	addi	sp,sp,16
 93e:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
 940:	4618                	lw	a4,8(a2)
 942:	9f2d                	addw	a4,a4,a1
 944:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 948:	6398                	ld	a4,0(a5)
 94a:	6310                	ld	a2,0(a4)
 94c:	b7f9                	j	91a <free+0x44>
    p->s.size += bp->s.size;
 94e:	ff852703          	lw	a4,-8(a0)
 952:	9f31                	addw	a4,a4,a2
 954:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 956:	ff053683          	ld	a3,-16(a0)
 95a:	bfd1                	j	92e <free+0x58>

000000000000095c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 95c:	7139                	addi	sp,sp,-64
 95e:	fc06                	sd	ra,56(sp)
 960:	f822                	sd	s0,48(sp)
 962:	f04a                	sd	s2,32(sp)
 964:	ec4e                	sd	s3,24(sp)
 966:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 968:	02051993          	slli	s3,a0,0x20
 96c:	0209d993          	srli	s3,s3,0x20
 970:	09bd                	addi	s3,s3,15
 972:	0049d993          	srli	s3,s3,0x4
 976:	2985                	addiw	s3,s3,1
 978:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 97a:	00000517          	auipc	a0,0x0
 97e:	65e53503          	ld	a0,1630(a0) # fd8 <freep>
 982:	c905                	beqz	a0,9b2 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 984:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 986:	4798                	lw	a4,8(a5)
 988:	09377a63          	bgeu	a4,s3,a1c <malloc+0xc0>
 98c:	f426                	sd	s1,40(sp)
 98e:	e852                	sd	s4,16(sp)
 990:	e456                	sd	s5,8(sp)
 992:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 994:	8a4e                	mv	s4,s3
 996:	6705                	lui	a4,0x1
 998:	00e9f363          	bgeu	s3,a4,99e <malloc+0x42>
 99c:	6a05                	lui	s4,0x1
 99e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9a2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a6:	00000497          	auipc	s1,0x0
 9aa:	63248493          	addi	s1,s1,1586 # fd8 <freep>
  if(p == (char*)-1)
 9ae:	5afd                	li	s5,-1
 9b0:	a089                	j	9f2 <malloc+0x96>
 9b2:	f426                	sd	s1,40(sp)
 9b4:	e852                	sd	s4,16(sp)
 9b6:	e456                	sd	s5,8(sp)
 9b8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9ba:	00001797          	auipc	a5,0x1
 9be:	a2678793          	addi	a5,a5,-1498 # 13e0 <base>
 9c2:	00000717          	auipc	a4,0x0
 9c6:	60f73b23          	sd	a5,1558(a4) # fd8 <freep>
 9ca:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9cc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9d0:	b7d1                	j	994 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 9d2:	6398                	ld	a4,0(a5)
 9d4:	e118                	sd	a4,0(a0)
 9d6:	a8b9                	j	a34 <malloc+0xd8>
  hp->s.size = nu;
 9d8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9dc:	0541                	addi	a0,a0,16
 9de:	00000097          	auipc	ra,0x0
 9e2:	ef8080e7          	jalr	-264(ra) # 8d6 <free>
  return freep;
 9e6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9e8:	c135                	beqz	a0,a4c <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9ea:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ec:	4798                	lw	a4,8(a5)
 9ee:	03277363          	bgeu	a4,s2,a14 <malloc+0xb8>
    if(p == freep)
 9f2:	6098                	ld	a4,0(s1)
 9f4:	853e                	mv	a0,a5
 9f6:	fef71ae3          	bne	a4,a5,9ea <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9fa:	8552                	mv	a0,s4
 9fc:	00000097          	auipc	ra,0x0
 a00:	bc6080e7          	jalr	-1082(ra) # 5c2 <sbrk>
  if(p == (char*)-1)
 a04:	fd551ae3          	bne	a0,s5,9d8 <malloc+0x7c>
        return 0;
 a08:	4501                	li	a0,0
 a0a:	74a2                	ld	s1,40(sp)
 a0c:	6a42                	ld	s4,16(sp)
 a0e:	6aa2                	ld	s5,8(sp)
 a10:	6b02                	ld	s6,0(sp)
 a12:	a03d                	j	a40 <malloc+0xe4>
 a14:	74a2                	ld	s1,40(sp)
 a16:	6a42                	ld	s4,16(sp)
 a18:	6aa2                	ld	s5,8(sp)
 a1a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a1c:	fae90be3          	beq	s2,a4,9d2 <malloc+0x76>
        p->s.size -= nunits;
 a20:	4137073b          	subw	a4,a4,s3
 a24:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a26:	02071693          	slli	a3,a4,0x20
 a2a:	01c6d713          	srli	a4,a3,0x1c
 a2e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a30:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a34:	00000717          	auipc	a4,0x0
 a38:	5aa73223          	sd	a0,1444(a4) # fd8 <freep>
      return (void*)(p + 1);
 a3c:	01078513          	addi	a0,a5,16
  }
}
 a40:	70e2                	ld	ra,56(sp)
 a42:	7442                	ld	s0,48(sp)
 a44:	7902                	ld	s2,32(sp)
 a46:	69e2                	ld	s3,24(sp)
 a48:	6121                	addi	sp,sp,64
 a4a:	8082                	ret
 a4c:	74a2                	ld	s1,40(sp)
 a4e:	6a42                	ld	s4,16(sp)
 a50:	6aa2                	ld	s5,8(sp)
 a52:	6b02                	ld	s6,0(sp)
 a54:	b7f5                	j	a40 <malloc+0xe4>
