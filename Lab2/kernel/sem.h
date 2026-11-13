#ifndef SEM_H
#define SEM_H


struct semaforo {
    int in_use;      // 0 si está libre, 1 si está abierto
    int value;       // Contador del semáforo
    struct spinlock lock; // Cerrojo para proteger el semáforo (garantizamos la atomicidad multiprocesador)
}; 

#endif