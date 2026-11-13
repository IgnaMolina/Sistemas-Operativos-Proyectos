
user/_prodcons:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sem_libre>:
#define SEM_MAX 65   // ids válidos: 1..64

static int sem_empty, sem_full, sem_mutex;

// Busca un id libre probando sem_open; devuelve el id o 0 si no hay.
static int sem_libre(int value){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	892a                	mv	s2,a0
    for(int id = 1; id < SEM_MAX; id++)
  10:	4485                	li	s1,1
  12:	04100993          	li	s3,65
        if(sem_open(id, value) != 0) return id;
  16:	85ca                	mv	a1,s2
  18:	8526                	mv	a0,s1
  1a:	00000097          	auipc	ra,0x0
  1e:	724080e7          	jalr	1828(ra) # 73e <sem_open>
  22:	e509                	bnez	a0,2c <sem_libre+0x2c>
    for(int id = 1; id < SEM_MAX; id++)
  24:	2485                	addiw	s1,s1,1
  26:	ff3498e3          	bne	s1,s3,16 <sem_libre+0x16>
    return 0;
  2a:	84aa                	mv	s1,a0
}
  2c:	8526                	mv	a0,s1
  2e:	70a2                	ld	ra,40(sp)
  30:	7402                	ld	s0,32(sp)
  32:	64e2                	ld	s1,24(sp)
  34:	6942                	ld	s2,16(sp)
  36:	69a2                	ld	s3,8(sp)
  38:	6145                	addi	sp,sp,48
  3a:	8082                	ret

000000000000003c <producir>:

static void producir(int n){
    for(int j = 1; j <= n; j++){
  3c:	08a05e63          	blez	a0,d8 <producir+0x9c>
static void producir(int n){
  40:	7139                	addi	sp,sp,-64
  42:	fc06                	sd	ra,56(sp)
  44:	f822                	sd	s0,48(sp)
  46:	f426                	sd	s1,40(sp)
  48:	f04a                	sd	s2,32(sp)
  4a:	ec4e                	sd	s3,24(sp)
  4c:	e852                	sd	s4,16(sp)
  4e:	e456                	sd	s5,8(sp)
  50:	e05a                	sd	s6,0(sp)
  52:	0080                	addi	s0,sp,64
  54:	89aa                	mv	s3,a0
    for(int j = 1; j <= n; j++){
  56:	4485                	li	s1,1
        sem_down(sem_empty);
  58:	00001b17          	auipc	s6,0x1
  5c:	460b0b13          	addi	s6,s6,1120 # 14b8 <sem_empty>
        sem_down(sem_mutex);
  60:	00001917          	auipc	s2,0x1
  64:	45090913          	addi	s2,s2,1104 # 14b0 <sem_mutex>
        printf("produce %d pid=%d\n", j, getpid());
  68:	00001a97          	auipc	s5,0x1
  6c:	b78a8a93          	addi	s5,s5,-1160 # be0 <malloc+0x102>
        sem_up(sem_mutex);
        sem_up(sem_full);
  70:	00001a17          	auipc	s4,0x1
  74:	444a0a13          	addi	s4,s4,1092 # 14b4 <sem_full>
        sem_down(sem_empty);
  78:	000b2503          	lw	a0,0(s6)
  7c:	00000097          	auipc	ra,0x0
  80:	6da080e7          	jalr	1754(ra) # 756 <sem_down>
        sem_down(sem_mutex);
  84:	00092503          	lw	a0,0(s2)
  88:	00000097          	auipc	ra,0x0
  8c:	6ce080e7          	jalr	1742(ra) # 756 <sem_down>
        printf("produce %d pid=%d\n", j, getpid());
  90:	00000097          	auipc	ra,0x0
  94:	68e080e7          	jalr	1678(ra) # 71e <getpid>
  98:	862a                	mv	a2,a0
  9a:	85a6                	mv	a1,s1
  9c:	8556                	mv	a0,s5
  9e:	00001097          	auipc	ra,0x1
  a2:	988080e7          	jalr	-1656(ra) # a26 <printf>
        sem_up(sem_mutex);
  a6:	00092503          	lw	a0,0(s2)
  aa:	00000097          	auipc	ra,0x0
  ae:	6a4080e7          	jalr	1700(ra) # 74e <sem_up>
        sem_up(sem_full);
  b2:	000a2503          	lw	a0,0(s4)
  b6:	00000097          	auipc	ra,0x0
  ba:	698080e7          	jalr	1688(ra) # 74e <sem_up>
    for(int j = 1; j <= n; j++){
  be:	2485                	addiw	s1,s1,1
  c0:	fa99dce3          	bge	s3,s1,78 <producir+0x3c>
    }
}
  c4:	70e2                	ld	ra,56(sp)
  c6:	7442                	ld	s0,48(sp)
  c8:	74a2                	ld	s1,40(sp)
  ca:	7902                	ld	s2,32(sp)
  cc:	69e2                	ld	s3,24(sp)
  ce:	6a42                	ld	s4,16(sp)
  d0:	6aa2                	ld	s5,8(sp)
  d2:	6b02                	ld	s6,0(sp)
  d4:	6121                	addi	sp,sp,64
  d6:	8082                	ret
  d8:	8082                	ret

00000000000000da <consumir>:

static void consumir(int n){
    for(int j = 1; j <= n; j++){
  da:	08a05d63          	blez	a0,174 <consumir+0x9a>
static void consumir(int n){
  de:	7139                	addi	sp,sp,-64
  e0:	fc06                	sd	ra,56(sp)
  e2:	f822                	sd	s0,48(sp)
  e4:	f426                	sd	s1,40(sp)
  e6:	f04a                	sd	s2,32(sp)
  e8:	ec4e                	sd	s3,24(sp)
  ea:	e852                	sd	s4,16(sp)
  ec:	e456                	sd	s5,8(sp)
  ee:	e05a                	sd	s6,0(sp)
  f0:	0080                	addi	s0,sp,64
  f2:	89aa                	mv	s3,a0
    for(int j = 1; j <= n; j++){
  f4:	4485                	li	s1,1
        sem_down(sem_full);
  f6:	00001b17          	auipc	s6,0x1
  fa:	3beb0b13          	addi	s6,s6,958 # 14b4 <sem_full>
        sem_down(sem_mutex);
  fe:	00001917          	auipc	s2,0x1
 102:	3b290913          	addi	s2,s2,946 # 14b0 <sem_mutex>
        printf("consume pid=%d\n", getpid());
 106:	00001a97          	auipc	s5,0x1
 10a:	af2a8a93          	addi	s5,s5,-1294 # bf8 <malloc+0x11a>
        sem_up(sem_mutex);
        sem_up(sem_empty);
 10e:	00001a17          	auipc	s4,0x1
 112:	3aaa0a13          	addi	s4,s4,938 # 14b8 <sem_empty>
        sem_down(sem_full);
 116:	000b2503          	lw	a0,0(s6)
 11a:	00000097          	auipc	ra,0x0
 11e:	63c080e7          	jalr	1596(ra) # 756 <sem_down>
        sem_down(sem_mutex);
 122:	00092503          	lw	a0,0(s2)
 126:	00000097          	auipc	ra,0x0
 12a:	630080e7          	jalr	1584(ra) # 756 <sem_down>
        printf("consume pid=%d\n", getpid());
 12e:	00000097          	auipc	ra,0x0
 132:	5f0080e7          	jalr	1520(ra) # 71e <getpid>
 136:	85aa                	mv	a1,a0
 138:	8556                	mv	a0,s5
 13a:	00001097          	auipc	ra,0x1
 13e:	8ec080e7          	jalr	-1812(ra) # a26 <printf>
        sem_up(sem_mutex);
 142:	00092503          	lw	a0,0(s2)
 146:	00000097          	auipc	ra,0x0
 14a:	608080e7          	jalr	1544(ra) # 74e <sem_up>
        sem_up(sem_empty);
 14e:	000a2503          	lw	a0,0(s4)
 152:	00000097          	auipc	ra,0x0
 156:	5fc080e7          	jalr	1532(ra) # 74e <sem_up>
    for(int j = 1; j <= n; j++){
 15a:	2485                	addiw	s1,s1,1
 15c:	fa99dde3          	bge	s3,s1,116 <consumir+0x3c>
    }
}
 160:	70e2                	ld	ra,56(sp)
 162:	7442                	ld	s0,48(sp)
 164:	74a2                	ld	s1,40(sp)
 166:	7902                	ld	s2,32(sp)
 168:	69e2                	ld	s3,24(sp)
 16a:	6a42                	ld	s4,16(sp)
 16c:	6aa2                	ld	s5,8(sp)
 16e:	6b02                	ld	s6,0(sp)
 170:	6121                	addi	sp,sp,64
 172:	8082                	ret
 174:	8082                	ret

0000000000000176 <main>:

int main(int argc, char *argv[]) {
 176:	7139                	addi	sp,sp,-64
 178:	fc06                	sd	ra,56(sp)
 17a:	f822                	sd	s0,48(sp)
 17c:	0080                	addi	s0,sp,64
    if(argc != 3 && argc != 5){
 17e:	ffd5079b          	addiw	a5,a0,-3
 182:	9bf5                	andi	a5,a5,-3
 184:	2781                	sext.w	a5,a5
 186:	c78d                	beqz	a5,1b0 <main+0x3a>
 188:	f426                	sd	s1,40(sp)
 18a:	f04a                	sd	s2,32(sp)
 18c:	ec4e                	sd	s3,24(sp)
 18e:	e852                	sd	s4,16(sp)
 190:	e456                	sd	s5,8(sp)
 192:	e05a                	sd	s6,0(sp)
        fprintf(2, "ERROR: uso: prodcons B N | prodcons B N P C\n");
 194:	00001597          	auipc	a1,0x1
 198:	a7458593          	addi	a1,a1,-1420 # c08 <malloc+0x12a>
 19c:	4509                	li	a0,2
 19e:	00001097          	auipc	ra,0x1
 1a2:	85a080e7          	jalr	-1958(ra) # 9f8 <fprintf>
        exit(1);
 1a6:	4505                	li	a0,1
 1a8:	00000097          	auipc	ra,0x0
 1ac:	4f6080e7          	jalr	1270(ra) # 69e <exit>
 1b0:	f426                	sd	s1,40(sp)
 1b2:	f04a                	sd	s2,32(sp)
 1b4:	ec4e                	sd	s3,24(sp)
 1b6:	e852                	sd	s4,16(sp)
 1b8:	89aa                	mv	s3,a0
 1ba:	84ae                	mv	s1,a1
    }

    int B = atoi(argv[1]);
 1bc:	6588                	ld	a0,8(a1)
 1be:	00000097          	auipc	ra,0x0
 1c2:	3e6080e7          	jalr	998(ra) # 5a4 <atoi>
 1c6:	892a                	mv	s2,a0
    int N = atoi(argv[2]);
 1c8:	6888                	ld	a0,16(s1)
 1ca:	00000097          	auipc	ra,0x0
 1ce:	3da080e7          	jalr	986(ra) # 5a4 <atoi>
 1d2:	8a2a                	mv	s4,a0
    if(B < 1 || N < 1){
 1d4:	09205c63          	blez	s2,26c <main+0xf6>
 1d8:	08a05a63          	blez	a0,26c <main+0xf6>
 1dc:	e456                	sd	s5,8(sp)
 1de:	e05a                	sd	s6,0(sp)
        fprintf(2, "ERROR: B y N deben ser enteros >= 1\n");
        exit(1);
    }

    int P = 1, C = 1;
    if(argc == 5){
 1e0:	4795                	li	a5,5
 1e2:	0af98563          	beq	s3,a5,28c <main+0x116>
    int P = 1, C = 1;
 1e6:	4b05                	li	s6,1
 1e8:	4a85                	li	s5,1
            fprintf(2, "ERROR: P y C deben ser >= 1\n");
            exit(1);
        }
    }

    sem_empty = sem_libre(B);
 1ea:	854a                	mv	a0,s2
 1ec:	00000097          	auipc	ra,0x0
 1f0:	e14080e7          	jalr	-492(ra) # 0 <sem_libre>
 1f4:	00001497          	auipc	s1,0x1
 1f8:	2c448493          	addi	s1,s1,708 # 14b8 <sem_empty>
 1fc:	c088                	sw	a0,0(s1)
    sem_full  = sem_libre(0);
 1fe:	4501                	li	a0,0
 200:	00000097          	auipc	ra,0x0
 204:	e00080e7          	jalr	-512(ra) # 0 <sem_libre>
 208:	00001797          	auipc	a5,0x1
 20c:	2aa7a623          	sw	a0,684(a5) # 14b4 <sem_full>
    sem_mutex = sem_libre(1);
 210:	4505                	li	a0,1
 212:	00000097          	auipc	ra,0x0
 216:	dee080e7          	jalr	-530(ra) # 0 <sem_libre>
 21a:	00001797          	auipc	a5,0x1
 21e:	28a7ab23          	sw	a0,662(a5) # 14b0 <sem_mutex>
    if(sem_empty == 0 || sem_full == 0 || sem_mutex == 0){
 222:	409c                	lw	a5,0(s1)
 224:	c799                	beqz	a5,232 <main+0xbc>
 226:	00001797          	auipc	a5,0x1
 22a:	28e7a783          	lw	a5,654(a5) # 14b4 <sem_full>
 22e:	c391                	beqz	a5,232 <main+0xbc>
 230:	e95d                	bnez	a0,2e6 <main+0x170>
        fprintf(2, "ERROR: no hay semaforos libres\n");
 232:	00001597          	auipc	a1,0x1
 236:	a4e58593          	addi	a1,a1,-1458 # c80 <malloc+0x1a2>
 23a:	4509                	li	a0,2
 23c:	00000097          	auipc	ra,0x0
 240:	7bc080e7          	jalr	1980(ra) # 9f8 <fprintf>
        if(sem_empty) sem_close(sem_empty);
 244:	00001517          	auipc	a0,0x1
 248:	27452503          	lw	a0,628(a0) # 14b8 <sem_empty>
 24c:	ed35                	bnez	a0,2c8 <main+0x152>
        if(sem_full)  sem_close(sem_full);
 24e:	00001517          	auipc	a0,0x1
 252:	26652503          	lw	a0,614(a0) # 14b4 <sem_full>
 256:	ed35                	bnez	a0,2d2 <main+0x15c>
        if(sem_mutex) sem_close(sem_mutex);
 258:	00001517          	auipc	a0,0x1
 25c:	25852503          	lw	a0,600(a0) # 14b0 <sem_mutex>
 260:	ed35                	bnez	a0,2dc <main+0x166>
        exit(1);
 262:	4505                	li	a0,1
 264:	00000097          	auipc	ra,0x0
 268:	43a080e7          	jalr	1082(ra) # 69e <exit>
 26c:	e456                	sd	s5,8(sp)
 26e:	e05a                	sd	s6,0(sp)
        fprintf(2, "ERROR: B y N deben ser enteros >= 1\n");
 270:	00001597          	auipc	a1,0x1
 274:	9c858593          	addi	a1,a1,-1592 # c38 <malloc+0x15a>
 278:	4509                	li	a0,2
 27a:	00000097          	auipc	ra,0x0
 27e:	77e080e7          	jalr	1918(ra) # 9f8 <fprintf>
        exit(1);
 282:	4505                	li	a0,1
 284:	00000097          	auipc	ra,0x0
 288:	41a080e7          	jalr	1050(ra) # 69e <exit>
        P = atoi(argv[3]);
 28c:	6c88                	ld	a0,24(s1)
 28e:	00000097          	auipc	ra,0x0
 292:	316080e7          	jalr	790(ra) # 5a4 <atoi>
 296:	8aaa                	mv	s5,a0
        C = atoi(argv[4]);
 298:	7088                	ld	a0,32(s1)
 29a:	00000097          	auipc	ra,0x0
 29e:	30a080e7          	jalr	778(ra) # 5a4 <atoi>
 2a2:	8b2a                	mv	s6,a0
        if(P < 1 || C < 1){
 2a4:	01505463          	blez	s5,2ac <main+0x136>
 2a8:	f4a041e3          	bgtz	a0,1ea <main+0x74>
            fprintf(2, "ERROR: P y C deben ser >= 1\n");
 2ac:	00001597          	auipc	a1,0x1
 2b0:	9b458593          	addi	a1,a1,-1612 # c60 <malloc+0x182>
 2b4:	4509                	li	a0,2
 2b6:	00000097          	auipc	ra,0x0
 2ba:	742080e7          	jalr	1858(ra) # 9f8 <fprintf>
            exit(1);
 2be:	4505                	li	a0,1
 2c0:	00000097          	auipc	ra,0x0
 2c4:	3de080e7          	jalr	990(ra) # 69e <exit>
        if(sem_empty) sem_close(sem_empty);
 2c8:	00000097          	auipc	ra,0x0
 2cc:	47e080e7          	jalr	1150(ra) # 746 <sem_close>
 2d0:	bfbd                	j	24e <main+0xd8>
        if(sem_full)  sem_close(sem_full);
 2d2:	00000097          	auipc	ra,0x0
 2d6:	474080e7          	jalr	1140(ra) # 746 <sem_close>
 2da:	bfbd                	j	258 <main+0xe2>
        if(sem_mutex) sem_close(sem_mutex);
 2dc:	00000097          	auipc	ra,0x0
 2e0:	46a080e7          	jalr	1130(ra) # 746 <sem_close>
 2e4:	bfbd                	j	262 <main+0xec>
    }

    if(argc == 3){
 2e6:	478d                	li	a5,3
        }
        producir(N);
        wait(0);
    } else {
        // Modo estrella (solo con 4 argumentos): P productores y C consumidores.
        for(int i = 0; i < P; i++){
 2e8:	4481                	li	s1,0
    if(argc == 3){
 2ea:	08f98163          	beq	s3,a5,36c <main+0x1f6>
            if(fork() == 0){
 2ee:	00000097          	auipc	ra,0x0
 2f2:	3a8080e7          	jalr	936(ra) # 696 <fork>
 2f6:	c569                	beqz	a0,3c0 <main+0x24a>
        for(int i = 0; i < P; i++){
 2f8:	0014891b          	addiw	s2,s1,1
 2fc:	0009049b          	sext.w	s1,s2
 300:	fe9a97e3          	bne	s5,s1,2ee <main+0x178>
                producir(i == P - 1 ? N - (N/P)*(P-1) : N/P);
                exit(0);
            }
        }
        for(int i = 0; i < C; i++){
 304:	4481                	li	s1,0
            if(fork() == 0){
 306:	00000097          	auipc	ra,0x0
 30a:	390080e7          	jalr	912(ra) # 696 <fork>
 30e:	cd79                	beqz	a0,3ec <main+0x276>
        for(int i = 0; i < C; i++){
 310:	0014879b          	addiw	a5,s1,1
 314:	0007849b          	sext.w	s1,a5
 318:	fe9b17e3          	bne	s6,s1,306 <main+0x190>
                consumir(i == C - 1 ? N - (N/C)*(C-1) : N/C);
                exit(0);
            }
        }
        for(int i = 0; i < P + C; i++)
 31c:	012784bb          	addw	s1,a5,s2
 320:	4901                	li	s2,0
            wait(0);
 322:	4501                	li	a0,0
 324:	00000097          	auipc	ra,0x0
 328:	382080e7          	jalr	898(ra) # 6a6 <wait>
        for(int i = 0; i < P + C; i++)
 32c:	2905                	addiw	s2,s2,1
 32e:	fe991ae3          	bne	s2,s1,322 <main+0x1ac>
    }

    sem_close(sem_empty);
 332:	00001517          	auipc	a0,0x1
 336:	18652503          	lw	a0,390(a0) # 14b8 <sem_empty>
 33a:	00000097          	auipc	ra,0x0
 33e:	40c080e7          	jalr	1036(ra) # 746 <sem_close>
    sem_close(sem_full);
 342:	00001517          	auipc	a0,0x1
 346:	17252503          	lw	a0,370(a0) # 14b4 <sem_full>
 34a:	00000097          	auipc	ra,0x0
 34e:	3fc080e7          	jalr	1020(ra) # 746 <sem_close>
    sem_close(sem_mutex);
 352:	00001517          	auipc	a0,0x1
 356:	15e52503          	lw	a0,350(a0) # 14b0 <sem_mutex>
 35a:	00000097          	auipc	ra,0x0
 35e:	3ec080e7          	jalr	1004(ra) # 746 <sem_close>
    exit(0);
 362:	4501                	li	a0,0
 364:	00000097          	auipc	ra,0x0
 368:	33a080e7          	jalr	826(ra) # 69e <exit>
        int pid = fork();
 36c:	00000097          	auipc	ra,0x0
 370:	32a080e7          	jalr	810(ra) # 696 <fork>
        if(pid < 0){
 374:	00054d63          	bltz	a0,38e <main+0x218>
        if(pid == 0){
 378:	e90d                	bnez	a0,3aa <main+0x234>
            consumir(N);
 37a:	8552                	mv	a0,s4
 37c:	00000097          	auipc	ra,0x0
 380:	d5e080e7          	jalr	-674(ra) # da <consumir>
            exit(0);
 384:	4501                	li	a0,0
 386:	00000097          	auipc	ra,0x0
 38a:	318080e7          	jalr	792(ra) # 69e <exit>
            fprintf(2, "ERROR: fallo el fork\n");
 38e:	00001597          	auipc	a1,0x1
 392:	91258593          	addi	a1,a1,-1774 # ca0 <malloc+0x1c2>
 396:	4509                	li	a0,2
 398:	00000097          	auipc	ra,0x0
 39c:	660080e7          	jalr	1632(ra) # 9f8 <fprintf>
            exit(1);
 3a0:	4505                	li	a0,1
 3a2:	00000097          	auipc	ra,0x0
 3a6:	2fc080e7          	jalr	764(ra) # 69e <exit>
        producir(N);
 3aa:	8552                	mv	a0,s4
 3ac:	00000097          	auipc	ra,0x0
 3b0:	c90080e7          	jalr	-880(ra) # 3c <producir>
        wait(0);
 3b4:	4501                	li	a0,0
 3b6:	00000097          	auipc	ra,0x0
 3ba:	2f0080e7          	jalr	752(ra) # 6a6 <wait>
 3be:	bf95                	j	332 <main+0x1bc>
                producir(i == P - 1 ? N - (N/P)*(P-1) : N/P);
 3c0:	fffa879b          	addiw	a5,s5,-1
 3c4:	00978d63          	beq	a5,s1,3de <main+0x268>
 3c8:	035a453b          	divw	a0,s4,s5
 3cc:	00000097          	auipc	ra,0x0
 3d0:	c70080e7          	jalr	-912(ra) # 3c <producir>
                exit(0);
 3d4:	4501                	li	a0,0
 3d6:	00000097          	auipc	ra,0x0
 3da:	2c8080e7          	jalr	712(ra) # 69e <exit>
                producir(i == P - 1 ? N - (N/P)*(P-1) : N/P);
 3de:	035a453b          	divw	a0,s4,s5
 3e2:	0295053b          	mulw	a0,a0,s1
 3e6:	40aa053b          	subw	a0,s4,a0
 3ea:	b7cd                	j	3cc <main+0x256>
                consumir(i == C - 1 ? N - (N/C)*(C-1) : N/C);
 3ec:	fffb079b          	addiw	a5,s6,-1
 3f0:	00978d63          	beq	a5,s1,40a <main+0x294>
 3f4:	036a453b          	divw	a0,s4,s6
 3f8:	00000097          	auipc	ra,0x0
 3fc:	ce2080e7          	jalr	-798(ra) # da <consumir>
                exit(0);
 400:	4501                	li	a0,0
 402:	00000097          	auipc	ra,0x0
 406:	29c080e7          	jalr	668(ra) # 69e <exit>
                consumir(i == C - 1 ? N - (N/C)*(C-1) : N/C);
 40a:	036a47bb          	divw	a5,s4,s6
 40e:	029787bb          	mulw	a5,a5,s1
 412:	40fa053b          	subw	a0,s4,a5
 416:	b7cd                	j	3f8 <main+0x282>

0000000000000418 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
 418:	1141                	addi	sp,sp,-16
 41a:	e406                	sd	ra,8(sp)
 41c:	e022                	sd	s0,0(sp)
 41e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 420:	00000097          	auipc	ra,0x0
 424:	d56080e7          	jalr	-682(ra) # 176 <main>
  exit(0);
 428:	4501                	li	a0,0
 42a:	00000097          	auipc	ra,0x0
 42e:	274080e7          	jalr	628(ra) # 69e <exit>

0000000000000432 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 432:	1141                	addi	sp,sp,-16
 434:	e422                	sd	s0,8(sp)
 436:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 438:	87aa                	mv	a5,a0
 43a:	0585                	addi	a1,a1,1
 43c:	0785                	addi	a5,a5,1
 43e:	fff5c703          	lbu	a4,-1(a1)
 442:	fee78fa3          	sb	a4,-1(a5)
 446:	fb75                	bnez	a4,43a <strcpy+0x8>
    ;
  return os;
}
 448:	6422                	ld	s0,8(sp)
 44a:	0141                	addi	sp,sp,16
 44c:	8082                	ret

000000000000044e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 44e:	1141                	addi	sp,sp,-16
 450:	e422                	sd	s0,8(sp)
 452:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 454:	00054783          	lbu	a5,0(a0)
 458:	cb91                	beqz	a5,46c <strcmp+0x1e>
 45a:	0005c703          	lbu	a4,0(a1)
 45e:	00f71763          	bne	a4,a5,46c <strcmp+0x1e>
    p++, q++;
 462:	0505                	addi	a0,a0,1
 464:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 466:	00054783          	lbu	a5,0(a0)
 46a:	fbe5                	bnez	a5,45a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 46c:	0005c503          	lbu	a0,0(a1)
}
 470:	40a7853b          	subw	a0,a5,a0
 474:	6422                	ld	s0,8(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret

000000000000047a <strlen>:

uint
strlen(const char *s)
{
 47a:	1141                	addi	sp,sp,-16
 47c:	e422                	sd	s0,8(sp)
 47e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 480:	00054783          	lbu	a5,0(a0)
 484:	cf91                	beqz	a5,4a0 <strlen+0x26>
 486:	0505                	addi	a0,a0,1
 488:	87aa                	mv	a5,a0
 48a:	86be                	mv	a3,a5
 48c:	0785                	addi	a5,a5,1
 48e:	fff7c703          	lbu	a4,-1(a5)
 492:	ff65                	bnez	a4,48a <strlen+0x10>
 494:	40a6853b          	subw	a0,a3,a0
 498:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 49a:	6422                	ld	s0,8(sp)
 49c:	0141                	addi	sp,sp,16
 49e:	8082                	ret
  for(n = 0; s[n]; n++)
 4a0:	4501                	li	a0,0
 4a2:	bfe5                	j	49a <strlen+0x20>

00000000000004a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4a4:	1141                	addi	sp,sp,-16
 4a6:	e422                	sd	s0,8(sp)
 4a8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4aa:	ca19                	beqz	a2,4c0 <memset+0x1c>
 4ac:	87aa                	mv	a5,a0
 4ae:	1602                	slli	a2,a2,0x20
 4b0:	9201                	srli	a2,a2,0x20
 4b2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4b6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 4ba:	0785                	addi	a5,a5,1
 4bc:	fee79de3          	bne	a5,a4,4b6 <memset+0x12>
  }
  return dst;
}
 4c0:	6422                	ld	s0,8(sp)
 4c2:	0141                	addi	sp,sp,16
 4c4:	8082                	ret

00000000000004c6 <strchr>:

char*
strchr(const char *s, char c)
{
 4c6:	1141                	addi	sp,sp,-16
 4c8:	e422                	sd	s0,8(sp)
 4ca:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4cc:	00054783          	lbu	a5,0(a0)
 4d0:	cb99                	beqz	a5,4e6 <strchr+0x20>
    if(*s == c)
 4d2:	00f58763          	beq	a1,a5,4e0 <strchr+0x1a>
  for(; *s; s++)
 4d6:	0505                	addi	a0,a0,1
 4d8:	00054783          	lbu	a5,0(a0)
 4dc:	fbfd                	bnez	a5,4d2 <strchr+0xc>
      return (char*)s;
  return 0;
 4de:	4501                	li	a0,0
}
 4e0:	6422                	ld	s0,8(sp)
 4e2:	0141                	addi	sp,sp,16
 4e4:	8082                	ret
  return 0;
 4e6:	4501                	li	a0,0
 4e8:	bfe5                	j	4e0 <strchr+0x1a>

00000000000004ea <gets>:

char*
gets(char *buf, int max)
{
 4ea:	711d                	addi	sp,sp,-96
 4ec:	ec86                	sd	ra,88(sp)
 4ee:	e8a2                	sd	s0,80(sp)
 4f0:	e4a6                	sd	s1,72(sp)
 4f2:	e0ca                	sd	s2,64(sp)
 4f4:	fc4e                	sd	s3,56(sp)
 4f6:	f852                	sd	s4,48(sp)
 4f8:	f456                	sd	s5,40(sp)
 4fa:	f05a                	sd	s6,32(sp)
 4fc:	ec5e                	sd	s7,24(sp)
 4fe:	1080                	addi	s0,sp,96
 500:	8baa                	mv	s7,a0
 502:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 504:	892a                	mv	s2,a0
 506:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 508:	4aa9                	li	s5,10
 50a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 50c:	89a6                	mv	s3,s1
 50e:	2485                	addiw	s1,s1,1
 510:	0344d863          	bge	s1,s4,540 <gets+0x56>
    cc = read(0, &c, 1);
 514:	4605                	li	a2,1
 516:	faf40593          	addi	a1,s0,-81
 51a:	4501                	li	a0,0
 51c:	00000097          	auipc	ra,0x0
 520:	19a080e7          	jalr	410(ra) # 6b6 <read>
    if(cc < 1)
 524:	00a05e63          	blez	a0,540 <gets+0x56>
    buf[i++] = c;
 528:	faf44783          	lbu	a5,-81(s0)
 52c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 530:	01578763          	beq	a5,s5,53e <gets+0x54>
 534:	0905                	addi	s2,s2,1
 536:	fd679be3          	bne	a5,s6,50c <gets+0x22>
    buf[i++] = c;
 53a:	89a6                	mv	s3,s1
 53c:	a011                	j	540 <gets+0x56>
 53e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 540:	99de                	add	s3,s3,s7
 542:	00098023          	sb	zero,0(s3)
  return buf;
}
 546:	855e                	mv	a0,s7
 548:	60e6                	ld	ra,88(sp)
 54a:	6446                	ld	s0,80(sp)
 54c:	64a6                	ld	s1,72(sp)
 54e:	6906                	ld	s2,64(sp)
 550:	79e2                	ld	s3,56(sp)
 552:	7a42                	ld	s4,48(sp)
 554:	7aa2                	ld	s5,40(sp)
 556:	7b02                	ld	s6,32(sp)
 558:	6be2                	ld	s7,24(sp)
 55a:	6125                	addi	sp,sp,96
 55c:	8082                	ret

000000000000055e <stat>:

int
stat(const char *n, struct stat *st)
{
 55e:	1101                	addi	sp,sp,-32
 560:	ec06                	sd	ra,24(sp)
 562:	e822                	sd	s0,16(sp)
 564:	e04a                	sd	s2,0(sp)
 566:	1000                	addi	s0,sp,32
 568:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 56a:	4581                	li	a1,0
 56c:	00000097          	auipc	ra,0x0
 570:	172080e7          	jalr	370(ra) # 6de <open>
  if(fd < 0)
 574:	02054663          	bltz	a0,5a0 <stat+0x42>
 578:	e426                	sd	s1,8(sp)
 57a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 57c:	85ca                	mv	a1,s2
 57e:	00000097          	auipc	ra,0x0
 582:	178080e7          	jalr	376(ra) # 6f6 <fstat>
 586:	892a                	mv	s2,a0
  close(fd);
 588:	8526                	mv	a0,s1
 58a:	00000097          	auipc	ra,0x0
 58e:	13c080e7          	jalr	316(ra) # 6c6 <close>
  return r;
 592:	64a2                	ld	s1,8(sp)
}
 594:	854a                	mv	a0,s2
 596:	60e2                	ld	ra,24(sp)
 598:	6442                	ld	s0,16(sp)
 59a:	6902                	ld	s2,0(sp)
 59c:	6105                	addi	sp,sp,32
 59e:	8082                	ret
    return -1;
 5a0:	597d                	li	s2,-1
 5a2:	bfcd                	j	594 <stat+0x36>

00000000000005a4 <atoi>:

int
atoi(const char *s)
{
 5a4:	1141                	addi	sp,sp,-16
 5a6:	e422                	sd	s0,8(sp)
 5a8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5aa:	00054683          	lbu	a3,0(a0)
 5ae:	fd06879b          	addiw	a5,a3,-48
 5b2:	0ff7f793          	zext.b	a5,a5
 5b6:	4625                	li	a2,9
 5b8:	02f66863          	bltu	a2,a5,5e8 <atoi+0x44>
 5bc:	872a                	mv	a4,a0
  n = 0;
 5be:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 5c0:	0705                	addi	a4,a4,1
 5c2:	0025179b          	slliw	a5,a0,0x2
 5c6:	9fa9                	addw	a5,a5,a0
 5c8:	0017979b          	slliw	a5,a5,0x1
 5cc:	9fb5                	addw	a5,a5,a3
 5ce:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5d2:	00074683          	lbu	a3,0(a4)
 5d6:	fd06879b          	addiw	a5,a3,-48
 5da:	0ff7f793          	zext.b	a5,a5
 5de:	fef671e3          	bgeu	a2,a5,5c0 <atoi+0x1c>
  return n;
}
 5e2:	6422                	ld	s0,8(sp)
 5e4:	0141                	addi	sp,sp,16
 5e6:	8082                	ret
  n = 0;
 5e8:	4501                	li	a0,0
 5ea:	bfe5                	j	5e2 <atoi+0x3e>

00000000000005ec <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5ec:	1141                	addi	sp,sp,-16
 5ee:	e422                	sd	s0,8(sp)
 5f0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5f2:	02b57463          	bgeu	a0,a1,61a <memmove+0x2e>
    while(n-- > 0)
 5f6:	00c05f63          	blez	a2,614 <memmove+0x28>
 5fa:	1602                	slli	a2,a2,0x20
 5fc:	9201                	srli	a2,a2,0x20
 5fe:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 602:	872a                	mv	a4,a0
      *dst++ = *src++;
 604:	0585                	addi	a1,a1,1
 606:	0705                	addi	a4,a4,1
 608:	fff5c683          	lbu	a3,-1(a1)
 60c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 610:	fef71ae3          	bne	a4,a5,604 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 614:	6422                	ld	s0,8(sp)
 616:	0141                	addi	sp,sp,16
 618:	8082                	ret
    dst += n;
 61a:	00c50733          	add	a4,a0,a2
    src += n;
 61e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 620:	fec05ae3          	blez	a2,614 <memmove+0x28>
 624:	fff6079b          	addiw	a5,a2,-1
 628:	1782                	slli	a5,a5,0x20
 62a:	9381                	srli	a5,a5,0x20
 62c:	fff7c793          	not	a5,a5
 630:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 632:	15fd                	addi	a1,a1,-1
 634:	177d                	addi	a4,a4,-1
 636:	0005c683          	lbu	a3,0(a1)
 63a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 63e:	fee79ae3          	bne	a5,a4,632 <memmove+0x46>
 642:	bfc9                	j	614 <memmove+0x28>

0000000000000644 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 644:	1141                	addi	sp,sp,-16
 646:	e422                	sd	s0,8(sp)
 648:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 64a:	ca05                	beqz	a2,67a <memcmp+0x36>
 64c:	fff6069b          	addiw	a3,a2,-1
 650:	1682                	slli	a3,a3,0x20
 652:	9281                	srli	a3,a3,0x20
 654:	0685                	addi	a3,a3,1
 656:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 658:	00054783          	lbu	a5,0(a0)
 65c:	0005c703          	lbu	a4,0(a1)
 660:	00e79863          	bne	a5,a4,670 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 664:	0505                	addi	a0,a0,1
    p2++;
 666:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 668:	fed518e3          	bne	a0,a3,658 <memcmp+0x14>
  }
  return 0;
 66c:	4501                	li	a0,0
 66e:	a019                	j	674 <memcmp+0x30>
      return *p1 - *p2;
 670:	40e7853b          	subw	a0,a5,a4
}
 674:	6422                	ld	s0,8(sp)
 676:	0141                	addi	sp,sp,16
 678:	8082                	ret
  return 0;
 67a:	4501                	li	a0,0
 67c:	bfe5                	j	674 <memcmp+0x30>

000000000000067e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 67e:	1141                	addi	sp,sp,-16
 680:	e406                	sd	ra,8(sp)
 682:	e022                	sd	s0,0(sp)
 684:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 686:	00000097          	auipc	ra,0x0
 68a:	f66080e7          	jalr	-154(ra) # 5ec <memmove>
}
 68e:	60a2                	ld	ra,8(sp)
 690:	6402                	ld	s0,0(sp)
 692:	0141                	addi	sp,sp,16
 694:	8082                	ret

0000000000000696 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 696:	4885                	li	a7,1
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <exit>:
.global exit
exit:
 li a7, SYS_exit
 69e:	4889                	li	a7,2
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6a6:	488d                	li	a7,3
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6ae:	4891                	li	a7,4
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <read>:
.global read
read:
 li a7, SYS_read
 6b6:	4895                	li	a7,5
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <write>:
.global write
write:
 li a7, SYS_write
 6be:	48c1                	li	a7,16
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <close>:
.global close
close:
 li a7, SYS_close
 6c6:	48d5                	li	a7,21
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <kill>:
.global kill
kill:
 li a7, SYS_kill
 6ce:	4899                	li	a7,6
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6d6:	489d                	li	a7,7
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <open>:
.global open
open:
 li a7, SYS_open
 6de:	48bd                	li	a7,15
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6e6:	48c5                	li	a7,17
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6ee:	48c9                	li	a7,18
 ecall
 6f0:	00000073          	ecall
 ret
 6f4:	8082                	ret

00000000000006f6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6f6:	48a1                	li	a7,8
 ecall
 6f8:	00000073          	ecall
 ret
 6fc:	8082                	ret

00000000000006fe <link>:
.global link
link:
 li a7, SYS_link
 6fe:	48cd                	li	a7,19
 ecall
 700:	00000073          	ecall
 ret
 704:	8082                	ret

0000000000000706 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 706:	48d1                	li	a7,20
 ecall
 708:	00000073          	ecall
 ret
 70c:	8082                	ret

000000000000070e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 70e:	48a5                	li	a7,9
 ecall
 710:	00000073          	ecall
 ret
 714:	8082                	ret

0000000000000716 <dup>:
.global dup
dup:
 li a7, SYS_dup
 716:	48a9                	li	a7,10
 ecall
 718:	00000073          	ecall
 ret
 71c:	8082                	ret

000000000000071e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 71e:	48ad                	li	a7,11
 ecall
 720:	00000073          	ecall
 ret
 724:	8082                	ret

0000000000000726 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 726:	48b1                	li	a7,12
 ecall
 728:	00000073          	ecall
 ret
 72c:	8082                	ret

000000000000072e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 72e:	48b5                	li	a7,13
 ecall
 730:	00000073          	ecall
 ret
 734:	8082                	ret

0000000000000736 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 736:	48b9                	li	a7,14
 ecall
 738:	00000073          	ecall
 ret
 73c:	8082                	ret

000000000000073e <sem_open>:
.global sem_open
sem_open:
 li a7, SYS_sem_open
 73e:	48d9                	li	a7,22
 ecall
 740:	00000073          	ecall
 ret
 744:	8082                	ret

0000000000000746 <sem_close>:
.global sem_close
sem_close:
 li a7, SYS_sem_close
 746:	48dd                	li	a7,23
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <sem_up>:
.global sem_up
sem_up:
 li a7, SYS_sem_up
 74e:	48e1                	li	a7,24
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <sem_down>:
.global sem_down
sem_down:
 li a7, SYS_sem_down
 756:	48e5                	li	a7,25
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 75e:	1101                	addi	sp,sp,-32
 760:	ec06                	sd	ra,24(sp)
 762:	e822                	sd	s0,16(sp)
 764:	1000                	addi	s0,sp,32
 766:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 76a:	4605                	li	a2,1
 76c:	fef40593          	addi	a1,s0,-17
 770:	00000097          	auipc	ra,0x0
 774:	f4e080e7          	jalr	-178(ra) # 6be <write>
}
 778:	60e2                	ld	ra,24(sp)
 77a:	6442                	ld	s0,16(sp)
 77c:	6105                	addi	sp,sp,32
 77e:	8082                	ret

0000000000000780 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 780:	7139                	addi	sp,sp,-64
 782:	fc06                	sd	ra,56(sp)
 784:	f822                	sd	s0,48(sp)
 786:	f426                	sd	s1,40(sp)
 788:	0080                	addi	s0,sp,64
 78a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 78c:	c299                	beqz	a3,792 <printint+0x12>
 78e:	0805cb63          	bltz	a1,824 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 792:	2581                	sext.w	a1,a1
  neg = 0;
 794:	4881                	li	a7,0
 796:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 79a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 79c:	2601                	sext.w	a2,a2
 79e:	00000517          	auipc	a0,0x0
 7a2:	57a50513          	addi	a0,a0,1402 # d18 <digits>
 7a6:	883a                	mv	a6,a4
 7a8:	2705                	addiw	a4,a4,1
 7aa:	02c5f7bb          	remuw	a5,a1,a2
 7ae:	1782                	slli	a5,a5,0x20
 7b0:	9381                	srli	a5,a5,0x20
 7b2:	97aa                	add	a5,a5,a0
 7b4:	0007c783          	lbu	a5,0(a5)
 7b8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7bc:	0005879b          	sext.w	a5,a1
 7c0:	02c5d5bb          	divuw	a1,a1,a2
 7c4:	0685                	addi	a3,a3,1
 7c6:	fec7f0e3          	bgeu	a5,a2,7a6 <printint+0x26>
  if(neg)
 7ca:	00088c63          	beqz	a7,7e2 <printint+0x62>
    buf[i++] = '-';
 7ce:	fd070793          	addi	a5,a4,-48
 7d2:	00878733          	add	a4,a5,s0
 7d6:	02d00793          	li	a5,45
 7da:	fef70823          	sb	a5,-16(a4)
 7de:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7e2:	02e05c63          	blez	a4,81a <printint+0x9a>
 7e6:	f04a                	sd	s2,32(sp)
 7e8:	ec4e                	sd	s3,24(sp)
 7ea:	fc040793          	addi	a5,s0,-64
 7ee:	00e78933          	add	s2,a5,a4
 7f2:	fff78993          	addi	s3,a5,-1
 7f6:	99ba                	add	s3,s3,a4
 7f8:	377d                	addiw	a4,a4,-1
 7fa:	1702                	slli	a4,a4,0x20
 7fc:	9301                	srli	a4,a4,0x20
 7fe:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 802:	fff94583          	lbu	a1,-1(s2)
 806:	8526                	mv	a0,s1
 808:	00000097          	auipc	ra,0x0
 80c:	f56080e7          	jalr	-170(ra) # 75e <putc>
  while(--i >= 0)
 810:	197d                	addi	s2,s2,-1
 812:	ff3918e3          	bne	s2,s3,802 <printint+0x82>
 816:	7902                	ld	s2,32(sp)
 818:	69e2                	ld	s3,24(sp)
}
 81a:	70e2                	ld	ra,56(sp)
 81c:	7442                	ld	s0,48(sp)
 81e:	74a2                	ld	s1,40(sp)
 820:	6121                	addi	sp,sp,64
 822:	8082                	ret
    x = -xx;
 824:	40b005bb          	negw	a1,a1
    neg = 1;
 828:	4885                	li	a7,1
    x = -xx;
 82a:	b7b5                	j	796 <printint+0x16>

000000000000082c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 82c:	715d                	addi	sp,sp,-80
 82e:	e486                	sd	ra,72(sp)
 830:	e0a2                	sd	s0,64(sp)
 832:	f84a                	sd	s2,48(sp)
 834:	0880                	addi	s0,sp,80
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 836:	0005c903          	lbu	s2,0(a1)
 83a:	1a090a63          	beqz	s2,9ee <vprintf+0x1c2>
 83e:	fc26                	sd	s1,56(sp)
 840:	f44e                	sd	s3,40(sp)
 842:	f052                	sd	s4,32(sp)
 844:	ec56                	sd	s5,24(sp)
 846:	e85a                	sd	s6,16(sp)
 848:	e45e                	sd	s7,8(sp)
 84a:	8aaa                	mv	s5,a0
 84c:	8bb2                	mv	s7,a2
 84e:	00158493          	addi	s1,a1,1
  state = 0;
 852:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 854:	02500a13          	li	s4,37
 858:	4b55                	li	s6,21
 85a:	a839                	j	878 <vprintf+0x4c>
        putc(fd, c);
 85c:	85ca                	mv	a1,s2
 85e:	8556                	mv	a0,s5
 860:	00000097          	auipc	ra,0x0
 864:	efe080e7          	jalr	-258(ra) # 75e <putc>
 868:	a019                	j	86e <vprintf+0x42>
    } else if(state == '%'){
 86a:	01498d63          	beq	s3,s4,884 <vprintf+0x58>
  for(i = 0; fmt[i]; i++){
 86e:	0485                	addi	s1,s1,1
 870:	fff4c903          	lbu	s2,-1(s1)
 874:	16090763          	beqz	s2,9e2 <vprintf+0x1b6>
    if(state == 0){
 878:	fe0999e3          	bnez	s3,86a <vprintf+0x3e>
      if(c == '%'){
 87c:	ff4910e3          	bne	s2,s4,85c <vprintf+0x30>
        state = '%';
 880:	89d2                	mv	s3,s4
 882:	b7f5                	j	86e <vprintf+0x42>
      if(c == 'd'){
 884:	13490463          	beq	s2,s4,9ac <vprintf+0x180>
 888:	f9d9079b          	addiw	a5,s2,-99
 88c:	0ff7f793          	zext.b	a5,a5
 890:	12fb6763          	bltu	s6,a5,9be <vprintf+0x192>
 894:	f9d9079b          	addiw	a5,s2,-99
 898:	0ff7f713          	zext.b	a4,a5
 89c:	12eb6163          	bltu	s6,a4,9be <vprintf+0x192>
 8a0:	00271793          	slli	a5,a4,0x2
 8a4:	00000717          	auipc	a4,0x0
 8a8:	41c70713          	addi	a4,a4,1052 # cc0 <malloc+0x1e2>
 8ac:	97ba                	add	a5,a5,a4
 8ae:	439c                	lw	a5,0(a5)
 8b0:	97ba                	add	a5,a5,a4
 8b2:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 8b4:	008b8913          	addi	s2,s7,8
 8b8:	4685                	li	a3,1
 8ba:	4629                	li	a2,10
 8bc:	000ba583          	lw	a1,0(s7)
 8c0:	8556                	mv	a0,s5
 8c2:	00000097          	auipc	ra,0x0
 8c6:	ebe080e7          	jalr	-322(ra) # 780 <printint>
 8ca:	8bca                	mv	s7,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	b745                	j	86e <vprintf+0x42>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d0:	008b8913          	addi	s2,s7,8
 8d4:	4681                	li	a3,0
 8d6:	4629                	li	a2,10
 8d8:	000ba583          	lw	a1,0(s7)
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	ea2080e7          	jalr	-350(ra) # 780 <printint>
 8e6:	8bca                	mv	s7,s2
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	b751                	j	86e <vprintf+0x42>
        printint(fd, va_arg(ap, int), 16, 0);
 8ec:	008b8913          	addi	s2,s7,8
 8f0:	4681                	li	a3,0
 8f2:	4641                	li	a2,16
 8f4:	000ba583          	lw	a1,0(s7)
 8f8:	8556                	mv	a0,s5
 8fa:	00000097          	auipc	ra,0x0
 8fe:	e86080e7          	jalr	-378(ra) # 780 <printint>
 902:	8bca                	mv	s7,s2
      state = 0;
 904:	4981                	li	s3,0
 906:	b7a5                	j	86e <vprintf+0x42>
 908:	e062                	sd	s8,0(sp)
        printptr(fd, va_arg(ap, uint64));
 90a:	008b8c13          	addi	s8,s7,8
 90e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 912:	03000593          	li	a1,48
 916:	8556                	mv	a0,s5
 918:	00000097          	auipc	ra,0x0
 91c:	e46080e7          	jalr	-442(ra) # 75e <putc>
  putc(fd, 'x');
 920:	07800593          	li	a1,120
 924:	8556                	mv	a0,s5
 926:	00000097          	auipc	ra,0x0
 92a:	e38080e7          	jalr	-456(ra) # 75e <putc>
 92e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 930:	00000b97          	auipc	s7,0x0
 934:	3e8b8b93          	addi	s7,s7,1000 # d18 <digits>
 938:	03c9d793          	srli	a5,s3,0x3c
 93c:	97de                	add	a5,a5,s7
 93e:	0007c583          	lbu	a1,0(a5)
 942:	8556                	mv	a0,s5
 944:	00000097          	auipc	ra,0x0
 948:	e1a080e7          	jalr	-486(ra) # 75e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 94c:	0992                	slli	s3,s3,0x4
 94e:	397d                	addiw	s2,s2,-1
 950:	fe0914e3          	bnez	s2,938 <vprintf+0x10c>
        printptr(fd, va_arg(ap, uint64));
 954:	8be2                	mv	s7,s8
      state = 0;
 956:	4981                	li	s3,0
 958:	6c02                	ld	s8,0(sp)
 95a:	bf11                	j	86e <vprintf+0x42>
        s = va_arg(ap, char*);
 95c:	008b8993          	addi	s3,s7,8
 960:	000bb903          	ld	s2,0(s7)
        if(s == 0)
 964:	02090163          	beqz	s2,986 <vprintf+0x15a>
        while(*s != 0){
 968:	00094583          	lbu	a1,0(s2)
 96c:	c9a5                	beqz	a1,9dc <vprintf+0x1b0>
          putc(fd, *s);
 96e:	8556                	mv	a0,s5
 970:	00000097          	auipc	ra,0x0
 974:	dee080e7          	jalr	-530(ra) # 75e <putc>
          s++;
 978:	0905                	addi	s2,s2,1
        while(*s != 0){
 97a:	00094583          	lbu	a1,0(s2)
 97e:	f9e5                	bnez	a1,96e <vprintf+0x142>
        s = va_arg(ap, char*);
 980:	8bce                	mv	s7,s3
      state = 0;
 982:	4981                	li	s3,0
 984:	b5ed                	j	86e <vprintf+0x42>
          s = "(null)";
 986:	00000917          	auipc	s2,0x0
 98a:	33290913          	addi	s2,s2,818 # cb8 <malloc+0x1da>
        while(*s != 0){
 98e:	02800593          	li	a1,40
 992:	bff1                	j	96e <vprintf+0x142>
        putc(fd, va_arg(ap, uint));
 994:	008b8913          	addi	s2,s7,8
 998:	000bc583          	lbu	a1,0(s7)
 99c:	8556                	mv	a0,s5
 99e:	00000097          	auipc	ra,0x0
 9a2:	dc0080e7          	jalr	-576(ra) # 75e <putc>
 9a6:	8bca                	mv	s7,s2
      state = 0;
 9a8:	4981                	li	s3,0
 9aa:	b5d1                	j	86e <vprintf+0x42>
        putc(fd, c);
 9ac:	02500593          	li	a1,37
 9b0:	8556                	mv	a0,s5
 9b2:	00000097          	auipc	ra,0x0
 9b6:	dac080e7          	jalr	-596(ra) # 75e <putc>
      state = 0;
 9ba:	4981                	li	s3,0
 9bc:	bd4d                	j	86e <vprintf+0x42>
        putc(fd, '%');
 9be:	02500593          	li	a1,37
 9c2:	8556                	mv	a0,s5
 9c4:	00000097          	auipc	ra,0x0
 9c8:	d9a080e7          	jalr	-614(ra) # 75e <putc>
        putc(fd, c);
 9cc:	85ca                	mv	a1,s2
 9ce:	8556                	mv	a0,s5
 9d0:	00000097          	auipc	ra,0x0
 9d4:	d8e080e7          	jalr	-626(ra) # 75e <putc>
      state = 0;
 9d8:	4981                	li	s3,0
 9da:	bd51                	j	86e <vprintf+0x42>
        s = va_arg(ap, char*);
 9dc:	8bce                	mv	s7,s3
      state = 0;
 9de:	4981                	li	s3,0
 9e0:	b579                	j	86e <vprintf+0x42>
 9e2:	74e2                	ld	s1,56(sp)
 9e4:	79a2                	ld	s3,40(sp)
 9e6:	7a02                	ld	s4,32(sp)
 9e8:	6ae2                	ld	s5,24(sp)
 9ea:	6b42                	ld	s6,16(sp)
 9ec:	6ba2                	ld	s7,8(sp)
    }
  }
}
 9ee:	60a6                	ld	ra,72(sp)
 9f0:	6406                	ld	s0,64(sp)
 9f2:	7942                	ld	s2,48(sp)
 9f4:	6161                	addi	sp,sp,80
 9f6:	8082                	ret

00000000000009f8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9f8:	715d                	addi	sp,sp,-80
 9fa:	ec06                	sd	ra,24(sp)
 9fc:	e822                	sd	s0,16(sp)
 9fe:	1000                	addi	s0,sp,32
 a00:	e010                	sd	a2,0(s0)
 a02:	e414                	sd	a3,8(s0)
 a04:	e818                	sd	a4,16(s0)
 a06:	ec1c                	sd	a5,24(s0)
 a08:	03043023          	sd	a6,32(s0)
 a0c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a10:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a14:	8622                	mv	a2,s0
 a16:	00000097          	auipc	ra,0x0
 a1a:	e16080e7          	jalr	-490(ra) # 82c <vprintf>
}
 a1e:	60e2                	ld	ra,24(sp)
 a20:	6442                	ld	s0,16(sp)
 a22:	6161                	addi	sp,sp,80
 a24:	8082                	ret

0000000000000a26 <printf>:

void
printf(const char *fmt, ...)
{
 a26:	711d                	addi	sp,sp,-96
 a28:	ec06                	sd	ra,24(sp)
 a2a:	e822                	sd	s0,16(sp)
 a2c:	1000                	addi	s0,sp,32
 a2e:	e40c                	sd	a1,8(s0)
 a30:	e810                	sd	a2,16(s0)
 a32:	ec14                	sd	a3,24(s0)
 a34:	f018                	sd	a4,32(s0)
 a36:	f41c                	sd	a5,40(s0)
 a38:	03043823          	sd	a6,48(s0)
 a3c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a40:	00840613          	addi	a2,s0,8
 a44:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a48:	85aa                	mv	a1,a0
 a4a:	4505                	li	a0,1
 a4c:	00000097          	auipc	ra,0x0
 a50:	de0080e7          	jalr	-544(ra) # 82c <vprintf>
}
 a54:	60e2                	ld	ra,24(sp)
 a56:	6442                	ld	s0,16(sp)
 a58:	6125                	addi	sp,sp,96
 a5a:	8082                	ret

0000000000000a5c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a5c:	1141                	addi	sp,sp,-16
 a5e:	e422                	sd	s0,8(sp)
 a60:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a62:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a66:	00001797          	auipc	a5,0x1
 a6a:	a5a7b783          	ld	a5,-1446(a5) # 14c0 <freep>
 a6e:	a02d                	j	a98 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a70:	4618                	lw	a4,8(a2)
 a72:	9f2d                	addw	a4,a4,a1
 a74:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a78:	6398                	ld	a4,0(a5)
 a7a:	6310                	ld	a2,0(a4)
 a7c:	a83d                	j	aba <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a7e:	ff852703          	lw	a4,-8(a0)
 a82:	9f31                	addw	a4,a4,a2
 a84:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a86:	ff053683          	ld	a3,-16(a0)
 a8a:	a091                	j	ace <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a8c:	6398                	ld	a4,0(a5)
 a8e:	00e7e463          	bltu	a5,a4,a96 <free+0x3a>
 a92:	00e6ea63          	bltu	a3,a4,aa6 <free+0x4a>
{
 a96:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a98:	fed7fae3          	bgeu	a5,a3,a8c <free+0x30>
 a9c:	6398                	ld	a4,0(a5)
 a9e:	00e6e463          	bltu	a3,a4,aa6 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aa2:	fee7eae3          	bltu	a5,a4,a96 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 aa6:	ff852583          	lw	a1,-8(a0)
 aaa:	6390                	ld	a2,0(a5)
 aac:	02059813          	slli	a6,a1,0x20
 ab0:	01c85713          	srli	a4,a6,0x1c
 ab4:	9736                	add	a4,a4,a3
 ab6:	fae60de3          	beq	a2,a4,a70 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 aba:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 abe:	4790                	lw	a2,8(a5)
 ac0:	02061593          	slli	a1,a2,0x20
 ac4:	01c5d713          	srli	a4,a1,0x1c
 ac8:	973e                	add	a4,a4,a5
 aca:	fae68ae3          	beq	a3,a4,a7e <free+0x22>
    p->s.ptr = bp->s.ptr;
 ace:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 ad0:	00001717          	auipc	a4,0x1
 ad4:	9ef73823          	sd	a5,-1552(a4) # 14c0 <freep>
}
 ad8:	6422                	ld	s0,8(sp)
 ada:	0141                	addi	sp,sp,16
 adc:	8082                	ret

0000000000000ade <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ade:	7139                	addi	sp,sp,-64
 ae0:	fc06                	sd	ra,56(sp)
 ae2:	f822                	sd	s0,48(sp)
 ae4:	f426                	sd	s1,40(sp)
 ae6:	ec4e                	sd	s3,24(sp)
 ae8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aea:	02051493          	slli	s1,a0,0x20
 aee:	9081                	srli	s1,s1,0x20
 af0:	04bd                	addi	s1,s1,15
 af2:	8091                	srli	s1,s1,0x4
 af4:	0014899b          	addiw	s3,s1,1
 af8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 afa:	00001517          	auipc	a0,0x1
 afe:	9c653503          	ld	a0,-1594(a0) # 14c0 <freep>
 b02:	c915                	beqz	a0,b36 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b04:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b06:	4798                	lw	a4,8(a5)
 b08:	08977e63          	bgeu	a4,s1,ba4 <malloc+0xc6>
 b0c:	f04a                	sd	s2,32(sp)
 b0e:	e852                	sd	s4,16(sp)
 b10:	e456                	sd	s5,8(sp)
 b12:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 b14:	8a4e                	mv	s4,s3
 b16:	0009871b          	sext.w	a4,s3
 b1a:	6685                	lui	a3,0x1
 b1c:	00d77363          	bgeu	a4,a3,b22 <malloc+0x44>
 b20:	6a05                	lui	s4,0x1
 b22:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b26:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b2a:	00001917          	auipc	s2,0x1
 b2e:	99690913          	addi	s2,s2,-1642 # 14c0 <freep>
  if(p == (char*)-1)
 b32:	5afd                	li	s5,-1
 b34:	a091                	j	b78 <malloc+0x9a>
 b36:	f04a                	sd	s2,32(sp)
 b38:	e852                	sd	s4,16(sp)
 b3a:	e456                	sd	s5,8(sp)
 b3c:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 b3e:	00001797          	auipc	a5,0x1
 b42:	99278793          	addi	a5,a5,-1646 # 14d0 <base>
 b46:	00001717          	auipc	a4,0x1
 b4a:	96f73d23          	sd	a5,-1670(a4) # 14c0 <freep>
 b4e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b50:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b54:	b7c1                	j	b14 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 b56:	6398                	ld	a4,0(a5)
 b58:	e118                	sd	a4,0(a0)
 b5a:	a08d                	j	bbc <malloc+0xde>
  hp->s.size = nu;
 b5c:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b60:	0541                	addi	a0,a0,16
 b62:	00000097          	auipc	ra,0x0
 b66:	efa080e7          	jalr	-262(ra) # a5c <free>
  return freep;
 b6a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b6e:	c13d                	beqz	a0,bd4 <malloc+0xf6>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b70:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b72:	4798                	lw	a4,8(a5)
 b74:	02977463          	bgeu	a4,s1,b9c <malloc+0xbe>
    if(p == freep)
 b78:	00093703          	ld	a4,0(s2)
 b7c:	853e                	mv	a0,a5
 b7e:	fef719e3          	bne	a4,a5,b70 <malloc+0x92>
  p = sbrk(nu * sizeof(Header));
 b82:	8552                	mv	a0,s4
 b84:	00000097          	auipc	ra,0x0
 b88:	ba2080e7          	jalr	-1118(ra) # 726 <sbrk>
  if(p == (char*)-1)
 b8c:	fd5518e3          	bne	a0,s5,b5c <malloc+0x7e>
        return 0;
 b90:	4501                	li	a0,0
 b92:	7902                	ld	s2,32(sp)
 b94:	6a42                	ld	s4,16(sp)
 b96:	6aa2                	ld	s5,8(sp)
 b98:	6b02                	ld	s6,0(sp)
 b9a:	a03d                	j	bc8 <malloc+0xea>
 b9c:	7902                	ld	s2,32(sp)
 b9e:	6a42                	ld	s4,16(sp)
 ba0:	6aa2                	ld	s5,8(sp)
 ba2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 ba4:	fae489e3          	beq	s1,a4,b56 <malloc+0x78>
        p->s.size -= nunits;
 ba8:	4137073b          	subw	a4,a4,s3
 bac:	c798                	sw	a4,8(a5)
        p += p->s.size;
 bae:	02071693          	slli	a3,a4,0x20
 bb2:	01c6d713          	srli	a4,a3,0x1c
 bb6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 bb8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 bbc:	00001717          	auipc	a4,0x1
 bc0:	90a73223          	sd	a0,-1788(a4) # 14c0 <freep>
      return (void*)(p + 1);
 bc4:	01078513          	addi	a0,a5,16
  }
}
 bc8:	70e2                	ld	ra,56(sp)
 bca:	7442                	ld	s0,48(sp)
 bcc:	74a2                	ld	s1,40(sp)
 bce:	69e2                	ld	s3,24(sp)
 bd0:	6121                	addi	sp,sp,64
 bd2:	8082                	ret
 bd4:	7902                	ld	s2,32(sp)
 bd6:	6a42                	ld	s4,16(sp)
 bd8:	6aa2                	ld	s5,8(sp)
 bda:	6b02                	ld	s6,0(sp)
 bdc:	b7f5                	j	bc8 <malloc+0xea>
