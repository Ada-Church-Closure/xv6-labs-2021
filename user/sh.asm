
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  fprintf(2, "$ ");
      10:	00001597          	auipc	a1,0x1
      14:	32858593          	addi	a1,a1,808 # 1338 <malloc+0xfc>
      18:	4509                	li	a0,2
      1a:	00001097          	auipc	ra,0x1
      1e:	138080e7          	jalr	312(ra) # 1152 <fprintf>
  memset(buf, 0, nbuf);
      22:	864a                	mv	a2,s2
      24:	4581                	li	a1,0
      26:	8526                	mv	a0,s1
      28:	00001097          	auipc	ra,0x1
      2c:	be0080e7          	jalr	-1056(ra) # c08 <memset>
  gets(buf, nbuf);
      30:	85ca                	mv	a1,s2
      32:	8526                	mv	a0,s1
      34:	00001097          	auipc	ra,0x1
      38:	c22080e7          	jalr	-990(ra) # c56 <gets>
  if(buf[0] == 0) // EOF
      3c:	0004c503          	lbu	a0,0(s1)
      40:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      44:	40a0053b          	negw	a0,a0
      48:	60e2                	ld	ra,24(sp)
      4a:	6442                	ld	s0,16(sp)
      4c:	64a2                	ld	s1,8(sp)
      4e:	6902                	ld	s2,0(sp)
      50:	6105                	addi	sp,sp,32
      52:	8082                	ret

0000000000000054 <panic>:
  exit(0);
}

void
panic(char *s)
{
      54:	1141                	addi	sp,sp,-16
      56:	e406                	sd	ra,8(sp)
      58:	e022                	sd	s0,0(sp)
      5a:	0800                	addi	s0,sp,16
      5c:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      5e:	00001597          	auipc	a1,0x1
      62:	2ea58593          	addi	a1,a1,746 # 1348 <malloc+0x10c>
      66:	4509                	li	a0,2
      68:	00001097          	auipc	ra,0x1
      6c:	0ea080e7          	jalr	234(ra) # 1152 <fprintf>
  exit(1);
      70:	4505                	li	a0,1
      72:	00001097          	auipc	ra,0x1
      76:	da8080e7          	jalr	-600(ra) # e1a <exit>

000000000000007a <fork1>:
}

int
fork1(void)
{
      7a:	1141                	addi	sp,sp,-16
      7c:	e406                	sd	ra,8(sp)
      7e:	e022                	sd	s0,0(sp)
      80:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      82:	00001097          	auipc	ra,0x1
      86:	d90080e7          	jalr	-624(ra) # e12 <fork>
  if(pid == -1)
      8a:	57fd                	li	a5,-1
      8c:	00f50663          	beq	a0,a5,98 <fork1+0x1e>
    panic("fork");
  return pid;
}
      90:	60a2                	ld	ra,8(sp)
      92:	6402                	ld	s0,0(sp)
      94:	0141                	addi	sp,sp,16
      96:	8082                	ret
    panic("fork");
      98:	00001517          	auipc	a0,0x1
      9c:	2b850513          	addi	a0,a0,696 # 1350 <malloc+0x114>
      a0:	00000097          	auipc	ra,0x0
      a4:	fb4080e7          	jalr	-76(ra) # 54 <panic>

00000000000000a8 <runcmd>:
{
      a8:	7179                	addi	sp,sp,-48
      aa:	f406                	sd	ra,40(sp)
      ac:	f022                	sd	s0,32(sp)
      ae:	1800                	addi	s0,sp,48
  if(cmd == 0)
      b0:	c115                	beqz	a0,d4 <runcmd+0x2c>
      b2:	ec26                	sd	s1,24(sp)
      b4:	84aa                	mv	s1,a0
  switch(cmd->type){
      b6:	4118                	lw	a4,0(a0)
      b8:	4795                	li	a5,5
      ba:	02e7e363          	bltu	a5,a4,e0 <runcmd+0x38>
      be:	00056783          	lwu	a5,0(a0)
      c2:	078a                	slli	a5,a5,0x2
      c4:	00001717          	auipc	a4,0x1
      c8:	38c70713          	addi	a4,a4,908 # 1450 <malloc+0x214>
      cc:	97ba                	add	a5,a5,a4
      ce:	439c                	lw	a5,0(a5)
      d0:	97ba                	add	a5,a5,a4
      d2:	8782                	jr	a5
      d4:	ec26                	sd	s1,24(sp)
    exit(1);
      d6:	4505                	li	a0,1
      d8:	00001097          	auipc	ra,0x1
      dc:	d42080e7          	jalr	-702(ra) # e1a <exit>
    panic("runcmd");
      e0:	00001517          	auipc	a0,0x1
      e4:	27850513          	addi	a0,a0,632 # 1358 <malloc+0x11c>
      e8:	00000097          	auipc	ra,0x0
      ec:	f6c080e7          	jalr	-148(ra) # 54 <panic>
    if(ecmd->argv[0] == 0)
      f0:	6508                	ld	a0,8(a0)
      f2:	c515                	beqz	a0,11e <runcmd+0x76>
    exec(ecmd->argv[0], ecmd->argv);
      f4:	00848593          	addi	a1,s1,8
      f8:	00001097          	auipc	ra,0x1
      fc:	d5a080e7          	jalr	-678(ra) # e52 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     100:	6490                	ld	a2,8(s1)
     102:	00001597          	auipc	a1,0x1
     106:	25e58593          	addi	a1,a1,606 # 1360 <malloc+0x124>
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	046080e7          	jalr	70(ra) # 1152 <fprintf>
  exit(0);
     114:	4501                	li	a0,0
     116:	00001097          	auipc	ra,0x1
     11a:	d04080e7          	jalr	-764(ra) # e1a <exit>
      exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	cfa080e7          	jalr	-774(ra) # e1a <exit>
    close(rcmd->fd);
     128:	5148                	lw	a0,36(a0)
     12a:	00001097          	auipc	ra,0x1
     12e:	d18080e7          	jalr	-744(ra) # e42 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     132:	508c                	lw	a1,32(s1)
     134:	6888                	ld	a0,16(s1)
     136:	00001097          	auipc	ra,0x1
     13a:	d24080e7          	jalr	-732(ra) # e5a <open>
     13e:	00054763          	bltz	a0,14c <runcmd+0xa4>
    runcmd(rcmd->cmd);
     142:	6488                	ld	a0,8(s1)
     144:	00000097          	auipc	ra,0x0
     148:	f64080e7          	jalr	-156(ra) # a8 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     14c:	6890                	ld	a2,16(s1)
     14e:	00001597          	auipc	a1,0x1
     152:	22258593          	addi	a1,a1,546 # 1370 <malloc+0x134>
     156:	4509                	li	a0,2
     158:	00001097          	auipc	ra,0x1
     15c:	ffa080e7          	jalr	-6(ra) # 1152 <fprintf>
      exit(1);
     160:	4505                	li	a0,1
     162:	00001097          	auipc	ra,0x1
     166:	cb8080e7          	jalr	-840(ra) # e1a <exit>
    if(fork1() == 0)
     16a:	00000097          	auipc	ra,0x0
     16e:	f10080e7          	jalr	-240(ra) # 7a <fork1>
     172:	c919                	beqz	a0,188 <runcmd+0xe0>
    wait(0);
     174:	4501                	li	a0,0
     176:	00001097          	auipc	ra,0x1
     17a:	cac080e7          	jalr	-852(ra) # e22 <wait>
    runcmd(lcmd->right);
     17e:	6888                	ld	a0,16(s1)
     180:	00000097          	auipc	ra,0x0
     184:	f28080e7          	jalr	-216(ra) # a8 <runcmd>
      runcmd(lcmd->left);
     188:	6488                	ld	a0,8(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f1e080e7          	jalr	-226(ra) # a8 <runcmd>
    if(pipe(p) < 0)
     192:	fd840513          	addi	a0,s0,-40
     196:	00001097          	auipc	ra,0x1
     19a:	c94080e7          	jalr	-876(ra) # e2a <pipe>
     19e:	04054363          	bltz	a0,1e4 <runcmd+0x13c>
    if(fork1() == 0){
     1a2:	00000097          	auipc	ra,0x0
     1a6:	ed8080e7          	jalr	-296(ra) # 7a <fork1>
     1aa:	c529                	beqz	a0,1f4 <runcmd+0x14c>
    if(fork1() == 0){
     1ac:	00000097          	auipc	ra,0x0
     1b0:	ece080e7          	jalr	-306(ra) # 7a <fork1>
     1b4:	cd25                	beqz	a0,22c <runcmd+0x184>
    close(p[0]);
     1b6:	fd842503          	lw	a0,-40(s0)
     1ba:	00001097          	auipc	ra,0x1
     1be:	c88080e7          	jalr	-888(ra) # e42 <close>
    close(p[1]);
     1c2:	fdc42503          	lw	a0,-36(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	c7c080e7          	jalr	-900(ra) # e42 <close>
    wait(0);
     1ce:	4501                	li	a0,0
     1d0:	00001097          	auipc	ra,0x1
     1d4:	c52080e7          	jalr	-942(ra) # e22 <wait>
    wait(0);
     1d8:	4501                	li	a0,0
     1da:	00001097          	auipc	ra,0x1
     1de:	c48080e7          	jalr	-952(ra) # e22 <wait>
    break;
     1e2:	bf0d                	j	114 <runcmd+0x6c>
      panic("pipe");
     1e4:	00001517          	auipc	a0,0x1
     1e8:	19c50513          	addi	a0,a0,412 # 1380 <malloc+0x144>
     1ec:	00000097          	auipc	ra,0x0
     1f0:	e68080e7          	jalr	-408(ra) # 54 <panic>
      close(1);
     1f4:	4505                	li	a0,1
     1f6:	00001097          	auipc	ra,0x1
     1fa:	c4c080e7          	jalr	-948(ra) # e42 <close>
      dup(p[1]);
     1fe:	fdc42503          	lw	a0,-36(s0)
     202:	00001097          	auipc	ra,0x1
     206:	c90080e7          	jalr	-880(ra) # e92 <dup>
      close(p[0]);
     20a:	fd842503          	lw	a0,-40(s0)
     20e:	00001097          	auipc	ra,0x1
     212:	c34080e7          	jalr	-972(ra) # e42 <close>
      close(p[1]);
     216:	fdc42503          	lw	a0,-36(s0)
     21a:	00001097          	auipc	ra,0x1
     21e:	c28080e7          	jalr	-984(ra) # e42 <close>
      runcmd(pcmd->left);
     222:	6488                	ld	a0,8(s1)
     224:	00000097          	auipc	ra,0x0
     228:	e84080e7          	jalr	-380(ra) # a8 <runcmd>
      close(0);
     22c:	00001097          	auipc	ra,0x1
     230:	c16080e7          	jalr	-1002(ra) # e42 <close>
      dup(p[0]);
     234:	fd842503          	lw	a0,-40(s0)
     238:	00001097          	auipc	ra,0x1
     23c:	c5a080e7          	jalr	-934(ra) # e92 <dup>
      close(p[0]);
     240:	fd842503          	lw	a0,-40(s0)
     244:	00001097          	auipc	ra,0x1
     248:	bfe080e7          	jalr	-1026(ra) # e42 <close>
      close(p[1]);
     24c:	fdc42503          	lw	a0,-36(s0)
     250:	00001097          	auipc	ra,0x1
     254:	bf2080e7          	jalr	-1038(ra) # e42 <close>
      runcmd(pcmd->right);
     258:	6888                	ld	a0,16(s1)
     25a:	00000097          	auipc	ra,0x0
     25e:	e4e080e7          	jalr	-434(ra) # a8 <runcmd>
    if(fork1() == 0)
     262:	00000097          	auipc	ra,0x0
     266:	e18080e7          	jalr	-488(ra) # 7a <fork1>
     26a:	ea0515e3          	bnez	a0,114 <runcmd+0x6c>
      runcmd(bcmd->cmd);
     26e:	6488                	ld	a0,8(s1)
     270:	00000097          	auipc	ra,0x0
     274:	e38080e7          	jalr	-456(ra) # a8 <runcmd>

0000000000000278 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     278:	1101                	addi	sp,sp,-32
     27a:	ec06                	sd	ra,24(sp)
     27c:	e822                	sd	s0,16(sp)
     27e:	e426                	sd	s1,8(sp)
     280:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     282:	0a800513          	li	a0,168
     286:	00001097          	auipc	ra,0x1
     28a:	fb6080e7          	jalr	-74(ra) # 123c <malloc>
     28e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     290:	0a800613          	li	a2,168
     294:	4581                	li	a1,0
     296:	00001097          	auipc	ra,0x1
     29a:	972080e7          	jalr	-1678(ra) # c08 <memset>
  cmd->type = EXEC;
     29e:	4785                	li	a5,1
     2a0:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2a2:	8526                	mv	a0,s1
     2a4:	60e2                	ld	ra,24(sp)
     2a6:	6442                	ld	s0,16(sp)
     2a8:	64a2                	ld	s1,8(sp)
     2aa:	6105                	addi	sp,sp,32
     2ac:	8082                	ret

00000000000002ae <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2ae:	7139                	addi	sp,sp,-64
     2b0:	fc06                	sd	ra,56(sp)
     2b2:	f822                	sd	s0,48(sp)
     2b4:	f426                	sd	s1,40(sp)
     2b6:	f04a                	sd	s2,32(sp)
     2b8:	ec4e                	sd	s3,24(sp)
     2ba:	e852                	sd	s4,16(sp)
     2bc:	e456                	sd	s5,8(sp)
     2be:	e05a                	sd	s6,0(sp)
     2c0:	0080                	addi	s0,sp,64
     2c2:	892a                	mv	s2,a0
     2c4:	89ae                	mv	s3,a1
     2c6:	8a32                	mv	s4,a2
     2c8:	8ab6                	mv	s5,a3
     2ca:	8b3a                	mv	s6,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2cc:	02800513          	li	a0,40
     2d0:	00001097          	auipc	ra,0x1
     2d4:	f6c080e7          	jalr	-148(ra) # 123c <malloc>
     2d8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2da:	02800613          	li	a2,40
     2de:	4581                	li	a1,0
     2e0:	00001097          	auipc	ra,0x1
     2e4:	928080e7          	jalr	-1752(ra) # c08 <memset>
  cmd->type = REDIR;
     2e8:	4789                	li	a5,2
     2ea:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2ec:	0124b423          	sd	s2,8(s1)
  cmd->file = file;
     2f0:	0134b823          	sd	s3,16(s1)
  cmd->efile = efile;
     2f4:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     2f8:	0354a023          	sw	s5,32(s1)
  cmd->fd = fd;
     2fc:	0364a223          	sw	s6,36(s1)
  return (struct cmd*)cmd;
}
     300:	8526                	mv	a0,s1
     302:	70e2                	ld	ra,56(sp)
     304:	7442                	ld	s0,48(sp)
     306:	74a2                	ld	s1,40(sp)
     308:	7902                	ld	s2,32(sp)
     30a:	69e2                	ld	s3,24(sp)
     30c:	6a42                	ld	s4,16(sp)
     30e:	6aa2                	ld	s5,8(sp)
     310:	6b02                	ld	s6,0(sp)
     312:	6121                	addi	sp,sp,64
     314:	8082                	ret

0000000000000316 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     316:	7179                	addi	sp,sp,-48
     318:	f406                	sd	ra,40(sp)
     31a:	f022                	sd	s0,32(sp)
     31c:	ec26                	sd	s1,24(sp)
     31e:	e84a                	sd	s2,16(sp)
     320:	e44e                	sd	s3,8(sp)
     322:	1800                	addi	s0,sp,48
     324:	892a                	mv	s2,a0
     326:	89ae                	mv	s3,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     328:	4561                	li	a0,24
     32a:	00001097          	auipc	ra,0x1
     32e:	f12080e7          	jalr	-238(ra) # 123c <malloc>
     332:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     334:	4661                	li	a2,24
     336:	4581                	li	a1,0
     338:	00001097          	auipc	ra,0x1
     33c:	8d0080e7          	jalr	-1840(ra) # c08 <memset>
  cmd->type = PIPE;
     340:	478d                	li	a5,3
     342:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     344:	0124b423          	sd	s2,8(s1)
  cmd->right = right;
     348:	0134b823          	sd	s3,16(s1)
  return (struct cmd*)cmd;
}
     34c:	8526                	mv	a0,s1
     34e:	70a2                	ld	ra,40(sp)
     350:	7402                	ld	s0,32(sp)
     352:	64e2                	ld	s1,24(sp)
     354:	6942                	ld	s2,16(sp)
     356:	69a2                	ld	s3,8(sp)
     358:	6145                	addi	sp,sp,48
     35a:	8082                	ret

000000000000035c <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     35c:	7179                	addi	sp,sp,-48
     35e:	f406                	sd	ra,40(sp)
     360:	f022                	sd	s0,32(sp)
     362:	ec26                	sd	s1,24(sp)
     364:	e84a                	sd	s2,16(sp)
     366:	e44e                	sd	s3,8(sp)
     368:	1800                	addi	s0,sp,48
     36a:	892a                	mv	s2,a0
     36c:	89ae                	mv	s3,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     36e:	4561                	li	a0,24
     370:	00001097          	auipc	ra,0x1
     374:	ecc080e7          	jalr	-308(ra) # 123c <malloc>
     378:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     37a:	4661                	li	a2,24
     37c:	4581                	li	a1,0
     37e:	00001097          	auipc	ra,0x1
     382:	88a080e7          	jalr	-1910(ra) # c08 <memset>
  cmd->type = LIST;
     386:	4791                	li	a5,4
     388:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     38a:	0124b423          	sd	s2,8(s1)
  cmd->right = right;
     38e:	0134b823          	sd	s3,16(s1)
  return (struct cmd*)cmd;
}
     392:	8526                	mv	a0,s1
     394:	70a2                	ld	ra,40(sp)
     396:	7402                	ld	s0,32(sp)
     398:	64e2                	ld	s1,24(sp)
     39a:	6942                	ld	s2,16(sp)
     39c:	69a2                	ld	s3,8(sp)
     39e:	6145                	addi	sp,sp,48
     3a0:	8082                	ret

00000000000003a2 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3a2:	1101                	addi	sp,sp,-32
     3a4:	ec06                	sd	ra,24(sp)
     3a6:	e822                	sd	s0,16(sp)
     3a8:	e426                	sd	s1,8(sp)
     3aa:	e04a                	sd	s2,0(sp)
     3ac:	1000                	addi	s0,sp,32
     3ae:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b0:	4541                	li	a0,16
     3b2:	00001097          	auipc	ra,0x1
     3b6:	e8a080e7          	jalr	-374(ra) # 123c <malloc>
     3ba:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3bc:	4641                	li	a2,16
     3be:	4581                	li	a1,0
     3c0:	00001097          	auipc	ra,0x1
     3c4:	848080e7          	jalr	-1976(ra) # c08 <memset>
  cmd->type = BACK;
     3c8:	4795                	li	a5,5
     3ca:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3cc:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     3d0:	8526                	mv	a0,s1
     3d2:	60e2                	ld	ra,24(sp)
     3d4:	6442                	ld	s0,16(sp)
     3d6:	64a2                	ld	s1,8(sp)
     3d8:	6902                	ld	s2,0(sp)
     3da:	6105                	addi	sp,sp,32
     3dc:	8082                	ret

00000000000003de <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3de:	7139                	addi	sp,sp,-64
     3e0:	fc06                	sd	ra,56(sp)
     3e2:	f822                	sd	s0,48(sp)
     3e4:	f426                	sd	s1,40(sp)
     3e6:	f04a                	sd	s2,32(sp)
     3e8:	ec4e                	sd	s3,24(sp)
     3ea:	e852                	sd	s4,16(sp)
     3ec:	e456                	sd	s5,8(sp)
     3ee:	e05a                	sd	s6,0(sp)
     3f0:	0080                	addi	s0,sp,64
     3f2:	8a2a                	mv	s4,a0
     3f4:	892e                	mv	s2,a1
     3f6:	8ab2                	mv	s5,a2
     3f8:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     3fa:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     3fc:	00002997          	auipc	s3,0x2
     400:	8ec98993          	addi	s3,s3,-1812 # 1ce8 <whitespace>
     404:	00b4fe63          	bgeu	s1,a1,420 <gettoken+0x42>
     408:	0004c583          	lbu	a1,0(s1)
     40c:	854e                	mv	a0,s3
     40e:	00001097          	auipc	ra,0x1
     412:	820080e7          	jalr	-2016(ra) # c2e <strchr>
     416:	c509                	beqz	a0,420 <gettoken+0x42>
    s++;
     418:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     41a:	fe9917e3          	bne	s2,s1,408 <gettoken+0x2a>
     41e:	84ca                	mv	s1,s2
  if(q)
     420:	000a8463          	beqz	s5,428 <gettoken+0x4a>
    *q = s;
     424:	009ab023          	sd	s1,0(s5)
  ret = *s;
     428:	0004c783          	lbu	a5,0(s1)
     42c:	00078a9b          	sext.w	s5,a5
  switch(*s){
     430:	03c00713          	li	a4,60
     434:	06f76663          	bltu	a4,a5,4a0 <gettoken+0xc2>
     438:	03a00713          	li	a4,58
     43c:	00f76e63          	bltu	a4,a5,458 <gettoken+0x7a>
     440:	cf89                	beqz	a5,45a <gettoken+0x7c>
     442:	02600713          	li	a4,38
     446:	00e78963          	beq	a5,a4,458 <gettoken+0x7a>
     44a:	fd87879b          	addiw	a5,a5,-40
     44e:	0ff7f793          	zext.b	a5,a5
     452:	4705                	li	a4,1
     454:	06f76763          	bltu	a4,a5,4c2 <gettoken+0xe4>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     458:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     45a:	000b0463          	beqz	s6,462 <gettoken+0x84>
    *eq = s;
     45e:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     462:	00002997          	auipc	s3,0x2
     466:	88698993          	addi	s3,s3,-1914 # 1ce8 <whitespace>
     46a:	0124fe63          	bgeu	s1,s2,486 <gettoken+0xa8>
     46e:	0004c583          	lbu	a1,0(s1)
     472:	854e                	mv	a0,s3
     474:	00000097          	auipc	ra,0x0
     478:	7ba080e7          	jalr	1978(ra) # c2e <strchr>
     47c:	c509                	beqz	a0,486 <gettoken+0xa8>
    s++;
     47e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     480:	fe9917e3          	bne	s2,s1,46e <gettoken+0x90>
     484:	84ca                	mv	s1,s2
  *ps = s;
     486:	009a3023          	sd	s1,0(s4)
  return ret;
}
     48a:	8556                	mv	a0,s5
     48c:	70e2                	ld	ra,56(sp)
     48e:	7442                	ld	s0,48(sp)
     490:	74a2                	ld	s1,40(sp)
     492:	7902                	ld	s2,32(sp)
     494:	69e2                	ld	s3,24(sp)
     496:	6a42                	ld	s4,16(sp)
     498:	6aa2                	ld	s5,8(sp)
     49a:	6b02                	ld	s6,0(sp)
     49c:	6121                	addi	sp,sp,64
     49e:	8082                	ret
  switch(*s){
     4a0:	03e00713          	li	a4,62
     4a4:	00e79b63          	bne	a5,a4,4ba <gettoken+0xdc>
    if(*s == '>'){
     4a8:	0014c703          	lbu	a4,1(s1)
     4ac:	03e00793          	li	a5,62
     4b0:	04f70c63          	beq	a4,a5,508 <gettoken+0x12a>
    s++;
     4b4:	0485                	addi	s1,s1,1
  ret = *s;
     4b6:	8abe                	mv	s5,a5
     4b8:	b74d                	j	45a <gettoken+0x7c>
  switch(*s){
     4ba:	07c00713          	li	a4,124
     4be:	f8e78de3          	beq	a5,a4,458 <gettoken+0x7a>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4c2:	00002997          	auipc	s3,0x2
     4c6:	82698993          	addi	s3,s3,-2010 # 1ce8 <whitespace>
     4ca:	00002a97          	auipc	s5,0x2
     4ce:	816a8a93          	addi	s5,s5,-2026 # 1ce0 <symbols>
     4d2:	0524f563          	bgeu	s1,s2,51c <gettoken+0x13e>
     4d6:	0004c583          	lbu	a1,0(s1)
     4da:	854e                	mv	a0,s3
     4dc:	00000097          	auipc	ra,0x0
     4e0:	752080e7          	jalr	1874(ra) # c2e <strchr>
     4e4:	e90d                	bnez	a0,516 <gettoken+0x138>
     4e6:	0004c583          	lbu	a1,0(s1)
     4ea:	8556                	mv	a0,s5
     4ec:	00000097          	auipc	ra,0x0
     4f0:	742080e7          	jalr	1858(ra) # c2e <strchr>
     4f4:	ed11                	bnez	a0,510 <gettoken+0x132>
      s++;
     4f6:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4f8:	fc991fe3          	bne	s2,s1,4d6 <gettoken+0xf8>
  if(eq)
     4fc:	84ca                	mv	s1,s2
    ret = 'a';
     4fe:	06100a93          	li	s5,97
  if(eq)
     502:	f40b1ee3          	bnez	s6,45e <gettoken+0x80>
     506:	b741                	j	486 <gettoken+0xa8>
      s++;
     508:	0489                	addi	s1,s1,2
      ret = '+';
     50a:	02b00a93          	li	s5,43
     50e:	b7b1                	j	45a <gettoken+0x7c>
    ret = 'a';
     510:	06100a93          	li	s5,97
     514:	b799                	j	45a <gettoken+0x7c>
     516:	06100a93          	li	s5,97
     51a:	b781                	j	45a <gettoken+0x7c>
     51c:	06100a93          	li	s5,97
  if(eq)
     520:	f20b1fe3          	bnez	s6,45e <gettoken+0x80>
     524:	b78d                	j	486 <gettoken+0xa8>

0000000000000526 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     526:	7139                	addi	sp,sp,-64
     528:	fc06                	sd	ra,56(sp)
     52a:	f822                	sd	s0,48(sp)
     52c:	f426                	sd	s1,40(sp)
     52e:	f04a                	sd	s2,32(sp)
     530:	ec4e                	sd	s3,24(sp)
     532:	e852                	sd	s4,16(sp)
     534:	e456                	sd	s5,8(sp)
     536:	0080                	addi	s0,sp,64
     538:	8a2a                	mv	s4,a0
     53a:	892e                	mv	s2,a1
     53c:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     53e:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     540:	00001997          	auipc	s3,0x1
     544:	7a898993          	addi	s3,s3,1960 # 1ce8 <whitespace>
     548:	00b4fe63          	bgeu	s1,a1,564 <peek+0x3e>
     54c:	0004c583          	lbu	a1,0(s1)
     550:	854e                	mv	a0,s3
     552:	00000097          	auipc	ra,0x0
     556:	6dc080e7          	jalr	1756(ra) # c2e <strchr>
     55a:	c509                	beqz	a0,564 <peek+0x3e>
    s++;
     55c:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     55e:	fe9917e3          	bne	s2,s1,54c <peek+0x26>
     562:	84ca                	mv	s1,s2
  *ps = s;
     564:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     568:	0004c583          	lbu	a1,0(s1)
     56c:	4501                	li	a0,0
     56e:	e991                	bnez	a1,582 <peek+0x5c>
}
     570:	70e2                	ld	ra,56(sp)
     572:	7442                	ld	s0,48(sp)
     574:	74a2                	ld	s1,40(sp)
     576:	7902                	ld	s2,32(sp)
     578:	69e2                	ld	s3,24(sp)
     57a:	6a42                	ld	s4,16(sp)
     57c:	6aa2                	ld	s5,8(sp)
     57e:	6121                	addi	sp,sp,64
     580:	8082                	ret
  return *s && strchr(toks, *s);
     582:	8556                	mv	a0,s5
     584:	00000097          	auipc	ra,0x0
     588:	6aa080e7          	jalr	1706(ra) # c2e <strchr>
     58c:	00a03533          	snez	a0,a0
     590:	b7c5                	j	570 <peek+0x4a>

0000000000000592 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     592:	7159                	addi	sp,sp,-112
     594:	f486                	sd	ra,104(sp)
     596:	f0a2                	sd	s0,96(sp)
     598:	eca6                	sd	s1,88(sp)
     59a:	e8ca                	sd	s2,80(sp)
     59c:	e4ce                	sd	s3,72(sp)
     59e:	e0d2                	sd	s4,64(sp)
     5a0:	fc56                	sd	s5,56(sp)
     5a2:	f85a                	sd	s6,48(sp)
     5a4:	f45e                	sd	s7,40(sp)
     5a6:	f062                	sd	s8,32(sp)
     5a8:	ec66                	sd	s9,24(sp)
     5aa:	1880                	addi	s0,sp,112
     5ac:	8a2a                	mv	s4,a0
     5ae:	89ae                	mv	s3,a1
     5b0:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5b2:	00001b17          	auipc	s6,0x1
     5b6:	df6b0b13          	addi	s6,s6,-522 # 13a8 <malloc+0x16c>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5ba:	f9040c93          	addi	s9,s0,-112
     5be:	f9840c13          	addi	s8,s0,-104
     5c2:	06100b93          	li	s7,97
  while(peek(ps, es, "<>")){
     5c6:	a02d                	j	5f0 <parseredirs+0x5e>
      panic("missing file for redirection");
     5c8:	00001517          	auipc	a0,0x1
     5cc:	dc050513          	addi	a0,a0,-576 # 1388 <malloc+0x14c>
     5d0:	00000097          	auipc	ra,0x0
     5d4:	a84080e7          	jalr	-1404(ra) # 54 <panic>
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5d8:	4701                	li	a4,0
     5da:	4681                	li	a3,0
     5dc:	f9043603          	ld	a2,-112(s0)
     5e0:	f9843583          	ld	a1,-104(s0)
     5e4:	8552                	mv	a0,s4
     5e6:	00000097          	auipc	ra,0x0
     5ea:	cc8080e7          	jalr	-824(ra) # 2ae <redircmd>
     5ee:	8a2a                	mv	s4,a0
    switch(tok){
     5f0:	03c00a93          	li	s5,60
  while(peek(ps, es, "<>")){
     5f4:	865a                	mv	a2,s6
     5f6:	85ca                	mv	a1,s2
     5f8:	854e                	mv	a0,s3
     5fa:	00000097          	auipc	ra,0x0
     5fe:	f2c080e7          	jalr	-212(ra) # 526 <peek>
     602:	c935                	beqz	a0,676 <parseredirs+0xe4>
    tok = gettoken(ps, es, 0, 0);
     604:	4681                	li	a3,0
     606:	4601                	li	a2,0
     608:	85ca                	mv	a1,s2
     60a:	854e                	mv	a0,s3
     60c:	00000097          	auipc	ra,0x0
     610:	dd2080e7          	jalr	-558(ra) # 3de <gettoken>
     614:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     616:	86e6                	mv	a3,s9
     618:	8662                	mv	a2,s8
     61a:	85ca                	mv	a1,s2
     61c:	854e                	mv	a0,s3
     61e:	00000097          	auipc	ra,0x0
     622:	dc0080e7          	jalr	-576(ra) # 3de <gettoken>
     626:	fb7511e3          	bne	a0,s7,5c8 <parseredirs+0x36>
    switch(tok){
     62a:	fb5487e3          	beq	s1,s5,5d8 <parseredirs+0x46>
     62e:	03e00793          	li	a5,62
     632:	02f48463          	beq	s1,a5,65a <parseredirs+0xc8>
     636:	02b00793          	li	a5,43
     63a:	faf49de3          	bne	s1,a5,5f4 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     63e:	4705                	li	a4,1
     640:	20100693          	li	a3,513
     644:	f9043603          	ld	a2,-112(s0)
     648:	f9843583          	ld	a1,-104(s0)
     64c:	8552                	mv	a0,s4
     64e:	00000097          	auipc	ra,0x0
     652:	c60080e7          	jalr	-928(ra) # 2ae <redircmd>
     656:	8a2a                	mv	s4,a0
      break;
     658:	bf61                	j	5f0 <parseredirs+0x5e>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     65a:	4705                	li	a4,1
     65c:	60100693          	li	a3,1537
     660:	f9043603          	ld	a2,-112(s0)
     664:	f9843583          	ld	a1,-104(s0)
     668:	8552                	mv	a0,s4
     66a:	00000097          	auipc	ra,0x0
     66e:	c44080e7          	jalr	-956(ra) # 2ae <redircmd>
     672:	8a2a                	mv	s4,a0
      break;
     674:	bfb5                	j	5f0 <parseredirs+0x5e>
    }
  }
  return cmd;
}
     676:	8552                	mv	a0,s4
     678:	70a6                	ld	ra,104(sp)
     67a:	7406                	ld	s0,96(sp)
     67c:	64e6                	ld	s1,88(sp)
     67e:	6946                	ld	s2,80(sp)
     680:	69a6                	ld	s3,72(sp)
     682:	6a06                	ld	s4,64(sp)
     684:	7ae2                	ld	s5,56(sp)
     686:	7b42                	ld	s6,48(sp)
     688:	7ba2                	ld	s7,40(sp)
     68a:	7c02                	ld	s8,32(sp)
     68c:	6ce2                	ld	s9,24(sp)
     68e:	6165                	addi	sp,sp,112
     690:	8082                	ret

0000000000000692 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     692:	7119                	addi	sp,sp,-128
     694:	fc86                	sd	ra,120(sp)
     696:	f8a2                	sd	s0,112(sp)
     698:	f4a6                	sd	s1,104(sp)
     69a:	e8d2                	sd	s4,80(sp)
     69c:	e4d6                	sd	s5,72(sp)
     69e:	0100                	addi	s0,sp,128
     6a0:	8a2a                	mv	s4,a0
     6a2:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6a4:	00001617          	auipc	a2,0x1
     6a8:	d0c60613          	addi	a2,a2,-756 # 13b0 <malloc+0x174>
     6ac:	00000097          	auipc	ra,0x0
     6b0:	e7a080e7          	jalr	-390(ra) # 526 <peek>
     6b4:	e521                	bnez	a0,6fc <parseexec+0x6a>
     6b6:	f0ca                	sd	s2,96(sp)
     6b8:	ecce                	sd	s3,88(sp)
     6ba:	e0da                	sd	s6,64(sp)
     6bc:	fc5e                	sd	s7,56(sp)
     6be:	f862                	sd	s8,48(sp)
     6c0:	f466                	sd	s9,40(sp)
     6c2:	f06a                	sd	s10,32(sp)
     6c4:	ec6e                	sd	s11,24(sp)
     6c6:	892a                	mv	s2,a0
    return parseblock(ps, es);

  ret = execcmd();
     6c8:	00000097          	auipc	ra,0x0
     6cc:	bb0080e7          	jalr	-1104(ra) # 278 <execcmd>
     6d0:	89aa                	mv	s3,a0
     6d2:	8daa                	mv	s11,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6d4:	8656                	mv	a2,s5
     6d6:	85d2                	mv	a1,s4
     6d8:	00000097          	auipc	ra,0x0
     6dc:	eba080e7          	jalr	-326(ra) # 592 <parseredirs>
     6e0:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     6e2:	09a1                	addi	s3,s3,8
     6e4:	00001b17          	auipc	s6,0x1
     6e8:	cecb0b13          	addi	s6,s6,-788 # 13d0 <malloc+0x194>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     6ec:	f8040c13          	addi	s8,s0,-128
     6f0:	f8840b93          	addi	s7,s0,-120
      break;
    if(tok != 'a')
     6f4:	06100d13          	li	s10,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     6f8:	4ca9                	li	s9,10
  while(!peek(ps, es, "|)&;")){
     6fa:	a089                	j	73c <parseexec+0xaa>
    return parseblock(ps, es);
     6fc:	85d6                	mv	a1,s5
     6fe:	8552                	mv	a0,s4
     700:	00000097          	auipc	ra,0x0
     704:	1c4080e7          	jalr	452(ra) # 8c4 <parseblock>
     708:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     70a:	8526                	mv	a0,s1
     70c:	70e6                	ld	ra,120(sp)
     70e:	7446                	ld	s0,112(sp)
     710:	74a6                	ld	s1,104(sp)
     712:	6a46                	ld	s4,80(sp)
     714:	6aa6                	ld	s5,72(sp)
     716:	6109                	addi	sp,sp,128
     718:	8082                	ret
      panic("syntax");
     71a:	00001517          	auipc	a0,0x1
     71e:	c9e50513          	addi	a0,a0,-866 # 13b8 <malloc+0x17c>
     722:	00000097          	auipc	ra,0x0
     726:	932080e7          	jalr	-1742(ra) # 54 <panic>
    if(argc >= MAXARGS)
     72a:	09a1                	addi	s3,s3,8
    ret = parseredirs(ret, ps, es);
     72c:	8656                	mv	a2,s5
     72e:	85d2                	mv	a1,s4
     730:	8526                	mv	a0,s1
     732:	00000097          	auipc	ra,0x0
     736:	e60080e7          	jalr	-416(ra) # 592 <parseredirs>
     73a:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     73c:	865a                	mv	a2,s6
     73e:	85d6                	mv	a1,s5
     740:	8552                	mv	a0,s4
     742:	00000097          	auipc	ra,0x0
     746:	de4080e7          	jalr	-540(ra) # 526 <peek>
     74a:	ed1d                	bnez	a0,788 <parseexec+0xf6>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     74c:	86e2                	mv	a3,s8
     74e:	865e                	mv	a2,s7
     750:	85d6                	mv	a1,s5
     752:	8552                	mv	a0,s4
     754:	00000097          	auipc	ra,0x0
     758:	c8a080e7          	jalr	-886(ra) # 3de <gettoken>
     75c:	c515                	beqz	a0,788 <parseexec+0xf6>
    if(tok != 'a')
     75e:	fba51ee3          	bne	a0,s10,71a <parseexec+0x88>
    cmd->argv[argc] = q;
     762:	f8843783          	ld	a5,-120(s0)
     766:	00f9b023          	sd	a5,0(s3)
    cmd->eargv[argc] = eq;
     76a:	f8043783          	ld	a5,-128(s0)
     76e:	04f9b823          	sd	a5,80(s3)
    argc++;
     772:	2905                	addiw	s2,s2,1
    if(argc >= MAXARGS)
     774:	fb991be3          	bne	s2,s9,72a <parseexec+0x98>
      panic("too many args");
     778:	00001517          	auipc	a0,0x1
     77c:	c4850513          	addi	a0,a0,-952 # 13c0 <malloc+0x184>
     780:	00000097          	auipc	ra,0x0
     784:	8d4080e7          	jalr	-1836(ra) # 54 <panic>
  cmd->argv[argc] = 0;
     788:	090e                	slli	s2,s2,0x3
     78a:	012d87b3          	add	a5,s11,s2
     78e:	0007b423          	sd	zero,8(a5)
  cmd->eargv[argc] = 0;
     792:	0407bc23          	sd	zero,88(a5)
     796:	7906                	ld	s2,96(sp)
     798:	69e6                	ld	s3,88(sp)
     79a:	6b06                	ld	s6,64(sp)
     79c:	7be2                	ld	s7,56(sp)
     79e:	7c42                	ld	s8,48(sp)
     7a0:	7ca2                	ld	s9,40(sp)
     7a2:	7d02                	ld	s10,32(sp)
     7a4:	6de2                	ld	s11,24(sp)
  return ret;
     7a6:	b795                	j	70a <parseexec+0x78>

00000000000007a8 <parsepipe>:
{
     7a8:	7179                	addi	sp,sp,-48
     7aa:	f406                	sd	ra,40(sp)
     7ac:	f022                	sd	s0,32(sp)
     7ae:	ec26                	sd	s1,24(sp)
     7b0:	e84a                	sd	s2,16(sp)
     7b2:	e44e                	sd	s3,8(sp)
     7b4:	e052                	sd	s4,0(sp)
     7b6:	1800                	addi	s0,sp,48
     7b8:	892a                	mv	s2,a0
     7ba:	8a2a                	mv	s4,a0
     7bc:	84ae                	mv	s1,a1
  cmd = parseexec(ps, es);
     7be:	00000097          	auipc	ra,0x0
     7c2:	ed4080e7          	jalr	-300(ra) # 692 <parseexec>
     7c6:	89aa                	mv	s3,a0
  if(peek(ps, es, "|")){
     7c8:	00001617          	auipc	a2,0x1
     7cc:	c1060613          	addi	a2,a2,-1008 # 13d8 <malloc+0x19c>
     7d0:	85a6                	mv	a1,s1
     7d2:	854a                	mv	a0,s2
     7d4:	00000097          	auipc	ra,0x0
     7d8:	d52080e7          	jalr	-686(ra) # 526 <peek>
     7dc:	e911                	bnez	a0,7f0 <parsepipe+0x48>
}
     7de:	854e                	mv	a0,s3
     7e0:	70a2                	ld	ra,40(sp)
     7e2:	7402                	ld	s0,32(sp)
     7e4:	64e2                	ld	s1,24(sp)
     7e6:	6942                	ld	s2,16(sp)
     7e8:	69a2                	ld	s3,8(sp)
     7ea:	6a02                	ld	s4,0(sp)
     7ec:	6145                	addi	sp,sp,48
     7ee:	8082                	ret
    gettoken(ps, es, 0, 0);
     7f0:	4681                	li	a3,0
     7f2:	4601                	li	a2,0
     7f4:	85a6                	mv	a1,s1
     7f6:	8552                	mv	a0,s4
     7f8:	00000097          	auipc	ra,0x0
     7fc:	be6080e7          	jalr	-1050(ra) # 3de <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     800:	85a6                	mv	a1,s1
     802:	8552                	mv	a0,s4
     804:	00000097          	auipc	ra,0x0
     808:	fa4080e7          	jalr	-92(ra) # 7a8 <parsepipe>
     80c:	85aa                	mv	a1,a0
     80e:	854e                	mv	a0,s3
     810:	00000097          	auipc	ra,0x0
     814:	b06080e7          	jalr	-1274(ra) # 316 <pipecmd>
     818:	89aa                	mv	s3,a0
  return cmd;
     81a:	b7d1                	j	7de <parsepipe+0x36>

000000000000081c <parseline>:
{
     81c:	7179                	addi	sp,sp,-48
     81e:	f406                	sd	ra,40(sp)
     820:	f022                	sd	s0,32(sp)
     822:	ec26                	sd	s1,24(sp)
     824:	e84a                	sd	s2,16(sp)
     826:	e44e                	sd	s3,8(sp)
     828:	e052                	sd	s4,0(sp)
     82a:	1800                	addi	s0,sp,48
     82c:	892a                	mv	s2,a0
     82e:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     830:	00000097          	auipc	ra,0x0
     834:	f78080e7          	jalr	-136(ra) # 7a8 <parsepipe>
     838:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     83a:	00001a17          	auipc	s4,0x1
     83e:	ba6a0a13          	addi	s4,s4,-1114 # 13e0 <malloc+0x1a4>
     842:	a839                	j	860 <parseline+0x44>
    gettoken(ps, es, 0, 0);
     844:	4681                	li	a3,0
     846:	4601                	li	a2,0
     848:	85ce                	mv	a1,s3
     84a:	854a                	mv	a0,s2
     84c:	00000097          	auipc	ra,0x0
     850:	b92080e7          	jalr	-1134(ra) # 3de <gettoken>
    cmd = backcmd(cmd);
     854:	8526                	mv	a0,s1
     856:	00000097          	auipc	ra,0x0
     85a:	b4c080e7          	jalr	-1204(ra) # 3a2 <backcmd>
     85e:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     860:	8652                	mv	a2,s4
     862:	85ce                	mv	a1,s3
     864:	854a                	mv	a0,s2
     866:	00000097          	auipc	ra,0x0
     86a:	cc0080e7          	jalr	-832(ra) # 526 <peek>
     86e:	f979                	bnez	a0,844 <parseline+0x28>
  if(peek(ps, es, ";")){
     870:	00001617          	auipc	a2,0x1
     874:	b7860613          	addi	a2,a2,-1160 # 13e8 <malloc+0x1ac>
     878:	85ce                	mv	a1,s3
     87a:	854a                	mv	a0,s2
     87c:	00000097          	auipc	ra,0x0
     880:	caa080e7          	jalr	-854(ra) # 526 <peek>
     884:	e911                	bnez	a0,898 <parseline+0x7c>
}
     886:	8526                	mv	a0,s1
     888:	70a2                	ld	ra,40(sp)
     88a:	7402                	ld	s0,32(sp)
     88c:	64e2                	ld	s1,24(sp)
     88e:	6942                	ld	s2,16(sp)
     890:	69a2                	ld	s3,8(sp)
     892:	6a02                	ld	s4,0(sp)
     894:	6145                	addi	sp,sp,48
     896:	8082                	ret
    gettoken(ps, es, 0, 0);
     898:	4681                	li	a3,0
     89a:	4601                	li	a2,0
     89c:	85ce                	mv	a1,s3
     89e:	854a                	mv	a0,s2
     8a0:	00000097          	auipc	ra,0x0
     8a4:	b3e080e7          	jalr	-1218(ra) # 3de <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8a8:	85ce                	mv	a1,s3
     8aa:	854a                	mv	a0,s2
     8ac:	00000097          	auipc	ra,0x0
     8b0:	f70080e7          	jalr	-144(ra) # 81c <parseline>
     8b4:	85aa                	mv	a1,a0
     8b6:	8526                	mv	a0,s1
     8b8:	00000097          	auipc	ra,0x0
     8bc:	aa4080e7          	jalr	-1372(ra) # 35c <listcmd>
     8c0:	84aa                	mv	s1,a0
  return cmd;
     8c2:	b7d1                	j	886 <parseline+0x6a>

00000000000008c4 <parseblock>:
{
     8c4:	7179                	addi	sp,sp,-48
     8c6:	f406                	sd	ra,40(sp)
     8c8:	f022                	sd	s0,32(sp)
     8ca:	ec26                	sd	s1,24(sp)
     8cc:	e84a                	sd	s2,16(sp)
     8ce:	e44e                	sd	s3,8(sp)
     8d0:	1800                	addi	s0,sp,48
     8d2:	84aa                	mv	s1,a0
     8d4:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8d6:	00001617          	auipc	a2,0x1
     8da:	ada60613          	addi	a2,a2,-1318 # 13b0 <malloc+0x174>
     8de:	00000097          	auipc	ra,0x0
     8e2:	c48080e7          	jalr	-952(ra) # 526 <peek>
     8e6:	c12d                	beqz	a0,948 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     8e8:	4681                	li	a3,0
     8ea:	4601                	li	a2,0
     8ec:	85ca                	mv	a1,s2
     8ee:	8526                	mv	a0,s1
     8f0:	00000097          	auipc	ra,0x0
     8f4:	aee080e7          	jalr	-1298(ra) # 3de <gettoken>
  cmd = parseline(ps, es);
     8f8:	85ca                	mv	a1,s2
     8fa:	8526                	mv	a0,s1
     8fc:	00000097          	auipc	ra,0x0
     900:	f20080e7          	jalr	-224(ra) # 81c <parseline>
     904:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     906:	00001617          	auipc	a2,0x1
     90a:	afa60613          	addi	a2,a2,-1286 # 1400 <malloc+0x1c4>
     90e:	85ca                	mv	a1,s2
     910:	8526                	mv	a0,s1
     912:	00000097          	auipc	ra,0x0
     916:	c14080e7          	jalr	-1004(ra) # 526 <peek>
     91a:	cd1d                	beqz	a0,958 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     91c:	4681                	li	a3,0
     91e:	4601                	li	a2,0
     920:	85ca                	mv	a1,s2
     922:	8526                	mv	a0,s1
     924:	00000097          	auipc	ra,0x0
     928:	aba080e7          	jalr	-1350(ra) # 3de <gettoken>
  cmd = parseredirs(cmd, ps, es);
     92c:	864a                	mv	a2,s2
     92e:	85a6                	mv	a1,s1
     930:	854e                	mv	a0,s3
     932:	00000097          	auipc	ra,0x0
     936:	c60080e7          	jalr	-928(ra) # 592 <parseredirs>
}
     93a:	70a2                	ld	ra,40(sp)
     93c:	7402                	ld	s0,32(sp)
     93e:	64e2                	ld	s1,24(sp)
     940:	6942                	ld	s2,16(sp)
     942:	69a2                	ld	s3,8(sp)
     944:	6145                	addi	sp,sp,48
     946:	8082                	ret
    panic("parseblock");
     948:	00001517          	auipc	a0,0x1
     94c:	aa850513          	addi	a0,a0,-1368 # 13f0 <malloc+0x1b4>
     950:	fffff097          	auipc	ra,0xfffff
     954:	704080e7          	jalr	1796(ra) # 54 <panic>
    panic("syntax - missing )");
     958:	00001517          	auipc	a0,0x1
     95c:	ab050513          	addi	a0,a0,-1360 # 1408 <malloc+0x1cc>
     960:	fffff097          	auipc	ra,0xfffff
     964:	6f4080e7          	jalr	1780(ra) # 54 <panic>

0000000000000968 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     968:	1101                	addi	sp,sp,-32
     96a:	ec06                	sd	ra,24(sp)
     96c:	e822                	sd	s0,16(sp)
     96e:	e426                	sd	s1,8(sp)
     970:	1000                	addi	s0,sp,32
     972:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     974:	c521                	beqz	a0,9bc <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     976:	4118                	lw	a4,0(a0)
     978:	4795                	li	a5,5
     97a:	04e7e163          	bltu	a5,a4,9bc <nulterminate+0x54>
     97e:	00056783          	lwu	a5,0(a0)
     982:	078a                	slli	a5,a5,0x2
     984:	00001717          	auipc	a4,0x1
     988:	ae470713          	addi	a4,a4,-1308 # 1468 <malloc+0x22c>
     98c:	97ba                	add	a5,a5,a4
     98e:	439c                	lw	a5,0(a5)
     990:	97ba                	add	a5,a5,a4
     992:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     994:	651c                	ld	a5,8(a0)
     996:	c39d                	beqz	a5,9bc <nulterminate+0x54>
     998:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     99c:	67b8                	ld	a4,72(a5)
     99e:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     9a2:	07a1                	addi	a5,a5,8
     9a4:	ff87b703          	ld	a4,-8(a5)
     9a8:	fb75                	bnez	a4,99c <nulterminate+0x34>
     9aa:	a809                	j	9bc <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     9ac:	6508                	ld	a0,8(a0)
     9ae:	00000097          	auipc	ra,0x0
     9b2:	fba080e7          	jalr	-70(ra) # 968 <nulterminate>
    *rcmd->efile = 0;
     9b6:	6c9c                	ld	a5,24(s1)
     9b8:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     9bc:	8526                	mv	a0,s1
     9be:	60e2                	ld	ra,24(sp)
     9c0:	6442                	ld	s0,16(sp)
     9c2:	64a2                	ld	s1,8(sp)
     9c4:	6105                	addi	sp,sp,32
     9c6:	8082                	ret
    nulterminate(pcmd->left);
     9c8:	6508                	ld	a0,8(a0)
     9ca:	00000097          	auipc	ra,0x0
     9ce:	f9e080e7          	jalr	-98(ra) # 968 <nulterminate>
    nulterminate(pcmd->right);
     9d2:	6888                	ld	a0,16(s1)
     9d4:	00000097          	auipc	ra,0x0
     9d8:	f94080e7          	jalr	-108(ra) # 968 <nulterminate>
    break;
     9dc:	b7c5                	j	9bc <nulterminate+0x54>
    nulterminate(lcmd->left);
     9de:	6508                	ld	a0,8(a0)
     9e0:	00000097          	auipc	ra,0x0
     9e4:	f88080e7          	jalr	-120(ra) # 968 <nulterminate>
    nulterminate(lcmd->right);
     9e8:	6888                	ld	a0,16(s1)
     9ea:	00000097          	auipc	ra,0x0
     9ee:	f7e080e7          	jalr	-130(ra) # 968 <nulterminate>
    break;
     9f2:	b7e9                	j	9bc <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     9f4:	6508                	ld	a0,8(a0)
     9f6:	00000097          	auipc	ra,0x0
     9fa:	f72080e7          	jalr	-142(ra) # 968 <nulterminate>
    break;
     9fe:	bf7d                	j	9bc <nulterminate+0x54>

0000000000000a00 <parsecmd>:
{
     a00:	7139                	addi	sp,sp,-64
     a02:	fc06                	sd	ra,56(sp)
     a04:	f822                	sd	s0,48(sp)
     a06:	f426                	sd	s1,40(sp)
     a08:	f04a                	sd	s2,32(sp)
     a0a:	ec4e                	sd	s3,24(sp)
     a0c:	0080                	addi	s0,sp,64
     a0e:	fca43423          	sd	a0,-56(s0)
  es = s + strlen(s);
     a12:	84aa                	mv	s1,a0
     a14:	00000097          	auipc	ra,0x0
     a18:	1c8080e7          	jalr	456(ra) # bdc <strlen>
     a1c:	1502                	slli	a0,a0,0x20
     a1e:	9101                	srli	a0,a0,0x20
     a20:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     a22:	fc840913          	addi	s2,s0,-56
     a26:	85a6                	mv	a1,s1
     a28:	854a                	mv	a0,s2
     a2a:	00000097          	auipc	ra,0x0
     a2e:	df2080e7          	jalr	-526(ra) # 81c <parseline>
     a32:	89aa                	mv	s3,a0
  peek(&s, es, "");
     a34:	00001617          	auipc	a2,0x1
     a38:	90c60613          	addi	a2,a2,-1780 # 1340 <malloc+0x104>
     a3c:	85a6                	mv	a1,s1
     a3e:	854a                	mv	a0,s2
     a40:	00000097          	auipc	ra,0x0
     a44:	ae6080e7          	jalr	-1306(ra) # 526 <peek>
  if(s != es){
     a48:	fc843603          	ld	a2,-56(s0)
     a4c:	00961f63          	bne	a2,s1,a6a <parsecmd+0x6a>
  nulterminate(cmd);
     a50:	854e                	mv	a0,s3
     a52:	00000097          	auipc	ra,0x0
     a56:	f16080e7          	jalr	-234(ra) # 968 <nulterminate>
}
     a5a:	854e                	mv	a0,s3
     a5c:	70e2                	ld	ra,56(sp)
     a5e:	7442                	ld	s0,48(sp)
     a60:	74a2                	ld	s1,40(sp)
     a62:	7902                	ld	s2,32(sp)
     a64:	69e2                	ld	s3,24(sp)
     a66:	6121                	addi	sp,sp,64
     a68:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a6a:	00001597          	auipc	a1,0x1
     a6e:	9b658593          	addi	a1,a1,-1610 # 1420 <malloc+0x1e4>
     a72:	4509                	li	a0,2
     a74:	00000097          	auipc	ra,0x0
     a78:	6de080e7          	jalr	1758(ra) # 1152 <fprintf>
    panic("syntax");
     a7c:	00001517          	auipc	a0,0x1
     a80:	93c50513          	addi	a0,a0,-1732 # 13b8 <malloc+0x17c>
     a84:	fffff097          	auipc	ra,0xfffff
     a88:	5d0080e7          	jalr	1488(ra) # 54 <panic>

0000000000000a8c <main>:
{
     a8c:	7179                	addi	sp,sp,-48
     a8e:	f406                	sd	ra,40(sp)
     a90:	f022                	sd	s0,32(sp)
     a92:	ec26                	sd	s1,24(sp)
     a94:	e84a                	sd	s2,16(sp)
     a96:	e44e                	sd	s3,8(sp)
     a98:	e052                	sd	s4,0(sp)
     a9a:	1800                	addi	s0,sp,48
  while((fd = open("console", O_RDWR)) >= 0){
     a9c:	4489                	li	s1,2
     a9e:	00001917          	auipc	s2,0x1
     aa2:	99290913          	addi	s2,s2,-1646 # 1430 <malloc+0x1f4>
     aa6:	85a6                	mv	a1,s1
     aa8:	854a                	mv	a0,s2
     aaa:	00000097          	auipc	ra,0x0
     aae:	3b0080e7          	jalr	944(ra) # e5a <open>
     ab2:	00054863          	bltz	a0,ac2 <main+0x36>
    if(fd >= 3){
     ab6:	fea4d8e3          	bge	s1,a0,aa6 <main+0x1a>
      close(fd);
     aba:	00000097          	auipc	ra,0x0
     abe:	388080e7          	jalr	904(ra) # e42 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ac2:	06400913          	li	s2,100
     ac6:	00001497          	auipc	s1,0x1
     aca:	23248493          	addi	s1,s1,562 # 1cf8 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ace:	06300993          	li	s3,99
     ad2:	02000a13          	li	s4,32
     ad6:	a819                	j	aec <main+0x60>
    if(fork1() == 0)
     ad8:	fffff097          	auipc	ra,0xfffff
     adc:	5a2080e7          	jalr	1442(ra) # 7a <fork1>
     ae0:	c549                	beqz	a0,b6a <main+0xde>
    wait(0);
     ae2:	4501                	li	a0,0
     ae4:	00000097          	auipc	ra,0x0
     ae8:	33e080e7          	jalr	830(ra) # e22 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     aec:	85ca                	mv	a1,s2
     aee:	8526                	mv	a0,s1
     af0:	fffff097          	auipc	ra,0xfffff
     af4:	510080e7          	jalr	1296(ra) # 0 <getcmd>
     af8:	08054563          	bltz	a0,b82 <main+0xf6>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     afc:	0004c783          	lbu	a5,0(s1)
     b00:	fd379ce3          	bne	a5,s3,ad8 <main+0x4c>
     b04:	0014c783          	lbu	a5,1(s1)
     b08:	fd2798e3          	bne	a5,s2,ad8 <main+0x4c>
     b0c:	0024c783          	lbu	a5,2(s1)
     b10:	fd4794e3          	bne	a5,s4,ad8 <main+0x4c>
      buf[strlen(buf)-1] = 0;  // chop \n
     b14:	00001517          	auipc	a0,0x1
     b18:	1e450513          	addi	a0,a0,484 # 1cf8 <buf.0>
     b1c:	00000097          	auipc	ra,0x0
     b20:	0c0080e7          	jalr	192(ra) # bdc <strlen>
     b24:	fff5079b          	addiw	a5,a0,-1
     b28:	1782                	slli	a5,a5,0x20
     b2a:	9381                	srli	a5,a5,0x20
     b2c:	00001717          	auipc	a4,0x1
     b30:	1cc70713          	addi	a4,a4,460 # 1cf8 <buf.0>
     b34:	97ba                	add	a5,a5,a4
     b36:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     b3a:	00001517          	auipc	a0,0x1
     b3e:	1c150513          	addi	a0,a0,449 # 1cfb <buf.0+0x3>
     b42:	00000097          	auipc	ra,0x0
     b46:	348080e7          	jalr	840(ra) # e8a <chdir>
     b4a:	fa0551e3          	bgez	a0,aec <main+0x60>
        fprintf(2, "cannot cd %s\n", buf+3);
     b4e:	00001617          	auipc	a2,0x1
     b52:	1ad60613          	addi	a2,a2,429 # 1cfb <buf.0+0x3>
     b56:	00001597          	auipc	a1,0x1
     b5a:	8e258593          	addi	a1,a1,-1822 # 1438 <malloc+0x1fc>
     b5e:	4509                	li	a0,2
     b60:	00000097          	auipc	ra,0x0
     b64:	5f2080e7          	jalr	1522(ra) # 1152 <fprintf>
     b68:	b751                	j	aec <main+0x60>
      runcmd(parsecmd(buf));
     b6a:	00001517          	auipc	a0,0x1
     b6e:	18e50513          	addi	a0,a0,398 # 1cf8 <buf.0>
     b72:	00000097          	auipc	ra,0x0
     b76:	e8e080e7          	jalr	-370(ra) # a00 <parsecmd>
     b7a:	fffff097          	auipc	ra,0xfffff
     b7e:	52e080e7          	jalr	1326(ra) # a8 <runcmd>
  exit(0);
     b82:	4501                	li	a0,0
     b84:	00000097          	auipc	ra,0x0
     b88:	296080e7          	jalr	662(ra) # e1a <exit>

0000000000000b8c <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     b8c:	1141                	addi	sp,sp,-16
     b8e:	e406                	sd	ra,8(sp)
     b90:	e022                	sd	s0,0(sp)
     b92:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b94:	87aa                	mv	a5,a0
     b96:	0585                	addi	a1,a1,1
     b98:	0785                	addi	a5,a5,1
     b9a:	fff5c703          	lbu	a4,-1(a1)
     b9e:	fee78fa3          	sb	a4,-1(a5)
     ba2:	fb75                	bnez	a4,b96 <strcpy+0xa>
    ;
  return os;
}
     ba4:	60a2                	ld	ra,8(sp)
     ba6:	6402                	ld	s0,0(sp)
     ba8:	0141                	addi	sp,sp,16
     baa:	8082                	ret

0000000000000bac <strcmp>:

int
strcmp(const char *p, const char *q)
{
     bac:	1141                	addi	sp,sp,-16
     bae:	e406                	sd	ra,8(sp)
     bb0:	e022                	sd	s0,0(sp)
     bb2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     bb4:	00054783          	lbu	a5,0(a0)
     bb8:	cb91                	beqz	a5,bcc <strcmp+0x20>
     bba:	0005c703          	lbu	a4,0(a1)
     bbe:	00f71763          	bne	a4,a5,bcc <strcmp+0x20>
    p++, q++;
     bc2:	0505                	addi	a0,a0,1
     bc4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     bc6:	00054783          	lbu	a5,0(a0)
     bca:	fbe5                	bnez	a5,bba <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     bcc:	0005c503          	lbu	a0,0(a1)
}
     bd0:	40a7853b          	subw	a0,a5,a0
     bd4:	60a2                	ld	ra,8(sp)
     bd6:	6402                	ld	s0,0(sp)
     bd8:	0141                	addi	sp,sp,16
     bda:	8082                	ret

0000000000000bdc <strlen>:

uint
strlen(const char *s)
{
     bdc:	1141                	addi	sp,sp,-16
     bde:	e406                	sd	ra,8(sp)
     be0:	e022                	sd	s0,0(sp)
     be2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     be4:	00054783          	lbu	a5,0(a0)
     be8:	cf91                	beqz	a5,c04 <strlen+0x28>
     bea:	00150793          	addi	a5,a0,1
     bee:	86be                	mv	a3,a5
     bf0:	0785                	addi	a5,a5,1
     bf2:	fff7c703          	lbu	a4,-1(a5)
     bf6:	ff65                	bnez	a4,bee <strlen+0x12>
     bf8:	40a6853b          	subw	a0,a3,a0
    ;
  return n;
}
     bfc:	60a2                	ld	ra,8(sp)
     bfe:	6402                	ld	s0,0(sp)
     c00:	0141                	addi	sp,sp,16
     c02:	8082                	ret
  for(n = 0; s[n]; n++)
     c04:	4501                	li	a0,0
     c06:	bfdd                	j	bfc <strlen+0x20>

0000000000000c08 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c08:	1141                	addi	sp,sp,-16
     c0a:	e406                	sd	ra,8(sp)
     c0c:	e022                	sd	s0,0(sp)
     c0e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     c10:	ca19                	beqz	a2,c26 <memset+0x1e>
     c12:	87aa                	mv	a5,a0
     c14:	1602                	slli	a2,a2,0x20
     c16:	9201                	srli	a2,a2,0x20
     c18:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     c1c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     c20:	0785                	addi	a5,a5,1
     c22:	fee79de3          	bne	a5,a4,c1c <memset+0x14>
  }
  return dst;
}
     c26:	60a2                	ld	ra,8(sp)
     c28:	6402                	ld	s0,0(sp)
     c2a:	0141                	addi	sp,sp,16
     c2c:	8082                	ret

0000000000000c2e <strchr>:

char*
strchr(const char *s, char c)
{
     c2e:	1141                	addi	sp,sp,-16
     c30:	e406                	sd	ra,8(sp)
     c32:	e022                	sd	s0,0(sp)
     c34:	0800                	addi	s0,sp,16
  for(; *s; s++)
     c36:	00054783          	lbu	a5,0(a0)
     c3a:	cf81                	beqz	a5,c52 <strchr+0x24>
    if(*s == c)
     c3c:	00f58763          	beq	a1,a5,c4a <strchr+0x1c>
  for(; *s; s++)
     c40:	0505                	addi	a0,a0,1
     c42:	00054783          	lbu	a5,0(a0)
     c46:	fbfd                	bnez	a5,c3c <strchr+0xe>
      return (char*)s;
  return 0;
     c48:	4501                	li	a0,0
}
     c4a:	60a2                	ld	ra,8(sp)
     c4c:	6402                	ld	s0,0(sp)
     c4e:	0141                	addi	sp,sp,16
     c50:	8082                	ret
  return 0;
     c52:	4501                	li	a0,0
     c54:	bfdd                	j	c4a <strchr+0x1c>

0000000000000c56 <gets>:

char*
gets(char *buf, int max)
{
     c56:	711d                	addi	sp,sp,-96
     c58:	ec86                	sd	ra,88(sp)
     c5a:	e8a2                	sd	s0,80(sp)
     c5c:	e4a6                	sd	s1,72(sp)
     c5e:	e0ca                	sd	s2,64(sp)
     c60:	fc4e                	sd	s3,56(sp)
     c62:	f852                	sd	s4,48(sp)
     c64:	f456                	sd	s5,40(sp)
     c66:	f05a                	sd	s6,32(sp)
     c68:	ec5e                	sd	s7,24(sp)
     c6a:	e862                	sd	s8,16(sp)
     c6c:	1080                	addi	s0,sp,96
     c6e:	8baa                	mv	s7,a0
     c70:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c72:	892a                	mv	s2,a0
     c74:	4481                	li	s1,0
    cc = read(0, &c, 1);
     c76:	faf40b13          	addi	s6,s0,-81
     c7a:	4a85                	li	s5,1
  for(i=0; i+1 < max; ){
     c7c:	8c26                	mv	s8,s1
     c7e:	0014899b          	addiw	s3,s1,1
     c82:	84ce                	mv	s1,s3
     c84:	0349d663          	bge	s3,s4,cb0 <gets+0x5a>
    cc = read(0, &c, 1);
     c88:	8656                	mv	a2,s5
     c8a:	85da                	mv	a1,s6
     c8c:	4501                	li	a0,0
     c8e:	00000097          	auipc	ra,0x0
     c92:	1a4080e7          	jalr	420(ra) # e32 <read>
    if(cc < 1)
     c96:	00a05d63          	blez	a0,cb0 <gets+0x5a>
      break;
    buf[i++] = c;
     c9a:	faf44783          	lbu	a5,-81(s0)
     c9e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     ca2:	0905                	addi	s2,s2,1
     ca4:	ff678713          	addi	a4,a5,-10
     ca8:	c319                	beqz	a4,cae <gets+0x58>
     caa:	17cd                	addi	a5,a5,-13
     cac:	fbe1                	bnez	a5,c7c <gets+0x26>
    buf[i++] = c;
     cae:	8c4e                	mv	s8,s3
      break;
  }
  buf[i] = '\0';
     cb0:	9c5e                	add	s8,s8,s7
     cb2:	000c0023          	sb	zero,0(s8)
  return buf;
}
     cb6:	855e                	mv	a0,s7
     cb8:	60e6                	ld	ra,88(sp)
     cba:	6446                	ld	s0,80(sp)
     cbc:	64a6                	ld	s1,72(sp)
     cbe:	6906                	ld	s2,64(sp)
     cc0:	79e2                	ld	s3,56(sp)
     cc2:	7a42                	ld	s4,48(sp)
     cc4:	7aa2                	ld	s5,40(sp)
     cc6:	7b02                	ld	s6,32(sp)
     cc8:	6be2                	ld	s7,24(sp)
     cca:	6c42                	ld	s8,16(sp)
     ccc:	6125                	addi	sp,sp,96
     cce:	8082                	ret

0000000000000cd0 <stat>:

int
stat(const char *n, struct stat *st)
{
     cd0:	1101                	addi	sp,sp,-32
     cd2:	ec06                	sd	ra,24(sp)
     cd4:	e822                	sd	s0,16(sp)
     cd6:	e04a                	sd	s2,0(sp)
     cd8:	1000                	addi	s0,sp,32
     cda:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cdc:	4581                	li	a1,0
     cde:	00000097          	auipc	ra,0x0
     ce2:	17c080e7          	jalr	380(ra) # e5a <open>
  if(fd < 0)
     ce6:	02054663          	bltz	a0,d12 <stat+0x42>
     cea:	e426                	sd	s1,8(sp)
     cec:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     cee:	85ca                	mv	a1,s2
     cf0:	00000097          	auipc	ra,0x0
     cf4:	182080e7          	jalr	386(ra) # e72 <fstat>
     cf8:	892a                	mv	s2,a0
  close(fd);
     cfa:	8526                	mv	a0,s1
     cfc:	00000097          	auipc	ra,0x0
     d00:	146080e7          	jalr	326(ra) # e42 <close>
  return r;
     d04:	64a2                	ld	s1,8(sp)
}
     d06:	854a                	mv	a0,s2
     d08:	60e2                	ld	ra,24(sp)
     d0a:	6442                	ld	s0,16(sp)
     d0c:	6902                	ld	s2,0(sp)
     d0e:	6105                	addi	sp,sp,32
     d10:	8082                	ret
    return -1;
     d12:	57fd                	li	a5,-1
     d14:	893e                	mv	s2,a5
     d16:	bfc5                	j	d06 <stat+0x36>

0000000000000d18 <atoi>:

int
atoi(const char *s)
{
     d18:	1141                	addi	sp,sp,-16
     d1a:	e406                	sd	ra,8(sp)
     d1c:	e022                	sd	s0,0(sp)
     d1e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     d20:	00054683          	lbu	a3,0(a0)
     d24:	fd06879b          	addiw	a5,a3,-48
     d28:	0ff7f793          	zext.b	a5,a5
     d2c:	4625                	li	a2,9
     d2e:	02f66963          	bltu	a2,a5,d60 <atoi+0x48>
     d32:	872a                	mv	a4,a0
  n = 0;
     d34:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     d36:	0705                	addi	a4,a4,1
     d38:	0025179b          	slliw	a5,a0,0x2
     d3c:	9fa9                	addw	a5,a5,a0
     d3e:	0017979b          	slliw	a5,a5,0x1
     d42:	9fb5                	addw	a5,a5,a3
     d44:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d48:	00074683          	lbu	a3,0(a4)
     d4c:	fd06879b          	addiw	a5,a3,-48
     d50:	0ff7f793          	zext.b	a5,a5
     d54:	fef671e3          	bgeu	a2,a5,d36 <atoi+0x1e>
  return n;
}
     d58:	60a2                	ld	ra,8(sp)
     d5a:	6402                	ld	s0,0(sp)
     d5c:	0141                	addi	sp,sp,16
     d5e:	8082                	ret
  n = 0;
     d60:	4501                	li	a0,0
     d62:	bfdd                	j	d58 <atoi+0x40>

0000000000000d64 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d64:	1141                	addi	sp,sp,-16
     d66:	e406                	sd	ra,8(sp)
     d68:	e022                	sd	s0,0(sp)
     d6a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d6c:	02b57563          	bgeu	a0,a1,d96 <memmove+0x32>
    while(n-- > 0)
     d70:	00c05f63          	blez	a2,d8e <memmove+0x2a>
     d74:	1602                	slli	a2,a2,0x20
     d76:	9201                	srli	a2,a2,0x20
     d78:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     d7c:	872a                	mv	a4,a0
      *dst++ = *src++;
     d7e:	0585                	addi	a1,a1,1
     d80:	0705                	addi	a4,a4,1
     d82:	fff5c683          	lbu	a3,-1(a1)
     d86:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     d8a:	fee79ae3          	bne	a5,a4,d7e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     d8e:	60a2                	ld	ra,8(sp)
     d90:	6402                	ld	s0,0(sp)
     d92:	0141                	addi	sp,sp,16
     d94:	8082                	ret
    while(n-- > 0)
     d96:	fec05ce3          	blez	a2,d8e <memmove+0x2a>
    dst += n;
     d9a:	00c50733          	add	a4,a0,a2
    src += n;
     d9e:	95b2                	add	a1,a1,a2
     da0:	fff6079b          	addiw	a5,a2,-1
     da4:	1782                	slli	a5,a5,0x20
     da6:	9381                	srli	a5,a5,0x20
     da8:	fff7c793          	not	a5,a5
     dac:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     dae:	15fd                	addi	a1,a1,-1
     db0:	177d                	addi	a4,a4,-1
     db2:	0005c683          	lbu	a3,0(a1)
     db6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     dba:	fef71ae3          	bne	a4,a5,dae <memmove+0x4a>
     dbe:	bfc1                	j	d8e <memmove+0x2a>

0000000000000dc0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     dc0:	1141                	addi	sp,sp,-16
     dc2:	e406                	sd	ra,8(sp)
     dc4:	e022                	sd	s0,0(sp)
     dc6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     dc8:	c61d                	beqz	a2,df6 <memcmp+0x36>
     dca:	1602                	slli	a2,a2,0x20
     dcc:	9201                	srli	a2,a2,0x20
     dce:	00c506b3          	add	a3,a0,a2
    if (*p1 != *p2) {
     dd2:	00054783          	lbu	a5,0(a0)
     dd6:	0005c703          	lbu	a4,0(a1)
     dda:	00e79863          	bne	a5,a4,dea <memcmp+0x2a>
      return *p1 - *p2;
    }
    p1++;
     dde:	0505                	addi	a0,a0,1
    p2++;
     de0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     de2:	fed518e3          	bne	a0,a3,dd2 <memcmp+0x12>
  }
  return 0;
     de6:	4501                	li	a0,0
     de8:	a019                	j	dee <memcmp+0x2e>
      return *p1 - *p2;
     dea:	40e7853b          	subw	a0,a5,a4
}
     dee:	60a2                	ld	ra,8(sp)
     df0:	6402                	ld	s0,0(sp)
     df2:	0141                	addi	sp,sp,16
     df4:	8082                	ret
  return 0;
     df6:	4501                	li	a0,0
     df8:	bfdd                	j	dee <memcmp+0x2e>

0000000000000dfa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     dfa:	1141                	addi	sp,sp,-16
     dfc:	e406                	sd	ra,8(sp)
     dfe:	e022                	sd	s0,0(sp)
     e00:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     e02:	00000097          	auipc	ra,0x0
     e06:	f62080e7          	jalr	-158(ra) # d64 <memmove>
}
     e0a:	60a2                	ld	ra,8(sp)
     e0c:	6402                	ld	s0,0(sp)
     e0e:	0141                	addi	sp,sp,16
     e10:	8082                	ret

0000000000000e12 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     e12:	4885                	li	a7,1
 ecall
     e14:	00000073          	ecall
 ret
     e18:	8082                	ret

0000000000000e1a <exit>:
.global exit
exit:
 li a7, SYS_exit
     e1a:	4889                	li	a7,2
 ecall
     e1c:	00000073          	ecall
 ret
     e20:	8082                	ret

0000000000000e22 <wait>:
.global wait
wait:
 li a7, SYS_wait
     e22:	488d                	li	a7,3
 ecall
     e24:	00000073          	ecall
 ret
     e28:	8082                	ret

0000000000000e2a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     e2a:	4891                	li	a7,4
 ecall
     e2c:	00000073          	ecall
 ret
     e30:	8082                	ret

0000000000000e32 <read>:
.global read
read:
 li a7, SYS_read
     e32:	4895                	li	a7,5
 ecall
     e34:	00000073          	ecall
 ret
     e38:	8082                	ret

0000000000000e3a <write>:
.global write
write:
 li a7, SYS_write
     e3a:	48c1                	li	a7,16
 ecall
     e3c:	00000073          	ecall
 ret
     e40:	8082                	ret

0000000000000e42 <close>:
.global close
close:
 li a7, SYS_close
     e42:	48d5                	li	a7,21
 ecall
     e44:	00000073          	ecall
 ret
     e48:	8082                	ret

0000000000000e4a <kill>:
.global kill
kill:
 li a7, SYS_kill
     e4a:	4899                	li	a7,6
 ecall
     e4c:	00000073          	ecall
 ret
     e50:	8082                	ret

0000000000000e52 <exec>:
.global exec
exec:
 li a7, SYS_exec
     e52:	489d                	li	a7,7
 ecall
     e54:	00000073          	ecall
 ret
     e58:	8082                	ret

0000000000000e5a <open>:
.global open
open:
 li a7, SYS_open
     e5a:	48bd                	li	a7,15
 ecall
     e5c:	00000073          	ecall
 ret
     e60:	8082                	ret

0000000000000e62 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e62:	48c5                	li	a7,17
 ecall
     e64:	00000073          	ecall
 ret
     e68:	8082                	ret

0000000000000e6a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e6a:	48c9                	li	a7,18
 ecall
     e6c:	00000073          	ecall
 ret
     e70:	8082                	ret

0000000000000e72 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e72:	48a1                	li	a7,8
 ecall
     e74:	00000073          	ecall
 ret
     e78:	8082                	ret

0000000000000e7a <link>:
.global link
link:
 li a7, SYS_link
     e7a:	48cd                	li	a7,19
 ecall
     e7c:	00000073          	ecall
 ret
     e80:	8082                	ret

0000000000000e82 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e82:	48d1                	li	a7,20
 ecall
     e84:	00000073          	ecall
 ret
     e88:	8082                	ret

0000000000000e8a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e8a:	48a5                	li	a7,9
 ecall
     e8c:	00000073          	ecall
 ret
     e90:	8082                	ret

0000000000000e92 <dup>:
.global dup
dup:
 li a7, SYS_dup
     e92:	48a9                	li	a7,10
 ecall
     e94:	00000073          	ecall
 ret
     e98:	8082                	ret

0000000000000e9a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e9a:	48ad                	li	a7,11
 ecall
     e9c:	00000073          	ecall
 ret
     ea0:	8082                	ret

0000000000000ea2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     ea2:	48b1                	li	a7,12
 ecall
     ea4:	00000073          	ecall
 ret
     ea8:	8082                	ret

0000000000000eaa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     eaa:	48b5                	li	a7,13
 ecall
     eac:	00000073          	ecall
 ret
     eb0:	8082                	ret

0000000000000eb2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     eb2:	48b9                	li	a7,14
 ecall
     eb4:	00000073          	ecall
 ret
     eb8:	8082                	ret

0000000000000eba <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     eba:	1101                	addi	sp,sp,-32
     ebc:	ec06                	sd	ra,24(sp)
     ebe:	e822                	sd	s0,16(sp)
     ec0:	1000                	addi	s0,sp,32
     ec2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     ec6:	4605                	li	a2,1
     ec8:	fef40593          	addi	a1,s0,-17
     ecc:	00000097          	auipc	ra,0x0
     ed0:	f6e080e7          	jalr	-146(ra) # e3a <write>
}
     ed4:	60e2                	ld	ra,24(sp)
     ed6:	6442                	ld	s0,16(sp)
     ed8:	6105                	addi	sp,sp,32
     eda:	8082                	ret

0000000000000edc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     edc:	7139                	addi	sp,sp,-64
     ede:	fc06                	sd	ra,56(sp)
     ee0:	f822                	sd	s0,48(sp)
     ee2:	f04a                	sd	s2,32(sp)
     ee4:	ec4e                	sd	s3,24(sp)
     ee6:	0080                	addi	s0,sp,64
     ee8:	892a                	mv	s2,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     eea:	cad9                	beqz	a3,f80 <printint+0xa4>
     eec:	01f5d79b          	srliw	a5,a1,0x1f
     ef0:	cbc1                	beqz	a5,f80 <printint+0xa4>
    neg = 1;
    x = -xx;
     ef2:	40b005bb          	negw	a1,a1
    neg = 1;
     ef6:	4305                	li	t1,1
  } else {
    x = xx;
  }

  i = 0;
     ef8:	fc040993          	addi	s3,s0,-64
  neg = 0;
     efc:	86ce                	mv	a3,s3
  i = 0;
     efe:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     f00:	00000817          	auipc	a6,0x0
     f04:	5d880813          	addi	a6,a6,1496 # 14d8 <digits>
     f08:	88ba                	mv	a7,a4
     f0a:	0017051b          	addiw	a0,a4,1
     f0e:	872a                	mv	a4,a0
     f10:	02c5f7bb          	remuw	a5,a1,a2
     f14:	1782                	slli	a5,a5,0x20
     f16:	9381                	srli	a5,a5,0x20
     f18:	97c2                	add	a5,a5,a6
     f1a:	0007c783          	lbu	a5,0(a5)
     f1e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     f22:	87ae                	mv	a5,a1
     f24:	02c5d5bb          	divuw	a1,a1,a2
     f28:	0685                	addi	a3,a3,1
     f2a:	fcc7ffe3          	bgeu	a5,a2,f08 <printint+0x2c>
  if(neg)
     f2e:	00030c63          	beqz	t1,f46 <printint+0x6a>
    buf[i++] = '-';
     f32:	fd050793          	addi	a5,a0,-48
     f36:	00878533          	add	a0,a5,s0
     f3a:	02d00793          	li	a5,45
     f3e:	fef50823          	sb	a5,-16(a0)
     f42:	0028871b          	addiw	a4,a7,2

  while(--i >= 0)
     f46:	02e05763          	blez	a4,f74 <printint+0x98>
     f4a:	f426                	sd	s1,40(sp)
     f4c:	377d                	addiw	a4,a4,-1
     f4e:	00e984b3          	add	s1,s3,a4
     f52:	19fd                	addi	s3,s3,-1
     f54:	99ba                	add	s3,s3,a4
     f56:	1702                	slli	a4,a4,0x20
     f58:	9301                	srli	a4,a4,0x20
     f5a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     f5e:	0004c583          	lbu	a1,0(s1)
     f62:	854a                	mv	a0,s2
     f64:	00000097          	auipc	ra,0x0
     f68:	f56080e7          	jalr	-170(ra) # eba <putc>
  while(--i >= 0)
     f6c:	14fd                	addi	s1,s1,-1
     f6e:	ff3498e3          	bne	s1,s3,f5e <printint+0x82>
     f72:	74a2                	ld	s1,40(sp)
}
     f74:	70e2                	ld	ra,56(sp)
     f76:	7442                	ld	s0,48(sp)
     f78:	7902                	ld	s2,32(sp)
     f7a:	69e2                	ld	s3,24(sp)
     f7c:	6121                	addi	sp,sp,64
     f7e:	8082                	ret
  neg = 0;
     f80:	4301                	li	t1,0
     f82:	bf9d                	j	ef8 <printint+0x1c>

0000000000000f84 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f84:	715d                	addi	sp,sp,-80
     f86:	e486                	sd	ra,72(sp)
     f88:	e0a2                	sd	s0,64(sp)
     f8a:	f84a                	sd	s2,48(sp)
     f8c:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f8e:	0005c903          	lbu	s2,0(a1)
     f92:	1a090b63          	beqz	s2,1148 <vprintf+0x1c4>
     f96:	fc26                	sd	s1,56(sp)
     f98:	f44e                	sd	s3,40(sp)
     f9a:	f052                	sd	s4,32(sp)
     f9c:	ec56                	sd	s5,24(sp)
     f9e:	e85a                	sd	s6,16(sp)
     fa0:	e45e                	sd	s7,8(sp)
     fa2:	8aaa                	mv	s5,a0
     fa4:	8bb2                	mv	s7,a2
     fa6:	00158493          	addi	s1,a1,1
  state = 0;
     faa:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     fac:	02500a13          	li	s4,37
     fb0:	4b55                	li	s6,21
     fb2:	a839                	j	fd0 <vprintf+0x4c>
        putc(fd, c);
     fb4:	85ca                	mv	a1,s2
     fb6:	8556                	mv	a0,s5
     fb8:	00000097          	auipc	ra,0x0
     fbc:	f02080e7          	jalr	-254(ra) # eba <putc>
     fc0:	a019                	j	fc6 <vprintf+0x42>
    } else if(state == '%'){
     fc2:	01498d63          	beq	s3,s4,fdc <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
     fc6:	0485                	addi	s1,s1,1
     fc8:	fff4c903          	lbu	s2,-1(s1)
     fcc:	16090863          	beqz	s2,113c <vprintf+0x1b8>
    if(state == 0){
     fd0:	fe0999e3          	bnez	s3,fc2 <vprintf+0x3e>
      if(c == '%'){
     fd4:	ff4910e3          	bne	s2,s4,fb4 <vprintf+0x30>
        state = '%';
     fd8:	89d2                	mv	s3,s4
     fda:	b7f5                	j	fc6 <vprintf+0x42>
      if(c == 'd'){
     fdc:	13490563          	beq	s2,s4,1106 <vprintf+0x182>
     fe0:	f9d9079b          	addiw	a5,s2,-99
     fe4:	0ff7f793          	zext.b	a5,a5
     fe8:	12fb6863          	bltu	s6,a5,1118 <vprintf+0x194>
     fec:	f9d9079b          	addiw	a5,s2,-99
     ff0:	0ff7f713          	zext.b	a4,a5
     ff4:	12eb6263          	bltu	s6,a4,1118 <vprintf+0x194>
     ff8:	00271793          	slli	a5,a4,0x2
     ffc:	00000717          	auipc	a4,0x0
    1000:	48470713          	addi	a4,a4,1156 # 1480 <malloc+0x244>
    1004:	97ba                	add	a5,a5,a4
    1006:	439c                	lw	a5,0(a5)
    1008:	97ba                	add	a5,a5,a4
    100a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    100c:	008b8913          	addi	s2,s7,8
    1010:	4685                	li	a3,1
    1012:	4629                	li	a2,10
    1014:	000ba583          	lw	a1,0(s7)
    1018:	8556                	mv	a0,s5
    101a:	00000097          	auipc	ra,0x0
    101e:	ec2080e7          	jalr	-318(ra) # edc <printint>
    1022:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1024:	4981                	li	s3,0
    1026:	b745                	j	fc6 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1028:	008b8913          	addi	s2,s7,8
    102c:	4681                	li	a3,0
    102e:	4629                	li	a2,10
    1030:	000ba583          	lw	a1,0(s7)
    1034:	8556                	mv	a0,s5
    1036:	00000097          	auipc	ra,0x0
    103a:	ea6080e7          	jalr	-346(ra) # edc <printint>
    103e:	8bca                	mv	s7,s2
      state = 0;
    1040:	4981                	li	s3,0
    1042:	b751                	j	fc6 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
    1044:	008b8913          	addi	s2,s7,8
    1048:	4681                	li	a3,0
    104a:	4641                	li	a2,16
    104c:	000ba583          	lw	a1,0(s7)
    1050:	8556                	mv	a0,s5
    1052:	00000097          	auipc	ra,0x0
    1056:	e8a080e7          	jalr	-374(ra) # edc <printint>
    105a:	8bca                	mv	s7,s2
      state = 0;
    105c:	4981                	li	s3,0
    105e:	b7a5                	j	fc6 <vprintf+0x42>
    1060:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
    1062:	008b8793          	addi	a5,s7,8
    1066:	8c3e                	mv	s8,a5
    1068:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    106c:	03000593          	li	a1,48
    1070:	8556                	mv	a0,s5
    1072:	00000097          	auipc	ra,0x0
    1076:	e48080e7          	jalr	-440(ra) # eba <putc>
  putc(fd, 'x');
    107a:	07800593          	li	a1,120
    107e:	8556                	mv	a0,s5
    1080:	00000097          	auipc	ra,0x0
    1084:	e3a080e7          	jalr	-454(ra) # eba <putc>
    1088:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    108a:	00000b97          	auipc	s7,0x0
    108e:	44eb8b93          	addi	s7,s7,1102 # 14d8 <digits>
    1092:	03c9d793          	srli	a5,s3,0x3c
    1096:	97de                	add	a5,a5,s7
    1098:	0007c583          	lbu	a1,0(a5)
    109c:	8556                	mv	a0,s5
    109e:	00000097          	auipc	ra,0x0
    10a2:	e1c080e7          	jalr	-484(ra) # eba <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    10a6:	0992                	slli	s3,s3,0x4
    10a8:	397d                	addiw	s2,s2,-1
    10aa:	fe0914e3          	bnez	s2,1092 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
    10ae:	8be2                	mv	s7,s8
      state = 0;
    10b0:	4981                	li	s3,0
    10b2:	6c02                	ld	s8,0(sp)
    10b4:	bf09                	j	fc6 <vprintf+0x42>
        s = va_arg(ap, char*);
    10b6:	008b8993          	addi	s3,s7,8
    10ba:	000bb903          	ld	s2,0(s7)
        if(s == 0)
    10be:	02090163          	beqz	s2,10e0 <vprintf+0x15c>
        while(*s != 0){
    10c2:	00094583          	lbu	a1,0(s2)
    10c6:	c9a5                	beqz	a1,1136 <vprintf+0x1b2>
          putc(fd, *s);
    10c8:	8556                	mv	a0,s5
    10ca:	00000097          	auipc	ra,0x0
    10ce:	df0080e7          	jalr	-528(ra) # eba <putc>
          s++;
    10d2:	0905                	addi	s2,s2,1
        while(*s != 0){
    10d4:	00094583          	lbu	a1,0(s2)
    10d8:	f9e5                	bnez	a1,10c8 <vprintf+0x144>
        s = va_arg(ap, char*);
    10da:	8bce                	mv	s7,s3
      state = 0;
    10dc:	4981                	li	s3,0
    10de:	b5e5                	j	fc6 <vprintf+0x42>
          s = "(null)";
    10e0:	00000917          	auipc	s2,0x0
    10e4:	36890913          	addi	s2,s2,872 # 1448 <malloc+0x20c>
        while(*s != 0){
    10e8:	02800593          	li	a1,40
    10ec:	bff1                	j	10c8 <vprintf+0x144>
        putc(fd, va_arg(ap, uint));
    10ee:	008b8913          	addi	s2,s7,8
    10f2:	000bc583          	lbu	a1,0(s7)
    10f6:	8556                	mv	a0,s5
    10f8:	00000097          	auipc	ra,0x0
    10fc:	dc2080e7          	jalr	-574(ra) # eba <putc>
    1100:	8bca                	mv	s7,s2
      state = 0;
    1102:	4981                	li	s3,0
    1104:	b5c9                	j	fc6 <vprintf+0x42>
        putc(fd, c);
    1106:	02500593          	li	a1,37
    110a:	8556                	mv	a0,s5
    110c:	00000097          	auipc	ra,0x0
    1110:	dae080e7          	jalr	-594(ra) # eba <putc>
      state = 0;
    1114:	4981                	li	s3,0
    1116:	bd45                	j	fc6 <vprintf+0x42>
        putc(fd, '%');
    1118:	02500593          	li	a1,37
    111c:	8556                	mv	a0,s5
    111e:	00000097          	auipc	ra,0x0
    1122:	d9c080e7          	jalr	-612(ra) # eba <putc>
        putc(fd, c);
    1126:	85ca                	mv	a1,s2
    1128:	8556                	mv	a0,s5
    112a:	00000097          	auipc	ra,0x0
    112e:	d90080e7          	jalr	-624(ra) # eba <putc>
      state = 0;
    1132:	4981                	li	s3,0
    1134:	bd49                	j	fc6 <vprintf+0x42>
        s = va_arg(ap, char*);
    1136:	8bce                	mv	s7,s3
      state = 0;
    1138:	4981                	li	s3,0
    113a:	b571                	j	fc6 <vprintf+0x42>
    113c:	74e2                	ld	s1,56(sp)
    113e:	79a2                	ld	s3,40(sp)
    1140:	7a02                	ld	s4,32(sp)
    1142:	6ae2                	ld	s5,24(sp)
    1144:	6b42                	ld	s6,16(sp)
    1146:	6ba2                	ld	s7,8(sp)
    }
  }
}
    1148:	60a6                	ld	ra,72(sp)
    114a:	6406                	ld	s0,64(sp)
    114c:	7942                	ld	s2,48(sp)
    114e:	6161                	addi	sp,sp,80
    1150:	8082                	ret

0000000000001152 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1152:	715d                	addi	sp,sp,-80
    1154:	ec06                	sd	ra,24(sp)
    1156:	e822                	sd	s0,16(sp)
    1158:	1000                	addi	s0,sp,32
    115a:	e010                	sd	a2,0(s0)
    115c:	e414                	sd	a3,8(s0)
    115e:	e818                	sd	a4,16(s0)
    1160:	ec1c                	sd	a5,24(s0)
    1162:	03043023          	sd	a6,32(s0)
    1166:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    116a:	8622                	mv	a2,s0
    116c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1170:	00000097          	auipc	ra,0x0
    1174:	e14080e7          	jalr	-492(ra) # f84 <vprintf>
}
    1178:	60e2                	ld	ra,24(sp)
    117a:	6442                	ld	s0,16(sp)
    117c:	6161                	addi	sp,sp,80
    117e:	8082                	ret

0000000000001180 <printf>:

void
printf(const char *fmt, ...)
{
    1180:	711d                	addi	sp,sp,-96
    1182:	ec06                	sd	ra,24(sp)
    1184:	e822                	sd	s0,16(sp)
    1186:	1000                	addi	s0,sp,32
    1188:	e40c                	sd	a1,8(s0)
    118a:	e810                	sd	a2,16(s0)
    118c:	ec14                	sd	a3,24(s0)
    118e:	f018                	sd	a4,32(s0)
    1190:	f41c                	sd	a5,40(s0)
    1192:	03043823          	sd	a6,48(s0)
    1196:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    119a:	00840613          	addi	a2,s0,8
    119e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    11a2:	85aa                	mv	a1,a0
    11a4:	4505                	li	a0,1
    11a6:	00000097          	auipc	ra,0x0
    11aa:	dde080e7          	jalr	-546(ra) # f84 <vprintf>
}
    11ae:	60e2                	ld	ra,24(sp)
    11b0:	6442                	ld	s0,16(sp)
    11b2:	6125                	addi	sp,sp,96
    11b4:	8082                	ret

00000000000011b6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11b6:	1141                	addi	sp,sp,-16
    11b8:	e406                	sd	ra,8(sp)
    11ba:	e022                	sd	s0,0(sp)
    11bc:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    11be:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11c2:	00001797          	auipc	a5,0x1
    11c6:	b2e7b783          	ld	a5,-1234(a5) # 1cf0 <freep>
    11ca:	a039                	j	11d8 <free+0x22>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11cc:	6398                	ld	a4,0(a5)
    11ce:	00e7e463          	bltu	a5,a4,11d6 <free+0x20>
    11d2:	00e6ea63          	bltu	a3,a4,11e6 <free+0x30>
{
    11d6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11d8:	fed7fae3          	bgeu	a5,a3,11cc <free+0x16>
    11dc:	6398                	ld	a4,0(a5)
    11de:	00e6e463          	bltu	a3,a4,11e6 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11e2:	fee7eae3          	bltu	a5,a4,11d6 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    11e6:	ff852583          	lw	a1,-8(a0)
    11ea:	6390                	ld	a2,0(a5)
    11ec:	02059813          	slli	a6,a1,0x20
    11f0:	01c85713          	srli	a4,a6,0x1c
    11f4:	9736                	add	a4,a4,a3
    11f6:	02e60563          	beq	a2,a4,1220 <free+0x6a>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    11fa:	fec53823          	sd	a2,-16(a0)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    11fe:	4790                	lw	a2,8(a5)
    1200:	02061593          	slli	a1,a2,0x20
    1204:	01c5d713          	srli	a4,a1,0x1c
    1208:	973e                	add	a4,a4,a5
    120a:	02e68263          	beq	a3,a4,122e <free+0x78>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    120e:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    1210:	00001717          	auipc	a4,0x1
    1214:	aef73023          	sd	a5,-1312(a4) # 1cf0 <freep>
}
    1218:	60a2                	ld	ra,8(sp)
    121a:	6402                	ld	s0,0(sp)
    121c:	0141                	addi	sp,sp,16
    121e:	8082                	ret
    bp->s.size += p->s.ptr->s.size;
    1220:	4618                	lw	a4,8(a2)
    1222:	9f2d                	addw	a4,a4,a1
    1224:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    1228:	6398                	ld	a4,0(a5)
    122a:	6310                	ld	a2,0(a4)
    122c:	b7f9                	j	11fa <free+0x44>
    p->s.size += bp->s.size;
    122e:	ff852703          	lw	a4,-8(a0)
    1232:	9f31                	addw	a4,a4,a2
    1234:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    1236:	ff053683          	ld	a3,-16(a0)
    123a:	bfd1                	j	120e <free+0x58>

000000000000123c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    123c:	7139                	addi	sp,sp,-64
    123e:	fc06                	sd	ra,56(sp)
    1240:	f822                	sd	s0,48(sp)
    1242:	f04a                	sd	s2,32(sp)
    1244:	ec4e                	sd	s3,24(sp)
    1246:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1248:	02051993          	slli	s3,a0,0x20
    124c:	0209d993          	srli	s3,s3,0x20
    1250:	09bd                	addi	s3,s3,15
    1252:	0049d993          	srli	s3,s3,0x4
    1256:	2985                	addiw	s3,s3,1
    1258:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    125a:	00001517          	auipc	a0,0x1
    125e:	a9653503          	ld	a0,-1386(a0) # 1cf0 <freep>
    1262:	c905                	beqz	a0,1292 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1264:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1266:	4798                	lw	a4,8(a5)
    1268:	09377a63          	bgeu	a4,s3,12fc <malloc+0xc0>
    126c:	f426                	sd	s1,40(sp)
    126e:	e852                	sd	s4,16(sp)
    1270:	e456                	sd	s5,8(sp)
    1272:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1274:	8a4e                	mv	s4,s3
    1276:	6705                	lui	a4,0x1
    1278:	00e9f363          	bgeu	s3,a4,127e <malloc+0x42>
    127c:	6a05                	lui	s4,0x1
    127e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1282:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1286:	00001497          	auipc	s1,0x1
    128a:	a6a48493          	addi	s1,s1,-1430 # 1cf0 <freep>
  if(p == (char*)-1)
    128e:	5afd                	li	s5,-1
    1290:	a089                	j	12d2 <malloc+0x96>
    1292:	f426                	sd	s1,40(sp)
    1294:	e852                	sd	s4,16(sp)
    1296:	e456                	sd	s5,8(sp)
    1298:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    129a:	00001797          	auipc	a5,0x1
    129e:	ac678793          	addi	a5,a5,-1338 # 1d60 <base>
    12a2:	00001717          	auipc	a4,0x1
    12a6:	a4f73723          	sd	a5,-1458(a4) # 1cf0 <freep>
    12aa:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    12ac:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    12b0:	b7d1                	j	1274 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    12b2:	6398                	ld	a4,0(a5)
    12b4:	e118                	sd	a4,0(a0)
    12b6:	a8b9                	j	1314 <malloc+0xd8>
  hp->s.size = nu;
    12b8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    12bc:	0541                	addi	a0,a0,16
    12be:	00000097          	auipc	ra,0x0
    12c2:	ef8080e7          	jalr	-264(ra) # 11b6 <free>
  return freep;
    12c6:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    12c8:	c135                	beqz	a0,132c <malloc+0xf0>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12ca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    12cc:	4798                	lw	a4,8(a5)
    12ce:	03277363          	bgeu	a4,s2,12f4 <malloc+0xb8>
    if(p == freep)
    12d2:	6098                	ld	a4,0(s1)
    12d4:	853e                	mv	a0,a5
    12d6:	fef71ae3          	bne	a4,a5,12ca <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
    12da:	8552                	mv	a0,s4
    12dc:	00000097          	auipc	ra,0x0
    12e0:	bc6080e7          	jalr	-1082(ra) # ea2 <sbrk>
  if(p == (char*)-1)
    12e4:	fd551ae3          	bne	a0,s5,12b8 <malloc+0x7c>
        return 0;
    12e8:	4501                	li	a0,0
    12ea:	74a2                	ld	s1,40(sp)
    12ec:	6a42                	ld	s4,16(sp)
    12ee:	6aa2                	ld	s5,8(sp)
    12f0:	6b02                	ld	s6,0(sp)
    12f2:	a03d                	j	1320 <malloc+0xe4>
    12f4:	74a2                	ld	s1,40(sp)
    12f6:	6a42                	ld	s4,16(sp)
    12f8:	6aa2                	ld	s5,8(sp)
    12fa:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    12fc:	fae90be3          	beq	s2,a4,12b2 <malloc+0x76>
        p->s.size -= nunits;
    1300:	4137073b          	subw	a4,a4,s3
    1304:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1306:	02071693          	slli	a3,a4,0x20
    130a:	01c6d713          	srli	a4,a3,0x1c
    130e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    1310:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    1314:	00001717          	auipc	a4,0x1
    1318:	9ca73e23          	sd	a0,-1572(a4) # 1cf0 <freep>
      return (void*)(p + 1);
    131c:	01078513          	addi	a0,a5,16
  }
}
    1320:	70e2                	ld	ra,56(sp)
    1322:	7442                	ld	s0,48(sp)
    1324:	7902                	ld	s2,32(sp)
    1326:	69e2                	ld	s3,24(sp)
    1328:	6121                	addi	sp,sp,64
    132a:	8082                	ret
    132c:	74a2                	ld	s1,40(sp)
    132e:	6a42                	ld	s4,16(sp)
    1330:	6aa2                	ld	s5,8(sp)
    1332:	6b02                	ld	s6,0(sp)
    1334:	b7f5                	j	1320 <malloc+0xe4>
