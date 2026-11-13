#include "kernel/types.h"
#include "user/user.h"

#define SEM_MAX 65   // ids válidos: 1..64

static int sem_empty, sem_full, sem_mutex;

// Busca un id libre probando sem_open; devuelve el id o 0 si no hay.
static int sem_libre(int value){
    for(int id = 1; id < SEM_MAX; id++)
        if(sem_open(id, value) != 0) return id;
    return 0;
}

static void producir(int n){
    for(int j = 1; j <= n; j++){
        sem_down(sem_empty);
        sem_down(sem_mutex);
        printf("produce %d pid=%d\n", j, getpid());
        sem_up(sem_mutex);
        sem_up(sem_full);
    }
}

static void consumir(int n){
    for(int j = 1; j <= n; j++){
        sem_down(sem_full);
        sem_down(sem_mutex);
        printf("consume pid=%d\n", getpid());
        sem_up(sem_mutex);
        sem_up(sem_empty);
    }
}

int main(int argc, char *argv[]) {
    if(argc != 3 && argc != 5){
        fprintf(2, "ERROR: uso: prodcons B N | prodcons B N P C\n");
        exit(1);
    }

    int B = atoi(argv[1]);
    int N = atoi(argv[2]);
    if(B < 1 || N < 1){
        fprintf(2, "ERROR: B y N deben ser enteros >= 1\n");
        exit(1);
    }

    int P = 1, C = 1;
    if(argc == 5){
        P = atoi(argv[3]);
        C = atoi(argv[4]);
        if(P < 1 || C < 1){
            fprintf(2, "ERROR: P y C deben ser >= 1\n");
            exit(1);
        }
    }

    sem_empty = sem_libre(B);
    sem_full  = sem_libre(0);
    sem_mutex = sem_libre(1);
    if(sem_empty == 0 || sem_full == 0 || sem_mutex == 0){
        fprintf(2, "ERROR: no hay semaforos libres\n");
        if(sem_empty) sem_close(sem_empty);
        if(sem_full)  sem_close(sem_full);
        if(sem_mutex) sem_close(sem_mutex);
        exit(1);
    }

    if(argc == 3){
        // Modo básico: un solo fork. El hijo consume, el padre produce.
        int pid = fork();
        if(pid < 0){
            fprintf(2, "ERROR: fallo el fork\n");
            exit(1);
        }
        if(pid == 0){
            consumir(N);
            exit(0);
        }
        producir(N);
        wait(0);
    } else {
        // Modo estrella (solo con 4 argumentos): P productores y C consumidores.
        for(int i = 0; i < P; i++){
            if(fork() == 0){
                producir(i == P - 1 ? N - (N/P)*(P-1) : N/P);
                exit(0);
            }
        }
        for(int i = 0; i < C; i++){
            if(fork() == 0){
                consumir(i == C - 1 ? N - (N/C)*(C-1) : N/C);
                exit(0);
            }
        }
        for(int i = 0; i < P + C; i++)
            wait(0);
    }

    sem_close(sem_empty);
    sem_close(sem_full);
    sem_close(sem_mutex);
    exit(0);
}