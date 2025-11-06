
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	7139                	addi	sp,sp,-64
       2:	fc06                	sd	ra,56(sp)
       4:	f822                	sd	s0,48(sp)
       6:	f426                	sd	s1,40(sp)
       8:	f04a                	sd	s2,32(sp)
       a:	ec4e                	sd	s3,24(sp)
       c:	0080                	addi	s0,sp,64
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
       e:	4785                	li	a5,1
      10:	07fe                	slli	a5,a5,0x1f
      12:	fcf43023          	sd	a5,-64(s0)
      16:	57fd                	li	a5,-1
      18:	fcf43423          	sd	a5,-56(s0)

  for(int ai = 0; ai < 2; ai++){
      1c:	fc040493          	addi	s1,s0,-64
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      20:	20100993          	li	s3,513
    uint64 addr = addrs[ai];
      24:	0004b903          	ld	s2,0(s1)
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      28:	85ce                	mv	a1,s3
      2a:	854a                	mv	a0,s2
      2c:	00006097          	auipc	ra,0x6
      30:	b28080e7          	jalr	-1240(ra) # 5b54 <open>
    if(fd >= 0){
      34:	00055e63          	bgez	a0,50 <copyinstr1+0x50>
  for(int ai = 0; ai < 2; ai++){
      38:	04a1                	addi	s1,s1,8
      3a:	fd040793          	addi	a5,s0,-48
      3e:	fef493e3          	bne	s1,a5,24 <copyinstr1+0x24>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      42:	70e2                	ld	ra,56(sp)
      44:	7442                	ld	s0,48(sp)
      46:	74a2                	ld	s1,40(sp)
      48:	7902                	ld	s2,32(sp)
      4a:	69e2                	ld	s3,24(sp)
      4c:	6121                	addi	sp,sp,64
      4e:	8082                	ret
      printf("open(%p) returned %d, not -1\n", addr, fd);
      50:	862a                	mv	a2,a0
      52:	85ca                	mv	a1,s2
      54:	00006517          	auipc	a0,0x6
      58:	fdc50513          	addi	a0,a0,-36 # 6030 <malloc+0xfa>
      5c:	00006097          	auipc	ra,0x6
      60:	e1e080e7          	jalr	-482(ra) # 5e7a <printf>
      exit(1);
      64:	4505                	li	a0,1
      66:	00006097          	auipc	ra,0x6
      6a:	aae080e7          	jalr	-1362(ra) # 5b14 <exit>

000000000000006e <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      6e:	0000b797          	auipc	a5,0xb
      72:	cd278793          	addi	a5,a5,-814 # ad40 <uninit>
      76:	0000d697          	auipc	a3,0xd
      7a:	3da68693          	addi	a3,a3,986 # d450 <buf>
    if(uninit[i] != '\0'){
      7e:	0007c703          	lbu	a4,0(a5)
      82:	e709                	bnez	a4,8c <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      84:	0785                	addi	a5,a5,1
      86:	fed79ce3          	bne	a5,a3,7e <bsstest+0x10>
      8a:	8082                	ret
{
      8c:	1141                	addi	sp,sp,-16
      8e:	e406                	sd	ra,8(sp)
      90:	e022                	sd	s0,0(sp)
      92:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      94:	85aa                	mv	a1,a0
      96:	00006517          	auipc	a0,0x6
      9a:	fba50513          	addi	a0,a0,-70 # 6050 <malloc+0x11a>
      9e:	00006097          	auipc	ra,0x6
      a2:	ddc080e7          	jalr	-548(ra) # 5e7a <printf>
      exit(1);
      a6:	4505                	li	a0,1
      a8:	00006097          	auipc	ra,0x6
      ac:	a6c080e7          	jalr	-1428(ra) # 5b14 <exit>

00000000000000b0 <opentest>:
{
      b0:	1101                	addi	sp,sp,-32
      b2:	ec06                	sd	ra,24(sp)
      b4:	e822                	sd	s0,16(sp)
      b6:	e426                	sd	s1,8(sp)
      b8:	1000                	addi	s0,sp,32
      ba:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      bc:	4581                	li	a1,0
      be:	00006517          	auipc	a0,0x6
      c2:	faa50513          	addi	a0,a0,-86 # 6068 <malloc+0x132>
      c6:	00006097          	auipc	ra,0x6
      ca:	a8e080e7          	jalr	-1394(ra) # 5b54 <open>
  if(fd < 0){
      ce:	02054663          	bltz	a0,fa <opentest+0x4a>
  close(fd);
      d2:	00006097          	auipc	ra,0x6
      d6:	a6a080e7          	jalr	-1430(ra) # 5b3c <close>
  fd = open("doesnotexist", 0);
      da:	4581                	li	a1,0
      dc:	00006517          	auipc	a0,0x6
      e0:	fac50513          	addi	a0,a0,-84 # 6088 <malloc+0x152>
      e4:	00006097          	auipc	ra,0x6
      e8:	a70080e7          	jalr	-1424(ra) # 5b54 <open>
  if(fd >= 0){
      ec:	02055563          	bgez	a0,116 <opentest+0x66>
}
      f0:	60e2                	ld	ra,24(sp)
      f2:	6442                	ld	s0,16(sp)
      f4:	64a2                	ld	s1,8(sp)
      f6:	6105                	addi	sp,sp,32
      f8:	8082                	ret
    printf("%s: open echo failed!\n", s);
      fa:	85a6                	mv	a1,s1
      fc:	00006517          	auipc	a0,0x6
     100:	f7450513          	addi	a0,a0,-140 # 6070 <malloc+0x13a>
     104:	00006097          	auipc	ra,0x6
     108:	d76080e7          	jalr	-650(ra) # 5e7a <printf>
    exit(1);
     10c:	4505                	li	a0,1
     10e:	00006097          	auipc	ra,0x6
     112:	a06080e7          	jalr	-1530(ra) # 5b14 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     116:	85a6                	mv	a1,s1
     118:	00006517          	auipc	a0,0x6
     11c:	f8050513          	addi	a0,a0,-128 # 6098 <malloc+0x162>
     120:	00006097          	auipc	ra,0x6
     124:	d5a080e7          	jalr	-678(ra) # 5e7a <printf>
    exit(1);
     128:	4505                	li	a0,1
     12a:	00006097          	auipc	ra,0x6
     12e:	9ea080e7          	jalr	-1558(ra) # 5b14 <exit>

0000000000000132 <truncate2>:
{
     132:	7179                	addi	sp,sp,-48
     134:	f406                	sd	ra,40(sp)
     136:	f022                	sd	s0,32(sp)
     138:	ec26                	sd	s1,24(sp)
     13a:	e84a                	sd	s2,16(sp)
     13c:	e44e                	sd	s3,8(sp)
     13e:	1800                	addi	s0,sp,48
     140:	89aa                	mv	s3,a0
  unlink("truncfile");
     142:	00006517          	auipc	a0,0x6
     146:	f7e50513          	addi	a0,a0,-130 # 60c0 <malloc+0x18a>
     14a:	00006097          	auipc	ra,0x6
     14e:	a1a080e7          	jalr	-1510(ra) # 5b64 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     152:	60100593          	li	a1,1537
     156:	00006517          	auipc	a0,0x6
     15a:	f6a50513          	addi	a0,a0,-150 # 60c0 <malloc+0x18a>
     15e:	00006097          	auipc	ra,0x6
     162:	9f6080e7          	jalr	-1546(ra) # 5b54 <open>
     166:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     168:	4611                	li	a2,4
     16a:	00006597          	auipc	a1,0x6
     16e:	f6658593          	addi	a1,a1,-154 # 60d0 <malloc+0x19a>
     172:	00006097          	auipc	ra,0x6
     176:	9c2080e7          	jalr	-1598(ra) # 5b34 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     17a:	40100593          	li	a1,1025
     17e:	00006517          	auipc	a0,0x6
     182:	f4250513          	addi	a0,a0,-190 # 60c0 <malloc+0x18a>
     186:	00006097          	auipc	ra,0x6
     18a:	9ce080e7          	jalr	-1586(ra) # 5b54 <open>
     18e:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     190:	4605                	li	a2,1
     192:	00006597          	auipc	a1,0x6
     196:	f4658593          	addi	a1,a1,-186 # 60d8 <malloc+0x1a2>
     19a:	8526                	mv	a0,s1
     19c:	00006097          	auipc	ra,0x6
     1a0:	998080e7          	jalr	-1640(ra) # 5b34 <write>
  if(n != -1){
     1a4:	57fd                	li	a5,-1
     1a6:	02f51b63          	bne	a0,a5,1dc <truncate2+0xaa>
  unlink("truncfile");
     1aa:	00006517          	auipc	a0,0x6
     1ae:	f1650513          	addi	a0,a0,-234 # 60c0 <malloc+0x18a>
     1b2:	00006097          	auipc	ra,0x6
     1b6:	9b2080e7          	jalr	-1614(ra) # 5b64 <unlink>
  close(fd1);
     1ba:	8526                	mv	a0,s1
     1bc:	00006097          	auipc	ra,0x6
     1c0:	980080e7          	jalr	-1664(ra) # 5b3c <close>
  close(fd2);
     1c4:	854a                	mv	a0,s2
     1c6:	00006097          	auipc	ra,0x6
     1ca:	976080e7          	jalr	-1674(ra) # 5b3c <close>
}
     1ce:	70a2                	ld	ra,40(sp)
     1d0:	7402                	ld	s0,32(sp)
     1d2:	64e2                	ld	s1,24(sp)
     1d4:	6942                	ld	s2,16(sp)
     1d6:	69a2                	ld	s3,8(sp)
     1d8:	6145                	addi	sp,sp,48
     1da:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1dc:	862a                	mv	a2,a0
     1de:	85ce                	mv	a1,s3
     1e0:	00006517          	auipc	a0,0x6
     1e4:	f0050513          	addi	a0,a0,-256 # 60e0 <malloc+0x1aa>
     1e8:	00006097          	auipc	ra,0x6
     1ec:	c92080e7          	jalr	-878(ra) # 5e7a <printf>
    exit(1);
     1f0:	4505                	li	a0,1
     1f2:	00006097          	auipc	ra,0x6
     1f6:	922080e7          	jalr	-1758(ra) # 5b14 <exit>

00000000000001fa <createtest>:
{
     1fa:	7139                	addi	sp,sp,-64
     1fc:	fc06                	sd	ra,56(sp)
     1fe:	f822                	sd	s0,48(sp)
     200:	f426                	sd	s1,40(sp)
     202:	f04a                	sd	s2,32(sp)
     204:	ec4e                	sd	s3,24(sp)
     206:	e852                	sd	s4,16(sp)
     208:	0080                	addi	s0,sp,64
  name[0] = 'a';
     20a:	06100793          	li	a5,97
     20e:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     212:	fc040523          	sb	zero,-54(s0)
     216:	03000493          	li	s1,48
    fd = open(name, O_CREATE|O_RDWR);
     21a:	fc840a13          	addi	s4,s0,-56
     21e:	20200993          	li	s3,514
  for(i = 0; i < N; i++){
     222:	06400913          	li	s2,100
    name[1] = '0' + i;
     226:	fc9404a3          	sb	s1,-55(s0)
    fd = open(name, O_CREATE|O_RDWR);
     22a:	85ce                	mv	a1,s3
     22c:	8552                	mv	a0,s4
     22e:	00006097          	auipc	ra,0x6
     232:	926080e7          	jalr	-1754(ra) # 5b54 <open>
    close(fd);
     236:	00006097          	auipc	ra,0x6
     23a:	906080e7          	jalr	-1786(ra) # 5b3c <close>
  for(i = 0; i < N; i++){
     23e:	2485                	addiw	s1,s1,1
     240:	0ff4f493          	zext.b	s1,s1
     244:	ff2491e3          	bne	s1,s2,226 <createtest+0x2c>
  name[0] = 'a';
     248:	06100793          	li	a5,97
     24c:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     250:	fc040523          	sb	zero,-54(s0)
     254:	03000493          	li	s1,48
    unlink(name);
     258:	fc840993          	addi	s3,s0,-56
  for(i = 0; i < N; i++){
     25c:	06400913          	li	s2,100
    name[1] = '0' + i;
     260:	fc9404a3          	sb	s1,-55(s0)
    unlink(name);
     264:	854e                	mv	a0,s3
     266:	00006097          	auipc	ra,0x6
     26a:	8fe080e7          	jalr	-1794(ra) # 5b64 <unlink>
  for(i = 0; i < N; i++){
     26e:	2485                	addiw	s1,s1,1
     270:	0ff4f493          	zext.b	s1,s1
     274:	ff2496e3          	bne	s1,s2,260 <createtest+0x66>
}
     278:	70e2                	ld	ra,56(sp)
     27a:	7442                	ld	s0,48(sp)
     27c:	74a2                	ld	s1,40(sp)
     27e:	7902                	ld	s2,32(sp)
     280:	69e2                	ld	s3,24(sp)
     282:	6a42                	ld	s4,16(sp)
     284:	6121                	addi	sp,sp,64
     286:	8082                	ret

0000000000000288 <bigwrite>:
{
     288:	711d                	addi	sp,sp,-96
     28a:	ec86                	sd	ra,88(sp)
     28c:	e8a2                	sd	s0,80(sp)
     28e:	e4a6                	sd	s1,72(sp)
     290:	e0ca                	sd	s2,64(sp)
     292:	fc4e                	sd	s3,56(sp)
     294:	f852                	sd	s4,48(sp)
     296:	f456                	sd	s5,40(sp)
     298:	f05a                	sd	s6,32(sp)
     29a:	ec5e                	sd	s7,24(sp)
     29c:	e862                	sd	s8,16(sp)
     29e:	e466                	sd	s9,8(sp)
     2a0:	1080                	addi	s0,sp,96
     2a2:	8caa                	mv	s9,a0
  unlink("bigwrite");
     2a4:	00006517          	auipc	a0,0x6
     2a8:	e6450513          	addi	a0,a0,-412 # 6108 <malloc+0x1d2>
     2ac:	00006097          	auipc	ra,0x6
     2b0:	8b8080e7          	jalr	-1864(ra) # 5b64 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2b4:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2b8:	20200b93          	li	s7,514
     2bc:	00006a17          	auipc	s4,0x6
     2c0:	e4ca0a13          	addi	s4,s4,-436 # 6108 <malloc+0x1d2>
     2c4:	4b09                	li	s6,2
      int cc = write(fd, buf, sz);
     2c6:	0000d997          	auipc	s3,0xd
     2ca:	18a98993          	addi	s3,s3,394 # d450 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2ce:	6a8d                	lui	s5,0x3
     2d0:	1c9a8a93          	addi	s5,s5,457 # 31c9 <exitiputtest+0xb>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2d4:	85de                	mv	a1,s7
     2d6:	8552                	mv	a0,s4
     2d8:	00006097          	auipc	ra,0x6
     2dc:	87c080e7          	jalr	-1924(ra) # 5b54 <open>
     2e0:	892a                	mv	s2,a0
    if(fd < 0){
     2e2:	04054a63          	bltz	a0,336 <bigwrite+0xae>
     2e6:	8c5a                	mv	s8,s6
      int cc = write(fd, buf, sz);
     2e8:	8626                	mv	a2,s1
     2ea:	85ce                	mv	a1,s3
     2ec:	854a                	mv	a0,s2
     2ee:	00006097          	auipc	ra,0x6
     2f2:	846080e7          	jalr	-1978(ra) # 5b34 <write>
      if(cc != sz){
     2f6:	04951e63          	bne	a0,s1,352 <bigwrite+0xca>
    for(i = 0; i < 2; i++){
     2fa:	3c7d                	addiw	s8,s8,-1
     2fc:	fe0c16e3          	bnez	s8,2e8 <bigwrite+0x60>
    close(fd);
     300:	854a                	mv	a0,s2
     302:	00006097          	auipc	ra,0x6
     306:	83a080e7          	jalr	-1990(ra) # 5b3c <close>
    unlink("bigwrite");
     30a:	8552                	mv	a0,s4
     30c:	00006097          	auipc	ra,0x6
     310:	858080e7          	jalr	-1960(ra) # 5b64 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     314:	1d74849b          	addiw	s1,s1,471
     318:	fb549ee3          	bne	s1,s5,2d4 <bigwrite+0x4c>
}
     31c:	60e6                	ld	ra,88(sp)
     31e:	6446                	ld	s0,80(sp)
     320:	64a6                	ld	s1,72(sp)
     322:	6906                	ld	s2,64(sp)
     324:	79e2                	ld	s3,56(sp)
     326:	7a42                	ld	s4,48(sp)
     328:	7aa2                	ld	s5,40(sp)
     32a:	7b02                	ld	s6,32(sp)
     32c:	6be2                	ld	s7,24(sp)
     32e:	6c42                	ld	s8,16(sp)
     330:	6ca2                	ld	s9,8(sp)
     332:	6125                	addi	sp,sp,96
     334:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     336:	85e6                	mv	a1,s9
     338:	00006517          	auipc	a0,0x6
     33c:	de050513          	addi	a0,a0,-544 # 6118 <malloc+0x1e2>
     340:	00006097          	auipc	ra,0x6
     344:	b3a080e7          	jalr	-1222(ra) # 5e7a <printf>
      exit(1);
     348:	4505                	li	a0,1
     34a:	00005097          	auipc	ra,0x5
     34e:	7ca080e7          	jalr	1994(ra) # 5b14 <exit>
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     352:	86aa                	mv	a3,a0
     354:	8626                	mv	a2,s1
     356:	85e6                	mv	a1,s9
     358:	00006517          	auipc	a0,0x6
     35c:	de050513          	addi	a0,a0,-544 # 6138 <malloc+0x202>
     360:	00006097          	auipc	ra,0x6
     364:	b1a080e7          	jalr	-1254(ra) # 5e7a <printf>
        exit(1);
     368:	4505                	li	a0,1
     36a:	00005097          	auipc	ra,0x5
     36e:	7aa080e7          	jalr	1962(ra) # 5b14 <exit>

0000000000000372 <copyin>:
{
     372:	7159                	addi	sp,sp,-112
     374:	f486                	sd	ra,104(sp)
     376:	f0a2                	sd	s0,96(sp)
     378:	eca6                	sd	s1,88(sp)
     37a:	e8ca                	sd	s2,80(sp)
     37c:	e4ce                	sd	s3,72(sp)
     37e:	e0d2                	sd	s4,64(sp)
     380:	fc56                	sd	s5,56(sp)
     382:	f85a                	sd	s6,48(sp)
     384:	f45e                	sd	s7,40(sp)
     386:	f062                	sd	s8,32(sp)
     388:	1880                	addi	s0,sp,112
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     38a:	4785                	li	a5,1
     38c:	07fe                	slli	a5,a5,0x1f
     38e:	faf43023          	sd	a5,-96(s0)
     392:	57fd                	li	a5,-1
     394:	faf43423          	sd	a5,-88(s0)
  for(int ai = 0; ai < 2; ai++){
     398:	fa040913          	addi	s2,s0,-96
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     39c:	20100b93          	li	s7,513
     3a0:	00006a97          	auipc	s5,0x6
     3a4:	db0a8a93          	addi	s5,s5,-592 # 6150 <malloc+0x21a>
    int n = write(fd, (void*)addr, 8192);
     3a8:	6a09                	lui	s4,0x2
    n = write(1, (char*)addr, 8192);
     3aa:	4b05                	li	s6,1
    if(pipe(fds) < 0){
     3ac:	f9840c13          	addi	s8,s0,-104
    uint64 addr = addrs[ai];
     3b0:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     3b4:	85de                	mv	a1,s7
     3b6:	8556                	mv	a0,s5
     3b8:	00005097          	auipc	ra,0x5
     3bc:	79c080e7          	jalr	1948(ra) # 5b54 <open>
     3c0:	84aa                	mv	s1,a0
    if(fd < 0){
     3c2:	08054b63          	bltz	a0,458 <copyin+0xe6>
    int n = write(fd, (void*)addr, 8192);
     3c6:	8652                	mv	a2,s4
     3c8:	85ce                	mv	a1,s3
     3ca:	00005097          	auipc	ra,0x5
     3ce:	76a080e7          	jalr	1898(ra) # 5b34 <write>
    if(n >= 0){
     3d2:	0a055063          	bgez	a0,472 <copyin+0x100>
    close(fd);
     3d6:	8526                	mv	a0,s1
     3d8:	00005097          	auipc	ra,0x5
     3dc:	764080e7          	jalr	1892(ra) # 5b3c <close>
    unlink("copyin1");
     3e0:	8556                	mv	a0,s5
     3e2:	00005097          	auipc	ra,0x5
     3e6:	782080e7          	jalr	1922(ra) # 5b64 <unlink>
    n = write(1, (char*)addr, 8192);
     3ea:	8652                	mv	a2,s4
     3ec:	85ce                	mv	a1,s3
     3ee:	855a                	mv	a0,s6
     3f0:	00005097          	auipc	ra,0x5
     3f4:	744080e7          	jalr	1860(ra) # 5b34 <write>
    if(n > 0){
     3f8:	08a04c63          	bgtz	a0,490 <copyin+0x11e>
    if(pipe(fds) < 0){
     3fc:	8562                	mv	a0,s8
     3fe:	00005097          	auipc	ra,0x5
     402:	726080e7          	jalr	1830(ra) # 5b24 <pipe>
     406:	0a054463          	bltz	a0,4ae <copyin+0x13c>
    n = write(fds[1], (char*)addr, 8192);
     40a:	8652                	mv	a2,s4
     40c:	85ce                	mv	a1,s3
     40e:	f9c42503          	lw	a0,-100(s0)
     412:	00005097          	auipc	ra,0x5
     416:	722080e7          	jalr	1826(ra) # 5b34 <write>
    if(n > 0){
     41a:	0aa04763          	bgtz	a0,4c8 <copyin+0x156>
    close(fds[0]);
     41e:	f9842503          	lw	a0,-104(s0)
     422:	00005097          	auipc	ra,0x5
     426:	71a080e7          	jalr	1818(ra) # 5b3c <close>
    close(fds[1]);
     42a:	f9c42503          	lw	a0,-100(s0)
     42e:	00005097          	auipc	ra,0x5
     432:	70e080e7          	jalr	1806(ra) # 5b3c <close>
  for(int ai = 0; ai < 2; ai++){
     436:	0921                	addi	s2,s2,8
     438:	fb040793          	addi	a5,s0,-80
     43c:	f6f91ae3          	bne	s2,a5,3b0 <copyin+0x3e>
}
     440:	70a6                	ld	ra,104(sp)
     442:	7406                	ld	s0,96(sp)
     444:	64e6                	ld	s1,88(sp)
     446:	6946                	ld	s2,80(sp)
     448:	69a6                	ld	s3,72(sp)
     44a:	6a06                	ld	s4,64(sp)
     44c:	7ae2                	ld	s5,56(sp)
     44e:	7b42                	ld	s6,48(sp)
     450:	7ba2                	ld	s7,40(sp)
     452:	7c02                	ld	s8,32(sp)
     454:	6165                	addi	sp,sp,112
     456:	8082                	ret
      printf("open(copyin1) failed\n");
     458:	00006517          	auipc	a0,0x6
     45c:	d0050513          	addi	a0,a0,-768 # 6158 <malloc+0x222>
     460:	00006097          	auipc	ra,0x6
     464:	a1a080e7          	jalr	-1510(ra) # 5e7a <printf>
      exit(1);
     468:	4505                	li	a0,1
     46a:	00005097          	auipc	ra,0x5
     46e:	6aa080e7          	jalr	1706(ra) # 5b14 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     472:	862a                	mv	a2,a0
     474:	85ce                	mv	a1,s3
     476:	00006517          	auipc	a0,0x6
     47a:	cfa50513          	addi	a0,a0,-774 # 6170 <malloc+0x23a>
     47e:	00006097          	auipc	ra,0x6
     482:	9fc080e7          	jalr	-1540(ra) # 5e7a <printf>
      exit(1);
     486:	4505                	li	a0,1
     488:	00005097          	auipc	ra,0x5
     48c:	68c080e7          	jalr	1676(ra) # 5b14 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     490:	862a                	mv	a2,a0
     492:	85ce                	mv	a1,s3
     494:	00006517          	auipc	a0,0x6
     498:	d0c50513          	addi	a0,a0,-756 # 61a0 <malloc+0x26a>
     49c:	00006097          	auipc	ra,0x6
     4a0:	9de080e7          	jalr	-1570(ra) # 5e7a <printf>
      exit(1);
     4a4:	4505                	li	a0,1
     4a6:	00005097          	auipc	ra,0x5
     4aa:	66e080e7          	jalr	1646(ra) # 5b14 <exit>
      printf("pipe() failed\n");
     4ae:	00006517          	auipc	a0,0x6
     4b2:	d2250513          	addi	a0,a0,-734 # 61d0 <malloc+0x29a>
     4b6:	00006097          	auipc	ra,0x6
     4ba:	9c4080e7          	jalr	-1596(ra) # 5e7a <printf>
      exit(1);
     4be:	4505                	li	a0,1
     4c0:	00005097          	auipc	ra,0x5
     4c4:	654080e7          	jalr	1620(ra) # 5b14 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     4c8:	862a                	mv	a2,a0
     4ca:	85ce                	mv	a1,s3
     4cc:	00006517          	auipc	a0,0x6
     4d0:	d1450513          	addi	a0,a0,-748 # 61e0 <malloc+0x2aa>
     4d4:	00006097          	auipc	ra,0x6
     4d8:	9a6080e7          	jalr	-1626(ra) # 5e7a <printf>
      exit(1);
     4dc:	4505                	li	a0,1
     4de:	00005097          	auipc	ra,0x5
     4e2:	636080e7          	jalr	1590(ra) # 5b14 <exit>

00000000000004e6 <copyout>:
{
     4e6:	7159                	addi	sp,sp,-112
     4e8:	f486                	sd	ra,104(sp)
     4ea:	f0a2                	sd	s0,96(sp)
     4ec:	eca6                	sd	s1,88(sp)
     4ee:	e8ca                	sd	s2,80(sp)
     4f0:	e4ce                	sd	s3,72(sp)
     4f2:	e0d2                	sd	s4,64(sp)
     4f4:	fc56                	sd	s5,56(sp)
     4f6:	f85a                	sd	s6,48(sp)
     4f8:	f45e                	sd	s7,40(sp)
     4fa:	f062                	sd	s8,32(sp)
     4fc:	1880                	addi	s0,sp,112
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     4fe:	4785                	li	a5,1
     500:	07fe                	slli	a5,a5,0x1f
     502:	faf43023          	sd	a5,-96(s0)
     506:	57fd                	li	a5,-1
     508:	faf43423          	sd	a5,-88(s0)
  for(int ai = 0; ai < 2; ai++){
     50c:	fa040913          	addi	s2,s0,-96
    int fd = open("README", 0);
     510:	00006b97          	auipc	s7,0x6
     514:	d00b8b93          	addi	s7,s7,-768 # 6210 <malloc+0x2da>
    int n = read(fd, (void*)addr, 8192);
     518:	6a09                	lui	s4,0x2
    if(pipe(fds) < 0){
     51a:	f9840b13          	addi	s6,s0,-104
    n = write(fds[1], "x", 1);
     51e:	4a85                	li	s5,1
     520:	00006c17          	auipc	s8,0x6
     524:	bb8c0c13          	addi	s8,s8,-1096 # 60d8 <malloc+0x1a2>
    uint64 addr = addrs[ai];
     528:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     52c:	4581                	li	a1,0
     52e:	855e                	mv	a0,s7
     530:	00005097          	auipc	ra,0x5
     534:	624080e7          	jalr	1572(ra) # 5b54 <open>
     538:	84aa                	mv	s1,a0
    if(fd < 0){
     53a:	08054763          	bltz	a0,5c8 <copyout+0xe2>
    int n = read(fd, (void*)addr, 8192);
     53e:	8652                	mv	a2,s4
     540:	85ce                	mv	a1,s3
     542:	00005097          	auipc	ra,0x5
     546:	5ea080e7          	jalr	1514(ra) # 5b2c <read>
    if(n > 0){
     54a:	08a04c63          	bgtz	a0,5e2 <copyout+0xfc>
    close(fd);
     54e:	8526                	mv	a0,s1
     550:	00005097          	auipc	ra,0x5
     554:	5ec080e7          	jalr	1516(ra) # 5b3c <close>
    if(pipe(fds) < 0){
     558:	855a                	mv	a0,s6
     55a:	00005097          	auipc	ra,0x5
     55e:	5ca080e7          	jalr	1482(ra) # 5b24 <pipe>
     562:	08054f63          	bltz	a0,600 <copyout+0x11a>
    n = write(fds[1], "x", 1);
     566:	8656                	mv	a2,s5
     568:	85e2                	mv	a1,s8
     56a:	f9c42503          	lw	a0,-100(s0)
     56e:	00005097          	auipc	ra,0x5
     572:	5c6080e7          	jalr	1478(ra) # 5b34 <write>
    if(n != 1){
     576:	0b551263          	bne	a0,s5,61a <copyout+0x134>
    n = read(fds[0], (void*)addr, 8192);
     57a:	8652                	mv	a2,s4
     57c:	85ce                	mv	a1,s3
     57e:	f9842503          	lw	a0,-104(s0)
     582:	00005097          	auipc	ra,0x5
     586:	5aa080e7          	jalr	1450(ra) # 5b2c <read>
    if(n > 0){
     58a:	0aa04563          	bgtz	a0,634 <copyout+0x14e>
    close(fds[0]);
     58e:	f9842503          	lw	a0,-104(s0)
     592:	00005097          	auipc	ra,0x5
     596:	5aa080e7          	jalr	1450(ra) # 5b3c <close>
    close(fds[1]);
     59a:	f9c42503          	lw	a0,-100(s0)
     59e:	00005097          	auipc	ra,0x5
     5a2:	59e080e7          	jalr	1438(ra) # 5b3c <close>
  for(int ai = 0; ai < 2; ai++){
     5a6:	0921                	addi	s2,s2,8
     5a8:	fb040793          	addi	a5,s0,-80
     5ac:	f6f91ee3          	bne	s2,a5,528 <copyout+0x42>
}
     5b0:	70a6                	ld	ra,104(sp)
     5b2:	7406                	ld	s0,96(sp)
     5b4:	64e6                	ld	s1,88(sp)
     5b6:	6946                	ld	s2,80(sp)
     5b8:	69a6                	ld	s3,72(sp)
     5ba:	6a06                	ld	s4,64(sp)
     5bc:	7ae2                	ld	s5,56(sp)
     5be:	7b42                	ld	s6,48(sp)
     5c0:	7ba2                	ld	s7,40(sp)
     5c2:	7c02                	ld	s8,32(sp)
     5c4:	6165                	addi	sp,sp,112
     5c6:	8082                	ret
      printf("open(README) failed\n");
     5c8:	00006517          	auipc	a0,0x6
     5cc:	c5050513          	addi	a0,a0,-944 # 6218 <malloc+0x2e2>
     5d0:	00006097          	auipc	ra,0x6
     5d4:	8aa080e7          	jalr	-1878(ra) # 5e7a <printf>
      exit(1);
     5d8:	4505                	li	a0,1
     5da:	00005097          	auipc	ra,0x5
     5de:	53a080e7          	jalr	1338(ra) # 5b14 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     5e2:	862a                	mv	a2,a0
     5e4:	85ce                	mv	a1,s3
     5e6:	00006517          	auipc	a0,0x6
     5ea:	c4a50513          	addi	a0,a0,-950 # 6230 <malloc+0x2fa>
     5ee:	00006097          	auipc	ra,0x6
     5f2:	88c080e7          	jalr	-1908(ra) # 5e7a <printf>
      exit(1);
     5f6:	4505                	li	a0,1
     5f8:	00005097          	auipc	ra,0x5
     5fc:	51c080e7          	jalr	1308(ra) # 5b14 <exit>
      printf("pipe() failed\n");
     600:	00006517          	auipc	a0,0x6
     604:	bd050513          	addi	a0,a0,-1072 # 61d0 <malloc+0x29a>
     608:	00006097          	auipc	ra,0x6
     60c:	872080e7          	jalr	-1934(ra) # 5e7a <printf>
      exit(1);
     610:	4505                	li	a0,1
     612:	00005097          	auipc	ra,0x5
     616:	502080e7          	jalr	1282(ra) # 5b14 <exit>
      printf("pipe write failed\n");
     61a:	00006517          	auipc	a0,0x6
     61e:	c4650513          	addi	a0,a0,-954 # 6260 <malloc+0x32a>
     622:	00006097          	auipc	ra,0x6
     626:	858080e7          	jalr	-1960(ra) # 5e7a <printf>
      exit(1);
     62a:	4505                	li	a0,1
     62c:	00005097          	auipc	ra,0x5
     630:	4e8080e7          	jalr	1256(ra) # 5b14 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     634:	862a                	mv	a2,a0
     636:	85ce                	mv	a1,s3
     638:	00006517          	auipc	a0,0x6
     63c:	c4050513          	addi	a0,a0,-960 # 6278 <malloc+0x342>
     640:	00006097          	auipc	ra,0x6
     644:	83a080e7          	jalr	-1990(ra) # 5e7a <printf>
      exit(1);
     648:	4505                	li	a0,1
     64a:	00005097          	auipc	ra,0x5
     64e:	4ca080e7          	jalr	1226(ra) # 5b14 <exit>

0000000000000652 <truncate1>:
{
     652:	711d                	addi	sp,sp,-96
     654:	ec86                	sd	ra,88(sp)
     656:	e8a2                	sd	s0,80(sp)
     658:	e4a6                	sd	s1,72(sp)
     65a:	e0ca                	sd	s2,64(sp)
     65c:	fc4e                	sd	s3,56(sp)
     65e:	f852                	sd	s4,48(sp)
     660:	f456                	sd	s5,40(sp)
     662:	1080                	addi	s0,sp,96
     664:	8a2a                	mv	s4,a0
  unlink("truncfile");
     666:	00006517          	auipc	a0,0x6
     66a:	a5a50513          	addi	a0,a0,-1446 # 60c0 <malloc+0x18a>
     66e:	00005097          	auipc	ra,0x5
     672:	4f6080e7          	jalr	1270(ra) # 5b64 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     676:	60100593          	li	a1,1537
     67a:	00006517          	auipc	a0,0x6
     67e:	a4650513          	addi	a0,a0,-1466 # 60c0 <malloc+0x18a>
     682:	00005097          	auipc	ra,0x5
     686:	4d2080e7          	jalr	1234(ra) # 5b54 <open>
     68a:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     68c:	4611                	li	a2,4
     68e:	00006597          	auipc	a1,0x6
     692:	a4258593          	addi	a1,a1,-1470 # 60d0 <malloc+0x19a>
     696:	00005097          	auipc	ra,0x5
     69a:	49e080e7          	jalr	1182(ra) # 5b34 <write>
  close(fd1);
     69e:	8526                	mv	a0,s1
     6a0:	00005097          	auipc	ra,0x5
     6a4:	49c080e7          	jalr	1180(ra) # 5b3c <close>
  int fd2 = open("truncfile", O_RDONLY);
     6a8:	4581                	li	a1,0
     6aa:	00006517          	auipc	a0,0x6
     6ae:	a1650513          	addi	a0,a0,-1514 # 60c0 <malloc+0x18a>
     6b2:	00005097          	auipc	ra,0x5
     6b6:	4a2080e7          	jalr	1186(ra) # 5b54 <open>
     6ba:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     6bc:	02000613          	li	a2,32
     6c0:	fa040593          	addi	a1,s0,-96
     6c4:	00005097          	auipc	ra,0x5
     6c8:	468080e7          	jalr	1128(ra) # 5b2c <read>
  if(n != 4){
     6cc:	4791                	li	a5,4
     6ce:	0cf51e63          	bne	a0,a5,7aa <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     6d2:	40100593          	li	a1,1025
     6d6:	00006517          	auipc	a0,0x6
     6da:	9ea50513          	addi	a0,a0,-1558 # 60c0 <malloc+0x18a>
     6de:	00005097          	auipc	ra,0x5
     6e2:	476080e7          	jalr	1142(ra) # 5b54 <open>
     6e6:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     6e8:	4581                	li	a1,0
     6ea:	00006517          	auipc	a0,0x6
     6ee:	9d650513          	addi	a0,a0,-1578 # 60c0 <malloc+0x18a>
     6f2:	00005097          	auipc	ra,0x5
     6f6:	462080e7          	jalr	1122(ra) # 5b54 <open>
     6fa:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     6fc:	02000613          	li	a2,32
     700:	fa040593          	addi	a1,s0,-96
     704:	00005097          	auipc	ra,0x5
     708:	428080e7          	jalr	1064(ra) # 5b2c <read>
     70c:	8aaa                	mv	s5,a0
  if(n != 0){
     70e:	ed4d                	bnez	a0,7c8 <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     710:	02000613          	li	a2,32
     714:	fa040593          	addi	a1,s0,-96
     718:	8526                	mv	a0,s1
     71a:	00005097          	auipc	ra,0x5
     71e:	412080e7          	jalr	1042(ra) # 5b2c <read>
     722:	8aaa                	mv	s5,a0
  if(n != 0){
     724:	e971                	bnez	a0,7f8 <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     726:	4619                	li	a2,6
     728:	00006597          	auipc	a1,0x6
     72c:	be058593          	addi	a1,a1,-1056 # 6308 <malloc+0x3d2>
     730:	854e                	mv	a0,s3
     732:	00005097          	auipc	ra,0x5
     736:	402080e7          	jalr	1026(ra) # 5b34 <write>
  n = read(fd3, buf, sizeof(buf));
     73a:	02000613          	li	a2,32
     73e:	fa040593          	addi	a1,s0,-96
     742:	854a                	mv	a0,s2
     744:	00005097          	auipc	ra,0x5
     748:	3e8080e7          	jalr	1000(ra) # 5b2c <read>
  if(n != 6){
     74c:	4799                	li	a5,6
     74e:	0cf51d63          	bne	a0,a5,828 <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     752:	02000613          	li	a2,32
     756:	fa040593          	addi	a1,s0,-96
     75a:	8526                	mv	a0,s1
     75c:	00005097          	auipc	ra,0x5
     760:	3d0080e7          	jalr	976(ra) # 5b2c <read>
  if(n != 2){
     764:	4789                	li	a5,2
     766:	0ef51063          	bne	a0,a5,846 <truncate1+0x1f4>
  unlink("truncfile");
     76a:	00006517          	auipc	a0,0x6
     76e:	95650513          	addi	a0,a0,-1706 # 60c0 <malloc+0x18a>
     772:	00005097          	auipc	ra,0x5
     776:	3f2080e7          	jalr	1010(ra) # 5b64 <unlink>
  close(fd1);
     77a:	854e                	mv	a0,s3
     77c:	00005097          	auipc	ra,0x5
     780:	3c0080e7          	jalr	960(ra) # 5b3c <close>
  close(fd2);
     784:	8526                	mv	a0,s1
     786:	00005097          	auipc	ra,0x5
     78a:	3b6080e7          	jalr	950(ra) # 5b3c <close>
  close(fd3);
     78e:	854a                	mv	a0,s2
     790:	00005097          	auipc	ra,0x5
     794:	3ac080e7          	jalr	940(ra) # 5b3c <close>
}
     798:	60e6                	ld	ra,88(sp)
     79a:	6446                	ld	s0,80(sp)
     79c:	64a6                	ld	s1,72(sp)
     79e:	6906                	ld	s2,64(sp)
     7a0:	79e2                	ld	s3,56(sp)
     7a2:	7a42                	ld	s4,48(sp)
     7a4:	7aa2                	ld	s5,40(sp)
     7a6:	6125                	addi	sp,sp,96
     7a8:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     7aa:	862a                	mv	a2,a0
     7ac:	85d2                	mv	a1,s4
     7ae:	00006517          	auipc	a0,0x6
     7b2:	afa50513          	addi	a0,a0,-1286 # 62a8 <malloc+0x372>
     7b6:	00005097          	auipc	ra,0x5
     7ba:	6c4080e7          	jalr	1732(ra) # 5e7a <printf>
    exit(1);
     7be:	4505                	li	a0,1
     7c0:	00005097          	auipc	ra,0x5
     7c4:	354080e7          	jalr	852(ra) # 5b14 <exit>
    printf("aaa fd3=%d\n", fd3);
     7c8:	85ca                	mv	a1,s2
     7ca:	00006517          	auipc	a0,0x6
     7ce:	afe50513          	addi	a0,a0,-1282 # 62c8 <malloc+0x392>
     7d2:	00005097          	auipc	ra,0x5
     7d6:	6a8080e7          	jalr	1704(ra) # 5e7a <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     7da:	8656                	mv	a2,s5
     7dc:	85d2                	mv	a1,s4
     7de:	00006517          	auipc	a0,0x6
     7e2:	afa50513          	addi	a0,a0,-1286 # 62d8 <malloc+0x3a2>
     7e6:	00005097          	auipc	ra,0x5
     7ea:	694080e7          	jalr	1684(ra) # 5e7a <printf>
    exit(1);
     7ee:	4505                	li	a0,1
     7f0:	00005097          	auipc	ra,0x5
     7f4:	324080e7          	jalr	804(ra) # 5b14 <exit>
    printf("bbb fd2=%d\n", fd2);
     7f8:	85a6                	mv	a1,s1
     7fa:	00006517          	auipc	a0,0x6
     7fe:	afe50513          	addi	a0,a0,-1282 # 62f8 <malloc+0x3c2>
     802:	00005097          	auipc	ra,0x5
     806:	678080e7          	jalr	1656(ra) # 5e7a <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     80a:	8656                	mv	a2,s5
     80c:	85d2                	mv	a1,s4
     80e:	00006517          	auipc	a0,0x6
     812:	aca50513          	addi	a0,a0,-1334 # 62d8 <malloc+0x3a2>
     816:	00005097          	auipc	ra,0x5
     81a:	664080e7          	jalr	1636(ra) # 5e7a <printf>
    exit(1);
     81e:	4505                	li	a0,1
     820:	00005097          	auipc	ra,0x5
     824:	2f4080e7          	jalr	756(ra) # 5b14 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     828:	862a                	mv	a2,a0
     82a:	85d2                	mv	a1,s4
     82c:	00006517          	auipc	a0,0x6
     830:	ae450513          	addi	a0,a0,-1308 # 6310 <malloc+0x3da>
     834:	00005097          	auipc	ra,0x5
     838:	646080e7          	jalr	1606(ra) # 5e7a <printf>
    exit(1);
     83c:	4505                	li	a0,1
     83e:	00005097          	auipc	ra,0x5
     842:	2d6080e7          	jalr	726(ra) # 5b14 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     846:	862a                	mv	a2,a0
     848:	85d2                	mv	a1,s4
     84a:	00006517          	auipc	a0,0x6
     84e:	ae650513          	addi	a0,a0,-1306 # 6330 <malloc+0x3fa>
     852:	00005097          	auipc	ra,0x5
     856:	628080e7          	jalr	1576(ra) # 5e7a <printf>
    exit(1);
     85a:	4505                	li	a0,1
     85c:	00005097          	auipc	ra,0x5
     860:	2b8080e7          	jalr	696(ra) # 5b14 <exit>

0000000000000864 <writetest>:
{
     864:	715d                	addi	sp,sp,-80
     866:	e486                	sd	ra,72(sp)
     868:	e0a2                	sd	s0,64(sp)
     86a:	fc26                	sd	s1,56(sp)
     86c:	f84a                	sd	s2,48(sp)
     86e:	f44e                	sd	s3,40(sp)
     870:	f052                	sd	s4,32(sp)
     872:	ec56                	sd	s5,24(sp)
     874:	e85a                	sd	s6,16(sp)
     876:	e45e                	sd	s7,8(sp)
     878:	0880                	addi	s0,sp,80
     87a:	8baa                	mv	s7,a0
  fd = open("small", O_CREATE|O_RDWR);
     87c:	20200593          	li	a1,514
     880:	00006517          	auipc	a0,0x6
     884:	ad050513          	addi	a0,a0,-1328 # 6350 <malloc+0x41a>
     888:	00005097          	auipc	ra,0x5
     88c:	2cc080e7          	jalr	716(ra) # 5b54 <open>
  if(fd < 0){
     890:	0a054d63          	bltz	a0,94a <writetest+0xe6>
     894:	89aa                	mv	s3,a0
     896:	4901                	li	s2,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     898:	44a9                	li	s1,10
     89a:	00006a17          	auipc	s4,0x6
     89e:	adea0a13          	addi	s4,s4,-1314 # 6378 <malloc+0x442>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     8a2:	00006b17          	auipc	s6,0x6
     8a6:	b0eb0b13          	addi	s6,s6,-1266 # 63b0 <malloc+0x47a>
  for(i = 0; i < N; i++){
     8aa:	06400a93          	li	s5,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     8ae:	8626                	mv	a2,s1
     8b0:	85d2                	mv	a1,s4
     8b2:	854e                	mv	a0,s3
     8b4:	00005097          	auipc	ra,0x5
     8b8:	280080e7          	jalr	640(ra) # 5b34 <write>
     8bc:	0a951563          	bne	a0,s1,966 <writetest+0x102>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     8c0:	8626                	mv	a2,s1
     8c2:	85da                	mv	a1,s6
     8c4:	854e                	mv	a0,s3
     8c6:	00005097          	auipc	ra,0x5
     8ca:	26e080e7          	jalr	622(ra) # 5b34 <write>
     8ce:	0a951b63          	bne	a0,s1,984 <writetest+0x120>
  for(i = 0; i < N; i++){
     8d2:	2905                	addiw	s2,s2,1
     8d4:	fd591de3          	bne	s2,s5,8ae <writetest+0x4a>
  close(fd);
     8d8:	854e                	mv	a0,s3
     8da:	00005097          	auipc	ra,0x5
     8de:	262080e7          	jalr	610(ra) # 5b3c <close>
  fd = open("small", O_RDONLY);
     8e2:	4581                	li	a1,0
     8e4:	00006517          	auipc	a0,0x6
     8e8:	a6c50513          	addi	a0,a0,-1428 # 6350 <malloc+0x41a>
     8ec:	00005097          	auipc	ra,0x5
     8f0:	268080e7          	jalr	616(ra) # 5b54 <open>
     8f4:	84aa                	mv	s1,a0
  if(fd < 0){
     8f6:	0a054663          	bltz	a0,9a2 <writetest+0x13e>
  i = read(fd, buf, N*SZ*2);
     8fa:	7d000613          	li	a2,2000
     8fe:	0000d597          	auipc	a1,0xd
     902:	b5258593          	addi	a1,a1,-1198 # d450 <buf>
     906:	00005097          	auipc	ra,0x5
     90a:	226080e7          	jalr	550(ra) # 5b2c <read>
  if(i != N*SZ*2){
     90e:	7d000793          	li	a5,2000
     912:	0af51663          	bne	a0,a5,9be <writetest+0x15a>
  close(fd);
     916:	8526                	mv	a0,s1
     918:	00005097          	auipc	ra,0x5
     91c:	224080e7          	jalr	548(ra) # 5b3c <close>
  if(unlink("small") < 0){
     920:	00006517          	auipc	a0,0x6
     924:	a3050513          	addi	a0,a0,-1488 # 6350 <malloc+0x41a>
     928:	00005097          	auipc	ra,0x5
     92c:	23c080e7          	jalr	572(ra) # 5b64 <unlink>
     930:	0a054563          	bltz	a0,9da <writetest+0x176>
}
     934:	60a6                	ld	ra,72(sp)
     936:	6406                	ld	s0,64(sp)
     938:	74e2                	ld	s1,56(sp)
     93a:	7942                	ld	s2,48(sp)
     93c:	79a2                	ld	s3,40(sp)
     93e:	7a02                	ld	s4,32(sp)
     940:	6ae2                	ld	s5,24(sp)
     942:	6b42                	ld	s6,16(sp)
     944:	6ba2                	ld	s7,8(sp)
     946:	6161                	addi	sp,sp,80
     948:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     94a:	85de                	mv	a1,s7
     94c:	00006517          	auipc	a0,0x6
     950:	a0c50513          	addi	a0,a0,-1524 # 6358 <malloc+0x422>
     954:	00005097          	auipc	ra,0x5
     958:	526080e7          	jalr	1318(ra) # 5e7a <printf>
    exit(1);
     95c:	4505                	li	a0,1
     95e:	00005097          	auipc	ra,0x5
     962:	1b6080e7          	jalr	438(ra) # 5b14 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     966:	864a                	mv	a2,s2
     968:	85de                	mv	a1,s7
     96a:	00006517          	auipc	a0,0x6
     96e:	a1e50513          	addi	a0,a0,-1506 # 6388 <malloc+0x452>
     972:	00005097          	auipc	ra,0x5
     976:	508080e7          	jalr	1288(ra) # 5e7a <printf>
      exit(1);
     97a:	4505                	li	a0,1
     97c:	00005097          	auipc	ra,0x5
     980:	198080e7          	jalr	408(ra) # 5b14 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     984:	864a                	mv	a2,s2
     986:	85de                	mv	a1,s7
     988:	00006517          	auipc	a0,0x6
     98c:	a3850513          	addi	a0,a0,-1480 # 63c0 <malloc+0x48a>
     990:	00005097          	auipc	ra,0x5
     994:	4ea080e7          	jalr	1258(ra) # 5e7a <printf>
      exit(1);
     998:	4505                	li	a0,1
     99a:	00005097          	auipc	ra,0x5
     99e:	17a080e7          	jalr	378(ra) # 5b14 <exit>
    printf("%s: error: open small failed!\n", s);
     9a2:	85de                	mv	a1,s7
     9a4:	00006517          	auipc	a0,0x6
     9a8:	a4450513          	addi	a0,a0,-1468 # 63e8 <malloc+0x4b2>
     9ac:	00005097          	auipc	ra,0x5
     9b0:	4ce080e7          	jalr	1230(ra) # 5e7a <printf>
    exit(1);
     9b4:	4505                	li	a0,1
     9b6:	00005097          	auipc	ra,0x5
     9ba:	15e080e7          	jalr	350(ra) # 5b14 <exit>
    printf("%s: read failed\n", s);
     9be:	85de                	mv	a1,s7
     9c0:	00006517          	auipc	a0,0x6
     9c4:	a4850513          	addi	a0,a0,-1464 # 6408 <malloc+0x4d2>
     9c8:	00005097          	auipc	ra,0x5
     9cc:	4b2080e7          	jalr	1202(ra) # 5e7a <printf>
    exit(1);
     9d0:	4505                	li	a0,1
     9d2:	00005097          	auipc	ra,0x5
     9d6:	142080e7          	jalr	322(ra) # 5b14 <exit>
    printf("%s: unlink small failed\n", s);
     9da:	85de                	mv	a1,s7
     9dc:	00006517          	auipc	a0,0x6
     9e0:	a4450513          	addi	a0,a0,-1468 # 6420 <malloc+0x4ea>
     9e4:	00005097          	auipc	ra,0x5
     9e8:	496080e7          	jalr	1174(ra) # 5e7a <printf>
    exit(1);
     9ec:	4505                	li	a0,1
     9ee:	00005097          	auipc	ra,0x5
     9f2:	126080e7          	jalr	294(ra) # 5b14 <exit>

00000000000009f6 <writebig>:
{
     9f6:	7139                	addi	sp,sp,-64
     9f8:	fc06                	sd	ra,56(sp)
     9fa:	f822                	sd	s0,48(sp)
     9fc:	f426                	sd	s1,40(sp)
     9fe:	f04a                	sd	s2,32(sp)
     a00:	ec4e                	sd	s3,24(sp)
     a02:	e852                	sd	s4,16(sp)
     a04:	e456                	sd	s5,8(sp)
     a06:	e05a                	sd	s6,0(sp)
     a08:	0080                	addi	s0,sp,64
     a0a:	8b2a                	mv	s6,a0
  fd = open("big", O_CREATE|O_RDWR);
     a0c:	20200593          	li	a1,514
     a10:	00006517          	auipc	a0,0x6
     a14:	a3050513          	addi	a0,a0,-1488 # 6440 <malloc+0x50a>
     a18:	00005097          	auipc	ra,0x5
     a1c:	13c080e7          	jalr	316(ra) # 5b54 <open>
  if(fd < 0){
     a20:	08054263          	bltz	a0,aa4 <writebig+0xae>
     a24:	8a2a                	mv	s4,a0
     a26:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     a28:	0000d997          	auipc	s3,0xd
     a2c:	a2898993          	addi	s3,s3,-1496 # d450 <buf>
    if(write(fd, buf, BSIZE) != BSIZE){
     a30:	40000913          	li	s2,1024
  for(i = 0; i < MAXFILE; i++){
     a34:	10c00a93          	li	s5,268
    ((int*)buf)[0] = i;
     a38:	0099a023          	sw	s1,0(s3)
    if(write(fd, buf, BSIZE) != BSIZE){
     a3c:	864a                	mv	a2,s2
     a3e:	85ce                	mv	a1,s3
     a40:	8552                	mv	a0,s4
     a42:	00005097          	auipc	ra,0x5
     a46:	0f2080e7          	jalr	242(ra) # 5b34 <write>
     a4a:	07251b63          	bne	a0,s2,ac0 <writebig+0xca>
  for(i = 0; i < MAXFILE; i++){
     a4e:	2485                	addiw	s1,s1,1
     a50:	ff5494e3          	bne	s1,s5,a38 <writebig+0x42>
  close(fd);
     a54:	8552                	mv	a0,s4
     a56:	00005097          	auipc	ra,0x5
     a5a:	0e6080e7          	jalr	230(ra) # 5b3c <close>
  fd = open("big", O_RDONLY);
     a5e:	4581                	li	a1,0
     a60:	00006517          	auipc	a0,0x6
     a64:	9e050513          	addi	a0,a0,-1568 # 6440 <malloc+0x50a>
     a68:	00005097          	auipc	ra,0x5
     a6c:	0ec080e7          	jalr	236(ra) # 5b54 <open>
     a70:	8a2a                	mv	s4,a0
  n = 0;
     a72:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a74:	40000993          	li	s3,1024
     a78:	0000d917          	auipc	s2,0xd
     a7c:	9d890913          	addi	s2,s2,-1576 # d450 <buf>
  if(fd < 0){
     a80:	04054f63          	bltz	a0,ade <writebig+0xe8>
    i = read(fd, buf, BSIZE);
     a84:	864e                	mv	a2,s3
     a86:	85ca                	mv	a1,s2
     a88:	8552                	mv	a0,s4
     a8a:	00005097          	auipc	ra,0x5
     a8e:	0a2080e7          	jalr	162(ra) # 5b2c <read>
    if(i == 0){
     a92:	c525                	beqz	a0,afa <writebig+0x104>
    } else if(i != BSIZE){
     a94:	0b351f63          	bne	a0,s3,b52 <writebig+0x15c>
    if(((int*)buf)[0] != n){
     a98:	00092683          	lw	a3,0(s2)
     a9c:	0c969a63          	bne	a3,s1,b70 <writebig+0x17a>
    n++;
     aa0:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     aa2:	b7cd                	j	a84 <writebig+0x8e>
    printf("%s: error: creat big failed!\n", s);
     aa4:	85da                	mv	a1,s6
     aa6:	00006517          	auipc	a0,0x6
     aaa:	9a250513          	addi	a0,a0,-1630 # 6448 <malloc+0x512>
     aae:	00005097          	auipc	ra,0x5
     ab2:	3cc080e7          	jalr	972(ra) # 5e7a <printf>
    exit(1);
     ab6:	4505                	li	a0,1
     ab8:	00005097          	auipc	ra,0x5
     abc:	05c080e7          	jalr	92(ra) # 5b14 <exit>
      printf("%s: error: write big file failed\n", s, i);
     ac0:	8626                	mv	a2,s1
     ac2:	85da                	mv	a1,s6
     ac4:	00006517          	auipc	a0,0x6
     ac8:	9a450513          	addi	a0,a0,-1628 # 6468 <malloc+0x532>
     acc:	00005097          	auipc	ra,0x5
     ad0:	3ae080e7          	jalr	942(ra) # 5e7a <printf>
      exit(1);
     ad4:	4505                	li	a0,1
     ad6:	00005097          	auipc	ra,0x5
     ada:	03e080e7          	jalr	62(ra) # 5b14 <exit>
    printf("%s: error: open big failed!\n", s);
     ade:	85da                	mv	a1,s6
     ae0:	00006517          	auipc	a0,0x6
     ae4:	9b050513          	addi	a0,a0,-1616 # 6490 <malloc+0x55a>
     ae8:	00005097          	auipc	ra,0x5
     aec:	392080e7          	jalr	914(ra) # 5e7a <printf>
    exit(1);
     af0:	4505                	li	a0,1
     af2:	00005097          	auipc	ra,0x5
     af6:	022080e7          	jalr	34(ra) # 5b14 <exit>
      if(n == MAXFILE - 1){
     afa:	10b00793          	li	a5,267
     afe:	02f48b63          	beq	s1,a5,b34 <writebig+0x13e>
  close(fd);
     b02:	8552                	mv	a0,s4
     b04:	00005097          	auipc	ra,0x5
     b08:	038080e7          	jalr	56(ra) # 5b3c <close>
  if(unlink("big") < 0){
     b0c:	00006517          	auipc	a0,0x6
     b10:	93450513          	addi	a0,a0,-1740 # 6440 <malloc+0x50a>
     b14:	00005097          	auipc	ra,0x5
     b18:	050080e7          	jalr	80(ra) # 5b64 <unlink>
     b1c:	06054963          	bltz	a0,b8e <writebig+0x198>
}
     b20:	70e2                	ld	ra,56(sp)
     b22:	7442                	ld	s0,48(sp)
     b24:	74a2                	ld	s1,40(sp)
     b26:	7902                	ld	s2,32(sp)
     b28:	69e2                	ld	s3,24(sp)
     b2a:	6a42                	ld	s4,16(sp)
     b2c:	6aa2                	ld	s5,8(sp)
     b2e:	6b02                	ld	s6,0(sp)
     b30:	6121                	addi	sp,sp,64
     b32:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     b34:	8626                	mv	a2,s1
     b36:	85da                	mv	a1,s6
     b38:	00006517          	auipc	a0,0x6
     b3c:	97850513          	addi	a0,a0,-1672 # 64b0 <malloc+0x57a>
     b40:	00005097          	auipc	ra,0x5
     b44:	33a080e7          	jalr	826(ra) # 5e7a <printf>
        exit(1);
     b48:	4505                	li	a0,1
     b4a:	00005097          	auipc	ra,0x5
     b4e:	fca080e7          	jalr	-54(ra) # 5b14 <exit>
      printf("%s: read failed %d\n", s, i);
     b52:	862a                	mv	a2,a0
     b54:	85da                	mv	a1,s6
     b56:	00006517          	auipc	a0,0x6
     b5a:	98250513          	addi	a0,a0,-1662 # 64d8 <malloc+0x5a2>
     b5e:	00005097          	auipc	ra,0x5
     b62:	31c080e7          	jalr	796(ra) # 5e7a <printf>
      exit(1);
     b66:	4505                	li	a0,1
     b68:	00005097          	auipc	ra,0x5
     b6c:	fac080e7          	jalr	-84(ra) # 5b14 <exit>
      printf("%s: read content of block %d is %d\n", s,
     b70:	8626                	mv	a2,s1
     b72:	85da                	mv	a1,s6
     b74:	00006517          	auipc	a0,0x6
     b78:	97c50513          	addi	a0,a0,-1668 # 64f0 <malloc+0x5ba>
     b7c:	00005097          	auipc	ra,0x5
     b80:	2fe080e7          	jalr	766(ra) # 5e7a <printf>
      exit(1);
     b84:	4505                	li	a0,1
     b86:	00005097          	auipc	ra,0x5
     b8a:	f8e080e7          	jalr	-114(ra) # 5b14 <exit>
    printf("%s: unlink big failed\n", s);
     b8e:	85da                	mv	a1,s6
     b90:	00006517          	auipc	a0,0x6
     b94:	98850513          	addi	a0,a0,-1656 # 6518 <malloc+0x5e2>
     b98:	00005097          	auipc	ra,0x5
     b9c:	2e2080e7          	jalr	738(ra) # 5e7a <printf>
    exit(1);
     ba0:	4505                	li	a0,1
     ba2:	00005097          	auipc	ra,0x5
     ba6:	f72080e7          	jalr	-142(ra) # 5b14 <exit>

0000000000000baa <unlinkread>:
{
     baa:	7179                	addi	sp,sp,-48
     bac:	f406                	sd	ra,40(sp)
     bae:	f022                	sd	s0,32(sp)
     bb0:	ec26                	sd	s1,24(sp)
     bb2:	e84a                	sd	s2,16(sp)
     bb4:	e44e                	sd	s3,8(sp)
     bb6:	1800                	addi	s0,sp,48
     bb8:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     bba:	20200593          	li	a1,514
     bbe:	00006517          	auipc	a0,0x6
     bc2:	97250513          	addi	a0,a0,-1678 # 6530 <malloc+0x5fa>
     bc6:	00005097          	auipc	ra,0x5
     bca:	f8e080e7          	jalr	-114(ra) # 5b54 <open>
  if(fd < 0){
     bce:	0e054563          	bltz	a0,cb8 <unlinkread+0x10e>
     bd2:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     bd4:	4615                	li	a2,5
     bd6:	00006597          	auipc	a1,0x6
     bda:	98a58593          	addi	a1,a1,-1654 # 6560 <malloc+0x62a>
     bde:	00005097          	auipc	ra,0x5
     be2:	f56080e7          	jalr	-170(ra) # 5b34 <write>
  close(fd);
     be6:	8526                	mv	a0,s1
     be8:	00005097          	auipc	ra,0x5
     bec:	f54080e7          	jalr	-172(ra) # 5b3c <close>
  fd = open("unlinkread", O_RDWR);
     bf0:	4589                	li	a1,2
     bf2:	00006517          	auipc	a0,0x6
     bf6:	93e50513          	addi	a0,a0,-1730 # 6530 <malloc+0x5fa>
     bfa:	00005097          	auipc	ra,0x5
     bfe:	f5a080e7          	jalr	-166(ra) # 5b54 <open>
     c02:	84aa                	mv	s1,a0
  if(fd < 0){
     c04:	0c054863          	bltz	a0,cd4 <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     c08:	00006517          	auipc	a0,0x6
     c0c:	92850513          	addi	a0,a0,-1752 # 6530 <malloc+0x5fa>
     c10:	00005097          	auipc	ra,0x5
     c14:	f54080e7          	jalr	-172(ra) # 5b64 <unlink>
     c18:	ed61                	bnez	a0,cf0 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     c1a:	20200593          	li	a1,514
     c1e:	00006517          	auipc	a0,0x6
     c22:	91250513          	addi	a0,a0,-1774 # 6530 <malloc+0x5fa>
     c26:	00005097          	auipc	ra,0x5
     c2a:	f2e080e7          	jalr	-210(ra) # 5b54 <open>
     c2e:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     c30:	460d                	li	a2,3
     c32:	00006597          	auipc	a1,0x6
     c36:	97658593          	addi	a1,a1,-1674 # 65a8 <malloc+0x672>
     c3a:	00005097          	auipc	ra,0x5
     c3e:	efa080e7          	jalr	-262(ra) # 5b34 <write>
  close(fd1);
     c42:	854a                	mv	a0,s2
     c44:	00005097          	auipc	ra,0x5
     c48:	ef8080e7          	jalr	-264(ra) # 5b3c <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     c4c:	660d                	lui	a2,0x3
     c4e:	0000d597          	auipc	a1,0xd
     c52:	80258593          	addi	a1,a1,-2046 # d450 <buf>
     c56:	8526                	mv	a0,s1
     c58:	00005097          	auipc	ra,0x5
     c5c:	ed4080e7          	jalr	-300(ra) # 5b2c <read>
     c60:	4795                	li	a5,5
     c62:	0af51563          	bne	a0,a5,d0c <unlinkread+0x162>
  if(buf[0] != 'h'){
     c66:	0000c717          	auipc	a4,0xc
     c6a:	7ea74703          	lbu	a4,2026(a4) # d450 <buf>
     c6e:	06800793          	li	a5,104
     c72:	0af71b63          	bne	a4,a5,d28 <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     c76:	4629                	li	a2,10
     c78:	0000c597          	auipc	a1,0xc
     c7c:	7d858593          	addi	a1,a1,2008 # d450 <buf>
     c80:	8526                	mv	a0,s1
     c82:	00005097          	auipc	ra,0x5
     c86:	eb2080e7          	jalr	-334(ra) # 5b34 <write>
     c8a:	47a9                	li	a5,10
     c8c:	0af51c63          	bne	a0,a5,d44 <unlinkread+0x19a>
  close(fd);
     c90:	8526                	mv	a0,s1
     c92:	00005097          	auipc	ra,0x5
     c96:	eaa080e7          	jalr	-342(ra) # 5b3c <close>
  unlink("unlinkread");
     c9a:	00006517          	auipc	a0,0x6
     c9e:	89650513          	addi	a0,a0,-1898 # 6530 <malloc+0x5fa>
     ca2:	00005097          	auipc	ra,0x5
     ca6:	ec2080e7          	jalr	-318(ra) # 5b64 <unlink>
}
     caa:	70a2                	ld	ra,40(sp)
     cac:	7402                	ld	s0,32(sp)
     cae:	64e2                	ld	s1,24(sp)
     cb0:	6942                	ld	s2,16(sp)
     cb2:	69a2                	ld	s3,8(sp)
     cb4:	6145                	addi	sp,sp,48
     cb6:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     cb8:	85ce                	mv	a1,s3
     cba:	00006517          	auipc	a0,0x6
     cbe:	88650513          	addi	a0,a0,-1914 # 6540 <malloc+0x60a>
     cc2:	00005097          	auipc	ra,0x5
     cc6:	1b8080e7          	jalr	440(ra) # 5e7a <printf>
    exit(1);
     cca:	4505                	li	a0,1
     ccc:	00005097          	auipc	ra,0x5
     cd0:	e48080e7          	jalr	-440(ra) # 5b14 <exit>
    printf("%s: open unlinkread failed\n", s);
     cd4:	85ce                	mv	a1,s3
     cd6:	00006517          	auipc	a0,0x6
     cda:	89250513          	addi	a0,a0,-1902 # 6568 <malloc+0x632>
     cde:	00005097          	auipc	ra,0x5
     ce2:	19c080e7          	jalr	412(ra) # 5e7a <printf>
    exit(1);
     ce6:	4505                	li	a0,1
     ce8:	00005097          	auipc	ra,0x5
     cec:	e2c080e7          	jalr	-468(ra) # 5b14 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     cf0:	85ce                	mv	a1,s3
     cf2:	00006517          	auipc	a0,0x6
     cf6:	89650513          	addi	a0,a0,-1898 # 6588 <malloc+0x652>
     cfa:	00005097          	auipc	ra,0x5
     cfe:	180080e7          	jalr	384(ra) # 5e7a <printf>
    exit(1);
     d02:	4505                	li	a0,1
     d04:	00005097          	auipc	ra,0x5
     d08:	e10080e7          	jalr	-496(ra) # 5b14 <exit>
    printf("%s: unlinkread read failed", s);
     d0c:	85ce                	mv	a1,s3
     d0e:	00006517          	auipc	a0,0x6
     d12:	8a250513          	addi	a0,a0,-1886 # 65b0 <malloc+0x67a>
     d16:	00005097          	auipc	ra,0x5
     d1a:	164080e7          	jalr	356(ra) # 5e7a <printf>
    exit(1);
     d1e:	4505                	li	a0,1
     d20:	00005097          	auipc	ra,0x5
     d24:	df4080e7          	jalr	-524(ra) # 5b14 <exit>
    printf("%s: unlinkread wrong data\n", s);
     d28:	85ce                	mv	a1,s3
     d2a:	00006517          	auipc	a0,0x6
     d2e:	8a650513          	addi	a0,a0,-1882 # 65d0 <malloc+0x69a>
     d32:	00005097          	auipc	ra,0x5
     d36:	148080e7          	jalr	328(ra) # 5e7a <printf>
    exit(1);
     d3a:	4505                	li	a0,1
     d3c:	00005097          	auipc	ra,0x5
     d40:	dd8080e7          	jalr	-552(ra) # 5b14 <exit>
    printf("%s: unlinkread write failed\n", s);
     d44:	85ce                	mv	a1,s3
     d46:	00006517          	auipc	a0,0x6
     d4a:	8aa50513          	addi	a0,a0,-1878 # 65f0 <malloc+0x6ba>
     d4e:	00005097          	auipc	ra,0x5
     d52:	12c080e7          	jalr	300(ra) # 5e7a <printf>
    exit(1);
     d56:	4505                	li	a0,1
     d58:	00005097          	auipc	ra,0x5
     d5c:	dbc080e7          	jalr	-580(ra) # 5b14 <exit>

0000000000000d60 <linktest>:
{
     d60:	1101                	addi	sp,sp,-32
     d62:	ec06                	sd	ra,24(sp)
     d64:	e822                	sd	s0,16(sp)
     d66:	e426                	sd	s1,8(sp)
     d68:	e04a                	sd	s2,0(sp)
     d6a:	1000                	addi	s0,sp,32
     d6c:	892a                	mv	s2,a0
  unlink("lf1");
     d6e:	00006517          	auipc	a0,0x6
     d72:	8a250513          	addi	a0,a0,-1886 # 6610 <malloc+0x6da>
     d76:	00005097          	auipc	ra,0x5
     d7a:	dee080e7          	jalr	-530(ra) # 5b64 <unlink>
  unlink("lf2");
     d7e:	00006517          	auipc	a0,0x6
     d82:	89a50513          	addi	a0,a0,-1894 # 6618 <malloc+0x6e2>
     d86:	00005097          	auipc	ra,0x5
     d8a:	dde080e7          	jalr	-546(ra) # 5b64 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     d8e:	20200593          	li	a1,514
     d92:	00006517          	auipc	a0,0x6
     d96:	87e50513          	addi	a0,a0,-1922 # 6610 <malloc+0x6da>
     d9a:	00005097          	auipc	ra,0x5
     d9e:	dba080e7          	jalr	-582(ra) # 5b54 <open>
  if(fd < 0){
     da2:	10054763          	bltz	a0,eb0 <linktest+0x150>
     da6:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     da8:	4615                	li	a2,5
     daa:	00005597          	auipc	a1,0x5
     dae:	7b658593          	addi	a1,a1,1974 # 6560 <malloc+0x62a>
     db2:	00005097          	auipc	ra,0x5
     db6:	d82080e7          	jalr	-638(ra) # 5b34 <write>
     dba:	4795                	li	a5,5
     dbc:	10f51863          	bne	a0,a5,ecc <linktest+0x16c>
  close(fd);
     dc0:	8526                	mv	a0,s1
     dc2:	00005097          	auipc	ra,0x5
     dc6:	d7a080e7          	jalr	-646(ra) # 5b3c <close>
  if(link("lf1", "lf2") < 0){
     dca:	00006597          	auipc	a1,0x6
     dce:	84e58593          	addi	a1,a1,-1970 # 6618 <malloc+0x6e2>
     dd2:	00006517          	auipc	a0,0x6
     dd6:	83e50513          	addi	a0,a0,-1986 # 6610 <malloc+0x6da>
     dda:	00005097          	auipc	ra,0x5
     dde:	d9a080e7          	jalr	-614(ra) # 5b74 <link>
     de2:	10054363          	bltz	a0,ee8 <linktest+0x188>
  unlink("lf1");
     de6:	00006517          	auipc	a0,0x6
     dea:	82a50513          	addi	a0,a0,-2006 # 6610 <malloc+0x6da>
     dee:	00005097          	auipc	ra,0x5
     df2:	d76080e7          	jalr	-650(ra) # 5b64 <unlink>
  if(open("lf1", 0) >= 0){
     df6:	4581                	li	a1,0
     df8:	00006517          	auipc	a0,0x6
     dfc:	81850513          	addi	a0,a0,-2024 # 6610 <malloc+0x6da>
     e00:	00005097          	auipc	ra,0x5
     e04:	d54080e7          	jalr	-684(ra) # 5b54 <open>
     e08:	0e055e63          	bgez	a0,f04 <linktest+0x1a4>
  fd = open("lf2", 0);
     e0c:	4581                	li	a1,0
     e0e:	00006517          	auipc	a0,0x6
     e12:	80a50513          	addi	a0,a0,-2038 # 6618 <malloc+0x6e2>
     e16:	00005097          	auipc	ra,0x5
     e1a:	d3e080e7          	jalr	-706(ra) # 5b54 <open>
     e1e:	84aa                	mv	s1,a0
  if(fd < 0){
     e20:	10054063          	bltz	a0,f20 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     e24:	660d                	lui	a2,0x3
     e26:	0000c597          	auipc	a1,0xc
     e2a:	62a58593          	addi	a1,a1,1578 # d450 <buf>
     e2e:	00005097          	auipc	ra,0x5
     e32:	cfe080e7          	jalr	-770(ra) # 5b2c <read>
     e36:	4795                	li	a5,5
     e38:	10f51263          	bne	a0,a5,f3c <linktest+0x1dc>
  close(fd);
     e3c:	8526                	mv	a0,s1
     e3e:	00005097          	auipc	ra,0x5
     e42:	cfe080e7          	jalr	-770(ra) # 5b3c <close>
  if(link("lf2", "lf2") >= 0){
     e46:	00005597          	auipc	a1,0x5
     e4a:	7d258593          	addi	a1,a1,2002 # 6618 <malloc+0x6e2>
     e4e:	852e                	mv	a0,a1
     e50:	00005097          	auipc	ra,0x5
     e54:	d24080e7          	jalr	-732(ra) # 5b74 <link>
     e58:	10055063          	bgez	a0,f58 <linktest+0x1f8>
  unlink("lf2");
     e5c:	00005517          	auipc	a0,0x5
     e60:	7bc50513          	addi	a0,a0,1980 # 6618 <malloc+0x6e2>
     e64:	00005097          	auipc	ra,0x5
     e68:	d00080e7          	jalr	-768(ra) # 5b64 <unlink>
  if(link("lf2", "lf1") >= 0){
     e6c:	00005597          	auipc	a1,0x5
     e70:	7a458593          	addi	a1,a1,1956 # 6610 <malloc+0x6da>
     e74:	00005517          	auipc	a0,0x5
     e78:	7a450513          	addi	a0,a0,1956 # 6618 <malloc+0x6e2>
     e7c:	00005097          	auipc	ra,0x5
     e80:	cf8080e7          	jalr	-776(ra) # 5b74 <link>
     e84:	0e055863          	bgez	a0,f74 <linktest+0x214>
  if(link(".", "lf1") >= 0){
     e88:	00005597          	auipc	a1,0x5
     e8c:	78858593          	addi	a1,a1,1928 # 6610 <malloc+0x6da>
     e90:	00006517          	auipc	a0,0x6
     e94:	89050513          	addi	a0,a0,-1904 # 6720 <malloc+0x7ea>
     e98:	00005097          	auipc	ra,0x5
     e9c:	cdc080e7          	jalr	-804(ra) # 5b74 <link>
     ea0:	0e055863          	bgez	a0,f90 <linktest+0x230>
}
     ea4:	60e2                	ld	ra,24(sp)
     ea6:	6442                	ld	s0,16(sp)
     ea8:	64a2                	ld	s1,8(sp)
     eaa:	6902                	ld	s2,0(sp)
     eac:	6105                	addi	sp,sp,32
     eae:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     eb0:	85ca                	mv	a1,s2
     eb2:	00005517          	auipc	a0,0x5
     eb6:	76e50513          	addi	a0,a0,1902 # 6620 <malloc+0x6ea>
     eba:	00005097          	auipc	ra,0x5
     ebe:	fc0080e7          	jalr	-64(ra) # 5e7a <printf>
    exit(1);
     ec2:	4505                	li	a0,1
     ec4:	00005097          	auipc	ra,0x5
     ec8:	c50080e7          	jalr	-944(ra) # 5b14 <exit>
    printf("%s: write lf1 failed\n", s);
     ecc:	85ca                	mv	a1,s2
     ece:	00005517          	auipc	a0,0x5
     ed2:	76a50513          	addi	a0,a0,1898 # 6638 <malloc+0x702>
     ed6:	00005097          	auipc	ra,0x5
     eda:	fa4080e7          	jalr	-92(ra) # 5e7a <printf>
    exit(1);
     ede:	4505                	li	a0,1
     ee0:	00005097          	auipc	ra,0x5
     ee4:	c34080e7          	jalr	-972(ra) # 5b14 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     ee8:	85ca                	mv	a1,s2
     eea:	00005517          	auipc	a0,0x5
     eee:	76650513          	addi	a0,a0,1894 # 6650 <malloc+0x71a>
     ef2:	00005097          	auipc	ra,0x5
     ef6:	f88080e7          	jalr	-120(ra) # 5e7a <printf>
    exit(1);
     efa:	4505                	li	a0,1
     efc:	00005097          	auipc	ra,0x5
     f00:	c18080e7          	jalr	-1000(ra) # 5b14 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     f04:	85ca                	mv	a1,s2
     f06:	00005517          	auipc	a0,0x5
     f0a:	76a50513          	addi	a0,a0,1898 # 6670 <malloc+0x73a>
     f0e:	00005097          	auipc	ra,0x5
     f12:	f6c080e7          	jalr	-148(ra) # 5e7a <printf>
    exit(1);
     f16:	4505                	li	a0,1
     f18:	00005097          	auipc	ra,0x5
     f1c:	bfc080e7          	jalr	-1028(ra) # 5b14 <exit>
    printf("%s: open lf2 failed\n", s);
     f20:	85ca                	mv	a1,s2
     f22:	00005517          	auipc	a0,0x5
     f26:	77e50513          	addi	a0,a0,1918 # 66a0 <malloc+0x76a>
     f2a:	00005097          	auipc	ra,0x5
     f2e:	f50080e7          	jalr	-176(ra) # 5e7a <printf>
    exit(1);
     f32:	4505                	li	a0,1
     f34:	00005097          	auipc	ra,0x5
     f38:	be0080e7          	jalr	-1056(ra) # 5b14 <exit>
    printf("%s: read lf2 failed\n", s);
     f3c:	85ca                	mv	a1,s2
     f3e:	00005517          	auipc	a0,0x5
     f42:	77a50513          	addi	a0,a0,1914 # 66b8 <malloc+0x782>
     f46:	00005097          	auipc	ra,0x5
     f4a:	f34080e7          	jalr	-204(ra) # 5e7a <printf>
    exit(1);
     f4e:	4505                	li	a0,1
     f50:	00005097          	auipc	ra,0x5
     f54:	bc4080e7          	jalr	-1084(ra) # 5b14 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     f58:	85ca                	mv	a1,s2
     f5a:	00005517          	auipc	a0,0x5
     f5e:	77650513          	addi	a0,a0,1910 # 66d0 <malloc+0x79a>
     f62:	00005097          	auipc	ra,0x5
     f66:	f18080e7          	jalr	-232(ra) # 5e7a <printf>
    exit(1);
     f6a:	4505                	li	a0,1
     f6c:	00005097          	auipc	ra,0x5
     f70:	ba8080e7          	jalr	-1112(ra) # 5b14 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     f74:	85ca                	mv	a1,s2
     f76:	00005517          	auipc	a0,0x5
     f7a:	78250513          	addi	a0,a0,1922 # 66f8 <malloc+0x7c2>
     f7e:	00005097          	auipc	ra,0x5
     f82:	efc080e7          	jalr	-260(ra) # 5e7a <printf>
    exit(1);
     f86:	4505                	li	a0,1
     f88:	00005097          	auipc	ra,0x5
     f8c:	b8c080e7          	jalr	-1140(ra) # 5b14 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     f90:	85ca                	mv	a1,s2
     f92:	00005517          	auipc	a0,0x5
     f96:	79650513          	addi	a0,a0,1942 # 6728 <malloc+0x7f2>
     f9a:	00005097          	auipc	ra,0x5
     f9e:	ee0080e7          	jalr	-288(ra) # 5e7a <printf>
    exit(1);
     fa2:	4505                	li	a0,1
     fa4:	00005097          	auipc	ra,0x5
     fa8:	b70080e7          	jalr	-1168(ra) # 5b14 <exit>

0000000000000fac <bigdir>:
{
     fac:	711d                	addi	sp,sp,-96
     fae:	ec86                	sd	ra,88(sp)
     fb0:	e8a2                	sd	s0,80(sp)
     fb2:	e4a6                	sd	s1,72(sp)
     fb4:	e0ca                	sd	s2,64(sp)
     fb6:	fc4e                	sd	s3,56(sp)
     fb8:	f852                	sd	s4,48(sp)
     fba:	f456                	sd	s5,40(sp)
     fbc:	f05a                	sd	s6,32(sp)
     fbe:	ec5e                	sd	s7,24(sp)
     fc0:	1080                	addi	s0,sp,96
     fc2:	8baa                	mv	s7,a0
  unlink("bd");
     fc4:	00005517          	auipc	a0,0x5
     fc8:	78450513          	addi	a0,a0,1924 # 6748 <malloc+0x812>
     fcc:	00005097          	auipc	ra,0x5
     fd0:	b98080e7          	jalr	-1128(ra) # 5b64 <unlink>
  fd = open("bd", O_CREATE);
     fd4:	20000593          	li	a1,512
     fd8:	00005517          	auipc	a0,0x5
     fdc:	77050513          	addi	a0,a0,1904 # 6748 <malloc+0x812>
     fe0:	00005097          	auipc	ra,0x5
     fe4:	b74080e7          	jalr	-1164(ra) # 5b54 <open>
  if(fd < 0){
     fe8:	0c054c63          	bltz	a0,10c0 <bigdir+0x114>
  close(fd);
     fec:	00005097          	auipc	ra,0x5
     ff0:	b50080e7          	jalr	-1200(ra) # 5b3c <close>
  for(i = 0; i < N; i++){
     ff4:	4901                	li	s2,0
    name[0] = 'x';
     ff6:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     ffa:	fa040a13          	addi	s4,s0,-96
     ffe:	00005997          	auipc	s3,0x5
    1002:	74a98993          	addi	s3,s3,1866 # 6748 <malloc+0x812>
  for(i = 0; i < N; i++){
    1006:	1f400b13          	li	s6,500
    name[0] = 'x';
    100a:	fb540023          	sb	s5,-96(s0)
    name[1] = '0' + (i / 64);
    100e:	41f9571b          	sraiw	a4,s2,0x1f
    1012:	01a7571b          	srliw	a4,a4,0x1a
    1016:	012707bb          	addw	a5,a4,s2
    101a:	4067d69b          	sraiw	a3,a5,0x6
    101e:	0306869b          	addiw	a3,a3,48
    1022:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
    1026:	03f7f793          	andi	a5,a5,63
    102a:	9f99                	subw	a5,a5,a4
    102c:	0307879b          	addiw	a5,a5,48
    1030:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
    1034:	fa0401a3          	sb	zero,-93(s0)
    if(link("bd", name) != 0){
    1038:	85d2                	mv	a1,s4
    103a:	854e                	mv	a0,s3
    103c:	00005097          	auipc	ra,0x5
    1040:	b38080e7          	jalr	-1224(ra) # 5b74 <link>
    1044:	84aa                	mv	s1,a0
    1046:	e959                	bnez	a0,10dc <bigdir+0x130>
  for(i = 0; i < N; i++){
    1048:	2905                	addiw	s2,s2,1
    104a:	fd6910e3          	bne	s2,s6,100a <bigdir+0x5e>
  unlink("bd");
    104e:	00005517          	auipc	a0,0x5
    1052:	6fa50513          	addi	a0,a0,1786 # 6748 <malloc+0x812>
    1056:	00005097          	auipc	ra,0x5
    105a:	b0e080e7          	jalr	-1266(ra) # 5b64 <unlink>
    name[0] = 'x';
    105e:	07800993          	li	s3,120
    if(unlink(name) != 0){
    1062:	fa040913          	addi	s2,s0,-96
  for(i = 0; i < N; i++){
    1066:	1f400a13          	li	s4,500
    name[0] = 'x';
    106a:	fb340023          	sb	s3,-96(s0)
    name[1] = '0' + (i / 64);
    106e:	41f4d71b          	sraiw	a4,s1,0x1f
    1072:	01a7571b          	srliw	a4,a4,0x1a
    1076:	009707bb          	addw	a5,a4,s1
    107a:	4067d69b          	sraiw	a3,a5,0x6
    107e:	0306869b          	addiw	a3,a3,48
    1082:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
    1086:	03f7f793          	andi	a5,a5,63
    108a:	9f99                	subw	a5,a5,a4
    108c:	0307879b          	addiw	a5,a5,48
    1090:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
    1094:	fa0401a3          	sb	zero,-93(s0)
    if(unlink(name) != 0){
    1098:	854a                	mv	a0,s2
    109a:	00005097          	auipc	ra,0x5
    109e:	aca080e7          	jalr	-1334(ra) # 5b64 <unlink>
    10a2:	ed29                	bnez	a0,10fc <bigdir+0x150>
  for(i = 0; i < N; i++){
    10a4:	2485                	addiw	s1,s1,1
    10a6:	fd4492e3          	bne	s1,s4,106a <bigdir+0xbe>
}
    10aa:	60e6                	ld	ra,88(sp)
    10ac:	6446                	ld	s0,80(sp)
    10ae:	64a6                	ld	s1,72(sp)
    10b0:	6906                	ld	s2,64(sp)
    10b2:	79e2                	ld	s3,56(sp)
    10b4:	7a42                	ld	s4,48(sp)
    10b6:	7aa2                	ld	s5,40(sp)
    10b8:	7b02                	ld	s6,32(sp)
    10ba:	6be2                	ld	s7,24(sp)
    10bc:	6125                	addi	sp,sp,96
    10be:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    10c0:	85de                	mv	a1,s7
    10c2:	00005517          	auipc	a0,0x5
    10c6:	68e50513          	addi	a0,a0,1678 # 6750 <malloc+0x81a>
    10ca:	00005097          	auipc	ra,0x5
    10ce:	db0080e7          	jalr	-592(ra) # 5e7a <printf>
    exit(1);
    10d2:	4505                	li	a0,1
    10d4:	00005097          	auipc	ra,0x5
    10d8:	a40080e7          	jalr	-1472(ra) # 5b14 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    10dc:	fa040613          	addi	a2,s0,-96
    10e0:	85de                	mv	a1,s7
    10e2:	00005517          	auipc	a0,0x5
    10e6:	68e50513          	addi	a0,a0,1678 # 6770 <malloc+0x83a>
    10ea:	00005097          	auipc	ra,0x5
    10ee:	d90080e7          	jalr	-624(ra) # 5e7a <printf>
      exit(1);
    10f2:	4505                	li	a0,1
    10f4:	00005097          	auipc	ra,0x5
    10f8:	a20080e7          	jalr	-1504(ra) # 5b14 <exit>
      printf("%s: bigdir unlink failed", s);
    10fc:	85de                	mv	a1,s7
    10fe:	00005517          	auipc	a0,0x5
    1102:	69250513          	addi	a0,a0,1682 # 6790 <malloc+0x85a>
    1106:	00005097          	auipc	ra,0x5
    110a:	d74080e7          	jalr	-652(ra) # 5e7a <printf>
      exit(1);
    110e:	4505                	li	a0,1
    1110:	00005097          	auipc	ra,0x5
    1114:	a04080e7          	jalr	-1532(ra) # 5b14 <exit>

0000000000001118 <validatetest>:
{
    1118:	7139                	addi	sp,sp,-64
    111a:	fc06                	sd	ra,56(sp)
    111c:	f822                	sd	s0,48(sp)
    111e:	f426                	sd	s1,40(sp)
    1120:	f04a                	sd	s2,32(sp)
    1122:	ec4e                	sd	s3,24(sp)
    1124:	e852                	sd	s4,16(sp)
    1126:	e456                	sd	s5,8(sp)
    1128:	e05a                	sd	s6,0(sp)
    112a:	0080                	addi	s0,sp,64
    112c:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    112e:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    1130:	00005997          	auipc	s3,0x5
    1134:	68098993          	addi	s3,s3,1664 # 67b0 <malloc+0x87a>
    1138:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    113a:	6a85                	lui	s5,0x1
    113c:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    1140:	85a6                	mv	a1,s1
    1142:	854e                	mv	a0,s3
    1144:	00005097          	auipc	ra,0x5
    1148:	a30080e7          	jalr	-1488(ra) # 5b74 <link>
    114c:	01251f63          	bne	a0,s2,116a <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1150:	94d6                	add	s1,s1,s5
    1152:	ff4497e3          	bne	s1,s4,1140 <validatetest+0x28>
}
    1156:	70e2                	ld	ra,56(sp)
    1158:	7442                	ld	s0,48(sp)
    115a:	74a2                	ld	s1,40(sp)
    115c:	7902                	ld	s2,32(sp)
    115e:	69e2                	ld	s3,24(sp)
    1160:	6a42                	ld	s4,16(sp)
    1162:	6aa2                	ld	s5,8(sp)
    1164:	6b02                	ld	s6,0(sp)
    1166:	6121                	addi	sp,sp,64
    1168:	8082                	ret
      printf("%s: link should not succeed\n", s);
    116a:	85da                	mv	a1,s6
    116c:	00005517          	auipc	a0,0x5
    1170:	65450513          	addi	a0,a0,1620 # 67c0 <malloc+0x88a>
    1174:	00005097          	auipc	ra,0x5
    1178:	d06080e7          	jalr	-762(ra) # 5e7a <printf>
      exit(1);
    117c:	4505                	li	a0,1
    117e:	00005097          	auipc	ra,0x5
    1182:	996080e7          	jalr	-1642(ra) # 5b14 <exit>

0000000000001186 <pgbug>:
// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    1186:	7179                	addi	sp,sp,-48
    1188:	f406                	sd	ra,40(sp)
    118a:	f022                	sd	s0,32(sp)
    118c:	ec26                	sd	s1,24(sp)
    118e:	1800                	addi	s0,sp,48
  char *argv[1];
  argv[0] = 0;
    1190:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    1194:	eaeb14b7          	lui	s1,0xeaeb1
    1198:	b5b48493          	addi	s1,s1,-1189 # ffffffffeaeb0b5b <__BSS_END__+0xffffffffeaea06fb>
    119c:	04d2                	slli	s1,s1,0x14
    119e:	048d                	addi	s1,s1,3
    11a0:	04b2                	slli	s1,s1,0xc
    11a2:	f5e48493          	addi	s1,s1,-162
    11a6:	fd840593          	addi	a1,s0,-40
    11aa:	8526                	mv	a0,s1
    11ac:	00005097          	auipc	ra,0x5
    11b0:	9a0080e7          	jalr	-1632(ra) # 5b4c <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    11b4:	8526                	mv	a0,s1
    11b6:	00005097          	auipc	ra,0x5
    11ba:	96e080e7          	jalr	-1682(ra) # 5b24 <pipe>

  exit(0);
    11be:	4501                	li	a0,0
    11c0:	00005097          	auipc	ra,0x5
    11c4:	954080e7          	jalr	-1708(ra) # 5b14 <exit>

00000000000011c8 <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    11c8:	7139                	addi	sp,sp,-64
    11ca:	fc06                	sd	ra,56(sp)
    11cc:	f822                	sd	s0,48(sp)
    11ce:	f426                	sd	s1,40(sp)
    11d0:	f04a                	sd	s2,32(sp)
    11d2:	ec4e                	sd	s3,24(sp)
    11d4:	e852                	sd	s4,16(sp)
    11d6:	0080                	addi	s0,sp,64
    11d8:	64b1                	lui	s1,0xc
    11da:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1610>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    11de:	597d                	li	s2,-1
    11e0:	02095913          	srli	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    11e4:	fc040a13          	addi	s4,s0,-64
    11e8:	00005997          	auipc	s3,0x5
    11ec:	e8098993          	addi	s3,s3,-384 # 6068 <malloc+0x132>
    argv[0] = (char*)0xffffffff;
    11f0:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    11f4:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    11f8:	85d2                	mv	a1,s4
    11fa:	854e                	mv	a0,s3
    11fc:	00005097          	auipc	ra,0x5
    1200:	950080e7          	jalr	-1712(ra) # 5b4c <exec>
  for(int i = 0; i < 50000; i++){
    1204:	34fd                	addiw	s1,s1,-1
    1206:	f4ed                	bnez	s1,11f0 <badarg+0x28>
  }
  
  exit(0);
    1208:	4501                	li	a0,0
    120a:	00005097          	auipc	ra,0x5
    120e:	90a080e7          	jalr	-1782(ra) # 5b14 <exit>

0000000000001212 <copyinstr2>:
{
    1212:	7155                	addi	sp,sp,-208
    1214:	e586                	sd	ra,200(sp)
    1216:	e1a2                	sd	s0,192(sp)
    1218:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    121a:	f6840793          	addi	a5,s0,-152
    121e:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    1222:	07800713          	li	a4,120
    1226:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    122a:	0785                	addi	a5,a5,1
    122c:	fed79de3          	bne	a5,a3,1226 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    1230:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    1234:	f6840513          	addi	a0,s0,-152
    1238:	00005097          	auipc	ra,0x5
    123c:	92c080e7          	jalr	-1748(ra) # 5b64 <unlink>
  if(ret != -1){
    1240:	57fd                	li	a5,-1
    1242:	0ef51063          	bne	a0,a5,1322 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    1246:	20100593          	li	a1,513
    124a:	f6840513          	addi	a0,s0,-152
    124e:	00005097          	auipc	ra,0x5
    1252:	906080e7          	jalr	-1786(ra) # 5b54 <open>
  if(fd != -1){
    1256:	57fd                	li	a5,-1
    1258:	0ef51563          	bne	a0,a5,1342 <copyinstr2+0x130>
  ret = link(b, b);
    125c:	f6840513          	addi	a0,s0,-152
    1260:	85aa                	mv	a1,a0
    1262:	00005097          	auipc	ra,0x5
    1266:	912080e7          	jalr	-1774(ra) # 5b74 <link>
  if(ret != -1){
    126a:	57fd                	li	a5,-1
    126c:	0ef51b63          	bne	a0,a5,1362 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    1270:	00006797          	auipc	a5,0x6
    1274:	74878793          	addi	a5,a5,1864 # 79b8 <malloc+0x1a82>
    1278:	f4f43c23          	sd	a5,-168(s0)
    127c:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1280:	f5840593          	addi	a1,s0,-168
    1284:	f6840513          	addi	a0,s0,-152
    1288:	00005097          	auipc	ra,0x5
    128c:	8c4080e7          	jalr	-1852(ra) # 5b4c <exec>
  if(ret != -1){
    1290:	57fd                	li	a5,-1
    1292:	0ef51963          	bne	a0,a5,1384 <copyinstr2+0x172>
  int pid = fork();
    1296:	00005097          	auipc	ra,0x5
    129a:	876080e7          	jalr	-1930(ra) # 5b0c <fork>
  if(pid < 0){
    129e:	10054363          	bltz	a0,13a4 <copyinstr2+0x192>
  if(pid == 0){
    12a2:	12051463          	bnez	a0,13ca <copyinstr2+0x1b8>
    12a6:	00009797          	auipc	a5,0x9
    12aa:	a9278793          	addi	a5,a5,-1390 # 9d38 <big.0>
    12ae:	0000a697          	auipc	a3,0xa
    12b2:	a8a68693          	addi	a3,a3,-1398 # ad38 <__global_pointer$+0x90c>
      big[i] = 'x';
    12b6:	07800713          	li	a4,120
    12ba:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    12be:	0785                	addi	a5,a5,1
    12c0:	fed79de3          	bne	a5,a3,12ba <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    12c4:	0000a797          	auipc	a5,0xa
    12c8:	a6078a23          	sb	zero,-1420(a5) # ad38 <__global_pointer$+0x90c>
    char *args2[] = { big, big, big, 0 };
    12cc:	00007797          	auipc	a5,0x7
    12d0:	13478793          	addi	a5,a5,308 # 8400 <malloc+0x24ca>
    12d4:	6390                	ld	a2,0(a5)
    12d6:	6794                	ld	a3,8(a5)
    12d8:	6b98                	ld	a4,16(a5)
    12da:	f2c43823          	sd	a2,-208(s0)
    12de:	f2d43c23          	sd	a3,-200(s0)
    12e2:	f4e43023          	sd	a4,-192(s0)
    12e6:	6f9c                	ld	a5,24(a5)
    12e8:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    12ec:	f3040593          	addi	a1,s0,-208
    12f0:	00005517          	auipc	a0,0x5
    12f4:	d7850513          	addi	a0,a0,-648 # 6068 <malloc+0x132>
    12f8:	00005097          	auipc	ra,0x5
    12fc:	854080e7          	jalr	-1964(ra) # 5b4c <exec>
    if(ret != -1){
    1300:	57fd                	li	a5,-1
    1302:	0af50e63          	beq	a0,a5,13be <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1306:	85be                	mv	a1,a5
    1308:	00005517          	auipc	a0,0x5
    130c:	56050513          	addi	a0,a0,1376 # 6868 <malloc+0x932>
    1310:	00005097          	auipc	ra,0x5
    1314:	b6a080e7          	jalr	-1174(ra) # 5e7a <printf>
      exit(1);
    1318:	4505                	li	a0,1
    131a:	00004097          	auipc	ra,0x4
    131e:	7fa080e7          	jalr	2042(ra) # 5b14 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1322:	862a                	mv	a2,a0
    1324:	f6840593          	addi	a1,s0,-152
    1328:	00005517          	auipc	a0,0x5
    132c:	4b850513          	addi	a0,a0,1208 # 67e0 <malloc+0x8aa>
    1330:	00005097          	auipc	ra,0x5
    1334:	b4a080e7          	jalr	-1206(ra) # 5e7a <printf>
    exit(1);
    1338:	4505                	li	a0,1
    133a:	00004097          	auipc	ra,0x4
    133e:	7da080e7          	jalr	2010(ra) # 5b14 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    1342:	862a                	mv	a2,a0
    1344:	f6840593          	addi	a1,s0,-152
    1348:	00005517          	auipc	a0,0x5
    134c:	4b850513          	addi	a0,a0,1208 # 6800 <malloc+0x8ca>
    1350:	00005097          	auipc	ra,0x5
    1354:	b2a080e7          	jalr	-1238(ra) # 5e7a <printf>
    exit(1);
    1358:	4505                	li	a0,1
    135a:	00004097          	auipc	ra,0x4
    135e:	7ba080e7          	jalr	1978(ra) # 5b14 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1362:	f6840593          	addi	a1,s0,-152
    1366:	86aa                	mv	a3,a0
    1368:	862e                	mv	a2,a1
    136a:	00005517          	auipc	a0,0x5
    136e:	4b650513          	addi	a0,a0,1206 # 6820 <malloc+0x8ea>
    1372:	00005097          	auipc	ra,0x5
    1376:	b08080e7          	jalr	-1272(ra) # 5e7a <printf>
    exit(1);
    137a:	4505                	li	a0,1
    137c:	00004097          	auipc	ra,0x4
    1380:	798080e7          	jalr	1944(ra) # 5b14 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1384:	863e                	mv	a2,a5
    1386:	f6840593          	addi	a1,s0,-152
    138a:	00005517          	auipc	a0,0x5
    138e:	4be50513          	addi	a0,a0,1214 # 6848 <malloc+0x912>
    1392:	00005097          	auipc	ra,0x5
    1396:	ae8080e7          	jalr	-1304(ra) # 5e7a <printf>
    exit(1);
    139a:	4505                	li	a0,1
    139c:	00004097          	auipc	ra,0x4
    13a0:	778080e7          	jalr	1912(ra) # 5b14 <exit>
    printf("fork failed\n");
    13a4:	00006517          	auipc	a0,0x6
    13a8:	93c50513          	addi	a0,a0,-1732 # 6ce0 <malloc+0xdaa>
    13ac:	00005097          	auipc	ra,0x5
    13b0:	ace080e7          	jalr	-1330(ra) # 5e7a <printf>
    exit(1);
    13b4:	4505                	li	a0,1
    13b6:	00004097          	auipc	ra,0x4
    13ba:	75e080e7          	jalr	1886(ra) # 5b14 <exit>
    exit(747); // OK
    13be:	2eb00513          	li	a0,747
    13c2:	00004097          	auipc	ra,0x4
    13c6:	752080e7          	jalr	1874(ra) # 5b14 <exit>
  int st = 0;
    13ca:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    13ce:	f5440513          	addi	a0,s0,-172
    13d2:	00004097          	auipc	ra,0x4
    13d6:	74a080e7          	jalr	1866(ra) # 5b1c <wait>
  if(st != 747){
    13da:	f5442703          	lw	a4,-172(s0)
    13de:	2eb00793          	li	a5,747
    13e2:	00f71663          	bne	a4,a5,13ee <copyinstr2+0x1dc>
}
    13e6:	60ae                	ld	ra,200(sp)
    13e8:	640e                	ld	s0,192(sp)
    13ea:	6169                	addi	sp,sp,208
    13ec:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    13ee:	00005517          	auipc	a0,0x5
    13f2:	4a250513          	addi	a0,a0,1186 # 6890 <malloc+0x95a>
    13f6:	00005097          	auipc	ra,0x5
    13fa:	a84080e7          	jalr	-1404(ra) # 5e7a <printf>
    exit(1);
    13fe:	4505                	li	a0,1
    1400:	00004097          	auipc	ra,0x4
    1404:	714080e7          	jalr	1812(ra) # 5b14 <exit>

0000000000001408 <truncate3>:
{
    1408:	7175                	addi	sp,sp,-144
    140a:	e506                	sd	ra,136(sp)
    140c:	e122                	sd	s0,128(sp)
    140e:	fc66                	sd	s9,56(sp)
    1410:	0900                	addi	s0,sp,144
    1412:	8caa                	mv	s9,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    1414:	60100593          	li	a1,1537
    1418:	00005517          	auipc	a0,0x5
    141c:	ca850513          	addi	a0,a0,-856 # 60c0 <malloc+0x18a>
    1420:	00004097          	auipc	ra,0x4
    1424:	734080e7          	jalr	1844(ra) # 5b54 <open>
    1428:	00004097          	auipc	ra,0x4
    142c:	714080e7          	jalr	1812(ra) # 5b3c <close>
  pid = fork();
    1430:	00004097          	auipc	ra,0x4
    1434:	6dc080e7          	jalr	1756(ra) # 5b0c <fork>
  if(pid < 0){
    1438:	08054b63          	bltz	a0,14ce <truncate3+0xc6>
  if(pid == 0){
    143c:	ed65                	bnez	a0,1534 <truncate3+0x12c>
    143e:	fca6                	sd	s1,120(sp)
    1440:	f8ca                	sd	s2,112(sp)
    1442:	f4ce                	sd	s3,104(sp)
    1444:	f0d2                	sd	s4,96(sp)
    1446:	ecd6                	sd	s5,88(sp)
    1448:	e8da                	sd	s6,80(sp)
    144a:	e4de                	sd	s7,72(sp)
    144c:	e0e2                	sd	s8,64(sp)
    144e:	06400913          	li	s2,100
      int fd = open("truncfile", O_WRONLY);
    1452:	4a85                	li	s5,1
    1454:	00005997          	auipc	s3,0x5
    1458:	c6c98993          	addi	s3,s3,-916 # 60c0 <malloc+0x18a>
      int n = write(fd, "1234567890", 10);
    145c:	4a29                	li	s4,10
    145e:	00005b17          	auipc	s6,0x5
    1462:	492b0b13          	addi	s6,s6,1170 # 68f0 <malloc+0x9ba>
      read(fd, buf, sizeof(buf));
    1466:	f7840c13          	addi	s8,s0,-136
    146a:	02000b93          	li	s7,32
      int fd = open("truncfile", O_WRONLY);
    146e:	85d6                	mv	a1,s5
    1470:	854e                	mv	a0,s3
    1472:	00004097          	auipc	ra,0x4
    1476:	6e2080e7          	jalr	1762(ra) # 5b54 <open>
    147a:	84aa                	mv	s1,a0
      if(fd < 0){
    147c:	06054f63          	bltz	a0,14fa <truncate3+0xf2>
      int n = write(fd, "1234567890", 10);
    1480:	8652                	mv	a2,s4
    1482:	85da                	mv	a1,s6
    1484:	00004097          	auipc	ra,0x4
    1488:	6b0080e7          	jalr	1712(ra) # 5b34 <write>
      if(n != 10){
    148c:	09451563          	bne	a0,s4,1516 <truncate3+0x10e>
      close(fd);
    1490:	8526                	mv	a0,s1
    1492:	00004097          	auipc	ra,0x4
    1496:	6aa080e7          	jalr	1706(ra) # 5b3c <close>
      fd = open("truncfile", O_RDONLY);
    149a:	4581                	li	a1,0
    149c:	854e                	mv	a0,s3
    149e:	00004097          	auipc	ra,0x4
    14a2:	6b6080e7          	jalr	1718(ra) # 5b54 <open>
    14a6:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    14a8:	865e                	mv	a2,s7
    14aa:	85e2                	mv	a1,s8
    14ac:	00004097          	auipc	ra,0x4
    14b0:	680080e7          	jalr	1664(ra) # 5b2c <read>
      close(fd);
    14b4:	8526                	mv	a0,s1
    14b6:	00004097          	auipc	ra,0x4
    14ba:	686080e7          	jalr	1670(ra) # 5b3c <close>
    for(int i = 0; i < 100; i++){
    14be:	397d                	addiw	s2,s2,-1
    14c0:	fa0917e3          	bnez	s2,146e <truncate3+0x66>
    exit(0);
    14c4:	4501                	li	a0,0
    14c6:	00004097          	auipc	ra,0x4
    14ca:	64e080e7          	jalr	1614(ra) # 5b14 <exit>
    14ce:	fca6                	sd	s1,120(sp)
    14d0:	f8ca                	sd	s2,112(sp)
    14d2:	f4ce                	sd	s3,104(sp)
    14d4:	f0d2                	sd	s4,96(sp)
    14d6:	ecd6                	sd	s5,88(sp)
    14d8:	e8da                	sd	s6,80(sp)
    14da:	e4de                	sd	s7,72(sp)
    14dc:	e0e2                	sd	s8,64(sp)
    printf("%s: fork failed\n", s);
    14de:	85e6                	mv	a1,s9
    14e0:	00005517          	auipc	a0,0x5
    14e4:	3e050513          	addi	a0,a0,992 # 68c0 <malloc+0x98a>
    14e8:	00005097          	auipc	ra,0x5
    14ec:	992080e7          	jalr	-1646(ra) # 5e7a <printf>
    exit(1);
    14f0:	4505                	li	a0,1
    14f2:	00004097          	auipc	ra,0x4
    14f6:	622080e7          	jalr	1570(ra) # 5b14 <exit>
        printf("%s: open failed\n", s);
    14fa:	85e6                	mv	a1,s9
    14fc:	00005517          	auipc	a0,0x5
    1500:	3dc50513          	addi	a0,a0,988 # 68d8 <malloc+0x9a2>
    1504:	00005097          	auipc	ra,0x5
    1508:	976080e7          	jalr	-1674(ra) # 5e7a <printf>
        exit(1);
    150c:	4505                	li	a0,1
    150e:	00004097          	auipc	ra,0x4
    1512:	606080e7          	jalr	1542(ra) # 5b14 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1516:	862a                	mv	a2,a0
    1518:	85e6                	mv	a1,s9
    151a:	00005517          	auipc	a0,0x5
    151e:	3e650513          	addi	a0,a0,998 # 6900 <malloc+0x9ca>
    1522:	00005097          	auipc	ra,0x5
    1526:	958080e7          	jalr	-1704(ra) # 5e7a <printf>
        exit(1);
    152a:	4505                	li	a0,1
    152c:	00004097          	auipc	ra,0x4
    1530:	5e8080e7          	jalr	1512(ra) # 5b14 <exit>
    1534:	fca6                	sd	s1,120(sp)
    1536:	f8ca                	sd	s2,112(sp)
    1538:	f4ce                	sd	s3,104(sp)
    153a:	f0d2                	sd	s4,96(sp)
    153c:	ecd6                	sd	s5,88(sp)
    153e:	e8da                	sd	s6,80(sp)
    1540:	09600913          	li	s2,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1544:	60100a93          	li	s5,1537
    1548:	00005a17          	auipc	s4,0x5
    154c:	b78a0a13          	addi	s4,s4,-1160 # 60c0 <malloc+0x18a>
    int n = write(fd, "xxx", 3);
    1550:	498d                	li	s3,3
    1552:	00005b17          	auipc	s6,0x5
    1556:	3ceb0b13          	addi	s6,s6,974 # 6920 <malloc+0x9ea>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    155a:	85d6                	mv	a1,s5
    155c:	8552                	mv	a0,s4
    155e:	00004097          	auipc	ra,0x4
    1562:	5f6080e7          	jalr	1526(ra) # 5b54 <open>
    1566:	84aa                	mv	s1,a0
    if(fd < 0){
    1568:	04054863          	bltz	a0,15b8 <truncate3+0x1b0>
    int n = write(fd, "xxx", 3);
    156c:	864e                	mv	a2,s3
    156e:	85da                	mv	a1,s6
    1570:	00004097          	auipc	ra,0x4
    1574:	5c4080e7          	jalr	1476(ra) # 5b34 <write>
    if(n != 3){
    1578:	07351063          	bne	a0,s3,15d8 <truncate3+0x1d0>
    close(fd);
    157c:	8526                	mv	a0,s1
    157e:	00004097          	auipc	ra,0x4
    1582:	5be080e7          	jalr	1470(ra) # 5b3c <close>
  for(int i = 0; i < 150; i++){
    1586:	397d                	addiw	s2,s2,-1
    1588:	fc0919e3          	bnez	s2,155a <truncate3+0x152>
    158c:	e4de                	sd	s7,72(sp)
    158e:	e0e2                	sd	s8,64(sp)
  wait(&xstatus);
    1590:	f9c40513          	addi	a0,s0,-100
    1594:	00004097          	auipc	ra,0x4
    1598:	588080e7          	jalr	1416(ra) # 5b1c <wait>
  unlink("truncfile");
    159c:	00005517          	auipc	a0,0x5
    15a0:	b2450513          	addi	a0,a0,-1244 # 60c0 <malloc+0x18a>
    15a4:	00004097          	auipc	ra,0x4
    15a8:	5c0080e7          	jalr	1472(ra) # 5b64 <unlink>
  exit(xstatus);
    15ac:	f9c42503          	lw	a0,-100(s0)
    15b0:	00004097          	auipc	ra,0x4
    15b4:	564080e7          	jalr	1380(ra) # 5b14 <exit>
    15b8:	e4de                	sd	s7,72(sp)
    15ba:	e0e2                	sd	s8,64(sp)
      printf("%s: open failed\n", s);
    15bc:	85e6                	mv	a1,s9
    15be:	00005517          	auipc	a0,0x5
    15c2:	31a50513          	addi	a0,a0,794 # 68d8 <malloc+0x9a2>
    15c6:	00005097          	auipc	ra,0x5
    15ca:	8b4080e7          	jalr	-1868(ra) # 5e7a <printf>
      exit(1);
    15ce:	4505                	li	a0,1
    15d0:	00004097          	auipc	ra,0x4
    15d4:	544080e7          	jalr	1348(ra) # 5b14 <exit>
    15d8:	e4de                	sd	s7,72(sp)
    15da:	e0e2                	sd	s8,64(sp)
      printf("%s: write got %d, expected 3\n", s, n);
    15dc:	862a                	mv	a2,a0
    15de:	85e6                	mv	a1,s9
    15e0:	00005517          	auipc	a0,0x5
    15e4:	34850513          	addi	a0,a0,840 # 6928 <malloc+0x9f2>
    15e8:	00005097          	auipc	ra,0x5
    15ec:	892080e7          	jalr	-1902(ra) # 5e7a <printf>
      exit(1);
    15f0:	4505                	li	a0,1
    15f2:	00004097          	auipc	ra,0x4
    15f6:	522080e7          	jalr	1314(ra) # 5b14 <exit>

00000000000015fa <exectest>:
{
    15fa:	715d                	addi	sp,sp,-80
    15fc:	e486                	sd	ra,72(sp)
    15fe:	e0a2                	sd	s0,64(sp)
    1600:	f84a                	sd	s2,48(sp)
    1602:	0880                	addi	s0,sp,80
    1604:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1606:	00005797          	auipc	a5,0x5
    160a:	a6278793          	addi	a5,a5,-1438 # 6068 <malloc+0x132>
    160e:	fcf43023          	sd	a5,-64(s0)
    1612:	00005797          	auipc	a5,0x5
    1616:	33678793          	addi	a5,a5,822 # 6948 <malloc+0xa12>
    161a:	fcf43423          	sd	a5,-56(s0)
    161e:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    1622:	00005517          	auipc	a0,0x5
    1626:	32e50513          	addi	a0,a0,814 # 6950 <malloc+0xa1a>
    162a:	00004097          	auipc	ra,0x4
    162e:	53a080e7          	jalr	1338(ra) # 5b64 <unlink>
  pid = fork();
    1632:	00004097          	auipc	ra,0x4
    1636:	4da080e7          	jalr	1242(ra) # 5b0c <fork>
  if(pid < 0) {
    163a:	04054763          	bltz	a0,1688 <exectest+0x8e>
    163e:	fc26                	sd	s1,56(sp)
    1640:	84aa                	mv	s1,a0
  if(pid == 0) {
    1642:	ed41                	bnez	a0,16da <exectest+0xe0>
    close(1);
    1644:	4505                	li	a0,1
    1646:	00004097          	auipc	ra,0x4
    164a:	4f6080e7          	jalr	1270(ra) # 5b3c <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    164e:	20100593          	li	a1,513
    1652:	00005517          	auipc	a0,0x5
    1656:	2fe50513          	addi	a0,a0,766 # 6950 <malloc+0xa1a>
    165a:	00004097          	auipc	ra,0x4
    165e:	4fa080e7          	jalr	1274(ra) # 5b54 <open>
    if(fd < 0) {
    1662:	04054263          	bltz	a0,16a6 <exectest+0xac>
    if(fd != 1) {
    1666:	4785                	li	a5,1
    1668:	04f50d63          	beq	a0,a5,16c2 <exectest+0xc8>
      printf("%s: wrong fd\n", s);
    166c:	85ca                	mv	a1,s2
    166e:	00005517          	auipc	a0,0x5
    1672:	30250513          	addi	a0,a0,770 # 6970 <malloc+0xa3a>
    1676:	00005097          	auipc	ra,0x5
    167a:	804080e7          	jalr	-2044(ra) # 5e7a <printf>
      exit(1);
    167e:	4505                	li	a0,1
    1680:	00004097          	auipc	ra,0x4
    1684:	494080e7          	jalr	1172(ra) # 5b14 <exit>
    1688:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    168a:	85ca                	mv	a1,s2
    168c:	00005517          	auipc	a0,0x5
    1690:	23450513          	addi	a0,a0,564 # 68c0 <malloc+0x98a>
    1694:	00004097          	auipc	ra,0x4
    1698:	7e6080e7          	jalr	2022(ra) # 5e7a <printf>
     exit(1);
    169c:	4505                	li	a0,1
    169e:	00004097          	auipc	ra,0x4
    16a2:	476080e7          	jalr	1142(ra) # 5b14 <exit>
      printf("%s: create failed\n", s);
    16a6:	85ca                	mv	a1,s2
    16a8:	00005517          	auipc	a0,0x5
    16ac:	2b050513          	addi	a0,a0,688 # 6958 <malloc+0xa22>
    16b0:	00004097          	auipc	ra,0x4
    16b4:	7ca080e7          	jalr	1994(ra) # 5e7a <printf>
      exit(1);
    16b8:	4505                	li	a0,1
    16ba:	00004097          	auipc	ra,0x4
    16be:	45a080e7          	jalr	1114(ra) # 5b14 <exit>
    if(exec("echo", echoargv) < 0){
    16c2:	fc040593          	addi	a1,s0,-64
    16c6:	00005517          	auipc	a0,0x5
    16ca:	9a250513          	addi	a0,a0,-1630 # 6068 <malloc+0x132>
    16ce:	00004097          	auipc	ra,0x4
    16d2:	47e080e7          	jalr	1150(ra) # 5b4c <exec>
    16d6:	02054163          	bltz	a0,16f8 <exectest+0xfe>
  if (wait(&xstatus) != pid) {
    16da:	fdc40513          	addi	a0,s0,-36
    16de:	00004097          	auipc	ra,0x4
    16e2:	43e080e7          	jalr	1086(ra) # 5b1c <wait>
    16e6:	02951763          	bne	a0,s1,1714 <exectest+0x11a>
  if(xstatus != 0)
    16ea:	fdc42503          	lw	a0,-36(s0)
    16ee:	cd0d                	beqz	a0,1728 <exectest+0x12e>
    exit(xstatus);
    16f0:	00004097          	auipc	ra,0x4
    16f4:	424080e7          	jalr	1060(ra) # 5b14 <exit>
      printf("%s: exec echo failed\n", s);
    16f8:	85ca                	mv	a1,s2
    16fa:	00005517          	auipc	a0,0x5
    16fe:	28650513          	addi	a0,a0,646 # 6980 <malloc+0xa4a>
    1702:	00004097          	auipc	ra,0x4
    1706:	778080e7          	jalr	1912(ra) # 5e7a <printf>
      exit(1);
    170a:	4505                	li	a0,1
    170c:	00004097          	auipc	ra,0x4
    1710:	408080e7          	jalr	1032(ra) # 5b14 <exit>
    printf("%s: wait failed!\n", s);
    1714:	85ca                	mv	a1,s2
    1716:	00005517          	auipc	a0,0x5
    171a:	28250513          	addi	a0,a0,642 # 6998 <malloc+0xa62>
    171e:	00004097          	auipc	ra,0x4
    1722:	75c080e7          	jalr	1884(ra) # 5e7a <printf>
    1726:	b7d1                	j	16ea <exectest+0xf0>
  fd = open("echo-ok", O_RDONLY);
    1728:	4581                	li	a1,0
    172a:	00005517          	auipc	a0,0x5
    172e:	22650513          	addi	a0,a0,550 # 6950 <malloc+0xa1a>
    1732:	00004097          	auipc	ra,0x4
    1736:	422080e7          	jalr	1058(ra) # 5b54 <open>
  if(fd < 0) {
    173a:	02054a63          	bltz	a0,176e <exectest+0x174>
  if (read(fd, buf, 2) != 2) {
    173e:	4609                	li	a2,2
    1740:	fb840593          	addi	a1,s0,-72
    1744:	00004097          	auipc	ra,0x4
    1748:	3e8080e7          	jalr	1000(ra) # 5b2c <read>
    174c:	4789                	li	a5,2
    174e:	02f50e63          	beq	a0,a5,178a <exectest+0x190>
    printf("%s: read failed\n", s);
    1752:	85ca                	mv	a1,s2
    1754:	00005517          	auipc	a0,0x5
    1758:	cb450513          	addi	a0,a0,-844 # 6408 <malloc+0x4d2>
    175c:	00004097          	auipc	ra,0x4
    1760:	71e080e7          	jalr	1822(ra) # 5e7a <printf>
    exit(1);
    1764:	4505                	li	a0,1
    1766:	00004097          	auipc	ra,0x4
    176a:	3ae080e7          	jalr	942(ra) # 5b14 <exit>
    printf("%s: open failed\n", s);
    176e:	85ca                	mv	a1,s2
    1770:	00005517          	auipc	a0,0x5
    1774:	16850513          	addi	a0,a0,360 # 68d8 <malloc+0x9a2>
    1778:	00004097          	auipc	ra,0x4
    177c:	702080e7          	jalr	1794(ra) # 5e7a <printf>
    exit(1);
    1780:	4505                	li	a0,1
    1782:	00004097          	auipc	ra,0x4
    1786:	392080e7          	jalr	914(ra) # 5b14 <exit>
  unlink("echo-ok");
    178a:	00005517          	auipc	a0,0x5
    178e:	1c650513          	addi	a0,a0,454 # 6950 <malloc+0xa1a>
    1792:	00004097          	auipc	ra,0x4
    1796:	3d2080e7          	jalr	978(ra) # 5b64 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    179a:	fb844703          	lbu	a4,-72(s0)
    179e:	04f00793          	li	a5,79
    17a2:	00f71863          	bne	a4,a5,17b2 <exectest+0x1b8>
    17a6:	fb944703          	lbu	a4,-71(s0)
    17aa:	04b00793          	li	a5,75
    17ae:	02f70063          	beq	a4,a5,17ce <exectest+0x1d4>
    printf("%s: wrong output\n", s);
    17b2:	85ca                	mv	a1,s2
    17b4:	00005517          	auipc	a0,0x5
    17b8:	1fc50513          	addi	a0,a0,508 # 69b0 <malloc+0xa7a>
    17bc:	00004097          	auipc	ra,0x4
    17c0:	6be080e7          	jalr	1726(ra) # 5e7a <printf>
    exit(1);
    17c4:	4505                	li	a0,1
    17c6:	00004097          	auipc	ra,0x4
    17ca:	34e080e7          	jalr	846(ra) # 5b14 <exit>
    exit(0);
    17ce:	4501                	li	a0,0
    17d0:	00004097          	auipc	ra,0x4
    17d4:	344080e7          	jalr	836(ra) # 5b14 <exit>

00000000000017d8 <pipe1>:
{
    17d8:	711d                	addi	sp,sp,-96
    17da:	ec86                	sd	ra,88(sp)
    17dc:	e8a2                	sd	s0,80(sp)
    17de:	e862                	sd	s8,16(sp)
    17e0:	1080                	addi	s0,sp,96
    17e2:	8c2a                	mv	s8,a0
  if(pipe(fds) != 0){
    17e4:	fa840513          	addi	a0,s0,-88
    17e8:	00004097          	auipc	ra,0x4
    17ec:	33c080e7          	jalr	828(ra) # 5b24 <pipe>
    17f0:	ed35                	bnez	a0,186c <pipe1+0x94>
    17f2:	e4a6                	sd	s1,72(sp)
    17f4:	fc4e                	sd	s3,56(sp)
    17f6:	84aa                	mv	s1,a0
  pid = fork();
    17f8:	00004097          	auipc	ra,0x4
    17fc:	314080e7          	jalr	788(ra) # 5b0c <fork>
    1800:	89aa                	mv	s3,a0
  if(pid == 0){
    1802:	c951                	beqz	a0,1896 <pipe1+0xbe>
  } else if(pid > 0){
    1804:	18a05d63          	blez	a0,199e <pipe1+0x1c6>
    1808:	e0ca                	sd	s2,64(sp)
    180a:	f852                	sd	s4,48(sp)
    close(fds[1]);
    180c:	fac42503          	lw	a0,-84(s0)
    1810:	00004097          	auipc	ra,0x4
    1814:	32c080e7          	jalr	812(ra) # 5b3c <close>
    total = 0;
    1818:	89a6                	mv	s3,s1
    cc = 1;
    181a:	4905                	li	s2,1
    while((n = read(fds[0], buf, cc)) > 0){
    181c:	0000ca17          	auipc	s4,0xc
    1820:	c34a0a13          	addi	s4,s4,-972 # d450 <buf>
    1824:	864a                	mv	a2,s2
    1826:	85d2                	mv	a1,s4
    1828:	fa842503          	lw	a0,-88(s0)
    182c:	00004097          	auipc	ra,0x4
    1830:	300080e7          	jalr	768(ra) # 5b2c <read>
    1834:	85aa                	mv	a1,a0
    1836:	10a05963          	blez	a0,1948 <pipe1+0x170>
    183a:	0000c797          	auipc	a5,0xc
    183e:	c1678793          	addi	a5,a5,-1002 # d450 <buf>
    1842:	00b4863b          	addw	a2,s1,a1
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1846:	0007c683          	lbu	a3,0(a5)
    184a:	0ff4f713          	zext.b	a4,s1
    184e:	0ce69b63          	bne	a3,a4,1924 <pipe1+0x14c>
    1852:	2485                	addiw	s1,s1,1
      for(i = 0; i < n; i++){
    1854:	0785                	addi	a5,a5,1
    1856:	fec498e3          	bne	s1,a2,1846 <pipe1+0x6e>
      total += n;
    185a:	00b989bb          	addw	s3,s3,a1
      cc = cc * 2;
    185e:	0019191b          	slliw	s2,s2,0x1
      if(cc > sizeof(buf))
    1862:	678d                	lui	a5,0x3
    1864:	fd27f0e3          	bgeu	a5,s2,1824 <pipe1+0x4c>
        cc = sizeof(buf);
    1868:	893e                	mv	s2,a5
    186a:	bf6d                	j	1824 <pipe1+0x4c>
    186c:	e4a6                	sd	s1,72(sp)
    186e:	e0ca                	sd	s2,64(sp)
    1870:	fc4e                	sd	s3,56(sp)
    1872:	f852                	sd	s4,48(sp)
    1874:	f456                	sd	s5,40(sp)
    1876:	f05a                	sd	s6,32(sp)
    1878:	ec5e                	sd	s7,24(sp)
    printf("%s: pipe() failed\n", s);
    187a:	85e2                	mv	a1,s8
    187c:	00005517          	auipc	a0,0x5
    1880:	14c50513          	addi	a0,a0,332 # 69c8 <malloc+0xa92>
    1884:	00004097          	auipc	ra,0x4
    1888:	5f6080e7          	jalr	1526(ra) # 5e7a <printf>
    exit(1);
    188c:	4505                	li	a0,1
    188e:	00004097          	auipc	ra,0x4
    1892:	286080e7          	jalr	646(ra) # 5b14 <exit>
    1896:	e0ca                	sd	s2,64(sp)
    1898:	f852                	sd	s4,48(sp)
    189a:	f456                	sd	s5,40(sp)
    189c:	f05a                	sd	s6,32(sp)
    189e:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    18a0:	fa842503          	lw	a0,-88(s0)
    18a4:	00004097          	auipc	ra,0x4
    18a8:	298080e7          	jalr	664(ra) # 5b3c <close>
    for(n = 0; n < N; n++){
    18ac:	0000cb17          	auipc	s6,0xc
    18b0:	ba4b0b13          	addi	s6,s6,-1116 # d450 <buf>
    18b4:	416004bb          	negw	s1,s6
    18b8:	0ff4f493          	zext.b	s1,s1
    18bc:	409b0913          	addi	s2,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    18c0:	40900a13          	li	s4,1033
    18c4:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    18c6:	6a85                	lui	s5,0x1
    18c8:	42da8a93          	addi	s5,s5,1069 # 142d <truncate3+0x25>
{
    18cc:	87da                	mv	a5,s6
        buf[i] = seq++;
    18ce:	0097873b          	addw	a4,a5,s1
    18d2:	00e78023          	sb	a4,0(a5) # 3000 <fourteen+0xbc>
      for(i = 0; i < SZ; i++)
    18d6:	0785                	addi	a5,a5,1
    18d8:	ff279be3          	bne	a5,s2,18ce <pipe1+0xf6>
      if(write(fds[1], buf, SZ) != SZ){
    18dc:	8652                	mv	a2,s4
    18de:	85de                	mv	a1,s7
    18e0:	fac42503          	lw	a0,-84(s0)
    18e4:	00004097          	auipc	ra,0x4
    18e8:	250080e7          	jalr	592(ra) # 5b34 <write>
    18ec:	01451e63          	bne	a0,s4,1908 <pipe1+0x130>
    18f0:	4099899b          	addiw	s3,s3,1033
    for(n = 0; n < N; n++){
    18f4:	24a5                	addiw	s1,s1,9
    18f6:	0ff4f493          	zext.b	s1,s1
    18fa:	fd5999e3          	bne	s3,s5,18cc <pipe1+0xf4>
    exit(0);
    18fe:	4501                	li	a0,0
    1900:	00004097          	auipc	ra,0x4
    1904:	214080e7          	jalr	532(ra) # 5b14 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1908:	85e2                	mv	a1,s8
    190a:	00005517          	auipc	a0,0x5
    190e:	0d650513          	addi	a0,a0,214 # 69e0 <malloc+0xaaa>
    1912:	00004097          	auipc	ra,0x4
    1916:	568080e7          	jalr	1384(ra) # 5e7a <printf>
        exit(1);
    191a:	4505                	li	a0,1
    191c:	00004097          	auipc	ra,0x4
    1920:	1f8080e7          	jalr	504(ra) # 5b14 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1924:	85e2                	mv	a1,s8
    1926:	00005517          	auipc	a0,0x5
    192a:	0d250513          	addi	a0,a0,210 # 69f8 <malloc+0xac2>
    192e:	00004097          	auipc	ra,0x4
    1932:	54c080e7          	jalr	1356(ra) # 5e7a <printf>
          return;
    1936:	64a6                	ld	s1,72(sp)
    1938:	6906                	ld	s2,64(sp)
    193a:	79e2                	ld	s3,56(sp)
    193c:	7a42                	ld	s4,48(sp)
}
    193e:	60e6                	ld	ra,88(sp)
    1940:	6446                	ld	s0,80(sp)
    1942:	6c42                	ld	s8,16(sp)
    1944:	6125                	addi	sp,sp,96
    1946:	8082                	ret
    if(total != N * SZ){
    1948:	6785                	lui	a5,0x1
    194a:	42d78793          	addi	a5,a5,1069 # 142d <truncate3+0x25>
    194e:	02f98363          	beq	s3,a5,1974 <pipe1+0x19c>
    1952:	f456                	sd	s5,40(sp)
    1954:	f05a                	sd	s6,32(sp)
    1956:	ec5e                	sd	s7,24(sp)
      printf("%s: pipe1 oops 3 total %d\n", total);
    1958:	85ce                	mv	a1,s3
    195a:	00005517          	auipc	a0,0x5
    195e:	0b650513          	addi	a0,a0,182 # 6a10 <malloc+0xada>
    1962:	00004097          	auipc	ra,0x4
    1966:	518080e7          	jalr	1304(ra) # 5e7a <printf>
      exit(1);
    196a:	4505                	li	a0,1
    196c:	00004097          	auipc	ra,0x4
    1970:	1a8080e7          	jalr	424(ra) # 5b14 <exit>
    1974:	f456                	sd	s5,40(sp)
    1976:	f05a                	sd	s6,32(sp)
    1978:	ec5e                	sd	s7,24(sp)
    close(fds[0]);
    197a:	fa842503          	lw	a0,-88(s0)
    197e:	00004097          	auipc	ra,0x4
    1982:	1be080e7          	jalr	446(ra) # 5b3c <close>
    wait(&xstatus);
    1986:	fa440513          	addi	a0,s0,-92
    198a:	00004097          	auipc	ra,0x4
    198e:	192080e7          	jalr	402(ra) # 5b1c <wait>
    exit(xstatus);
    1992:	fa442503          	lw	a0,-92(s0)
    1996:	00004097          	auipc	ra,0x4
    199a:	17e080e7          	jalr	382(ra) # 5b14 <exit>
    199e:	e0ca                	sd	s2,64(sp)
    19a0:	f852                	sd	s4,48(sp)
    19a2:	f456                	sd	s5,40(sp)
    19a4:	f05a                	sd	s6,32(sp)
    19a6:	ec5e                	sd	s7,24(sp)
    printf("%s: fork() failed\n", s);
    19a8:	85e2                	mv	a1,s8
    19aa:	00005517          	auipc	a0,0x5
    19ae:	08650513          	addi	a0,a0,134 # 6a30 <malloc+0xafa>
    19b2:	00004097          	auipc	ra,0x4
    19b6:	4c8080e7          	jalr	1224(ra) # 5e7a <printf>
    exit(1);
    19ba:	4505                	li	a0,1
    19bc:	00004097          	auipc	ra,0x4
    19c0:	158080e7          	jalr	344(ra) # 5b14 <exit>

00000000000019c4 <exitwait>:
{
    19c4:	715d                	addi	sp,sp,-80
    19c6:	e486                	sd	ra,72(sp)
    19c8:	e0a2                	sd	s0,64(sp)
    19ca:	fc26                	sd	s1,56(sp)
    19cc:	f84a                	sd	s2,48(sp)
    19ce:	f44e                	sd	s3,40(sp)
    19d0:	f052                	sd	s4,32(sp)
    19d2:	ec56                	sd	s5,24(sp)
    19d4:	0880                	addi	s0,sp,80
    19d6:	8aaa                	mv	s5,a0
  for(i = 0; i < 100; i++){
    19d8:	4901                	li	s2,0
      if(wait(&xstate) != pid){
    19da:	fbc40993          	addi	s3,s0,-68
  for(i = 0; i < 100; i++){
    19de:	06400a13          	li	s4,100
    pid = fork();
    19e2:	00004097          	auipc	ra,0x4
    19e6:	12a080e7          	jalr	298(ra) # 5b0c <fork>
    19ea:	84aa                	mv	s1,a0
    if(pid < 0){
    19ec:	02054a63          	bltz	a0,1a20 <exitwait+0x5c>
    if(pid){
    19f0:	c151                	beqz	a0,1a74 <exitwait+0xb0>
      if(wait(&xstate) != pid){
    19f2:	854e                	mv	a0,s3
    19f4:	00004097          	auipc	ra,0x4
    19f8:	128080e7          	jalr	296(ra) # 5b1c <wait>
    19fc:	04951063          	bne	a0,s1,1a3c <exitwait+0x78>
      if(i != xstate) {
    1a00:	fbc42783          	lw	a5,-68(s0)
    1a04:	05279a63          	bne	a5,s2,1a58 <exitwait+0x94>
  for(i = 0; i < 100; i++){
    1a08:	2905                	addiw	s2,s2,1
    1a0a:	fd491ce3          	bne	s2,s4,19e2 <exitwait+0x1e>
}
    1a0e:	60a6                	ld	ra,72(sp)
    1a10:	6406                	ld	s0,64(sp)
    1a12:	74e2                	ld	s1,56(sp)
    1a14:	7942                	ld	s2,48(sp)
    1a16:	79a2                	ld	s3,40(sp)
    1a18:	7a02                	ld	s4,32(sp)
    1a1a:	6ae2                	ld	s5,24(sp)
    1a1c:	6161                	addi	sp,sp,80
    1a1e:	8082                	ret
      printf("%s: fork failed\n", s);
    1a20:	85d6                	mv	a1,s5
    1a22:	00005517          	auipc	a0,0x5
    1a26:	e9e50513          	addi	a0,a0,-354 # 68c0 <malloc+0x98a>
    1a2a:	00004097          	auipc	ra,0x4
    1a2e:	450080e7          	jalr	1104(ra) # 5e7a <printf>
      exit(1);
    1a32:	4505                	li	a0,1
    1a34:	00004097          	auipc	ra,0x4
    1a38:	0e0080e7          	jalr	224(ra) # 5b14 <exit>
        printf("%s: wait wrong pid\n", s);
    1a3c:	85d6                	mv	a1,s5
    1a3e:	00005517          	auipc	a0,0x5
    1a42:	00a50513          	addi	a0,a0,10 # 6a48 <malloc+0xb12>
    1a46:	00004097          	auipc	ra,0x4
    1a4a:	434080e7          	jalr	1076(ra) # 5e7a <printf>
        exit(1);
    1a4e:	4505                	li	a0,1
    1a50:	00004097          	auipc	ra,0x4
    1a54:	0c4080e7          	jalr	196(ra) # 5b14 <exit>
        printf("%s: wait wrong exit status\n", s);
    1a58:	85d6                	mv	a1,s5
    1a5a:	00005517          	auipc	a0,0x5
    1a5e:	00650513          	addi	a0,a0,6 # 6a60 <malloc+0xb2a>
    1a62:	00004097          	auipc	ra,0x4
    1a66:	418080e7          	jalr	1048(ra) # 5e7a <printf>
        exit(1);
    1a6a:	4505                	li	a0,1
    1a6c:	00004097          	auipc	ra,0x4
    1a70:	0a8080e7          	jalr	168(ra) # 5b14 <exit>
      exit(i);
    1a74:	854a                	mv	a0,s2
    1a76:	00004097          	auipc	ra,0x4
    1a7a:	09e080e7          	jalr	158(ra) # 5b14 <exit>

0000000000001a7e <twochildren>:
{
    1a7e:	1101                	addi	sp,sp,-32
    1a80:	ec06                	sd	ra,24(sp)
    1a82:	e822                	sd	s0,16(sp)
    1a84:	e426                	sd	s1,8(sp)
    1a86:	e04a                	sd	s2,0(sp)
    1a88:	1000                	addi	s0,sp,32
    1a8a:	892a                	mv	s2,a0
    1a8c:	3e800493          	li	s1,1000
    int pid1 = fork();
    1a90:	00004097          	auipc	ra,0x4
    1a94:	07c080e7          	jalr	124(ra) # 5b0c <fork>
    if(pid1 < 0){
    1a98:	02054c63          	bltz	a0,1ad0 <twochildren+0x52>
    if(pid1 == 0){
    1a9c:	c921                	beqz	a0,1aec <twochildren+0x6e>
      int pid2 = fork();
    1a9e:	00004097          	auipc	ra,0x4
    1aa2:	06e080e7          	jalr	110(ra) # 5b0c <fork>
      if(pid2 < 0){
    1aa6:	04054763          	bltz	a0,1af4 <twochildren+0x76>
      if(pid2 == 0){
    1aaa:	c13d                	beqz	a0,1b10 <twochildren+0x92>
        wait(0);
    1aac:	4501                	li	a0,0
    1aae:	00004097          	auipc	ra,0x4
    1ab2:	06e080e7          	jalr	110(ra) # 5b1c <wait>
        wait(0);
    1ab6:	4501                	li	a0,0
    1ab8:	00004097          	auipc	ra,0x4
    1abc:	064080e7          	jalr	100(ra) # 5b1c <wait>
  for(int i = 0; i < 1000; i++){
    1ac0:	34fd                	addiw	s1,s1,-1
    1ac2:	f4f9                	bnez	s1,1a90 <twochildren+0x12>
}
    1ac4:	60e2                	ld	ra,24(sp)
    1ac6:	6442                	ld	s0,16(sp)
    1ac8:	64a2                	ld	s1,8(sp)
    1aca:	6902                	ld	s2,0(sp)
    1acc:	6105                	addi	sp,sp,32
    1ace:	8082                	ret
      printf("%s: fork failed\n", s);
    1ad0:	85ca                	mv	a1,s2
    1ad2:	00005517          	auipc	a0,0x5
    1ad6:	dee50513          	addi	a0,a0,-530 # 68c0 <malloc+0x98a>
    1ada:	00004097          	auipc	ra,0x4
    1ade:	3a0080e7          	jalr	928(ra) # 5e7a <printf>
      exit(1);
    1ae2:	4505                	li	a0,1
    1ae4:	00004097          	auipc	ra,0x4
    1ae8:	030080e7          	jalr	48(ra) # 5b14 <exit>
      exit(0);
    1aec:	00004097          	auipc	ra,0x4
    1af0:	028080e7          	jalr	40(ra) # 5b14 <exit>
        printf("%s: fork failed\n", s);
    1af4:	85ca                	mv	a1,s2
    1af6:	00005517          	auipc	a0,0x5
    1afa:	dca50513          	addi	a0,a0,-566 # 68c0 <malloc+0x98a>
    1afe:	00004097          	auipc	ra,0x4
    1b02:	37c080e7          	jalr	892(ra) # 5e7a <printf>
        exit(1);
    1b06:	4505                	li	a0,1
    1b08:	00004097          	auipc	ra,0x4
    1b0c:	00c080e7          	jalr	12(ra) # 5b14 <exit>
        exit(0);
    1b10:	00004097          	auipc	ra,0x4
    1b14:	004080e7          	jalr	4(ra) # 5b14 <exit>

0000000000001b18 <forkfork>:
{
    1b18:	7179                	addi	sp,sp,-48
    1b1a:	f406                	sd	ra,40(sp)
    1b1c:	f022                	sd	s0,32(sp)
    1b1e:	ec26                	sd	s1,24(sp)
    1b20:	1800                	addi	s0,sp,48
    1b22:	84aa                	mv	s1,a0
    int pid = fork();
    1b24:	00004097          	auipc	ra,0x4
    1b28:	fe8080e7          	jalr	-24(ra) # 5b0c <fork>
    if(pid < 0){
    1b2c:	04054163          	bltz	a0,1b6e <forkfork+0x56>
    if(pid == 0){
    1b30:	cd29                	beqz	a0,1b8a <forkfork+0x72>
    int pid = fork();
    1b32:	00004097          	auipc	ra,0x4
    1b36:	fda080e7          	jalr	-38(ra) # 5b0c <fork>
    if(pid < 0){
    1b3a:	02054a63          	bltz	a0,1b6e <forkfork+0x56>
    if(pid == 0){
    1b3e:	c531                	beqz	a0,1b8a <forkfork+0x72>
    wait(&xstatus);
    1b40:	fdc40513          	addi	a0,s0,-36
    1b44:	00004097          	auipc	ra,0x4
    1b48:	fd8080e7          	jalr	-40(ra) # 5b1c <wait>
    if(xstatus != 0) {
    1b4c:	fdc42783          	lw	a5,-36(s0)
    1b50:	ebbd                	bnez	a5,1bc6 <forkfork+0xae>
    wait(&xstatus);
    1b52:	fdc40513          	addi	a0,s0,-36
    1b56:	00004097          	auipc	ra,0x4
    1b5a:	fc6080e7          	jalr	-58(ra) # 5b1c <wait>
    if(xstatus != 0) {
    1b5e:	fdc42783          	lw	a5,-36(s0)
    1b62:	e3b5                	bnez	a5,1bc6 <forkfork+0xae>
}
    1b64:	70a2                	ld	ra,40(sp)
    1b66:	7402                	ld	s0,32(sp)
    1b68:	64e2                	ld	s1,24(sp)
    1b6a:	6145                	addi	sp,sp,48
    1b6c:	8082                	ret
      printf("%s: fork failed", s);
    1b6e:	85a6                	mv	a1,s1
    1b70:	00005517          	auipc	a0,0x5
    1b74:	f1050513          	addi	a0,a0,-240 # 6a80 <malloc+0xb4a>
    1b78:	00004097          	auipc	ra,0x4
    1b7c:	302080e7          	jalr	770(ra) # 5e7a <printf>
      exit(1);
    1b80:	4505                	li	a0,1
    1b82:	00004097          	auipc	ra,0x4
    1b86:	f92080e7          	jalr	-110(ra) # 5b14 <exit>
{
    1b8a:	0c800493          	li	s1,200
        int pid1 = fork();
    1b8e:	00004097          	auipc	ra,0x4
    1b92:	f7e080e7          	jalr	-130(ra) # 5b0c <fork>
        if(pid1 < 0){
    1b96:	00054f63          	bltz	a0,1bb4 <forkfork+0x9c>
        if(pid1 == 0){
    1b9a:	c115                	beqz	a0,1bbe <forkfork+0xa6>
        wait(0);
    1b9c:	4501                	li	a0,0
    1b9e:	00004097          	auipc	ra,0x4
    1ba2:	f7e080e7          	jalr	-130(ra) # 5b1c <wait>
      for(int j = 0; j < 200; j++){
    1ba6:	34fd                	addiw	s1,s1,-1
    1ba8:	f0fd                	bnez	s1,1b8e <forkfork+0x76>
      exit(0);
    1baa:	4501                	li	a0,0
    1bac:	00004097          	auipc	ra,0x4
    1bb0:	f68080e7          	jalr	-152(ra) # 5b14 <exit>
          exit(1);
    1bb4:	4505                	li	a0,1
    1bb6:	00004097          	auipc	ra,0x4
    1bba:	f5e080e7          	jalr	-162(ra) # 5b14 <exit>
          exit(0);
    1bbe:	00004097          	auipc	ra,0x4
    1bc2:	f56080e7          	jalr	-170(ra) # 5b14 <exit>
      printf("%s: fork in child failed", s);
    1bc6:	85a6                	mv	a1,s1
    1bc8:	00005517          	auipc	a0,0x5
    1bcc:	ec850513          	addi	a0,a0,-312 # 6a90 <malloc+0xb5a>
    1bd0:	00004097          	auipc	ra,0x4
    1bd4:	2aa080e7          	jalr	682(ra) # 5e7a <printf>
      exit(1);
    1bd8:	4505                	li	a0,1
    1bda:	00004097          	auipc	ra,0x4
    1bde:	f3a080e7          	jalr	-198(ra) # 5b14 <exit>

0000000000001be2 <reparent2>:
{
    1be2:	1101                	addi	sp,sp,-32
    1be4:	ec06                	sd	ra,24(sp)
    1be6:	e822                	sd	s0,16(sp)
    1be8:	e426                	sd	s1,8(sp)
    1bea:	1000                	addi	s0,sp,32
    1bec:	32000493          	li	s1,800
    int pid1 = fork();
    1bf0:	00004097          	auipc	ra,0x4
    1bf4:	f1c080e7          	jalr	-228(ra) # 5b0c <fork>
    if(pid1 < 0){
    1bf8:	00054f63          	bltz	a0,1c16 <reparent2+0x34>
    if(pid1 == 0){
    1bfc:	c915                	beqz	a0,1c30 <reparent2+0x4e>
    wait(0);
    1bfe:	4501                	li	a0,0
    1c00:	00004097          	auipc	ra,0x4
    1c04:	f1c080e7          	jalr	-228(ra) # 5b1c <wait>
  for(int i = 0; i < 800; i++){
    1c08:	34fd                	addiw	s1,s1,-1
    1c0a:	f0fd                	bnez	s1,1bf0 <reparent2+0xe>
  exit(0);
    1c0c:	4501                	li	a0,0
    1c0e:	00004097          	auipc	ra,0x4
    1c12:	f06080e7          	jalr	-250(ra) # 5b14 <exit>
      printf("fork failed\n");
    1c16:	00005517          	auipc	a0,0x5
    1c1a:	0ca50513          	addi	a0,a0,202 # 6ce0 <malloc+0xdaa>
    1c1e:	00004097          	auipc	ra,0x4
    1c22:	25c080e7          	jalr	604(ra) # 5e7a <printf>
      exit(1);
    1c26:	4505                	li	a0,1
    1c28:	00004097          	auipc	ra,0x4
    1c2c:	eec080e7          	jalr	-276(ra) # 5b14 <exit>
      fork();
    1c30:	00004097          	auipc	ra,0x4
    1c34:	edc080e7          	jalr	-292(ra) # 5b0c <fork>
      fork();
    1c38:	00004097          	auipc	ra,0x4
    1c3c:	ed4080e7          	jalr	-300(ra) # 5b0c <fork>
      exit(0);
    1c40:	4501                	li	a0,0
    1c42:	00004097          	auipc	ra,0x4
    1c46:	ed2080e7          	jalr	-302(ra) # 5b14 <exit>

0000000000001c4a <createdelete>:
{
    1c4a:	7135                	addi	sp,sp,-160
    1c4c:	ed06                	sd	ra,152(sp)
    1c4e:	e922                	sd	s0,144(sp)
    1c50:	e526                	sd	s1,136(sp)
    1c52:	e14a                	sd	s2,128(sp)
    1c54:	fcce                	sd	s3,120(sp)
    1c56:	f8d2                	sd	s4,112(sp)
    1c58:	f4d6                	sd	s5,104(sp)
    1c5a:	f0da                	sd	s6,96(sp)
    1c5c:	ecde                	sd	s7,88(sp)
    1c5e:	e8e2                	sd	s8,80(sp)
    1c60:	e4e6                	sd	s9,72(sp)
    1c62:	e0ea                	sd	s10,64(sp)
    1c64:	fc6e                	sd	s11,56(sp)
    1c66:	1100                	addi	s0,sp,160
    1c68:	8daa                	mv	s11,a0
  for(pi = 0; pi < NCHILD; pi++){
    1c6a:	4901                	li	s2,0
    1c6c:	4991                	li	s3,4
    pid = fork();
    1c6e:	00004097          	auipc	ra,0x4
    1c72:	e9e080e7          	jalr	-354(ra) # 5b0c <fork>
    1c76:	84aa                	mv	s1,a0
    if(pid < 0){
    1c78:	04054263          	bltz	a0,1cbc <createdelete+0x72>
    if(pid == 0){
    1c7c:	cd31                	beqz	a0,1cd8 <createdelete+0x8e>
  for(pi = 0; pi < NCHILD; pi++){
    1c7e:	2905                	addiw	s2,s2,1
    1c80:	ff3917e3          	bne	s2,s3,1c6e <createdelete+0x24>
    1c84:	4491                	li	s1,4
    wait(&xstatus);
    1c86:	f6c40913          	addi	s2,s0,-148
    1c8a:	854a                	mv	a0,s2
    1c8c:	00004097          	auipc	ra,0x4
    1c90:	e90080e7          	jalr	-368(ra) # 5b1c <wait>
    if(xstatus != 0)
    1c94:	f6c42a83          	lw	s5,-148(s0)
    1c98:	0e0a9663          	bnez	s5,1d84 <createdelete+0x13a>
  for(pi = 0; pi < NCHILD; pi++){
    1c9c:	34fd                	addiw	s1,s1,-1
    1c9e:	f4f5                	bnez	s1,1c8a <createdelete+0x40>
  name[0] = name[1] = name[2] = 0;
    1ca0:	f6040923          	sb	zero,-142(s0)
    1ca4:	03000913          	li	s2,48
    1ca8:	5a7d                	li	s4,-1
      if((i == 0 || i >= N/2) && fd < 0){
    1caa:	4d25                	li	s10,9
    1cac:	07000c93          	li	s9,112
      fd = open(name, 0);
    1cb0:	f7040c13          	addi	s8,s0,-144
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1cb4:	4ba1                	li	s7,8
    for(pi = 0; pi < NCHILD; pi++){
    1cb6:	07400b13          	li	s6,116
    1cba:	a28d                	j	1e1c <createdelete+0x1d2>
      printf("fork failed\n", s);
    1cbc:	85ee                	mv	a1,s11
    1cbe:	00005517          	auipc	a0,0x5
    1cc2:	02250513          	addi	a0,a0,34 # 6ce0 <malloc+0xdaa>
    1cc6:	00004097          	auipc	ra,0x4
    1cca:	1b4080e7          	jalr	436(ra) # 5e7a <printf>
      exit(1);
    1cce:	4505                	li	a0,1
    1cd0:	00004097          	auipc	ra,0x4
    1cd4:	e44080e7          	jalr	-444(ra) # 5b14 <exit>
      name[0] = 'p' + pi;
    1cd8:	0709091b          	addiw	s2,s2,112
    1cdc:	f7240823          	sb	s2,-144(s0)
      name[2] = '\0';
    1ce0:	f6040923          	sb	zero,-142(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1ce4:	f7040913          	addi	s2,s0,-144
    1ce8:	20200993          	li	s3,514
      for(i = 0; i < N; i++){
    1cec:	4a51                	li	s4,20
    1cee:	a081                	j	1d2e <createdelete+0xe4>
          printf("%s: create failed\n", s);
    1cf0:	85ee                	mv	a1,s11
    1cf2:	00005517          	auipc	a0,0x5
    1cf6:	c6650513          	addi	a0,a0,-922 # 6958 <malloc+0xa22>
    1cfa:	00004097          	auipc	ra,0x4
    1cfe:	180080e7          	jalr	384(ra) # 5e7a <printf>
          exit(1);
    1d02:	4505                	li	a0,1
    1d04:	00004097          	auipc	ra,0x4
    1d08:	e10080e7          	jalr	-496(ra) # 5b14 <exit>
          name[1] = '0' + (i / 2);
    1d0c:	01f4d79b          	srliw	a5,s1,0x1f
    1d10:	9fa5                	addw	a5,a5,s1
    1d12:	4017d79b          	sraiw	a5,a5,0x1
    1d16:	0307879b          	addiw	a5,a5,48
    1d1a:	f6f408a3          	sb	a5,-143(s0)
          if(unlink(name) < 0){
    1d1e:	854a                	mv	a0,s2
    1d20:	00004097          	auipc	ra,0x4
    1d24:	e44080e7          	jalr	-444(ra) # 5b64 <unlink>
    1d28:	04054063          	bltz	a0,1d68 <createdelete+0x11e>
      for(i = 0; i < N; i++){
    1d2c:	2485                	addiw	s1,s1,1
        name[1] = '0' + i;
    1d2e:	0304879b          	addiw	a5,s1,48
    1d32:	f6f408a3          	sb	a5,-143(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1d36:	85ce                	mv	a1,s3
    1d38:	854a                	mv	a0,s2
    1d3a:	00004097          	auipc	ra,0x4
    1d3e:	e1a080e7          	jalr	-486(ra) # 5b54 <open>
        if(fd < 0){
    1d42:	fa0547e3          	bltz	a0,1cf0 <createdelete+0xa6>
        close(fd);
    1d46:	00004097          	auipc	ra,0x4
    1d4a:	df6080e7          	jalr	-522(ra) # 5b3c <close>
        if(i > 0 && (i % 2 ) == 0){
    1d4e:	fc905fe3          	blez	s1,1d2c <createdelete+0xe2>
    1d52:	0014f793          	andi	a5,s1,1
    1d56:	dbdd                	beqz	a5,1d0c <createdelete+0xc2>
      for(i = 0; i < N; i++){
    1d58:	2485                	addiw	s1,s1,1
    1d5a:	fd449ae3          	bne	s1,s4,1d2e <createdelete+0xe4>
      exit(0);
    1d5e:	4501                	li	a0,0
    1d60:	00004097          	auipc	ra,0x4
    1d64:	db4080e7          	jalr	-588(ra) # 5b14 <exit>
            printf("%s: unlink failed\n", s);
    1d68:	85ee                	mv	a1,s11
    1d6a:	00005517          	auipc	a0,0x5
    1d6e:	d4650513          	addi	a0,a0,-698 # 6ab0 <malloc+0xb7a>
    1d72:	00004097          	auipc	ra,0x4
    1d76:	108080e7          	jalr	264(ra) # 5e7a <printf>
            exit(1);
    1d7a:	4505                	li	a0,1
    1d7c:	00004097          	auipc	ra,0x4
    1d80:	d98080e7          	jalr	-616(ra) # 5b14 <exit>
      exit(1);
    1d84:	4505                	li	a0,1
    1d86:	00004097          	auipc	ra,0x4
    1d8a:	d8e080e7          	jalr	-626(ra) # 5b14 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d8e:	054bf863          	bgeu	s7,s4,1dde <createdelete+0x194>
      if(fd >= 0)
    1d92:	06055863          	bgez	a0,1e02 <createdelete+0x1b8>
    for(pi = 0; pi < NCHILD; pi++){
    1d96:	2485                	addiw	s1,s1,1
    1d98:	0ff4f493          	zext.b	s1,s1
    1d9c:	07648863          	beq	s1,s6,1e0c <createdelete+0x1c2>
      name[0] = 'p' + pi;
    1da0:	f6940823          	sb	s1,-144(s0)
      name[1] = '0' + i;
    1da4:	f72408a3          	sb	s2,-143(s0)
      fd = open(name, 0);
    1da8:	4581                	li	a1,0
    1daa:	8562                	mv	a0,s8
    1dac:	00004097          	auipc	ra,0x4
    1db0:	da8080e7          	jalr	-600(ra) # 5b54 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1db4:	01f5579b          	srliw	a5,a0,0x1f
    1db8:	dbf9                	beqz	a5,1d8e <createdelete+0x144>
    1dba:	fc098ae3          	beqz	s3,1d8e <createdelete+0x144>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1dbe:	f7040613          	addi	a2,s0,-144
    1dc2:	85ee                	mv	a1,s11
    1dc4:	00005517          	auipc	a0,0x5
    1dc8:	d0450513          	addi	a0,a0,-764 # 6ac8 <malloc+0xb92>
    1dcc:	00004097          	auipc	ra,0x4
    1dd0:	0ae080e7          	jalr	174(ra) # 5e7a <printf>
        exit(1);
    1dd4:	4505                	li	a0,1
    1dd6:	00004097          	auipc	ra,0x4
    1dda:	d3e080e7          	jalr	-706(ra) # 5b14 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1dde:	fa054ce3          	bltz	a0,1d96 <createdelete+0x14c>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1de2:	f7040613          	addi	a2,s0,-144
    1de6:	85ee                	mv	a1,s11
    1de8:	00005517          	auipc	a0,0x5
    1dec:	d0850513          	addi	a0,a0,-760 # 6af0 <malloc+0xbba>
    1df0:	00004097          	auipc	ra,0x4
    1df4:	08a080e7          	jalr	138(ra) # 5e7a <printf>
        exit(1);
    1df8:	4505                	li	a0,1
    1dfa:	00004097          	auipc	ra,0x4
    1dfe:	d1a080e7          	jalr	-742(ra) # 5b14 <exit>
        close(fd);
    1e02:	00004097          	auipc	ra,0x4
    1e06:	d3a080e7          	jalr	-710(ra) # 5b3c <close>
    1e0a:	b771                	j	1d96 <createdelete+0x14c>
  for(i = 0; i < N; i++){
    1e0c:	2a85                	addiw	s5,s5,1
    1e0e:	2a05                	addiw	s4,s4,1
    1e10:	2905                	addiw	s2,s2,1
    1e12:	0ff97913          	zext.b	s2,s2
    1e16:	47d1                	li	a5,20
    1e18:	00fa8a63          	beq	s5,a5,1e2c <createdelete+0x1e2>
      if((i == 0 || i >= N/2) && fd < 0){
    1e1c:	001ab993          	seqz	s3,s5
    1e20:	015d27b3          	slt	a5,s10,s5
    1e24:	00f9e9b3          	or	s3,s3,a5
    1e28:	84e6                	mv	s1,s9
    1e2a:	bf9d                	j	1da0 <createdelete+0x156>
    1e2c:	03000993          	li	s3,48
    1e30:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1e34:	4b11                	li	s6,4
      unlink(name);
    1e36:	f7040a13          	addi	s4,s0,-144
  for(i = 0; i < N; i++){
    1e3a:	08400a93          	li	s5,132
  name[0] = name[1] = name[2] = 0;
    1e3e:	84da                	mv	s1,s6
      name[0] = 'p' + i;
    1e40:	f7240823          	sb	s2,-144(s0)
      name[1] = '0' + i;
    1e44:	f73408a3          	sb	s3,-143(s0)
      unlink(name);
    1e48:	8552                	mv	a0,s4
    1e4a:	00004097          	auipc	ra,0x4
    1e4e:	d1a080e7          	jalr	-742(ra) # 5b64 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1e52:	34fd                	addiw	s1,s1,-1
    1e54:	f4f5                	bnez	s1,1e40 <createdelete+0x1f6>
  for(i = 0; i < N; i++){
    1e56:	2905                	addiw	s2,s2,1
    1e58:	0ff97913          	zext.b	s2,s2
    1e5c:	2985                	addiw	s3,s3,1
    1e5e:	0ff9f993          	zext.b	s3,s3
    1e62:	fd591ee3          	bne	s2,s5,1e3e <createdelete+0x1f4>
}
    1e66:	60ea                	ld	ra,152(sp)
    1e68:	644a                	ld	s0,144(sp)
    1e6a:	64aa                	ld	s1,136(sp)
    1e6c:	690a                	ld	s2,128(sp)
    1e6e:	79e6                	ld	s3,120(sp)
    1e70:	7a46                	ld	s4,112(sp)
    1e72:	7aa6                	ld	s5,104(sp)
    1e74:	7b06                	ld	s6,96(sp)
    1e76:	6be6                	ld	s7,88(sp)
    1e78:	6c46                	ld	s8,80(sp)
    1e7a:	6ca6                	ld	s9,72(sp)
    1e7c:	6d06                	ld	s10,64(sp)
    1e7e:	7de2                	ld	s11,56(sp)
    1e80:	610d                	addi	sp,sp,160
    1e82:	8082                	ret

0000000000001e84 <linkunlink>:
{
    1e84:	711d                	addi	sp,sp,-96
    1e86:	ec86                	sd	ra,88(sp)
    1e88:	e8a2                	sd	s0,80(sp)
    1e8a:	e4a6                	sd	s1,72(sp)
    1e8c:	e0ca                	sd	s2,64(sp)
    1e8e:	fc4e                	sd	s3,56(sp)
    1e90:	f852                	sd	s4,48(sp)
    1e92:	f456                	sd	s5,40(sp)
    1e94:	f05a                	sd	s6,32(sp)
    1e96:	ec5e                	sd	s7,24(sp)
    1e98:	e862                	sd	s8,16(sp)
    1e9a:	e466                	sd	s9,8(sp)
    1e9c:	e06a                	sd	s10,0(sp)
    1e9e:	1080                	addi	s0,sp,96
    1ea0:	84aa                	mv	s1,a0
  unlink("x");
    1ea2:	00004517          	auipc	a0,0x4
    1ea6:	23650513          	addi	a0,a0,566 # 60d8 <malloc+0x1a2>
    1eaa:	00004097          	auipc	ra,0x4
    1eae:	cba080e7          	jalr	-838(ra) # 5b64 <unlink>
  pid = fork();
    1eb2:	00004097          	auipc	ra,0x4
    1eb6:	c5a080e7          	jalr	-934(ra) # 5b0c <fork>
  if(pid < 0){
    1eba:	04054363          	bltz	a0,1f00 <linkunlink+0x7c>
    1ebe:	8d2a                	mv	s10,a0
  unsigned int x = (pid ? 1 : 97);
    1ec0:	06100913          	li	s2,97
    1ec4:	c111                	beqz	a0,1ec8 <linkunlink+0x44>
    1ec6:	4905                	li	s2,1
    1ec8:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1ecc:	41c65ab7          	lui	s5,0x41c65
    1ed0:	e6da8a9b          	addiw	s5,s5,-403 # 41c64e6d <__BSS_END__+0x41c54a0d>
    1ed4:	6a0d                	lui	s4,0x3
    1ed6:	039a0a1b          	addiw	s4,s4,57 # 3039 <fourteen+0xf5>
    if((x % 3) == 0){
    1eda:	000ab9b7          	lui	s3,0xab
    1ede:	aab98993          	addi	s3,s3,-1365 # aaaab <__BSS_END__+0x9a64b>
    1ee2:	09b2                	slli	s3,s3,0xc
    1ee4:	aab98993          	addi	s3,s3,-1365
    } else if((x % 3) == 1){
    1ee8:	4b85                	li	s7,1
      unlink("x");
    1eea:	00004b17          	auipc	s6,0x4
    1eee:	1eeb0b13          	addi	s6,s6,494 # 60d8 <malloc+0x1a2>
      link("cat", "x");
    1ef2:	00005c97          	auipc	s9,0x5
    1ef6:	c26c8c93          	addi	s9,s9,-986 # 6b18 <malloc+0xbe2>
      close(open("x", O_RDWR | O_CREATE));
    1efa:	20200c13          	li	s8,514
    1efe:	a089                	j	1f40 <linkunlink+0xbc>
    printf("%s: fork failed\n", s);
    1f00:	85a6                	mv	a1,s1
    1f02:	00005517          	auipc	a0,0x5
    1f06:	9be50513          	addi	a0,a0,-1602 # 68c0 <malloc+0x98a>
    1f0a:	00004097          	auipc	ra,0x4
    1f0e:	f70080e7          	jalr	-144(ra) # 5e7a <printf>
    exit(1);
    1f12:	4505                	li	a0,1
    1f14:	00004097          	auipc	ra,0x4
    1f18:	c00080e7          	jalr	-1024(ra) # 5b14 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1f1c:	85e2                	mv	a1,s8
    1f1e:	855a                	mv	a0,s6
    1f20:	00004097          	auipc	ra,0x4
    1f24:	c34080e7          	jalr	-972(ra) # 5b54 <open>
    1f28:	00004097          	auipc	ra,0x4
    1f2c:	c14080e7          	jalr	-1004(ra) # 5b3c <close>
    1f30:	a031                	j	1f3c <linkunlink+0xb8>
      unlink("x");
    1f32:	855a                	mv	a0,s6
    1f34:	00004097          	auipc	ra,0x4
    1f38:	c30080e7          	jalr	-976(ra) # 5b64 <unlink>
  for(i = 0; i < 100; i++){
    1f3c:	34fd                	addiw	s1,s1,-1
    1f3e:	c895                	beqz	s1,1f72 <linkunlink+0xee>
    x = x * 1103515245 + 12345;
    1f40:	035907bb          	mulw	a5,s2,s5
    1f44:	00fa07bb          	addw	a5,s4,a5
    1f48:	893e                	mv	s2,a5
    if((x % 3) == 0){
    1f4a:	02079713          	slli	a4,a5,0x20
    1f4e:	9301                	srli	a4,a4,0x20
    1f50:	03370733          	mul	a4,a4,s3
    1f54:	9305                	srli	a4,a4,0x21
    1f56:	0017169b          	slliw	a3,a4,0x1
    1f5a:	9f35                	addw	a4,a4,a3
    1f5c:	9f99                	subw	a5,a5,a4
    1f5e:	dfdd                	beqz	a5,1f1c <linkunlink+0x98>
    } else if((x % 3) == 1){
    1f60:	fd7799e3          	bne	a5,s7,1f32 <linkunlink+0xae>
      link("cat", "x");
    1f64:	85da                	mv	a1,s6
    1f66:	8566                	mv	a0,s9
    1f68:	00004097          	auipc	ra,0x4
    1f6c:	c0c080e7          	jalr	-1012(ra) # 5b74 <link>
    1f70:	b7f1                	j	1f3c <linkunlink+0xb8>
  if(pid)
    1f72:	020d0563          	beqz	s10,1f9c <linkunlink+0x118>
    wait(0);
    1f76:	4501                	li	a0,0
    1f78:	00004097          	auipc	ra,0x4
    1f7c:	ba4080e7          	jalr	-1116(ra) # 5b1c <wait>
}
    1f80:	60e6                	ld	ra,88(sp)
    1f82:	6446                	ld	s0,80(sp)
    1f84:	64a6                	ld	s1,72(sp)
    1f86:	6906                	ld	s2,64(sp)
    1f88:	79e2                	ld	s3,56(sp)
    1f8a:	7a42                	ld	s4,48(sp)
    1f8c:	7aa2                	ld	s5,40(sp)
    1f8e:	7b02                	ld	s6,32(sp)
    1f90:	6be2                	ld	s7,24(sp)
    1f92:	6c42                	ld	s8,16(sp)
    1f94:	6ca2                	ld	s9,8(sp)
    1f96:	6d02                	ld	s10,0(sp)
    1f98:	6125                	addi	sp,sp,96
    1f9a:	8082                	ret
    exit(0);
    1f9c:	4501                	li	a0,0
    1f9e:	00004097          	auipc	ra,0x4
    1fa2:	b76080e7          	jalr	-1162(ra) # 5b14 <exit>

0000000000001fa6 <manywrites>:
{
    1fa6:	7159                	addi	sp,sp,-112
    1fa8:	f486                	sd	ra,104(sp)
    1faa:	f0a2                	sd	s0,96(sp)
    1fac:	eca6                	sd	s1,88(sp)
    1fae:	e8ca                	sd	s2,80(sp)
    1fb0:	e4ce                	sd	s3,72(sp)
    1fb2:	ec66                	sd	s9,24(sp)
    1fb4:	1880                	addi	s0,sp,112
    1fb6:	8caa                	mv	s9,a0
  for(int ci = 0; ci < nchildren; ci++){
    1fb8:	4901                	li	s2,0
    1fba:	4991                	li	s3,4
    int pid = fork();
    1fbc:	00004097          	auipc	ra,0x4
    1fc0:	b50080e7          	jalr	-1200(ra) # 5b0c <fork>
    1fc4:	84aa                	mv	s1,a0
    if(pid < 0){
    1fc6:	04054063          	bltz	a0,2006 <manywrites+0x60>
    if(pid == 0){
    1fca:	c12d                	beqz	a0,202c <manywrites+0x86>
  for(int ci = 0; ci < nchildren; ci++){
    1fcc:	2905                	addiw	s2,s2,1
    1fce:	ff3917e3          	bne	s2,s3,1fbc <manywrites+0x16>
    1fd2:	4491                	li	s1,4
    wait(&st);
    1fd4:	f9840913          	addi	s2,s0,-104
    int st = 0;
    1fd8:	f8042c23          	sw	zero,-104(s0)
    wait(&st);
    1fdc:	854a                	mv	a0,s2
    1fde:	00004097          	auipc	ra,0x4
    1fe2:	b3e080e7          	jalr	-1218(ra) # 5b1c <wait>
    if(st != 0)
    1fe6:	f9842503          	lw	a0,-104(s0)
    1fea:	12051363          	bnez	a0,2110 <manywrites+0x16a>
  for(int ci = 0; ci < nchildren; ci++){
    1fee:	34fd                	addiw	s1,s1,-1
    1ff0:	f4e5                	bnez	s1,1fd8 <manywrites+0x32>
    1ff2:	e0d2                	sd	s4,64(sp)
    1ff4:	fc56                	sd	s5,56(sp)
    1ff6:	f85a                	sd	s6,48(sp)
    1ff8:	f45e                	sd	s7,40(sp)
    1ffa:	f062                	sd	s8,32(sp)
    1ffc:	e86a                	sd	s10,16(sp)
  exit(0);
    1ffe:	00004097          	auipc	ra,0x4
    2002:	b16080e7          	jalr	-1258(ra) # 5b14 <exit>
    2006:	e0d2                	sd	s4,64(sp)
    2008:	fc56                	sd	s5,56(sp)
    200a:	f85a                	sd	s6,48(sp)
    200c:	f45e                	sd	s7,40(sp)
    200e:	f062                	sd	s8,32(sp)
    2010:	e86a                	sd	s10,16(sp)
      printf("fork failed\n");
    2012:	00005517          	auipc	a0,0x5
    2016:	cce50513          	addi	a0,a0,-818 # 6ce0 <malloc+0xdaa>
    201a:	00004097          	auipc	ra,0x4
    201e:	e60080e7          	jalr	-416(ra) # 5e7a <printf>
      exit(1);
    2022:	4505                	li	a0,1
    2024:	00004097          	auipc	ra,0x4
    2028:	af0080e7          	jalr	-1296(ra) # 5b14 <exit>
    202c:	e0d2                	sd	s4,64(sp)
    202e:	fc56                	sd	s5,56(sp)
    2030:	f85a                	sd	s6,48(sp)
    2032:	f45e                	sd	s7,40(sp)
    2034:	f062                	sd	s8,32(sp)
    2036:	e86a                	sd	s10,16(sp)
      name[0] = 'b';
    2038:	06200793          	li	a5,98
    203c:	f8f40c23          	sb	a5,-104(s0)
      name[1] = 'a' + ci;
    2040:	0619079b          	addiw	a5,s2,97
    2044:	f8f40ca3          	sb	a5,-103(s0)
      name[2] = '\0';
    2048:	f8040d23          	sb	zero,-102(s0)
      unlink(name);
    204c:	f9840513          	addi	a0,s0,-104
    2050:	00004097          	auipc	ra,0x4
    2054:	b14080e7          	jalr	-1260(ra) # 5b64 <unlink>
    2058:	47f9                	li	a5,30
    205a:	8d3e                	mv	s10,a5
          int fd = open(name, O_CREATE | O_RDWR);
    205c:	f9840b93          	addi	s7,s0,-104
    2060:	20200b13          	li	s6,514
          int cc = write(fd, buf, sz);
    2064:	6a8d                	lui	s5,0x3
    2066:	0000bc17          	auipc	s8,0xb
    206a:	3eac0c13          	addi	s8,s8,1002 # d450 <buf>
        for(int i = 0; i < ci+1; i++){
    206e:	8a26                	mv	s4,s1
    2070:	02094b63          	bltz	s2,20a6 <manywrites+0x100>
          int fd = open(name, O_CREATE | O_RDWR);
    2074:	85da                	mv	a1,s6
    2076:	855e                	mv	a0,s7
    2078:	00004097          	auipc	ra,0x4
    207c:	adc080e7          	jalr	-1316(ra) # 5b54 <open>
    2080:	89aa                	mv	s3,a0
          if(fd < 0){
    2082:	04054763          	bltz	a0,20d0 <manywrites+0x12a>
          int cc = write(fd, buf, sz);
    2086:	8656                	mv	a2,s5
    2088:	85e2                	mv	a1,s8
    208a:	00004097          	auipc	ra,0x4
    208e:	aaa080e7          	jalr	-1366(ra) # 5b34 <write>
          if(cc != sz){
    2092:	05551f63          	bne	a0,s5,20f0 <manywrites+0x14a>
          close(fd);
    2096:	854e                	mv	a0,s3
    2098:	00004097          	auipc	ra,0x4
    209c:	aa4080e7          	jalr	-1372(ra) # 5b3c <close>
        for(int i = 0; i < ci+1; i++){
    20a0:	2a05                	addiw	s4,s4,1
    20a2:	fd4959e3          	bge	s2,s4,2074 <manywrites+0xce>
        unlink(name);
    20a6:	f9840513          	addi	a0,s0,-104
    20aa:	00004097          	auipc	ra,0x4
    20ae:	aba080e7          	jalr	-1350(ra) # 5b64 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    20b2:	fffd079b          	addiw	a5,s10,-1
    20b6:	8d3e                	mv	s10,a5
    20b8:	fbdd                	bnez	a5,206e <manywrites+0xc8>
      unlink(name);
    20ba:	f9840513          	addi	a0,s0,-104
    20be:	00004097          	auipc	ra,0x4
    20c2:	aa6080e7          	jalr	-1370(ra) # 5b64 <unlink>
      exit(0);
    20c6:	4501                	li	a0,0
    20c8:	00004097          	auipc	ra,0x4
    20cc:	a4c080e7          	jalr	-1460(ra) # 5b14 <exit>
            printf("%s: cannot create %s\n", s, name);
    20d0:	f9840613          	addi	a2,s0,-104
    20d4:	85e6                	mv	a1,s9
    20d6:	00005517          	auipc	a0,0x5
    20da:	a4a50513          	addi	a0,a0,-1462 # 6b20 <malloc+0xbea>
    20de:	00004097          	auipc	ra,0x4
    20e2:	d9c080e7          	jalr	-612(ra) # 5e7a <printf>
            exit(1);
    20e6:	4505                	li	a0,1
    20e8:	00004097          	auipc	ra,0x4
    20ec:	a2c080e7          	jalr	-1492(ra) # 5b14 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    20f0:	86aa                	mv	a3,a0
    20f2:	660d                	lui	a2,0x3
    20f4:	85e6                	mv	a1,s9
    20f6:	00004517          	auipc	a0,0x4
    20fa:	04250513          	addi	a0,a0,66 # 6138 <malloc+0x202>
    20fe:	00004097          	auipc	ra,0x4
    2102:	d7c080e7          	jalr	-644(ra) # 5e7a <printf>
            exit(1);
    2106:	4505                	li	a0,1
    2108:	00004097          	auipc	ra,0x4
    210c:	a0c080e7          	jalr	-1524(ra) # 5b14 <exit>
    2110:	e0d2                	sd	s4,64(sp)
    2112:	fc56                	sd	s5,56(sp)
    2114:	f85a                	sd	s6,48(sp)
    2116:	f45e                	sd	s7,40(sp)
    2118:	f062                	sd	s8,32(sp)
    211a:	e86a                	sd	s10,16(sp)
      exit(st);
    211c:	00004097          	auipc	ra,0x4
    2120:	9f8080e7          	jalr	-1544(ra) # 5b14 <exit>

0000000000002124 <forktest>:
{
    2124:	7179                	addi	sp,sp,-48
    2126:	f406                	sd	ra,40(sp)
    2128:	f022                	sd	s0,32(sp)
    212a:	ec26                	sd	s1,24(sp)
    212c:	e84a                	sd	s2,16(sp)
    212e:	e44e                	sd	s3,8(sp)
    2130:	1800                	addi	s0,sp,48
    2132:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    2134:	4481                	li	s1,0
    2136:	3e800913          	li	s2,1000
    pid = fork();
    213a:	00004097          	auipc	ra,0x4
    213e:	9d2080e7          	jalr	-1582(ra) # 5b0c <fork>
    if(pid < 0)
    2142:	08054263          	bltz	a0,21c6 <forktest+0xa2>
    if(pid == 0)
    2146:	c115                	beqz	a0,216a <forktest+0x46>
  for(n=0; n<N; n++){
    2148:	2485                	addiw	s1,s1,1
    214a:	ff2498e3          	bne	s1,s2,213a <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    214e:	85ce                	mv	a1,s3
    2150:	00005517          	auipc	a0,0x5
    2154:	a3050513          	addi	a0,a0,-1488 # 6b80 <malloc+0xc4a>
    2158:	00004097          	auipc	ra,0x4
    215c:	d22080e7          	jalr	-734(ra) # 5e7a <printf>
    exit(1);
    2160:	4505                	li	a0,1
    2162:	00004097          	auipc	ra,0x4
    2166:	9b2080e7          	jalr	-1614(ra) # 5b14 <exit>
      exit(0);
    216a:	00004097          	auipc	ra,0x4
    216e:	9aa080e7          	jalr	-1622(ra) # 5b14 <exit>
    printf("%s: no fork at all!\n", s);
    2172:	85ce                	mv	a1,s3
    2174:	00005517          	auipc	a0,0x5
    2178:	9c450513          	addi	a0,a0,-1596 # 6b38 <malloc+0xc02>
    217c:	00004097          	auipc	ra,0x4
    2180:	cfe080e7          	jalr	-770(ra) # 5e7a <printf>
    exit(1);
    2184:	4505                	li	a0,1
    2186:	00004097          	auipc	ra,0x4
    218a:	98e080e7          	jalr	-1650(ra) # 5b14 <exit>
      printf("%s: wait stopped early\n", s);
    218e:	85ce                	mv	a1,s3
    2190:	00005517          	auipc	a0,0x5
    2194:	9c050513          	addi	a0,a0,-1600 # 6b50 <malloc+0xc1a>
    2198:	00004097          	auipc	ra,0x4
    219c:	ce2080e7          	jalr	-798(ra) # 5e7a <printf>
      exit(1);
    21a0:	4505                	li	a0,1
    21a2:	00004097          	auipc	ra,0x4
    21a6:	972080e7          	jalr	-1678(ra) # 5b14 <exit>
    printf("%s: wait got too many\n", s);
    21aa:	85ce                	mv	a1,s3
    21ac:	00005517          	auipc	a0,0x5
    21b0:	9bc50513          	addi	a0,a0,-1604 # 6b68 <malloc+0xc32>
    21b4:	00004097          	auipc	ra,0x4
    21b8:	cc6080e7          	jalr	-826(ra) # 5e7a <printf>
    exit(1);
    21bc:	4505                	li	a0,1
    21be:	00004097          	auipc	ra,0x4
    21c2:	956080e7          	jalr	-1706(ra) # 5b14 <exit>
  if (n == 0) {
    21c6:	d4d5                	beqz	s1,2172 <forktest+0x4e>
  for(; n > 0; n--){
    21c8:	00905b63          	blez	s1,21de <forktest+0xba>
    if(wait(0) < 0){
    21cc:	4501                	li	a0,0
    21ce:	00004097          	auipc	ra,0x4
    21d2:	94e080e7          	jalr	-1714(ra) # 5b1c <wait>
    21d6:	fa054ce3          	bltz	a0,218e <forktest+0x6a>
  for(; n > 0; n--){
    21da:	34fd                	addiw	s1,s1,-1
    21dc:	f8e5                	bnez	s1,21cc <forktest+0xa8>
  if(wait(0) != -1){
    21de:	4501                	li	a0,0
    21e0:	00004097          	auipc	ra,0x4
    21e4:	93c080e7          	jalr	-1732(ra) # 5b1c <wait>
    21e8:	57fd                	li	a5,-1
    21ea:	fcf510e3          	bne	a0,a5,21aa <forktest+0x86>
}
    21ee:	70a2                	ld	ra,40(sp)
    21f0:	7402                	ld	s0,32(sp)
    21f2:	64e2                	ld	s1,24(sp)
    21f4:	6942                	ld	s2,16(sp)
    21f6:	69a2                	ld	s3,8(sp)
    21f8:	6145                	addi	sp,sp,48
    21fa:	8082                	ret

00000000000021fc <kernmem>:
{
    21fc:	715d                	addi	sp,sp,-80
    21fe:	e486                	sd	ra,72(sp)
    2200:	e0a2                	sd	s0,64(sp)
    2202:	fc26                	sd	s1,56(sp)
    2204:	f84a                	sd	s2,48(sp)
    2206:	f44e                	sd	s3,40(sp)
    2208:	f052                	sd	s4,32(sp)
    220a:	ec56                	sd	s5,24(sp)
    220c:	e85a                	sd	s6,16(sp)
    220e:	0880                	addi	s0,sp,80
    2210:	8b2a                	mv	s6,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2212:	4485                	li	s1,1
    2214:	04fe                	slli	s1,s1,0x1f
    wait(&xstatus);
    2216:	fbc40a93          	addi	s5,s0,-68
    if(xstatus != -1)  // did kernel kill child?
    221a:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    221c:	69b1                	lui	s3,0xc
    221e:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1610>
    2222:	1003d937          	lui	s2,0x1003d
    2226:	090e                	slli	s2,s2,0x3
    2228:	48090913          	addi	s2,s2,1152 # 1003d480 <__BSS_END__+0x1002d020>
    pid = fork();
    222c:	00004097          	auipc	ra,0x4
    2230:	8e0080e7          	jalr	-1824(ra) # 5b0c <fork>
    if(pid < 0){
    2234:	02054963          	bltz	a0,2266 <kernmem+0x6a>
    if(pid == 0){
    2238:	c529                	beqz	a0,2282 <kernmem+0x86>
    wait(&xstatus);
    223a:	8556                	mv	a0,s5
    223c:	00004097          	auipc	ra,0x4
    2240:	8e0080e7          	jalr	-1824(ra) # 5b1c <wait>
    if(xstatus != -1)  // did kernel kill child?
    2244:	fbc42783          	lw	a5,-68(s0)
    2248:	05479e63          	bne	a5,s4,22a4 <kernmem+0xa8>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    224c:	94ce                	add	s1,s1,s3
    224e:	fd249fe3          	bne	s1,s2,222c <kernmem+0x30>
}
    2252:	60a6                	ld	ra,72(sp)
    2254:	6406                	ld	s0,64(sp)
    2256:	74e2                	ld	s1,56(sp)
    2258:	7942                	ld	s2,48(sp)
    225a:	79a2                	ld	s3,40(sp)
    225c:	7a02                	ld	s4,32(sp)
    225e:	6ae2                	ld	s5,24(sp)
    2260:	6b42                	ld	s6,16(sp)
    2262:	6161                	addi	sp,sp,80
    2264:	8082                	ret
      printf("%s: fork failed\n", s);
    2266:	85da                	mv	a1,s6
    2268:	00004517          	auipc	a0,0x4
    226c:	65850513          	addi	a0,a0,1624 # 68c0 <malloc+0x98a>
    2270:	00004097          	auipc	ra,0x4
    2274:	c0a080e7          	jalr	-1014(ra) # 5e7a <printf>
      exit(1);
    2278:	4505                	li	a0,1
    227a:	00004097          	auipc	ra,0x4
    227e:	89a080e7          	jalr	-1894(ra) # 5b14 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    2282:	0004c683          	lbu	a3,0(s1)
    2286:	8626                	mv	a2,s1
    2288:	85da                	mv	a1,s6
    228a:	00005517          	auipc	a0,0x5
    228e:	91e50513          	addi	a0,a0,-1762 # 6ba8 <malloc+0xc72>
    2292:	00004097          	auipc	ra,0x4
    2296:	be8080e7          	jalr	-1048(ra) # 5e7a <printf>
      exit(1);
    229a:	4505                	li	a0,1
    229c:	00004097          	auipc	ra,0x4
    22a0:	878080e7          	jalr	-1928(ra) # 5b14 <exit>
      exit(1);
    22a4:	4505                	li	a0,1
    22a6:	00004097          	auipc	ra,0x4
    22aa:	86e080e7          	jalr	-1938(ra) # 5b14 <exit>

00000000000022ae <MAXVAplus>:
{
    22ae:	7139                	addi	sp,sp,-64
    22b0:	fc06                	sd	ra,56(sp)
    22b2:	f822                	sd	s0,48(sp)
    22b4:	0080                	addi	s0,sp,64
  volatile uint64 a = MAXVA;
    22b6:	4785                	li	a5,1
    22b8:	179a                	slli	a5,a5,0x26
    22ba:	fcf43423          	sd	a5,-56(s0)
  for( ; a != 0; a <<= 1){
    22be:	fc843783          	ld	a5,-56(s0)
    22c2:	c3b9                	beqz	a5,2308 <MAXVAplus+0x5a>
    22c4:	f426                	sd	s1,40(sp)
    22c6:	f04a                	sd	s2,32(sp)
    22c8:	ec4e                	sd	s3,24(sp)
    22ca:	89aa                	mv	s3,a0
    wait(&xstatus);
    22cc:	fc440913          	addi	s2,s0,-60
    if(xstatus != -1)  // did kernel kill child?
    22d0:	54fd                	li	s1,-1
    pid = fork();
    22d2:	00004097          	auipc	ra,0x4
    22d6:	83a080e7          	jalr	-1990(ra) # 5b0c <fork>
    if(pid < 0){
    22da:	02054b63          	bltz	a0,2310 <MAXVAplus+0x62>
    if(pid == 0){
    22de:	c539                	beqz	a0,232c <MAXVAplus+0x7e>
    wait(&xstatus);
    22e0:	854a                	mv	a0,s2
    22e2:	00004097          	auipc	ra,0x4
    22e6:	83a080e7          	jalr	-1990(ra) # 5b1c <wait>
    if(xstatus != -1)  // did kernel kill child?
    22ea:	fc442783          	lw	a5,-60(s0)
    22ee:	06979563          	bne	a5,s1,2358 <MAXVAplus+0xaa>
  for( ; a != 0; a <<= 1){
    22f2:	fc843783          	ld	a5,-56(s0)
    22f6:	0786                	slli	a5,a5,0x1
    22f8:	fcf43423          	sd	a5,-56(s0)
    22fc:	fc843783          	ld	a5,-56(s0)
    2300:	fbe9                	bnez	a5,22d2 <MAXVAplus+0x24>
    2302:	74a2                	ld	s1,40(sp)
    2304:	7902                	ld	s2,32(sp)
    2306:	69e2                	ld	s3,24(sp)
}
    2308:	70e2                	ld	ra,56(sp)
    230a:	7442                	ld	s0,48(sp)
    230c:	6121                	addi	sp,sp,64
    230e:	8082                	ret
      printf("%s: fork failed\n", s);
    2310:	85ce                	mv	a1,s3
    2312:	00004517          	auipc	a0,0x4
    2316:	5ae50513          	addi	a0,a0,1454 # 68c0 <malloc+0x98a>
    231a:	00004097          	auipc	ra,0x4
    231e:	b60080e7          	jalr	-1184(ra) # 5e7a <printf>
      exit(1);
    2322:	4505                	li	a0,1
    2324:	00003097          	auipc	ra,0x3
    2328:	7f0080e7          	jalr	2032(ra) # 5b14 <exit>
      *(char*)a = 99;
    232c:	fc843783          	ld	a5,-56(s0)
    2330:	06300713          	li	a4,99
    2334:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    2338:	fc843603          	ld	a2,-56(s0)
    233c:	85ce                	mv	a1,s3
    233e:	00005517          	auipc	a0,0x5
    2342:	88a50513          	addi	a0,a0,-1910 # 6bc8 <malloc+0xc92>
    2346:	00004097          	auipc	ra,0x4
    234a:	b34080e7          	jalr	-1228(ra) # 5e7a <printf>
      exit(1);
    234e:	4505                	li	a0,1
    2350:	00003097          	auipc	ra,0x3
    2354:	7c4080e7          	jalr	1988(ra) # 5b14 <exit>
      exit(1);
    2358:	4505                	li	a0,1
    235a:	00003097          	auipc	ra,0x3
    235e:	7ba080e7          	jalr	1978(ra) # 5b14 <exit>

0000000000002362 <bigargtest>:
{
    2362:	7179                	addi	sp,sp,-48
    2364:	f406                	sd	ra,40(sp)
    2366:	f022                	sd	s0,32(sp)
    2368:	ec26                	sd	s1,24(sp)
    236a:	1800                	addi	s0,sp,48
    236c:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    236e:	00005517          	auipc	a0,0x5
    2372:	87250513          	addi	a0,a0,-1934 # 6be0 <malloc+0xcaa>
    2376:	00003097          	auipc	ra,0x3
    237a:	7ee080e7          	jalr	2030(ra) # 5b64 <unlink>
  pid = fork();
    237e:	00003097          	auipc	ra,0x3
    2382:	78e080e7          	jalr	1934(ra) # 5b0c <fork>
  if(pid == 0){
    2386:	c121                	beqz	a0,23c6 <bigargtest+0x64>
  } else if(pid < 0){
    2388:	0a054263          	bltz	a0,242c <bigargtest+0xca>
  wait(&xstatus);
    238c:	fdc40513          	addi	a0,s0,-36
    2390:	00003097          	auipc	ra,0x3
    2394:	78c080e7          	jalr	1932(ra) # 5b1c <wait>
  if(xstatus != 0)
    2398:	fdc42503          	lw	a0,-36(s0)
    239c:	e555                	bnez	a0,2448 <bigargtest+0xe6>
  fd = open("bigarg-ok", 0);
    239e:	4581                	li	a1,0
    23a0:	00005517          	auipc	a0,0x5
    23a4:	84050513          	addi	a0,a0,-1984 # 6be0 <malloc+0xcaa>
    23a8:	00003097          	auipc	ra,0x3
    23ac:	7ac080e7          	jalr	1964(ra) # 5b54 <open>
  if(fd < 0){
    23b0:	0a054063          	bltz	a0,2450 <bigargtest+0xee>
  close(fd);
    23b4:	00003097          	auipc	ra,0x3
    23b8:	788080e7          	jalr	1928(ra) # 5b3c <close>
}
    23bc:	70a2                	ld	ra,40(sp)
    23be:	7402                	ld	s0,32(sp)
    23c0:	64e2                	ld	s1,24(sp)
    23c2:	6145                	addi	sp,sp,48
    23c4:	8082                	ret
    23c6:	00008797          	auipc	a5,0x8
    23ca:	87278793          	addi	a5,a5,-1934 # 9c38 <args.1>
    23ce:	00008697          	auipc	a3,0x8
    23d2:	96268693          	addi	a3,a3,-1694 # 9d30 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    23d6:	00005717          	auipc	a4,0x5
    23da:	81a70713          	addi	a4,a4,-2022 # 6bf0 <malloc+0xcba>
    23de:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    23e0:	07a1                	addi	a5,a5,8
    23e2:	fed79ee3          	bne	a5,a3,23de <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    23e6:	00008797          	auipc	a5,0x8
    23ea:	9407b523          	sd	zero,-1718(a5) # 9d30 <args.1+0xf8>
    exec("echo", args);
    23ee:	00008597          	auipc	a1,0x8
    23f2:	84a58593          	addi	a1,a1,-1974 # 9c38 <args.1>
    23f6:	00004517          	auipc	a0,0x4
    23fa:	c7250513          	addi	a0,a0,-910 # 6068 <malloc+0x132>
    23fe:	00003097          	auipc	ra,0x3
    2402:	74e080e7          	jalr	1870(ra) # 5b4c <exec>
    fd = open("bigarg-ok", O_CREATE);
    2406:	20000593          	li	a1,512
    240a:	00004517          	auipc	a0,0x4
    240e:	7d650513          	addi	a0,a0,2006 # 6be0 <malloc+0xcaa>
    2412:	00003097          	auipc	ra,0x3
    2416:	742080e7          	jalr	1858(ra) # 5b54 <open>
    close(fd);
    241a:	00003097          	auipc	ra,0x3
    241e:	722080e7          	jalr	1826(ra) # 5b3c <close>
    exit(0);
    2422:	4501                	li	a0,0
    2424:	00003097          	auipc	ra,0x3
    2428:	6f0080e7          	jalr	1776(ra) # 5b14 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    242c:	85a6                	mv	a1,s1
    242e:	00005517          	auipc	a0,0x5
    2432:	8a250513          	addi	a0,a0,-1886 # 6cd0 <malloc+0xd9a>
    2436:	00004097          	auipc	ra,0x4
    243a:	a44080e7          	jalr	-1468(ra) # 5e7a <printf>
    exit(1);
    243e:	4505                	li	a0,1
    2440:	00003097          	auipc	ra,0x3
    2444:	6d4080e7          	jalr	1748(ra) # 5b14 <exit>
    exit(xstatus);
    2448:	00003097          	auipc	ra,0x3
    244c:	6cc080e7          	jalr	1740(ra) # 5b14 <exit>
    printf("%s: bigarg test failed!\n", s);
    2450:	85a6                	mv	a1,s1
    2452:	00005517          	auipc	a0,0x5
    2456:	89e50513          	addi	a0,a0,-1890 # 6cf0 <malloc+0xdba>
    245a:	00004097          	auipc	ra,0x4
    245e:	a20080e7          	jalr	-1504(ra) # 5e7a <printf>
    exit(1);
    2462:	4505                	li	a0,1
    2464:	00003097          	auipc	ra,0x3
    2468:	6b0080e7          	jalr	1712(ra) # 5b14 <exit>

000000000000246c <stacktest>:
{
    246c:	7179                	addi	sp,sp,-48
    246e:	f406                	sd	ra,40(sp)
    2470:	f022                	sd	s0,32(sp)
    2472:	ec26                	sd	s1,24(sp)
    2474:	1800                	addi	s0,sp,48
    2476:	84aa                	mv	s1,a0
  pid = fork();
    2478:	00003097          	auipc	ra,0x3
    247c:	694080e7          	jalr	1684(ra) # 5b0c <fork>
  if(pid == 0) {
    2480:	c115                	beqz	a0,24a4 <stacktest+0x38>
  } else if(pid < 0){
    2482:	04054463          	bltz	a0,24ca <stacktest+0x5e>
  wait(&xstatus);
    2486:	fdc40513          	addi	a0,s0,-36
    248a:	00003097          	auipc	ra,0x3
    248e:	692080e7          	jalr	1682(ra) # 5b1c <wait>
  if(xstatus == -1)  // kernel killed child?
    2492:	fdc42503          	lw	a0,-36(s0)
    2496:	57fd                	li	a5,-1
    2498:	04f50763          	beq	a0,a5,24e6 <stacktest+0x7a>
    exit(xstatus);
    249c:	00003097          	auipc	ra,0x3
    24a0:	678080e7          	jalr	1656(ra) # 5b14 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    24a4:	878a                	mv	a5,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    24a6:	80078793          	addi	a5,a5,-2048
    24aa:	8007c603          	lbu	a2,-2048(a5)
    24ae:	85a6                	mv	a1,s1
    24b0:	00005517          	auipc	a0,0x5
    24b4:	86050513          	addi	a0,a0,-1952 # 6d10 <malloc+0xdda>
    24b8:	00004097          	auipc	ra,0x4
    24bc:	9c2080e7          	jalr	-1598(ra) # 5e7a <printf>
    exit(1);
    24c0:	4505                	li	a0,1
    24c2:	00003097          	auipc	ra,0x3
    24c6:	652080e7          	jalr	1618(ra) # 5b14 <exit>
    printf("%s: fork failed\n", s);
    24ca:	85a6                	mv	a1,s1
    24cc:	00004517          	auipc	a0,0x4
    24d0:	3f450513          	addi	a0,a0,1012 # 68c0 <malloc+0x98a>
    24d4:	00004097          	auipc	ra,0x4
    24d8:	9a6080e7          	jalr	-1626(ra) # 5e7a <printf>
    exit(1);
    24dc:	4505                	li	a0,1
    24de:	00003097          	auipc	ra,0x3
    24e2:	636080e7          	jalr	1590(ra) # 5b14 <exit>
    exit(0);
    24e6:	4501                	li	a0,0
    24e8:	00003097          	auipc	ra,0x3
    24ec:	62c080e7          	jalr	1580(ra) # 5b14 <exit>

00000000000024f0 <copyinstr3>:
{
    24f0:	7179                	addi	sp,sp,-48
    24f2:	f406                	sd	ra,40(sp)
    24f4:	f022                	sd	s0,32(sp)
    24f6:	ec26                	sd	s1,24(sp)
    24f8:	1800                	addi	s0,sp,48
  sbrk(8192);
    24fa:	6509                	lui	a0,0x2
    24fc:	00003097          	auipc	ra,0x3
    2500:	6a0080e7          	jalr	1696(ra) # 5b9c <sbrk>
  uint64 top = (uint64) sbrk(0);
    2504:	4501                	li	a0,0
    2506:	00003097          	auipc	ra,0x3
    250a:	696080e7          	jalr	1686(ra) # 5b9c <sbrk>
  if((top % PGSIZE) != 0){
    250e:	03451793          	slli	a5,a0,0x34
    2512:	e3c9                	bnez	a5,2594 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    2514:	4501                	li	a0,0
    2516:	00003097          	auipc	ra,0x3
    251a:	686080e7          	jalr	1670(ra) # 5b9c <sbrk>
  if(top % PGSIZE){
    251e:	03451793          	slli	a5,a0,0x34
    2522:	e3d9                	bnez	a5,25a8 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    2524:	fff50493          	addi	s1,a0,-1 # 1fff <manywrites+0x59>
  *b = 'x';
    2528:	07800793          	li	a5,120
    252c:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    2530:	8526                	mv	a0,s1
    2532:	00003097          	auipc	ra,0x3
    2536:	632080e7          	jalr	1586(ra) # 5b64 <unlink>
  if(ret != -1){
    253a:	57fd                	li	a5,-1
    253c:	08f51363          	bne	a0,a5,25c2 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    2540:	20100593          	li	a1,513
    2544:	8526                	mv	a0,s1
    2546:	00003097          	auipc	ra,0x3
    254a:	60e080e7          	jalr	1550(ra) # 5b54 <open>
  if(fd != -1){
    254e:	57fd                	li	a5,-1
    2550:	08f51863          	bne	a0,a5,25e0 <copyinstr3+0xf0>
  ret = link(b, b);
    2554:	85a6                	mv	a1,s1
    2556:	8526                	mv	a0,s1
    2558:	00003097          	auipc	ra,0x3
    255c:	61c080e7          	jalr	1564(ra) # 5b74 <link>
  if(ret != -1){
    2560:	57fd                	li	a5,-1
    2562:	08f51e63          	bne	a0,a5,25fe <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2566:	00005797          	auipc	a5,0x5
    256a:	45278793          	addi	a5,a5,1106 # 79b8 <malloc+0x1a82>
    256e:	fcf43823          	sd	a5,-48(s0)
    2572:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2576:	fd040593          	addi	a1,s0,-48
    257a:	8526                	mv	a0,s1
    257c:	00003097          	auipc	ra,0x3
    2580:	5d0080e7          	jalr	1488(ra) # 5b4c <exec>
  if(ret != -1){
    2584:	57fd                	li	a5,-1
    2586:	08f51c63          	bne	a0,a5,261e <copyinstr3+0x12e>
}
    258a:	70a2                	ld	ra,40(sp)
    258c:	7402                	ld	s0,32(sp)
    258e:	64e2                	ld	s1,24(sp)
    2590:	6145                	addi	sp,sp,48
    2592:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2594:	0347d513          	srli	a0,a5,0x34
    2598:	6785                	lui	a5,0x1
    259a:	40a7853b          	subw	a0,a5,a0
    259e:	00003097          	auipc	ra,0x3
    25a2:	5fe080e7          	jalr	1534(ra) # 5b9c <sbrk>
    25a6:	b7bd                	j	2514 <copyinstr3+0x24>
    printf("oops\n");
    25a8:	00004517          	auipc	a0,0x4
    25ac:	79050513          	addi	a0,a0,1936 # 6d38 <malloc+0xe02>
    25b0:	00004097          	auipc	ra,0x4
    25b4:	8ca080e7          	jalr	-1846(ra) # 5e7a <printf>
    exit(1);
    25b8:	4505                	li	a0,1
    25ba:	00003097          	auipc	ra,0x3
    25be:	55a080e7          	jalr	1370(ra) # 5b14 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    25c2:	862a                	mv	a2,a0
    25c4:	85a6                	mv	a1,s1
    25c6:	00004517          	auipc	a0,0x4
    25ca:	21a50513          	addi	a0,a0,538 # 67e0 <malloc+0x8aa>
    25ce:	00004097          	auipc	ra,0x4
    25d2:	8ac080e7          	jalr	-1876(ra) # 5e7a <printf>
    exit(1);
    25d6:	4505                	li	a0,1
    25d8:	00003097          	auipc	ra,0x3
    25dc:	53c080e7          	jalr	1340(ra) # 5b14 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    25e0:	862a                	mv	a2,a0
    25e2:	85a6                	mv	a1,s1
    25e4:	00004517          	auipc	a0,0x4
    25e8:	21c50513          	addi	a0,a0,540 # 6800 <malloc+0x8ca>
    25ec:	00004097          	auipc	ra,0x4
    25f0:	88e080e7          	jalr	-1906(ra) # 5e7a <printf>
    exit(1);
    25f4:	4505                	li	a0,1
    25f6:	00003097          	auipc	ra,0x3
    25fa:	51e080e7          	jalr	1310(ra) # 5b14 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    25fe:	86aa                	mv	a3,a0
    2600:	8626                	mv	a2,s1
    2602:	85a6                	mv	a1,s1
    2604:	00004517          	auipc	a0,0x4
    2608:	21c50513          	addi	a0,a0,540 # 6820 <malloc+0x8ea>
    260c:	00004097          	auipc	ra,0x4
    2610:	86e080e7          	jalr	-1938(ra) # 5e7a <printf>
    exit(1);
    2614:	4505                	li	a0,1
    2616:	00003097          	auipc	ra,0x3
    261a:	4fe080e7          	jalr	1278(ra) # 5b14 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    261e:	863e                	mv	a2,a5
    2620:	85a6                	mv	a1,s1
    2622:	00004517          	auipc	a0,0x4
    2626:	22650513          	addi	a0,a0,550 # 6848 <malloc+0x912>
    262a:	00004097          	auipc	ra,0x4
    262e:	850080e7          	jalr	-1968(ra) # 5e7a <printf>
    exit(1);
    2632:	4505                	li	a0,1
    2634:	00003097          	auipc	ra,0x3
    2638:	4e0080e7          	jalr	1248(ra) # 5b14 <exit>

000000000000263c <rwsbrk>:
{
    263c:	1101                	addi	sp,sp,-32
    263e:	ec06                	sd	ra,24(sp)
    2640:	e822                	sd	s0,16(sp)
    2642:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2644:	6509                	lui	a0,0x2
    2646:	00003097          	auipc	ra,0x3
    264a:	556080e7          	jalr	1366(ra) # 5b9c <sbrk>
  if(a == 0xffffffffffffffffLL) {
    264e:	57fd                	li	a5,-1
    2650:	06f50463          	beq	a0,a5,26b8 <rwsbrk+0x7c>
    2654:	e426                	sd	s1,8(sp)
    2656:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    2658:	7579                	lui	a0,0xffffe
    265a:	00003097          	auipc	ra,0x3
    265e:	542080e7          	jalr	1346(ra) # 5b9c <sbrk>
    2662:	57fd                	li	a5,-1
    2664:	06f50963          	beq	a0,a5,26d6 <rwsbrk+0x9a>
    2668:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    266a:	20100593          	li	a1,513
    266e:	00004517          	auipc	a0,0x4
    2672:	70a50513          	addi	a0,a0,1802 # 6d78 <malloc+0xe42>
    2676:	00003097          	auipc	ra,0x3
    267a:	4de080e7          	jalr	1246(ra) # 5b54 <open>
    267e:	892a                	mv	s2,a0
  if(fd < 0){
    2680:	06054963          	bltz	a0,26f2 <rwsbrk+0xb6>
  n = write(fd, (void*)(a+4096), 1024);
    2684:	6785                	lui	a5,0x1
    2686:	94be                	add	s1,s1,a5
    2688:	40000613          	li	a2,1024
    268c:	85a6                	mv	a1,s1
    268e:	00003097          	auipc	ra,0x3
    2692:	4a6080e7          	jalr	1190(ra) # 5b34 <write>
    2696:	862a                	mv	a2,a0
  if(n >= 0){
    2698:	06054a63          	bltz	a0,270c <rwsbrk+0xd0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    269c:	85a6                	mv	a1,s1
    269e:	00004517          	auipc	a0,0x4
    26a2:	6fa50513          	addi	a0,a0,1786 # 6d98 <malloc+0xe62>
    26a6:	00003097          	auipc	ra,0x3
    26aa:	7d4080e7          	jalr	2004(ra) # 5e7a <printf>
    exit(1);
    26ae:	4505                	li	a0,1
    26b0:	00003097          	auipc	ra,0x3
    26b4:	464080e7          	jalr	1124(ra) # 5b14 <exit>
    26b8:	e426                	sd	s1,8(sp)
    26ba:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    26bc:	00004517          	auipc	a0,0x4
    26c0:	68450513          	addi	a0,a0,1668 # 6d40 <malloc+0xe0a>
    26c4:	00003097          	auipc	ra,0x3
    26c8:	7b6080e7          	jalr	1974(ra) # 5e7a <printf>
    exit(1);
    26cc:	4505                	li	a0,1
    26ce:	00003097          	auipc	ra,0x3
    26d2:	446080e7          	jalr	1094(ra) # 5b14 <exit>
    26d6:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    26d8:	00004517          	auipc	a0,0x4
    26dc:	68050513          	addi	a0,a0,1664 # 6d58 <malloc+0xe22>
    26e0:	00003097          	auipc	ra,0x3
    26e4:	79a080e7          	jalr	1946(ra) # 5e7a <printf>
    exit(1);
    26e8:	4505                	li	a0,1
    26ea:	00003097          	auipc	ra,0x3
    26ee:	42a080e7          	jalr	1066(ra) # 5b14 <exit>
    printf("open(rwsbrk) failed\n");
    26f2:	00004517          	auipc	a0,0x4
    26f6:	68e50513          	addi	a0,a0,1678 # 6d80 <malloc+0xe4a>
    26fa:	00003097          	auipc	ra,0x3
    26fe:	780080e7          	jalr	1920(ra) # 5e7a <printf>
    exit(1);
    2702:	4505                	li	a0,1
    2704:	00003097          	auipc	ra,0x3
    2708:	410080e7          	jalr	1040(ra) # 5b14 <exit>
  close(fd);
    270c:	854a                	mv	a0,s2
    270e:	00003097          	auipc	ra,0x3
    2712:	42e080e7          	jalr	1070(ra) # 5b3c <close>
  unlink("rwsbrk");
    2716:	00004517          	auipc	a0,0x4
    271a:	66250513          	addi	a0,a0,1634 # 6d78 <malloc+0xe42>
    271e:	00003097          	auipc	ra,0x3
    2722:	446080e7          	jalr	1094(ra) # 5b64 <unlink>
  fd = open("README", O_RDONLY);
    2726:	4581                	li	a1,0
    2728:	00004517          	auipc	a0,0x4
    272c:	ae850513          	addi	a0,a0,-1304 # 6210 <malloc+0x2da>
    2730:	00003097          	auipc	ra,0x3
    2734:	424080e7          	jalr	1060(ra) # 5b54 <open>
    2738:	892a                	mv	s2,a0
  if(fd < 0){
    273a:	02054963          	bltz	a0,276c <rwsbrk+0x130>
  n = read(fd, (void*)(a+4096), 10);
    273e:	4629                	li	a2,10
    2740:	85a6                	mv	a1,s1
    2742:	00003097          	auipc	ra,0x3
    2746:	3ea080e7          	jalr	1002(ra) # 5b2c <read>
    274a:	862a                	mv	a2,a0
  if(n >= 0){
    274c:	02054d63          	bltz	a0,2786 <rwsbrk+0x14a>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    2750:	85a6                	mv	a1,s1
    2752:	00004517          	auipc	a0,0x4
    2756:	67650513          	addi	a0,a0,1654 # 6dc8 <malloc+0xe92>
    275a:	00003097          	auipc	ra,0x3
    275e:	720080e7          	jalr	1824(ra) # 5e7a <printf>
    exit(1);
    2762:	4505                	li	a0,1
    2764:	00003097          	auipc	ra,0x3
    2768:	3b0080e7          	jalr	944(ra) # 5b14 <exit>
    printf("open(rwsbrk) failed\n");
    276c:	00004517          	auipc	a0,0x4
    2770:	61450513          	addi	a0,a0,1556 # 6d80 <malloc+0xe4a>
    2774:	00003097          	auipc	ra,0x3
    2778:	706080e7          	jalr	1798(ra) # 5e7a <printf>
    exit(1);
    277c:	4505                	li	a0,1
    277e:	00003097          	auipc	ra,0x3
    2782:	396080e7          	jalr	918(ra) # 5b14 <exit>
  close(fd);
    2786:	854a                	mv	a0,s2
    2788:	00003097          	auipc	ra,0x3
    278c:	3b4080e7          	jalr	948(ra) # 5b3c <close>
  exit(0);
    2790:	4501                	li	a0,0
    2792:	00003097          	auipc	ra,0x3
    2796:	382080e7          	jalr	898(ra) # 5b14 <exit>

000000000000279a <sbrkbasic>:
{
    279a:	715d                	addi	sp,sp,-80
    279c:	e486                	sd	ra,72(sp)
    279e:	e0a2                	sd	s0,64(sp)
    27a0:	ec56                	sd	s5,24(sp)
    27a2:	0880                	addi	s0,sp,80
    27a4:	8aaa                	mv	s5,a0
  pid = fork();
    27a6:	00003097          	auipc	ra,0x3
    27aa:	366080e7          	jalr	870(ra) # 5b0c <fork>
  if(pid < 0){
    27ae:	04054063          	bltz	a0,27ee <sbrkbasic+0x54>
  if(pid == 0){
    27b2:	e925                	bnez	a0,2822 <sbrkbasic+0x88>
    a = sbrk(TOOMUCH);
    27b4:	40000537          	lui	a0,0x40000
    27b8:	00003097          	auipc	ra,0x3
    27bc:	3e4080e7          	jalr	996(ra) # 5b9c <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    27c0:	57fd                	li	a5,-1
    27c2:	04f50763          	beq	a0,a5,2810 <sbrkbasic+0x76>
    27c6:	fc26                	sd	s1,56(sp)
    27c8:	f84a                	sd	s2,48(sp)
    27ca:	f44e                	sd	s3,40(sp)
    27cc:	f052                	sd	s4,32(sp)
    for(b = a; b < a+TOOMUCH; b += 4096){
    27ce:	400007b7          	lui	a5,0x40000
    27d2:	97aa                	add	a5,a5,a0
      *b = 99;
    27d4:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    27d8:	6705                	lui	a4,0x1
      *b = 99;
    27da:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3ffefba0>
    for(b = a; b < a+TOOMUCH; b += 4096){
    27de:	953a                	add	a0,a0,a4
    27e0:	fef51de3          	bne	a0,a5,27da <sbrkbasic+0x40>
    exit(1);
    27e4:	4505                	li	a0,1
    27e6:	00003097          	auipc	ra,0x3
    27ea:	32e080e7          	jalr	814(ra) # 5b14 <exit>
    27ee:	fc26                	sd	s1,56(sp)
    27f0:	f84a                	sd	s2,48(sp)
    27f2:	f44e                	sd	s3,40(sp)
    27f4:	f052                	sd	s4,32(sp)
    printf("fork failed in sbrkbasic\n");
    27f6:	00004517          	auipc	a0,0x4
    27fa:	5fa50513          	addi	a0,a0,1530 # 6df0 <malloc+0xeba>
    27fe:	00003097          	auipc	ra,0x3
    2802:	67c080e7          	jalr	1660(ra) # 5e7a <printf>
    exit(1);
    2806:	4505                	li	a0,1
    2808:	00003097          	auipc	ra,0x3
    280c:	30c080e7          	jalr	780(ra) # 5b14 <exit>
    2810:	fc26                	sd	s1,56(sp)
    2812:	f84a                	sd	s2,48(sp)
    2814:	f44e                	sd	s3,40(sp)
    2816:	f052                	sd	s4,32(sp)
      exit(0);
    2818:	4501                	li	a0,0
    281a:	00003097          	auipc	ra,0x3
    281e:	2fa080e7          	jalr	762(ra) # 5b14 <exit>
  wait(&xstatus);
    2822:	fbc40513          	addi	a0,s0,-68
    2826:	00003097          	auipc	ra,0x3
    282a:	2f6080e7          	jalr	758(ra) # 5b1c <wait>
  if(xstatus == 1){
    282e:	fbc42703          	lw	a4,-68(s0)
    2832:	4785                	li	a5,1
    2834:	02f70263          	beq	a4,a5,2858 <sbrkbasic+0xbe>
    2838:	fc26                	sd	s1,56(sp)
    283a:	f84a                	sd	s2,48(sp)
    283c:	f44e                	sd	s3,40(sp)
    283e:	f052                	sd	s4,32(sp)
  a = sbrk(0);
    2840:	4501                	li	a0,0
    2842:	00003097          	auipc	ra,0x3
    2846:	35a080e7          	jalr	858(ra) # 5b9c <sbrk>
    284a:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    284c:	4901                	li	s2,0
    b = sbrk(1);
    284e:	4985                	li	s3,1
  for(i = 0; i < 5000; i++){
    2850:	6a05                	lui	s4,0x1
    2852:	388a0a13          	addi	s4,s4,904 # 1388 <copyinstr2+0x176>
    2856:	a025                	j	287e <sbrkbasic+0xe4>
    2858:	fc26                	sd	s1,56(sp)
    285a:	f84a                	sd	s2,48(sp)
    285c:	f44e                	sd	s3,40(sp)
    285e:	f052                	sd	s4,32(sp)
    printf("%s: too much memory allocated!\n", s);
    2860:	85d6                	mv	a1,s5
    2862:	00004517          	auipc	a0,0x4
    2866:	5ae50513          	addi	a0,a0,1454 # 6e10 <malloc+0xeda>
    286a:	00003097          	auipc	ra,0x3
    286e:	610080e7          	jalr	1552(ra) # 5e7a <printf>
    exit(1);
    2872:	4505                	li	a0,1
    2874:	00003097          	auipc	ra,0x3
    2878:	2a0080e7          	jalr	672(ra) # 5b14 <exit>
    287c:	84be                	mv	s1,a5
    b = sbrk(1);
    287e:	854e                	mv	a0,s3
    2880:	00003097          	auipc	ra,0x3
    2884:	31c080e7          	jalr	796(ra) # 5b9c <sbrk>
    if(b != a){
    2888:	04951b63          	bne	a0,s1,28de <sbrkbasic+0x144>
    *b = 1;
    288c:	01348023          	sb	s3,0(s1)
    a = b + 1;
    2890:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    2894:	2905                	addiw	s2,s2,1
    2896:	ff4913e3          	bne	s2,s4,287c <sbrkbasic+0xe2>
  pid = fork();
    289a:	00003097          	auipc	ra,0x3
    289e:	272080e7          	jalr	626(ra) # 5b0c <fork>
    28a2:	892a                	mv	s2,a0
  if(pid < 0){
    28a4:	04054e63          	bltz	a0,2900 <sbrkbasic+0x166>
  c = sbrk(1);
    28a8:	4505                	li	a0,1
    28aa:	00003097          	auipc	ra,0x3
    28ae:	2f2080e7          	jalr	754(ra) # 5b9c <sbrk>
  c = sbrk(1);
    28b2:	4505                	li	a0,1
    28b4:	00003097          	auipc	ra,0x3
    28b8:	2e8080e7          	jalr	744(ra) # 5b9c <sbrk>
  if(c != a + 1){
    28bc:	0489                	addi	s1,s1,2
    28be:	04950f63          	beq	a0,s1,291c <sbrkbasic+0x182>
    printf("%s: sbrk test failed post-fork\n", s);
    28c2:	85d6                	mv	a1,s5
    28c4:	00004517          	auipc	a0,0x4
    28c8:	5ac50513          	addi	a0,a0,1452 # 6e70 <malloc+0xf3a>
    28cc:	00003097          	auipc	ra,0x3
    28d0:	5ae080e7          	jalr	1454(ra) # 5e7a <printf>
    exit(1);
    28d4:	4505                	li	a0,1
    28d6:	00003097          	auipc	ra,0x3
    28da:	23e080e7          	jalr	574(ra) # 5b14 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    28de:	872a                	mv	a4,a0
    28e0:	86a6                	mv	a3,s1
    28e2:	864a                	mv	a2,s2
    28e4:	85d6                	mv	a1,s5
    28e6:	00004517          	auipc	a0,0x4
    28ea:	54a50513          	addi	a0,a0,1354 # 6e30 <malloc+0xefa>
    28ee:	00003097          	auipc	ra,0x3
    28f2:	58c080e7          	jalr	1420(ra) # 5e7a <printf>
      exit(1);
    28f6:	4505                	li	a0,1
    28f8:	00003097          	auipc	ra,0x3
    28fc:	21c080e7          	jalr	540(ra) # 5b14 <exit>
    printf("%s: sbrk test fork failed\n", s);
    2900:	85d6                	mv	a1,s5
    2902:	00004517          	auipc	a0,0x4
    2906:	54e50513          	addi	a0,a0,1358 # 6e50 <malloc+0xf1a>
    290a:	00003097          	auipc	ra,0x3
    290e:	570080e7          	jalr	1392(ra) # 5e7a <printf>
    exit(1);
    2912:	4505                	li	a0,1
    2914:	00003097          	auipc	ra,0x3
    2918:	200080e7          	jalr	512(ra) # 5b14 <exit>
  if(pid == 0)
    291c:	00091763          	bnez	s2,292a <sbrkbasic+0x190>
    exit(0);
    2920:	4501                	li	a0,0
    2922:	00003097          	auipc	ra,0x3
    2926:	1f2080e7          	jalr	498(ra) # 5b14 <exit>
  wait(&xstatus);
    292a:	fbc40513          	addi	a0,s0,-68
    292e:	00003097          	auipc	ra,0x3
    2932:	1ee080e7          	jalr	494(ra) # 5b1c <wait>
  exit(xstatus);
    2936:	fbc42503          	lw	a0,-68(s0)
    293a:	00003097          	auipc	ra,0x3
    293e:	1da080e7          	jalr	474(ra) # 5b14 <exit>

0000000000002942 <sbrkmuch>:
{
    2942:	7179                	addi	sp,sp,-48
    2944:	f406                	sd	ra,40(sp)
    2946:	f022                	sd	s0,32(sp)
    2948:	ec26                	sd	s1,24(sp)
    294a:	e84a                	sd	s2,16(sp)
    294c:	e44e                	sd	s3,8(sp)
    294e:	e052                	sd	s4,0(sp)
    2950:	1800                	addi	s0,sp,48
    2952:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2954:	4501                	li	a0,0
    2956:	00003097          	auipc	ra,0x3
    295a:	246080e7          	jalr	582(ra) # 5b9c <sbrk>
    295e:	892a                	mv	s2,a0
  a = sbrk(0);
    2960:	4501                	li	a0,0
    2962:	00003097          	auipc	ra,0x3
    2966:	23a080e7          	jalr	570(ra) # 5b9c <sbrk>
    296a:	84aa                	mv	s1,a0
  p = sbrk(amt);
    296c:	06400537          	lui	a0,0x6400
    2970:	9d05                	subw	a0,a0,s1
    2972:	00003097          	auipc	ra,0x3
    2976:	22a080e7          	jalr	554(ra) # 5b9c <sbrk>
  if (p != a) {
    297a:	0ca49a63          	bne	s1,a0,2a4e <sbrkmuch+0x10c>
  char *eee = sbrk(0);
    297e:	4501                	li	a0,0
    2980:	00003097          	auipc	ra,0x3
    2984:	21c080e7          	jalr	540(ra) # 5b9c <sbrk>
    2988:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    298a:	00a4f963          	bgeu	s1,a0,299c <sbrkmuch+0x5a>
    *pp = 1;
    298e:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2990:	6705                	lui	a4,0x1
    *pp = 1;
    2992:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2996:	94ba                	add	s1,s1,a4
    2998:	fef4ede3          	bltu	s1,a5,2992 <sbrkmuch+0x50>
  *lastaddr = 99;
    299c:	064007b7          	lui	a5,0x6400
    29a0:	06300713          	li	a4,99
    29a4:	fee78fa3          	sb	a4,-1(a5) # 63fffff <__BSS_END__+0x63efb9f>
  a = sbrk(0);
    29a8:	4501                	li	a0,0
    29aa:	00003097          	auipc	ra,0x3
    29ae:	1f2080e7          	jalr	498(ra) # 5b9c <sbrk>
    29b2:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    29b4:	757d                	lui	a0,0xfffff
    29b6:	00003097          	auipc	ra,0x3
    29ba:	1e6080e7          	jalr	486(ra) # 5b9c <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    29be:	57fd                	li	a5,-1
    29c0:	0af50563          	beq	a0,a5,2a6a <sbrkmuch+0x128>
  c = sbrk(0);
    29c4:	4501                	li	a0,0
    29c6:	00003097          	auipc	ra,0x3
    29ca:	1d6080e7          	jalr	470(ra) # 5b9c <sbrk>
  if(c != a - PGSIZE){
    29ce:	80048793          	addi	a5,s1,-2048
    29d2:	80078793          	addi	a5,a5,-2048
    29d6:	0af51863          	bne	a0,a5,2a86 <sbrkmuch+0x144>
  a = sbrk(0);
    29da:	4501                	li	a0,0
    29dc:	00003097          	auipc	ra,0x3
    29e0:	1c0080e7          	jalr	448(ra) # 5b9c <sbrk>
    29e4:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    29e6:	6505                	lui	a0,0x1
    29e8:	00003097          	auipc	ra,0x3
    29ec:	1b4080e7          	jalr	436(ra) # 5b9c <sbrk>
    29f0:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    29f2:	0aa49a63          	bne	s1,a0,2aa6 <sbrkmuch+0x164>
    29f6:	4501                	li	a0,0
    29f8:	00003097          	auipc	ra,0x3
    29fc:	1a4080e7          	jalr	420(ra) # 5b9c <sbrk>
    2a00:	6785                	lui	a5,0x1
    2a02:	97a6                	add	a5,a5,s1
    2a04:	0af51163          	bne	a0,a5,2aa6 <sbrkmuch+0x164>
  if(*lastaddr == 99){
    2a08:	064007b7          	lui	a5,0x6400
    2a0c:	fff7c703          	lbu	a4,-1(a5) # 63fffff <__BSS_END__+0x63efb9f>
    2a10:	06300793          	li	a5,99
    2a14:	0af70963          	beq	a4,a5,2ac6 <sbrkmuch+0x184>
  a = sbrk(0);
    2a18:	4501                	li	a0,0
    2a1a:	00003097          	auipc	ra,0x3
    2a1e:	182080e7          	jalr	386(ra) # 5b9c <sbrk>
    2a22:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2a24:	4501                	li	a0,0
    2a26:	00003097          	auipc	ra,0x3
    2a2a:	176080e7          	jalr	374(ra) # 5b9c <sbrk>
    2a2e:	40a9053b          	subw	a0,s2,a0
    2a32:	00003097          	auipc	ra,0x3
    2a36:	16a080e7          	jalr	362(ra) # 5b9c <sbrk>
  if(c != a){
    2a3a:	0aa49463          	bne	s1,a0,2ae2 <sbrkmuch+0x1a0>
}
    2a3e:	70a2                	ld	ra,40(sp)
    2a40:	7402                	ld	s0,32(sp)
    2a42:	64e2                	ld	s1,24(sp)
    2a44:	6942                	ld	s2,16(sp)
    2a46:	69a2                	ld	s3,8(sp)
    2a48:	6a02                	ld	s4,0(sp)
    2a4a:	6145                	addi	sp,sp,48
    2a4c:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2a4e:	85ce                	mv	a1,s3
    2a50:	00004517          	auipc	a0,0x4
    2a54:	44050513          	addi	a0,a0,1088 # 6e90 <malloc+0xf5a>
    2a58:	00003097          	auipc	ra,0x3
    2a5c:	422080e7          	jalr	1058(ra) # 5e7a <printf>
    exit(1);
    2a60:	4505                	li	a0,1
    2a62:	00003097          	auipc	ra,0x3
    2a66:	0b2080e7          	jalr	178(ra) # 5b14 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2a6a:	85ce                	mv	a1,s3
    2a6c:	00004517          	auipc	a0,0x4
    2a70:	46c50513          	addi	a0,a0,1132 # 6ed8 <malloc+0xfa2>
    2a74:	00003097          	auipc	ra,0x3
    2a78:	406080e7          	jalr	1030(ra) # 5e7a <printf>
    exit(1);
    2a7c:	4505                	li	a0,1
    2a7e:	00003097          	auipc	ra,0x3
    2a82:	096080e7          	jalr	150(ra) # 5b14 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2a86:	86aa                	mv	a3,a0
    2a88:	8626                	mv	a2,s1
    2a8a:	85ce                	mv	a1,s3
    2a8c:	00004517          	auipc	a0,0x4
    2a90:	46c50513          	addi	a0,a0,1132 # 6ef8 <malloc+0xfc2>
    2a94:	00003097          	auipc	ra,0x3
    2a98:	3e6080e7          	jalr	998(ra) # 5e7a <printf>
    exit(1);
    2a9c:	4505                	li	a0,1
    2a9e:	00003097          	auipc	ra,0x3
    2aa2:	076080e7          	jalr	118(ra) # 5b14 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2aa6:	86d2                	mv	a3,s4
    2aa8:	8626                	mv	a2,s1
    2aaa:	85ce                	mv	a1,s3
    2aac:	00004517          	auipc	a0,0x4
    2ab0:	48c50513          	addi	a0,a0,1164 # 6f38 <malloc+0x1002>
    2ab4:	00003097          	auipc	ra,0x3
    2ab8:	3c6080e7          	jalr	966(ra) # 5e7a <printf>
    exit(1);
    2abc:	4505                	li	a0,1
    2abe:	00003097          	auipc	ra,0x3
    2ac2:	056080e7          	jalr	86(ra) # 5b14 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2ac6:	85ce                	mv	a1,s3
    2ac8:	00004517          	auipc	a0,0x4
    2acc:	4a050513          	addi	a0,a0,1184 # 6f68 <malloc+0x1032>
    2ad0:	00003097          	auipc	ra,0x3
    2ad4:	3aa080e7          	jalr	938(ra) # 5e7a <printf>
    exit(1);
    2ad8:	4505                	li	a0,1
    2ada:	00003097          	auipc	ra,0x3
    2ade:	03a080e7          	jalr	58(ra) # 5b14 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2ae2:	86aa                	mv	a3,a0
    2ae4:	8626                	mv	a2,s1
    2ae6:	85ce                	mv	a1,s3
    2ae8:	00004517          	auipc	a0,0x4
    2aec:	4b850513          	addi	a0,a0,1208 # 6fa0 <malloc+0x106a>
    2af0:	00003097          	auipc	ra,0x3
    2af4:	38a080e7          	jalr	906(ra) # 5e7a <printf>
    exit(1);
    2af8:	4505                	li	a0,1
    2afa:	00003097          	auipc	ra,0x3
    2afe:	01a080e7          	jalr	26(ra) # 5b14 <exit>

0000000000002b02 <sbrkarg>:
{
    2b02:	7179                	addi	sp,sp,-48
    2b04:	f406                	sd	ra,40(sp)
    2b06:	f022                	sd	s0,32(sp)
    2b08:	ec26                	sd	s1,24(sp)
    2b0a:	e84a                	sd	s2,16(sp)
    2b0c:	e44e                	sd	s3,8(sp)
    2b0e:	1800                	addi	s0,sp,48
    2b10:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2b12:	6505                	lui	a0,0x1
    2b14:	00003097          	auipc	ra,0x3
    2b18:	088080e7          	jalr	136(ra) # 5b9c <sbrk>
    2b1c:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2b1e:	20100593          	li	a1,513
    2b22:	00004517          	auipc	a0,0x4
    2b26:	4a650513          	addi	a0,a0,1190 # 6fc8 <malloc+0x1092>
    2b2a:	00003097          	auipc	ra,0x3
    2b2e:	02a080e7          	jalr	42(ra) # 5b54 <open>
    2b32:	84aa                	mv	s1,a0
  unlink("sbrk");
    2b34:	00004517          	auipc	a0,0x4
    2b38:	49450513          	addi	a0,a0,1172 # 6fc8 <malloc+0x1092>
    2b3c:	00003097          	auipc	ra,0x3
    2b40:	028080e7          	jalr	40(ra) # 5b64 <unlink>
  if(fd < 0)  {
    2b44:	0404c163          	bltz	s1,2b86 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2b48:	6605                	lui	a2,0x1
    2b4a:	85ca                	mv	a1,s2
    2b4c:	8526                	mv	a0,s1
    2b4e:	00003097          	auipc	ra,0x3
    2b52:	fe6080e7          	jalr	-26(ra) # 5b34 <write>
    2b56:	04054663          	bltz	a0,2ba2 <sbrkarg+0xa0>
  close(fd);
    2b5a:	8526                	mv	a0,s1
    2b5c:	00003097          	auipc	ra,0x3
    2b60:	fe0080e7          	jalr	-32(ra) # 5b3c <close>
  a = sbrk(PGSIZE);
    2b64:	6505                	lui	a0,0x1
    2b66:	00003097          	auipc	ra,0x3
    2b6a:	036080e7          	jalr	54(ra) # 5b9c <sbrk>
  if(pipe((int *) a) != 0){
    2b6e:	00003097          	auipc	ra,0x3
    2b72:	fb6080e7          	jalr	-74(ra) # 5b24 <pipe>
    2b76:	e521                	bnez	a0,2bbe <sbrkarg+0xbc>
}
    2b78:	70a2                	ld	ra,40(sp)
    2b7a:	7402                	ld	s0,32(sp)
    2b7c:	64e2                	ld	s1,24(sp)
    2b7e:	6942                	ld	s2,16(sp)
    2b80:	69a2                	ld	s3,8(sp)
    2b82:	6145                	addi	sp,sp,48
    2b84:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2b86:	85ce                	mv	a1,s3
    2b88:	00004517          	auipc	a0,0x4
    2b8c:	44850513          	addi	a0,a0,1096 # 6fd0 <malloc+0x109a>
    2b90:	00003097          	auipc	ra,0x3
    2b94:	2ea080e7          	jalr	746(ra) # 5e7a <printf>
    exit(1);
    2b98:	4505                	li	a0,1
    2b9a:	00003097          	auipc	ra,0x3
    2b9e:	f7a080e7          	jalr	-134(ra) # 5b14 <exit>
    printf("%s: write sbrk failed\n", s);
    2ba2:	85ce                	mv	a1,s3
    2ba4:	00004517          	auipc	a0,0x4
    2ba8:	44450513          	addi	a0,a0,1092 # 6fe8 <malloc+0x10b2>
    2bac:	00003097          	auipc	ra,0x3
    2bb0:	2ce080e7          	jalr	718(ra) # 5e7a <printf>
    exit(1);
    2bb4:	4505                	li	a0,1
    2bb6:	00003097          	auipc	ra,0x3
    2bba:	f5e080e7          	jalr	-162(ra) # 5b14 <exit>
    printf("%s: pipe() failed\n", s);
    2bbe:	85ce                	mv	a1,s3
    2bc0:	00004517          	auipc	a0,0x4
    2bc4:	e0850513          	addi	a0,a0,-504 # 69c8 <malloc+0xa92>
    2bc8:	00003097          	auipc	ra,0x3
    2bcc:	2b2080e7          	jalr	690(ra) # 5e7a <printf>
    exit(1);
    2bd0:	4505                	li	a0,1
    2bd2:	00003097          	auipc	ra,0x3
    2bd6:	f42080e7          	jalr	-190(ra) # 5b14 <exit>

0000000000002bda <argptest>:
{
    2bda:	1101                	addi	sp,sp,-32
    2bdc:	ec06                	sd	ra,24(sp)
    2bde:	e822                	sd	s0,16(sp)
    2be0:	e426                	sd	s1,8(sp)
    2be2:	e04a                	sd	s2,0(sp)
    2be4:	1000                	addi	s0,sp,32
    2be6:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2be8:	4581                	li	a1,0
    2bea:	00004517          	auipc	a0,0x4
    2bee:	41650513          	addi	a0,a0,1046 # 7000 <malloc+0x10ca>
    2bf2:	00003097          	auipc	ra,0x3
    2bf6:	f62080e7          	jalr	-158(ra) # 5b54 <open>
  if (fd < 0) {
    2bfa:	02054b63          	bltz	a0,2c30 <argptest+0x56>
    2bfe:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2c00:	4501                	li	a0,0
    2c02:	00003097          	auipc	ra,0x3
    2c06:	f9a080e7          	jalr	-102(ra) # 5b9c <sbrk>
    2c0a:	567d                	li	a2,-1
    2c0c:	00c505b3          	add	a1,a0,a2
    2c10:	8526                	mv	a0,s1
    2c12:	00003097          	auipc	ra,0x3
    2c16:	f1a080e7          	jalr	-230(ra) # 5b2c <read>
  close(fd);
    2c1a:	8526                	mv	a0,s1
    2c1c:	00003097          	auipc	ra,0x3
    2c20:	f20080e7          	jalr	-224(ra) # 5b3c <close>
}
    2c24:	60e2                	ld	ra,24(sp)
    2c26:	6442                	ld	s0,16(sp)
    2c28:	64a2                	ld	s1,8(sp)
    2c2a:	6902                	ld	s2,0(sp)
    2c2c:	6105                	addi	sp,sp,32
    2c2e:	8082                	ret
    printf("%s: open failed\n", s);
    2c30:	85ca                	mv	a1,s2
    2c32:	00004517          	auipc	a0,0x4
    2c36:	ca650513          	addi	a0,a0,-858 # 68d8 <malloc+0x9a2>
    2c3a:	00003097          	auipc	ra,0x3
    2c3e:	240080e7          	jalr	576(ra) # 5e7a <printf>
    exit(1);
    2c42:	4505                	li	a0,1
    2c44:	00003097          	auipc	ra,0x3
    2c48:	ed0080e7          	jalr	-304(ra) # 5b14 <exit>

0000000000002c4c <sbrkbugs>:
{
    2c4c:	1141                	addi	sp,sp,-16
    2c4e:	e406                	sd	ra,8(sp)
    2c50:	e022                	sd	s0,0(sp)
    2c52:	0800                	addi	s0,sp,16
  int pid = fork();
    2c54:	00003097          	auipc	ra,0x3
    2c58:	eb8080e7          	jalr	-328(ra) # 5b0c <fork>
  if(pid < 0){
    2c5c:	02054263          	bltz	a0,2c80 <sbrkbugs+0x34>
  if(pid == 0){
    2c60:	ed0d                	bnez	a0,2c9a <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2c62:	00003097          	auipc	ra,0x3
    2c66:	f3a080e7          	jalr	-198(ra) # 5b9c <sbrk>
    sbrk(-sz);
    2c6a:	40a0053b          	negw	a0,a0
    2c6e:	00003097          	auipc	ra,0x3
    2c72:	f2e080e7          	jalr	-210(ra) # 5b9c <sbrk>
    exit(0);
    2c76:	4501                	li	a0,0
    2c78:	00003097          	auipc	ra,0x3
    2c7c:	e9c080e7          	jalr	-356(ra) # 5b14 <exit>
    printf("fork failed\n");
    2c80:	00004517          	auipc	a0,0x4
    2c84:	06050513          	addi	a0,a0,96 # 6ce0 <malloc+0xdaa>
    2c88:	00003097          	auipc	ra,0x3
    2c8c:	1f2080e7          	jalr	498(ra) # 5e7a <printf>
    exit(1);
    2c90:	4505                	li	a0,1
    2c92:	00003097          	auipc	ra,0x3
    2c96:	e82080e7          	jalr	-382(ra) # 5b14 <exit>
  wait(0);
    2c9a:	4501                	li	a0,0
    2c9c:	00003097          	auipc	ra,0x3
    2ca0:	e80080e7          	jalr	-384(ra) # 5b1c <wait>
  pid = fork();
    2ca4:	00003097          	auipc	ra,0x3
    2ca8:	e68080e7          	jalr	-408(ra) # 5b0c <fork>
  if(pid < 0){
    2cac:	02054563          	bltz	a0,2cd6 <sbrkbugs+0x8a>
  if(pid == 0){
    2cb0:	e121                	bnez	a0,2cf0 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2cb2:	00003097          	auipc	ra,0x3
    2cb6:	eea080e7          	jalr	-278(ra) # 5b9c <sbrk>
    sbrk(-(sz - 3500));
    2cba:	6785                	lui	a5,0x1
    2cbc:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0x4c>
    2cc0:	40a7853b          	subw	a0,a5,a0
    2cc4:	00003097          	auipc	ra,0x3
    2cc8:	ed8080e7          	jalr	-296(ra) # 5b9c <sbrk>
    exit(0);
    2ccc:	4501                	li	a0,0
    2cce:	00003097          	auipc	ra,0x3
    2cd2:	e46080e7          	jalr	-442(ra) # 5b14 <exit>
    printf("fork failed\n");
    2cd6:	00004517          	auipc	a0,0x4
    2cda:	00a50513          	addi	a0,a0,10 # 6ce0 <malloc+0xdaa>
    2cde:	00003097          	auipc	ra,0x3
    2ce2:	19c080e7          	jalr	412(ra) # 5e7a <printf>
    exit(1);
    2ce6:	4505                	li	a0,1
    2ce8:	00003097          	auipc	ra,0x3
    2cec:	e2c080e7          	jalr	-468(ra) # 5b14 <exit>
  wait(0);
    2cf0:	4501                	li	a0,0
    2cf2:	00003097          	auipc	ra,0x3
    2cf6:	e2a080e7          	jalr	-470(ra) # 5b1c <wait>
  pid = fork();
    2cfa:	00003097          	auipc	ra,0x3
    2cfe:	e12080e7          	jalr	-494(ra) # 5b0c <fork>
  if(pid < 0){
    2d02:	02054a63          	bltz	a0,2d36 <sbrkbugs+0xea>
  if(pid == 0){
    2d06:	e529                	bnez	a0,2d50 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2d08:	00003097          	auipc	ra,0x3
    2d0c:	e94080e7          	jalr	-364(ra) # 5b9c <sbrk>
    2d10:	67ad                	lui	a5,0xb
    2d12:	8007879b          	addiw	a5,a5,-2048 # a800 <__global_pointer$+0x3d4>
    2d16:	40a7853b          	subw	a0,a5,a0
    2d1a:	00003097          	auipc	ra,0x3
    2d1e:	e82080e7          	jalr	-382(ra) # 5b9c <sbrk>
    sbrk(-10);
    2d22:	5559                	li	a0,-10
    2d24:	00003097          	auipc	ra,0x3
    2d28:	e78080e7          	jalr	-392(ra) # 5b9c <sbrk>
    exit(0);
    2d2c:	4501                	li	a0,0
    2d2e:	00003097          	auipc	ra,0x3
    2d32:	de6080e7          	jalr	-538(ra) # 5b14 <exit>
    printf("fork failed\n");
    2d36:	00004517          	auipc	a0,0x4
    2d3a:	faa50513          	addi	a0,a0,-86 # 6ce0 <malloc+0xdaa>
    2d3e:	00003097          	auipc	ra,0x3
    2d42:	13c080e7          	jalr	316(ra) # 5e7a <printf>
    exit(1);
    2d46:	4505                	li	a0,1
    2d48:	00003097          	auipc	ra,0x3
    2d4c:	dcc080e7          	jalr	-564(ra) # 5b14 <exit>
  wait(0);
    2d50:	4501                	li	a0,0
    2d52:	00003097          	auipc	ra,0x3
    2d56:	dca080e7          	jalr	-566(ra) # 5b1c <wait>
  exit(0);
    2d5a:	4501                	li	a0,0
    2d5c:	00003097          	auipc	ra,0x3
    2d60:	db8080e7          	jalr	-584(ra) # 5b14 <exit>

0000000000002d64 <sbrklast>:
{
    2d64:	7179                	addi	sp,sp,-48
    2d66:	f406                	sd	ra,40(sp)
    2d68:	f022                	sd	s0,32(sp)
    2d6a:	ec26                	sd	s1,24(sp)
    2d6c:	e84a                	sd	s2,16(sp)
    2d6e:	e44e                	sd	s3,8(sp)
    2d70:	e052                	sd	s4,0(sp)
    2d72:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2d74:	4501                	li	a0,0
    2d76:	00003097          	auipc	ra,0x3
    2d7a:	e26080e7          	jalr	-474(ra) # 5b9c <sbrk>
  if((top % 4096) != 0)
    2d7e:	03451793          	slli	a5,a0,0x34
    2d82:	ebd9                	bnez	a5,2e18 <sbrklast+0xb4>
  sbrk(4096);
    2d84:	6505                	lui	a0,0x1
    2d86:	00003097          	auipc	ra,0x3
    2d8a:	e16080e7          	jalr	-490(ra) # 5b9c <sbrk>
  sbrk(10);
    2d8e:	4529                	li	a0,10
    2d90:	00003097          	auipc	ra,0x3
    2d94:	e0c080e7          	jalr	-500(ra) # 5b9c <sbrk>
  sbrk(-20);
    2d98:	5531                	li	a0,-20
    2d9a:	00003097          	auipc	ra,0x3
    2d9e:	e02080e7          	jalr	-510(ra) # 5b9c <sbrk>
  top = (uint64) sbrk(0);
    2da2:	4501                	li	a0,0
    2da4:	00003097          	auipc	ra,0x3
    2da8:	df8080e7          	jalr	-520(ra) # 5b9c <sbrk>
    2dac:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2dae:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0x14>
  p[0] = 'x';
    2db2:	07800993          	li	s3,120
    2db6:	fd350023          	sb	s3,-64(a0)
  p[1] = '\0';
    2dba:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2dbe:	20200593          	li	a1,514
    2dc2:	854a                	mv	a0,s2
    2dc4:	00003097          	auipc	ra,0x3
    2dc8:	d90080e7          	jalr	-624(ra) # 5b54 <open>
    2dcc:	8a2a                	mv	s4,a0
  write(fd, p, 1);
    2dce:	4605                	li	a2,1
    2dd0:	85ca                	mv	a1,s2
    2dd2:	00003097          	auipc	ra,0x3
    2dd6:	d62080e7          	jalr	-670(ra) # 5b34 <write>
  close(fd);
    2dda:	8552                	mv	a0,s4
    2ddc:	00003097          	auipc	ra,0x3
    2de0:	d60080e7          	jalr	-672(ra) # 5b3c <close>
  fd = open(p, O_RDWR);
    2de4:	4589                	li	a1,2
    2de6:	854a                	mv	a0,s2
    2de8:	00003097          	auipc	ra,0x3
    2dec:	d6c080e7          	jalr	-660(ra) # 5b54 <open>
  p[0] = '\0';
    2df0:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2df4:	4605                	li	a2,1
    2df6:	85ca                	mv	a1,s2
    2df8:	00003097          	auipc	ra,0x3
    2dfc:	d34080e7          	jalr	-716(ra) # 5b2c <read>
  if(p[0] != 'x')
    2e00:	fc04c783          	lbu	a5,-64(s1)
    2e04:	03379463          	bne	a5,s3,2e2c <sbrklast+0xc8>
}
    2e08:	70a2                	ld	ra,40(sp)
    2e0a:	7402                	ld	s0,32(sp)
    2e0c:	64e2                	ld	s1,24(sp)
    2e0e:	6942                	ld	s2,16(sp)
    2e10:	69a2                	ld	s3,8(sp)
    2e12:	6a02                	ld	s4,0(sp)
    2e14:	6145                	addi	sp,sp,48
    2e16:	8082                	ret
    sbrk(4096 - (top % 4096));
    2e18:	0347d513          	srli	a0,a5,0x34
    2e1c:	6785                	lui	a5,0x1
    2e1e:	40a7853b          	subw	a0,a5,a0
    2e22:	00003097          	auipc	ra,0x3
    2e26:	d7a080e7          	jalr	-646(ra) # 5b9c <sbrk>
    2e2a:	bfa9                	j	2d84 <sbrklast+0x20>
    exit(1);
    2e2c:	4505                	li	a0,1
    2e2e:	00003097          	auipc	ra,0x3
    2e32:	ce6080e7          	jalr	-794(ra) # 5b14 <exit>

0000000000002e36 <sbrk8000>:
{
    2e36:	1141                	addi	sp,sp,-16
    2e38:	e406                	sd	ra,8(sp)
    2e3a:	e022                	sd	s0,0(sp)
    2e3c:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2e3e:	80000537          	lui	a0,0x80000
    2e42:	0511                	addi	a0,a0,4 # ffffffff80000004 <__BSS_END__+0xffffffff7ffefba4>
    2e44:	00003097          	auipc	ra,0x3
    2e48:	d58080e7          	jalr	-680(ra) # 5b9c <sbrk>
  volatile char *top = sbrk(0);
    2e4c:	4501                	li	a0,0
    2e4e:	00003097          	auipc	ra,0x3
    2e52:	d4e080e7          	jalr	-690(ra) # 5b9c <sbrk>
  *(top-1) = *(top-1) + 1;
    2e56:	fff54783          	lbu	a5,-1(a0)
    2e5a:	0785                	addi	a5,a5,1 # 1001 <bigdir+0x55>
    2e5c:	0ff7f793          	zext.b	a5,a5
    2e60:	fef50fa3          	sb	a5,-1(a0)
}
    2e64:	60a2                	ld	ra,8(sp)
    2e66:	6402                	ld	s0,0(sp)
    2e68:	0141                	addi	sp,sp,16
    2e6a:	8082                	ret

0000000000002e6c <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    2e6c:	711d                	addi	sp,sp,-96
    2e6e:	ec86                	sd	ra,88(sp)
    2e70:	e8a2                	sd	s0,80(sp)
    2e72:	e4a6                	sd	s1,72(sp)
    2e74:	e0ca                	sd	s2,64(sp)
    2e76:	fc4e                	sd	s3,56(sp)
    2e78:	1080                	addi	s0,sp,96
  for(int avail = 0; avail < 15; avail++){
    2e7a:	4901                	li	s2,0
    2e7c:	49bd                	li	s3,15
    int pid = fork();
    2e7e:	00003097          	auipc	ra,0x3
    2e82:	c8e080e7          	jalr	-882(ra) # 5b0c <fork>
    2e86:	84aa                	mv	s1,a0
    if(pid < 0){
    2e88:	02054263          	bltz	a0,2eac <execout+0x40>
      printf("fork failed\n");
      exit(1);
    } else if(pid == 0){
    2e8c:	cd1d                	beqz	a0,2eca <execout+0x5e>
      close(1);
      char *args[] = { "echo", "x", 0 };
      exec("echo", args);
      exit(0);
    } else {
      wait((int*)0);
    2e8e:	4501                	li	a0,0
    2e90:	00003097          	auipc	ra,0x3
    2e94:	c8c080e7          	jalr	-884(ra) # 5b1c <wait>
  for(int avail = 0; avail < 15; avail++){
    2e98:	2905                	addiw	s2,s2,1
    2e9a:	ff3912e3          	bne	s2,s3,2e7e <execout+0x12>
    2e9e:	f852                	sd	s4,48(sp)
    2ea0:	f456                	sd	s5,40(sp)
    }
  }

  exit(0);
    2ea2:	4501                	li	a0,0
    2ea4:	00003097          	auipc	ra,0x3
    2ea8:	c70080e7          	jalr	-912(ra) # 5b14 <exit>
    2eac:	f852                	sd	s4,48(sp)
    2eae:	f456                	sd	s5,40(sp)
      printf("fork failed\n");
    2eb0:	00004517          	auipc	a0,0x4
    2eb4:	e3050513          	addi	a0,a0,-464 # 6ce0 <malloc+0xdaa>
    2eb8:	00003097          	auipc	ra,0x3
    2ebc:	fc2080e7          	jalr	-62(ra) # 5e7a <printf>
      exit(1);
    2ec0:	4505                	li	a0,1
    2ec2:	00003097          	auipc	ra,0x3
    2ec6:	c52080e7          	jalr	-942(ra) # 5b14 <exit>
    2eca:	f852                	sd	s4,48(sp)
    2ecc:	f456                	sd	s5,40(sp)
        uint64 a = (uint64) sbrk(4096);
    2ece:	6985                	lui	s3,0x1
        if(a == 0xffffffffffffffffLL)
    2ed0:	5a7d                	li	s4,-1
        *(char*)(a + 4096 - 1) = 1;
    2ed2:	4a85                	li	s5,1
        uint64 a = (uint64) sbrk(4096);
    2ed4:	854e                	mv	a0,s3
    2ed6:	00003097          	auipc	ra,0x3
    2eda:	cc6080e7          	jalr	-826(ra) # 5b9c <sbrk>
        if(a == 0xffffffffffffffffLL)
    2ede:	01450663          	beq	a0,s4,2eea <execout+0x7e>
        *(char*)(a + 4096 - 1) = 1;
    2ee2:	954e                	add	a0,a0,s3
    2ee4:	ff550fa3          	sb	s5,-1(a0)
      while(1){
    2ee8:	b7f5                	j	2ed4 <execout+0x68>
        sbrk(-4096);
    2eea:	79fd                	lui	s3,0xfffff
      for(int i = 0; i < avail; i++)
    2eec:	01205a63          	blez	s2,2f00 <execout+0x94>
        sbrk(-4096);
    2ef0:	854e                	mv	a0,s3
    2ef2:	00003097          	auipc	ra,0x3
    2ef6:	caa080e7          	jalr	-854(ra) # 5b9c <sbrk>
      for(int i = 0; i < avail; i++)
    2efa:	2485                	addiw	s1,s1,1
    2efc:	ff249ae3          	bne	s1,s2,2ef0 <execout+0x84>
      close(1);
    2f00:	4505                	li	a0,1
    2f02:	00003097          	auipc	ra,0x3
    2f06:	c3a080e7          	jalr	-966(ra) # 5b3c <close>
      char *args[] = { "echo", "x", 0 };
    2f0a:	00003797          	auipc	a5,0x3
    2f0e:	15e78793          	addi	a5,a5,350 # 6068 <malloc+0x132>
    2f12:	faf43423          	sd	a5,-88(s0)
    2f16:	00003797          	auipc	a5,0x3
    2f1a:	1c278793          	addi	a5,a5,450 # 60d8 <malloc+0x1a2>
    2f1e:	faf43823          	sd	a5,-80(s0)
    2f22:	fa043c23          	sd	zero,-72(s0)
      exec("echo", args);
    2f26:	fa840593          	addi	a1,s0,-88
    2f2a:	00003517          	auipc	a0,0x3
    2f2e:	13e50513          	addi	a0,a0,318 # 6068 <malloc+0x132>
    2f32:	00003097          	auipc	ra,0x3
    2f36:	c1a080e7          	jalr	-998(ra) # 5b4c <exec>
      exit(0);
    2f3a:	4501                	li	a0,0
    2f3c:	00003097          	auipc	ra,0x3
    2f40:	bd8080e7          	jalr	-1064(ra) # 5b14 <exit>

0000000000002f44 <fourteen>:
{
    2f44:	1101                	addi	sp,sp,-32
    2f46:	ec06                	sd	ra,24(sp)
    2f48:	e822                	sd	s0,16(sp)
    2f4a:	e426                	sd	s1,8(sp)
    2f4c:	1000                	addi	s0,sp,32
    2f4e:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2f50:	00004517          	auipc	a0,0x4
    2f54:	28850513          	addi	a0,a0,648 # 71d8 <malloc+0x12a2>
    2f58:	00003097          	auipc	ra,0x3
    2f5c:	c24080e7          	jalr	-988(ra) # 5b7c <mkdir>
    2f60:	e165                	bnez	a0,3040 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    2f62:	00004517          	auipc	a0,0x4
    2f66:	0ce50513          	addi	a0,a0,206 # 7030 <malloc+0x10fa>
    2f6a:	00003097          	auipc	ra,0x3
    2f6e:	c12080e7          	jalr	-1006(ra) # 5b7c <mkdir>
    2f72:	e56d                	bnez	a0,305c <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2f74:	20000593          	li	a1,512
    2f78:	00004517          	auipc	a0,0x4
    2f7c:	11050513          	addi	a0,a0,272 # 7088 <malloc+0x1152>
    2f80:	00003097          	auipc	ra,0x3
    2f84:	bd4080e7          	jalr	-1068(ra) # 5b54 <open>
  if(fd < 0){
    2f88:	0e054863          	bltz	a0,3078 <fourteen+0x134>
  close(fd);
    2f8c:	00003097          	auipc	ra,0x3
    2f90:	bb0080e7          	jalr	-1104(ra) # 5b3c <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2f94:	4581                	li	a1,0
    2f96:	00004517          	auipc	a0,0x4
    2f9a:	16a50513          	addi	a0,a0,362 # 7100 <malloc+0x11ca>
    2f9e:	00003097          	auipc	ra,0x3
    2fa2:	bb6080e7          	jalr	-1098(ra) # 5b54 <open>
  if(fd < 0){
    2fa6:	0e054763          	bltz	a0,3094 <fourteen+0x150>
  close(fd);
    2faa:	00003097          	auipc	ra,0x3
    2fae:	b92080e7          	jalr	-1134(ra) # 5b3c <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2fb2:	00004517          	auipc	a0,0x4
    2fb6:	1be50513          	addi	a0,a0,446 # 7170 <malloc+0x123a>
    2fba:	00003097          	auipc	ra,0x3
    2fbe:	bc2080e7          	jalr	-1086(ra) # 5b7c <mkdir>
    2fc2:	c57d                	beqz	a0,30b0 <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    2fc4:	00004517          	auipc	a0,0x4
    2fc8:	20450513          	addi	a0,a0,516 # 71c8 <malloc+0x1292>
    2fcc:	00003097          	auipc	ra,0x3
    2fd0:	bb0080e7          	jalr	-1104(ra) # 5b7c <mkdir>
    2fd4:	cd65                	beqz	a0,30cc <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    2fd6:	00004517          	auipc	a0,0x4
    2fda:	1f250513          	addi	a0,a0,498 # 71c8 <malloc+0x1292>
    2fde:	00003097          	auipc	ra,0x3
    2fe2:	b86080e7          	jalr	-1146(ra) # 5b64 <unlink>
  unlink("12345678901234/12345678901234");
    2fe6:	00004517          	auipc	a0,0x4
    2fea:	18a50513          	addi	a0,a0,394 # 7170 <malloc+0x123a>
    2fee:	00003097          	auipc	ra,0x3
    2ff2:	b76080e7          	jalr	-1162(ra) # 5b64 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2ff6:	00004517          	auipc	a0,0x4
    2ffa:	10a50513          	addi	a0,a0,266 # 7100 <malloc+0x11ca>
    2ffe:	00003097          	auipc	ra,0x3
    3002:	b66080e7          	jalr	-1178(ra) # 5b64 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    3006:	00004517          	auipc	a0,0x4
    300a:	08250513          	addi	a0,a0,130 # 7088 <malloc+0x1152>
    300e:	00003097          	auipc	ra,0x3
    3012:	b56080e7          	jalr	-1194(ra) # 5b64 <unlink>
  unlink("12345678901234/123456789012345");
    3016:	00004517          	auipc	a0,0x4
    301a:	01a50513          	addi	a0,a0,26 # 7030 <malloc+0x10fa>
    301e:	00003097          	auipc	ra,0x3
    3022:	b46080e7          	jalr	-1210(ra) # 5b64 <unlink>
  unlink("12345678901234");
    3026:	00004517          	auipc	a0,0x4
    302a:	1b250513          	addi	a0,a0,434 # 71d8 <malloc+0x12a2>
    302e:	00003097          	auipc	ra,0x3
    3032:	b36080e7          	jalr	-1226(ra) # 5b64 <unlink>
}
    3036:	60e2                	ld	ra,24(sp)
    3038:	6442                	ld	s0,16(sp)
    303a:	64a2                	ld	s1,8(sp)
    303c:	6105                	addi	sp,sp,32
    303e:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    3040:	85a6                	mv	a1,s1
    3042:	00004517          	auipc	a0,0x4
    3046:	fc650513          	addi	a0,a0,-58 # 7008 <malloc+0x10d2>
    304a:	00003097          	auipc	ra,0x3
    304e:	e30080e7          	jalr	-464(ra) # 5e7a <printf>
    exit(1);
    3052:	4505                	li	a0,1
    3054:	00003097          	auipc	ra,0x3
    3058:	ac0080e7          	jalr	-1344(ra) # 5b14 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    305c:	85a6                	mv	a1,s1
    305e:	00004517          	auipc	a0,0x4
    3062:	ff250513          	addi	a0,a0,-14 # 7050 <malloc+0x111a>
    3066:	00003097          	auipc	ra,0x3
    306a:	e14080e7          	jalr	-492(ra) # 5e7a <printf>
    exit(1);
    306e:	4505                	li	a0,1
    3070:	00003097          	auipc	ra,0x3
    3074:	aa4080e7          	jalr	-1372(ra) # 5b14 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    3078:	85a6                	mv	a1,s1
    307a:	00004517          	auipc	a0,0x4
    307e:	03e50513          	addi	a0,a0,62 # 70b8 <malloc+0x1182>
    3082:	00003097          	auipc	ra,0x3
    3086:	df8080e7          	jalr	-520(ra) # 5e7a <printf>
    exit(1);
    308a:	4505                	li	a0,1
    308c:	00003097          	auipc	ra,0x3
    3090:	a88080e7          	jalr	-1400(ra) # 5b14 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    3094:	85a6                	mv	a1,s1
    3096:	00004517          	auipc	a0,0x4
    309a:	09a50513          	addi	a0,a0,154 # 7130 <malloc+0x11fa>
    309e:	00003097          	auipc	ra,0x3
    30a2:	ddc080e7          	jalr	-548(ra) # 5e7a <printf>
    exit(1);
    30a6:	4505                	li	a0,1
    30a8:	00003097          	auipc	ra,0x3
    30ac:	a6c080e7          	jalr	-1428(ra) # 5b14 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    30b0:	85a6                	mv	a1,s1
    30b2:	00004517          	auipc	a0,0x4
    30b6:	0de50513          	addi	a0,a0,222 # 7190 <malloc+0x125a>
    30ba:	00003097          	auipc	ra,0x3
    30be:	dc0080e7          	jalr	-576(ra) # 5e7a <printf>
    exit(1);
    30c2:	4505                	li	a0,1
    30c4:	00003097          	auipc	ra,0x3
    30c8:	a50080e7          	jalr	-1456(ra) # 5b14 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    30cc:	85a6                	mv	a1,s1
    30ce:	00004517          	auipc	a0,0x4
    30d2:	11a50513          	addi	a0,a0,282 # 71e8 <malloc+0x12b2>
    30d6:	00003097          	auipc	ra,0x3
    30da:	da4080e7          	jalr	-604(ra) # 5e7a <printf>
    exit(1);
    30de:	4505                	li	a0,1
    30e0:	00003097          	auipc	ra,0x3
    30e4:	a34080e7          	jalr	-1484(ra) # 5b14 <exit>

00000000000030e8 <iputtest>:
{
    30e8:	1101                	addi	sp,sp,-32
    30ea:	ec06                	sd	ra,24(sp)
    30ec:	e822                	sd	s0,16(sp)
    30ee:	e426                	sd	s1,8(sp)
    30f0:	1000                	addi	s0,sp,32
    30f2:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    30f4:	00004517          	auipc	a0,0x4
    30f8:	12c50513          	addi	a0,a0,300 # 7220 <malloc+0x12ea>
    30fc:	00003097          	auipc	ra,0x3
    3100:	a80080e7          	jalr	-1408(ra) # 5b7c <mkdir>
    3104:	04054563          	bltz	a0,314e <iputtest+0x66>
  if(chdir("iputdir") < 0){
    3108:	00004517          	auipc	a0,0x4
    310c:	11850513          	addi	a0,a0,280 # 7220 <malloc+0x12ea>
    3110:	00003097          	auipc	ra,0x3
    3114:	a74080e7          	jalr	-1420(ra) # 5b84 <chdir>
    3118:	04054963          	bltz	a0,316a <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    311c:	00004517          	auipc	a0,0x4
    3120:	14450513          	addi	a0,a0,324 # 7260 <malloc+0x132a>
    3124:	00003097          	auipc	ra,0x3
    3128:	a40080e7          	jalr	-1472(ra) # 5b64 <unlink>
    312c:	04054d63          	bltz	a0,3186 <iputtest+0x9e>
  if(chdir("/") < 0){
    3130:	00004517          	auipc	a0,0x4
    3134:	16050513          	addi	a0,a0,352 # 7290 <malloc+0x135a>
    3138:	00003097          	auipc	ra,0x3
    313c:	a4c080e7          	jalr	-1460(ra) # 5b84 <chdir>
    3140:	06054163          	bltz	a0,31a2 <iputtest+0xba>
}
    3144:	60e2                	ld	ra,24(sp)
    3146:	6442                	ld	s0,16(sp)
    3148:	64a2                	ld	s1,8(sp)
    314a:	6105                	addi	sp,sp,32
    314c:	8082                	ret
    printf("%s: mkdir failed\n", s);
    314e:	85a6                	mv	a1,s1
    3150:	00004517          	auipc	a0,0x4
    3154:	0d850513          	addi	a0,a0,216 # 7228 <malloc+0x12f2>
    3158:	00003097          	auipc	ra,0x3
    315c:	d22080e7          	jalr	-734(ra) # 5e7a <printf>
    exit(1);
    3160:	4505                	li	a0,1
    3162:	00003097          	auipc	ra,0x3
    3166:	9b2080e7          	jalr	-1614(ra) # 5b14 <exit>
    printf("%s: chdir iputdir failed\n", s);
    316a:	85a6                	mv	a1,s1
    316c:	00004517          	auipc	a0,0x4
    3170:	0d450513          	addi	a0,a0,212 # 7240 <malloc+0x130a>
    3174:	00003097          	auipc	ra,0x3
    3178:	d06080e7          	jalr	-762(ra) # 5e7a <printf>
    exit(1);
    317c:	4505                	li	a0,1
    317e:	00003097          	auipc	ra,0x3
    3182:	996080e7          	jalr	-1642(ra) # 5b14 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    3186:	85a6                	mv	a1,s1
    3188:	00004517          	auipc	a0,0x4
    318c:	0e850513          	addi	a0,a0,232 # 7270 <malloc+0x133a>
    3190:	00003097          	auipc	ra,0x3
    3194:	cea080e7          	jalr	-790(ra) # 5e7a <printf>
    exit(1);
    3198:	4505                	li	a0,1
    319a:	00003097          	auipc	ra,0x3
    319e:	97a080e7          	jalr	-1670(ra) # 5b14 <exit>
    printf("%s: chdir / failed\n", s);
    31a2:	85a6                	mv	a1,s1
    31a4:	00004517          	auipc	a0,0x4
    31a8:	0f450513          	addi	a0,a0,244 # 7298 <malloc+0x1362>
    31ac:	00003097          	auipc	ra,0x3
    31b0:	cce080e7          	jalr	-818(ra) # 5e7a <printf>
    exit(1);
    31b4:	4505                	li	a0,1
    31b6:	00003097          	auipc	ra,0x3
    31ba:	95e080e7          	jalr	-1698(ra) # 5b14 <exit>

00000000000031be <exitiputtest>:
{
    31be:	7179                	addi	sp,sp,-48
    31c0:	f406                	sd	ra,40(sp)
    31c2:	f022                	sd	s0,32(sp)
    31c4:	ec26                	sd	s1,24(sp)
    31c6:	1800                	addi	s0,sp,48
    31c8:	84aa                	mv	s1,a0
  pid = fork();
    31ca:	00003097          	auipc	ra,0x3
    31ce:	942080e7          	jalr	-1726(ra) # 5b0c <fork>
  if(pid < 0){
    31d2:	04054663          	bltz	a0,321e <exitiputtest+0x60>
  if(pid == 0){
    31d6:	ed45                	bnez	a0,328e <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    31d8:	00004517          	auipc	a0,0x4
    31dc:	04850513          	addi	a0,a0,72 # 7220 <malloc+0x12ea>
    31e0:	00003097          	auipc	ra,0x3
    31e4:	99c080e7          	jalr	-1636(ra) # 5b7c <mkdir>
    31e8:	04054963          	bltz	a0,323a <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    31ec:	00004517          	auipc	a0,0x4
    31f0:	03450513          	addi	a0,a0,52 # 7220 <malloc+0x12ea>
    31f4:	00003097          	auipc	ra,0x3
    31f8:	990080e7          	jalr	-1648(ra) # 5b84 <chdir>
    31fc:	04054d63          	bltz	a0,3256 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    3200:	00004517          	auipc	a0,0x4
    3204:	06050513          	addi	a0,a0,96 # 7260 <malloc+0x132a>
    3208:	00003097          	auipc	ra,0x3
    320c:	95c080e7          	jalr	-1700(ra) # 5b64 <unlink>
    3210:	06054163          	bltz	a0,3272 <exitiputtest+0xb4>
    exit(0);
    3214:	4501                	li	a0,0
    3216:	00003097          	auipc	ra,0x3
    321a:	8fe080e7          	jalr	-1794(ra) # 5b14 <exit>
    printf("%s: fork failed\n", s);
    321e:	85a6                	mv	a1,s1
    3220:	00003517          	auipc	a0,0x3
    3224:	6a050513          	addi	a0,a0,1696 # 68c0 <malloc+0x98a>
    3228:	00003097          	auipc	ra,0x3
    322c:	c52080e7          	jalr	-942(ra) # 5e7a <printf>
    exit(1);
    3230:	4505                	li	a0,1
    3232:	00003097          	auipc	ra,0x3
    3236:	8e2080e7          	jalr	-1822(ra) # 5b14 <exit>
      printf("%s: mkdir failed\n", s);
    323a:	85a6                	mv	a1,s1
    323c:	00004517          	auipc	a0,0x4
    3240:	fec50513          	addi	a0,a0,-20 # 7228 <malloc+0x12f2>
    3244:	00003097          	auipc	ra,0x3
    3248:	c36080e7          	jalr	-970(ra) # 5e7a <printf>
      exit(1);
    324c:	4505                	li	a0,1
    324e:	00003097          	auipc	ra,0x3
    3252:	8c6080e7          	jalr	-1850(ra) # 5b14 <exit>
      printf("%s: child chdir failed\n", s);
    3256:	85a6                	mv	a1,s1
    3258:	00004517          	auipc	a0,0x4
    325c:	05850513          	addi	a0,a0,88 # 72b0 <malloc+0x137a>
    3260:	00003097          	auipc	ra,0x3
    3264:	c1a080e7          	jalr	-998(ra) # 5e7a <printf>
      exit(1);
    3268:	4505                	li	a0,1
    326a:	00003097          	auipc	ra,0x3
    326e:	8aa080e7          	jalr	-1878(ra) # 5b14 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    3272:	85a6                	mv	a1,s1
    3274:	00004517          	auipc	a0,0x4
    3278:	ffc50513          	addi	a0,a0,-4 # 7270 <malloc+0x133a>
    327c:	00003097          	auipc	ra,0x3
    3280:	bfe080e7          	jalr	-1026(ra) # 5e7a <printf>
      exit(1);
    3284:	4505                	li	a0,1
    3286:	00003097          	auipc	ra,0x3
    328a:	88e080e7          	jalr	-1906(ra) # 5b14 <exit>
  wait(&xstatus);
    328e:	fdc40513          	addi	a0,s0,-36
    3292:	00003097          	auipc	ra,0x3
    3296:	88a080e7          	jalr	-1910(ra) # 5b1c <wait>
  exit(xstatus);
    329a:	fdc42503          	lw	a0,-36(s0)
    329e:	00003097          	auipc	ra,0x3
    32a2:	876080e7          	jalr	-1930(ra) # 5b14 <exit>

00000000000032a6 <dirtest>:
{
    32a6:	1101                	addi	sp,sp,-32
    32a8:	ec06                	sd	ra,24(sp)
    32aa:	e822                	sd	s0,16(sp)
    32ac:	e426                	sd	s1,8(sp)
    32ae:	1000                	addi	s0,sp,32
    32b0:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    32b2:	00004517          	auipc	a0,0x4
    32b6:	01650513          	addi	a0,a0,22 # 72c8 <malloc+0x1392>
    32ba:	00003097          	auipc	ra,0x3
    32be:	8c2080e7          	jalr	-1854(ra) # 5b7c <mkdir>
    32c2:	04054563          	bltz	a0,330c <dirtest+0x66>
  if(chdir("dir0") < 0){
    32c6:	00004517          	auipc	a0,0x4
    32ca:	00250513          	addi	a0,a0,2 # 72c8 <malloc+0x1392>
    32ce:	00003097          	auipc	ra,0x3
    32d2:	8b6080e7          	jalr	-1866(ra) # 5b84 <chdir>
    32d6:	04054963          	bltz	a0,3328 <dirtest+0x82>
  if(chdir("..") < 0){
    32da:	00004517          	auipc	a0,0x4
    32de:	00e50513          	addi	a0,a0,14 # 72e8 <malloc+0x13b2>
    32e2:	00003097          	auipc	ra,0x3
    32e6:	8a2080e7          	jalr	-1886(ra) # 5b84 <chdir>
    32ea:	04054d63          	bltz	a0,3344 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    32ee:	00004517          	auipc	a0,0x4
    32f2:	fda50513          	addi	a0,a0,-38 # 72c8 <malloc+0x1392>
    32f6:	00003097          	auipc	ra,0x3
    32fa:	86e080e7          	jalr	-1938(ra) # 5b64 <unlink>
    32fe:	06054163          	bltz	a0,3360 <dirtest+0xba>
}
    3302:	60e2                	ld	ra,24(sp)
    3304:	6442                	ld	s0,16(sp)
    3306:	64a2                	ld	s1,8(sp)
    3308:	6105                	addi	sp,sp,32
    330a:	8082                	ret
    printf("%s: mkdir failed\n", s);
    330c:	85a6                	mv	a1,s1
    330e:	00004517          	auipc	a0,0x4
    3312:	f1a50513          	addi	a0,a0,-230 # 7228 <malloc+0x12f2>
    3316:	00003097          	auipc	ra,0x3
    331a:	b64080e7          	jalr	-1180(ra) # 5e7a <printf>
    exit(1);
    331e:	4505                	li	a0,1
    3320:	00002097          	auipc	ra,0x2
    3324:	7f4080e7          	jalr	2036(ra) # 5b14 <exit>
    printf("%s: chdir dir0 failed\n", s);
    3328:	85a6                	mv	a1,s1
    332a:	00004517          	auipc	a0,0x4
    332e:	fa650513          	addi	a0,a0,-90 # 72d0 <malloc+0x139a>
    3332:	00003097          	auipc	ra,0x3
    3336:	b48080e7          	jalr	-1208(ra) # 5e7a <printf>
    exit(1);
    333a:	4505                	li	a0,1
    333c:	00002097          	auipc	ra,0x2
    3340:	7d8080e7          	jalr	2008(ra) # 5b14 <exit>
    printf("%s: chdir .. failed\n", s);
    3344:	85a6                	mv	a1,s1
    3346:	00004517          	auipc	a0,0x4
    334a:	faa50513          	addi	a0,a0,-86 # 72f0 <malloc+0x13ba>
    334e:	00003097          	auipc	ra,0x3
    3352:	b2c080e7          	jalr	-1236(ra) # 5e7a <printf>
    exit(1);
    3356:	4505                	li	a0,1
    3358:	00002097          	auipc	ra,0x2
    335c:	7bc080e7          	jalr	1980(ra) # 5b14 <exit>
    printf("%s: unlink dir0 failed\n", s);
    3360:	85a6                	mv	a1,s1
    3362:	00004517          	auipc	a0,0x4
    3366:	fa650513          	addi	a0,a0,-90 # 7308 <malloc+0x13d2>
    336a:	00003097          	auipc	ra,0x3
    336e:	b10080e7          	jalr	-1264(ra) # 5e7a <printf>
    exit(1);
    3372:	4505                	li	a0,1
    3374:	00002097          	auipc	ra,0x2
    3378:	7a0080e7          	jalr	1952(ra) # 5b14 <exit>

000000000000337c <subdir>:
{
    337c:	1101                	addi	sp,sp,-32
    337e:	ec06                	sd	ra,24(sp)
    3380:	e822                	sd	s0,16(sp)
    3382:	e426                	sd	s1,8(sp)
    3384:	e04a                	sd	s2,0(sp)
    3386:	1000                	addi	s0,sp,32
    3388:	892a                	mv	s2,a0
  unlink("ff");
    338a:	00004517          	auipc	a0,0x4
    338e:	0c650513          	addi	a0,a0,198 # 7450 <malloc+0x151a>
    3392:	00002097          	auipc	ra,0x2
    3396:	7d2080e7          	jalr	2002(ra) # 5b64 <unlink>
  if(mkdir("dd") != 0){
    339a:	00004517          	auipc	a0,0x4
    339e:	f8650513          	addi	a0,a0,-122 # 7320 <malloc+0x13ea>
    33a2:	00002097          	auipc	ra,0x2
    33a6:	7da080e7          	jalr	2010(ra) # 5b7c <mkdir>
    33aa:	38051663          	bnez	a0,3736 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    33ae:	20200593          	li	a1,514
    33b2:	00004517          	auipc	a0,0x4
    33b6:	f8e50513          	addi	a0,a0,-114 # 7340 <malloc+0x140a>
    33ba:	00002097          	auipc	ra,0x2
    33be:	79a080e7          	jalr	1946(ra) # 5b54 <open>
    33c2:	84aa                	mv	s1,a0
  if(fd < 0){
    33c4:	38054763          	bltz	a0,3752 <subdir+0x3d6>
  write(fd, "ff", 2);
    33c8:	4609                	li	a2,2
    33ca:	00004597          	auipc	a1,0x4
    33ce:	08658593          	addi	a1,a1,134 # 7450 <malloc+0x151a>
    33d2:	00002097          	auipc	ra,0x2
    33d6:	762080e7          	jalr	1890(ra) # 5b34 <write>
  close(fd);
    33da:	8526                	mv	a0,s1
    33dc:	00002097          	auipc	ra,0x2
    33e0:	760080e7          	jalr	1888(ra) # 5b3c <close>
  if(unlink("dd") >= 0){
    33e4:	00004517          	auipc	a0,0x4
    33e8:	f3c50513          	addi	a0,a0,-196 # 7320 <malloc+0x13ea>
    33ec:	00002097          	auipc	ra,0x2
    33f0:	778080e7          	jalr	1912(ra) # 5b64 <unlink>
    33f4:	36055d63          	bgez	a0,376e <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    33f8:	00004517          	auipc	a0,0x4
    33fc:	fa050513          	addi	a0,a0,-96 # 7398 <malloc+0x1462>
    3400:	00002097          	auipc	ra,0x2
    3404:	77c080e7          	jalr	1916(ra) # 5b7c <mkdir>
    3408:	38051163          	bnez	a0,378a <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    340c:	20200593          	li	a1,514
    3410:	00004517          	auipc	a0,0x4
    3414:	fb050513          	addi	a0,a0,-80 # 73c0 <malloc+0x148a>
    3418:	00002097          	auipc	ra,0x2
    341c:	73c080e7          	jalr	1852(ra) # 5b54 <open>
    3420:	84aa                	mv	s1,a0
  if(fd < 0){
    3422:	38054263          	bltz	a0,37a6 <subdir+0x42a>
  write(fd, "FF", 2);
    3426:	4609                	li	a2,2
    3428:	00004597          	auipc	a1,0x4
    342c:	fc858593          	addi	a1,a1,-56 # 73f0 <malloc+0x14ba>
    3430:	00002097          	auipc	ra,0x2
    3434:	704080e7          	jalr	1796(ra) # 5b34 <write>
  close(fd);
    3438:	8526                	mv	a0,s1
    343a:	00002097          	auipc	ra,0x2
    343e:	702080e7          	jalr	1794(ra) # 5b3c <close>
  fd = open("dd/dd/../ff", 0);
    3442:	4581                	li	a1,0
    3444:	00004517          	auipc	a0,0x4
    3448:	fb450513          	addi	a0,a0,-76 # 73f8 <malloc+0x14c2>
    344c:	00002097          	auipc	ra,0x2
    3450:	708080e7          	jalr	1800(ra) # 5b54 <open>
    3454:	84aa                	mv	s1,a0
  if(fd < 0){
    3456:	36054663          	bltz	a0,37c2 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    345a:	660d                	lui	a2,0x3
    345c:	0000a597          	auipc	a1,0xa
    3460:	ff458593          	addi	a1,a1,-12 # d450 <buf>
    3464:	00002097          	auipc	ra,0x2
    3468:	6c8080e7          	jalr	1736(ra) # 5b2c <read>
  if(cc != 2 || buf[0] != 'f'){
    346c:	4789                	li	a5,2
    346e:	36f51863          	bne	a0,a5,37de <subdir+0x462>
    3472:	0000a717          	auipc	a4,0xa
    3476:	fde74703          	lbu	a4,-34(a4) # d450 <buf>
    347a:	06600793          	li	a5,102
    347e:	36f71063          	bne	a4,a5,37de <subdir+0x462>
  close(fd);
    3482:	8526                	mv	a0,s1
    3484:	00002097          	auipc	ra,0x2
    3488:	6b8080e7          	jalr	1720(ra) # 5b3c <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    348c:	00004597          	auipc	a1,0x4
    3490:	fbc58593          	addi	a1,a1,-68 # 7448 <malloc+0x1512>
    3494:	00004517          	auipc	a0,0x4
    3498:	f2c50513          	addi	a0,a0,-212 # 73c0 <malloc+0x148a>
    349c:	00002097          	auipc	ra,0x2
    34a0:	6d8080e7          	jalr	1752(ra) # 5b74 <link>
    34a4:	34051b63          	bnez	a0,37fa <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    34a8:	00004517          	auipc	a0,0x4
    34ac:	f1850513          	addi	a0,a0,-232 # 73c0 <malloc+0x148a>
    34b0:	00002097          	auipc	ra,0x2
    34b4:	6b4080e7          	jalr	1716(ra) # 5b64 <unlink>
    34b8:	34051f63          	bnez	a0,3816 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    34bc:	4581                	li	a1,0
    34be:	00004517          	auipc	a0,0x4
    34c2:	f0250513          	addi	a0,a0,-254 # 73c0 <malloc+0x148a>
    34c6:	00002097          	auipc	ra,0x2
    34ca:	68e080e7          	jalr	1678(ra) # 5b54 <open>
    34ce:	36055263          	bgez	a0,3832 <subdir+0x4b6>
  if(chdir("dd") != 0){
    34d2:	00004517          	auipc	a0,0x4
    34d6:	e4e50513          	addi	a0,a0,-434 # 7320 <malloc+0x13ea>
    34da:	00002097          	auipc	ra,0x2
    34de:	6aa080e7          	jalr	1706(ra) # 5b84 <chdir>
    34e2:	36051663          	bnez	a0,384e <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    34e6:	00004517          	auipc	a0,0x4
    34ea:	ffa50513          	addi	a0,a0,-6 # 74e0 <malloc+0x15aa>
    34ee:	00002097          	auipc	ra,0x2
    34f2:	696080e7          	jalr	1686(ra) # 5b84 <chdir>
    34f6:	36051a63          	bnez	a0,386a <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    34fa:	00004517          	auipc	a0,0x4
    34fe:	01650513          	addi	a0,a0,22 # 7510 <malloc+0x15da>
    3502:	00002097          	auipc	ra,0x2
    3506:	682080e7          	jalr	1666(ra) # 5b84 <chdir>
    350a:	36051e63          	bnez	a0,3886 <subdir+0x50a>
  if(chdir("./..") != 0){
    350e:	00004517          	auipc	a0,0x4
    3512:	03250513          	addi	a0,a0,50 # 7540 <malloc+0x160a>
    3516:	00002097          	auipc	ra,0x2
    351a:	66e080e7          	jalr	1646(ra) # 5b84 <chdir>
    351e:	38051263          	bnez	a0,38a2 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    3522:	4581                	li	a1,0
    3524:	00004517          	auipc	a0,0x4
    3528:	f2450513          	addi	a0,a0,-220 # 7448 <malloc+0x1512>
    352c:	00002097          	auipc	ra,0x2
    3530:	628080e7          	jalr	1576(ra) # 5b54 <open>
    3534:	84aa                	mv	s1,a0
  if(fd < 0){
    3536:	38054463          	bltz	a0,38be <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    353a:	660d                	lui	a2,0x3
    353c:	0000a597          	auipc	a1,0xa
    3540:	f1458593          	addi	a1,a1,-236 # d450 <buf>
    3544:	00002097          	auipc	ra,0x2
    3548:	5e8080e7          	jalr	1512(ra) # 5b2c <read>
    354c:	4789                	li	a5,2
    354e:	38f51663          	bne	a0,a5,38da <subdir+0x55e>
  close(fd);
    3552:	8526                	mv	a0,s1
    3554:	00002097          	auipc	ra,0x2
    3558:	5e8080e7          	jalr	1512(ra) # 5b3c <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    355c:	4581                	li	a1,0
    355e:	00004517          	auipc	a0,0x4
    3562:	e6250513          	addi	a0,a0,-414 # 73c0 <malloc+0x148a>
    3566:	00002097          	auipc	ra,0x2
    356a:	5ee080e7          	jalr	1518(ra) # 5b54 <open>
    356e:	38055463          	bgez	a0,38f6 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3572:	20200593          	li	a1,514
    3576:	00004517          	auipc	a0,0x4
    357a:	05a50513          	addi	a0,a0,90 # 75d0 <malloc+0x169a>
    357e:	00002097          	auipc	ra,0x2
    3582:	5d6080e7          	jalr	1494(ra) # 5b54 <open>
    3586:	38055663          	bgez	a0,3912 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    358a:	20200593          	li	a1,514
    358e:	00004517          	auipc	a0,0x4
    3592:	07250513          	addi	a0,a0,114 # 7600 <malloc+0x16ca>
    3596:	00002097          	auipc	ra,0x2
    359a:	5be080e7          	jalr	1470(ra) # 5b54 <open>
    359e:	38055863          	bgez	a0,392e <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    35a2:	20000593          	li	a1,512
    35a6:	00004517          	auipc	a0,0x4
    35aa:	d7a50513          	addi	a0,a0,-646 # 7320 <malloc+0x13ea>
    35ae:	00002097          	auipc	ra,0x2
    35b2:	5a6080e7          	jalr	1446(ra) # 5b54 <open>
    35b6:	38055a63          	bgez	a0,394a <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    35ba:	4589                	li	a1,2
    35bc:	00004517          	auipc	a0,0x4
    35c0:	d6450513          	addi	a0,a0,-668 # 7320 <malloc+0x13ea>
    35c4:	00002097          	auipc	ra,0x2
    35c8:	590080e7          	jalr	1424(ra) # 5b54 <open>
    35cc:	38055d63          	bgez	a0,3966 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    35d0:	4585                	li	a1,1
    35d2:	00004517          	auipc	a0,0x4
    35d6:	d4e50513          	addi	a0,a0,-690 # 7320 <malloc+0x13ea>
    35da:	00002097          	auipc	ra,0x2
    35de:	57a080e7          	jalr	1402(ra) # 5b54 <open>
    35e2:	3a055063          	bgez	a0,3982 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    35e6:	00004597          	auipc	a1,0x4
    35ea:	0aa58593          	addi	a1,a1,170 # 7690 <malloc+0x175a>
    35ee:	00004517          	auipc	a0,0x4
    35f2:	fe250513          	addi	a0,a0,-30 # 75d0 <malloc+0x169a>
    35f6:	00002097          	auipc	ra,0x2
    35fa:	57e080e7          	jalr	1406(ra) # 5b74 <link>
    35fe:	3a050063          	beqz	a0,399e <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3602:	00004597          	auipc	a1,0x4
    3606:	08e58593          	addi	a1,a1,142 # 7690 <malloc+0x175a>
    360a:	00004517          	auipc	a0,0x4
    360e:	ff650513          	addi	a0,a0,-10 # 7600 <malloc+0x16ca>
    3612:	00002097          	auipc	ra,0x2
    3616:	562080e7          	jalr	1378(ra) # 5b74 <link>
    361a:	3a050063          	beqz	a0,39ba <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    361e:	00004597          	auipc	a1,0x4
    3622:	e2a58593          	addi	a1,a1,-470 # 7448 <malloc+0x1512>
    3626:	00004517          	auipc	a0,0x4
    362a:	d1a50513          	addi	a0,a0,-742 # 7340 <malloc+0x140a>
    362e:	00002097          	auipc	ra,0x2
    3632:	546080e7          	jalr	1350(ra) # 5b74 <link>
    3636:	3a050063          	beqz	a0,39d6 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    363a:	00004517          	auipc	a0,0x4
    363e:	f9650513          	addi	a0,a0,-106 # 75d0 <malloc+0x169a>
    3642:	00002097          	auipc	ra,0x2
    3646:	53a080e7          	jalr	1338(ra) # 5b7c <mkdir>
    364a:	3a050463          	beqz	a0,39f2 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    364e:	00004517          	auipc	a0,0x4
    3652:	fb250513          	addi	a0,a0,-78 # 7600 <malloc+0x16ca>
    3656:	00002097          	auipc	ra,0x2
    365a:	526080e7          	jalr	1318(ra) # 5b7c <mkdir>
    365e:	3a050863          	beqz	a0,3a0e <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    3662:	00004517          	auipc	a0,0x4
    3666:	de650513          	addi	a0,a0,-538 # 7448 <malloc+0x1512>
    366a:	00002097          	auipc	ra,0x2
    366e:	512080e7          	jalr	1298(ra) # 5b7c <mkdir>
    3672:	3a050c63          	beqz	a0,3a2a <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    3676:	00004517          	auipc	a0,0x4
    367a:	f8a50513          	addi	a0,a0,-118 # 7600 <malloc+0x16ca>
    367e:	00002097          	auipc	ra,0x2
    3682:	4e6080e7          	jalr	1254(ra) # 5b64 <unlink>
    3686:	3c050063          	beqz	a0,3a46 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    368a:	00004517          	auipc	a0,0x4
    368e:	f4650513          	addi	a0,a0,-186 # 75d0 <malloc+0x169a>
    3692:	00002097          	auipc	ra,0x2
    3696:	4d2080e7          	jalr	1234(ra) # 5b64 <unlink>
    369a:	3c050463          	beqz	a0,3a62 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    369e:	00004517          	auipc	a0,0x4
    36a2:	ca250513          	addi	a0,a0,-862 # 7340 <malloc+0x140a>
    36a6:	00002097          	auipc	ra,0x2
    36aa:	4de080e7          	jalr	1246(ra) # 5b84 <chdir>
    36ae:	3c050863          	beqz	a0,3a7e <subdir+0x702>
  if(chdir("dd/xx") == 0){
    36b2:	00004517          	auipc	a0,0x4
    36b6:	12e50513          	addi	a0,a0,302 # 77e0 <malloc+0x18aa>
    36ba:	00002097          	auipc	ra,0x2
    36be:	4ca080e7          	jalr	1226(ra) # 5b84 <chdir>
    36c2:	3c050c63          	beqz	a0,3a9a <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    36c6:	00004517          	auipc	a0,0x4
    36ca:	d8250513          	addi	a0,a0,-638 # 7448 <malloc+0x1512>
    36ce:	00002097          	auipc	ra,0x2
    36d2:	496080e7          	jalr	1174(ra) # 5b64 <unlink>
    36d6:	3e051063          	bnez	a0,3ab6 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    36da:	00004517          	auipc	a0,0x4
    36de:	c6650513          	addi	a0,a0,-922 # 7340 <malloc+0x140a>
    36e2:	00002097          	auipc	ra,0x2
    36e6:	482080e7          	jalr	1154(ra) # 5b64 <unlink>
    36ea:	3e051463          	bnez	a0,3ad2 <subdir+0x756>
  if(unlink("dd") == 0){
    36ee:	00004517          	auipc	a0,0x4
    36f2:	c3250513          	addi	a0,a0,-974 # 7320 <malloc+0x13ea>
    36f6:	00002097          	auipc	ra,0x2
    36fa:	46e080e7          	jalr	1134(ra) # 5b64 <unlink>
    36fe:	3e050863          	beqz	a0,3aee <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3702:	00004517          	auipc	a0,0x4
    3706:	14e50513          	addi	a0,a0,334 # 7850 <malloc+0x191a>
    370a:	00002097          	auipc	ra,0x2
    370e:	45a080e7          	jalr	1114(ra) # 5b64 <unlink>
    3712:	3e054c63          	bltz	a0,3b0a <subdir+0x78e>
  if(unlink("dd") < 0){
    3716:	00004517          	auipc	a0,0x4
    371a:	c0a50513          	addi	a0,a0,-1014 # 7320 <malloc+0x13ea>
    371e:	00002097          	auipc	ra,0x2
    3722:	446080e7          	jalr	1094(ra) # 5b64 <unlink>
    3726:	40054063          	bltz	a0,3b26 <subdir+0x7aa>
}
    372a:	60e2                	ld	ra,24(sp)
    372c:	6442                	ld	s0,16(sp)
    372e:	64a2                	ld	s1,8(sp)
    3730:	6902                	ld	s2,0(sp)
    3732:	6105                	addi	sp,sp,32
    3734:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3736:	85ca                	mv	a1,s2
    3738:	00004517          	auipc	a0,0x4
    373c:	bf050513          	addi	a0,a0,-1040 # 7328 <malloc+0x13f2>
    3740:	00002097          	auipc	ra,0x2
    3744:	73a080e7          	jalr	1850(ra) # 5e7a <printf>
    exit(1);
    3748:	4505                	li	a0,1
    374a:	00002097          	auipc	ra,0x2
    374e:	3ca080e7          	jalr	970(ra) # 5b14 <exit>
    printf("%s: create dd/ff failed\n", s);
    3752:	85ca                	mv	a1,s2
    3754:	00004517          	auipc	a0,0x4
    3758:	bf450513          	addi	a0,a0,-1036 # 7348 <malloc+0x1412>
    375c:	00002097          	auipc	ra,0x2
    3760:	71e080e7          	jalr	1822(ra) # 5e7a <printf>
    exit(1);
    3764:	4505                	li	a0,1
    3766:	00002097          	auipc	ra,0x2
    376a:	3ae080e7          	jalr	942(ra) # 5b14 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    376e:	85ca                	mv	a1,s2
    3770:	00004517          	auipc	a0,0x4
    3774:	bf850513          	addi	a0,a0,-1032 # 7368 <malloc+0x1432>
    3778:	00002097          	auipc	ra,0x2
    377c:	702080e7          	jalr	1794(ra) # 5e7a <printf>
    exit(1);
    3780:	4505                	li	a0,1
    3782:	00002097          	auipc	ra,0x2
    3786:	392080e7          	jalr	914(ra) # 5b14 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    378a:	85ca                	mv	a1,s2
    378c:	00004517          	auipc	a0,0x4
    3790:	c1450513          	addi	a0,a0,-1004 # 73a0 <malloc+0x146a>
    3794:	00002097          	auipc	ra,0x2
    3798:	6e6080e7          	jalr	1766(ra) # 5e7a <printf>
    exit(1);
    379c:	4505                	li	a0,1
    379e:	00002097          	auipc	ra,0x2
    37a2:	376080e7          	jalr	886(ra) # 5b14 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    37a6:	85ca                	mv	a1,s2
    37a8:	00004517          	auipc	a0,0x4
    37ac:	c2850513          	addi	a0,a0,-984 # 73d0 <malloc+0x149a>
    37b0:	00002097          	auipc	ra,0x2
    37b4:	6ca080e7          	jalr	1738(ra) # 5e7a <printf>
    exit(1);
    37b8:	4505                	li	a0,1
    37ba:	00002097          	auipc	ra,0x2
    37be:	35a080e7          	jalr	858(ra) # 5b14 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    37c2:	85ca                	mv	a1,s2
    37c4:	00004517          	auipc	a0,0x4
    37c8:	c4450513          	addi	a0,a0,-956 # 7408 <malloc+0x14d2>
    37cc:	00002097          	auipc	ra,0x2
    37d0:	6ae080e7          	jalr	1710(ra) # 5e7a <printf>
    exit(1);
    37d4:	4505                	li	a0,1
    37d6:	00002097          	auipc	ra,0x2
    37da:	33e080e7          	jalr	830(ra) # 5b14 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    37de:	85ca                	mv	a1,s2
    37e0:	00004517          	auipc	a0,0x4
    37e4:	c4850513          	addi	a0,a0,-952 # 7428 <malloc+0x14f2>
    37e8:	00002097          	auipc	ra,0x2
    37ec:	692080e7          	jalr	1682(ra) # 5e7a <printf>
    exit(1);
    37f0:	4505                	li	a0,1
    37f2:	00002097          	auipc	ra,0x2
    37f6:	322080e7          	jalr	802(ra) # 5b14 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    37fa:	85ca                	mv	a1,s2
    37fc:	00004517          	auipc	a0,0x4
    3800:	c5c50513          	addi	a0,a0,-932 # 7458 <malloc+0x1522>
    3804:	00002097          	auipc	ra,0x2
    3808:	676080e7          	jalr	1654(ra) # 5e7a <printf>
    exit(1);
    380c:	4505                	li	a0,1
    380e:	00002097          	auipc	ra,0x2
    3812:	306080e7          	jalr	774(ra) # 5b14 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3816:	85ca                	mv	a1,s2
    3818:	00004517          	auipc	a0,0x4
    381c:	c6850513          	addi	a0,a0,-920 # 7480 <malloc+0x154a>
    3820:	00002097          	auipc	ra,0x2
    3824:	65a080e7          	jalr	1626(ra) # 5e7a <printf>
    exit(1);
    3828:	4505                	li	a0,1
    382a:	00002097          	auipc	ra,0x2
    382e:	2ea080e7          	jalr	746(ra) # 5b14 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3832:	85ca                	mv	a1,s2
    3834:	00004517          	auipc	a0,0x4
    3838:	c6c50513          	addi	a0,a0,-916 # 74a0 <malloc+0x156a>
    383c:	00002097          	auipc	ra,0x2
    3840:	63e080e7          	jalr	1598(ra) # 5e7a <printf>
    exit(1);
    3844:	4505                	li	a0,1
    3846:	00002097          	auipc	ra,0x2
    384a:	2ce080e7          	jalr	718(ra) # 5b14 <exit>
    printf("%s: chdir dd failed\n", s);
    384e:	85ca                	mv	a1,s2
    3850:	00004517          	auipc	a0,0x4
    3854:	c7850513          	addi	a0,a0,-904 # 74c8 <malloc+0x1592>
    3858:	00002097          	auipc	ra,0x2
    385c:	622080e7          	jalr	1570(ra) # 5e7a <printf>
    exit(1);
    3860:	4505                	li	a0,1
    3862:	00002097          	auipc	ra,0x2
    3866:	2b2080e7          	jalr	690(ra) # 5b14 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    386a:	85ca                	mv	a1,s2
    386c:	00004517          	auipc	a0,0x4
    3870:	c8450513          	addi	a0,a0,-892 # 74f0 <malloc+0x15ba>
    3874:	00002097          	auipc	ra,0x2
    3878:	606080e7          	jalr	1542(ra) # 5e7a <printf>
    exit(1);
    387c:	4505                	li	a0,1
    387e:	00002097          	auipc	ra,0x2
    3882:	296080e7          	jalr	662(ra) # 5b14 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3886:	85ca                	mv	a1,s2
    3888:	00004517          	auipc	a0,0x4
    388c:	c9850513          	addi	a0,a0,-872 # 7520 <malloc+0x15ea>
    3890:	00002097          	auipc	ra,0x2
    3894:	5ea080e7          	jalr	1514(ra) # 5e7a <printf>
    exit(1);
    3898:	4505                	li	a0,1
    389a:	00002097          	auipc	ra,0x2
    389e:	27a080e7          	jalr	634(ra) # 5b14 <exit>
    printf("%s: chdir ./.. failed\n", s);
    38a2:	85ca                	mv	a1,s2
    38a4:	00004517          	auipc	a0,0x4
    38a8:	ca450513          	addi	a0,a0,-860 # 7548 <malloc+0x1612>
    38ac:	00002097          	auipc	ra,0x2
    38b0:	5ce080e7          	jalr	1486(ra) # 5e7a <printf>
    exit(1);
    38b4:	4505                	li	a0,1
    38b6:	00002097          	auipc	ra,0x2
    38ba:	25e080e7          	jalr	606(ra) # 5b14 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    38be:	85ca                	mv	a1,s2
    38c0:	00004517          	auipc	a0,0x4
    38c4:	ca050513          	addi	a0,a0,-864 # 7560 <malloc+0x162a>
    38c8:	00002097          	auipc	ra,0x2
    38cc:	5b2080e7          	jalr	1458(ra) # 5e7a <printf>
    exit(1);
    38d0:	4505                	li	a0,1
    38d2:	00002097          	auipc	ra,0x2
    38d6:	242080e7          	jalr	578(ra) # 5b14 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    38da:	85ca                	mv	a1,s2
    38dc:	00004517          	auipc	a0,0x4
    38e0:	ca450513          	addi	a0,a0,-860 # 7580 <malloc+0x164a>
    38e4:	00002097          	auipc	ra,0x2
    38e8:	596080e7          	jalr	1430(ra) # 5e7a <printf>
    exit(1);
    38ec:	4505                	li	a0,1
    38ee:	00002097          	auipc	ra,0x2
    38f2:	226080e7          	jalr	550(ra) # 5b14 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    38f6:	85ca                	mv	a1,s2
    38f8:	00004517          	auipc	a0,0x4
    38fc:	ca850513          	addi	a0,a0,-856 # 75a0 <malloc+0x166a>
    3900:	00002097          	auipc	ra,0x2
    3904:	57a080e7          	jalr	1402(ra) # 5e7a <printf>
    exit(1);
    3908:	4505                	li	a0,1
    390a:	00002097          	auipc	ra,0x2
    390e:	20a080e7          	jalr	522(ra) # 5b14 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3912:	85ca                	mv	a1,s2
    3914:	00004517          	auipc	a0,0x4
    3918:	ccc50513          	addi	a0,a0,-820 # 75e0 <malloc+0x16aa>
    391c:	00002097          	auipc	ra,0x2
    3920:	55e080e7          	jalr	1374(ra) # 5e7a <printf>
    exit(1);
    3924:	4505                	li	a0,1
    3926:	00002097          	auipc	ra,0x2
    392a:	1ee080e7          	jalr	494(ra) # 5b14 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    392e:	85ca                	mv	a1,s2
    3930:	00004517          	auipc	a0,0x4
    3934:	ce050513          	addi	a0,a0,-800 # 7610 <malloc+0x16da>
    3938:	00002097          	auipc	ra,0x2
    393c:	542080e7          	jalr	1346(ra) # 5e7a <printf>
    exit(1);
    3940:	4505                	li	a0,1
    3942:	00002097          	auipc	ra,0x2
    3946:	1d2080e7          	jalr	466(ra) # 5b14 <exit>
    printf("%s: create dd succeeded!\n", s);
    394a:	85ca                	mv	a1,s2
    394c:	00004517          	auipc	a0,0x4
    3950:	ce450513          	addi	a0,a0,-796 # 7630 <malloc+0x16fa>
    3954:	00002097          	auipc	ra,0x2
    3958:	526080e7          	jalr	1318(ra) # 5e7a <printf>
    exit(1);
    395c:	4505                	li	a0,1
    395e:	00002097          	auipc	ra,0x2
    3962:	1b6080e7          	jalr	438(ra) # 5b14 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3966:	85ca                	mv	a1,s2
    3968:	00004517          	auipc	a0,0x4
    396c:	ce850513          	addi	a0,a0,-792 # 7650 <malloc+0x171a>
    3970:	00002097          	auipc	ra,0x2
    3974:	50a080e7          	jalr	1290(ra) # 5e7a <printf>
    exit(1);
    3978:	4505                	li	a0,1
    397a:	00002097          	auipc	ra,0x2
    397e:	19a080e7          	jalr	410(ra) # 5b14 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3982:	85ca                	mv	a1,s2
    3984:	00004517          	auipc	a0,0x4
    3988:	cec50513          	addi	a0,a0,-788 # 7670 <malloc+0x173a>
    398c:	00002097          	auipc	ra,0x2
    3990:	4ee080e7          	jalr	1262(ra) # 5e7a <printf>
    exit(1);
    3994:	4505                	li	a0,1
    3996:	00002097          	auipc	ra,0x2
    399a:	17e080e7          	jalr	382(ra) # 5b14 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    399e:	85ca                	mv	a1,s2
    39a0:	00004517          	auipc	a0,0x4
    39a4:	d0050513          	addi	a0,a0,-768 # 76a0 <malloc+0x176a>
    39a8:	00002097          	auipc	ra,0x2
    39ac:	4d2080e7          	jalr	1234(ra) # 5e7a <printf>
    exit(1);
    39b0:	4505                	li	a0,1
    39b2:	00002097          	auipc	ra,0x2
    39b6:	162080e7          	jalr	354(ra) # 5b14 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    39ba:	85ca                	mv	a1,s2
    39bc:	00004517          	auipc	a0,0x4
    39c0:	d0c50513          	addi	a0,a0,-756 # 76c8 <malloc+0x1792>
    39c4:	00002097          	auipc	ra,0x2
    39c8:	4b6080e7          	jalr	1206(ra) # 5e7a <printf>
    exit(1);
    39cc:	4505                	li	a0,1
    39ce:	00002097          	auipc	ra,0x2
    39d2:	146080e7          	jalr	326(ra) # 5b14 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    39d6:	85ca                	mv	a1,s2
    39d8:	00004517          	auipc	a0,0x4
    39dc:	d1850513          	addi	a0,a0,-744 # 76f0 <malloc+0x17ba>
    39e0:	00002097          	auipc	ra,0x2
    39e4:	49a080e7          	jalr	1178(ra) # 5e7a <printf>
    exit(1);
    39e8:	4505                	li	a0,1
    39ea:	00002097          	auipc	ra,0x2
    39ee:	12a080e7          	jalr	298(ra) # 5b14 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    39f2:	85ca                	mv	a1,s2
    39f4:	00004517          	auipc	a0,0x4
    39f8:	d2450513          	addi	a0,a0,-732 # 7718 <malloc+0x17e2>
    39fc:	00002097          	auipc	ra,0x2
    3a00:	47e080e7          	jalr	1150(ra) # 5e7a <printf>
    exit(1);
    3a04:	4505                	li	a0,1
    3a06:	00002097          	auipc	ra,0x2
    3a0a:	10e080e7          	jalr	270(ra) # 5b14 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3a0e:	85ca                	mv	a1,s2
    3a10:	00004517          	auipc	a0,0x4
    3a14:	d2850513          	addi	a0,a0,-728 # 7738 <malloc+0x1802>
    3a18:	00002097          	auipc	ra,0x2
    3a1c:	462080e7          	jalr	1122(ra) # 5e7a <printf>
    exit(1);
    3a20:	4505                	li	a0,1
    3a22:	00002097          	auipc	ra,0x2
    3a26:	0f2080e7          	jalr	242(ra) # 5b14 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3a2a:	85ca                	mv	a1,s2
    3a2c:	00004517          	auipc	a0,0x4
    3a30:	d2c50513          	addi	a0,a0,-724 # 7758 <malloc+0x1822>
    3a34:	00002097          	auipc	ra,0x2
    3a38:	446080e7          	jalr	1094(ra) # 5e7a <printf>
    exit(1);
    3a3c:	4505                	li	a0,1
    3a3e:	00002097          	auipc	ra,0x2
    3a42:	0d6080e7          	jalr	214(ra) # 5b14 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3a46:	85ca                	mv	a1,s2
    3a48:	00004517          	auipc	a0,0x4
    3a4c:	d3850513          	addi	a0,a0,-712 # 7780 <malloc+0x184a>
    3a50:	00002097          	auipc	ra,0x2
    3a54:	42a080e7          	jalr	1066(ra) # 5e7a <printf>
    exit(1);
    3a58:	4505                	li	a0,1
    3a5a:	00002097          	auipc	ra,0x2
    3a5e:	0ba080e7          	jalr	186(ra) # 5b14 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3a62:	85ca                	mv	a1,s2
    3a64:	00004517          	auipc	a0,0x4
    3a68:	d3c50513          	addi	a0,a0,-708 # 77a0 <malloc+0x186a>
    3a6c:	00002097          	auipc	ra,0x2
    3a70:	40e080e7          	jalr	1038(ra) # 5e7a <printf>
    exit(1);
    3a74:	4505                	li	a0,1
    3a76:	00002097          	auipc	ra,0x2
    3a7a:	09e080e7          	jalr	158(ra) # 5b14 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3a7e:	85ca                	mv	a1,s2
    3a80:	00004517          	auipc	a0,0x4
    3a84:	d4050513          	addi	a0,a0,-704 # 77c0 <malloc+0x188a>
    3a88:	00002097          	auipc	ra,0x2
    3a8c:	3f2080e7          	jalr	1010(ra) # 5e7a <printf>
    exit(1);
    3a90:	4505                	li	a0,1
    3a92:	00002097          	auipc	ra,0x2
    3a96:	082080e7          	jalr	130(ra) # 5b14 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3a9a:	85ca                	mv	a1,s2
    3a9c:	00004517          	auipc	a0,0x4
    3aa0:	d4c50513          	addi	a0,a0,-692 # 77e8 <malloc+0x18b2>
    3aa4:	00002097          	auipc	ra,0x2
    3aa8:	3d6080e7          	jalr	982(ra) # 5e7a <printf>
    exit(1);
    3aac:	4505                	li	a0,1
    3aae:	00002097          	auipc	ra,0x2
    3ab2:	066080e7          	jalr	102(ra) # 5b14 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3ab6:	85ca                	mv	a1,s2
    3ab8:	00004517          	auipc	a0,0x4
    3abc:	9c850513          	addi	a0,a0,-1592 # 7480 <malloc+0x154a>
    3ac0:	00002097          	auipc	ra,0x2
    3ac4:	3ba080e7          	jalr	954(ra) # 5e7a <printf>
    exit(1);
    3ac8:	4505                	li	a0,1
    3aca:	00002097          	auipc	ra,0x2
    3ace:	04a080e7          	jalr	74(ra) # 5b14 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3ad2:	85ca                	mv	a1,s2
    3ad4:	00004517          	auipc	a0,0x4
    3ad8:	d3450513          	addi	a0,a0,-716 # 7808 <malloc+0x18d2>
    3adc:	00002097          	auipc	ra,0x2
    3ae0:	39e080e7          	jalr	926(ra) # 5e7a <printf>
    exit(1);
    3ae4:	4505                	li	a0,1
    3ae6:	00002097          	auipc	ra,0x2
    3aea:	02e080e7          	jalr	46(ra) # 5b14 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3aee:	85ca                	mv	a1,s2
    3af0:	00004517          	auipc	a0,0x4
    3af4:	d3850513          	addi	a0,a0,-712 # 7828 <malloc+0x18f2>
    3af8:	00002097          	auipc	ra,0x2
    3afc:	382080e7          	jalr	898(ra) # 5e7a <printf>
    exit(1);
    3b00:	4505                	li	a0,1
    3b02:	00002097          	auipc	ra,0x2
    3b06:	012080e7          	jalr	18(ra) # 5b14 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3b0a:	85ca                	mv	a1,s2
    3b0c:	00004517          	auipc	a0,0x4
    3b10:	d4c50513          	addi	a0,a0,-692 # 7858 <malloc+0x1922>
    3b14:	00002097          	auipc	ra,0x2
    3b18:	366080e7          	jalr	870(ra) # 5e7a <printf>
    exit(1);
    3b1c:	4505                	li	a0,1
    3b1e:	00002097          	auipc	ra,0x2
    3b22:	ff6080e7          	jalr	-10(ra) # 5b14 <exit>
    printf("%s: unlink dd failed\n", s);
    3b26:	85ca                	mv	a1,s2
    3b28:	00004517          	auipc	a0,0x4
    3b2c:	d5050513          	addi	a0,a0,-688 # 7878 <malloc+0x1942>
    3b30:	00002097          	auipc	ra,0x2
    3b34:	34a080e7          	jalr	842(ra) # 5e7a <printf>
    exit(1);
    3b38:	4505                	li	a0,1
    3b3a:	00002097          	auipc	ra,0x2
    3b3e:	fda080e7          	jalr	-38(ra) # 5b14 <exit>

0000000000003b42 <rmdot>:
{
    3b42:	1101                	addi	sp,sp,-32
    3b44:	ec06                	sd	ra,24(sp)
    3b46:	e822                	sd	s0,16(sp)
    3b48:	e426                	sd	s1,8(sp)
    3b4a:	1000                	addi	s0,sp,32
    3b4c:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3b4e:	00004517          	auipc	a0,0x4
    3b52:	d4250513          	addi	a0,a0,-702 # 7890 <malloc+0x195a>
    3b56:	00002097          	auipc	ra,0x2
    3b5a:	026080e7          	jalr	38(ra) # 5b7c <mkdir>
    3b5e:	e549                	bnez	a0,3be8 <rmdot+0xa6>
  if(chdir("dots") != 0){
    3b60:	00004517          	auipc	a0,0x4
    3b64:	d3050513          	addi	a0,a0,-720 # 7890 <malloc+0x195a>
    3b68:	00002097          	auipc	ra,0x2
    3b6c:	01c080e7          	jalr	28(ra) # 5b84 <chdir>
    3b70:	e951                	bnez	a0,3c04 <rmdot+0xc2>
  if(unlink(".") == 0){
    3b72:	00003517          	auipc	a0,0x3
    3b76:	bae50513          	addi	a0,a0,-1106 # 6720 <malloc+0x7ea>
    3b7a:	00002097          	auipc	ra,0x2
    3b7e:	fea080e7          	jalr	-22(ra) # 5b64 <unlink>
    3b82:	cd59                	beqz	a0,3c20 <rmdot+0xde>
  if(unlink("..") == 0){
    3b84:	00003517          	auipc	a0,0x3
    3b88:	76450513          	addi	a0,a0,1892 # 72e8 <malloc+0x13b2>
    3b8c:	00002097          	auipc	ra,0x2
    3b90:	fd8080e7          	jalr	-40(ra) # 5b64 <unlink>
    3b94:	c545                	beqz	a0,3c3c <rmdot+0xfa>
  if(chdir("/") != 0){
    3b96:	00003517          	auipc	a0,0x3
    3b9a:	6fa50513          	addi	a0,a0,1786 # 7290 <malloc+0x135a>
    3b9e:	00002097          	auipc	ra,0x2
    3ba2:	fe6080e7          	jalr	-26(ra) # 5b84 <chdir>
    3ba6:	e94d                	bnez	a0,3c58 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3ba8:	00004517          	auipc	a0,0x4
    3bac:	d5050513          	addi	a0,a0,-688 # 78f8 <malloc+0x19c2>
    3bb0:	00002097          	auipc	ra,0x2
    3bb4:	fb4080e7          	jalr	-76(ra) # 5b64 <unlink>
    3bb8:	cd55                	beqz	a0,3c74 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3bba:	00004517          	auipc	a0,0x4
    3bbe:	d6650513          	addi	a0,a0,-666 # 7920 <malloc+0x19ea>
    3bc2:	00002097          	auipc	ra,0x2
    3bc6:	fa2080e7          	jalr	-94(ra) # 5b64 <unlink>
    3bca:	c179                	beqz	a0,3c90 <rmdot+0x14e>
  if(unlink("dots") != 0){
    3bcc:	00004517          	auipc	a0,0x4
    3bd0:	cc450513          	addi	a0,a0,-828 # 7890 <malloc+0x195a>
    3bd4:	00002097          	auipc	ra,0x2
    3bd8:	f90080e7          	jalr	-112(ra) # 5b64 <unlink>
    3bdc:	e961                	bnez	a0,3cac <rmdot+0x16a>
}
    3bde:	60e2                	ld	ra,24(sp)
    3be0:	6442                	ld	s0,16(sp)
    3be2:	64a2                	ld	s1,8(sp)
    3be4:	6105                	addi	sp,sp,32
    3be6:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3be8:	85a6                	mv	a1,s1
    3bea:	00004517          	auipc	a0,0x4
    3bee:	cae50513          	addi	a0,a0,-850 # 7898 <malloc+0x1962>
    3bf2:	00002097          	auipc	ra,0x2
    3bf6:	288080e7          	jalr	648(ra) # 5e7a <printf>
    exit(1);
    3bfa:	4505                	li	a0,1
    3bfc:	00002097          	auipc	ra,0x2
    3c00:	f18080e7          	jalr	-232(ra) # 5b14 <exit>
    printf("%s: chdir dots failed\n", s);
    3c04:	85a6                	mv	a1,s1
    3c06:	00004517          	auipc	a0,0x4
    3c0a:	caa50513          	addi	a0,a0,-854 # 78b0 <malloc+0x197a>
    3c0e:	00002097          	auipc	ra,0x2
    3c12:	26c080e7          	jalr	620(ra) # 5e7a <printf>
    exit(1);
    3c16:	4505                	li	a0,1
    3c18:	00002097          	auipc	ra,0x2
    3c1c:	efc080e7          	jalr	-260(ra) # 5b14 <exit>
    printf("%s: rm . worked!\n", s);
    3c20:	85a6                	mv	a1,s1
    3c22:	00004517          	auipc	a0,0x4
    3c26:	ca650513          	addi	a0,a0,-858 # 78c8 <malloc+0x1992>
    3c2a:	00002097          	auipc	ra,0x2
    3c2e:	250080e7          	jalr	592(ra) # 5e7a <printf>
    exit(1);
    3c32:	4505                	li	a0,1
    3c34:	00002097          	auipc	ra,0x2
    3c38:	ee0080e7          	jalr	-288(ra) # 5b14 <exit>
    printf("%s: rm .. worked!\n", s);
    3c3c:	85a6                	mv	a1,s1
    3c3e:	00004517          	auipc	a0,0x4
    3c42:	ca250513          	addi	a0,a0,-862 # 78e0 <malloc+0x19aa>
    3c46:	00002097          	auipc	ra,0x2
    3c4a:	234080e7          	jalr	564(ra) # 5e7a <printf>
    exit(1);
    3c4e:	4505                	li	a0,1
    3c50:	00002097          	auipc	ra,0x2
    3c54:	ec4080e7          	jalr	-316(ra) # 5b14 <exit>
    printf("%s: chdir / failed\n", s);
    3c58:	85a6                	mv	a1,s1
    3c5a:	00003517          	auipc	a0,0x3
    3c5e:	63e50513          	addi	a0,a0,1598 # 7298 <malloc+0x1362>
    3c62:	00002097          	auipc	ra,0x2
    3c66:	218080e7          	jalr	536(ra) # 5e7a <printf>
    exit(1);
    3c6a:	4505                	li	a0,1
    3c6c:	00002097          	auipc	ra,0x2
    3c70:	ea8080e7          	jalr	-344(ra) # 5b14 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3c74:	85a6                	mv	a1,s1
    3c76:	00004517          	auipc	a0,0x4
    3c7a:	c8a50513          	addi	a0,a0,-886 # 7900 <malloc+0x19ca>
    3c7e:	00002097          	auipc	ra,0x2
    3c82:	1fc080e7          	jalr	508(ra) # 5e7a <printf>
    exit(1);
    3c86:	4505                	li	a0,1
    3c88:	00002097          	auipc	ra,0x2
    3c8c:	e8c080e7          	jalr	-372(ra) # 5b14 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3c90:	85a6                	mv	a1,s1
    3c92:	00004517          	auipc	a0,0x4
    3c96:	c9650513          	addi	a0,a0,-874 # 7928 <malloc+0x19f2>
    3c9a:	00002097          	auipc	ra,0x2
    3c9e:	1e0080e7          	jalr	480(ra) # 5e7a <printf>
    exit(1);
    3ca2:	4505                	li	a0,1
    3ca4:	00002097          	auipc	ra,0x2
    3ca8:	e70080e7          	jalr	-400(ra) # 5b14 <exit>
    printf("%s: unlink dots failed!\n", s);
    3cac:	85a6                	mv	a1,s1
    3cae:	00004517          	auipc	a0,0x4
    3cb2:	c9a50513          	addi	a0,a0,-870 # 7948 <malloc+0x1a12>
    3cb6:	00002097          	auipc	ra,0x2
    3cba:	1c4080e7          	jalr	452(ra) # 5e7a <printf>
    exit(1);
    3cbe:	4505                	li	a0,1
    3cc0:	00002097          	auipc	ra,0x2
    3cc4:	e54080e7          	jalr	-428(ra) # 5b14 <exit>

0000000000003cc8 <dirfile>:
{
    3cc8:	1101                	addi	sp,sp,-32
    3cca:	ec06                	sd	ra,24(sp)
    3ccc:	e822                	sd	s0,16(sp)
    3cce:	e426                	sd	s1,8(sp)
    3cd0:	e04a                	sd	s2,0(sp)
    3cd2:	1000                	addi	s0,sp,32
    3cd4:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3cd6:	20000593          	li	a1,512
    3cda:	00004517          	auipc	a0,0x4
    3cde:	c8e50513          	addi	a0,a0,-882 # 7968 <malloc+0x1a32>
    3ce2:	00002097          	auipc	ra,0x2
    3ce6:	e72080e7          	jalr	-398(ra) # 5b54 <open>
  if(fd < 0){
    3cea:	0e054d63          	bltz	a0,3de4 <dirfile+0x11c>
  close(fd);
    3cee:	00002097          	auipc	ra,0x2
    3cf2:	e4e080e7          	jalr	-434(ra) # 5b3c <close>
  if(chdir("dirfile") == 0){
    3cf6:	00004517          	auipc	a0,0x4
    3cfa:	c7250513          	addi	a0,a0,-910 # 7968 <malloc+0x1a32>
    3cfe:	00002097          	auipc	ra,0x2
    3d02:	e86080e7          	jalr	-378(ra) # 5b84 <chdir>
    3d06:	cd6d                	beqz	a0,3e00 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    3d08:	4581                	li	a1,0
    3d0a:	00004517          	auipc	a0,0x4
    3d0e:	ca650513          	addi	a0,a0,-858 # 79b0 <malloc+0x1a7a>
    3d12:	00002097          	auipc	ra,0x2
    3d16:	e42080e7          	jalr	-446(ra) # 5b54 <open>
  if(fd >= 0){
    3d1a:	10055163          	bgez	a0,3e1c <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    3d1e:	20000593          	li	a1,512
    3d22:	00004517          	auipc	a0,0x4
    3d26:	c8e50513          	addi	a0,a0,-882 # 79b0 <malloc+0x1a7a>
    3d2a:	00002097          	auipc	ra,0x2
    3d2e:	e2a080e7          	jalr	-470(ra) # 5b54 <open>
  if(fd >= 0){
    3d32:	10055363          	bgez	a0,3e38 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    3d36:	00004517          	auipc	a0,0x4
    3d3a:	c7a50513          	addi	a0,a0,-902 # 79b0 <malloc+0x1a7a>
    3d3e:	00002097          	auipc	ra,0x2
    3d42:	e3e080e7          	jalr	-450(ra) # 5b7c <mkdir>
    3d46:	10050763          	beqz	a0,3e54 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    3d4a:	00004517          	auipc	a0,0x4
    3d4e:	c6650513          	addi	a0,a0,-922 # 79b0 <malloc+0x1a7a>
    3d52:	00002097          	auipc	ra,0x2
    3d56:	e12080e7          	jalr	-494(ra) # 5b64 <unlink>
    3d5a:	10050b63          	beqz	a0,3e70 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    3d5e:	00004597          	auipc	a1,0x4
    3d62:	c5258593          	addi	a1,a1,-942 # 79b0 <malloc+0x1a7a>
    3d66:	00002517          	auipc	a0,0x2
    3d6a:	4aa50513          	addi	a0,a0,1194 # 6210 <malloc+0x2da>
    3d6e:	00002097          	auipc	ra,0x2
    3d72:	e06080e7          	jalr	-506(ra) # 5b74 <link>
    3d76:	10050b63          	beqz	a0,3e8c <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    3d7a:	00004517          	auipc	a0,0x4
    3d7e:	bee50513          	addi	a0,a0,-1042 # 7968 <malloc+0x1a32>
    3d82:	00002097          	auipc	ra,0x2
    3d86:	de2080e7          	jalr	-542(ra) # 5b64 <unlink>
    3d8a:	10051f63          	bnez	a0,3ea8 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    3d8e:	4589                	li	a1,2
    3d90:	00003517          	auipc	a0,0x3
    3d94:	99050513          	addi	a0,a0,-1648 # 6720 <malloc+0x7ea>
    3d98:	00002097          	auipc	ra,0x2
    3d9c:	dbc080e7          	jalr	-580(ra) # 5b54 <open>
  if(fd >= 0){
    3da0:	12055263          	bgez	a0,3ec4 <dirfile+0x1fc>
  fd = open(".", 0);
    3da4:	4581                	li	a1,0
    3da6:	00003517          	auipc	a0,0x3
    3daa:	97a50513          	addi	a0,a0,-1670 # 6720 <malloc+0x7ea>
    3dae:	00002097          	auipc	ra,0x2
    3db2:	da6080e7          	jalr	-602(ra) # 5b54 <open>
    3db6:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3db8:	4605                	li	a2,1
    3dba:	00002597          	auipc	a1,0x2
    3dbe:	31e58593          	addi	a1,a1,798 # 60d8 <malloc+0x1a2>
    3dc2:	00002097          	auipc	ra,0x2
    3dc6:	d72080e7          	jalr	-654(ra) # 5b34 <write>
    3dca:	10a04b63          	bgtz	a0,3ee0 <dirfile+0x218>
  close(fd);
    3dce:	8526                	mv	a0,s1
    3dd0:	00002097          	auipc	ra,0x2
    3dd4:	d6c080e7          	jalr	-660(ra) # 5b3c <close>
}
    3dd8:	60e2                	ld	ra,24(sp)
    3dda:	6442                	ld	s0,16(sp)
    3ddc:	64a2                	ld	s1,8(sp)
    3dde:	6902                	ld	s2,0(sp)
    3de0:	6105                	addi	sp,sp,32
    3de2:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3de4:	85ca                	mv	a1,s2
    3de6:	00004517          	auipc	a0,0x4
    3dea:	b8a50513          	addi	a0,a0,-1142 # 7970 <malloc+0x1a3a>
    3dee:	00002097          	auipc	ra,0x2
    3df2:	08c080e7          	jalr	140(ra) # 5e7a <printf>
    exit(1);
    3df6:	4505                	li	a0,1
    3df8:	00002097          	auipc	ra,0x2
    3dfc:	d1c080e7          	jalr	-740(ra) # 5b14 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    3e00:	85ca                	mv	a1,s2
    3e02:	00004517          	auipc	a0,0x4
    3e06:	b8e50513          	addi	a0,a0,-1138 # 7990 <malloc+0x1a5a>
    3e0a:	00002097          	auipc	ra,0x2
    3e0e:	070080e7          	jalr	112(ra) # 5e7a <printf>
    exit(1);
    3e12:	4505                	li	a0,1
    3e14:	00002097          	auipc	ra,0x2
    3e18:	d00080e7          	jalr	-768(ra) # 5b14 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3e1c:	85ca                	mv	a1,s2
    3e1e:	00004517          	auipc	a0,0x4
    3e22:	ba250513          	addi	a0,a0,-1118 # 79c0 <malloc+0x1a8a>
    3e26:	00002097          	auipc	ra,0x2
    3e2a:	054080e7          	jalr	84(ra) # 5e7a <printf>
    exit(1);
    3e2e:	4505                	li	a0,1
    3e30:	00002097          	auipc	ra,0x2
    3e34:	ce4080e7          	jalr	-796(ra) # 5b14 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3e38:	85ca                	mv	a1,s2
    3e3a:	00004517          	auipc	a0,0x4
    3e3e:	b8650513          	addi	a0,a0,-1146 # 79c0 <malloc+0x1a8a>
    3e42:	00002097          	auipc	ra,0x2
    3e46:	038080e7          	jalr	56(ra) # 5e7a <printf>
    exit(1);
    3e4a:	4505                	li	a0,1
    3e4c:	00002097          	auipc	ra,0x2
    3e50:	cc8080e7          	jalr	-824(ra) # 5b14 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3e54:	85ca                	mv	a1,s2
    3e56:	00004517          	auipc	a0,0x4
    3e5a:	b9250513          	addi	a0,a0,-1134 # 79e8 <malloc+0x1ab2>
    3e5e:	00002097          	auipc	ra,0x2
    3e62:	01c080e7          	jalr	28(ra) # 5e7a <printf>
    exit(1);
    3e66:	4505                	li	a0,1
    3e68:	00002097          	auipc	ra,0x2
    3e6c:	cac080e7          	jalr	-852(ra) # 5b14 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3e70:	85ca                	mv	a1,s2
    3e72:	00004517          	auipc	a0,0x4
    3e76:	b9e50513          	addi	a0,a0,-1122 # 7a10 <malloc+0x1ada>
    3e7a:	00002097          	auipc	ra,0x2
    3e7e:	000080e7          	jalr	ra # 5e7a <printf>
    exit(1);
    3e82:	4505                	li	a0,1
    3e84:	00002097          	auipc	ra,0x2
    3e88:	c90080e7          	jalr	-880(ra) # 5b14 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3e8c:	85ca                	mv	a1,s2
    3e8e:	00004517          	auipc	a0,0x4
    3e92:	baa50513          	addi	a0,a0,-1110 # 7a38 <malloc+0x1b02>
    3e96:	00002097          	auipc	ra,0x2
    3e9a:	fe4080e7          	jalr	-28(ra) # 5e7a <printf>
    exit(1);
    3e9e:	4505                	li	a0,1
    3ea0:	00002097          	auipc	ra,0x2
    3ea4:	c74080e7          	jalr	-908(ra) # 5b14 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3ea8:	85ca                	mv	a1,s2
    3eaa:	00004517          	auipc	a0,0x4
    3eae:	bb650513          	addi	a0,a0,-1098 # 7a60 <malloc+0x1b2a>
    3eb2:	00002097          	auipc	ra,0x2
    3eb6:	fc8080e7          	jalr	-56(ra) # 5e7a <printf>
    exit(1);
    3eba:	4505                	li	a0,1
    3ebc:	00002097          	auipc	ra,0x2
    3ec0:	c58080e7          	jalr	-936(ra) # 5b14 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3ec4:	85ca                	mv	a1,s2
    3ec6:	00004517          	auipc	a0,0x4
    3eca:	bba50513          	addi	a0,a0,-1094 # 7a80 <malloc+0x1b4a>
    3ece:	00002097          	auipc	ra,0x2
    3ed2:	fac080e7          	jalr	-84(ra) # 5e7a <printf>
    exit(1);
    3ed6:	4505                	li	a0,1
    3ed8:	00002097          	auipc	ra,0x2
    3edc:	c3c080e7          	jalr	-964(ra) # 5b14 <exit>
    printf("%s: write . succeeded!\n", s);
    3ee0:	85ca                	mv	a1,s2
    3ee2:	00004517          	auipc	a0,0x4
    3ee6:	bc650513          	addi	a0,a0,-1082 # 7aa8 <malloc+0x1b72>
    3eea:	00002097          	auipc	ra,0x2
    3eee:	f90080e7          	jalr	-112(ra) # 5e7a <printf>
    exit(1);
    3ef2:	4505                	li	a0,1
    3ef4:	00002097          	auipc	ra,0x2
    3ef8:	c20080e7          	jalr	-992(ra) # 5b14 <exit>

0000000000003efc <iref>:
{
    3efc:	715d                	addi	sp,sp,-80
    3efe:	e486                	sd	ra,72(sp)
    3f00:	e0a2                	sd	s0,64(sp)
    3f02:	fc26                	sd	s1,56(sp)
    3f04:	f84a                	sd	s2,48(sp)
    3f06:	f44e                	sd	s3,40(sp)
    3f08:	f052                	sd	s4,32(sp)
    3f0a:	ec56                	sd	s5,24(sp)
    3f0c:	e85a                	sd	s6,16(sp)
    3f0e:	e45e                	sd	s7,8(sp)
    3f10:	0880                	addi	s0,sp,80
    3f12:	8baa                	mv	s7,a0
    3f14:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    3f18:	00004a97          	auipc	s5,0x4
    3f1c:	ba8a8a93          	addi	s5,s5,-1112 # 7ac0 <malloc+0x1b8a>
    mkdir("");
    3f20:	00003497          	auipc	s1,0x3
    3f24:	6a848493          	addi	s1,s1,1704 # 75c8 <malloc+0x1692>
    link("README", "");
    3f28:	00002b17          	auipc	s6,0x2
    3f2c:	2e8b0b13          	addi	s6,s6,744 # 6210 <malloc+0x2da>
    fd = open("", O_CREATE);
    3f30:	20000a13          	li	s4,512
    fd = open("xx", O_CREATE);
    3f34:	00004997          	auipc	s3,0x4
    3f38:	a8498993          	addi	s3,s3,-1404 # 79b8 <malloc+0x1a82>
    3f3c:	a891                	j	3f90 <iref+0x94>
      printf("%s: mkdir irefd failed\n", s);
    3f3e:	85de                	mv	a1,s7
    3f40:	00004517          	auipc	a0,0x4
    3f44:	b8850513          	addi	a0,a0,-1144 # 7ac8 <malloc+0x1b92>
    3f48:	00002097          	auipc	ra,0x2
    3f4c:	f32080e7          	jalr	-206(ra) # 5e7a <printf>
      exit(1);
    3f50:	4505                	li	a0,1
    3f52:	00002097          	auipc	ra,0x2
    3f56:	bc2080e7          	jalr	-1086(ra) # 5b14 <exit>
      printf("%s: chdir irefd failed\n", s);
    3f5a:	85de                	mv	a1,s7
    3f5c:	00004517          	auipc	a0,0x4
    3f60:	b8450513          	addi	a0,a0,-1148 # 7ae0 <malloc+0x1baa>
    3f64:	00002097          	auipc	ra,0x2
    3f68:	f16080e7          	jalr	-234(ra) # 5e7a <printf>
      exit(1);
    3f6c:	4505                	li	a0,1
    3f6e:	00002097          	auipc	ra,0x2
    3f72:	ba6080e7          	jalr	-1114(ra) # 5b14 <exit>
      close(fd);
    3f76:	00002097          	auipc	ra,0x2
    3f7a:	bc6080e7          	jalr	-1082(ra) # 5b3c <close>
    3f7e:	a881                	j	3fce <iref+0xd2>
    unlink("xx");
    3f80:	854e                	mv	a0,s3
    3f82:	00002097          	auipc	ra,0x2
    3f86:	be2080e7          	jalr	-1054(ra) # 5b64 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3f8a:	397d                	addiw	s2,s2,-1
    3f8c:	04090e63          	beqz	s2,3fe8 <iref+0xec>
    if(mkdir("irefd") != 0){
    3f90:	8556                	mv	a0,s5
    3f92:	00002097          	auipc	ra,0x2
    3f96:	bea080e7          	jalr	-1046(ra) # 5b7c <mkdir>
    3f9a:	f155                	bnez	a0,3f3e <iref+0x42>
    if(chdir("irefd") != 0){
    3f9c:	8556                	mv	a0,s5
    3f9e:	00002097          	auipc	ra,0x2
    3fa2:	be6080e7          	jalr	-1050(ra) # 5b84 <chdir>
    3fa6:	f955                	bnez	a0,3f5a <iref+0x5e>
    mkdir("");
    3fa8:	8526                	mv	a0,s1
    3faa:	00002097          	auipc	ra,0x2
    3fae:	bd2080e7          	jalr	-1070(ra) # 5b7c <mkdir>
    link("README", "");
    3fb2:	85a6                	mv	a1,s1
    3fb4:	855a                	mv	a0,s6
    3fb6:	00002097          	auipc	ra,0x2
    3fba:	bbe080e7          	jalr	-1090(ra) # 5b74 <link>
    fd = open("", O_CREATE);
    3fbe:	85d2                	mv	a1,s4
    3fc0:	8526                	mv	a0,s1
    3fc2:	00002097          	auipc	ra,0x2
    3fc6:	b92080e7          	jalr	-1134(ra) # 5b54 <open>
    if(fd >= 0)
    3fca:	fa0556e3          	bgez	a0,3f76 <iref+0x7a>
    fd = open("xx", O_CREATE);
    3fce:	85d2                	mv	a1,s4
    3fd0:	854e                	mv	a0,s3
    3fd2:	00002097          	auipc	ra,0x2
    3fd6:	b82080e7          	jalr	-1150(ra) # 5b54 <open>
    if(fd >= 0)
    3fda:	fa0543e3          	bltz	a0,3f80 <iref+0x84>
      close(fd);
    3fde:	00002097          	auipc	ra,0x2
    3fe2:	b5e080e7          	jalr	-1186(ra) # 5b3c <close>
    3fe6:	bf69                	j	3f80 <iref+0x84>
    3fe8:	03300493          	li	s1,51
    chdir("..");
    3fec:	00003997          	auipc	s3,0x3
    3ff0:	2fc98993          	addi	s3,s3,764 # 72e8 <malloc+0x13b2>
    unlink("irefd");
    3ff4:	00004917          	auipc	s2,0x4
    3ff8:	acc90913          	addi	s2,s2,-1332 # 7ac0 <malloc+0x1b8a>
    chdir("..");
    3ffc:	854e                	mv	a0,s3
    3ffe:	00002097          	auipc	ra,0x2
    4002:	b86080e7          	jalr	-1146(ra) # 5b84 <chdir>
    unlink("irefd");
    4006:	854a                	mv	a0,s2
    4008:	00002097          	auipc	ra,0x2
    400c:	b5c080e7          	jalr	-1188(ra) # 5b64 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4010:	34fd                	addiw	s1,s1,-1
    4012:	f4ed                	bnez	s1,3ffc <iref+0x100>
  chdir("/");
    4014:	00003517          	auipc	a0,0x3
    4018:	27c50513          	addi	a0,a0,636 # 7290 <malloc+0x135a>
    401c:	00002097          	auipc	ra,0x2
    4020:	b68080e7          	jalr	-1176(ra) # 5b84 <chdir>
}
    4024:	60a6                	ld	ra,72(sp)
    4026:	6406                	ld	s0,64(sp)
    4028:	74e2                	ld	s1,56(sp)
    402a:	7942                	ld	s2,48(sp)
    402c:	79a2                	ld	s3,40(sp)
    402e:	7a02                	ld	s4,32(sp)
    4030:	6ae2                	ld	s5,24(sp)
    4032:	6b42                	ld	s6,16(sp)
    4034:	6ba2                	ld	s7,8(sp)
    4036:	6161                	addi	sp,sp,80
    4038:	8082                	ret

000000000000403a <openiputtest>:
{
    403a:	7179                	addi	sp,sp,-48
    403c:	f406                	sd	ra,40(sp)
    403e:	f022                	sd	s0,32(sp)
    4040:	ec26                	sd	s1,24(sp)
    4042:	1800                	addi	s0,sp,48
    4044:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    4046:	00004517          	auipc	a0,0x4
    404a:	ab250513          	addi	a0,a0,-1358 # 7af8 <malloc+0x1bc2>
    404e:	00002097          	auipc	ra,0x2
    4052:	b2e080e7          	jalr	-1234(ra) # 5b7c <mkdir>
    4056:	04054263          	bltz	a0,409a <openiputtest+0x60>
  pid = fork();
    405a:	00002097          	auipc	ra,0x2
    405e:	ab2080e7          	jalr	-1358(ra) # 5b0c <fork>
  if(pid < 0){
    4062:	04054a63          	bltz	a0,40b6 <openiputtest+0x7c>
  if(pid == 0){
    4066:	e93d                	bnez	a0,40dc <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    4068:	4589                	li	a1,2
    406a:	00004517          	auipc	a0,0x4
    406e:	a8e50513          	addi	a0,a0,-1394 # 7af8 <malloc+0x1bc2>
    4072:	00002097          	auipc	ra,0x2
    4076:	ae2080e7          	jalr	-1310(ra) # 5b54 <open>
    if(fd >= 0){
    407a:	04054c63          	bltz	a0,40d2 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    407e:	85a6                	mv	a1,s1
    4080:	00004517          	auipc	a0,0x4
    4084:	a9850513          	addi	a0,a0,-1384 # 7b18 <malloc+0x1be2>
    4088:	00002097          	auipc	ra,0x2
    408c:	df2080e7          	jalr	-526(ra) # 5e7a <printf>
      exit(1);
    4090:	4505                	li	a0,1
    4092:	00002097          	auipc	ra,0x2
    4096:	a82080e7          	jalr	-1406(ra) # 5b14 <exit>
    printf("%s: mkdir oidir failed\n", s);
    409a:	85a6                	mv	a1,s1
    409c:	00004517          	auipc	a0,0x4
    40a0:	a6450513          	addi	a0,a0,-1436 # 7b00 <malloc+0x1bca>
    40a4:	00002097          	auipc	ra,0x2
    40a8:	dd6080e7          	jalr	-554(ra) # 5e7a <printf>
    exit(1);
    40ac:	4505                	li	a0,1
    40ae:	00002097          	auipc	ra,0x2
    40b2:	a66080e7          	jalr	-1434(ra) # 5b14 <exit>
    printf("%s: fork failed\n", s);
    40b6:	85a6                	mv	a1,s1
    40b8:	00003517          	auipc	a0,0x3
    40bc:	80850513          	addi	a0,a0,-2040 # 68c0 <malloc+0x98a>
    40c0:	00002097          	auipc	ra,0x2
    40c4:	dba080e7          	jalr	-582(ra) # 5e7a <printf>
    exit(1);
    40c8:	4505                	li	a0,1
    40ca:	00002097          	auipc	ra,0x2
    40ce:	a4a080e7          	jalr	-1462(ra) # 5b14 <exit>
    exit(0);
    40d2:	4501                	li	a0,0
    40d4:	00002097          	auipc	ra,0x2
    40d8:	a40080e7          	jalr	-1472(ra) # 5b14 <exit>
  sleep(1);
    40dc:	4505                	li	a0,1
    40de:	00002097          	auipc	ra,0x2
    40e2:	ac6080e7          	jalr	-1338(ra) # 5ba4 <sleep>
  if(unlink("oidir") != 0){
    40e6:	00004517          	auipc	a0,0x4
    40ea:	a1250513          	addi	a0,a0,-1518 # 7af8 <malloc+0x1bc2>
    40ee:	00002097          	auipc	ra,0x2
    40f2:	a76080e7          	jalr	-1418(ra) # 5b64 <unlink>
    40f6:	cd19                	beqz	a0,4114 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    40f8:	85a6                	mv	a1,s1
    40fa:	00003517          	auipc	a0,0x3
    40fe:	9b650513          	addi	a0,a0,-1610 # 6ab0 <malloc+0xb7a>
    4102:	00002097          	auipc	ra,0x2
    4106:	d78080e7          	jalr	-648(ra) # 5e7a <printf>
    exit(1);
    410a:	4505                	li	a0,1
    410c:	00002097          	auipc	ra,0x2
    4110:	a08080e7          	jalr	-1528(ra) # 5b14 <exit>
  wait(&xstatus);
    4114:	fdc40513          	addi	a0,s0,-36
    4118:	00002097          	auipc	ra,0x2
    411c:	a04080e7          	jalr	-1532(ra) # 5b1c <wait>
  exit(xstatus);
    4120:	fdc42503          	lw	a0,-36(s0)
    4124:	00002097          	auipc	ra,0x2
    4128:	9f0080e7          	jalr	-1552(ra) # 5b14 <exit>

000000000000412c <forkforkfork>:
{
    412c:	1101                	addi	sp,sp,-32
    412e:	ec06                	sd	ra,24(sp)
    4130:	e822                	sd	s0,16(sp)
    4132:	e426                	sd	s1,8(sp)
    4134:	1000                	addi	s0,sp,32
    4136:	84aa                	mv	s1,a0
  unlink("stopforking");
    4138:	00004517          	auipc	a0,0x4
    413c:	a0850513          	addi	a0,a0,-1528 # 7b40 <malloc+0x1c0a>
    4140:	00002097          	auipc	ra,0x2
    4144:	a24080e7          	jalr	-1500(ra) # 5b64 <unlink>
  int pid = fork();
    4148:	00002097          	auipc	ra,0x2
    414c:	9c4080e7          	jalr	-1596(ra) # 5b0c <fork>
  if(pid < 0){
    4150:	04054563          	bltz	a0,419a <forkforkfork+0x6e>
  if(pid == 0){
    4154:	c12d                	beqz	a0,41b6 <forkforkfork+0x8a>
  sleep(20); // two seconds
    4156:	4551                	li	a0,20
    4158:	00002097          	auipc	ra,0x2
    415c:	a4c080e7          	jalr	-1460(ra) # 5ba4 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    4160:	20200593          	li	a1,514
    4164:	00004517          	auipc	a0,0x4
    4168:	9dc50513          	addi	a0,a0,-1572 # 7b40 <malloc+0x1c0a>
    416c:	00002097          	auipc	ra,0x2
    4170:	9e8080e7          	jalr	-1560(ra) # 5b54 <open>
    4174:	00002097          	auipc	ra,0x2
    4178:	9c8080e7          	jalr	-1592(ra) # 5b3c <close>
  wait(0);
    417c:	4501                	li	a0,0
    417e:	00002097          	auipc	ra,0x2
    4182:	99e080e7          	jalr	-1634(ra) # 5b1c <wait>
  sleep(10); // one second
    4186:	4529                	li	a0,10
    4188:	00002097          	auipc	ra,0x2
    418c:	a1c080e7          	jalr	-1508(ra) # 5ba4 <sleep>
}
    4190:	60e2                	ld	ra,24(sp)
    4192:	6442                	ld	s0,16(sp)
    4194:	64a2                	ld	s1,8(sp)
    4196:	6105                	addi	sp,sp,32
    4198:	8082                	ret
    printf("%s: fork failed", s);
    419a:	85a6                	mv	a1,s1
    419c:	00003517          	auipc	a0,0x3
    41a0:	8e450513          	addi	a0,a0,-1820 # 6a80 <malloc+0xb4a>
    41a4:	00002097          	auipc	ra,0x2
    41a8:	cd6080e7          	jalr	-810(ra) # 5e7a <printf>
    exit(1);
    41ac:	4505                	li	a0,1
    41ae:	00002097          	auipc	ra,0x2
    41b2:	966080e7          	jalr	-1690(ra) # 5b14 <exit>
      int fd = open("stopforking", 0);
    41b6:	4581                	li	a1,0
    41b8:	00004517          	auipc	a0,0x4
    41bc:	98850513          	addi	a0,a0,-1656 # 7b40 <malloc+0x1c0a>
    41c0:	00002097          	auipc	ra,0x2
    41c4:	994080e7          	jalr	-1644(ra) # 5b54 <open>
      if(fd >= 0){
    41c8:	02055763          	bgez	a0,41f6 <forkforkfork+0xca>
      if(fork() < 0){
    41cc:	00002097          	auipc	ra,0x2
    41d0:	940080e7          	jalr	-1728(ra) # 5b0c <fork>
    41d4:	fe0551e3          	bgez	a0,41b6 <forkforkfork+0x8a>
        close(open("stopforking", O_CREATE|O_RDWR));
    41d8:	20200593          	li	a1,514
    41dc:	00004517          	auipc	a0,0x4
    41e0:	96450513          	addi	a0,a0,-1692 # 7b40 <malloc+0x1c0a>
    41e4:	00002097          	auipc	ra,0x2
    41e8:	970080e7          	jalr	-1680(ra) # 5b54 <open>
    41ec:	00002097          	auipc	ra,0x2
    41f0:	950080e7          	jalr	-1712(ra) # 5b3c <close>
    41f4:	b7c9                	j	41b6 <forkforkfork+0x8a>
        exit(0);
    41f6:	4501                	li	a0,0
    41f8:	00002097          	auipc	ra,0x2
    41fc:	91c080e7          	jalr	-1764(ra) # 5b14 <exit>

0000000000004200 <killstatus>:
{
    4200:	715d                	addi	sp,sp,-80
    4202:	e486                	sd	ra,72(sp)
    4204:	e0a2                	sd	s0,64(sp)
    4206:	fc26                	sd	s1,56(sp)
    4208:	f84a                	sd	s2,48(sp)
    420a:	f44e                	sd	s3,40(sp)
    420c:	f052                	sd	s4,32(sp)
    420e:	ec56                	sd	s5,24(sp)
    4210:	e85a                	sd	s6,16(sp)
    4212:	0880                	addi	s0,sp,80
    4214:	8b2a                	mv	s6,a0
    4216:	06400913          	li	s2,100
    sleep(1);
    421a:	4a85                	li	s5,1
    wait(&xst);
    421c:	fbc40a13          	addi	s4,s0,-68
    if(xst != -1) {
    4220:	59fd                	li	s3,-1
    int pid1 = fork();
    4222:	00002097          	auipc	ra,0x2
    4226:	8ea080e7          	jalr	-1814(ra) # 5b0c <fork>
    422a:	84aa                	mv	s1,a0
    if(pid1 < 0){
    422c:	02054e63          	bltz	a0,4268 <killstatus+0x68>
    if(pid1 == 0){
    4230:	c931                	beqz	a0,4284 <killstatus+0x84>
    sleep(1);
    4232:	8556                	mv	a0,s5
    4234:	00002097          	auipc	ra,0x2
    4238:	970080e7          	jalr	-1680(ra) # 5ba4 <sleep>
    kill(pid1);
    423c:	8526                	mv	a0,s1
    423e:	00002097          	auipc	ra,0x2
    4242:	906080e7          	jalr	-1786(ra) # 5b44 <kill>
    wait(&xst);
    4246:	8552                	mv	a0,s4
    4248:	00002097          	auipc	ra,0x2
    424c:	8d4080e7          	jalr	-1836(ra) # 5b1c <wait>
    if(xst != -1) {
    4250:	fbc42783          	lw	a5,-68(s0)
    4254:	03379d63          	bne	a5,s3,428e <killstatus+0x8e>
  for(int i = 0; i < 100; i++){
    4258:	397d                	addiw	s2,s2,-1
    425a:	fc0914e3          	bnez	s2,4222 <killstatus+0x22>
  exit(0);
    425e:	4501                	li	a0,0
    4260:	00002097          	auipc	ra,0x2
    4264:	8b4080e7          	jalr	-1868(ra) # 5b14 <exit>
      printf("%s: fork failed\n", s);
    4268:	85da                	mv	a1,s6
    426a:	00002517          	auipc	a0,0x2
    426e:	65650513          	addi	a0,a0,1622 # 68c0 <malloc+0x98a>
    4272:	00002097          	auipc	ra,0x2
    4276:	c08080e7          	jalr	-1016(ra) # 5e7a <printf>
      exit(1);
    427a:	4505                	li	a0,1
    427c:	00002097          	auipc	ra,0x2
    4280:	898080e7          	jalr	-1896(ra) # 5b14 <exit>
        getpid();
    4284:	00002097          	auipc	ra,0x2
    4288:	910080e7          	jalr	-1776(ra) # 5b94 <getpid>
      while(1) {
    428c:	bfe5                	j	4284 <killstatus+0x84>
       printf("%s: status should be -1\n", s);
    428e:	85da                	mv	a1,s6
    4290:	00004517          	auipc	a0,0x4
    4294:	8c050513          	addi	a0,a0,-1856 # 7b50 <malloc+0x1c1a>
    4298:	00002097          	auipc	ra,0x2
    429c:	be2080e7          	jalr	-1054(ra) # 5e7a <printf>
       exit(1);
    42a0:	4505                	li	a0,1
    42a2:	00002097          	auipc	ra,0x2
    42a6:	872080e7          	jalr	-1934(ra) # 5b14 <exit>

00000000000042aa <preempt>:
{
    42aa:	7139                	addi	sp,sp,-64
    42ac:	fc06                	sd	ra,56(sp)
    42ae:	f822                	sd	s0,48(sp)
    42b0:	f426                	sd	s1,40(sp)
    42b2:	f04a                	sd	s2,32(sp)
    42b4:	ec4e                	sd	s3,24(sp)
    42b6:	e852                	sd	s4,16(sp)
    42b8:	0080                	addi	s0,sp,64
    42ba:	892a                	mv	s2,a0
  pid1 = fork();
    42bc:	00002097          	auipc	ra,0x2
    42c0:	850080e7          	jalr	-1968(ra) # 5b0c <fork>
  if(pid1 < 0) {
    42c4:	00054563          	bltz	a0,42ce <preempt+0x24>
    42c8:	84aa                	mv	s1,a0
  if(pid1 == 0)
    42ca:	e105                	bnez	a0,42ea <preempt+0x40>
    for(;;)
    42cc:	a001                	j	42cc <preempt+0x22>
    printf("%s: fork failed", s);
    42ce:	85ca                	mv	a1,s2
    42d0:	00002517          	auipc	a0,0x2
    42d4:	7b050513          	addi	a0,a0,1968 # 6a80 <malloc+0xb4a>
    42d8:	00002097          	auipc	ra,0x2
    42dc:	ba2080e7          	jalr	-1118(ra) # 5e7a <printf>
    exit(1);
    42e0:	4505                	li	a0,1
    42e2:	00002097          	auipc	ra,0x2
    42e6:	832080e7          	jalr	-1998(ra) # 5b14 <exit>
  pid2 = fork();
    42ea:	00002097          	auipc	ra,0x2
    42ee:	822080e7          	jalr	-2014(ra) # 5b0c <fork>
    42f2:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    42f4:	00054463          	bltz	a0,42fc <preempt+0x52>
  if(pid2 == 0)
    42f8:	e105                	bnez	a0,4318 <preempt+0x6e>
    for(;;)
    42fa:	a001                	j	42fa <preempt+0x50>
    printf("%s: fork failed\n", s);
    42fc:	85ca                	mv	a1,s2
    42fe:	00002517          	auipc	a0,0x2
    4302:	5c250513          	addi	a0,a0,1474 # 68c0 <malloc+0x98a>
    4306:	00002097          	auipc	ra,0x2
    430a:	b74080e7          	jalr	-1164(ra) # 5e7a <printf>
    exit(1);
    430e:	4505                	li	a0,1
    4310:	00002097          	auipc	ra,0x2
    4314:	804080e7          	jalr	-2044(ra) # 5b14 <exit>
  pipe(pfds);
    4318:	fc840513          	addi	a0,s0,-56
    431c:	00002097          	auipc	ra,0x2
    4320:	808080e7          	jalr	-2040(ra) # 5b24 <pipe>
  pid3 = fork();
    4324:	00001097          	auipc	ra,0x1
    4328:	7e8080e7          	jalr	2024(ra) # 5b0c <fork>
    432c:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    432e:	02054e63          	bltz	a0,436a <preempt+0xc0>
  if(pid3 == 0){
    4332:	e525                	bnez	a0,439a <preempt+0xf0>
    close(pfds[0]);
    4334:	fc842503          	lw	a0,-56(s0)
    4338:	00002097          	auipc	ra,0x2
    433c:	804080e7          	jalr	-2044(ra) # 5b3c <close>
    if(write(pfds[1], "x", 1) != 1)
    4340:	4605                	li	a2,1
    4342:	00002597          	auipc	a1,0x2
    4346:	d9658593          	addi	a1,a1,-618 # 60d8 <malloc+0x1a2>
    434a:	fcc42503          	lw	a0,-52(s0)
    434e:	00001097          	auipc	ra,0x1
    4352:	7e6080e7          	jalr	2022(ra) # 5b34 <write>
    4356:	4785                	li	a5,1
    4358:	02f51763          	bne	a0,a5,4386 <preempt+0xdc>
    close(pfds[1]);
    435c:	fcc42503          	lw	a0,-52(s0)
    4360:	00001097          	auipc	ra,0x1
    4364:	7dc080e7          	jalr	2012(ra) # 5b3c <close>
    for(;;)
    4368:	a001                	j	4368 <preempt+0xbe>
     printf("%s: fork failed\n", s);
    436a:	85ca                	mv	a1,s2
    436c:	00002517          	auipc	a0,0x2
    4370:	55450513          	addi	a0,a0,1364 # 68c0 <malloc+0x98a>
    4374:	00002097          	auipc	ra,0x2
    4378:	b06080e7          	jalr	-1274(ra) # 5e7a <printf>
     exit(1);
    437c:	4505                	li	a0,1
    437e:	00001097          	auipc	ra,0x1
    4382:	796080e7          	jalr	1942(ra) # 5b14 <exit>
      printf("%s: preempt write error", s);
    4386:	85ca                	mv	a1,s2
    4388:	00003517          	auipc	a0,0x3
    438c:	7e850513          	addi	a0,a0,2024 # 7b70 <malloc+0x1c3a>
    4390:	00002097          	auipc	ra,0x2
    4394:	aea080e7          	jalr	-1302(ra) # 5e7a <printf>
    4398:	b7d1                	j	435c <preempt+0xb2>
  close(pfds[1]);
    439a:	fcc42503          	lw	a0,-52(s0)
    439e:	00001097          	auipc	ra,0x1
    43a2:	79e080e7          	jalr	1950(ra) # 5b3c <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    43a6:	660d                	lui	a2,0x3
    43a8:	00009597          	auipc	a1,0x9
    43ac:	0a858593          	addi	a1,a1,168 # d450 <buf>
    43b0:	fc842503          	lw	a0,-56(s0)
    43b4:	00001097          	auipc	ra,0x1
    43b8:	778080e7          	jalr	1912(ra) # 5b2c <read>
    43bc:	4785                	li	a5,1
    43be:	02f50363          	beq	a0,a5,43e4 <preempt+0x13a>
    printf("%s: preempt read error", s);
    43c2:	85ca                	mv	a1,s2
    43c4:	00003517          	auipc	a0,0x3
    43c8:	7c450513          	addi	a0,a0,1988 # 7b88 <malloc+0x1c52>
    43cc:	00002097          	auipc	ra,0x2
    43d0:	aae080e7          	jalr	-1362(ra) # 5e7a <printf>
}
    43d4:	70e2                	ld	ra,56(sp)
    43d6:	7442                	ld	s0,48(sp)
    43d8:	74a2                	ld	s1,40(sp)
    43da:	7902                	ld	s2,32(sp)
    43dc:	69e2                	ld	s3,24(sp)
    43de:	6a42                	ld	s4,16(sp)
    43e0:	6121                	addi	sp,sp,64
    43e2:	8082                	ret
  close(pfds[0]);
    43e4:	fc842503          	lw	a0,-56(s0)
    43e8:	00001097          	auipc	ra,0x1
    43ec:	754080e7          	jalr	1876(ra) # 5b3c <close>
  printf("kill... ");
    43f0:	00003517          	auipc	a0,0x3
    43f4:	7b050513          	addi	a0,a0,1968 # 7ba0 <malloc+0x1c6a>
    43f8:	00002097          	auipc	ra,0x2
    43fc:	a82080e7          	jalr	-1406(ra) # 5e7a <printf>
  kill(pid1);
    4400:	8526                	mv	a0,s1
    4402:	00001097          	auipc	ra,0x1
    4406:	742080e7          	jalr	1858(ra) # 5b44 <kill>
  kill(pid2);
    440a:	854e                	mv	a0,s3
    440c:	00001097          	auipc	ra,0x1
    4410:	738080e7          	jalr	1848(ra) # 5b44 <kill>
  kill(pid3);
    4414:	8552                	mv	a0,s4
    4416:	00001097          	auipc	ra,0x1
    441a:	72e080e7          	jalr	1838(ra) # 5b44 <kill>
  printf("wait... ");
    441e:	00003517          	auipc	a0,0x3
    4422:	79250513          	addi	a0,a0,1938 # 7bb0 <malloc+0x1c7a>
    4426:	00002097          	auipc	ra,0x2
    442a:	a54080e7          	jalr	-1452(ra) # 5e7a <printf>
  wait(0);
    442e:	4501                	li	a0,0
    4430:	00001097          	auipc	ra,0x1
    4434:	6ec080e7          	jalr	1772(ra) # 5b1c <wait>
  wait(0);
    4438:	4501                	li	a0,0
    443a:	00001097          	auipc	ra,0x1
    443e:	6e2080e7          	jalr	1762(ra) # 5b1c <wait>
  wait(0);
    4442:	4501                	li	a0,0
    4444:	00001097          	auipc	ra,0x1
    4448:	6d8080e7          	jalr	1752(ra) # 5b1c <wait>
    444c:	b761                	j	43d4 <preempt+0x12a>

000000000000444e <reparent>:
{
    444e:	7179                	addi	sp,sp,-48
    4450:	f406                	sd	ra,40(sp)
    4452:	f022                	sd	s0,32(sp)
    4454:	ec26                	sd	s1,24(sp)
    4456:	e84a                	sd	s2,16(sp)
    4458:	e44e                	sd	s3,8(sp)
    445a:	e052                	sd	s4,0(sp)
    445c:	1800                	addi	s0,sp,48
    445e:	89aa                	mv	s3,a0
  int master_pid = getpid();
    4460:	00001097          	auipc	ra,0x1
    4464:	734080e7          	jalr	1844(ra) # 5b94 <getpid>
    4468:	8a2a                	mv	s4,a0
    446a:	0c800913          	li	s2,200
    int pid = fork();
    446e:	00001097          	auipc	ra,0x1
    4472:	69e080e7          	jalr	1694(ra) # 5b0c <fork>
    4476:	84aa                	mv	s1,a0
    if(pid < 0){
    4478:	02054263          	bltz	a0,449c <reparent+0x4e>
    if(pid){
    447c:	cd21                	beqz	a0,44d4 <reparent+0x86>
      if(wait(0) != pid){
    447e:	4501                	li	a0,0
    4480:	00001097          	auipc	ra,0x1
    4484:	69c080e7          	jalr	1692(ra) # 5b1c <wait>
    4488:	02951863          	bne	a0,s1,44b8 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    448c:	397d                	addiw	s2,s2,-1
    448e:	fe0910e3          	bnez	s2,446e <reparent+0x20>
  exit(0);
    4492:	4501                	li	a0,0
    4494:	00001097          	auipc	ra,0x1
    4498:	680080e7          	jalr	1664(ra) # 5b14 <exit>
      printf("%s: fork failed\n", s);
    449c:	85ce                	mv	a1,s3
    449e:	00002517          	auipc	a0,0x2
    44a2:	42250513          	addi	a0,a0,1058 # 68c0 <malloc+0x98a>
    44a6:	00002097          	auipc	ra,0x2
    44aa:	9d4080e7          	jalr	-1580(ra) # 5e7a <printf>
      exit(1);
    44ae:	4505                	li	a0,1
    44b0:	00001097          	auipc	ra,0x1
    44b4:	664080e7          	jalr	1636(ra) # 5b14 <exit>
        printf("%s: wait wrong pid\n", s);
    44b8:	85ce                	mv	a1,s3
    44ba:	00002517          	auipc	a0,0x2
    44be:	58e50513          	addi	a0,a0,1422 # 6a48 <malloc+0xb12>
    44c2:	00002097          	auipc	ra,0x2
    44c6:	9b8080e7          	jalr	-1608(ra) # 5e7a <printf>
        exit(1);
    44ca:	4505                	li	a0,1
    44cc:	00001097          	auipc	ra,0x1
    44d0:	648080e7          	jalr	1608(ra) # 5b14 <exit>
      int pid2 = fork();
    44d4:	00001097          	auipc	ra,0x1
    44d8:	638080e7          	jalr	1592(ra) # 5b0c <fork>
      if(pid2 < 0){
    44dc:	00054763          	bltz	a0,44ea <reparent+0x9c>
      exit(0);
    44e0:	4501                	li	a0,0
    44e2:	00001097          	auipc	ra,0x1
    44e6:	632080e7          	jalr	1586(ra) # 5b14 <exit>
        kill(master_pid);
    44ea:	8552                	mv	a0,s4
    44ec:	00001097          	auipc	ra,0x1
    44f0:	658080e7          	jalr	1624(ra) # 5b44 <kill>
        exit(1);
    44f4:	4505                	li	a0,1
    44f6:	00001097          	auipc	ra,0x1
    44fa:	61e080e7          	jalr	1566(ra) # 5b14 <exit>

00000000000044fe <sbrkfail>:
{
    44fe:	7175                	addi	sp,sp,-144
    4500:	e506                	sd	ra,136(sp)
    4502:	e122                	sd	s0,128(sp)
    4504:	fca6                	sd	s1,120(sp)
    4506:	f8ca                	sd	s2,112(sp)
    4508:	f4ce                	sd	s3,104(sp)
    450a:	f0d2                	sd	s4,96(sp)
    450c:	ecd6                	sd	s5,88(sp)
    450e:	e8da                	sd	s6,80(sp)
    4510:	e4de                	sd	s7,72(sp)
    4512:	0900                	addi	s0,sp,144
    4514:	8baa                	mv	s7,a0
  if(pipe(fds) != 0){
    4516:	fa040513          	addi	a0,s0,-96
    451a:	00001097          	auipc	ra,0x1
    451e:	60a080e7          	jalr	1546(ra) # 5b24 <pipe>
    4522:	e919                	bnez	a0,4538 <sbrkfail+0x3a>
    4524:	f7040493          	addi	s1,s0,-144
    4528:	f9840993          	addi	s3,s0,-104
    452c:	8926                	mv	s2,s1
    if(pids[i] != -1)
    452e:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    4530:	f9f40b13          	addi	s6,s0,-97
    4534:	4a85                	li	s5,1
    4536:	a08d                	j	4598 <sbrkfail+0x9a>
    printf("%s: pipe() failed\n", s);
    4538:	85de                	mv	a1,s7
    453a:	00002517          	auipc	a0,0x2
    453e:	48e50513          	addi	a0,a0,1166 # 69c8 <malloc+0xa92>
    4542:	00002097          	auipc	ra,0x2
    4546:	938080e7          	jalr	-1736(ra) # 5e7a <printf>
    exit(1);
    454a:	4505                	li	a0,1
    454c:	00001097          	auipc	ra,0x1
    4550:	5c8080e7          	jalr	1480(ra) # 5b14 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    4554:	00001097          	auipc	ra,0x1
    4558:	648080e7          	jalr	1608(ra) # 5b9c <sbrk>
    455c:	064007b7          	lui	a5,0x6400
    4560:	40a7853b          	subw	a0,a5,a0
    4564:	00001097          	auipc	ra,0x1
    4568:	638080e7          	jalr	1592(ra) # 5b9c <sbrk>
      write(fds[1], "x", 1);
    456c:	4605                	li	a2,1
    456e:	00002597          	auipc	a1,0x2
    4572:	b6a58593          	addi	a1,a1,-1174 # 60d8 <malloc+0x1a2>
    4576:	fa442503          	lw	a0,-92(s0)
    457a:	00001097          	auipc	ra,0x1
    457e:	5ba080e7          	jalr	1466(ra) # 5b34 <write>
      for(;;) sleep(1000);
    4582:	3e800493          	li	s1,1000
    4586:	8526                	mv	a0,s1
    4588:	00001097          	auipc	ra,0x1
    458c:	61c080e7          	jalr	1564(ra) # 5ba4 <sleep>
    4590:	bfdd                	j	4586 <sbrkfail+0x88>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4592:	0911                	addi	s2,s2,4
    4594:	03390463          	beq	s2,s3,45bc <sbrkfail+0xbe>
    if((pids[i] = fork()) == 0){
    4598:	00001097          	auipc	ra,0x1
    459c:	574080e7          	jalr	1396(ra) # 5b0c <fork>
    45a0:	00a92023          	sw	a0,0(s2)
    45a4:	d945                	beqz	a0,4554 <sbrkfail+0x56>
    if(pids[i] != -1)
    45a6:	ff4506e3          	beq	a0,s4,4592 <sbrkfail+0x94>
      read(fds[0], &scratch, 1);
    45aa:	8656                	mv	a2,s5
    45ac:	85da                	mv	a1,s6
    45ae:	fa042503          	lw	a0,-96(s0)
    45b2:	00001097          	auipc	ra,0x1
    45b6:	57a080e7          	jalr	1402(ra) # 5b2c <read>
    45ba:	bfe1                	j	4592 <sbrkfail+0x94>
  c = sbrk(PGSIZE);
    45bc:	6505                	lui	a0,0x1
    45be:	00001097          	auipc	ra,0x1
    45c2:	5de080e7          	jalr	1502(ra) # 5b9c <sbrk>
    45c6:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    45c8:	597d                	li	s2,-1
    45ca:	a021                	j	45d2 <sbrkfail+0xd4>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    45cc:	0491                	addi	s1,s1,4
    45ce:	01348f63          	beq	s1,s3,45ec <sbrkfail+0xee>
    if(pids[i] == -1)
    45d2:	4088                	lw	a0,0(s1)
    45d4:	ff250ce3          	beq	a0,s2,45cc <sbrkfail+0xce>
    kill(pids[i]);
    45d8:	00001097          	auipc	ra,0x1
    45dc:	56c080e7          	jalr	1388(ra) # 5b44 <kill>
    wait(0);
    45e0:	4501                	li	a0,0
    45e2:	00001097          	auipc	ra,0x1
    45e6:	53a080e7          	jalr	1338(ra) # 5b1c <wait>
    45ea:	b7cd                	j	45cc <sbrkfail+0xce>
  if(c == (char*)0xffffffffffffffffL){
    45ec:	57fd                	li	a5,-1
    45ee:	04fa0263          	beq	s4,a5,4632 <sbrkfail+0x134>
  pid = fork();
    45f2:	00001097          	auipc	ra,0x1
    45f6:	51a080e7          	jalr	1306(ra) # 5b0c <fork>
    45fa:	84aa                	mv	s1,a0
  if(pid < 0){
    45fc:	04054963          	bltz	a0,464e <sbrkfail+0x150>
  if(pid == 0){
    4600:	c52d                	beqz	a0,466a <sbrkfail+0x16c>
  wait(&xstatus);
    4602:	fac40513          	addi	a0,s0,-84
    4606:	00001097          	auipc	ra,0x1
    460a:	516080e7          	jalr	1302(ra) # 5b1c <wait>
  if(xstatus != -1 && xstatus != 2)
    460e:	fac42783          	lw	a5,-84(s0)
    4612:	00178713          	addi	a4,a5,1 # 6400001 <__BSS_END__+0x63efba1>
    4616:	c319                	beqz	a4,461c <sbrkfail+0x11e>
    4618:	17f9                	addi	a5,a5,-2
    461a:	efd1                	bnez	a5,46b6 <sbrkfail+0x1b8>
}
    461c:	60aa                	ld	ra,136(sp)
    461e:	640a                	ld	s0,128(sp)
    4620:	74e6                	ld	s1,120(sp)
    4622:	7946                	ld	s2,112(sp)
    4624:	79a6                	ld	s3,104(sp)
    4626:	7a06                	ld	s4,96(sp)
    4628:	6ae6                	ld	s5,88(sp)
    462a:	6b46                	ld	s6,80(sp)
    462c:	6ba6                	ld	s7,72(sp)
    462e:	6149                	addi	sp,sp,144
    4630:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    4632:	85de                	mv	a1,s7
    4634:	00003517          	auipc	a0,0x3
    4638:	58c50513          	addi	a0,a0,1420 # 7bc0 <malloc+0x1c8a>
    463c:	00002097          	auipc	ra,0x2
    4640:	83e080e7          	jalr	-1986(ra) # 5e7a <printf>
    exit(1);
    4644:	4505                	li	a0,1
    4646:	00001097          	auipc	ra,0x1
    464a:	4ce080e7          	jalr	1230(ra) # 5b14 <exit>
    printf("%s: fork failed\n", s);
    464e:	85de                	mv	a1,s7
    4650:	00002517          	auipc	a0,0x2
    4654:	27050513          	addi	a0,a0,624 # 68c0 <malloc+0x98a>
    4658:	00002097          	auipc	ra,0x2
    465c:	822080e7          	jalr	-2014(ra) # 5e7a <printf>
    exit(1);
    4660:	4505                	li	a0,1
    4662:	00001097          	auipc	ra,0x1
    4666:	4b2080e7          	jalr	1202(ra) # 5b14 <exit>
    a = sbrk(0);
    466a:	4501                	li	a0,0
    466c:	00001097          	auipc	ra,0x1
    4670:	530080e7          	jalr	1328(ra) # 5b9c <sbrk>
    4674:	892a                	mv	s2,a0
    sbrk(10*BIG);
    4676:	3e800537          	lui	a0,0x3e800
    467a:	00001097          	auipc	ra,0x1
    467e:	522080e7          	jalr	1314(ra) # 5b9c <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4682:	87ca                	mv	a5,s2
    4684:	3e800737          	lui	a4,0x3e800
    4688:	993a                	add	s2,s2,a4
    468a:	6705                	lui	a4,0x1
      n += *(a+i);
    468c:	0007c603          	lbu	a2,0(a5)
    4690:	9e25                	addw	a2,a2,s1
    4692:	84b2                	mv	s1,a2
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4694:	97ba                	add	a5,a5,a4
    4696:	fef91be3          	bne	s2,a5,468c <sbrkfail+0x18e>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    469a:	85de                	mv	a1,s7
    469c:	00003517          	auipc	a0,0x3
    46a0:	54450513          	addi	a0,a0,1348 # 7be0 <malloc+0x1caa>
    46a4:	00001097          	auipc	ra,0x1
    46a8:	7d6080e7          	jalr	2006(ra) # 5e7a <printf>
    exit(1);
    46ac:	4505                	li	a0,1
    46ae:	00001097          	auipc	ra,0x1
    46b2:	466080e7          	jalr	1126(ra) # 5b14 <exit>
    exit(1);
    46b6:	4505                	li	a0,1
    46b8:	00001097          	auipc	ra,0x1
    46bc:	45c080e7          	jalr	1116(ra) # 5b14 <exit>

00000000000046c0 <mem>:
{
    46c0:	7139                	addi	sp,sp,-64
    46c2:	fc06                	sd	ra,56(sp)
    46c4:	f822                	sd	s0,48(sp)
    46c6:	f426                	sd	s1,40(sp)
    46c8:	f04a                	sd	s2,32(sp)
    46ca:	ec4e                	sd	s3,24(sp)
    46cc:	0080                	addi	s0,sp,64
    46ce:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    46d0:	00001097          	auipc	ra,0x1
    46d4:	43c080e7          	jalr	1084(ra) # 5b0c <fork>
    m1 = 0;
    46d8:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    46da:	6909                	lui	s2,0x2
    46dc:	71190913          	addi	s2,s2,1809 # 2711 <rwsbrk+0xd5>
  if((pid = fork()) == 0){
    46e0:	c115                	beqz	a0,4704 <mem+0x44>
    wait(&xstatus);
    46e2:	fcc40513          	addi	a0,s0,-52
    46e6:	00001097          	auipc	ra,0x1
    46ea:	436080e7          	jalr	1078(ra) # 5b1c <wait>
    if(xstatus == -1){
    46ee:	fcc42503          	lw	a0,-52(s0)
    46f2:	57fd                	li	a5,-1
    46f4:	06f50363          	beq	a0,a5,475a <mem+0x9a>
    exit(xstatus);
    46f8:	00001097          	auipc	ra,0x1
    46fc:	41c080e7          	jalr	1052(ra) # 5b14 <exit>
      *(char**)m2 = m1;
    4700:	e104                	sd	s1,0(a0)
      m1 = m2;
    4702:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4704:	854a                	mv	a0,s2
    4706:	00002097          	auipc	ra,0x2
    470a:	830080e7          	jalr	-2000(ra) # 5f36 <malloc>
    470e:	f96d                	bnez	a0,4700 <mem+0x40>
    while(m1){
    4710:	c881                	beqz	s1,4720 <mem+0x60>
      m2 = *(char**)m1;
    4712:	8526                	mv	a0,s1
    4714:	6084                	ld	s1,0(s1)
      free(m1);
    4716:	00001097          	auipc	ra,0x1
    471a:	79a080e7          	jalr	1946(ra) # 5eb0 <free>
    while(m1){
    471e:	f8f5                	bnez	s1,4712 <mem+0x52>
    m1 = malloc(1024*20);
    4720:	6515                	lui	a0,0x5
    4722:	00002097          	auipc	ra,0x2
    4726:	814080e7          	jalr	-2028(ra) # 5f36 <malloc>
    if(m1 == 0){
    472a:	c911                	beqz	a0,473e <mem+0x7e>
    free(m1);
    472c:	00001097          	auipc	ra,0x1
    4730:	784080e7          	jalr	1924(ra) # 5eb0 <free>
    exit(0);
    4734:	4501                	li	a0,0
    4736:	00001097          	auipc	ra,0x1
    473a:	3de080e7          	jalr	990(ra) # 5b14 <exit>
      printf("couldn't allocate mem?!!\n", s);
    473e:	85ce                	mv	a1,s3
    4740:	00003517          	auipc	a0,0x3
    4744:	4d050513          	addi	a0,a0,1232 # 7c10 <malloc+0x1cda>
    4748:	00001097          	auipc	ra,0x1
    474c:	732080e7          	jalr	1842(ra) # 5e7a <printf>
      exit(1);
    4750:	4505                	li	a0,1
    4752:	00001097          	auipc	ra,0x1
    4756:	3c2080e7          	jalr	962(ra) # 5b14 <exit>
      exit(0);
    475a:	4501                	li	a0,0
    475c:	00001097          	auipc	ra,0x1
    4760:	3b8080e7          	jalr	952(ra) # 5b14 <exit>

0000000000004764 <sharedfd>:
{
    4764:	7159                	addi	sp,sp,-112
    4766:	f486                	sd	ra,104(sp)
    4768:	f0a2                	sd	s0,96(sp)
    476a:	eca6                	sd	s1,88(sp)
    476c:	f85a                	sd	s6,48(sp)
    476e:	1880                	addi	s0,sp,112
    4770:	84aa                	mv	s1,a0
    4772:	8b2a                	mv	s6,a0
  unlink("sharedfd");
    4774:	00003517          	auipc	a0,0x3
    4778:	4bc50513          	addi	a0,a0,1212 # 7c30 <malloc+0x1cfa>
    477c:	00001097          	auipc	ra,0x1
    4780:	3e8080e7          	jalr	1000(ra) # 5b64 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4784:	20200593          	li	a1,514
    4788:	00003517          	auipc	a0,0x3
    478c:	4a850513          	addi	a0,a0,1192 # 7c30 <malloc+0x1cfa>
    4790:	00001097          	auipc	ra,0x1
    4794:	3c4080e7          	jalr	964(ra) # 5b54 <open>
  if(fd < 0){
    4798:	06054063          	bltz	a0,47f8 <sharedfd+0x94>
    479c:	e8ca                	sd	s2,80(sp)
    479e:	e4ce                	sd	s3,72(sp)
    47a0:	e0d2                	sd	s4,64(sp)
    47a2:	fc56                	sd	s5,56(sp)
    47a4:	89aa                	mv	s3,a0
  pid = fork();
    47a6:	00001097          	auipc	ra,0x1
    47aa:	366080e7          	jalr	870(ra) # 5b0c <fork>
    47ae:	8aaa                	mv	s5,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    47b0:	07000593          	li	a1,112
    47b4:	e119                	bnez	a0,47ba <sharedfd+0x56>
    47b6:	06300593          	li	a1,99
    47ba:	4629                	li	a2,10
    47bc:	fa040513          	addi	a0,s0,-96
    47c0:	00001097          	auipc	ra,0x1
    47c4:	142080e7          	jalr	322(ra) # 5902 <memset>
    47c8:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    47cc:	fa040a13          	addi	s4,s0,-96
    47d0:	4929                	li	s2,10
    47d2:	864a                	mv	a2,s2
    47d4:	85d2                	mv	a1,s4
    47d6:	854e                	mv	a0,s3
    47d8:	00001097          	auipc	ra,0x1
    47dc:	35c080e7          	jalr	860(ra) # 5b34 <write>
    47e0:	03251f63          	bne	a0,s2,481e <sharedfd+0xba>
  for(i = 0; i < N; i++){
    47e4:	34fd                	addiw	s1,s1,-1
    47e6:	f4f5                	bnez	s1,47d2 <sharedfd+0x6e>
  if(pid == 0) {
    47e8:	040a9a63          	bnez	s5,483c <sharedfd+0xd8>
    47ec:	f45e                	sd	s7,40(sp)
    exit(0);
    47ee:	4501                	li	a0,0
    47f0:	00001097          	auipc	ra,0x1
    47f4:	324080e7          	jalr	804(ra) # 5b14 <exit>
    47f8:	e8ca                	sd	s2,80(sp)
    47fa:	e4ce                	sd	s3,72(sp)
    47fc:	e0d2                	sd	s4,64(sp)
    47fe:	fc56                	sd	s5,56(sp)
    4800:	f45e                	sd	s7,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    4802:	85a6                	mv	a1,s1
    4804:	00003517          	auipc	a0,0x3
    4808:	43c50513          	addi	a0,a0,1084 # 7c40 <malloc+0x1d0a>
    480c:	00001097          	auipc	ra,0x1
    4810:	66e080e7          	jalr	1646(ra) # 5e7a <printf>
    exit(1);
    4814:	4505                	li	a0,1
    4816:	00001097          	auipc	ra,0x1
    481a:	2fe080e7          	jalr	766(ra) # 5b14 <exit>
    481e:	f45e                	sd	s7,40(sp)
      printf("%s: write sharedfd failed\n", s);
    4820:	85da                	mv	a1,s6
    4822:	00003517          	auipc	a0,0x3
    4826:	44650513          	addi	a0,a0,1094 # 7c68 <malloc+0x1d32>
    482a:	00001097          	auipc	ra,0x1
    482e:	650080e7          	jalr	1616(ra) # 5e7a <printf>
      exit(1);
    4832:	4505                	li	a0,1
    4834:	00001097          	auipc	ra,0x1
    4838:	2e0080e7          	jalr	736(ra) # 5b14 <exit>
    wait(&xstatus);
    483c:	f9c40513          	addi	a0,s0,-100
    4840:	00001097          	auipc	ra,0x1
    4844:	2dc080e7          	jalr	732(ra) # 5b1c <wait>
    if(xstatus != 0)
    4848:	f9c42a03          	lw	s4,-100(s0)
    484c:	000a0863          	beqz	s4,485c <sharedfd+0xf8>
    4850:	f45e                	sd	s7,40(sp)
      exit(xstatus);
    4852:	8552                	mv	a0,s4
    4854:	00001097          	auipc	ra,0x1
    4858:	2c0080e7          	jalr	704(ra) # 5b14 <exit>
    485c:	f45e                	sd	s7,40(sp)
  close(fd);
    485e:	854e                	mv	a0,s3
    4860:	00001097          	auipc	ra,0x1
    4864:	2dc080e7          	jalr	732(ra) # 5b3c <close>
  fd = open("sharedfd", 0);
    4868:	4581                	li	a1,0
    486a:	00003517          	auipc	a0,0x3
    486e:	3c650513          	addi	a0,a0,966 # 7c30 <malloc+0x1cfa>
    4872:	00001097          	auipc	ra,0x1
    4876:	2e2080e7          	jalr	738(ra) # 5b54 <open>
    487a:	8baa                	mv	s7,a0
  nc = np = 0;
    487c:	89d2                	mv	s3,s4
  if(fd < 0){
    487e:	02054563          	bltz	a0,48a8 <sharedfd+0x144>
    4882:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4886:	06300493          	li	s1,99
      if(buf[i] == 'p')
    488a:	07000a93          	li	s5,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    488e:	4629                	li	a2,10
    4890:	fa040593          	addi	a1,s0,-96
    4894:	855e                	mv	a0,s7
    4896:	00001097          	auipc	ra,0x1
    489a:	296080e7          	jalr	662(ra) # 5b2c <read>
    489e:	02a05f63          	blez	a0,48dc <sharedfd+0x178>
    48a2:	fa040793          	addi	a5,s0,-96
    48a6:	a01d                	j	48cc <sharedfd+0x168>
    printf("%s: cannot open sharedfd for reading\n", s);
    48a8:	85da                	mv	a1,s6
    48aa:	00003517          	auipc	a0,0x3
    48ae:	3de50513          	addi	a0,a0,990 # 7c88 <malloc+0x1d52>
    48b2:	00001097          	auipc	ra,0x1
    48b6:	5c8080e7          	jalr	1480(ra) # 5e7a <printf>
    exit(1);
    48ba:	4505                	li	a0,1
    48bc:	00001097          	auipc	ra,0x1
    48c0:	258080e7          	jalr	600(ra) # 5b14 <exit>
        nc++;
    48c4:	2a05                	addiw	s4,s4,1
    for(i = 0; i < sizeof(buf); i++){
    48c6:	0785                	addi	a5,a5,1
    48c8:	fd2783e3          	beq	a5,s2,488e <sharedfd+0x12a>
      if(buf[i] == 'c')
    48cc:	0007c703          	lbu	a4,0(a5)
    48d0:	fe970ae3          	beq	a4,s1,48c4 <sharedfd+0x160>
      if(buf[i] == 'p')
    48d4:	ff5719e3          	bne	a4,s5,48c6 <sharedfd+0x162>
        np++;
    48d8:	2985                	addiw	s3,s3,1
    48da:	b7f5                	j	48c6 <sharedfd+0x162>
  close(fd);
    48dc:	855e                	mv	a0,s7
    48de:	00001097          	auipc	ra,0x1
    48e2:	25e080e7          	jalr	606(ra) # 5b3c <close>
  unlink("sharedfd");
    48e6:	00003517          	auipc	a0,0x3
    48ea:	34a50513          	addi	a0,a0,842 # 7c30 <malloc+0x1cfa>
    48ee:	00001097          	auipc	ra,0x1
    48f2:	276080e7          	jalr	630(ra) # 5b64 <unlink>
  if(nc == N*SZ && np == N*SZ){
    48f6:	6789                	lui	a5,0x2
    48f8:	71078793          	addi	a5,a5,1808 # 2710 <rwsbrk+0xd4>
    48fc:	00fa1963          	bne	s4,a5,490e <sharedfd+0x1aa>
    4900:	01499763          	bne	s3,s4,490e <sharedfd+0x1aa>
    exit(0);
    4904:	4501                	li	a0,0
    4906:	00001097          	auipc	ra,0x1
    490a:	20e080e7          	jalr	526(ra) # 5b14 <exit>
    printf("%s: nc/np test fails\n", s);
    490e:	85da                	mv	a1,s6
    4910:	00003517          	auipc	a0,0x3
    4914:	3a050513          	addi	a0,a0,928 # 7cb0 <malloc+0x1d7a>
    4918:	00001097          	auipc	ra,0x1
    491c:	562080e7          	jalr	1378(ra) # 5e7a <printf>
    exit(1);
    4920:	4505                	li	a0,1
    4922:	00001097          	auipc	ra,0x1
    4926:	1f2080e7          	jalr	498(ra) # 5b14 <exit>

000000000000492a <fourfiles>:
{
    492a:	7135                	addi	sp,sp,-160
    492c:	ed06                	sd	ra,152(sp)
    492e:	e922                	sd	s0,144(sp)
    4930:	e526                	sd	s1,136(sp)
    4932:	e14a                	sd	s2,128(sp)
    4934:	fcce                	sd	s3,120(sp)
    4936:	f8d2                	sd	s4,112(sp)
    4938:	f4d6                	sd	s5,104(sp)
    493a:	f0da                	sd	s6,96(sp)
    493c:	ecde                	sd	s7,88(sp)
    493e:	e8e2                	sd	s8,80(sp)
    4940:	e4e6                	sd	s9,72(sp)
    4942:	e0ea                	sd	s10,64(sp)
    4944:	fc6e                	sd	s11,56(sp)
    4946:	1100                	addi	s0,sp,160
    4948:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    494a:	00003797          	auipc	a5,0x3
    494e:	37e78793          	addi	a5,a5,894 # 7cc8 <malloc+0x1d92>
    4952:	f6f43823          	sd	a5,-144(s0)
    4956:	00003797          	auipc	a5,0x3
    495a:	37a78793          	addi	a5,a5,890 # 7cd0 <malloc+0x1d9a>
    495e:	f6f43c23          	sd	a5,-136(s0)
    4962:	00003797          	auipc	a5,0x3
    4966:	37678793          	addi	a5,a5,886 # 7cd8 <malloc+0x1da2>
    496a:	f8f43023          	sd	a5,-128(s0)
    496e:	00003797          	auipc	a5,0x3
    4972:	37278793          	addi	a5,a5,882 # 7ce0 <malloc+0x1daa>
    4976:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    497a:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    497e:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    4980:	4481                	li	s1,0
    4982:	4a11                	li	s4,4
    fname = names[pi];
    4984:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4988:	854e                	mv	a0,s3
    498a:	00001097          	auipc	ra,0x1
    498e:	1da080e7          	jalr	474(ra) # 5b64 <unlink>
    pid = fork();
    4992:	00001097          	auipc	ra,0x1
    4996:	17a080e7          	jalr	378(ra) # 5b0c <fork>
    if(pid < 0){
    499a:	04054263          	bltz	a0,49de <fourfiles+0xb4>
    if(pid == 0){
    499e:	cd31                	beqz	a0,49fa <fourfiles+0xd0>
  for(pi = 0; pi < NCHILD; pi++){
    49a0:	2485                	addiw	s1,s1,1
    49a2:	0921                	addi	s2,s2,8
    49a4:	ff4490e3          	bne	s1,s4,4984 <fourfiles+0x5a>
    49a8:	4491                	li	s1,4
    wait(&xstatus);
    49aa:	f6c40913          	addi	s2,s0,-148
    49ae:	854a                	mv	a0,s2
    49b0:	00001097          	auipc	ra,0x1
    49b4:	16c080e7          	jalr	364(ra) # 5b1c <wait>
    if(xstatus != 0)
    49b8:	f6c42b03          	lw	s6,-148(s0)
    49bc:	0c0b1863          	bnez	s6,4a8c <fourfiles+0x162>
  for(pi = 0; pi < NCHILD; pi++){
    49c0:	34fd                	addiw	s1,s1,-1
    49c2:	f4f5                	bnez	s1,49ae <fourfiles+0x84>
    49c4:	03000493          	li	s1,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    49c8:	6a8d                	lui	s5,0x3
    49ca:	00009a17          	auipc	s4,0x9
    49ce:	a86a0a13          	addi	s4,s4,-1402 # d450 <buf>
    if(total != N*SZ){
    49d2:	6d05                	lui	s10,0x1
    49d4:	770d0d13          	addi	s10,s10,1904 # 1770 <exectest+0x176>
  for(i = 0; i < NCHILD; i++){
    49d8:	03400d93          	li	s11,52
    49dc:	a8dd                	j	4ad2 <fourfiles+0x1a8>
      printf("fork failed\n", s);
    49de:	85e6                	mv	a1,s9
    49e0:	00002517          	auipc	a0,0x2
    49e4:	30050513          	addi	a0,a0,768 # 6ce0 <malloc+0xdaa>
    49e8:	00001097          	auipc	ra,0x1
    49ec:	492080e7          	jalr	1170(ra) # 5e7a <printf>
      exit(1);
    49f0:	4505                	li	a0,1
    49f2:	00001097          	auipc	ra,0x1
    49f6:	122080e7          	jalr	290(ra) # 5b14 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    49fa:	20200593          	li	a1,514
    49fe:	854e                	mv	a0,s3
    4a00:	00001097          	auipc	ra,0x1
    4a04:	154080e7          	jalr	340(ra) # 5b54 <open>
    4a08:	892a                	mv	s2,a0
      if(fd < 0){
    4a0a:	04054663          	bltz	a0,4a56 <fourfiles+0x12c>
      memset(buf, '0'+pi, SZ);
    4a0e:	1f400613          	li	a2,500
    4a12:	0304859b          	addiw	a1,s1,48
    4a16:	00009517          	auipc	a0,0x9
    4a1a:	a3a50513          	addi	a0,a0,-1478 # d450 <buf>
    4a1e:	00001097          	auipc	ra,0x1
    4a22:	ee4080e7          	jalr	-284(ra) # 5902 <memset>
    4a26:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4a28:	1f400993          	li	s3,500
    4a2c:	00009a17          	auipc	s4,0x9
    4a30:	a24a0a13          	addi	s4,s4,-1500 # d450 <buf>
    4a34:	864e                	mv	a2,s3
    4a36:	85d2                	mv	a1,s4
    4a38:	854a                	mv	a0,s2
    4a3a:	00001097          	auipc	ra,0x1
    4a3e:	0fa080e7          	jalr	250(ra) # 5b34 <write>
    4a42:	85aa                	mv	a1,a0
    4a44:	03351763          	bne	a0,s3,4a72 <fourfiles+0x148>
      for(i = 0; i < N; i++){
    4a48:	34fd                	addiw	s1,s1,-1
    4a4a:	f4ed                	bnez	s1,4a34 <fourfiles+0x10a>
      exit(0);
    4a4c:	4501                	li	a0,0
    4a4e:	00001097          	auipc	ra,0x1
    4a52:	0c6080e7          	jalr	198(ra) # 5b14 <exit>
        printf("create failed\n", s);
    4a56:	85e6                	mv	a1,s9
    4a58:	00003517          	auipc	a0,0x3
    4a5c:	29050513          	addi	a0,a0,656 # 7ce8 <malloc+0x1db2>
    4a60:	00001097          	auipc	ra,0x1
    4a64:	41a080e7          	jalr	1050(ra) # 5e7a <printf>
        exit(1);
    4a68:	4505                	li	a0,1
    4a6a:	00001097          	auipc	ra,0x1
    4a6e:	0aa080e7          	jalr	170(ra) # 5b14 <exit>
          printf("write failed %d\n", n);
    4a72:	00003517          	auipc	a0,0x3
    4a76:	28650513          	addi	a0,a0,646 # 7cf8 <malloc+0x1dc2>
    4a7a:	00001097          	auipc	ra,0x1
    4a7e:	400080e7          	jalr	1024(ra) # 5e7a <printf>
          exit(1);
    4a82:	4505                	li	a0,1
    4a84:	00001097          	auipc	ra,0x1
    4a88:	090080e7          	jalr	144(ra) # 5b14 <exit>
      exit(xstatus);
    4a8c:	855a                	mv	a0,s6
    4a8e:	00001097          	auipc	ra,0x1
    4a92:	086080e7          	jalr	134(ra) # 5b14 <exit>
          printf("wrong char\n", s);
    4a96:	85e6                	mv	a1,s9
    4a98:	00003517          	auipc	a0,0x3
    4a9c:	27850513          	addi	a0,a0,632 # 7d10 <malloc+0x1dda>
    4aa0:	00001097          	auipc	ra,0x1
    4aa4:	3da080e7          	jalr	986(ra) # 5e7a <printf>
          exit(1);
    4aa8:	4505                	li	a0,1
    4aaa:	00001097          	auipc	ra,0x1
    4aae:	06a080e7          	jalr	106(ra) # 5b14 <exit>
    close(fd);
    4ab2:	854e                	mv	a0,s3
    4ab4:	00001097          	auipc	ra,0x1
    4ab8:	088080e7          	jalr	136(ra) # 5b3c <close>
    if(total != N*SZ){
    4abc:	05a91e63          	bne	s2,s10,4b18 <fourfiles+0x1ee>
    unlink(fname);
    4ac0:	8562                	mv	a0,s8
    4ac2:	00001097          	auipc	ra,0x1
    4ac6:	0a2080e7          	jalr	162(ra) # 5b64 <unlink>
  for(i = 0; i < NCHILD; i++){
    4aca:	0ba1                	addi	s7,s7,8
    4acc:	2485                	addiw	s1,s1,1
    4ace:	07b48363          	beq	s1,s11,4b34 <fourfiles+0x20a>
    fname = names[i];
    4ad2:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    4ad6:	4581                	li	a1,0
    4ad8:	8562                	mv	a0,s8
    4ada:	00001097          	auipc	ra,0x1
    4ade:	07a080e7          	jalr	122(ra) # 5b54 <open>
    4ae2:	89aa                	mv	s3,a0
    total = 0;
    4ae4:	895a                	mv	s2,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4ae6:	8656                	mv	a2,s5
    4ae8:	85d2                	mv	a1,s4
    4aea:	854e                	mv	a0,s3
    4aec:	00001097          	auipc	ra,0x1
    4af0:	040080e7          	jalr	64(ra) # 5b2c <read>
    4af4:	faa05fe3          	blez	a0,4ab2 <fourfiles+0x188>
    4af8:	00009797          	auipc	a5,0x9
    4afc:	95878793          	addi	a5,a5,-1704 # d450 <buf>
    4b00:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    4b04:	0007c703          	lbu	a4,0(a5)
    4b08:	f89717e3          	bne	a4,s1,4a96 <fourfiles+0x16c>
      for(j = 0; j < n; j++){
    4b0c:	0785                	addi	a5,a5,1
    4b0e:	fed79be3          	bne	a5,a3,4b04 <fourfiles+0x1da>
      total += n;
    4b12:	00a9093b          	addw	s2,s2,a0
    4b16:	bfc1                	j	4ae6 <fourfiles+0x1bc>
      printf("wrong length %d\n", total);
    4b18:	85ca                	mv	a1,s2
    4b1a:	00003517          	auipc	a0,0x3
    4b1e:	20650513          	addi	a0,a0,518 # 7d20 <malloc+0x1dea>
    4b22:	00001097          	auipc	ra,0x1
    4b26:	358080e7          	jalr	856(ra) # 5e7a <printf>
      exit(1);
    4b2a:	4505                	li	a0,1
    4b2c:	00001097          	auipc	ra,0x1
    4b30:	fe8080e7          	jalr	-24(ra) # 5b14 <exit>
}
    4b34:	60ea                	ld	ra,152(sp)
    4b36:	644a                	ld	s0,144(sp)
    4b38:	64aa                	ld	s1,136(sp)
    4b3a:	690a                	ld	s2,128(sp)
    4b3c:	79e6                	ld	s3,120(sp)
    4b3e:	7a46                	ld	s4,112(sp)
    4b40:	7aa6                	ld	s5,104(sp)
    4b42:	7b06                	ld	s6,96(sp)
    4b44:	6be6                	ld	s7,88(sp)
    4b46:	6c46                	ld	s8,80(sp)
    4b48:	6ca6                	ld	s9,72(sp)
    4b4a:	6d06                	ld	s10,64(sp)
    4b4c:	7de2                	ld	s11,56(sp)
    4b4e:	610d                	addi	sp,sp,160
    4b50:	8082                	ret

0000000000004b52 <concreate>:
{
    4b52:	7171                	addi	sp,sp,-176
    4b54:	f506                	sd	ra,168(sp)
    4b56:	f122                	sd	s0,160(sp)
    4b58:	ed26                	sd	s1,152(sp)
    4b5a:	e94a                	sd	s2,144(sp)
    4b5c:	e54e                	sd	s3,136(sp)
    4b5e:	e152                	sd	s4,128(sp)
    4b60:	fcd6                	sd	s5,120(sp)
    4b62:	f8da                	sd	s6,112(sp)
    4b64:	f4de                	sd	s7,104(sp)
    4b66:	f0e2                	sd	s8,96(sp)
    4b68:	ece6                	sd	s9,88(sp)
    4b6a:	e8ea                	sd	s10,80(sp)
    4b6c:	1900                	addi	s0,sp,176
    4b6e:	8d2a                	mv	s10,a0
  file[0] = 'C';
    4b70:	04300793          	li	a5,67
    4b74:	f8f40c23          	sb	a5,-104(s0)
  file[2] = '\0';
    4b78:	f8040d23          	sb	zero,-102(s0)
  for(i = 0; i < N; i++){
    4b7c:	4901                	li	s2,0
    unlink(file);
    4b7e:	f9840993          	addi	s3,s0,-104
    if(pid && (i % 3) == 1){
    4b82:	55555b37          	lui	s6,0x55555
    4b86:	556b0b13          	addi	s6,s6,1366 # 55555556 <__BSS_END__+0x555450f6>
    4b8a:	4b85                	li	s7,1
      fd = open(file, O_CREATE | O_RDWR);
    4b8c:	20200c13          	li	s8,514
      link("C0", file);
    4b90:	00003c97          	auipc	s9,0x3
    4b94:	1a8c8c93          	addi	s9,s9,424 # 7d38 <malloc+0x1e02>
      wait(&xstatus);
    4b98:	f5c40a93          	addi	s5,s0,-164
  for(i = 0; i < N; i++){
    4b9c:	02800a13          	li	s4,40
    4ba0:	a4d5                	j	4e84 <concreate+0x332>
      link("C0", file);
    4ba2:	85ce                	mv	a1,s3
    4ba4:	8566                	mv	a0,s9
    4ba6:	00001097          	auipc	ra,0x1
    4baa:	fce080e7          	jalr	-50(ra) # 5b74 <link>
    if(pid == 0) {
    4bae:	ac7d                	j	4e6c <concreate+0x31a>
    } else if(pid == 0 && (i % 5) == 1){
    4bb0:	666667b7          	lui	a5,0x66666
    4bb4:	66778793          	addi	a5,a5,1639 # 66666667 <__BSS_END__+0x66656207>
    4bb8:	02f907b3          	mul	a5,s2,a5
    4bbc:	9785                	srai	a5,a5,0x21
    4bbe:	41f9571b          	sraiw	a4,s2,0x1f
    4bc2:	9f99                	subw	a5,a5,a4
    4bc4:	0027971b          	slliw	a4,a5,0x2
    4bc8:	9fb9                	addw	a5,a5,a4
    4bca:	40f9093b          	subw	s2,s2,a5
    4bce:	4785                	li	a5,1
    4bd0:	02f90b63          	beq	s2,a5,4c06 <concreate+0xb4>
      fd = open(file, O_CREATE | O_RDWR);
    4bd4:	20200593          	li	a1,514
    4bd8:	f9840513          	addi	a0,s0,-104
    4bdc:	00001097          	auipc	ra,0x1
    4be0:	f78080e7          	jalr	-136(ra) # 5b54 <open>
      if(fd < 0){
    4be4:	26055b63          	bgez	a0,4e5a <concreate+0x308>
        printf("concreate create %s failed\n", file);
    4be8:	f9840593          	addi	a1,s0,-104
    4bec:	00003517          	auipc	a0,0x3
    4bf0:	15450513          	addi	a0,a0,340 # 7d40 <malloc+0x1e0a>
    4bf4:	00001097          	auipc	ra,0x1
    4bf8:	286080e7          	jalr	646(ra) # 5e7a <printf>
        exit(1);
    4bfc:	4505                	li	a0,1
    4bfe:	00001097          	auipc	ra,0x1
    4c02:	f16080e7          	jalr	-234(ra) # 5b14 <exit>
      link("C0", file);
    4c06:	f9840593          	addi	a1,s0,-104
    4c0a:	00003517          	auipc	a0,0x3
    4c0e:	12e50513          	addi	a0,a0,302 # 7d38 <malloc+0x1e02>
    4c12:	00001097          	auipc	ra,0x1
    4c16:	f62080e7          	jalr	-158(ra) # 5b74 <link>
      exit(0);
    4c1a:	4501                	li	a0,0
    4c1c:	00001097          	auipc	ra,0x1
    4c20:	ef8080e7          	jalr	-264(ra) # 5b14 <exit>
        exit(1);
    4c24:	4505                	li	a0,1
    4c26:	00001097          	auipc	ra,0x1
    4c2a:	eee080e7          	jalr	-274(ra) # 5b14 <exit>
  memset(fa, 0, sizeof(fa));
    4c2e:	02800613          	li	a2,40
    4c32:	4581                	li	a1,0
    4c34:	f7040513          	addi	a0,s0,-144
    4c38:	00001097          	auipc	ra,0x1
    4c3c:	cca080e7          	jalr	-822(ra) # 5902 <memset>
  fd = open(".", 0);
    4c40:	4581                	li	a1,0
    4c42:	00002517          	auipc	a0,0x2
    4c46:	ade50513          	addi	a0,a0,-1314 # 6720 <malloc+0x7ea>
    4c4a:	00001097          	auipc	ra,0x1
    4c4e:	f0a080e7          	jalr	-246(ra) # 5b54 <open>
    4c52:	892a                	mv	s2,a0
  n = 0;
    4c54:	8b26                	mv	s6,s1
  while(read(fd, &de, sizeof(de)) > 0){
    4c56:	f6040a13          	addi	s4,s0,-160
    4c5a:	49c1                	li	s3,16
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4c5c:	04300a93          	li	s5,67
      if(i < 0 || i >= sizeof(fa)){
    4c60:	02700b93          	li	s7,39
      fa[i] = 1;
    4c64:	4c05                	li	s8,1
  while(read(fd, &de, sizeof(de)) > 0){
    4c66:	864e                	mv	a2,s3
    4c68:	85d2                	mv	a1,s4
    4c6a:	854a                	mv	a0,s2
    4c6c:	00001097          	auipc	ra,0x1
    4c70:	ec0080e7          	jalr	-320(ra) # 5b2c <read>
    4c74:	06a05f63          	blez	a0,4cf2 <concreate+0x1a0>
    if(de.inum == 0)
    4c78:	f6045783          	lhu	a5,-160(s0)
    4c7c:	d7ed                	beqz	a5,4c66 <concreate+0x114>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4c7e:	f6244783          	lbu	a5,-158(s0)
    4c82:	ff5792e3          	bne	a5,s5,4c66 <concreate+0x114>
    4c86:	f6444783          	lbu	a5,-156(s0)
    4c8a:	fff1                	bnez	a5,4c66 <concreate+0x114>
      i = de.name[1] - '0';
    4c8c:	f6344783          	lbu	a5,-157(s0)
    4c90:	fd07879b          	addiw	a5,a5,-48
      if(i < 0 || i >= sizeof(fa)){
    4c94:	00fbef63          	bltu	s7,a5,4cb2 <concreate+0x160>
      if(fa[i]){
    4c98:	fa078713          	addi	a4,a5,-96
    4c9c:	9722                	add	a4,a4,s0
    4c9e:	fd074703          	lbu	a4,-48(a4) # fd0 <bigdir+0x24>
    4ca2:	eb05                	bnez	a4,4cd2 <concreate+0x180>
      fa[i] = 1;
    4ca4:	fa078793          	addi	a5,a5,-96
    4ca8:	97a2                	add	a5,a5,s0
    4caa:	fd878823          	sb	s8,-48(a5)
      n++;
    4cae:	2b05                	addiw	s6,s6,1
    4cb0:	bf5d                	j	4c66 <concreate+0x114>
        printf("%s: concreate weird file %s\n", s, de.name);
    4cb2:	f6240613          	addi	a2,s0,-158
    4cb6:	85ea                	mv	a1,s10
    4cb8:	00003517          	auipc	a0,0x3
    4cbc:	0a850513          	addi	a0,a0,168 # 7d60 <malloc+0x1e2a>
    4cc0:	00001097          	auipc	ra,0x1
    4cc4:	1ba080e7          	jalr	442(ra) # 5e7a <printf>
        exit(1);
    4cc8:	4505                	li	a0,1
    4cca:	00001097          	auipc	ra,0x1
    4cce:	e4a080e7          	jalr	-438(ra) # 5b14 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4cd2:	f6240613          	addi	a2,s0,-158
    4cd6:	85ea                	mv	a1,s10
    4cd8:	00003517          	auipc	a0,0x3
    4cdc:	0a850513          	addi	a0,a0,168 # 7d80 <malloc+0x1e4a>
    4ce0:	00001097          	auipc	ra,0x1
    4ce4:	19a080e7          	jalr	410(ra) # 5e7a <printf>
        exit(1);
    4ce8:	4505                	li	a0,1
    4cea:	00001097          	auipc	ra,0x1
    4cee:	e2a080e7          	jalr	-470(ra) # 5b14 <exit>
  close(fd);
    4cf2:	854a                	mv	a0,s2
    4cf4:	00001097          	auipc	ra,0x1
    4cf8:	e48080e7          	jalr	-440(ra) # 5b3c <close>
  if(n != N){
    4cfc:	02800793          	li	a5,40
    4d00:	00fb1a63          	bne	s6,a5,4d14 <concreate+0x1c2>
    if(((i % 3) == 0 && pid == 0) ||
    4d04:	55555a37          	lui	s4,0x55555
    4d08:	556a0a13          	addi	s4,s4,1366 # 55555556 <__BSS_END__+0x555450f6>
      close(open(file, 0));
    4d0c:	f9840993          	addi	s3,s0,-104
  for(i = 0; i < N; i++){
    4d10:	8ada                	mv	s5,s6
    4d12:	a0d9                	j	4dd8 <concreate+0x286>
    printf("%s: concreate not enough files in directory listing\n", s);
    4d14:	85ea                	mv	a1,s10
    4d16:	00003517          	auipc	a0,0x3
    4d1a:	09250513          	addi	a0,a0,146 # 7da8 <malloc+0x1e72>
    4d1e:	00001097          	auipc	ra,0x1
    4d22:	15c080e7          	jalr	348(ra) # 5e7a <printf>
    exit(1);
    4d26:	4505                	li	a0,1
    4d28:	00001097          	auipc	ra,0x1
    4d2c:	dec080e7          	jalr	-532(ra) # 5b14 <exit>
      printf("%s: fork failed\n", s);
    4d30:	85ea                	mv	a1,s10
    4d32:	00002517          	auipc	a0,0x2
    4d36:	b8e50513          	addi	a0,a0,-1138 # 68c0 <malloc+0x98a>
    4d3a:	00001097          	auipc	ra,0x1
    4d3e:	140080e7          	jalr	320(ra) # 5e7a <printf>
      exit(1);
    4d42:	4505                	li	a0,1
    4d44:	00001097          	auipc	ra,0x1
    4d48:	dd0080e7          	jalr	-560(ra) # 5b14 <exit>
      close(open(file, 0));
    4d4c:	4581                	li	a1,0
    4d4e:	854e                	mv	a0,s3
    4d50:	00001097          	auipc	ra,0x1
    4d54:	e04080e7          	jalr	-508(ra) # 5b54 <open>
    4d58:	00001097          	auipc	ra,0x1
    4d5c:	de4080e7          	jalr	-540(ra) # 5b3c <close>
      close(open(file, 0));
    4d60:	4581                	li	a1,0
    4d62:	854e                	mv	a0,s3
    4d64:	00001097          	auipc	ra,0x1
    4d68:	df0080e7          	jalr	-528(ra) # 5b54 <open>
    4d6c:	00001097          	auipc	ra,0x1
    4d70:	dd0080e7          	jalr	-560(ra) # 5b3c <close>
      close(open(file, 0));
    4d74:	4581                	li	a1,0
    4d76:	854e                	mv	a0,s3
    4d78:	00001097          	auipc	ra,0x1
    4d7c:	ddc080e7          	jalr	-548(ra) # 5b54 <open>
    4d80:	00001097          	auipc	ra,0x1
    4d84:	dbc080e7          	jalr	-580(ra) # 5b3c <close>
      close(open(file, 0));
    4d88:	4581                	li	a1,0
    4d8a:	854e                	mv	a0,s3
    4d8c:	00001097          	auipc	ra,0x1
    4d90:	dc8080e7          	jalr	-568(ra) # 5b54 <open>
    4d94:	00001097          	auipc	ra,0x1
    4d98:	da8080e7          	jalr	-600(ra) # 5b3c <close>
      close(open(file, 0));
    4d9c:	4581                	li	a1,0
    4d9e:	854e                	mv	a0,s3
    4da0:	00001097          	auipc	ra,0x1
    4da4:	db4080e7          	jalr	-588(ra) # 5b54 <open>
    4da8:	00001097          	auipc	ra,0x1
    4dac:	d94080e7          	jalr	-620(ra) # 5b3c <close>
      close(open(file, 0));
    4db0:	4581                	li	a1,0
    4db2:	854e                	mv	a0,s3
    4db4:	00001097          	auipc	ra,0x1
    4db8:	da0080e7          	jalr	-608(ra) # 5b54 <open>
    4dbc:	00001097          	auipc	ra,0x1
    4dc0:	d80080e7          	jalr	-640(ra) # 5b3c <close>
    if(pid == 0)
    4dc4:	08090663          	beqz	s2,4e50 <concreate+0x2fe>
      wait(0);
    4dc8:	4501                	li	a0,0
    4dca:	00001097          	auipc	ra,0x1
    4dce:	d52080e7          	jalr	-686(ra) # 5b1c <wait>
  for(i = 0; i < N; i++){
    4dd2:	2485                	addiw	s1,s1,1
    4dd4:	0f548d63          	beq	s1,s5,4ece <concreate+0x37c>
    file[1] = '0' + i;
    4dd8:	0304879b          	addiw	a5,s1,48
    4ddc:	f8f40ca3          	sb	a5,-103(s0)
    pid = fork();
    4de0:	00001097          	auipc	ra,0x1
    4de4:	d2c080e7          	jalr	-724(ra) # 5b0c <fork>
    4de8:	892a                	mv	s2,a0
    if(pid < 0){
    4dea:	f40543e3          	bltz	a0,4d30 <concreate+0x1de>
    if(((i % 3) == 0 && pid == 0) ||
    4dee:	03448733          	mul	a4,s1,s4
    4df2:	9301                	srli	a4,a4,0x20
    4df4:	41f4d79b          	sraiw	a5,s1,0x1f
    4df8:	9f1d                	subw	a4,a4,a5
    4dfa:	0017179b          	slliw	a5,a4,0x1
    4dfe:	9fb9                	addw	a5,a5,a4
    4e00:	40f487bb          	subw	a5,s1,a5
    4e04:	00a7e733          	or	a4,a5,a0
    4e08:	2701                	sext.w	a4,a4
    4e0a:	d329                	beqz	a4,4d4c <concreate+0x1fa>
       ((i % 3) == 1 && pid != 0)){
    4e0c:	c119                	beqz	a0,4e12 <concreate+0x2c0>
    if(((i % 3) == 0 && pid == 0) ||
    4e0e:	17fd                	addi	a5,a5,-1
       ((i % 3) == 1 && pid != 0)){
    4e10:	df95                	beqz	a5,4d4c <concreate+0x1fa>
      unlink(file);
    4e12:	854e                	mv	a0,s3
    4e14:	00001097          	auipc	ra,0x1
    4e18:	d50080e7          	jalr	-688(ra) # 5b64 <unlink>
      unlink(file);
    4e1c:	854e                	mv	a0,s3
    4e1e:	00001097          	auipc	ra,0x1
    4e22:	d46080e7          	jalr	-698(ra) # 5b64 <unlink>
      unlink(file);
    4e26:	854e                	mv	a0,s3
    4e28:	00001097          	auipc	ra,0x1
    4e2c:	d3c080e7          	jalr	-708(ra) # 5b64 <unlink>
      unlink(file);
    4e30:	854e                	mv	a0,s3
    4e32:	00001097          	auipc	ra,0x1
    4e36:	d32080e7          	jalr	-718(ra) # 5b64 <unlink>
      unlink(file);
    4e3a:	854e                	mv	a0,s3
    4e3c:	00001097          	auipc	ra,0x1
    4e40:	d28080e7          	jalr	-728(ra) # 5b64 <unlink>
      unlink(file);
    4e44:	854e                	mv	a0,s3
    4e46:	00001097          	auipc	ra,0x1
    4e4a:	d1e080e7          	jalr	-738(ra) # 5b64 <unlink>
    4e4e:	bf9d                	j	4dc4 <concreate+0x272>
      exit(0);
    4e50:	4501                	li	a0,0
    4e52:	00001097          	auipc	ra,0x1
    4e56:	cc2080e7          	jalr	-830(ra) # 5b14 <exit>
      close(fd);
    4e5a:	00001097          	auipc	ra,0x1
    4e5e:	ce2080e7          	jalr	-798(ra) # 5b3c <close>
    if(pid == 0) {
    4e62:	bb65                	j	4c1a <concreate+0xc8>
      close(fd);
    4e64:	00001097          	auipc	ra,0x1
    4e68:	cd8080e7          	jalr	-808(ra) # 5b3c <close>
      wait(&xstatus);
    4e6c:	8556                	mv	a0,s5
    4e6e:	00001097          	auipc	ra,0x1
    4e72:	cae080e7          	jalr	-850(ra) # 5b1c <wait>
      if(xstatus != 0)
    4e76:	f5c42483          	lw	s1,-164(s0)
    4e7a:	da0495e3          	bnez	s1,4c24 <concreate+0xd2>
  for(i = 0; i < N; i++){
    4e7e:	2905                	addiw	s2,s2,1
    4e80:	db4907e3          	beq	s2,s4,4c2e <concreate+0xdc>
    file[1] = '0' + i;
    4e84:	0309079b          	addiw	a5,s2,48
    4e88:	f8f40ca3          	sb	a5,-103(s0)
    unlink(file);
    4e8c:	854e                	mv	a0,s3
    4e8e:	00001097          	auipc	ra,0x1
    4e92:	cd6080e7          	jalr	-810(ra) # 5b64 <unlink>
    pid = fork();
    4e96:	00001097          	auipc	ra,0x1
    4e9a:	c76080e7          	jalr	-906(ra) # 5b0c <fork>
    if(pid && (i % 3) == 1){
    4e9e:	d00509e3          	beqz	a0,4bb0 <concreate+0x5e>
    4ea2:	036907b3          	mul	a5,s2,s6
    4ea6:	9381                	srli	a5,a5,0x20
    4ea8:	41f9571b          	sraiw	a4,s2,0x1f
    4eac:	9f99                	subw	a5,a5,a4
    4eae:	0017971b          	slliw	a4,a5,0x1
    4eb2:	9fb9                	addw	a5,a5,a4
    4eb4:	40f907bb          	subw	a5,s2,a5
    4eb8:	cf7785e3          	beq	a5,s7,4ba2 <concreate+0x50>
      fd = open(file, O_CREATE | O_RDWR);
    4ebc:	85e2                	mv	a1,s8
    4ebe:	854e                	mv	a0,s3
    4ec0:	00001097          	auipc	ra,0x1
    4ec4:	c94080e7          	jalr	-876(ra) # 5b54 <open>
      if(fd < 0){
    4ec8:	f8055ee3          	bgez	a0,4e64 <concreate+0x312>
    4ecc:	bb31                	j	4be8 <concreate+0x96>
}
    4ece:	70aa                	ld	ra,168(sp)
    4ed0:	740a                	ld	s0,160(sp)
    4ed2:	64ea                	ld	s1,152(sp)
    4ed4:	694a                	ld	s2,144(sp)
    4ed6:	69aa                	ld	s3,136(sp)
    4ed8:	6a0a                	ld	s4,128(sp)
    4eda:	7ae6                	ld	s5,120(sp)
    4edc:	7b46                	ld	s6,112(sp)
    4ede:	7ba6                	ld	s7,104(sp)
    4ee0:	7c06                	ld	s8,96(sp)
    4ee2:	6ce6                	ld	s9,88(sp)
    4ee4:	6d46                	ld	s10,80(sp)
    4ee6:	614d                	addi	sp,sp,176
    4ee8:	8082                	ret

0000000000004eea <bigfile>:
{
    4eea:	7139                	addi	sp,sp,-64
    4eec:	fc06                	sd	ra,56(sp)
    4eee:	f822                	sd	s0,48(sp)
    4ef0:	f426                	sd	s1,40(sp)
    4ef2:	f04a                	sd	s2,32(sp)
    4ef4:	ec4e                	sd	s3,24(sp)
    4ef6:	e852                	sd	s4,16(sp)
    4ef8:	e456                	sd	s5,8(sp)
    4efa:	e05a                	sd	s6,0(sp)
    4efc:	0080                	addi	s0,sp,64
    4efe:	8b2a                	mv	s6,a0
  unlink("bigfile.dat");
    4f00:	00003517          	auipc	a0,0x3
    4f04:	ee050513          	addi	a0,a0,-288 # 7de0 <malloc+0x1eaa>
    4f08:	00001097          	auipc	ra,0x1
    4f0c:	c5c080e7          	jalr	-932(ra) # 5b64 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4f10:	20200593          	li	a1,514
    4f14:	00003517          	auipc	a0,0x3
    4f18:	ecc50513          	addi	a0,a0,-308 # 7de0 <malloc+0x1eaa>
    4f1c:	00001097          	auipc	ra,0x1
    4f20:	c38080e7          	jalr	-968(ra) # 5b54 <open>
  if(fd < 0){
    4f24:	0a054463          	bltz	a0,4fcc <bigfile+0xe2>
    4f28:	8a2a                	mv	s4,a0
    4f2a:	4481                	li	s1,0
    memset(buf, i, SZ);
    4f2c:	25800913          	li	s2,600
    4f30:	00008997          	auipc	s3,0x8
    4f34:	52098993          	addi	s3,s3,1312 # d450 <buf>
  for(i = 0; i < N; i++){
    4f38:	4ad1                	li	s5,20
    memset(buf, i, SZ);
    4f3a:	864a                	mv	a2,s2
    4f3c:	85a6                	mv	a1,s1
    4f3e:	854e                	mv	a0,s3
    4f40:	00001097          	auipc	ra,0x1
    4f44:	9c2080e7          	jalr	-1598(ra) # 5902 <memset>
    if(write(fd, buf, SZ) != SZ){
    4f48:	864a                	mv	a2,s2
    4f4a:	85ce                	mv	a1,s3
    4f4c:	8552                	mv	a0,s4
    4f4e:	00001097          	auipc	ra,0x1
    4f52:	be6080e7          	jalr	-1050(ra) # 5b34 <write>
    4f56:	09251963          	bne	a0,s2,4fe8 <bigfile+0xfe>
  for(i = 0; i < N; i++){
    4f5a:	2485                	addiw	s1,s1,1
    4f5c:	fd549fe3          	bne	s1,s5,4f3a <bigfile+0x50>
  close(fd);
    4f60:	8552                	mv	a0,s4
    4f62:	00001097          	auipc	ra,0x1
    4f66:	bda080e7          	jalr	-1062(ra) # 5b3c <close>
  fd = open("bigfile.dat", 0);
    4f6a:	4581                	li	a1,0
    4f6c:	00003517          	auipc	a0,0x3
    4f70:	e7450513          	addi	a0,a0,-396 # 7de0 <malloc+0x1eaa>
    4f74:	00001097          	auipc	ra,0x1
    4f78:	be0080e7          	jalr	-1056(ra) # 5b54 <open>
    4f7c:	8aaa                	mv	s5,a0
  total = 0;
    4f7e:	4a01                	li	s4,0
  for(i = 0; ; i++){
    4f80:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4f82:	12c00993          	li	s3,300
    4f86:	00008917          	auipc	s2,0x8
    4f8a:	4ca90913          	addi	s2,s2,1226 # d450 <buf>
  if(fd < 0){
    4f8e:	06054b63          	bltz	a0,5004 <bigfile+0x11a>
    cc = read(fd, buf, SZ/2);
    4f92:	864e                	mv	a2,s3
    4f94:	85ca                	mv	a1,s2
    4f96:	8556                	mv	a0,s5
    4f98:	00001097          	auipc	ra,0x1
    4f9c:	b94080e7          	jalr	-1132(ra) # 5b2c <read>
    if(cc < 0){
    4fa0:	08054063          	bltz	a0,5020 <bigfile+0x136>
    if(cc == 0)
    4fa4:	c961                	beqz	a0,5074 <bigfile+0x18a>
    if(cc != SZ/2){
    4fa6:	09351b63          	bne	a0,s3,503c <bigfile+0x152>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4faa:	01f4d79b          	srliw	a5,s1,0x1f
    4fae:	9fa5                	addw	a5,a5,s1
    4fb0:	4017d79b          	sraiw	a5,a5,0x1
    4fb4:	00094703          	lbu	a4,0(s2)
    4fb8:	0af71063          	bne	a4,a5,5058 <bigfile+0x16e>
    4fbc:	12b94703          	lbu	a4,299(s2)
    4fc0:	08f71c63          	bne	a4,a5,5058 <bigfile+0x16e>
    total += cc;
    4fc4:	12ca0a1b          	addiw	s4,s4,300
  for(i = 0; ; i++){
    4fc8:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4fca:	b7e1                	j	4f92 <bigfile+0xa8>
    printf("%s: cannot create bigfile", s);
    4fcc:	85da                	mv	a1,s6
    4fce:	00003517          	auipc	a0,0x3
    4fd2:	e2250513          	addi	a0,a0,-478 # 7df0 <malloc+0x1eba>
    4fd6:	00001097          	auipc	ra,0x1
    4fda:	ea4080e7          	jalr	-348(ra) # 5e7a <printf>
    exit(1);
    4fde:	4505                	li	a0,1
    4fe0:	00001097          	auipc	ra,0x1
    4fe4:	b34080e7          	jalr	-1228(ra) # 5b14 <exit>
      printf("%s: write bigfile failed\n", s);
    4fe8:	85da                	mv	a1,s6
    4fea:	00003517          	auipc	a0,0x3
    4fee:	e2650513          	addi	a0,a0,-474 # 7e10 <malloc+0x1eda>
    4ff2:	00001097          	auipc	ra,0x1
    4ff6:	e88080e7          	jalr	-376(ra) # 5e7a <printf>
      exit(1);
    4ffa:	4505                	li	a0,1
    4ffc:	00001097          	auipc	ra,0x1
    5000:	b18080e7          	jalr	-1256(ra) # 5b14 <exit>
    printf("%s: cannot open bigfile\n", s);
    5004:	85da                	mv	a1,s6
    5006:	00003517          	auipc	a0,0x3
    500a:	e2a50513          	addi	a0,a0,-470 # 7e30 <malloc+0x1efa>
    500e:	00001097          	auipc	ra,0x1
    5012:	e6c080e7          	jalr	-404(ra) # 5e7a <printf>
    exit(1);
    5016:	4505                	li	a0,1
    5018:	00001097          	auipc	ra,0x1
    501c:	afc080e7          	jalr	-1284(ra) # 5b14 <exit>
      printf("%s: read bigfile failed\n", s);
    5020:	85da                	mv	a1,s6
    5022:	00003517          	auipc	a0,0x3
    5026:	e2e50513          	addi	a0,a0,-466 # 7e50 <malloc+0x1f1a>
    502a:	00001097          	auipc	ra,0x1
    502e:	e50080e7          	jalr	-432(ra) # 5e7a <printf>
      exit(1);
    5032:	4505                	li	a0,1
    5034:	00001097          	auipc	ra,0x1
    5038:	ae0080e7          	jalr	-1312(ra) # 5b14 <exit>
      printf("%s: short read bigfile\n", s);
    503c:	85da                	mv	a1,s6
    503e:	00003517          	auipc	a0,0x3
    5042:	e3250513          	addi	a0,a0,-462 # 7e70 <malloc+0x1f3a>
    5046:	00001097          	auipc	ra,0x1
    504a:	e34080e7          	jalr	-460(ra) # 5e7a <printf>
      exit(1);
    504e:	4505                	li	a0,1
    5050:	00001097          	auipc	ra,0x1
    5054:	ac4080e7          	jalr	-1340(ra) # 5b14 <exit>
      printf("%s: read bigfile wrong data\n", s);
    5058:	85da                	mv	a1,s6
    505a:	00003517          	auipc	a0,0x3
    505e:	e2e50513          	addi	a0,a0,-466 # 7e88 <malloc+0x1f52>
    5062:	00001097          	auipc	ra,0x1
    5066:	e18080e7          	jalr	-488(ra) # 5e7a <printf>
      exit(1);
    506a:	4505                	li	a0,1
    506c:	00001097          	auipc	ra,0x1
    5070:	aa8080e7          	jalr	-1368(ra) # 5b14 <exit>
  close(fd);
    5074:	8556                	mv	a0,s5
    5076:	00001097          	auipc	ra,0x1
    507a:	ac6080e7          	jalr	-1338(ra) # 5b3c <close>
  if(total != N*SZ){
    507e:	678d                	lui	a5,0x3
    5080:	ee078793          	addi	a5,a5,-288 # 2ee0 <execout+0x74>
    5084:	02fa1463          	bne	s4,a5,50ac <bigfile+0x1c2>
  unlink("bigfile.dat");
    5088:	00003517          	auipc	a0,0x3
    508c:	d5850513          	addi	a0,a0,-680 # 7de0 <malloc+0x1eaa>
    5090:	00001097          	auipc	ra,0x1
    5094:	ad4080e7          	jalr	-1324(ra) # 5b64 <unlink>
}
    5098:	70e2                	ld	ra,56(sp)
    509a:	7442                	ld	s0,48(sp)
    509c:	74a2                	ld	s1,40(sp)
    509e:	7902                	ld	s2,32(sp)
    50a0:	69e2                	ld	s3,24(sp)
    50a2:	6a42                	ld	s4,16(sp)
    50a4:	6aa2                	ld	s5,8(sp)
    50a6:	6b02                	ld	s6,0(sp)
    50a8:	6121                	addi	sp,sp,64
    50aa:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    50ac:	85da                	mv	a1,s6
    50ae:	00003517          	auipc	a0,0x3
    50b2:	dfa50513          	addi	a0,a0,-518 # 7ea8 <malloc+0x1f72>
    50b6:	00001097          	auipc	ra,0x1
    50ba:	dc4080e7          	jalr	-572(ra) # 5e7a <printf>
    exit(1);
    50be:	4505                	li	a0,1
    50c0:	00001097          	auipc	ra,0x1
    50c4:	a54080e7          	jalr	-1452(ra) # 5b14 <exit>

00000000000050c8 <fsfull>:
{
    50c8:	7171                	addi	sp,sp,-176
    50ca:	f506                	sd	ra,168(sp)
    50cc:	f122                	sd	s0,160(sp)
    50ce:	ed26                	sd	s1,152(sp)
    50d0:	e94a                	sd	s2,144(sp)
    50d2:	e54e                	sd	s3,136(sp)
    50d4:	e152                	sd	s4,128(sp)
    50d6:	fcd6                	sd	s5,120(sp)
    50d8:	f8da                	sd	s6,112(sp)
    50da:	f4de                	sd	s7,104(sp)
    50dc:	f0e2                	sd	s8,96(sp)
    50de:	ece6                	sd	s9,88(sp)
    50e0:	e8ea                	sd	s10,80(sp)
    50e2:	e4ee                	sd	s11,72(sp)
    50e4:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    50e6:	00003517          	auipc	a0,0x3
    50ea:	de250513          	addi	a0,a0,-542 # 7ec8 <malloc+0x1f92>
    50ee:	00001097          	auipc	ra,0x1
    50f2:	d8c080e7          	jalr	-628(ra) # 5e7a <printf>
  for(nfiles = 0; ; nfiles++){
    50f6:	4481                	li	s1,0
    name[0] = 'f';
    50f8:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    50fc:	10625cb7          	lui	s9,0x10625
    5100:	dd3c8c93          	addi	s9,s9,-557 # 10624dd3 <__BSS_END__+0x10614973>
    name[2] = '0' + (nfiles % 1000) / 100;
    5104:	51eb8ab7          	lui	s5,0x51eb8
    5108:	51fa8a93          	addi	s5,s5,1311 # 51eb851f <__BSS_END__+0x51ea80bf>
    name[3] = '0' + (nfiles % 100) / 10;
    510c:	66666a37          	lui	s4,0x66666
    5110:	667a0a13          	addi	s4,s4,1639 # 66666667 <__BSS_END__+0x66656207>
    printf("writing %s\n", name);
    5114:	f5040d13          	addi	s10,s0,-176
    name[0] = 'f';
    5118:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    511c:	039487b3          	mul	a5,s1,s9
    5120:	9799                	srai	a5,a5,0x26
    5122:	41f4d69b          	sraiw	a3,s1,0x1f
    5126:	9f95                	subw	a5,a5,a3
    5128:	0307871b          	addiw	a4,a5,48
    512c:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5130:	3e800713          	li	a4,1000
    5134:	02f707bb          	mulw	a5,a4,a5
    5138:	40f487bb          	subw	a5,s1,a5
    513c:	03578733          	mul	a4,a5,s5
    5140:	9715                	srai	a4,a4,0x25
    5142:	41f7d79b          	sraiw	a5,a5,0x1f
    5146:	40f707bb          	subw	a5,a4,a5
    514a:	0307879b          	addiw	a5,a5,48
    514e:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5152:	035487b3          	mul	a5,s1,s5
    5156:	9795                	srai	a5,a5,0x25
    5158:	9f95                	subw	a5,a5,a3
    515a:	06400713          	li	a4,100
    515e:	02f707bb          	mulw	a5,a4,a5
    5162:	40f487bb          	subw	a5,s1,a5
    5166:	03478733          	mul	a4,a5,s4
    516a:	9709                	srai	a4,a4,0x22
    516c:	41f7d79b          	sraiw	a5,a5,0x1f
    5170:	40f707bb          	subw	a5,a4,a5
    5174:	0307879b          	addiw	a5,a5,48
    5178:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    517c:	03448733          	mul	a4,s1,s4
    5180:	9709                	srai	a4,a4,0x22
    5182:	9f15                	subw	a4,a4,a3
    5184:	0027179b          	slliw	a5,a4,0x2
    5188:	9fb9                	addw	a5,a5,a4
    518a:	0017979b          	slliw	a5,a5,0x1
    518e:	40f487bb          	subw	a5,s1,a5
    5192:	0307879b          	addiw	a5,a5,48
    5196:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    519a:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    519e:	85ea                	mv	a1,s10
    51a0:	00003517          	auipc	a0,0x3
    51a4:	d3850513          	addi	a0,a0,-712 # 7ed8 <malloc+0x1fa2>
    51a8:	00001097          	auipc	ra,0x1
    51ac:	cd2080e7          	jalr	-814(ra) # 5e7a <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    51b0:	20200593          	li	a1,514
    51b4:	856a                	mv	a0,s10
    51b6:	00001097          	auipc	ra,0x1
    51ba:	99e080e7          	jalr	-1634(ra) # 5b54 <open>
    51be:	892a                	mv	s2,a0
    if(fd < 0){
    51c0:	10055163          	bgez	a0,52c2 <fsfull+0x1fa>
      printf("open %s failed\n", name);
    51c4:	f5040593          	addi	a1,s0,-176
    51c8:	00003517          	auipc	a0,0x3
    51cc:	d2050513          	addi	a0,a0,-736 # 7ee8 <malloc+0x1fb2>
    51d0:	00001097          	auipc	ra,0x1
    51d4:	caa080e7          	jalr	-854(ra) # 5e7a <printf>
  while(nfiles >= 0){
    51d8:	0a04ce63          	bltz	s1,5294 <fsfull+0x1cc>
    name[0] = 'f';
    51dc:	06600c13          	li	s8,102
    name[1] = '0' + nfiles / 1000;
    51e0:	10625a37          	lui	s4,0x10625
    51e4:	dd3a0a13          	addi	s4,s4,-557 # 10624dd3 <__BSS_END__+0x10614973>
    name[2] = '0' + (nfiles % 1000) / 100;
    51e8:	3e800b93          	li	s7,1000
    51ec:	51eb89b7          	lui	s3,0x51eb8
    51f0:	51f98993          	addi	s3,s3,1311 # 51eb851f <__BSS_END__+0x51ea80bf>
    name[3] = '0' + (nfiles % 100) / 10;
    51f4:	06400b13          	li	s6,100
    51f8:	66666937          	lui	s2,0x66666
    51fc:	66790913          	addi	s2,s2,1639 # 66666667 <__BSS_END__+0x66656207>
    unlink(name);
    5200:	f5040a93          	addi	s5,s0,-176
    name[0] = 'f';
    5204:	f5840823          	sb	s8,-176(s0)
    name[1] = '0' + nfiles / 1000;
    5208:	034487b3          	mul	a5,s1,s4
    520c:	9799                	srai	a5,a5,0x26
    520e:	41f4d69b          	sraiw	a3,s1,0x1f
    5212:	9f95                	subw	a5,a5,a3
    5214:	0307871b          	addiw	a4,a5,48
    5218:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    521c:	02fb87bb          	mulw	a5,s7,a5
    5220:	40f487bb          	subw	a5,s1,a5
    5224:	03378733          	mul	a4,a5,s3
    5228:	9715                	srai	a4,a4,0x25
    522a:	41f7d79b          	sraiw	a5,a5,0x1f
    522e:	40f707bb          	subw	a5,a4,a5
    5232:	0307879b          	addiw	a5,a5,48
    5236:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    523a:	033487b3          	mul	a5,s1,s3
    523e:	9795                	srai	a5,a5,0x25
    5240:	9f95                	subw	a5,a5,a3
    5242:	02fb07bb          	mulw	a5,s6,a5
    5246:	40f487bb          	subw	a5,s1,a5
    524a:	03278733          	mul	a4,a5,s2
    524e:	9709                	srai	a4,a4,0x22
    5250:	41f7d79b          	sraiw	a5,a5,0x1f
    5254:	40f707bb          	subw	a5,a4,a5
    5258:	0307879b          	addiw	a5,a5,48
    525c:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5260:	03248733          	mul	a4,s1,s2
    5264:	9709                	srai	a4,a4,0x22
    5266:	9f15                	subw	a4,a4,a3
    5268:	0027179b          	slliw	a5,a4,0x2
    526c:	9fb9                	addw	a5,a5,a4
    526e:	0017979b          	slliw	a5,a5,0x1
    5272:	40f487bb          	subw	a5,s1,a5
    5276:	0307879b          	addiw	a5,a5,48
    527a:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    527e:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    5282:	8556                	mv	a0,s5
    5284:	00001097          	auipc	ra,0x1
    5288:	8e0080e7          	jalr	-1824(ra) # 5b64 <unlink>
    nfiles--;
    528c:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    528e:	57fd                	li	a5,-1
    5290:	f6f49ae3          	bne	s1,a5,5204 <fsfull+0x13c>
  printf("fsfull test finished\n");
    5294:	00003517          	auipc	a0,0x3
    5298:	c7450513          	addi	a0,a0,-908 # 7f08 <malloc+0x1fd2>
    529c:	00001097          	auipc	ra,0x1
    52a0:	bde080e7          	jalr	-1058(ra) # 5e7a <printf>
}
    52a4:	70aa                	ld	ra,168(sp)
    52a6:	740a                	ld	s0,160(sp)
    52a8:	64ea                	ld	s1,152(sp)
    52aa:	694a                	ld	s2,144(sp)
    52ac:	69aa                	ld	s3,136(sp)
    52ae:	6a0a                	ld	s4,128(sp)
    52b0:	7ae6                	ld	s5,120(sp)
    52b2:	7b46                	ld	s6,112(sp)
    52b4:	7ba6                	ld	s7,104(sp)
    52b6:	7c06                	ld	s8,96(sp)
    52b8:	6ce6                	ld	s9,88(sp)
    52ba:	6d46                	ld	s10,80(sp)
    52bc:	6da6                	ld	s11,72(sp)
    52be:	614d                	addi	sp,sp,176
    52c0:	8082                	ret
    int total = 0;
    52c2:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    52c4:	40000c13          	li	s8,1024
    52c8:	00008b97          	auipc	s7,0x8
    52cc:	188b8b93          	addi	s7,s7,392 # d450 <buf>
      if(cc < BSIZE)
    52d0:	3ff00b13          	li	s6,1023
      int cc = write(fd, buf, BSIZE);
    52d4:	8662                	mv	a2,s8
    52d6:	85de                	mv	a1,s7
    52d8:	854a                	mv	a0,s2
    52da:	00001097          	auipc	ra,0x1
    52de:	85a080e7          	jalr	-1958(ra) # 5b34 <write>
      if(cc < BSIZE)
    52e2:	00ab5563          	bge	s6,a0,52ec <fsfull+0x224>
      total += cc;
    52e6:	00a989bb          	addw	s3,s3,a0
    while(1){
    52ea:	b7ed                	j	52d4 <fsfull+0x20c>
    printf("wrote %d bytes\n", total);
    52ec:	85ce                	mv	a1,s3
    52ee:	00003517          	auipc	a0,0x3
    52f2:	c0a50513          	addi	a0,a0,-1014 # 7ef8 <malloc+0x1fc2>
    52f6:	00001097          	auipc	ra,0x1
    52fa:	b84080e7          	jalr	-1148(ra) # 5e7a <printf>
    close(fd);
    52fe:	854a                	mv	a0,s2
    5300:	00001097          	auipc	ra,0x1
    5304:	83c080e7          	jalr	-1988(ra) # 5b3c <close>
    if(total == 0)
    5308:	ec0988e3          	beqz	s3,51d8 <fsfull+0x110>
  for(nfiles = 0; ; nfiles++){
    530c:	2485                	addiw	s1,s1,1
    530e:	b529                	j	5118 <fsfull+0x50>

0000000000005310 <badwrite>:
{
    5310:	7139                	addi	sp,sp,-64
    5312:	fc06                	sd	ra,56(sp)
    5314:	f822                	sd	s0,48(sp)
    5316:	f426                	sd	s1,40(sp)
    5318:	f04a                	sd	s2,32(sp)
    531a:	ec4e                	sd	s3,24(sp)
    531c:	e852                	sd	s4,16(sp)
    531e:	e456                	sd	s5,8(sp)
    5320:	e05a                	sd	s6,0(sp)
    5322:	0080                	addi	s0,sp,64
  unlink("junk");
    5324:	00003517          	auipc	a0,0x3
    5328:	bfc50513          	addi	a0,a0,-1028 # 7f20 <malloc+0x1fea>
    532c:	00001097          	auipc	ra,0x1
    5330:	838080e7          	jalr	-1992(ra) # 5b64 <unlink>
    5334:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    5338:	20100a93          	li	s5,513
    533c:	00003997          	auipc	s3,0x3
    5340:	be498993          	addi	s3,s3,-1052 # 7f20 <malloc+0x1fea>
    write(fd, (char*)0xffffffffffL, 1);
    5344:	4b05                	li	s6,1
    5346:	5a7d                	li	s4,-1
    5348:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    534c:	85d6                	mv	a1,s5
    534e:	854e                	mv	a0,s3
    5350:	00001097          	auipc	ra,0x1
    5354:	804080e7          	jalr	-2044(ra) # 5b54 <open>
    5358:	84aa                	mv	s1,a0
    if(fd < 0){
    535a:	06054b63          	bltz	a0,53d0 <badwrite+0xc0>
    write(fd, (char*)0xffffffffffL, 1);
    535e:	865a                	mv	a2,s6
    5360:	85d2                	mv	a1,s4
    5362:	00000097          	auipc	ra,0x0
    5366:	7d2080e7          	jalr	2002(ra) # 5b34 <write>
    close(fd);
    536a:	8526                	mv	a0,s1
    536c:	00000097          	auipc	ra,0x0
    5370:	7d0080e7          	jalr	2000(ra) # 5b3c <close>
    unlink("junk");
    5374:	854e                	mv	a0,s3
    5376:	00000097          	auipc	ra,0x0
    537a:	7ee080e7          	jalr	2030(ra) # 5b64 <unlink>
  for(int i = 0; i < assumed_free; i++){
    537e:	397d                	addiw	s2,s2,-1
    5380:	fc0916e3          	bnez	s2,534c <badwrite+0x3c>
  int fd = open("junk", O_CREATE|O_WRONLY);
    5384:	20100593          	li	a1,513
    5388:	00003517          	auipc	a0,0x3
    538c:	b9850513          	addi	a0,a0,-1128 # 7f20 <malloc+0x1fea>
    5390:	00000097          	auipc	ra,0x0
    5394:	7c4080e7          	jalr	1988(ra) # 5b54 <open>
    5398:	84aa                	mv	s1,a0
  if(fd < 0){
    539a:	04054863          	bltz	a0,53ea <badwrite+0xda>
  if(write(fd, "x", 1) != 1){
    539e:	4605                	li	a2,1
    53a0:	00001597          	auipc	a1,0x1
    53a4:	d3858593          	addi	a1,a1,-712 # 60d8 <malloc+0x1a2>
    53a8:	00000097          	auipc	ra,0x0
    53ac:	78c080e7          	jalr	1932(ra) # 5b34 <write>
    53b0:	4785                	li	a5,1
    53b2:	04f50963          	beq	a0,a5,5404 <badwrite+0xf4>
    printf("write failed\n");
    53b6:	00003517          	auipc	a0,0x3
    53ba:	b8a50513          	addi	a0,a0,-1142 # 7f40 <malloc+0x200a>
    53be:	00001097          	auipc	ra,0x1
    53c2:	abc080e7          	jalr	-1348(ra) # 5e7a <printf>
    exit(1);
    53c6:	4505                	li	a0,1
    53c8:	00000097          	auipc	ra,0x0
    53cc:	74c080e7          	jalr	1868(ra) # 5b14 <exit>
      printf("open junk failed\n");
    53d0:	00003517          	auipc	a0,0x3
    53d4:	b5850513          	addi	a0,a0,-1192 # 7f28 <malloc+0x1ff2>
    53d8:	00001097          	auipc	ra,0x1
    53dc:	aa2080e7          	jalr	-1374(ra) # 5e7a <printf>
      exit(1);
    53e0:	4505                	li	a0,1
    53e2:	00000097          	auipc	ra,0x0
    53e6:	732080e7          	jalr	1842(ra) # 5b14 <exit>
    printf("open junk failed\n");
    53ea:	00003517          	auipc	a0,0x3
    53ee:	b3e50513          	addi	a0,a0,-1218 # 7f28 <malloc+0x1ff2>
    53f2:	00001097          	auipc	ra,0x1
    53f6:	a88080e7          	jalr	-1400(ra) # 5e7a <printf>
    exit(1);
    53fa:	4505                	li	a0,1
    53fc:	00000097          	auipc	ra,0x0
    5400:	718080e7          	jalr	1816(ra) # 5b14 <exit>
  close(fd);
    5404:	8526                	mv	a0,s1
    5406:	00000097          	auipc	ra,0x0
    540a:	736080e7          	jalr	1846(ra) # 5b3c <close>
  unlink("junk");
    540e:	00003517          	auipc	a0,0x3
    5412:	b1250513          	addi	a0,a0,-1262 # 7f20 <malloc+0x1fea>
    5416:	00000097          	auipc	ra,0x0
    541a:	74e080e7          	jalr	1870(ra) # 5b64 <unlink>
  exit(0);
    541e:	4501                	li	a0,0
    5420:	00000097          	auipc	ra,0x0
    5424:	6f4080e7          	jalr	1780(ra) # 5b14 <exit>

0000000000005428 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    5428:	7139                	addi	sp,sp,-64
    542a:	fc06                	sd	ra,56(sp)
    542c:	f822                	sd	s0,48(sp)
    542e:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    5430:	fc840513          	addi	a0,s0,-56
    5434:	00000097          	auipc	ra,0x0
    5438:	6f0080e7          	jalr	1776(ra) # 5b24 <pipe>
    543c:	06054b63          	bltz	a0,54b2 <countfree+0x8a>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    5440:	00000097          	auipc	ra,0x0
    5444:	6cc080e7          	jalr	1740(ra) # 5b0c <fork>

  if(pid < 0){
    5448:	08054663          	bltz	a0,54d4 <countfree+0xac>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    544c:	e955                	bnez	a0,5500 <countfree+0xd8>
    544e:	f426                	sd	s1,40(sp)
    5450:	f04a                	sd	s2,32(sp)
    5452:	ec4e                	sd	s3,24(sp)
    5454:	e852                	sd	s4,16(sp)
    close(fds[0]);
    5456:	fc842503          	lw	a0,-56(s0)
    545a:	00000097          	auipc	ra,0x0
    545e:	6e2080e7          	jalr	1762(ra) # 5b3c <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
    5462:	6905                	lui	s2,0x1
      if(a == 0xffffffffffffffff){
    5464:	59fd                	li	s3,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    5466:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5468:	00001a17          	auipc	s4,0x1
    546c:	c70a0a13          	addi	s4,s4,-912 # 60d8 <malloc+0x1a2>
      uint64 a = (uint64) sbrk(4096);
    5470:	854a                	mv	a0,s2
    5472:	00000097          	auipc	ra,0x0
    5476:	72a080e7          	jalr	1834(ra) # 5b9c <sbrk>
      if(a == 0xffffffffffffffff){
    547a:	07350e63          	beq	a0,s3,54f6 <countfree+0xce>
      *(char *)(a + 4096 - 1) = 1;
    547e:	954a                	add	a0,a0,s2
    5480:	fe950fa3          	sb	s1,-1(a0)
      if(write(fds[1], "x", 1) != 1){
    5484:	8626                	mv	a2,s1
    5486:	85d2                	mv	a1,s4
    5488:	fcc42503          	lw	a0,-52(s0)
    548c:	00000097          	auipc	ra,0x0
    5490:	6a8080e7          	jalr	1704(ra) # 5b34 <write>
    5494:	fc950ee3          	beq	a0,s1,5470 <countfree+0x48>
        printf("write() failed in countfree()\n");
    5498:	00003517          	auipc	a0,0x3
    549c:	af850513          	addi	a0,a0,-1288 # 7f90 <malloc+0x205a>
    54a0:	00001097          	auipc	ra,0x1
    54a4:	9da080e7          	jalr	-1574(ra) # 5e7a <printf>
        exit(1);
    54a8:	4505                	li	a0,1
    54aa:	00000097          	auipc	ra,0x0
    54ae:	66a080e7          	jalr	1642(ra) # 5b14 <exit>
    54b2:	f426                	sd	s1,40(sp)
    54b4:	f04a                	sd	s2,32(sp)
    54b6:	ec4e                	sd	s3,24(sp)
    54b8:	e852                	sd	s4,16(sp)
    printf("pipe() failed in countfree()\n");
    54ba:	00003517          	auipc	a0,0x3
    54be:	a9650513          	addi	a0,a0,-1386 # 7f50 <malloc+0x201a>
    54c2:	00001097          	auipc	ra,0x1
    54c6:	9b8080e7          	jalr	-1608(ra) # 5e7a <printf>
    exit(1);
    54ca:	4505                	li	a0,1
    54cc:	00000097          	auipc	ra,0x0
    54d0:	648080e7          	jalr	1608(ra) # 5b14 <exit>
    54d4:	f426                	sd	s1,40(sp)
    54d6:	f04a                	sd	s2,32(sp)
    54d8:	ec4e                	sd	s3,24(sp)
    54da:	e852                	sd	s4,16(sp)
    printf("fork failed in countfree()\n");
    54dc:	00003517          	auipc	a0,0x3
    54e0:	a9450513          	addi	a0,a0,-1388 # 7f70 <malloc+0x203a>
    54e4:	00001097          	auipc	ra,0x1
    54e8:	996080e7          	jalr	-1642(ra) # 5e7a <printf>
    exit(1);
    54ec:	4505                	li	a0,1
    54ee:	00000097          	auipc	ra,0x0
    54f2:	626080e7          	jalr	1574(ra) # 5b14 <exit>
      }
    }

    exit(0);
    54f6:	4501                	li	a0,0
    54f8:	00000097          	auipc	ra,0x0
    54fc:	61c080e7          	jalr	1564(ra) # 5b14 <exit>
    5500:	f426                	sd	s1,40(sp)
    5502:	f04a                	sd	s2,32(sp)
    5504:	ec4e                	sd	s3,24(sp)
  }

  close(fds[1]);
    5506:	fcc42503          	lw	a0,-52(s0)
    550a:	00000097          	auipc	ra,0x0
    550e:	632080e7          	jalr	1586(ra) # 5b3c <close>

  int n = 0;
    5512:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    5514:	fc740993          	addi	s3,s0,-57
    5518:	4905                	li	s2,1
    551a:	864a                	mv	a2,s2
    551c:	85ce                	mv	a1,s3
    551e:	fc842503          	lw	a0,-56(s0)
    5522:	00000097          	auipc	ra,0x0
    5526:	60a080e7          	jalr	1546(ra) # 5b2c <read>
    if(cc < 0){
    552a:	00054563          	bltz	a0,5534 <countfree+0x10c>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    552e:	c10d                	beqz	a0,5550 <countfree+0x128>
      break;
    n += 1;
    5530:	2485                	addiw	s1,s1,1
  while(1){
    5532:	b7e5                	j	551a <countfree+0xf2>
    5534:	e852                	sd	s4,16(sp)
      printf("read() failed in countfree()\n");
    5536:	00003517          	auipc	a0,0x3
    553a:	a7a50513          	addi	a0,a0,-1414 # 7fb0 <malloc+0x207a>
    553e:	00001097          	auipc	ra,0x1
    5542:	93c080e7          	jalr	-1732(ra) # 5e7a <printf>
      exit(1);
    5546:	4505                	li	a0,1
    5548:	00000097          	auipc	ra,0x0
    554c:	5cc080e7          	jalr	1484(ra) # 5b14 <exit>
  }

  close(fds[0]);
    5550:	fc842503          	lw	a0,-56(s0)
    5554:	00000097          	auipc	ra,0x0
    5558:	5e8080e7          	jalr	1512(ra) # 5b3c <close>
  wait((int*)0);
    555c:	4501                	li	a0,0
    555e:	00000097          	auipc	ra,0x0
    5562:	5be080e7          	jalr	1470(ra) # 5b1c <wait>
  
  return n;
}
    5566:	8526                	mv	a0,s1
    5568:	74a2                	ld	s1,40(sp)
    556a:	7902                	ld	s2,32(sp)
    556c:	69e2                	ld	s3,24(sp)
    556e:	70e2                	ld	ra,56(sp)
    5570:	7442                	ld	s0,48(sp)
    5572:	6121                	addi	sp,sp,64
    5574:	8082                	ret

0000000000005576 <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    5576:	7179                	addi	sp,sp,-48
    5578:	f406                	sd	ra,40(sp)
    557a:	f022                	sd	s0,32(sp)
    557c:	ec26                	sd	s1,24(sp)
    557e:	e84a                	sd	s2,16(sp)
    5580:	1800                	addi	s0,sp,48
    5582:	84aa                	mv	s1,a0
    5584:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    5586:	00003517          	auipc	a0,0x3
    558a:	a4a50513          	addi	a0,a0,-1462 # 7fd0 <malloc+0x209a>
    558e:	00001097          	auipc	ra,0x1
    5592:	8ec080e7          	jalr	-1812(ra) # 5e7a <printf>
  if((pid = fork()) < 0) {
    5596:	00000097          	auipc	ra,0x0
    559a:	576080e7          	jalr	1398(ra) # 5b0c <fork>
    559e:	02054e63          	bltz	a0,55da <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    55a2:	c929                	beqz	a0,55f4 <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    55a4:	fdc40513          	addi	a0,s0,-36
    55a8:	00000097          	auipc	ra,0x0
    55ac:	574080e7          	jalr	1396(ra) # 5b1c <wait>
    if(xstatus != 0) 
    55b0:	fdc42783          	lw	a5,-36(s0)
    55b4:	c7b9                	beqz	a5,5602 <run+0x8c>
      printf("FAILED\n");
    55b6:	00003517          	auipc	a0,0x3
    55ba:	a4250513          	addi	a0,a0,-1470 # 7ff8 <malloc+0x20c2>
    55be:	00001097          	auipc	ra,0x1
    55c2:	8bc080e7          	jalr	-1860(ra) # 5e7a <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    55c6:	fdc42503          	lw	a0,-36(s0)
  }
}
    55ca:	00153513          	seqz	a0,a0
    55ce:	70a2                	ld	ra,40(sp)
    55d0:	7402                	ld	s0,32(sp)
    55d2:	64e2                	ld	s1,24(sp)
    55d4:	6942                	ld	s2,16(sp)
    55d6:	6145                	addi	sp,sp,48
    55d8:	8082                	ret
    printf("runtest: fork error\n");
    55da:	00003517          	auipc	a0,0x3
    55de:	a0650513          	addi	a0,a0,-1530 # 7fe0 <malloc+0x20aa>
    55e2:	00001097          	auipc	ra,0x1
    55e6:	898080e7          	jalr	-1896(ra) # 5e7a <printf>
    exit(1);
    55ea:	4505                	li	a0,1
    55ec:	00000097          	auipc	ra,0x0
    55f0:	528080e7          	jalr	1320(ra) # 5b14 <exit>
    f(s);
    55f4:	854a                	mv	a0,s2
    55f6:	9482                	jalr	s1
    exit(0);
    55f8:	4501                	li	a0,0
    55fa:	00000097          	auipc	ra,0x0
    55fe:	51a080e7          	jalr	1306(ra) # 5b14 <exit>
      printf("OK\n");
    5602:	00003517          	auipc	a0,0x3
    5606:	9fe50513          	addi	a0,a0,-1538 # 8000 <malloc+0x20ca>
    560a:	00001097          	auipc	ra,0x1
    560e:	870080e7          	jalr	-1936(ra) # 5e7a <printf>
    5612:	bf55                	j	55c6 <run+0x50>

0000000000005614 <main>:

int
main(int argc, char *argv[])
{
    5614:	bd010113          	addi	sp,sp,-1072
    5618:	42113423          	sd	ra,1064(sp)
    561c:	42813023          	sd	s0,1056(sp)
    5620:	41313423          	sd	s3,1032(sp)
    5624:	43010413          	addi	s0,sp,1072
    5628:	89aa                	mv	s3,a0
  int continuous = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    562a:	4789                	li	a5,2
    562c:	0af50763          	beq	a0,a5,56da <main+0xc6>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    5630:	4785                	li	a5,1
    5632:	14a7c963          	blt	a5,a0,5784 <main+0x170>
  char *justone = 0;
    5636:	4981                	li	s3,0
    5638:	40913c23          	sd	s1,1048(sp)
    563c:	41213823          	sd	s2,1040(sp)
    5640:	41413023          	sd	s4,1024(sp)
    5644:	3f513c23          	sd	s5,1016(sp)
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    5648:	00003797          	auipc	a5,0x3
    564c:	dd878793          	addi	a5,a5,-552 # 8420 <malloc+0x24ea>
    5650:	bd040713          	addi	a4,s0,-1072
    5654:	00003697          	auipc	a3,0x3
    5658:	1bc68693          	addi	a3,a3,444 # 8810 <malloc+0x28da>
    565c:	0007b883          	ld	a7,0(a5)
    5660:	0087b803          	ld	a6,8(a5)
    5664:	6b88                	ld	a0,16(a5)
    5666:	6f8c                	ld	a1,24(a5)
    5668:	7390                	ld	a2,32(a5)
    566a:	01173023          	sd	a7,0(a4)
    566e:	01073423          	sd	a6,8(a4)
    5672:	eb08                	sd	a0,16(a4)
    5674:	ef0c                	sd	a1,24(a4)
    5676:	f310                	sd	a2,32(a4)
    5678:	7790                	ld	a2,40(a5)
    567a:	f710                	sd	a2,40(a4)
    567c:	03078793          	addi	a5,a5,48
    5680:	03070713          	addi	a4,a4,48
    5684:	fcd79ce3          	bne	a5,a3,565c <main+0x48>
          exit(1);
      }
    }
  }

  printf("usertests starting\n");
    5688:	00003517          	auipc	a0,0x3
    568c:	a3850513          	addi	a0,a0,-1480 # 80c0 <malloc+0x218a>
    5690:	00000097          	auipc	ra,0x0
    5694:	7ea080e7          	jalr	2026(ra) # 5e7a <printf>
  int free0 = countfree();
    5698:	00000097          	auipc	ra,0x0
    569c:	d90080e7          	jalr	-624(ra) # 5428 <countfree>
    56a0:	8aaa                	mv	s5,a0
  int free1 = 0;
  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    56a2:	bd843903          	ld	s2,-1064(s0)
    56a6:	bd040493          	addi	s1,s0,-1072
  int fail = 0;
    56aa:	4a01                	li	s4,0
  for (struct test *t = tests; t->s != 0; t++) {
    56ac:	14091663          	bnez	s2,57f8 <main+0x1e4>
  }

  if(fail){
    printf("SOME TESTS FAILED\n");
    exit(1);
  } else if((free1 = countfree()) < free0){
    56b0:	00000097          	auipc	ra,0x0
    56b4:	d78080e7          	jalr	-648(ra) # 5428 <countfree>
    56b8:	85aa                	mv	a1,a0
    56ba:	17555863          	bge	a0,s5,582a <main+0x216>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    56be:	8656                	mv	a2,s5
    56c0:	00003517          	auipc	a0,0x3
    56c4:	9b850513          	addi	a0,a0,-1608 # 8078 <malloc+0x2142>
    56c8:	00000097          	auipc	ra,0x0
    56cc:	7b2080e7          	jalr	1970(ra) # 5e7a <printf>
    exit(1);
    56d0:	4505                	li	a0,1
    56d2:	00000097          	auipc	ra,0x0
    56d6:	442080e7          	jalr	1090(ra) # 5b14 <exit>
    56da:	40913c23          	sd	s1,1048(sp)
    56de:	41213823          	sd	s2,1040(sp)
    56e2:	41413023          	sd	s4,1024(sp)
    56e6:	3f513c23          	sd	s5,1016(sp)
    56ea:	84ae                	mv	s1,a1
  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    56ec:	00003597          	auipc	a1,0x3
    56f0:	91c58593          	addi	a1,a1,-1764 # 8008 <malloc+0x20d2>
    56f4:	6488                	ld	a0,8(s1)
    56f6:	00000097          	auipc	ra,0x0
    56fa:	1b0080e7          	jalr	432(ra) # 58a6 <strcmp>
    56fe:	e125                	bnez	a0,575e <main+0x14a>
    continuous = 1;
    5700:	4985                	li	s3,1
  } tests[] = {
    5702:	00003797          	auipc	a5,0x3
    5706:	d1e78793          	addi	a5,a5,-738 # 8420 <malloc+0x24ea>
    570a:	bd040713          	addi	a4,s0,-1072
    570e:	00003697          	auipc	a3,0x3
    5712:	10268693          	addi	a3,a3,258 # 8810 <malloc+0x28da>
    5716:	0007b883          	ld	a7,0(a5)
    571a:	0087b803          	ld	a6,8(a5)
    571e:	6b88                	ld	a0,16(a5)
    5720:	6f8c                	ld	a1,24(a5)
    5722:	7390                	ld	a2,32(a5)
    5724:	01173023          	sd	a7,0(a4)
    5728:	01073423          	sd	a6,8(a4)
    572c:	eb08                	sd	a0,16(a4)
    572e:	ef0c                	sd	a1,24(a4)
    5730:	f310                	sd	a2,32(a4)
    5732:	7790                	ld	a2,40(a5)
    5734:	f710                	sd	a2,40(a4)
    5736:	03078793          	addi	a5,a5,48
    573a:	03070713          	addi	a4,a4,48
    573e:	fcd79ce3          	bne	a5,a3,5716 <main+0x102>
    printf("continuous usertests starting\n");
    5742:	00003517          	auipc	a0,0x3
    5746:	99650513          	addi	a0,a0,-1642 # 80d8 <malloc+0x21a2>
    574a:	00000097          	auipc	ra,0x0
    574e:	730080e7          	jalr	1840(ra) # 5e7a <printf>
        printf("SOME TESTS FAILED\n");
    5752:	00003a97          	auipc	s5,0x3
    5756:	90ea8a93          	addi	s5,s5,-1778 # 8060 <malloc+0x212a>
        if(continuous != 2)
    575a:	4a09                	li	s4,2
    575c:	a209                	j	585e <main+0x24a>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    575e:	00003597          	auipc	a1,0x3
    5762:	8b258593          	addi	a1,a1,-1870 # 8010 <malloc+0x20da>
    5766:	6488                	ld	a0,8(s1)
    5768:	00000097          	auipc	ra,0x0
    576c:	13e080e7          	jalr	318(ra) # 58a6 <strcmp>
    5770:	d949                	beqz	a0,5702 <main+0xee>
  } else if(argc == 2 && argv[1][0] != '-'){
    5772:	0084b983          	ld	s3,8(s1)
    5776:	0009c703          	lbu	a4,0(s3)
    577a:	02d00793          	li	a5,45
    577e:	ecf715e3          	bne	a4,a5,5648 <main+0x34>
    5782:	a809                	j	5794 <main+0x180>
    5784:	40913c23          	sd	s1,1048(sp)
    5788:	41213823          	sd	s2,1040(sp)
    578c:	41413023          	sd	s4,1024(sp)
    5790:	3f513c23          	sd	s5,1016(sp)
    printf("Usage: usertests [-c] [testname]\n");
    5794:	00003517          	auipc	a0,0x3
    5798:	88450513          	addi	a0,a0,-1916 # 8018 <malloc+0x20e2>
    579c:	00000097          	auipc	ra,0x0
    57a0:	6de080e7          	jalr	1758(ra) # 5e7a <printf>
    exit(1);
    57a4:	4505                	li	a0,1
    57a6:	00000097          	auipc	ra,0x0
    57aa:	36e080e7          	jalr	878(ra) # 5b14 <exit>
          exit(1);
    57ae:	4505                	li	a0,1
    57b0:	00000097          	auipc	ra,0x0
    57b4:	364080e7          	jalr	868(ra) # 5b14 <exit>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    57b8:	40a905bb          	subw	a1,s2,a0
    57bc:	00003517          	auipc	a0,0x3
    57c0:	88450513          	addi	a0,a0,-1916 # 8040 <malloc+0x210a>
    57c4:	00000097          	auipc	ra,0x0
    57c8:	6b6080e7          	jalr	1718(ra) # 5e7a <printf>
        if(continuous != 2)
    57cc:	09498963          	beq	s3,s4,585e <main+0x24a>
          exit(1);
    57d0:	4505                	li	a0,1
    57d2:	00000097          	auipc	ra,0x0
    57d6:	342080e7          	jalr	834(ra) # 5b14 <exit>
      if(!run(t->f, t->s))
    57da:	85ca                	mv	a1,s2
    57dc:	6088                	ld	a0,0(s1)
    57de:	00000097          	auipc	ra,0x0
    57e2:	d98080e7          	jalr	-616(ra) # 5576 <run>
    57e6:	00153513          	seqz	a0,a0
    57ea:	00aa6a33          	or	s4,s4,a0
  for (struct test *t = tests; t->s != 0; t++) {
    57ee:	04c1                	addi	s1,s1,16
    57f0:	0084b903          	ld	s2,8(s1)
    57f4:	00090c63          	beqz	s2,580c <main+0x1f8>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    57f8:	fe0981e3          	beqz	s3,57da <main+0x1c6>
    57fc:	85ce                	mv	a1,s3
    57fe:	854a                	mv	a0,s2
    5800:	00000097          	auipc	ra,0x0
    5804:	0a6080e7          	jalr	166(ra) # 58a6 <strcmp>
    5808:	f17d                	bnez	a0,57ee <main+0x1da>
    580a:	bfc1                	j	57da <main+0x1c6>
  if(fail){
    580c:	ea0a02e3          	beqz	s4,56b0 <main+0x9c>
    printf("SOME TESTS FAILED\n");
    5810:	00003517          	auipc	a0,0x3
    5814:	85050513          	addi	a0,a0,-1968 # 8060 <malloc+0x212a>
    5818:	00000097          	auipc	ra,0x0
    581c:	662080e7          	jalr	1634(ra) # 5e7a <printf>
    exit(1);
    5820:	4505                	li	a0,1
    5822:	00000097          	auipc	ra,0x0
    5826:	2f2080e7          	jalr	754(ra) # 5b14 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    582a:	00003517          	auipc	a0,0x3
    582e:	87e50513          	addi	a0,a0,-1922 # 80a8 <malloc+0x2172>
    5832:	00000097          	auipc	ra,0x0
    5836:	648080e7          	jalr	1608(ra) # 5e7a <printf>
    exit(0);
    583a:	4501                	li	a0,0
    583c:	00000097          	auipc	ra,0x0
    5840:	2d8080e7          	jalr	728(ra) # 5b14 <exit>
        printf("SOME TESTS FAILED\n");
    5844:	8556                	mv	a0,s5
    5846:	00000097          	auipc	ra,0x0
    584a:	634080e7          	jalr	1588(ra) # 5e7a <printf>
        if(continuous != 2)
    584e:	f74990e3          	bne	s3,s4,57ae <main+0x19a>
      int free1 = countfree();
    5852:	00000097          	auipc	ra,0x0
    5856:	bd6080e7          	jalr	-1066(ra) # 5428 <countfree>
      if(free1 < free0){
    585a:	f5254fe3          	blt	a0,s2,57b8 <main+0x1a4>
      int free0 = countfree();
    585e:	00000097          	auipc	ra,0x0
    5862:	bca080e7          	jalr	-1078(ra) # 5428 <countfree>
    5866:	892a                	mv	s2,a0
      for (struct test *t = tests; t->s != 0; t++) {
    5868:	bd843583          	ld	a1,-1064(s0)
    586c:	d1fd                	beqz	a1,5852 <main+0x23e>
    586e:	bd040493          	addi	s1,s0,-1072
        if(!run(t->f, t->s)){
    5872:	6088                	ld	a0,0(s1)
    5874:	00000097          	auipc	ra,0x0
    5878:	d02080e7          	jalr	-766(ra) # 5576 <run>
    587c:	d561                	beqz	a0,5844 <main+0x230>
      for (struct test *t = tests; t->s != 0; t++) {
    587e:	04c1                	addi	s1,s1,16
    5880:	648c                	ld	a1,8(s1)
    5882:	f9e5                	bnez	a1,5872 <main+0x25e>
    5884:	b7f9                	j	5852 <main+0x23e>

0000000000005886 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    5886:	1141                	addi	sp,sp,-16
    5888:	e406                	sd	ra,8(sp)
    588a:	e022                	sd	s0,0(sp)
    588c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    588e:	87aa                	mv	a5,a0
    5890:	0585                	addi	a1,a1,1
    5892:	0785                	addi	a5,a5,1
    5894:	fff5c703          	lbu	a4,-1(a1)
    5898:	fee78fa3          	sb	a4,-1(a5)
    589c:	fb75                	bnez	a4,5890 <strcpy+0xa>
    ;
  return os;
}
    589e:	60a2                	ld	ra,8(sp)
    58a0:	6402                	ld	s0,0(sp)
    58a2:	0141                	addi	sp,sp,16
    58a4:	8082                	ret

00000000000058a6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    58a6:	1141                	addi	sp,sp,-16
    58a8:	e406                	sd	ra,8(sp)
    58aa:	e022                	sd	s0,0(sp)
    58ac:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    58ae:	00054783          	lbu	a5,0(a0)
    58b2:	cb91                	beqz	a5,58c6 <strcmp+0x20>
    58b4:	0005c703          	lbu	a4,0(a1)
    58b8:	00f71763          	bne	a4,a5,58c6 <strcmp+0x20>
    p++, q++;
    58bc:	0505                	addi	a0,a0,1
    58be:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    58c0:	00054783          	lbu	a5,0(a0)
    58c4:	fbe5                	bnez	a5,58b4 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    58c6:	0005c503          	lbu	a0,0(a1)
}
    58ca:	40a7853b          	subw	a0,a5,a0
    58ce:	60a2                	ld	ra,8(sp)
    58d0:	6402                	ld	s0,0(sp)
    58d2:	0141                	addi	sp,sp,16
    58d4:	8082                	ret

00000000000058d6 <strlen>:

uint
strlen(const char *s)
{
    58d6:	1141                	addi	sp,sp,-16
    58d8:	e406                	sd	ra,8(sp)
    58da:	e022                	sd	s0,0(sp)
    58dc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    58de:	00054783          	lbu	a5,0(a0)
    58e2:	cf91                	beqz	a5,58fe <strlen+0x28>
    58e4:	00150793          	addi	a5,a0,1
    58e8:	86be                	mv	a3,a5
    58ea:	0785                	addi	a5,a5,1
    58ec:	fff7c703          	lbu	a4,-1(a5)
    58f0:	ff65                	bnez	a4,58e8 <strlen+0x12>
    58f2:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
    58f6:	60a2                	ld	ra,8(sp)
    58f8:	6402                	ld	s0,0(sp)
    58fa:	0141                	addi	sp,sp,16
    58fc:	8082                	ret
  for(n = 0; s[n]; n++)
    58fe:	4501                	li	a0,0
    5900:	bfdd                	j	58f6 <strlen+0x20>

0000000000005902 <memset>:

void*
memset(void *dst, int c, uint n)
{
    5902:	1141                	addi	sp,sp,-16
    5904:	e406                	sd	ra,8(sp)
    5906:	e022                	sd	s0,0(sp)
    5908:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    590a:	ca19                	beqz	a2,5920 <memset+0x1e>
    590c:	87aa                	mv	a5,a0
    590e:	1602                	slli	a2,a2,0x20
    5910:	9201                	srli	a2,a2,0x20
    5912:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    5916:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    591a:	0785                	addi	a5,a5,1
    591c:	fee79de3          	bne	a5,a4,5916 <memset+0x14>
  }
  return dst;
}
    5920:	60a2                	ld	ra,8(sp)
    5922:	6402                	ld	s0,0(sp)
    5924:	0141                	addi	sp,sp,16
    5926:	8082                	ret

0000000000005928 <strchr>:

char*
strchr(const char *s, char c)
{
    5928:	1141                	addi	sp,sp,-16
    592a:	e406                	sd	ra,8(sp)
    592c:	e022                	sd	s0,0(sp)
    592e:	0800                	addi	s0,sp,16
  for(; *s; s++)
    5930:	00054783          	lbu	a5,0(a0)
    5934:	cf81                	beqz	a5,594c <strchr+0x24>
    if(*s == c)
    5936:	00f58763          	beq	a1,a5,5944 <strchr+0x1c>
  for(; *s; s++)
    593a:	0505                	addi	a0,a0,1
    593c:	00054783          	lbu	a5,0(a0)
    5940:	fbfd                	bnez	a5,5936 <strchr+0xe>
      return (char*)s;
  return 0;
    5942:	4501                	li	a0,0
}
    5944:	60a2                	ld	ra,8(sp)
    5946:	6402                	ld	s0,0(sp)
    5948:	0141                	addi	sp,sp,16
    594a:	8082                	ret
  return 0;
    594c:	4501                	li	a0,0
    594e:	bfdd                	j	5944 <strchr+0x1c>

0000000000005950 <gets>:

char*
gets(char *buf, int max)
{
    5950:	711d                	addi	sp,sp,-96
    5952:	ec86                	sd	ra,88(sp)
    5954:	e8a2                	sd	s0,80(sp)
    5956:	e4a6                	sd	s1,72(sp)
    5958:	e0ca                	sd	s2,64(sp)
    595a:	fc4e                	sd	s3,56(sp)
    595c:	f852                	sd	s4,48(sp)
    595e:	f456                	sd	s5,40(sp)
    5960:	f05a                	sd	s6,32(sp)
    5962:	ec5e                	sd	s7,24(sp)
    5964:	e862                	sd	s8,16(sp)
    5966:	1080                	addi	s0,sp,96
    5968:	8baa                	mv	s7,a0
    596a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    596c:	892a                	mv	s2,a0
    596e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    5970:	faf40b13          	addi	s6,s0,-81
    5974:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
    5976:	8c26                	mv	s8,s1
    5978:	0014899b          	addiw	s3,s1,1
    597c:	84ce                	mv	s1,s3
    597e:	0349d663          	bge	s3,s4,59aa <gets+0x5a>
    cc = read(0, &c, 1);
    5982:	8656                	mv	a2,s5
    5984:	85da                	mv	a1,s6
    5986:	4501                	li	a0,0
    5988:	00000097          	auipc	ra,0x0
    598c:	1a4080e7          	jalr	420(ra) # 5b2c <read>
    if(cc < 1)
    5990:	00a05d63          	blez	a0,59aa <gets+0x5a>
      break;
    buf[i++] = c;
    5994:	faf44783          	lbu	a5,-81(s0)
    5998:	00f90023          	sb	a5,0(s2) # 1000 <bigdir+0x54>
    if(c == '\n' || c == '\r')
    599c:	0905                	addi	s2,s2,1
    599e:	ff678713          	addi	a4,a5,-10
    59a2:	c319                	beqz	a4,59a8 <gets+0x58>
    59a4:	17cd                	addi	a5,a5,-13
    59a6:	fbe1                	bnez	a5,5976 <gets+0x26>
    buf[i++] = c;
    59a8:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
    59aa:	9c5e                	add	s8,s8,s7
    59ac:	000c0023          	sb	zero,0(s8)
  return buf;
}
    59b0:	855e                	mv	a0,s7
    59b2:	60e6                	ld	ra,88(sp)
    59b4:	6446                	ld	s0,80(sp)
    59b6:	64a6                	ld	s1,72(sp)
    59b8:	6906                	ld	s2,64(sp)
    59ba:	79e2                	ld	s3,56(sp)
    59bc:	7a42                	ld	s4,48(sp)
    59be:	7aa2                	ld	s5,40(sp)
    59c0:	7b02                	ld	s6,32(sp)
    59c2:	6be2                	ld	s7,24(sp)
    59c4:	6c42                	ld	s8,16(sp)
    59c6:	6125                	addi	sp,sp,96
    59c8:	8082                	ret

00000000000059ca <stat>:

int
stat(const char *n, struct stat *st)
{
    59ca:	1101                	addi	sp,sp,-32
    59cc:	ec06                	sd	ra,24(sp)
    59ce:	e822                	sd	s0,16(sp)
    59d0:	e04a                	sd	s2,0(sp)
    59d2:	1000                	addi	s0,sp,32
    59d4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    59d6:	4581                	li	a1,0
    59d8:	00000097          	auipc	ra,0x0
    59dc:	17c080e7          	jalr	380(ra) # 5b54 <open>
  if(fd < 0)
    59e0:	02054663          	bltz	a0,5a0c <stat+0x42>
    59e4:	e426                	sd	s1,8(sp)
    59e6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    59e8:	85ca                	mv	a1,s2
    59ea:	00000097          	auipc	ra,0x0
    59ee:	182080e7          	jalr	386(ra) # 5b6c <fstat>
    59f2:	892a                	mv	s2,a0
  close(fd);
    59f4:	8526                	mv	a0,s1
    59f6:	00000097          	auipc	ra,0x0
    59fa:	146080e7          	jalr	326(ra) # 5b3c <close>
  return r;
    59fe:	64a2                	ld	s1,8(sp)
}
    5a00:	854a                	mv	a0,s2
    5a02:	60e2                	ld	ra,24(sp)
    5a04:	6442                	ld	s0,16(sp)
    5a06:	6902                	ld	s2,0(sp)
    5a08:	6105                	addi	sp,sp,32
    5a0a:	8082                	ret
    return -1;
    5a0c:	57fd                	li	a5,-1
    5a0e:	893e                	mv	s2,a5
    5a10:	bfc5                	j	5a00 <stat+0x36>

0000000000005a12 <atoi>:

int
atoi(const char *s)
{
    5a12:	1141                	addi	sp,sp,-16
    5a14:	e406                	sd	ra,8(sp)
    5a16:	e022                	sd	s0,0(sp)
    5a18:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5a1a:	00054683          	lbu	a3,0(a0)
    5a1e:	fd06879b          	addiw	a5,a3,-48
    5a22:	0ff7f793          	zext.b	a5,a5
    5a26:	4625                	li	a2,9
    5a28:	02f66963          	bltu	a2,a5,5a5a <atoi+0x48>
    5a2c:	872a                	mv	a4,a0
  n = 0;
    5a2e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    5a30:	0705                	addi	a4,a4,1
    5a32:	0025179b          	slliw	a5,a0,0x2
    5a36:	9fa9                	addw	a5,a5,a0
    5a38:	0017979b          	slliw	a5,a5,0x1
    5a3c:	9fb5                	addw	a5,a5,a3
    5a3e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5a42:	00074683          	lbu	a3,0(a4)
    5a46:	fd06879b          	addiw	a5,a3,-48
    5a4a:	0ff7f793          	zext.b	a5,a5
    5a4e:	fef671e3          	bgeu	a2,a5,5a30 <atoi+0x1e>
  return n;
}
    5a52:	60a2                	ld	ra,8(sp)
    5a54:	6402                	ld	s0,0(sp)
    5a56:	0141                	addi	sp,sp,16
    5a58:	8082                	ret
  n = 0;
    5a5a:	4501                	li	a0,0
    5a5c:	bfdd                	j	5a52 <atoi+0x40>

0000000000005a5e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5a5e:	1141                	addi	sp,sp,-16
    5a60:	e406                	sd	ra,8(sp)
    5a62:	e022                	sd	s0,0(sp)
    5a64:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5a66:	02b57563          	bgeu	a0,a1,5a90 <memmove+0x32>
    while(n-- > 0)
    5a6a:	00c05f63          	blez	a2,5a88 <memmove+0x2a>
    5a6e:	1602                	slli	a2,a2,0x20
    5a70:	9201                	srli	a2,a2,0x20
    5a72:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    5a76:	872a                	mv	a4,a0
      *dst++ = *src++;
    5a78:	0585                	addi	a1,a1,1
    5a7a:	0705                	addi	a4,a4,1
    5a7c:	fff5c683          	lbu	a3,-1(a1)
    5a80:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5a84:	fee79ae3          	bne	a5,a4,5a78 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5a88:	60a2                	ld	ra,8(sp)
    5a8a:	6402                	ld	s0,0(sp)
    5a8c:	0141                	addi	sp,sp,16
    5a8e:	8082                	ret
    while(n-- > 0)
    5a90:	fec05ce3          	blez	a2,5a88 <memmove+0x2a>
    dst += n;
    5a94:	00c50733          	add	a4,a0,a2
    src += n;
    5a98:	95b2                	add	a1,a1,a2
    5a9a:	fff6079b          	addiw	a5,a2,-1 # 2fff <fourteen+0xbb>
    5a9e:	1782                	slli	a5,a5,0x20
    5aa0:	9381                	srli	a5,a5,0x20
    5aa2:	fff7c793          	not	a5,a5
    5aa6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5aa8:	15fd                	addi	a1,a1,-1
    5aaa:	177d                	addi	a4,a4,-1
    5aac:	0005c683          	lbu	a3,0(a1)
    5ab0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5ab4:	fef71ae3          	bne	a4,a5,5aa8 <memmove+0x4a>
    5ab8:	bfc1                	j	5a88 <memmove+0x2a>

0000000000005aba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5aba:	1141                	addi	sp,sp,-16
    5abc:	e406                	sd	ra,8(sp)
    5abe:	e022                	sd	s0,0(sp)
    5ac0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5ac2:	c61d                	beqz	a2,5af0 <memcmp+0x36>
    5ac4:	1602                	slli	a2,a2,0x20
    5ac6:	9201                	srli	a2,a2,0x20
    5ac8:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
    5acc:	00054783          	lbu	a5,0(a0)
    5ad0:	0005c703          	lbu	a4,0(a1)
    5ad4:	00e79863          	bne	a5,a4,5ae4 <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
    5ad8:	0505                	addi	a0,a0,1
    p2++;
    5ada:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5adc:	fed518e3          	bne	a0,a3,5acc <memcmp+0x12>
  }
  return 0;
    5ae0:	4501                	li	a0,0
    5ae2:	a019                	j	5ae8 <memcmp+0x2e>
      return *p1 - *p2;
    5ae4:	40e7853b          	subw	a0,a5,a4
}
    5ae8:	60a2                	ld	ra,8(sp)
    5aea:	6402                	ld	s0,0(sp)
    5aec:	0141                	addi	sp,sp,16
    5aee:	8082                	ret
  return 0;
    5af0:	4501                	li	a0,0
    5af2:	bfdd                	j	5ae8 <memcmp+0x2e>

0000000000005af4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5af4:	1141                	addi	sp,sp,-16
    5af6:	e406                	sd	ra,8(sp)
    5af8:	e022                	sd	s0,0(sp)
    5afa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5afc:	00000097          	auipc	ra,0x0
    5b00:	f62080e7          	jalr	-158(ra) # 5a5e <memmove>
}
    5b04:	60a2                	ld	ra,8(sp)
    5b06:	6402                	ld	s0,0(sp)
    5b08:	0141                	addi	sp,sp,16
    5b0a:	8082                	ret

0000000000005b0c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5b0c:	4885                	li	a7,1
 ecall
    5b0e:	00000073          	ecall
 ret
    5b12:	8082                	ret

0000000000005b14 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5b14:	4889                	li	a7,2
 ecall
    5b16:	00000073          	ecall
 ret
    5b1a:	8082                	ret

0000000000005b1c <wait>:
.global wait
wait:
 li a7, SYS_wait
    5b1c:	488d                	li	a7,3
 ecall
    5b1e:	00000073          	ecall
 ret
    5b22:	8082                	ret

0000000000005b24 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5b24:	4891                	li	a7,4
 ecall
    5b26:	00000073          	ecall
 ret
    5b2a:	8082                	ret

0000000000005b2c <read>:
.global read
read:
 li a7, SYS_read
    5b2c:	4895                	li	a7,5
 ecall
    5b2e:	00000073          	ecall
 ret
    5b32:	8082                	ret

0000000000005b34 <write>:
.global write
write:
 li a7, SYS_write
    5b34:	48c1                	li	a7,16
 ecall
    5b36:	00000073          	ecall
 ret
    5b3a:	8082                	ret

0000000000005b3c <close>:
.global close
close:
 li a7, SYS_close
    5b3c:	48d5                	li	a7,21
 ecall
    5b3e:	00000073          	ecall
 ret
    5b42:	8082                	ret

0000000000005b44 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5b44:	4899                	li	a7,6
 ecall
    5b46:	00000073          	ecall
 ret
    5b4a:	8082                	ret

0000000000005b4c <exec>:
.global exec
exec:
 li a7, SYS_exec
    5b4c:	489d                	li	a7,7
 ecall
    5b4e:	00000073          	ecall
 ret
    5b52:	8082                	ret

0000000000005b54 <open>:
.global open
open:
 li a7, SYS_open
    5b54:	48bd                	li	a7,15
 ecall
    5b56:	00000073          	ecall
 ret
    5b5a:	8082                	ret

0000000000005b5c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5b5c:	48c5                	li	a7,17
 ecall
    5b5e:	00000073          	ecall
 ret
    5b62:	8082                	ret

0000000000005b64 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5b64:	48c9                	li	a7,18
 ecall
    5b66:	00000073          	ecall
 ret
    5b6a:	8082                	ret

0000000000005b6c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5b6c:	48a1                	li	a7,8
 ecall
    5b6e:	00000073          	ecall
 ret
    5b72:	8082                	ret

0000000000005b74 <link>:
.global link
link:
 li a7, SYS_link
    5b74:	48cd                	li	a7,19
 ecall
    5b76:	00000073          	ecall
 ret
    5b7a:	8082                	ret

0000000000005b7c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5b7c:	48d1                	li	a7,20
 ecall
    5b7e:	00000073          	ecall
 ret
    5b82:	8082                	ret

0000000000005b84 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5b84:	48a5                	li	a7,9
 ecall
    5b86:	00000073          	ecall
 ret
    5b8a:	8082                	ret

0000000000005b8c <dup>:
.global dup
dup:
 li a7, SYS_dup
    5b8c:	48a9                	li	a7,10
 ecall
    5b8e:	00000073          	ecall
 ret
    5b92:	8082                	ret

0000000000005b94 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5b94:	48ad                	li	a7,11
 ecall
    5b96:	00000073          	ecall
 ret
    5b9a:	8082                	ret

0000000000005b9c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5b9c:	48b1                	li	a7,12
 ecall
    5b9e:	00000073          	ecall
 ret
    5ba2:	8082                	ret

0000000000005ba4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5ba4:	48b5                	li	a7,13
 ecall
    5ba6:	00000073          	ecall
 ret
    5baa:	8082                	ret

0000000000005bac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5bac:	48b9                	li	a7,14
 ecall
    5bae:	00000073          	ecall
 ret
    5bb2:	8082                	ret

0000000000005bb4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5bb4:	1101                	addi	sp,sp,-32
    5bb6:	ec06                	sd	ra,24(sp)
    5bb8:	e822                	sd	s0,16(sp)
    5bba:	1000                	addi	s0,sp,32
    5bbc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5bc0:	4605                	li	a2,1
    5bc2:	fef40593          	addi	a1,s0,-17
    5bc6:	00000097          	auipc	ra,0x0
    5bca:	f6e080e7          	jalr	-146(ra) # 5b34 <write>
}
    5bce:	60e2                	ld	ra,24(sp)
    5bd0:	6442                	ld	s0,16(sp)
    5bd2:	6105                	addi	sp,sp,32
    5bd4:	8082                	ret

0000000000005bd6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5bd6:	7139                	addi	sp,sp,-64
    5bd8:	fc06                	sd	ra,56(sp)
    5bda:	f822                	sd	s0,48(sp)
    5bdc:	f04a                	sd	s2,32(sp)
    5bde:	ec4e                	sd	s3,24(sp)
    5be0:	0080                	addi	s0,sp,64
    5be2:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5be4:	cad9                	beqz	a3,5c7a <printint+0xa4>
    5be6:	01f5d79b          	srliw	a5,a1,0x1f
    5bea:	cbc1                	beqz	a5,5c7a <printint+0xa4>
    neg = 1;
    x = -xx;
    5bec:	40b005bb          	negw	a1,a1
    neg = 1;
    5bf0:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
    5bf2:	fc040993          	addi	s3,s0,-64
  neg = 0;
    5bf6:	86ce                	mv	a3,s3
  i = 0;
    5bf8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5bfa:	00003817          	auipc	a6,0x3
    5bfe:	c6e80813          	addi	a6,a6,-914 # 8868 <digits>
    5c02:	88ba                	mv	a7,a4
    5c04:	0017051b          	addiw	a0,a4,1
    5c08:	872a                	mv	a4,a0
    5c0a:	02c5f7bb          	remuw	a5,a1,a2
    5c0e:	1782                	slli	a5,a5,0x20
    5c10:	9381                	srli	a5,a5,0x20
    5c12:	97c2                	add	a5,a5,a6
    5c14:	0007c783          	lbu	a5,0(a5)
    5c18:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5c1c:	87ae                	mv	a5,a1
    5c1e:	02c5d5bb          	divuw	a1,a1,a2
    5c22:	0685                	addi	a3,a3,1
    5c24:	fcc7ffe3          	bgeu	a5,a2,5c02 <printint+0x2c>
  if(neg)
    5c28:	00030c63          	beqz	t1,5c40 <printint+0x6a>
    buf[i++] = '-';
    5c2c:	fd050793          	addi	a5,a0,-48
    5c30:	00878533          	add	a0,a5,s0
    5c34:	02d00793          	li	a5,45
    5c38:	fef50823          	sb	a5,-16(a0)
    5c3c:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
    5c40:	02e05763          	blez	a4,5c6e <printint+0x98>
    5c44:	f426                	sd	s1,40(sp)
    5c46:	377d                	addiw	a4,a4,-1
    5c48:	00e984b3          	add	s1,s3,a4
    5c4c:	19fd                	addi	s3,s3,-1
    5c4e:	99ba                	add	s3,s3,a4
    5c50:	1702                	slli	a4,a4,0x20
    5c52:	9301                	srli	a4,a4,0x20
    5c54:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5c58:	0004c583          	lbu	a1,0(s1)
    5c5c:	854a                	mv	a0,s2
    5c5e:	00000097          	auipc	ra,0x0
    5c62:	f56080e7          	jalr	-170(ra) # 5bb4 <putc>
  while(--i >= 0)
    5c66:	14fd                	addi	s1,s1,-1
    5c68:	ff3498e3          	bne	s1,s3,5c58 <printint+0x82>
    5c6c:	74a2                	ld	s1,40(sp)
}
    5c6e:	70e2                	ld	ra,56(sp)
    5c70:	7442                	ld	s0,48(sp)
    5c72:	7902                	ld	s2,32(sp)
    5c74:	69e2                	ld	s3,24(sp)
    5c76:	6121                	addi	sp,sp,64
    5c78:	8082                	ret
  neg = 0;
    5c7a:	4301                	li	t1,0
    5c7c:	bf9d                	j	5bf2 <printint+0x1c>

0000000000005c7e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5c7e:	715d                	addi	sp,sp,-80
    5c80:	e486                	sd	ra,72(sp)
    5c82:	e0a2                	sd	s0,64(sp)
    5c84:	f84a                	sd	s2,48(sp)
    5c86:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5c88:	0005c903          	lbu	s2,0(a1)
    5c8c:	1a090b63          	beqz	s2,5e42 <vprintf+0x1c4>
    5c90:	fc26                	sd	s1,56(sp)
    5c92:	f44e                	sd	s3,40(sp)
    5c94:	f052                	sd	s4,32(sp)
    5c96:	ec56                	sd	s5,24(sp)
    5c98:	e85a                	sd	s6,16(sp)
    5c9a:	e45e                	sd	s7,8(sp)
    5c9c:	8aaa                	mv	s5,a0
    5c9e:	8bb2                	mv	s7,a2
    5ca0:	00158493          	addi	s1,a1,1
  state = 0;
    5ca4:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5ca6:	02500a13          	li	s4,37
    5caa:	4b55                	li	s6,21
    5cac:	a839                	j	5cca <vprintf+0x4c>
        putc(fd, c);
    5cae:	85ca                	mv	a1,s2
    5cb0:	8556                	mv	a0,s5
    5cb2:	00000097          	auipc	ra,0x0
    5cb6:	f02080e7          	jalr	-254(ra) # 5bb4 <putc>
    5cba:	a019                	j	5cc0 <vprintf+0x42>
    } else if(state == '%'){
    5cbc:	01498d63          	beq	s3,s4,5cd6 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
    5cc0:	0485                	addi	s1,s1,1
    5cc2:	fff4c903          	lbu	s2,-1(s1)
    5cc6:	16090863          	beqz	s2,5e36 <vprintf+0x1b8>
    if(state == 0){
    5cca:	fe0999e3          	bnez	s3,5cbc <vprintf+0x3e>
      if(c == '%'){
    5cce:	ff4910e3          	bne	s2,s4,5cae <vprintf+0x30>
        state = '%';
    5cd2:	89d2                	mv	s3,s4
    5cd4:	b7f5                	j	5cc0 <vprintf+0x42>
      if(c == 'd'){
    5cd6:	13490563          	beq	s2,s4,5e00 <vprintf+0x182>
    5cda:	f9d9079b          	addiw	a5,s2,-99
    5cde:	0ff7f793          	zext.b	a5,a5
    5ce2:	12fb6863          	bltu	s6,a5,5e12 <vprintf+0x194>
    5ce6:	f9d9079b          	addiw	a5,s2,-99
    5cea:	0ff7f713          	zext.b	a4,a5
    5cee:	12eb6263          	bltu	s6,a4,5e12 <vprintf+0x194>
    5cf2:	00271793          	slli	a5,a4,0x2
    5cf6:	00003717          	auipc	a4,0x3
    5cfa:	b1a70713          	addi	a4,a4,-1254 # 8810 <malloc+0x28da>
    5cfe:	97ba                	add	a5,a5,a4
    5d00:	439c                	lw	a5,0(a5)
    5d02:	97ba                	add	a5,a5,a4
    5d04:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    5d06:	008b8913          	addi	s2,s7,8
    5d0a:	4685                	li	a3,1
    5d0c:	4629                	li	a2,10
    5d0e:	000ba583          	lw	a1,0(s7)
    5d12:	8556                	mv	a0,s5
    5d14:	00000097          	auipc	ra,0x0
    5d18:	ec2080e7          	jalr	-318(ra) # 5bd6 <printint>
    5d1c:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    5d1e:	4981                	li	s3,0
    5d20:	b745                	j	5cc0 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5d22:	008b8913          	addi	s2,s7,8
    5d26:	4681                	li	a3,0
    5d28:	4629                	li	a2,10
    5d2a:	000ba583          	lw	a1,0(s7)
    5d2e:	8556                	mv	a0,s5
    5d30:	00000097          	auipc	ra,0x0
    5d34:	ea6080e7          	jalr	-346(ra) # 5bd6 <printint>
    5d38:	8bca                	mv	s7,s2
      state = 0;
    5d3a:	4981                	li	s3,0
    5d3c:	b751                	j	5cc0 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    5d3e:	008b8913          	addi	s2,s7,8
    5d42:	4681                	li	a3,0
    5d44:	4641                	li	a2,16
    5d46:	000ba583          	lw	a1,0(s7)
    5d4a:	8556                	mv	a0,s5
    5d4c:	00000097          	auipc	ra,0x0
    5d50:	e8a080e7          	jalr	-374(ra) # 5bd6 <printint>
    5d54:	8bca                	mv	s7,s2
      state = 0;
    5d56:	4981                	li	s3,0
    5d58:	b7a5                	j	5cc0 <vprintf+0x42>
    5d5a:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    5d5c:	008b8793          	addi	a5,s7,8
    5d60:	8c3e                	mv	s8,a5
    5d62:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    5d66:	03000593          	li	a1,48
    5d6a:	8556                	mv	a0,s5
    5d6c:	00000097          	auipc	ra,0x0
    5d70:	e48080e7          	jalr	-440(ra) # 5bb4 <putc>
  putc(fd, 'x');
    5d74:	07800593          	li	a1,120
    5d78:	8556                	mv	a0,s5
    5d7a:	00000097          	auipc	ra,0x0
    5d7e:	e3a080e7          	jalr	-454(ra) # 5bb4 <putc>
    5d82:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5d84:	00003b97          	auipc	s7,0x3
    5d88:	ae4b8b93          	addi	s7,s7,-1308 # 8868 <digits>
    5d8c:	03c9d793          	srli	a5,s3,0x3c
    5d90:	97de                	add	a5,a5,s7
    5d92:	0007c583          	lbu	a1,0(a5)
    5d96:	8556                	mv	a0,s5
    5d98:	00000097          	auipc	ra,0x0
    5d9c:	e1c080e7          	jalr	-484(ra) # 5bb4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5da0:	0992                	slli	s3,s3,0x4
    5da2:	397d                	addiw	s2,s2,-1
    5da4:	fe0914e3          	bnez	s2,5d8c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
    5da8:	8be2                	mv	s7,s8
      state = 0;
    5daa:	4981                	li	s3,0
    5dac:	6c02                	ld	s8,0(sp)
    5dae:	bf09                	j	5cc0 <vprintf+0x42>
        s = va_arg(ap, char*);
    5db0:	008b8993          	addi	s3,s7,8
    5db4:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    5db8:	02090163          	beqz	s2,5dda <vprintf+0x15c>
        while(*s != 0){
    5dbc:	00094583          	lbu	a1,0(s2)
    5dc0:	c9a5                	beqz	a1,5e30 <vprintf+0x1b2>
          putc(fd, *s);
    5dc2:	8556                	mv	a0,s5
    5dc4:	00000097          	auipc	ra,0x0
    5dc8:	df0080e7          	jalr	-528(ra) # 5bb4 <putc>
          s++;
    5dcc:	0905                	addi	s2,s2,1
        while(*s != 0){
    5dce:	00094583          	lbu	a1,0(s2)
    5dd2:	f9e5                	bnez	a1,5dc2 <vprintf+0x144>
        s = va_arg(ap, char*);
    5dd4:	8bce                	mv	s7,s3
      state = 0;
    5dd6:	4981                	li	s3,0
    5dd8:	b5e5                	j	5cc0 <vprintf+0x42>
          s = "(null)";
    5dda:	00002917          	auipc	s2,0x2
    5dde:	61e90913          	addi	s2,s2,1566 # 83f8 <malloc+0x24c2>
        while(*s != 0){
    5de2:	02800593          	li	a1,40
    5de6:	bff1                	j	5dc2 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
    5de8:	008b8913          	addi	s2,s7,8
    5dec:	000bc583          	lbu	a1,0(s7)
    5df0:	8556                	mv	a0,s5
    5df2:	00000097          	auipc	ra,0x0
    5df6:	dc2080e7          	jalr	-574(ra) # 5bb4 <putc>
    5dfa:	8bca                	mv	s7,s2
      state = 0;
    5dfc:	4981                	li	s3,0
    5dfe:	b5c9                	j	5cc0 <vprintf+0x42>
        putc(fd, c);
    5e00:	02500593          	li	a1,37
    5e04:	8556                	mv	a0,s5
    5e06:	00000097          	auipc	ra,0x0
    5e0a:	dae080e7          	jalr	-594(ra) # 5bb4 <putc>
      state = 0;
    5e0e:	4981                	li	s3,0
    5e10:	bd45                	j	5cc0 <vprintf+0x42>
        putc(fd, '%');
    5e12:	02500593          	li	a1,37
    5e16:	8556                	mv	a0,s5
    5e18:	00000097          	auipc	ra,0x0
    5e1c:	d9c080e7          	jalr	-612(ra) # 5bb4 <putc>
        putc(fd, c);
    5e20:	85ca                	mv	a1,s2
    5e22:	8556                	mv	a0,s5
    5e24:	00000097          	auipc	ra,0x0
    5e28:	d90080e7          	jalr	-624(ra) # 5bb4 <putc>
      state = 0;
    5e2c:	4981                	li	s3,0
    5e2e:	bd49                	j	5cc0 <vprintf+0x42>
        s = va_arg(ap, char*);
    5e30:	8bce                	mv	s7,s3
      state = 0;
    5e32:	4981                	li	s3,0
    5e34:	b571                	j	5cc0 <vprintf+0x42>
    5e36:	74e2                	ld	s1,56(sp)
    5e38:	79a2                	ld	s3,40(sp)
    5e3a:	7a02                	ld	s4,32(sp)
    5e3c:	6ae2                	ld	s5,24(sp)
    5e3e:	6b42                	ld	s6,16(sp)
    5e40:	6ba2                	ld	s7,8(sp)
    }
  }
}
    5e42:	60a6                	ld	ra,72(sp)
    5e44:	6406                	ld	s0,64(sp)
    5e46:	7942                	ld	s2,48(sp)
    5e48:	6161                	addi	sp,sp,80
    5e4a:	8082                	ret

0000000000005e4c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5e4c:	715d                	addi	sp,sp,-80
    5e4e:	ec06                	sd	ra,24(sp)
    5e50:	e822                	sd	s0,16(sp)
    5e52:	1000                	addi	s0,sp,32
    5e54:	e010                	sd	a2,0(s0)
    5e56:	e414                	sd	a3,8(s0)
    5e58:	e818                	sd	a4,16(s0)
    5e5a:	ec1c                	sd	a5,24(s0)
    5e5c:	03043023          	sd	a6,32(s0)
    5e60:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5e64:	8622                	mv	a2,s0
    5e66:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5e6a:	00000097          	auipc	ra,0x0
    5e6e:	e14080e7          	jalr	-492(ra) # 5c7e <vprintf>
}
    5e72:	60e2                	ld	ra,24(sp)
    5e74:	6442                	ld	s0,16(sp)
    5e76:	6161                	addi	sp,sp,80
    5e78:	8082                	ret

0000000000005e7a <printf>:

void
printf(const char *fmt, ...)
{
    5e7a:	711d                	addi	sp,sp,-96
    5e7c:	ec06                	sd	ra,24(sp)
    5e7e:	e822                	sd	s0,16(sp)
    5e80:	1000                	addi	s0,sp,32
    5e82:	e40c                	sd	a1,8(s0)
    5e84:	e810                	sd	a2,16(s0)
    5e86:	ec14                	sd	a3,24(s0)
    5e88:	f018                	sd	a4,32(s0)
    5e8a:	f41c                	sd	a5,40(s0)
    5e8c:	03043823          	sd	a6,48(s0)
    5e90:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5e94:	00840613          	addi	a2,s0,8
    5e98:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5e9c:	85aa                	mv	a1,a0
    5e9e:	4505                	li	a0,1
    5ea0:	00000097          	auipc	ra,0x0
    5ea4:	dde080e7          	jalr	-546(ra) # 5c7e <vprintf>
}
    5ea8:	60e2                	ld	ra,24(sp)
    5eaa:	6442                	ld	s0,16(sp)
    5eac:	6125                	addi	sp,sp,96
    5eae:	8082                	ret

0000000000005eb0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5eb0:	1141                	addi	sp,sp,-16
    5eb2:	e406                	sd	ra,8(sp)
    5eb4:	e022                	sd	s0,0(sp)
    5eb6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5eb8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5ebc:	00004797          	auipc	a5,0x4
    5ec0:	d747b783          	ld	a5,-652(a5) # 9c30 <freep>
    5ec4:	a039                	j	5ed2 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5ec6:	6398                	ld	a4,0(a5)
    5ec8:	00e7e463          	bltu	a5,a4,5ed0 <free+0x20>
    5ecc:	00e6ea63          	bltu	a3,a4,5ee0 <free+0x30>
{
    5ed0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5ed2:	fed7fae3          	bgeu	a5,a3,5ec6 <free+0x16>
    5ed6:	6398                	ld	a4,0(a5)
    5ed8:	00e6e463          	bltu	a3,a4,5ee0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5edc:	fee7eae3          	bltu	a5,a4,5ed0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    5ee0:	ff852583          	lw	a1,-8(a0)
    5ee4:	6390                	ld	a2,0(a5)
    5ee6:	02059813          	slli	a6,a1,0x20
    5eea:	01c85713          	srli	a4,a6,0x1c
    5eee:	9736                	add	a4,a4,a3
    5ef0:	02e60563          	beq	a2,a4,5f1a <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    5ef4:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    5ef8:	4790                	lw	a2,8(a5)
    5efa:	02061593          	slli	a1,a2,0x20
    5efe:	01c5d713          	srli	a4,a1,0x1c
    5f02:	973e                	add	a4,a4,a5
    5f04:	02e68263          	beq	a3,a4,5f28 <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    5f08:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    5f0a:	00004717          	auipc	a4,0x4
    5f0e:	d2f73323          	sd	a5,-730(a4) # 9c30 <freep>
}
    5f12:	60a2                	ld	ra,8(sp)
    5f14:	6402                	ld	s0,0(sp)
    5f16:	0141                	addi	sp,sp,16
    5f18:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    5f1a:	4618                	lw	a4,8(a2)
    5f1c:	9f2d                	addw	a4,a4,a1
    5f1e:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5f22:	6398                	ld	a4,0(a5)
    5f24:	6310                	ld	a2,0(a4)
    5f26:	b7f9                	j	5ef4 <free+0x44>
    p->s.size += bp->s.size;
    5f28:	ff852703          	lw	a4,-8(a0)
    5f2c:	9f31                	addw	a4,a4,a2
    5f2e:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5f30:	ff053683          	ld	a3,-16(a0)
    5f34:	bfd1                	j	5f08 <free+0x58>

0000000000005f36 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5f36:	7139                	addi	sp,sp,-64
    5f38:	fc06                	sd	ra,56(sp)
    5f3a:	f822                	sd	s0,48(sp)
    5f3c:	f04a                	sd	s2,32(sp)
    5f3e:	ec4e                	sd	s3,24(sp)
    5f40:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5f42:	02051993          	slli	s3,a0,0x20
    5f46:	0209d993          	srli	s3,s3,0x20
    5f4a:	09bd                	addi	s3,s3,15
    5f4c:	0049d993          	srli	s3,s3,0x4
    5f50:	2985                	addiw	s3,s3,1
    5f52:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    5f54:	00004517          	auipc	a0,0x4
    5f58:	cdc53503          	ld	a0,-804(a0) # 9c30 <freep>
    5f5c:	c905                	beqz	a0,5f8c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5f5e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5f60:	4798                	lw	a4,8(a5)
    5f62:	09377a63          	bgeu	a4,s3,5ff6 <malloc+0xc0>
    5f66:	f426                	sd	s1,40(sp)
    5f68:	e852                	sd	s4,16(sp)
    5f6a:	e456                	sd	s5,8(sp)
    5f6c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    5f6e:	8a4e                	mv	s4,s3
    5f70:	6705                	lui	a4,0x1
    5f72:	00e9f363          	bgeu	s3,a4,5f78 <malloc+0x42>
    5f76:	6a05                	lui	s4,0x1
    5f78:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5f7c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    5f80:	00004497          	auipc	s1,0x4
    5f84:	cb048493          	addi	s1,s1,-848 # 9c30 <freep>
  if(p == (char*)-1)
    5f88:	5afd                	li	s5,-1
    5f8a:	a089                	j	5fcc <malloc+0x96>
    5f8c:	f426                	sd	s1,40(sp)
    5f8e:	e852                	sd	s4,16(sp)
    5f90:	e456                	sd	s5,8(sp)
    5f92:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    5f94:	0000a797          	auipc	a5,0xa
    5f98:	4bc78793          	addi	a5,a5,1212 # 10450 <base>
    5f9c:	00004717          	auipc	a4,0x4
    5fa0:	c8f73a23          	sd	a5,-876(a4) # 9c30 <freep>
    5fa4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5fa6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    5faa:	b7d1                	j	5f6e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    5fac:	6398                	ld	a4,0(a5)
    5fae:	e118                	sd	a4,0(a0)
    5fb0:	a8b9                	j	600e <malloc+0xd8>
  hp->s.size = nu;
    5fb2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5fb6:	0541                	addi	a0,a0,16
    5fb8:	00000097          	auipc	ra,0x0
    5fbc:	ef8080e7          	jalr	-264(ra) # 5eb0 <free>
  return freep;
    5fc0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    5fc2:	c135                	beqz	a0,6026 <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5fc4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5fc6:	4798                	lw	a4,8(a5)
    5fc8:	03277363          	bgeu	a4,s2,5fee <malloc+0xb8>
    if(p == freep)
    5fcc:	6098                	ld	a4,0(s1)
    5fce:	853e                	mv	a0,a5
    5fd0:	fef71ae3          	bne	a4,a5,5fc4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    5fd4:	8552                	mv	a0,s4
    5fd6:	00000097          	auipc	ra,0x0
    5fda:	bc6080e7          	jalr	-1082(ra) # 5b9c <sbrk>
  if(p == (char*)-1)
    5fde:	fd551ae3          	bne	a0,s5,5fb2 <malloc+0x7c>
        return 0;
    5fe2:	4501                	li	a0,0
    5fe4:	74a2                	ld	s1,40(sp)
    5fe6:	6a42                	ld	s4,16(sp)
    5fe8:	6aa2                	ld	s5,8(sp)
    5fea:	6b02                	ld	s6,0(sp)
    5fec:	a03d                	j	601a <malloc+0xe4>
    5fee:	74a2                	ld	s1,40(sp)
    5ff0:	6a42                	ld	s4,16(sp)
    5ff2:	6aa2                	ld	s5,8(sp)
    5ff4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    5ff6:	fae90be3          	beq	s2,a4,5fac <malloc+0x76>
        p->s.size -= nunits;
    5ffa:	4137073b          	subw	a4,a4,s3
    5ffe:	c798                	sw	a4,8(a5)
        p += p->s.size;
    6000:	02071693          	slli	a3,a4,0x20
    6004:	01c6d713          	srli	a4,a3,0x1c
    6008:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    600a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    600e:	00004717          	auipc	a4,0x4
    6012:	c2a73123          	sd	a0,-990(a4) # 9c30 <freep>
      return (void*)(p + 1);
    6016:	01078513          	addi	a0,a5,16
  }
}
    601a:	70e2                	ld	ra,56(sp)
    601c:	7442                	ld	s0,48(sp)
    601e:	7902                	ld	s2,32(sp)
    6020:	69e2                	ld	s3,24(sp)
    6022:	6121                	addi	sp,sp,64
    6024:	8082                	ret
    6026:	74a2                	ld	s1,40(sp)
    6028:	6a42                	ld	s4,16(sp)
    602a:	6aa2                	ld	s5,8(sp)
    602c:	6b02                	ld	s6,0(sp)
    602e:	b7f5                	j	601a <malloc+0xe4>
