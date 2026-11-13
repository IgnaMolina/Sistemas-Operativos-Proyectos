#include "kernel/types.h"
#include "user/user.h"
#define SEM_MAX 65
static int sem_libre(int value){
    for(int id = 1; id < SEM_MAX; id++)
        if(sem_open(id, value) != 0) return id;
    return 0;
}

int main(int argc, char *argv[]){
    //Logica de verficiacion previa.
    if (argc != 2){
        fprintf(2, "ERROR: cantidad de elementos invaldias.\n");
        exit(1);
    }
    int n = atoi(argv[1]);

    if(n < 1){
        fprintf(2, "ERROR: cantidad de pingpongs invalida.\n");
        exit(1);
    }
    int sem_ping = sem_libre(1); //Semaforo de ping
    int sem_pong = sem_libre(0); //Semaforo de pong
    if(sem_ping <= 0 || sem_pong <= 0){
        fprintf(2,"ERROR: Id de semaforos invalida");
        exit(1);
    }
    int pid = fork();
    if (pid < 0) {
        fprintf(2, "ERROR: Falló el fork\n");
        sem_close(sem_ping);
        sem_close(sem_pong);
        exit(1);
    }
    for(int i = 0; i < n; i++){

        if(pid == 0){
            sem_down(sem_pong);
            printf("pong\n");
            sem_up(sem_ping);
        }else {
            sem_down(sem_ping);
            printf("ping\n");
            sem_up(sem_pong);
        }
    }
    if(pid == 0) exit(0);
    wait(0);
    sem_close(sem_ping);
    sem_close(sem_pong);
    exit(0);
}