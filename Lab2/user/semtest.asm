
user/_semtest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

static void usage(void) {
  printf("semtest: uso: semtest <noinit|init N|closeuse|exhaust|grow|reopen>\n");
}

int main(int argc, char *argv[]) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
  if (argc < 2) {
   8:	4785                	li	a5,1
   a:	04a7d563          	bge	a5,a0,54 <main+0x54>
   e:	ec26                	sd	s1,24(sp)
  10:	e84a                	sd	s2,16(sp)
  12:	84aa                	mv	s1,a0
  14:	892e                	mv	s2,a1
    usage();
    exit(1);
  }
  if (strcmp(argv[1], "noinit") == 0) {
  16:	00001597          	auipc	a1,0x1
  1a:	b9258593          	addi	a1,a1,-1134 # ba8 <malloc+0x152>
  1e:	00893503          	ld	a0,8(s2)
  22:	00000097          	auipc	ra,0x0
  26:	3a4080e7          	jalr	932(ra) # 3c6 <strcmp>
  2a:	ed31                	bnez	a0,86 <main+0x86>
  2c:	e44e                	sd	s3,8(sp)
    int ok = sem_down(TEST_SEM);
  2e:	4505                	li	a0,1
  30:	00000097          	auipc	ra,0x0
  34:	69e080e7          	jalr	1694(ra) # 6ce <sem_down>
    if (ok == 0) {
  38:	ed15                	bnez	a0,74 <main+0x74>
      printf("error: semáforo no inicializado\n");
  3a:	00001517          	auipc	a0,0x1
  3e:	b7650513          	addi	a0,a0,-1162 # bb0 <malloc+0x15a>
  42:	00001097          	auipc	ra,0x1
  46:	95c080e7          	jalr	-1700(ra) # 99e <printf>
    } else {
      printf("inesperado: down exitoso sin open\n");
    }
    exit(0);
  4a:	4501                	li	a0,0
  4c:	00000097          	auipc	ra,0x0
  50:	5ca080e7          	jalr	1482(ra) # 616 <exit>
  54:	ec26                	sd	s1,24(sp)
  56:	e84a                	sd	s2,16(sp)
  58:	e44e                	sd	s3,8(sp)
  printf("semtest: uso: semtest <noinit|init N|closeuse|exhaust|grow|reopen>\n");
  5a:	00001517          	auipc	a0,0x1
  5e:	b0650513          	addi	a0,a0,-1274 # b60 <malloc+0x10a>
  62:	00001097          	auipc	ra,0x1
  66:	93c080e7          	jalr	-1732(ra) # 99e <printf>
    exit(1);
  6a:	4505                	li	a0,1
  6c:	00000097          	auipc	ra,0x0
  70:	5aa080e7          	jalr	1450(ra) # 616 <exit>
      printf("inesperado: down exitoso sin open\n");
  74:	00001517          	auipc	a0,0x1
  78:	b6450513          	addi	a0,a0,-1180 # bd8 <malloc+0x182>
  7c:	00001097          	auipc	ra,0x1
  80:	922080e7          	jalr	-1758(ra) # 99e <printf>
  84:	b7d9                	j	4a <main+0x4a>
  86:	e44e                	sd	s3,8(sp)
  } else if (strcmp(argv[1], "init") == 0) {
  88:	00001597          	auipc	a1,0x1
  8c:	b7858593          	addi	a1,a1,-1160 # c00 <malloc+0x1aa>
  90:	00893503          	ld	a0,8(s2)
  94:	00000097          	auipc	ra,0x0
  98:	332080e7          	jalr	818(ra) # 3c6 <strcmp>
  9c:	89aa                	mv	s3,a0
  9e:	e925                	bnez	a0,10e <main+0x10e>
    int v = 0;
    if (argc >= 3) v = atoi(argv[2]);
  a0:	4789                	li	a5,2
  a2:	0497c563          	blt	a5,s1,ec <main+0xec>
    if (sem_open(TEST_SEM, v)) {
  a6:	85ce                	mv	a1,s3
  a8:	4505                	li	a0,1
  aa:	00000097          	auipc	ra,0x0
  ae:	60c080e7          	jalr	1548(ra) # 6b6 <sem_open>
  b2:	c529                	beqz	a0,fc <main+0xfc>
      printf("init: %d\n", v);
  b4:	85ce                	mv	a1,s3
  b6:	00001517          	auipc	a0,0x1
  ba:	b5250513          	addi	a0,a0,-1198 # c08 <malloc+0x1b2>
  be:	00001097          	auipc	ra,0x1
  c2:	8e0080e7          	jalr	-1824(ra) # 99e <printf>
      printf("value=%d\n", v);
  c6:	85ce                	mv	a1,s3
  c8:	00001517          	auipc	a0,0x1
  cc:	b5050513          	addi	a0,a0,-1200 # c18 <malloc+0x1c2>
  d0:	00001097          	auipc	ra,0x1
  d4:	8ce080e7          	jalr	-1842(ra) # 99e <printf>
      sem_close(TEST_SEM);
  d8:	4505                	li	a0,1
  da:	00000097          	auipc	ra,0x0
  de:	5e4080e7          	jalr	1508(ra) # 6be <sem_close>
    } else {
      printf("error: init falló\n");
    }
    exit(0);
  e2:	4501                	li	a0,0
  e4:	00000097          	auipc	ra,0x0
  e8:	532080e7          	jalr	1330(ra) # 616 <exit>
    if (argc >= 3) v = atoi(argv[2]);
  ec:	01093503          	ld	a0,16(s2)
  f0:	00000097          	auipc	ra,0x0
  f4:	42c080e7          	jalr	1068(ra) # 51c <atoi>
  f8:	89aa                	mv	s3,a0
  fa:	b775                	j	a6 <main+0xa6>
      printf("error: init falló\n");
  fc:	00001517          	auipc	a0,0x1
 100:	b2c50513          	addi	a0,a0,-1236 # c28 <malloc+0x1d2>
 104:	00001097          	auipc	ra,0x1
 108:	89a080e7          	jalr	-1894(ra) # 99e <printf>
 10c:	bfd9                	j	e2 <main+0xe2>
  } else if (strcmp(argv[1], "closeuse") == 0) {
 10e:	00001597          	auipc	a1,0x1
 112:	b3258593          	addi	a1,a1,-1230 # c40 <malloc+0x1ea>
 116:	00893503          	ld	a0,8(s2)
 11a:	00000097          	auipc	ra,0x0
 11e:	2ac080e7          	jalr	684(ra) # 3c6 <strcmp>
 122:	ed35                	bnez	a0,19e <main+0x19e>
    if (!sem_open(TEST_SEM, 1)) {
 124:	4585                	li	a1,1
 126:	4505                	li	a0,1
 128:	00000097          	auipc	ra,0x0
 12c:	58e080e7          	jalr	1422(ra) # 6b6 <sem_open>
 130:	ed11                	bnez	a0,14c <main+0x14c>
      printf("error: init falló\n");
 132:	00001517          	auipc	a0,0x1
 136:	af650513          	addi	a0,a0,-1290 # c28 <malloc+0x1d2>
 13a:	00001097          	auipc	ra,0x1
 13e:	864080e7          	jalr	-1948(ra) # 99e <printf>
      exit(0);
 142:	4501                	li	a0,0
 144:	00000097          	auipc	ra,0x0
 148:	4d2080e7          	jalr	1234(ra) # 616 <exit>
    }
    sem_close(TEST_SEM);
 14c:	4505                	li	a0,1
 14e:	00000097          	auipc	ra,0x0
 152:	570080e7          	jalr	1392(ra) # 6be <sem_close>
    int ok = sem_up(TEST_SEM);
 156:	4505                	li	a0,1
 158:	00000097          	auipc	ra,0x0
 15c:	56e080e7          	jalr	1390(ra) # 6c6 <sem_up>
    if (ok == 0) {
 160:	e515                	bnez	a0,18c <main+0x18c>
      printf("cerrado (closed)\n");
 162:	00001517          	auipc	a0,0x1
 166:	aee50513          	addi	a0,a0,-1298 # c50 <malloc+0x1fa>
 16a:	00001097          	auipc	ra,0x1
 16e:	834080e7          	jalr	-1996(ra) # 99e <printf>
      printf("error: no se puede usar tras cierre\n");
 172:	00001517          	auipc	a0,0x1
 176:	af650513          	addi	a0,a0,-1290 # c68 <malloc+0x212>
 17a:	00001097          	auipc	ra,0x1
 17e:	824080e7          	jalr	-2012(ra) # 99e <printf>
    } else {
      printf("inesperado: up exitoso tras cierre\n");
    }
    exit(0);
 182:	4501                	li	a0,0
 184:	00000097          	auipc	ra,0x0
 188:	492080e7          	jalr	1170(ra) # 616 <exit>
      printf("inesperado: up exitoso tras cierre\n");
 18c:	00001517          	auipc	a0,0x1
 190:	b0450513          	addi	a0,a0,-1276 # c90 <malloc+0x23a>
 194:	00001097          	auipc	ra,0x1
 198:	80a080e7          	jalr	-2038(ra) # 99e <printf>
 19c:	b7dd                	j	182 <main+0x182>
  } else if (strcmp(argv[1], "exhaust") == 0) {
 19e:	00001597          	auipc	a1,0x1
 1a2:	b1a58593          	addi	a1,a1,-1254 # cb8 <malloc+0x262>
 1a6:	00893503          	ld	a0,8(s2)
 1aa:	00000097          	auipc	ra,0x0
 1ae:	21c080e7          	jalr	540(ra) # 3c6 <strcmp>
 1b2:	e15d                	bnez	a0,258 <main+0x258>
    if (!sem_open(TEST_SEM, 1)) {
 1b4:	4585                	li	a1,1
 1b6:	4505                	li	a0,1
 1b8:	00000097          	auipc	ra,0x0
 1bc:	4fe080e7          	jalr	1278(ra) # 6b6 <sem_open>
 1c0:	ed11                	bnez	a0,1dc <main+0x1dc>
      printf("error: init falló\n");
 1c2:	00001517          	auipc	a0,0x1
 1c6:	a6650513          	addi	a0,a0,-1434 # c28 <malloc+0x1d2>
 1ca:	00000097          	auipc	ra,0x0
 1ce:	7d4080e7          	jalr	2004(ra) # 99e <printf>
      exit(0);
 1d2:	4501                	li	a0,0
 1d4:	00000097          	auipc	ra,0x0
 1d8:	442080e7          	jalr	1090(ra) # 616 <exit>
    }
    if (sem_down(TEST_SEM)) {
 1dc:	4505                	li	a0,1
 1de:	00000097          	auipc	ra,0x0
 1e2:	4f0080e7          	jalr	1264(ra) # 6ce <sem_down>
 1e6:	c539                	beqz	a0,234 <main+0x234>
      printf("agotado (exhausted)\n");
 1e8:	00001517          	auipc	a0,0x1
 1ec:	ad850513          	addi	a0,a0,-1320 # cc0 <malloc+0x26a>
 1f0:	00000097          	auipc	ra,0x0
 1f4:	7ae080e7          	jalr	1966(ra) # 99e <printf>
    } else {
      printf("error: down falló\n");
    }
    sem_close(TEST_SEM);
 1f8:	4505                	li	a0,1
 1fa:	00000097          	auipc	ra,0x0
 1fe:	4c4080e7          	jalr	1220(ra) # 6be <sem_close>
    if (sem_open(TEST_SEM, 1)) {
 202:	4585                	li	a1,1
 204:	4505                	li	a0,1
 206:	00000097          	auipc	ra,0x0
 20a:	4b0080e7          	jalr	1200(ra) # 6b6 <sem_open>
 20e:	cd05                	beqz	a0,246 <main+0x246>
      printf("reutilización (reuse)\n");
 210:	00001517          	auipc	a0,0x1
 214:	ae050513          	addi	a0,a0,-1312 # cf0 <malloc+0x29a>
 218:	00000097          	auipc	ra,0x0
 21c:	786080e7          	jalr	1926(ra) # 99e <printf>
      sem_close(TEST_SEM);
 220:	4505                	li	a0,1
 222:	00000097          	auipc	ra,0x0
 226:	49c080e7          	jalr	1180(ra) # 6be <sem_close>
    } else {
      printf("error: abrir para reutilización falló\n");
    }
    exit(0);
 22a:	4501                	li	a0,0
 22c:	00000097          	auipc	ra,0x0
 230:	3ea080e7          	jalr	1002(ra) # 616 <exit>
      printf("error: down falló\n");
 234:	00001517          	auipc	a0,0x1
 238:	aa450513          	addi	a0,a0,-1372 # cd8 <malloc+0x282>
 23c:	00000097          	auipc	ra,0x0
 240:	762080e7          	jalr	1890(ra) # 99e <printf>
 244:	bf55                	j	1f8 <main+0x1f8>
      printf("error: abrir para reutilización falló\n");
 246:	00001517          	auipc	a0,0x1
 24a:	ac250513          	addi	a0,a0,-1342 # d08 <malloc+0x2b2>
 24e:	00000097          	auipc	ra,0x0
 252:	750080e7          	jalr	1872(ra) # 99e <printf>
 256:	bfd1                	j	22a <main+0x22a>
  } else if (strcmp(argv[1], "grow") == 0) {
 258:	00001597          	auipc	a1,0x1
 25c:	ae058593          	addi	a1,a1,-1312 # d38 <malloc+0x2e2>
 260:	00893503          	ld	a0,8(s2)
 264:	00000097          	auipc	ra,0x0
 268:	162080e7          	jalr	354(ra) # 3c6 <strcmp>
 26c:	e541                	bnez	a0,2f4 <main+0x2f4>
    if (!sem_open(TEST_SEM, 0)) {
 26e:	4581                	li	a1,0
 270:	4505                	li	a0,1
 272:	00000097          	auipc	ra,0x0
 276:	444080e7          	jalr	1092(ra) # 6b6 <sem_open>
 27a:	ed11                	bnez	a0,296 <main+0x296>
      printf("error: init falló\n");
 27c:	00001517          	auipc	a0,0x1
 280:	9ac50513          	addi	a0,a0,-1620 # c28 <malloc+0x1d2>
 284:	00000097          	auipc	ra,0x0
 288:	71a080e7          	jalr	1818(ra) # 99e <printf>
      exit(0);
 28c:	4501                	li	a0,0
 28e:	00000097          	auipc	ra,0x0
 292:	388080e7          	jalr	904(ra) # 616 <exit>
    }
    if (sem_up(TEST_SEM) && sem_up(TEST_SEM)) {
 296:	4505                	li	a0,1
 298:	00000097          	auipc	ra,0x0
 29c:	42e080e7          	jalr	1070(ra) # 6c6 <sem_up>
 2a0:	c519                	beqz	a0,2ae <main+0x2ae>
 2a2:	4505                	li	a0,1
 2a4:	00000097          	auipc	ra,0x0
 2a8:	422080e7          	jalr	1058(ra) # 6c6 <sem_up>
 2ac:	e11d                	bnez	a0,2d2 <main+0x2d2>
      printf("grow ok\n");
      printf("contador supera valor inicial\n");
    } else {
      printf("error: sem_up no permitió crecer mas alla del valor inicial\n");
 2ae:	00001517          	auipc	a0,0x1
 2b2:	ac250513          	addi	a0,a0,-1342 # d70 <malloc+0x31a>
 2b6:	00000097          	auipc	ra,0x0
 2ba:	6e8080e7          	jalr	1768(ra) # 99e <printf>
    }
    sem_close(TEST_SEM);
 2be:	4505                	li	a0,1
 2c0:	00000097          	auipc	ra,0x0
 2c4:	3fe080e7          	jalr	1022(ra) # 6be <sem_close>
    exit(0);
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	34c080e7          	jalr	844(ra) # 616 <exit>
      printf("grow ok\n");
 2d2:	00001517          	auipc	a0,0x1
 2d6:	a6e50513          	addi	a0,a0,-1426 # d40 <malloc+0x2ea>
 2da:	00000097          	auipc	ra,0x0
 2de:	6c4080e7          	jalr	1732(ra) # 99e <printf>
      printf("contador supera valor inicial\n");
 2e2:	00001517          	auipc	a0,0x1
 2e6:	a6e50513          	addi	a0,a0,-1426 # d50 <malloc+0x2fa>
 2ea:	00000097          	auipc	ra,0x0
 2ee:	6b4080e7          	jalr	1716(ra) # 99e <printf>
 2f2:	b7f1                	j	2be <main+0x2be>
  } else if (strcmp(argv[1], "reopen") == 0) {
 2f4:	00001597          	auipc	a1,0x1
 2f8:	abc58593          	addi	a1,a1,-1348 # db0 <malloc+0x35a>
 2fc:	00893503          	ld	a0,8(s2)
 300:	00000097          	auipc	ra,0x0
 304:	0c6080e7          	jalr	198(ra) # 3c6 <strcmp>
 308:	e53d                	bnez	a0,376 <main+0x376>
    if (!sem_open(TEST_SEM, 1)) {
 30a:	4585                	li	a1,1
 30c:	4505                	li	a0,1
 30e:	00000097          	auipc	ra,0x0
 312:	3a8080e7          	jalr	936(ra) # 6b6 <sem_open>
 316:	ed11                	bnez	a0,332 <main+0x332>
      printf("error: primer open falló\n");
 318:	00001517          	auipc	a0,0x1
 31c:	aa050513          	addi	a0,a0,-1376 # db8 <malloc+0x362>
 320:	00000097          	auipc	ra,0x0
 324:	67e080e7          	jalr	1662(ra) # 99e <printf>
      exit(0);
 328:	4501                	li	a0,0
 32a:	00000097          	auipc	ra,0x0
 32e:	2ec080e7          	jalr	748(ra) # 616 <exit>
    }
    if (sem_open(TEST_SEM, 5) == 0) {
 332:	4595                	li	a1,5
 334:	4505                	li	a0,1
 336:	00000097          	auipc	ra,0x0
 33a:	380080e7          	jalr	896(ra) # 6b6 <sem_open>
 33e:	e11d                	bnez	a0,364 <main+0x364>
      printf("error: doble open rechazado\n");
 340:	00001517          	auipc	a0,0x1
 344:	a9850513          	addi	a0,a0,-1384 # dd8 <malloc+0x382>
 348:	00000097          	auipc	ra,0x0
 34c:	656080e7          	jalr	1622(ra) # 99e <printf>
    } else {
      printf("inesperado: doble open permitido\n");
    }
    sem_close(TEST_SEM);
 350:	4505                	li	a0,1
 352:	00000097          	auipc	ra,0x0
 356:	36c080e7          	jalr	876(ra) # 6be <sem_close>
    exit(0);
 35a:	4501                	li	a0,0
 35c:	00000097          	auipc	ra,0x0
 360:	2ba080e7          	jalr	698(ra) # 616 <exit>
      printf("inesperado: doble open permitido\n");
 364:	00001517          	auipc	a0,0x1
 368:	a9450513          	addi	a0,a0,-1388 # df8 <malloc+0x3a2>
 36c:	00000097          	auipc	ra,0x0
 370:	632080e7          	jalr	1586(ra) # 99e <printf>
 374:	bff1                	j	350 <main+0x350>
  printf("semtest: uso: semtest <noinit|init N|closeuse|exhaust|grow|reopen>\n");
 376:	00000517          	auipc	a0,0x0
 37a:	7ea50513          	addi	a0,a0,2026 # b60 <malloc+0x10a>
 37e:	00000097          	auipc	ra,0x0
 382:	620080e7          	jalr	1568(ra) # 99e <printf>
  } else {
    usage();
    exit(1);
 386:	4505                	li	a0,1
 388:	00000097          	auipc	ra,0x0
 38c:	28e080e7          	jalr	654(ra) # 616 <exit>

0000000000000390 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 390:	1141                	addi	sp,sp,-16
 392:	e406                	sd	ra,8(sp)
 394:	e022                	sd	s0,0(sp)
 396:	0800                	addi	s0,sp,16
  extern int main();
  main();
 398:	00000097          	auipc	ra,0x0
 39c:	c68080e7          	jalr	-920(ra) # 0 <main>
  exit(0);
 3a0:	4501                	li	a0,0
 3a2:	00000097          	auipc	ra,0x0
 3a6:	274080e7          	jalr	628(ra) # 616 <exit>

00000000000003aa <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 3aa:	1141                	addi	sp,sp,-16
 3ac:	e422                	sd	s0,8(sp)
 3ae:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3b0:	87aa                	mv	a5,a0
 3b2:	0585                	addi	a1,a1,1
 3b4:	0785                	addi	a5,a5,1
 3b6:	fff5c703          	lbu	a4,-1(a1)
 3ba:	fee78fa3          	sb	a4,-1(a5)
 3be:	fb75                	bnez	a4,3b2 <strcpy+0x8>
    ;
  return os;
}
 3c0:	6422                	ld	s0,8(sp)
 3c2:	0141                	addi	sp,sp,16
 3c4:	8082                	ret

00000000000003c6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3c6:	1141                	addi	sp,sp,-16
 3c8:	e422                	sd	s0,8(sp)
 3ca:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3cc:	00054783          	lbu	a5,0(a0)
 3d0:	cb91                	beqz	a5,3e4 <strcmp+0x1e>
 3d2:	0005c703          	lbu	a4,0(a1)
 3d6:	00f71763          	bne	a4,a5,3e4 <strcmp+0x1e>
    p++, q++;
 3da:	0505                	addi	a0,a0,1
 3dc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3de:	00054783          	lbu	a5,0(a0)
 3e2:	fbe5                	bnez	a5,3d2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3e4:	0005c503          	lbu	a0,0(a1)
}
 3e8:	40a7853b          	subw	a0,a5,a0
 3ec:	6422                	ld	s0,8(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret

00000000000003f2 <strlen>:

uint
strlen(const char *s)
{
 3f2:	1141                	addi	sp,sp,-16
 3f4:	e422                	sd	s0,8(sp)
 3f6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3f8:	00054783          	lbu	a5,0(a0)
 3fc:	cf91                	beqz	a5,418 <strlen+0x26>
 3fe:	0505                	addi	a0,a0,1
 400:	87aa                	mv	a5,a0
 402:	86be                	mv	a3,a5
 404:	0785                	addi	a5,a5,1
 406:	fff7c703          	lbu	a4,-1(a5)
 40a:	ff65                	bnez	a4,402 <strlen+0x10>
 40c:	40a6853b          	subw	a0,a3,a0
 410:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 412:	6422                	ld	s0,8(sp)
 414:	0141                	addi	sp,sp,16
 416:	8082                	ret
  for(n = 0; s[n]; n++)
 418:	4501                	li	a0,0
 41a:	bfe5                	j	412 <strlen+0x20>

000000000000041c <memset>:

void*
memset(void *dst, int c, uint n)
{
 41c:	1141                	addi	sp,sp,-16
 41e:	e422                	sd	s0,8(sp)
 420:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 422:	ca19                	beqz	a2,438 <memset+0x1c>
 424:	87aa                	mv	a5,a0
 426:	1602                	slli	a2,a2,0x20
 428:	9201                	srli	a2,a2,0x20
 42a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 42e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 432:	0785                	addi	a5,a5,1
 434:	fee79de3          	bne	a5,a4,42e <memset+0x12>
  }
  return dst;
}
 438:	6422                	ld	s0,8(sp)
 43a:	0141                	addi	sp,sp,16
 43c:	8082                	ret

000000000000043e <strchr>:

char*
strchr(const char *s, char c)
{
 43e:	1141                	addi	sp,sp,-16
 440:	e422                	sd	s0,8(sp)
 442:	0800                	addi	s0,sp,16
  for(; *s; s++)
 444:	00054783          	lbu	a5,0(a0)
 448:	cb99                	beqz	a5,45e <strchr+0x20>
    if(*s == c)
 44a:	00f58763          	beq	a1,a5,458 <strchr+0x1a>
  for(; *s; s++)
 44e:	0505                	addi	a0,a0,1
 450:	00054783          	lbu	a5,0(a0)
 454:	fbfd                	bnez	a5,44a <strchr+0xc>
      return (char*)s;
  return 0;
 456:	4501                	li	a0,0
}
 458:	6422                	ld	s0,8(sp)
 45a:	0141                	addi	sp,sp,16
 45c:	8082                	ret
  return 0;
 45e:	4501                	li	a0,0
 460:	bfe5                	j	458 <strchr+0x1a>

0000000000000462 <gets>:

char*
gets(char *buf, int max)
{
 462:	711d                	addi	sp,sp,-96
 464:	ec86                	sd	ra,88(sp)
 466:	e8a2                	sd	s0,80(sp)
 468:	e4a6                	sd	s1,72(sp)
 46a:	e0ca                	sd	s2,64(sp)
 46c:	fc4e                	sd	s3,56(sp)
 46e:	f852                	sd	s4,48(sp)
 470:	f456                	sd	s5,40(sp)
 472:	f05a                	sd	s6,32(sp)
 474:	ec5e                	sd	s7,24(sp)
 476:	1080                	addi	s0,sp,96
 478:	8baa                	mv	s7,a0
 47a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 47c:	892a                	mv	s2,a0
 47e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 480:	4aa9                	li	s5,10
 482:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 484:	89a6                	mv	s3,s1
 486:	2485                	addiw	s1,s1,1
 488:	0344d863          	bge	s1,s4,4b8 <gets+0x56>
    cc = read(0, &c, 1);
 48c:	4605                	li	a2,1
 48e:	faf40593          	addi	a1,s0,-81
 492:	4501                	li	a0,0
 494:	00000097          	auipc	ra,0x0
 498:	19a080e7          	jalr	410(ra) # 62e <read>
    if(cc < 1)
 49c:	00a05e63          	blez	a0,4b8 <gets+0x56>
    buf[i++] = c;
 4a0:	faf44783          	lbu	a5,-81(s0)
 4a4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4a8:	01578763          	beq	a5,s5,4b6 <gets+0x54>
 4ac:	0905                	addi	s2,s2,1
 4ae:	fd679be3          	bne	a5,s6,484 <gets+0x22>
    buf[i++] = c;
 4b2:	89a6                	mv	s3,s1
 4b4:	a011                	j	4b8 <gets+0x56>
 4b6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 4b8:	99de                	add	s3,s3,s7
 4ba:	00098023          	sb	zero,0(s3)
  return buf;
}
 4be:	855e                	mv	a0,s7
 4c0:	60e6                	ld	ra,88(sp)
 4c2:	6446                	ld	s0,80(sp)
 4c4:	64a6                	ld	s1,72(sp)
 4c6:	6906                	ld	s2,64(sp)
 4c8:	79e2                	ld	s3,56(sp)
 4ca:	7a42                	ld	s4,48(sp)
 4cc:	7aa2                	ld	s5,40(sp)
 4ce:	7b02                	ld	s6,32(sp)
 4d0:	6be2                	ld	s7,24(sp)
 4d2:	6125                	addi	sp,sp,96
 4d4:	8082                	ret

00000000000004d6 <stat>:

int
stat(const char *n, struct stat *st)
{
 4d6:	1101                	addi	sp,sp,-32
 4d8:	ec06                	sd	ra,24(sp)
 4da:	e822                	sd	s0,16(sp)
 4dc:	e04a                	sd	s2,0(sp)
 4de:	1000                	addi	s0,sp,32
 4e0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4e2:	4581                	li	a1,0
 4e4:	00000097          	auipc	ra,0x0
 4e8:	172080e7          	jalr	370(ra) # 656 <open>
  if(fd < 0)
 4ec:	02054663          	bltz	a0,518 <stat+0x42>
 4f0:	e426                	sd	s1,8(sp)
 4f2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4f4:	85ca                	mv	a1,s2
 4f6:	00000097          	auipc	ra,0x0
 4fa:	178080e7          	jalr	376(ra) # 66e <fstat>
 4fe:	892a                	mv	s2,a0
  close(fd);
 500:	8526                	mv	a0,s1
 502:	00000097          	auipc	ra,0x0
 506:	13c080e7          	jalr	316(ra) # 63e <close>
  return r;
 50a:	64a2                	ld	s1,8(sp)
}
 50c:	854a                	mv	a0,s2
 50e:	60e2                	ld	ra,24(sp)
 510:	6442                	ld	s0,16(sp)
 512:	6902                	ld	s2,0(sp)
 514:	6105                	addi	sp,sp,32
 516:	8082                	ret
    return -1;
 518:	597d                	li	s2,-1
 51a:	bfcd                	j	50c <stat+0x36>

000000000000051c <atoi>:

int
atoi(const char *s)
{
 51c:	1141                	addi	sp,sp,-16
 51e:	e422                	sd	s0,8(sp)
 520:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 522:	00054683          	lbu	a3,0(a0)
 526:	fd06879b          	addiw	a5,a3,-48
 52a:	0ff7f793          	zext.b	a5,a5
 52e:	4625                	li	a2,9
 530:	02f66863          	bltu	a2,a5,560 <atoi+0x44>
 534:	872a                	mv	a4,a0
  n = 0;
 536:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 538:	0705                	addi	a4,a4,1
 53a:	0025179b          	slliw	a5,a0,0x2
 53e:	9fa9                	addw	a5,a5,a0
 540:	0017979b          	slliw	a5,a5,0x1
 544:	9fb5                	addw	a5,a5,a3
 546:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 54a:	00074683          	lbu	a3,0(a4)
 54e:	fd06879b          	addiw	a5,a3,-48
 552:	0ff7f793          	zext.b	a5,a5
 556:	fef671e3          	bgeu	a2,a5,538 <atoi+0x1c>
  return n;
}
 55a:	6422                	ld	s0,8(sp)
 55c:	0141                	addi	sp,sp,16
 55e:	8082                	ret
  n = 0;
 560:	4501                	li	a0,0
 562:	bfe5                	j	55a <atoi+0x3e>

0000000000000564 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 564:	1141                	addi	sp,sp,-16
 566:	e422                	sd	s0,8(sp)
 568:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 56a:	02b57463          	bgeu	a0,a1,592 <memmove+0x2e>
    while(n-- > 0)
 56e:	00c05f63          	blez	a2,58c <memmove+0x28>
 572:	1602                	slli	a2,a2,0x20
 574:	9201                	srli	a2,a2,0x20
 576:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 57a:	872a                	mv	a4,a0
      *dst++ = *src++;
 57c:	0585                	addi	a1,a1,1
 57e:	0705                	addi	a4,a4,1
 580:	fff5c683          	lbu	a3,-1(a1)
 584:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 588:	fef71ae3          	bne	a4,a5,57c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 58c:	6422                	ld	s0,8(sp)
 58e:	0141                	addi	sp,sp,16
 590:	8082                	ret
    dst += n;
 592:	00c50733          	add	a4,a0,a2
    src += n;
 596:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 598:	fec05ae3          	blez	a2,58c <memmove+0x28>
 59c:	fff6079b          	addiw	a5,a2,-1
 5a0:	1782                	slli	a5,a5,0x20
 5a2:	9381                	srli	a5,a5,0x20
 5a4:	fff7c793          	not	a5,a5
 5a8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5aa:	15fd                	addi	a1,a1,-1
 5ac:	177d                	addi	a4,a4,-1
 5ae:	0005c683          	lbu	a3,0(a1)
 5b2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5b6:	fee79ae3          	bne	a5,a4,5aa <memmove+0x46>
 5ba:	bfc9                	j	58c <memmove+0x28>

00000000000005bc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5bc:	1141                	addi	sp,sp,-16
 5be:	e422                	sd	s0,8(sp)
 5c0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5c2:	ca05                	beqz	a2,5f2 <memcmp+0x36>
 5c4:	fff6069b          	addiw	a3,a2,-1
 5c8:	1682                	slli	a3,a3,0x20
 5ca:	9281                	srli	a3,a3,0x20
 5cc:	0685                	addi	a3,a3,1
 5ce:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5d0:	00054783          	lbu	a5,0(a0)
 5d4:	0005c703          	lbu	a4,0(a1)
 5d8:	00e79863          	bne	a5,a4,5e8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5dc:	0505                	addi	a0,a0,1
    p2++;
 5de:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5e0:	fed518e3          	bne	a0,a3,5d0 <memcmp+0x14>
  }
  return 0;
 5e4:	4501                	li	a0,0
 5e6:	a019                	j	5ec <memcmp+0x30>
      return *p1 - *p2;
 5e8:	40e7853b          	subw	a0,a5,a4
}
 5ec:	6422                	ld	s0,8(sp)
 5ee:	0141                	addi	sp,sp,16
 5f0:	8082                	ret
  return 0;
 5f2:	4501                	li	a0,0
 5f4:	bfe5                	j	5ec <memcmp+0x30>

00000000000005f6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5f6:	1141                	addi	sp,sp,-16
 5f8:	e406                	sd	ra,8(sp)
 5fa:	e022                	sd	s0,0(sp)
 5fc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5fe:	00000097          	auipc	ra,0x0
 602:	f66080e7          	jalr	-154(ra) # 564 <memmove>
}
 606:	60a2                	ld	ra,8(sp)
 608:	6402                	ld	s0,0(sp)
 60a:	0141                	addi	sp,sp,16
 60c:	8082                	ret

000000000000060e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 60e:	4885                	li	a7,1
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <exit>:
.global exit
exit:
 li a7, SYS_exit
 616:	4889                	li	a7,2
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <wait>:
.global wait
wait:
 li a7, SYS_wait
 61e:	488d                	li	a7,3
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 626:	4891                	li	a7,4
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <read>:
.global read
read:
 li a7, SYS_read
 62e:	4895                	li	a7,5
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <write>:
.global write
write:
 li a7, SYS_write
 636:	48c1                	li	a7,16
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <close>:
.global close
close:
 li a7, SYS_close
 63e:	48d5                	li	a7,21
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <kill>:
.global kill
kill:
 li a7, SYS_kill
 646:	4899                	li	a7,6
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <exec>:
.global exec
exec:
 li a7, SYS_exec
 64e:	489d                	li	a7,7
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <open>:
.global open
open:
 li a7, SYS_open
 656:	48bd                	li	a7,15
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 65e:	48c5                	li	a7,17
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 666:	48c9                	li	a7,18
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 66e:	48a1                	li	a7,8
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <link>:
.global link
link:
 li a7, SYS_link
 676:	48cd                	li	a7,19
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 67e:	48d1                	li	a7,20
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 686:	48a5                	li	a7,9
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <dup>:
.global dup
dup:
 li a7, SYS_dup
 68e:	48a9                	li	a7,10
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 696:	48ad                	li	a7,11
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 69e:	48b1                	li	a7,12
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6a6:	48b5                	li	a7,13
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6ae:	48b9                	li	a7,14
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 6b6:	48d9                	li	a7,22
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 6be:	48dd                	li	a7,23
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <sem_up>:
.global sem_up
sem_up:
 li a7, SYS_sem_up
 6c6:	48e1                	li	a7,24
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <sem_down>:
.global sem_down
sem_down:
 li a7, SYS_sem_down
 6ce:	48e5                	li	a7,25
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6d6:	1101                	addi	sp,sp,-32
 6d8:	ec06                	sd	ra,24(sp)
 6da:	e822                	sd	s0,16(sp)
 6dc:	1000                	addi	s0,sp,32
 6de:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6e2:	4605                	li	a2,1
 6e4:	fef40593          	addi	a1,s0,-17
 6e8:	00000097          	auipc	ra,0x0
 6ec:	f4e080e7          	jalr	-178(ra) # 636 <write>
}
 6f0:	60e2                	ld	ra,24(sp)
 6f2:	6442                	ld	s0,16(sp)
 6f4:	6105                	addi	sp,sp,32
 6f6:	8082                	ret

00000000000006f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6f8:	7139                	addi	sp,sp,-64
 6fa:	fc06                	sd	ra,56(sp)
 6fc:	f822                	sd	s0,48(sp)
 6fe:	f426                	sd	s1,40(sp)
 700:	0080                	addi	s0,sp,64
 702:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 704:	c299                	beqz	a3,70a <printint+0x12>
 706:	0805cb63          	bltz	a1,79c <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 70a:	2581                	sext.w	a1,a1
  neg = 0;
 70c:	4881                	li	a7,0
 70e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 712:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 714:	2601                	sext.w	a2,a2
 716:	00000517          	auipc	a0,0x0
 71a:	76a50513          	addi	a0,a0,1898 # e80 <digits>
 71e:	883a                	mv	a6,a4
 720:	2705                	addiw	a4,a4,1
 722:	02c5f7bb          	remuw	a5,a1,a2
 726:	1782                	slli	a5,a5,0x20
 728:	9381                	srli	a5,a5,0x20
 72a:	97aa                	add	a5,a5,a0
 72c:	0007c783          	lbu	a5,0(a5)
 730:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 734:	0005879b          	sext.w	a5,a1
 738:	02c5d5bb          	divuw	a1,a1,a2
 73c:	0685                	addi	a3,a3,1
 73e:	fec7f0e3          	bgeu	a5,a2,71e <printint+0x26>
  if(neg)
 742:	00088c63          	beqz	a7,75a <printint+0x62>
    buf[i++] = '-';
 746:	fd070793          	addi	a5,a4,-48
 74a:	00878733          	add	a4,a5,s0
 74e:	02d00793          	li	a5,45
 752:	fef70823          	sb	a5,-16(a4)
 756:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 75a:	02e05c63          	blez	a4,792 <printint+0x9a>
 75e:	f04a                	sd	s2,32(sp)
 760:	ec4e                	sd	s3,24(sp)
 762:	fc040793          	addi	a5,s0,-64
 766:	00e78933          	add	s2,a5,a4
 76a:	fff78993          	addi	s3,a5,-1
 76e:	99ba                	add	s3,s3,a4
 770:	377d                	addiw	a4,a4,-1
 772:	1702                	slli	a4,a4,0x20
 774:	9301                	srli	a4,a4,0x20
 776:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 77a:	fff94583          	lbu	a1,-1(s2)
 77e:	8526                	mv	a0,s1
 780:	00000097          	auipc	ra,0x0
 784:	f56080e7          	jalr	-170(ra) # 6d6 <putc>
  while(--i >= 0)
 788:	197d                	addi	s2,s2,-1
 78a:	ff3918e3          	bne	s2,s3,77a <printint+0x82>
 78e:	7902                	ld	s2,32(sp)
 790:	69e2                	ld	s3,24(sp)
}
 792:	70e2                	ld	ra,56(sp)
 794:	7442                	ld	s0,48(sp)
 796:	74a2                	ld	s1,40(sp)
 798:	6121                	addi	sp,sp,64
 79a:	8082                	ret
    x = -xx;
 79c:	40b005bb          	negw	a1,a1
    neg = 1;
 7a0:	4885                	li	a7,1
    x = -xx;
 7a2:	b7b5                	j	70e <printint+0x16>

00000000000007a4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7a4:	715d                	addi	sp,sp,-80
 7a6:	e486                	sd	ra,72(sp)
 7a8:	e0a2                	sd	s0,64(sp)
 7aa:	f84a                	sd	s2,48(sp)
 7ac:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7ae:	0005c903          	lbu	s2,0(a1)
 7b2:	1a090a63          	beqz	s2,966 <vprintf+0x1c2>
 7b6:	fc26                	sd	s1,56(sp)
 7b8:	f44e                	sd	s3,40(sp)
 7ba:	f052                	sd	s4,32(sp)
 7bc:	ec56                	sd	s5,24(sp)
 7be:	e85a                	sd	s6,16(sp)
 7c0:	e45e                	sd	s7,8(sp)
 7c2:	8aaa                	mv	s5,a0
 7c4:	8bb2                	mv	s7,a2
 7c6:	00158493          	addi	s1,a1,1
  state = 0;
 7ca:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7cc:	02500a13          	li	s4,37
 7d0:	4b55                	li	s6,21
 7d2:	a839                	j	7f0 <vprintf+0x4c>
        putc(fd, c);
 7d4:	85ca                	mv	a1,s2
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	efe080e7          	jalr	-258(ra) # 6d6 <putc>
 7e0:	a019                	j	7e6 <vprintf+0x42>
    } else if(state == '%'){
 7e2:	01498d63          	beq	s3,s4,7fc <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 7e6:	0485                	addi	s1,s1,1
 7e8:	fff4c903          	lbu	s2,-1(s1)
 7ec:	16090763          	beqz	s2,95a <vprintf+0x1b6>
    if(state == 0){
 7f0:	fe0999e3          	bnez	s3,7e2 <vprintf+0x3e>
      if(c == '%'){
 7f4:	ff4910e3          	bne	s2,s4,7d4 <vprintf+0x30>
        state = '%';
 7f8:	89d2                	mv	s3,s4
 7fa:	b7f5                	j	7e6 <vprintf+0x42>
      if(c == 'd'){
 7fc:	13490463          	beq	s2,s4,924 <vprintf+0x180>
 800:	f9d9079b          	addiw	a5,s2,-99
 804:	0ff7f793          	zext.b	a5,a5
 808:	12fb6763          	bltu	s6,a5,936 <vprintf+0x192>
 80c:	f9d9079b          	addiw	a5,s2,-99
 810:	0ff7f713          	zext.b	a4,a5
 814:	12eb6163          	bltu	s6,a4,936 <vprintf+0x192>
 818:	00271793          	slli	a5,a4,0x2
 81c:	00000717          	auipc	a4,0x0
 820:	60c70713          	addi	a4,a4,1548 # e28 <malloc+0x3d2>
 824:	97ba                	add	a5,a5,a4
 826:	439c                	lw	a5,0(a5)
 828:	97ba                	add	a5,a5,a4
 82a:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 82c:	008b8913          	addi	s2,s7,8
 830:	4685                	li	a3,1
 832:	4629                	li	a2,10
 834:	000ba583          	lw	a1,0(s7)
 838:	8556                	mv	a0,s5
 83a:	00000097          	auipc	ra,0x0
 83e:	ebe080e7          	jalr	-322(ra) # 6f8 <printint>
 842:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 844:	4981                	li	s3,0
 846:	b745                	j	7e6 <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 848:	008b8913          	addi	s2,s7,8
 84c:	4681                	li	a3,0
 84e:	4629                	li	a2,10
 850:	000ba583          	lw	a1,0(s7)
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	ea2080e7          	jalr	-350(ra) # 6f8 <printint>
 85e:	8bca                	mv	s7,s2
      state = 0;
 860:	4981                	li	s3,0
 862:	b751                	j	7e6 <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 864:	008b8913          	addi	s2,s7,8
 868:	4681                	li	a3,0
 86a:	4641                	li	a2,16
 86c:	000ba583          	lw	a1,0(s7)
 870:	8556                	mv	a0,s5
 872:	00000097          	auipc	ra,0x0
 876:	e86080e7          	jalr	-378(ra) # 6f8 <printint>
 87a:	8bca                	mv	s7,s2
      state = 0;
 87c:	4981                	li	s3,0
 87e:	b7a5                	j	7e6 <vprintf+0x42>
 880:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 882:	008b8c13          	addi	s8,s7,8
 886:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 88a:	03000593          	li	a1,48
 88e:	8556                	mv	a0,s5
 890:	00000097          	auipc	ra,0x0
 894:	e46080e7          	jalr	-442(ra) # 6d6 <putc>
  putc(fd, 'x');
 898:	07800593          	li	a1,120
 89c:	8556                	mv	a0,s5
 89e:	00000097          	auipc	ra,0x0
 8a2:	e38080e7          	jalr	-456(ra) # 6d6 <putc>
 8a6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8a8:	00000b97          	auipc	s7,0x0
 8ac:	5d8b8b93          	addi	s7,s7,1496 # e80 <digits>
 8b0:	03c9d793          	srli	a5,s3,0x3c
 8b4:	97de                	add	a5,a5,s7
 8b6:	0007c583          	lbu	a1,0(a5)
 8ba:	8556                	mv	a0,s5
 8bc:	00000097          	auipc	ra,0x0
 8c0:	e1a080e7          	jalr	-486(ra) # 6d6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8c4:	0992                	slli	s3,s3,0x4
 8c6:	397d                	addiw	s2,s2,-1
 8c8:	fe0914e3          	bnez	s2,8b0 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 8cc:	8be2                	mv	s7,s8
      state = 0;
 8ce:	4981                	li	s3,0
 8d0:	6c02                	ld	s8,0(sp)
 8d2:	bf11                	j	7e6 <vprintf+0x42>
        s = va_arg(ap, char*);
 8d4:	008b8993          	addi	s3,s7,8
 8d8:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 8dc:	02090163          	beqz	s2,8fe <vprintf+0x15a>
        while(*s != 0){
 8e0:	00094583          	lbu	a1,0(s2)
 8e4:	c9a5                	beqz	a1,954 <vprintf+0x1b0>
          putc(fd, *s);
 8e6:	8556                	mv	a0,s5
 8e8:	00000097          	auipc	ra,0x0
 8ec:	dee080e7          	jalr	-530(ra) # 6d6 <putc>
          s++;
 8f0:	0905                	addi	s2,s2,1
        while(*s != 0){
 8f2:	00094583          	lbu	a1,0(s2)
 8f6:	f9e5                	bnez	a1,8e6 <vprintf+0x142>
        s = va_arg(ap, char*);
 8f8:	8bce                	mv	s7,s3
      state = 0;
 8fa:	4981                	li	s3,0
 8fc:	b5ed                	j	7e6 <vprintf+0x42>
          s = "(null)";
 8fe:	00000917          	auipc	s2,0x0
 902:	52290913          	addi	s2,s2,1314 # e20 <malloc+0x3ca>
        while(*s != 0){
 906:	02800593          	li	a1,40
 90a:	bff1                	j	8e6 <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 90c:	008b8913          	addi	s2,s7,8
 910:	000bc583          	lbu	a1,0(s7)
 914:	8556                	mv	a0,s5
 916:	00000097          	auipc	ra,0x0
 91a:	dc0080e7          	jalr	-576(ra) # 6d6 <putc>
 91e:	8bca                	mv	s7,s2
      state = 0;
 920:	4981                	li	s3,0
 922:	b5d1                	j	7e6 <vprintf+0x42>
        putc(fd, c);
 924:	02500593          	li	a1,37
 928:	8556                	mv	a0,s5
 92a:	00000097          	auipc	ra,0x0
 92e:	dac080e7          	jalr	-596(ra) # 6d6 <putc>
      state = 0;
 932:	4981                	li	s3,0
 934:	bd4d                	j	7e6 <vprintf+0x42>
        putc(fd, '%');
 936:	02500593          	li	a1,37
 93a:	8556                	mv	a0,s5
 93c:	00000097          	auipc	ra,0x0
 940:	d9a080e7          	jalr	-614(ra) # 6d6 <putc>
        putc(fd, c);
 944:	85ca                	mv	a1,s2
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	d8e080e7          	jalr	-626(ra) # 6d6 <putc>
      state = 0;
 950:	4981                	li	s3,0
 952:	bd51                	j	7e6 <vprintf+0x42>
        s = va_arg(ap, char*);
 954:	8bce                	mv	s7,s3
      state = 0;
 956:	4981                	li	s3,0
 958:	b579                	j	7e6 <vprintf+0x42>
 95a:	74e2                	ld	s1,56(sp)
 95c:	79a2                	ld	s3,40(sp)
 95e:	7a02                	ld	s4,32(sp)
 960:	6ae2                	ld	s5,24(sp)
 962:	6b42                	ld	s6,16(sp)
 964:	6ba2                	ld	s7,8(sp)
    }
  }
}
 966:	60a6                	ld	ra,72(sp)
 968:	6406                	ld	s0,64(sp)
 96a:	7942                	ld	s2,48(sp)
 96c:	6161                	addi	sp,sp,80
 96e:	8082                	ret

0000000000000970 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 970:	715d                	addi	sp,sp,-80
 972:	ec06                	sd	ra,24(sp)
 974:	e822                	sd	s0,16(sp)
 976:	1000                	addi	s0,sp,32
 978:	e010                	sd	a2,0(s0)
 97a:	e414                	sd	a3,8(s0)
 97c:	e818                	sd	a4,16(s0)
 97e:	ec1c                	sd	a5,24(s0)
 980:	03043023          	sd	a6,32(s0)
 984:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 988:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 98c:	8622                	mv	a2,s0
 98e:	00000097          	auipc	ra,0x0
 992:	e16080e7          	jalr	-490(ra) # 7a4 <vprintf>
}
 996:	60e2                	ld	ra,24(sp)
 998:	6442                	ld	s0,16(sp)
 99a:	6161                	addi	sp,sp,80
 99c:	8082                	ret

000000000000099e <printf>:

void
printf(const char *fmt, ...)
{
 99e:	711d                	addi	sp,sp,-96
 9a0:	ec06                	sd	ra,24(sp)
 9a2:	e822                	sd	s0,16(sp)
 9a4:	1000                	addi	s0,sp,32
 9a6:	e40c                	sd	a1,8(s0)
 9a8:	e810                	sd	a2,16(s0)
 9aa:	ec14                	sd	a3,24(s0)
 9ac:	f018                	sd	a4,32(s0)
 9ae:	f41c                	sd	a5,40(s0)
 9b0:	03043823          	sd	a6,48(s0)
 9b4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9b8:	00840613          	addi	a2,s0,8
 9bc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9c0:	85aa                	mv	a1,a0
 9c2:	4505                	li	a0,1
 9c4:	00000097          	auipc	ra,0x0
 9c8:	de0080e7          	jalr	-544(ra) # 7a4 <vprintf>
}
 9cc:	60e2                	ld	ra,24(sp)
 9ce:	6442                	ld	s0,16(sp)
 9d0:	6125                	addi	sp,sp,96
 9d2:	8082                	ret

00000000000009d4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9d4:	1141                	addi	sp,sp,-16
 9d6:	e422                	sd	s0,8(sp)
 9d8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9da:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9de:	00001797          	auipc	a5,0x1
 9e2:	a127b783          	ld	a5,-1518(a5) # 13f0 <freep>
 9e6:	a02d                	j	a10 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9e8:	4618                	lw	a4,8(a2)
 9ea:	9f2d                	addw	a4,a4,a1
 9ec:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9f0:	6398                	ld	a4,0(a5)
 9f2:	6310                	ld	a2,0(a4)
 9f4:	a83d                	j	a32 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9f6:	ff852703          	lw	a4,-8(a0)
 9fa:	9f31                	addw	a4,a4,a2
 9fc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9fe:	ff053683          	ld	a3,-16(a0)
 a02:	a091                	j	a46 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a04:	6398                	ld	a4,0(a5)
 a06:	00e7e463          	bltu	a5,a4,a0e <free+0x3a>
 a0a:	00e6ea63          	bltu	a3,a4,a1e <free+0x4a>
{
 a0e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a10:	fed7fae3          	bgeu	a5,a3,a04 <free+0x30>
 a14:	6398                	ld	a4,0(a5)
 a16:	00e6e463          	bltu	a3,a4,a1e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a1a:	fee7eae3          	bltu	a5,a4,a0e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 a1e:	ff852583          	lw	a1,-8(a0)
 a22:	6390                	ld	a2,0(a5)
 a24:	02059813          	slli	a6,a1,0x20
 a28:	01c85713          	srli	a4,a6,0x1c
 a2c:	9736                	add	a4,a4,a3
 a2e:	fae60de3          	beq	a2,a4,9e8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 a32:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a36:	4790                	lw	a2,8(a5)
 a38:	02061593          	slli	a1,a2,0x20
 a3c:	01c5d713          	srli	a4,a1,0x1c
 a40:	973e                	add	a4,a4,a5
 a42:	fae68ae3          	beq	a3,a4,9f6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 a46:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a48:	00001717          	auipc	a4,0x1
 a4c:	9af73423          	sd	a5,-1624(a4) # 13f0 <freep>
}
 a50:	6422                	ld	s0,8(sp)
 a52:	0141                	addi	sp,sp,16
 a54:	8082                	ret

0000000000000a56 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a56:	7139                	addi	sp,sp,-64
 a58:	fc06                	sd	ra,56(sp)
 a5a:	f822                	sd	s0,48(sp)
 a5c:	f426                	sd	s1,40(sp)
 a5e:	ec4e                	sd	s3,24(sp)
 a60:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a62:	02051493          	slli	s1,a0,0x20
 a66:	9081                	srli	s1,s1,0x20
 a68:	04bd                	addi	s1,s1,15
 a6a:	8091                	srli	s1,s1,0x4
 a6c:	0014899b          	addiw	s3,s1,1
 a70:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a72:	00001517          	auipc	a0,0x1
 a76:	97e53503          	ld	a0,-1666(a0) # 13f0 <freep>
 a7a:	c915                	beqz	a0,aae <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a7c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a7e:	4798                	lw	a4,8(a5)
 a80:	08977e63          	bgeu	a4,s1,b1c <malloc+0xc6>
 a84:	f04a                	sd	s2,32(sp)
 a86:	e852                	sd	s4,16(sp)
 a88:	e456                	sd	s5,8(sp)
 a8a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a8c:	8a4e                	mv	s4,s3
 a8e:	0009871b          	sext.w	a4,s3
 a92:	6685                	lui	a3,0x1
 a94:	00d77363          	bgeu	a4,a3,a9a <malloc+0x44>
 a98:	6a05                	lui	s4,0x1
 a9a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a9e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 aa2:	00001917          	auipc	s2,0x1
 aa6:	94e90913          	addi	s2,s2,-1714 # 13f0 <freep>
  if(p == (char*)-1)
 aaa:	5afd                	li	s5,-1
 aac:	a091                	j	af0 <malloc+0x9a>
 aae:	f04a                	sd	s2,32(sp)
 ab0:	e852                	sd	s4,16(sp)
 ab2:	e456                	sd	s5,8(sp)
 ab4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 ab6:	00001797          	auipc	a5,0x1
 aba:	94a78793          	addi	a5,a5,-1718 # 1400 <base>
 abe:	00001717          	auipc	a4,0x1
 ac2:	92f73923          	sd	a5,-1742(a4) # 13f0 <freep>
 ac6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ac8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 acc:	b7c1                	j	a8c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 ace:	6398                	ld	a4,0(a5)
 ad0:	e118                	sd	a4,0(a0)
 ad2:	a08d                	j	b34 <malloc+0xde>
  hp->s.size = nu;
 ad4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ad8:	0541                	addi	a0,a0,16
 ada:	00000097          	auipc	ra,0x0
 ade:	efa080e7          	jalr	-262(ra) # 9d4 <free>
  return freep;
 ae2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ae6:	c13d                	beqz	a0,b4c <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ae8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aea:	4798                	lw	a4,8(a5)
 aec:	02977463          	bgeu	a4,s1,b14 <malloc+0xbe>
    if(p == freep)
 af0:	00093703          	ld	a4,0(s2)
 af4:	853e                	mv	a0,a5
 af6:	fef719e3          	bne	a4,a5,ae8 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 afa:	8552                	mv	a0,s4
 afc:	00000097          	auipc	ra,0x0
 b00:	ba2080e7          	jalr	-1118(ra) # 69e <sbrk>
  if(p == (char*)-1)
 b04:	fd5518e3          	bne	a0,s5,ad4 <malloc+0x7e>
        return 0;
 b08:	4501                	li	a0,0
 b0a:	7902                	ld	s2,32(sp)
 b0c:	6a42                	ld	s4,16(sp)
 b0e:	6aa2                	ld	s5,8(sp)
 b10:	6b02                	ld	s6,0(sp)
 b12:	a03d                	j	b40 <malloc+0xea>
 b14:	7902                	ld	s2,32(sp)
 b16:	6a42                	ld	s4,16(sp)
 b18:	6aa2                	ld	s5,8(sp)
 b1a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b1c:	fae489e3          	beq	s1,a4,ace <malloc+0x78>
        p->s.size -= nunits;
 b20:	4137073b          	subw	a4,a4,s3
 b24:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b26:	02071693          	slli	a3,a4,0x20
 b2a:	01c6d713          	srli	a4,a3,0x1c
 b2e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b30:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b34:	00001717          	auipc	a4,0x1
 b38:	8aa73e23          	sd	a0,-1860(a4) # 13f0 <freep>
      return (void*)(p + 1);
 b3c:	01078513          	addi	a0,a5,16
  }
}
 b40:	70e2                	ld	ra,56(sp)
 b42:	7442                	ld	s0,48(sp)
 b44:	74a2                	ld	s1,40(sp)
 b46:	69e2                	ld	s3,24(sp)
 b48:	6121                	addi	sp,sp,64
 b4a:	8082                	ret
 b4c:	7902                	ld	s2,32(sp)
 b4e:	6a42                	ld	s4,16(sp)
 b50:	6aa2                	ld	s5,8(sp)
 b52:	6b02                	ld	s6,0(sp)
 b54:	b7f5                	j	b40 <malloc+0xea>
