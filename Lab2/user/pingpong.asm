
user/_pingpong:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
    for(int id = 1; id < SEM_MAX; id++)
        if(sem_open(id, value) != 0) return id;
    return 0;
}

int main(int argc, char *argv[]){
   0:	715d                	addi	sp,sp,-80
   2:	e486                	sd	ra,72(sp)
   4:	e0a2                	sd	s0,64(sp)
   6:	0880                	addi	s0,sp,80
    //Logica de verficiacion previa.
    if (argc != 2){
   8:	4789                	li	a5,2
   a:	02f50763          	beq	a0,a5,38 <main+0x38>
   e:	fc26                	sd	s1,56(sp)
  10:	f84a                	sd	s2,48(sp)
  12:	f44e                	sd	s3,40(sp)
  14:	f052                	sd	s4,32(sp)
  16:	ec56                	sd	s5,24(sp)
  18:	e85a                	sd	s6,16(sp)
  1a:	e45e                	sd	s7,8(sp)
        fprintf(2, "ERROR: cantidad de elementos invaldias.\n");
  1c:	00001597          	auipc	a1,0x1
  20:	95458593          	addi	a1,a1,-1708 # 970 <malloc+0x106>
  24:	4509                	li	a0,2
  26:	00000097          	auipc	ra,0x0
  2a:	75e080e7          	jalr	1886(ra) # 784 <fprintf>
        exit(1);
  2e:	4505                	li	a0,1
  30:	00000097          	auipc	ra,0x0
  34:	3fa080e7          	jalr	1018(ra) # 42a <exit>
  38:	fc26                	sd	s1,56(sp)
  3a:	f84a                	sd	s2,48(sp)
  3c:	f052                	sd	s4,32(sp)
    }
    int n = atoi(argv[1]);
  3e:	6588                	ld	a0,8(a1)
  40:	00000097          	auipc	ra,0x0
  44:	2f0080e7          	jalr	752(ra) # 330 <atoi>
  48:	8a2a                	mv	s4,a0
    for(int id = 1; id < SEM_MAX; id++)
  4a:	4485                	li	s1,1
  4c:	04100913          	li	s2,65

    if(n < 1){
  50:	04a05c63          	blez	a0,a8 <main+0xa8>
  54:	f44e                	sd	s3,40(sp)
  56:	ec56                	sd	s5,24(sp)
  58:	e85a                	sd	s6,16(sp)
  5a:	e45e                	sd	s7,8(sp)
        if(sem_open(id, value) != 0) return id;
  5c:	4585                	li	a1,1
  5e:	8526                	mv	a0,s1
  60:	00000097          	auipc	ra,0x0
  64:	46a080e7          	jalr	1130(ra) # 4ca <sem_open>
  68:	e509                	bnez	a0,72 <main+0x72>
    for(int id = 1; id < SEM_MAX; id++)
  6a:	2485                	addiw	s1,s1,1
  6c:	ff2498e3          	bne	s1,s2,5c <main+0x5c>
    return 0;
  70:	84aa                	mv	s1,a0
    for(int id = 1; id < SEM_MAX; id++)
  72:	4905                	li	s2,1
  74:	04100993          	li	s3,65
        if(sem_open(id, value) != 0) return id;
  78:	4581                	li	a1,0
  7a:	854a                	mv	a0,s2
  7c:	00000097          	auipc	ra,0x0
  80:	44e080e7          	jalr	1102(ra) # 4ca <sem_open>
  84:	e521                	bnez	a0,cc <main+0xcc>
    for(int id = 1; id < SEM_MAX; id++)
  86:	2905                	addiw	s2,s2,1
  88:	ff3918e3          	bne	s2,s3,78 <main+0x78>
        exit(1);
    }
    int sem_ping = sem_libre(1); //Semaforo de ping
    int sem_pong = sem_libre(0); //Semaforo de pong
    if(sem_ping <= 0 || sem_pong <= 0){
        fprintf(2,"ERROR: Id de semaforos invalida");
  8c:	00001597          	auipc	a1,0x1
  90:	93c58593          	addi	a1,a1,-1732 # 9c8 <malloc+0x15e>
  94:	4509                	li	a0,2
  96:	00000097          	auipc	ra,0x0
  9a:	6ee080e7          	jalr	1774(ra) # 784 <fprintf>
        exit(1);
  9e:	4505                	li	a0,1
  a0:	00000097          	auipc	ra,0x0
  a4:	38a080e7          	jalr	906(ra) # 42a <exit>
  a8:	f44e                	sd	s3,40(sp)
  aa:	ec56                	sd	s5,24(sp)
  ac:	e85a                	sd	s6,16(sp)
  ae:	e45e                	sd	s7,8(sp)
        fprintf(2, "ERROR: cantidad de pingpongs invalida.\n");
  b0:	00001597          	auipc	a1,0x1
  b4:	8f058593          	addi	a1,a1,-1808 # 9a0 <malloc+0x136>
  b8:	4509                	li	a0,2
  ba:	00000097          	auipc	ra,0x0
  be:	6ca080e7          	jalr	1738(ra) # 784 <fprintf>
        exit(1);
  c2:	4505                	li	a0,1
  c4:	00000097          	auipc	ra,0x0
  c8:	366080e7          	jalr	870(ra) # 42a <exit>
    if(sem_ping <= 0 || sem_pong <= 0){
  cc:	fc9050e3          	blez	s1,8c <main+0x8c>
  d0:	fb205ee3          	blez	s2,8c <main+0x8c>
    }
    int pid = fork();
  d4:	00000097          	auipc	ra,0x0
  d8:	34e080e7          	jalr	846(ra) # 422 <fork>
  dc:	8aaa                	mv	s5,a0
        fprintf(2, "ERROR: Falló el fork\n");
        sem_close(sem_ping);
        sem_close(sem_pong);
        exit(1);
    }
    for(int i = 0; i < n; i++){
  de:	4981                	li	s3,0
    if (pid < 0) {
  e0:	00054b63          	bltz	a0,f6 <main+0xf6>
            sem_down(sem_pong);
            printf("pong\n");
            sem_up(sem_ping);
        }else {
            sem_down(sem_ping);
            printf("ping\n");
  e4:	00001b97          	auipc	s7,0x1
  e8:	924b8b93          	addi	s7,s7,-1756 # a08 <malloc+0x19e>
            printf("pong\n");
  ec:	00001b17          	auipc	s6,0x1
  f0:	914b0b13          	addi	s6,s6,-1772 # a00 <malloc+0x196>
  f4:	a899                	j	14a <main+0x14a>
        fprintf(2, "ERROR: Falló el fork\n");
  f6:	00001597          	auipc	a1,0x1
  fa:	8f258593          	addi	a1,a1,-1806 # 9e8 <malloc+0x17e>
  fe:	4509                	li	a0,2
 100:	00000097          	auipc	ra,0x0
 104:	684080e7          	jalr	1668(ra) # 784 <fprintf>
        sem_close(sem_ping);
 108:	8526                	mv	a0,s1
 10a:	00000097          	auipc	ra,0x0
 10e:	3c8080e7          	jalr	968(ra) # 4d2 <sem_close>
        sem_close(sem_pong);
 112:	854a                	mv	a0,s2
 114:	00000097          	auipc	ra,0x0
 118:	3be080e7          	jalr	958(ra) # 4d2 <sem_close>
        exit(1);
 11c:	4505                	li	a0,1
 11e:	00000097          	auipc	ra,0x0
 122:	30c080e7          	jalr	780(ra) # 42a <exit>
            sem_down(sem_ping);
 126:	8526                	mv	a0,s1
 128:	00000097          	auipc	ra,0x0
 12c:	3ba080e7          	jalr	954(ra) # 4e2 <sem_down>
            printf("ping\n");
 130:	855e                	mv	a0,s7
 132:	00000097          	auipc	ra,0x0
 136:	680080e7          	jalr	1664(ra) # 7b2 <printf>
            sem_up(sem_pong);
 13a:	854a                	mv	a0,s2
 13c:	00000097          	auipc	ra,0x0
 140:	39e080e7          	jalr	926(ra) # 4da <sem_up>
    for(int i = 0; i < n; i++){
 144:	2985                	addiw	s3,s3,1
 146:	033a0463          	beq	s4,s3,16e <main+0x16e>
        if(pid == 0){
 14a:	fc0a9ee3          	bnez	s5,126 <main+0x126>
            sem_down(sem_pong);
 14e:	854a                	mv	a0,s2
 150:	00000097          	auipc	ra,0x0
 154:	392080e7          	jalr	914(ra) # 4e2 <sem_down>
            printf("pong\n");
 158:	855a                	mv	a0,s6
 15a:	00000097          	auipc	ra,0x0
 15e:	658080e7          	jalr	1624(ra) # 7b2 <printf>
            sem_up(sem_ping);
 162:	8526                	mv	a0,s1
 164:	00000097          	auipc	ra,0x0
 168:	376080e7          	jalr	886(ra) # 4da <sem_up>
 16c:	bfe1                	j	144 <main+0x144>
        }
    }
    if(pid == 0) exit(0);
 16e:	000a9763          	bnez	s5,17c <main+0x17c>
 172:	4501                	li	a0,0
 174:	00000097          	auipc	ra,0x0
 178:	2b6080e7          	jalr	694(ra) # 42a <exit>
    wait(0);
 17c:	4501                	li	a0,0
 17e:	00000097          	auipc	ra,0x0
 182:	2b4080e7          	jalr	692(ra) # 432 <wait>
    sem_close(sem_ping);
 186:	8526                	mv	a0,s1
 188:	00000097          	auipc	ra,0x0
 18c:	34a080e7          	jalr	842(ra) # 4d2 <sem_close>
    sem_close(sem_pong);
 190:	854a                	mv	a0,s2
 192:	00000097          	auipc	ra,0x0
 196:	340080e7          	jalr	832(ra) # 4d2 <sem_close>
    exit(0);
 19a:	4501                	li	a0,0
 19c:	00000097          	auipc	ra,0x0
 1a0:	28e080e7          	jalr	654(ra) # 42a <exit>

00000000000001a4 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 1a4:	1141                	addi	sp,sp,-16
 1a6:	e406                	sd	ra,8(sp)
 1a8:	e022                	sd	s0,0(sp)
 1aa:	0800                	addi	s0,sp,16
  extern int main();
  main();
 1ac:	00000097          	auipc	ra,0x0
 1b0:	e54080e7          	jalr	-428(ra) # 0 <main>
  exit(0);
 1b4:	4501                	li	a0,0
 1b6:	00000097          	auipc	ra,0x0
 1ba:	274080e7          	jalr	628(ra) # 42a <exit>

00000000000001be <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e422                	sd	s0,8(sp)
 1c2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1c4:	87aa                	mv	a5,a0
 1c6:	0585                	addi	a1,a1,1
 1c8:	0785                	addi	a5,a5,1
 1ca:	fff5c703          	lbu	a4,-1(a1)
 1ce:	fee78fa3          	sb	a4,-1(a5)
 1d2:	fb75                	bnez	a4,1c6 <strcpy+0x8>
    ;
  return os;
}
 1d4:	6422                	ld	s0,8(sp)
 1d6:	0141                	addi	sp,sp,16
 1d8:	8082                	ret

00000000000001da <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1da:	1141                	addi	sp,sp,-16
 1dc:	e422                	sd	s0,8(sp)
 1de:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1e0:	00054783          	lbu	a5,0(a0)
 1e4:	cb91                	beqz	a5,1f8 <strcmp+0x1e>
 1e6:	0005c703          	lbu	a4,0(a1)
 1ea:	00f71763          	bne	a4,a5,1f8 <strcmp+0x1e>
    p++, q++;
 1ee:	0505                	addi	a0,a0,1
 1f0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	fbe5                	bnez	a5,1e6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 1f8:	0005c503          	lbu	a0,0(a1)
}
 1fc:	40a7853b          	subw	a0,a5,a0
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret

0000000000000206 <strlen>:

uint
strlen(const char *s)
{
 206:	1141                	addi	sp,sp,-16
 208:	e422                	sd	s0,8(sp)
 20a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 20c:	00054783          	lbu	a5,0(a0)
 210:	cf91                	beqz	a5,22c <strlen+0x26>
 212:	0505                	addi	a0,a0,1
 214:	87aa                	mv	a5,a0
 216:	86be                	mv	a3,a5
 218:	0785                	addi	a5,a5,1
 21a:	fff7c703          	lbu	a4,-1(a5)
 21e:	ff65                	bnez	a4,216 <strlen+0x10>
 220:	40a6853b          	subw	a0,a3,a0
 224:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 226:	6422                	ld	s0,8(sp)
 228:	0141                	addi	sp,sp,16
 22a:	8082                	ret
  for(n = 0; s[n]; n++)
 22c:	4501                	li	a0,0
 22e:	bfe5                	j	226 <strlen+0x20>

0000000000000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 236:	ca19                	beqz	a2,24c <memset+0x1c>
 238:	87aa                	mv	a5,a0
 23a:	1602                	slli	a2,a2,0x20
 23c:	9201                	srli	a2,a2,0x20
 23e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 242:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 246:	0785                	addi	a5,a5,1
 248:	fee79de3          	bne	a5,a4,242 <memset+0x12>
  }
  return dst;
}
 24c:	6422                	ld	s0,8(sp)
 24e:	0141                	addi	sp,sp,16
 250:	8082                	ret

0000000000000252 <strchr>:

char*
strchr(const char *s, char c)
{
 252:	1141                	addi	sp,sp,-16
 254:	e422                	sd	s0,8(sp)
 256:	0800                	addi	s0,sp,16
  for(; *s; s++)
 258:	00054783          	lbu	a5,0(a0)
 25c:	cb99                	beqz	a5,272 <strchr+0x20>
    if(*s == c)
 25e:	00f58763          	beq	a1,a5,26c <strchr+0x1a>
  for(; *s; s++)
 262:	0505                	addi	a0,a0,1
 264:	00054783          	lbu	a5,0(a0)
 268:	fbfd                	bnez	a5,25e <strchr+0xc>
      return (char*)s;
  return 0;
 26a:	4501                	li	a0,0
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
  return 0;
 272:	4501                	li	a0,0
 274:	bfe5                	j	26c <strchr+0x1a>

0000000000000276 <gets>:

char*
gets(char *buf, int max)
{
 276:	711d                	addi	sp,sp,-96
 278:	ec86                	sd	ra,88(sp)
 27a:	e8a2                	sd	s0,80(sp)
 27c:	e4a6                	sd	s1,72(sp)
 27e:	e0ca                	sd	s2,64(sp)
 280:	fc4e                	sd	s3,56(sp)
 282:	f852                	sd	s4,48(sp)
 284:	f456                	sd	s5,40(sp)
 286:	f05a                	sd	s6,32(sp)
 288:	ec5e                	sd	s7,24(sp)
 28a:	1080                	addi	s0,sp,96
 28c:	8baa                	mv	s7,a0
 28e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 290:	892a                	mv	s2,a0
 292:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 294:	4aa9                	li	s5,10
 296:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 298:	89a6                	mv	s3,s1
 29a:	2485                	addiw	s1,s1,1
 29c:	0344d863          	bge	s1,s4,2cc <gets+0x56>
    cc = read(0, &c, 1);
 2a0:	4605                	li	a2,1
 2a2:	faf40593          	addi	a1,s0,-81
 2a6:	4501                	li	a0,0
 2a8:	00000097          	auipc	ra,0x0
 2ac:	19a080e7          	jalr	410(ra) # 442 <read>
    if(cc < 1)
 2b0:	00a05e63          	blez	a0,2cc <gets+0x56>
    buf[i++] = c;
 2b4:	faf44783          	lbu	a5,-81(s0)
 2b8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2bc:	01578763          	beq	a5,s5,2ca <gets+0x54>
 2c0:	0905                	addi	s2,s2,1
 2c2:	fd679be3          	bne	a5,s6,298 <gets+0x22>
    buf[i++] = c;
 2c6:	89a6                	mv	s3,s1
 2c8:	a011                	j	2cc <gets+0x56>
 2ca:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 2cc:	99de                	add	s3,s3,s7
 2ce:	00098023          	sb	zero,0(s3)
  return buf;
}
 2d2:	855e                	mv	a0,s7
 2d4:	60e6                	ld	ra,88(sp)
 2d6:	6446                	ld	s0,80(sp)
 2d8:	64a6                	ld	s1,72(sp)
 2da:	6906                	ld	s2,64(sp)
 2dc:	79e2                	ld	s3,56(sp)
 2de:	7a42                	ld	s4,48(sp)
 2e0:	7aa2                	ld	s5,40(sp)
 2e2:	7b02                	ld	s6,32(sp)
 2e4:	6be2                	ld	s7,24(sp)
 2e6:	6125                	addi	sp,sp,96
 2e8:	8082                	ret

00000000000002ea <stat>:

int
stat(const char *n, struct stat *st)
{
 2ea:	1101                	addi	sp,sp,-32
 2ec:	ec06                	sd	ra,24(sp)
 2ee:	e822                	sd	s0,16(sp)
 2f0:	e04a                	sd	s2,0(sp)
 2f2:	1000                	addi	s0,sp,32
 2f4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f6:	4581                	li	a1,0
 2f8:	00000097          	auipc	ra,0x0
 2fc:	172080e7          	jalr	370(ra) # 46a <open>
  if(fd < 0)
 300:	02054663          	bltz	a0,32c <stat+0x42>
 304:	e426                	sd	s1,8(sp)
 306:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 308:	85ca                	mv	a1,s2
 30a:	00000097          	auipc	ra,0x0
 30e:	178080e7          	jalr	376(ra) # 482 <fstat>
 312:	892a                	mv	s2,a0
  close(fd);
 314:	8526                	mv	a0,s1
 316:	00000097          	auipc	ra,0x0
 31a:	13c080e7          	jalr	316(ra) # 452 <close>
  return r;
 31e:	64a2                	ld	s1,8(sp)
}
 320:	854a                	mv	a0,s2
 322:	60e2                	ld	ra,24(sp)
 324:	6442                	ld	s0,16(sp)
 326:	6902                	ld	s2,0(sp)
 328:	6105                	addi	sp,sp,32
 32a:	8082                	ret
    return -1;
 32c:	597d                	li	s2,-1
 32e:	bfcd                	j	320 <stat+0x36>

0000000000000330 <atoi>:

int
atoi(const char *s)
{
 330:	1141                	addi	sp,sp,-16
 332:	e422                	sd	s0,8(sp)
 334:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 336:	00054683          	lbu	a3,0(a0)
 33a:	fd06879b          	addiw	a5,a3,-48
 33e:	0ff7f793          	zext.b	a5,a5
 342:	4625                	li	a2,9
 344:	02f66863          	bltu	a2,a5,374 <atoi+0x44>
 348:	872a                	mv	a4,a0
  n = 0;
 34a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 34c:	0705                	addi	a4,a4,1
 34e:	0025179b          	slliw	a5,a0,0x2
 352:	9fa9                	addw	a5,a5,a0
 354:	0017979b          	slliw	a5,a5,0x1
 358:	9fb5                	addw	a5,a5,a3
 35a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 35e:	00074683          	lbu	a3,0(a4)
 362:	fd06879b          	addiw	a5,a3,-48
 366:	0ff7f793          	zext.b	a5,a5
 36a:	fef671e3          	bgeu	a2,a5,34c <atoi+0x1c>
  return n;
}
 36e:	6422                	ld	s0,8(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  n = 0;
 374:	4501                	li	a0,0
 376:	bfe5                	j	36e <atoi+0x3e>

0000000000000378 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e422                	sd	s0,8(sp)
 37c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 37e:	02b57463          	bgeu	a0,a1,3a6 <memmove+0x2e>
    while(n-- > 0)
 382:	00c05f63          	blez	a2,3a0 <memmove+0x28>
 386:	1602                	slli	a2,a2,0x20
 388:	9201                	srli	a2,a2,0x20
 38a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 38e:	872a                	mv	a4,a0
      *dst++ = *src++;
 390:	0585                	addi	a1,a1,1
 392:	0705                	addi	a4,a4,1
 394:	fff5c683          	lbu	a3,-1(a1)
 398:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 39c:	fef71ae3          	bne	a4,a5,390 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 3a0:	6422                	ld	s0,8(sp)
 3a2:	0141                	addi	sp,sp,16
 3a4:	8082                	ret
    dst += n;
 3a6:	00c50733          	add	a4,a0,a2
    src += n;
 3aa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3ac:	fec05ae3          	blez	a2,3a0 <memmove+0x28>
 3b0:	fff6079b          	addiw	a5,a2,-1
 3b4:	1782                	slli	a5,a5,0x20
 3b6:	9381                	srli	a5,a5,0x20
 3b8:	fff7c793          	not	a5,a5
 3bc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3be:	15fd                	addi	a1,a1,-1
 3c0:	177d                	addi	a4,a4,-1
 3c2:	0005c683          	lbu	a3,0(a1)
 3c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3ca:	fee79ae3          	bne	a5,a4,3be <memmove+0x46>
 3ce:	bfc9                	j	3a0 <memmove+0x28>

00000000000003d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3d0:	1141                	addi	sp,sp,-16
 3d2:	e422                	sd	s0,8(sp)
 3d4:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3d6:	ca05                	beqz	a2,406 <memcmp+0x36>
 3d8:	fff6069b          	addiw	a3,a2,-1
 3dc:	1682                	slli	a3,a3,0x20
 3de:	9281                	srli	a3,a3,0x20
 3e0:	0685                	addi	a3,a3,1
 3e2:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3e4:	00054783          	lbu	a5,0(a0)
 3e8:	0005c703          	lbu	a4,0(a1)
 3ec:	00e79863          	bne	a5,a4,3fc <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 3f0:	0505                	addi	a0,a0,1
    p2++;
 3f2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3f4:	fed518e3          	bne	a0,a3,3e4 <memcmp+0x14>
  }
  return 0;
 3f8:	4501                	li	a0,0
 3fa:	a019                	j	400 <memcmp+0x30>
      return *p1 - *p2;
 3fc:	40e7853b          	subw	a0,a5,a4
}
 400:	6422                	ld	s0,8(sp)
 402:	0141                	addi	sp,sp,16
 404:	8082                	ret
  return 0;
 406:	4501                	li	a0,0
 408:	bfe5                	j	400 <memcmp+0x30>

000000000000040a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 40a:	1141                	addi	sp,sp,-16
 40c:	e406                	sd	ra,8(sp)
 40e:	e022                	sd	s0,0(sp)
 410:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 412:	00000097          	auipc	ra,0x0
 416:	f66080e7          	jalr	-154(ra) # 378 <memmove>
}
 41a:	60a2                	ld	ra,8(sp)
 41c:	6402                	ld	s0,0(sp)
 41e:	0141                	addi	sp,sp,16
 420:	8082                	ret

0000000000000422 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 422:	4885                	li	a7,1
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <exit>:
.global exit
exit:
 li a7, SYS_exit
 42a:	4889                	li	a7,2
 ecall
 42c:	00000073          	ecall
 ret
 430:	8082                	ret

0000000000000432 <wait>:
.global wait
wait:
 li a7, SYS_wait
 432:	488d                	li	a7,3
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 43a:	4891                	li	a7,4
 ecall
 43c:	00000073          	ecall
 ret
 440:	8082                	ret

0000000000000442 <read>:
.global read
read:
 li a7, SYS_read
 442:	4895                	li	a7,5
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <write>:
.global write
write:
 li a7, SYS_write
 44a:	48c1                	li	a7,16
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <close>:
.global close
close:
 li a7, SYS_close
 452:	48d5                	li	a7,21
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <kill>:
.global kill
kill:
 li a7, SYS_kill
 45a:	4899                	li	a7,6
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <exec>:
.global exec
exec:
 li a7, SYS_exec
 462:	489d                	li	a7,7
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <open>:
.global open
open:
 li a7, SYS_open
 46a:	48bd                	li	a7,15
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 472:	48c5                	li	a7,17
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 47a:	48c9                	li	a7,18
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 482:	48a1                	li	a7,8
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <link>:
.global link
link:
 li a7, SYS_link
 48a:	48cd                	li	a7,19
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 492:	48d1                	li	a7,20
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 49a:	48a5                	li	a7,9
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a2:	48a9                	li	a7,10
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4aa:	48ad                	li	a7,11
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 4b2:	48b1                	li	a7,12
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 4ba:	48b5                	li	a7,13
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c2:	48b9                	li	a7,14
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 4ca:	48d9                	li	a7,22
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 4d2:	48dd                	li	a7,23
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <sem_up>:
.global sem_up
sem_up:
 li a7, SYS_sem_up
 4da:	48e1                	li	a7,24
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <sem_down>:
.global sem_down
sem_down:
 li a7, SYS_sem_down
 4e2:	48e5                	li	a7,25
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ea:	1101                	addi	sp,sp,-32
 4ec:	ec06                	sd	ra,24(sp)
 4ee:	e822                	sd	s0,16(sp)
 4f0:	1000                	addi	s0,sp,32
 4f2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4f6:	4605                	li	a2,1
 4f8:	fef40593          	addi	a1,s0,-17
 4fc:	00000097          	auipc	ra,0x0
 500:	f4e080e7          	jalr	-178(ra) # 44a <write>
}
 504:	60e2                	ld	ra,24(sp)
 506:	6442                	ld	s0,16(sp)
 508:	6105                	addi	sp,sp,32
 50a:	8082                	ret

000000000000050c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 50c:	7139                	addi	sp,sp,-64
 50e:	fc06                	sd	ra,56(sp)
 510:	f822                	sd	s0,48(sp)
 512:	f426                	sd	s1,40(sp)
 514:	0080                	addi	s0,sp,64
 516:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 518:	c299                	beqz	a3,51e <printint+0x12>
 51a:	0805cb63          	bltz	a1,5b0 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 51e:	2581                	sext.w	a1,a1
  neg = 0;
 520:	4881                	li	a7,0
 522:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 526:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 528:	2601                	sext.w	a2,a2
 52a:	00000517          	auipc	a0,0x0
 52e:	54650513          	addi	a0,a0,1350 # a70 <digits>
 532:	883a                	mv	a6,a4
 534:	2705                	addiw	a4,a4,1
 536:	02c5f7bb          	remuw	a5,a1,a2
 53a:	1782                	slli	a5,a5,0x20
 53c:	9381                	srli	a5,a5,0x20
 53e:	97aa                	add	a5,a5,a0
 540:	0007c783          	lbu	a5,0(a5)
 544:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 548:	0005879b          	sext.w	a5,a1
 54c:	02c5d5bb          	divuw	a1,a1,a2
 550:	0685                	addi	a3,a3,1
 552:	fec7f0e3          	bgeu	a5,a2,532 <printint+0x26>
  if(neg)
 556:	00088c63          	beqz	a7,56e <printint+0x62>
    buf[i++] = '-';
 55a:	fd070793          	addi	a5,a4,-48
 55e:	00878733          	add	a4,a5,s0
 562:	02d00793          	li	a5,45
 566:	fef70823          	sb	a5,-16(a4)
 56a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 56e:	02e05c63          	blez	a4,5a6 <printint+0x9a>
 572:	f04a                	sd	s2,32(sp)
 574:	ec4e                	sd	s3,24(sp)
 576:	fc040793          	addi	a5,s0,-64
 57a:	00e78933          	add	s2,a5,a4
 57e:	fff78993          	addi	s3,a5,-1
 582:	99ba                	add	s3,s3,a4
 584:	377d                	addiw	a4,a4,-1
 586:	1702                	slli	a4,a4,0x20
 588:	9301                	srli	a4,a4,0x20
 58a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 58e:	fff94583          	lbu	a1,-1(s2)
 592:	8526                	mv	a0,s1
 594:	00000097          	auipc	ra,0x0
 598:	f56080e7          	jalr	-170(ra) # 4ea <putc>
  while(--i >= 0)
 59c:	197d                	addi	s2,s2,-1
 59e:	ff3918e3          	bne	s2,s3,58e <printint+0x82>
 5a2:	7902                	ld	s2,32(sp)
 5a4:	69e2                	ld	s3,24(sp)
}
 5a6:	70e2                	ld	ra,56(sp)
 5a8:	7442                	ld	s0,48(sp)
 5aa:	74a2                	ld	s1,40(sp)
 5ac:	6121                	addi	sp,sp,64
 5ae:	8082                	ret
    x = -xx;
 5b0:	40b005bb          	negw	a1,a1
    neg = 1;
 5b4:	4885                	li	a7,1
    x = -xx;
 5b6:	b7b5                	j	522 <printint+0x16>

00000000000005b8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5b8:	715d                	addi	sp,sp,-80
 5ba:	e486                	sd	ra,72(sp)
 5bc:	e0a2                	sd	s0,64(sp)
 5be:	f84a                	sd	s2,48(sp)
 5c0:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5c2:	0005c903          	lbu	s2,0(a1)
 5c6:	1a090a63          	beqz	s2,77a <vprintf+0x1c2>
 5ca:	fc26                	sd	s1,56(sp)
 5cc:	f44e                	sd	s3,40(sp)
 5ce:	f052                	sd	s4,32(sp)
 5d0:	ec56                	sd	s5,24(sp)
 5d2:	e85a                	sd	s6,16(sp)
 5d4:	e45e                	sd	s7,8(sp)
 5d6:	8aaa                	mv	s5,a0
 5d8:	8bb2                	mv	s7,a2
 5da:	00158493          	addi	s1,a1,1
  state = 0;
 5de:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5e0:	02500a13          	li	s4,37
 5e4:	4b55                	li	s6,21
 5e6:	a839                	j	604 <vprintf+0x4c>
        putc(fd, c);
 5e8:	85ca                	mv	a1,s2
 5ea:	8556                	mv	a0,s5
 5ec:	00000097          	auipc	ra,0x0
 5f0:	efe080e7          	jalr	-258(ra) # 4ea <putc>
 5f4:	a019                	j	5fa <vprintf+0x42>
    } else if(state == '%'){
 5f6:	01498d63          	beq	s3,s4,610 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 5fa:	0485                	addi	s1,s1,1
 5fc:	fff4c903          	lbu	s2,-1(s1)
 600:	16090763          	beqz	s2,76e <vprintf+0x1b6>
    if(state == 0){
 604:	fe0999e3          	bnez	s3,5f6 <vprintf+0x3e>
      if(c == '%'){
 608:	ff4910e3          	bne	s2,s4,5e8 <vprintf+0x30>
        state = '%';
 60c:	89d2                	mv	s3,s4
 60e:	b7f5                	j	5fa <vprintf+0x42>
      if(c == 'd'){
 610:	13490463          	beq	s2,s4,738 <vprintf+0x180>
 614:	f9d9079b          	addiw	a5,s2,-99
 618:	0ff7f793          	zext.b	a5,a5
 61c:	12fb6763          	bltu	s6,a5,74a <vprintf+0x192>
 620:	f9d9079b          	addiw	a5,s2,-99
 624:	0ff7f713          	zext.b	a4,a5
 628:	12eb6163          	bltu	s6,a4,74a <vprintf+0x192>
 62c:	00271793          	slli	a5,a4,0x2
 630:	00000717          	auipc	a4,0x0
 634:	3e870713          	addi	a4,a4,1000 # a18 <malloc+0x1ae>
 638:	97ba                	add	a5,a5,a4
 63a:	439c                	lw	a5,0(a5)
 63c:	97ba                	add	a5,a5,a4
 63e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 640:	008b8913          	addi	s2,s7,8
 644:	4685                	li	a3,1
 646:	4629                	li	a2,10
 648:	000ba583          	lw	a1,0(s7)
 64c:	8556                	mv	a0,s5
 64e:	00000097          	auipc	ra,0x0
 652:	ebe080e7          	jalr	-322(ra) # 50c <printint>
 656:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 658:	4981                	li	s3,0
 65a:	b745                	j	5fa <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 65c:	008b8913          	addi	s2,s7,8
 660:	4681                	li	a3,0
 662:	4629                	li	a2,10
 664:	000ba583          	lw	a1,0(s7)
 668:	8556                	mv	a0,s5
 66a:	00000097          	auipc	ra,0x0
 66e:	ea2080e7          	jalr	-350(ra) # 50c <printint>
 672:	8bca                	mv	s7,s2
      state = 0;
 674:	4981                	li	s3,0
 676:	b751                	j	5fa <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 678:	008b8913          	addi	s2,s7,8
 67c:	4681                	li	a3,0
 67e:	4641                	li	a2,16
 680:	000ba583          	lw	a1,0(s7)
 684:	8556                	mv	a0,s5
 686:	00000097          	auipc	ra,0x0
 68a:	e86080e7          	jalr	-378(ra) # 50c <printint>
 68e:	8bca                	mv	s7,s2
      state = 0;
 690:	4981                	li	s3,0
 692:	b7a5                	j	5fa <vprintf+0x42>
 694:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 696:	008b8c13          	addi	s8,s7,8
 69a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 69e:	03000593          	li	a1,48
 6a2:	8556                	mv	a0,s5
 6a4:	00000097          	auipc	ra,0x0
 6a8:	e46080e7          	jalr	-442(ra) # 4ea <putc>
  putc(fd, 'x');
 6ac:	07800593          	li	a1,120
 6b0:	8556                	mv	a0,s5
 6b2:	00000097          	auipc	ra,0x0
 6b6:	e38080e7          	jalr	-456(ra) # 4ea <putc>
 6ba:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6bc:	00000b97          	auipc	s7,0x0
 6c0:	3b4b8b93          	addi	s7,s7,948 # a70 <digits>
 6c4:	03c9d793          	srli	a5,s3,0x3c
 6c8:	97de                	add	a5,a5,s7
 6ca:	0007c583          	lbu	a1,0(a5)
 6ce:	8556                	mv	a0,s5
 6d0:	00000097          	auipc	ra,0x0
 6d4:	e1a080e7          	jalr	-486(ra) # 4ea <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d8:	0992                	slli	s3,s3,0x4
 6da:	397d                	addiw	s2,s2,-1
 6dc:	fe0914e3          	bnez	s2,6c4 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 6e0:	8be2                	mv	s7,s8
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	6c02                	ld	s8,0(sp)
 6e6:	bf11                	j	5fa <vprintf+0x42>
        s = va_arg(ap, char*);
 6e8:	008b8993          	addi	s3,s7,8
 6ec:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 6f0:	02090163          	beqz	s2,712 <vprintf+0x15a>
        while(*s != 0){
 6f4:	00094583          	lbu	a1,0(s2)
 6f8:	c9a5                	beqz	a1,768 <vprintf+0x1b0>
          putc(fd, *s);
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	dee080e7          	jalr	-530(ra) # 4ea <putc>
          s++;
 704:	0905                	addi	s2,s2,1
        while(*s != 0){
 706:	00094583          	lbu	a1,0(s2)
 70a:	f9e5                	bnez	a1,6fa <vprintf+0x142>
        s = va_arg(ap, char*);
 70c:	8bce                	mv	s7,s3
      state = 0;
 70e:	4981                	li	s3,0
 710:	b5ed                	j	5fa <vprintf+0x42>
          s = "(null)";
 712:	00000917          	auipc	s2,0x0
 716:	2fe90913          	addi	s2,s2,766 # a10 <malloc+0x1a6>
        while(*s != 0){
 71a:	02800593          	li	a1,40
 71e:	bff1                	j	6fa <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 720:	008b8913          	addi	s2,s7,8
 724:	000bc583          	lbu	a1,0(s7)
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	dc0080e7          	jalr	-576(ra) # 4ea <putc>
 732:	8bca                	mv	s7,s2
      state = 0;
 734:	4981                	li	s3,0
 736:	b5d1                	j	5fa <vprintf+0x42>
        putc(fd, c);
 738:	02500593          	li	a1,37
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	dac080e7          	jalr	-596(ra) # 4ea <putc>
      state = 0;
 746:	4981                	li	s3,0
 748:	bd4d                	j	5fa <vprintf+0x42>
        putc(fd, '%');
 74a:	02500593          	li	a1,37
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	d9a080e7          	jalr	-614(ra) # 4ea <putc>
        putc(fd, c);
 758:	85ca                	mv	a1,s2
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	d8e080e7          	jalr	-626(ra) # 4ea <putc>
      state = 0;
 764:	4981                	li	s3,0
 766:	bd51                	j	5fa <vprintf+0x42>
        s = va_arg(ap, char*);
 768:	8bce                	mv	s7,s3
      state = 0;
 76a:	4981                	li	s3,0
 76c:	b579                	j	5fa <vprintf+0x42>
 76e:	74e2                	ld	s1,56(sp)
 770:	79a2                	ld	s3,40(sp)
 772:	7a02                	ld	s4,32(sp)
 774:	6ae2                	ld	s5,24(sp)
 776:	6b42                	ld	s6,16(sp)
 778:	6ba2                	ld	s7,8(sp)
    }
  }
}
 77a:	60a6                	ld	ra,72(sp)
 77c:	6406                	ld	s0,64(sp)
 77e:	7942                	ld	s2,48(sp)
 780:	6161                	addi	sp,sp,80
 782:	8082                	ret

0000000000000784 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 784:	715d                	addi	sp,sp,-80
 786:	ec06                	sd	ra,24(sp)
 788:	e822                	sd	s0,16(sp)
 78a:	1000                	addi	s0,sp,32
 78c:	e010                	sd	a2,0(s0)
 78e:	e414                	sd	a3,8(s0)
 790:	e818                	sd	a4,16(s0)
 792:	ec1c                	sd	a5,24(s0)
 794:	03043023          	sd	a6,32(s0)
 798:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 79c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a0:	8622                	mv	a2,s0
 7a2:	00000097          	auipc	ra,0x0
 7a6:	e16080e7          	jalr	-490(ra) # 5b8 <vprintf>
}
 7aa:	60e2                	ld	ra,24(sp)
 7ac:	6442                	ld	s0,16(sp)
 7ae:	6161                	addi	sp,sp,80
 7b0:	8082                	ret

00000000000007b2 <printf>:

void
printf(const char *fmt, ...)
{
 7b2:	711d                	addi	sp,sp,-96
 7b4:	ec06                	sd	ra,24(sp)
 7b6:	e822                	sd	s0,16(sp)
 7b8:	1000                	addi	s0,sp,32
 7ba:	e40c                	sd	a1,8(s0)
 7bc:	e810                	sd	a2,16(s0)
 7be:	ec14                	sd	a3,24(s0)
 7c0:	f018                	sd	a4,32(s0)
 7c2:	f41c                	sd	a5,40(s0)
 7c4:	03043823          	sd	a6,48(s0)
 7c8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7cc:	00840613          	addi	a2,s0,8
 7d0:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7d4:	85aa                	mv	a1,a0
 7d6:	4505                	li	a0,1
 7d8:	00000097          	auipc	ra,0x0
 7dc:	de0080e7          	jalr	-544(ra) # 5b8 <vprintf>
}
 7e0:	60e2                	ld	ra,24(sp)
 7e2:	6442                	ld	s0,16(sp)
 7e4:	6125                	addi	sp,sp,96
 7e6:	8082                	ret

00000000000007e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e8:	1141                	addi	sp,sp,-16
 7ea:	e422                	sd	s0,8(sp)
 7ec:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ee:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f2:	00001797          	auipc	a5,0x1
 7f6:	c1e7b783          	ld	a5,-994(a5) # 1410 <freep>
 7fa:	a02d                	j	824 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7fc:	4618                	lw	a4,8(a2)
 7fe:	9f2d                	addw	a4,a4,a1
 800:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 804:	6398                	ld	a4,0(a5)
 806:	6310                	ld	a2,0(a4)
 808:	a83d                	j	846 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 80a:	ff852703          	lw	a4,-8(a0)
 80e:	9f31                	addw	a4,a4,a2
 810:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 812:	ff053683          	ld	a3,-16(a0)
 816:	a091                	j	85a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 818:	6398                	ld	a4,0(a5)
 81a:	00e7e463          	bltu	a5,a4,822 <free+0x3a>
 81e:	00e6ea63          	bltu	a3,a4,832 <free+0x4a>
{
 822:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 824:	fed7fae3          	bgeu	a5,a3,818 <free+0x30>
 828:	6398                	ld	a4,0(a5)
 82a:	00e6e463          	bltu	a3,a4,832 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82e:	fee7eae3          	bltu	a5,a4,822 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 832:	ff852583          	lw	a1,-8(a0)
 836:	6390                	ld	a2,0(a5)
 838:	02059813          	slli	a6,a1,0x20
 83c:	01c85713          	srli	a4,a6,0x1c
 840:	9736                	add	a4,a4,a3
 842:	fae60de3          	beq	a2,a4,7fc <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 846:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 84a:	4790                	lw	a2,8(a5)
 84c:	02061593          	slli	a1,a2,0x20
 850:	01c5d713          	srli	a4,a1,0x1c
 854:	973e                	add	a4,a4,a5
 856:	fae68ae3          	beq	a3,a4,80a <free+0x22>
    p->s.ptr = bp->s.ptr;
 85a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 85c:	00001717          	auipc	a4,0x1
 860:	baf73a23          	sd	a5,-1100(a4) # 1410 <freep>
}
 864:	6422                	ld	s0,8(sp)
 866:	0141                	addi	sp,sp,16
 868:	8082                	ret

000000000000086a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 86a:	7139                	addi	sp,sp,-64
 86c:	fc06                	sd	ra,56(sp)
 86e:	f822                	sd	s0,48(sp)
 870:	f426                	sd	s1,40(sp)
 872:	ec4e                	sd	s3,24(sp)
 874:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 876:	02051493          	slli	s1,a0,0x20
 87a:	9081                	srli	s1,s1,0x20
 87c:	04bd                	addi	s1,s1,15
 87e:	8091                	srli	s1,s1,0x4
 880:	0014899b          	addiw	s3,s1,1
 884:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 886:	00001517          	auipc	a0,0x1
 88a:	b8a53503          	ld	a0,-1142(a0) # 1410 <freep>
 88e:	c915                	beqz	a0,8c2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 890:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 892:	4798                	lw	a4,8(a5)
 894:	08977e63          	bgeu	a4,s1,930 <malloc+0xc6>
 898:	f04a                	sd	s2,32(sp)
 89a:	e852                	sd	s4,16(sp)
 89c:	e456                	sd	s5,8(sp)
 89e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8a0:	8a4e                	mv	s4,s3
 8a2:	0009871b          	sext.w	a4,s3
 8a6:	6685                	lui	a3,0x1
 8a8:	00d77363          	bgeu	a4,a3,8ae <malloc+0x44>
 8ac:	6a05                	lui	s4,0x1
 8ae:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8b2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8b6:	00001917          	auipc	s2,0x1
 8ba:	b5a90913          	addi	s2,s2,-1190 # 1410 <freep>
  if(p == (char*)-1)
 8be:	5afd                	li	s5,-1
 8c0:	a091                	j	904 <malloc+0x9a>
 8c2:	f04a                	sd	s2,32(sp)
 8c4:	e852                	sd	s4,16(sp)
 8c6:	e456                	sd	s5,8(sp)
 8c8:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8ca:	00001797          	auipc	a5,0x1
 8ce:	b5678793          	addi	a5,a5,-1194 # 1420 <base>
 8d2:	00001717          	auipc	a4,0x1
 8d6:	b2f73f23          	sd	a5,-1218(a4) # 1410 <freep>
 8da:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8dc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8e0:	b7c1                	j	8a0 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 8e2:	6398                	ld	a4,0(a5)
 8e4:	e118                	sd	a4,0(a0)
 8e6:	a08d                	j	948 <malloc+0xde>
  hp->s.size = nu;
 8e8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ec:	0541                	addi	a0,a0,16
 8ee:	00000097          	auipc	ra,0x0
 8f2:	efa080e7          	jalr	-262(ra) # 7e8 <free>
  return freep;
 8f6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 8fa:	c13d                	beqz	a0,960 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8fe:	4798                	lw	a4,8(a5)
 900:	02977463          	bgeu	a4,s1,928 <malloc+0xbe>
    if(p == freep)
 904:	00093703          	ld	a4,0(s2)
 908:	853e                	mv	a0,a5
 90a:	fef719e3          	bne	a4,a5,8fc <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 90e:	8552                	mv	a0,s4
 910:	00000097          	auipc	ra,0x0
 914:	ba2080e7          	jalr	-1118(ra) # 4b2 <sbrk>
  if(p == (char*)-1)
 918:	fd5518e3          	bne	a0,s5,8e8 <malloc+0x7e>
        return 0;
 91c:	4501                	li	a0,0
 91e:	7902                	ld	s2,32(sp)
 920:	6a42                	ld	s4,16(sp)
 922:	6aa2                	ld	s5,8(sp)
 924:	6b02                	ld	s6,0(sp)
 926:	a03d                	j	954 <malloc+0xea>
 928:	7902                	ld	s2,32(sp)
 92a:	6a42                	ld	s4,16(sp)
 92c:	6aa2                	ld	s5,8(sp)
 92e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 930:	fae489e3          	beq	s1,a4,8e2 <malloc+0x78>
        p->s.size -= nunits;
 934:	4137073b          	subw	a4,a4,s3
 938:	c798                	sw	a4,8(a5)
        p += p->s.size;
 93a:	02071693          	slli	a3,a4,0x20
 93e:	01c6d713          	srli	a4,a3,0x1c
 942:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 944:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 948:	00001717          	auipc	a4,0x1
 94c:	aca73423          	sd	a0,-1336(a4) # 1410 <freep>
      return (void*)(p + 1);
 950:	01078513          	addi	a0,a5,16
  }
}
 954:	70e2                	ld	ra,56(sp)
 956:	7442                	ld	s0,48(sp)
 958:	74a2                	ld	s1,40(sp)
 95a:	69e2                	ld	s3,24(sp)
 95c:	6121                	addi	sp,sp,64
 95e:	8082                	ret
 960:	7902                	ld	s2,32(sp)
 962:	6a42                	ld	s4,16(sp)
 964:	6aa2                	ld	s5,8(sp)
 966:	6b02                	ld	s6,0(sp)
 968:	b7f5                	j	954 <malloc+0xea>
