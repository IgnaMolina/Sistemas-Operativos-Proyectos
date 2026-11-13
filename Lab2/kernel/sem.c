#include "types.h"      // Define tipos de datos básicos (uint, ushort, etc.)
#include "param.h"      // Contiene constantes globales del sistema (como SEM_MAX)
#include "memlayout.h"  // Mapa de memoria del kernel (si fuera necesario)
#include "riscv.h"      // Definiciones específicas de la arquitectura (si aplica)
#include "defs.h"       // Prototipos de funciones globales del kernel (como wakeup y sleep)
#include "spinlock.h"   // Para las estructuras y funciones de cerrojos (struct spinlock, acquire, release)
#include "proc.h"       // Definiciones relacionadas con los procesos (struct proc)
#include "sem.h"

#define SEM_MAX 65

// Arreglo global de semáforos (tamaño 65, índice 0 no se usa)
struct semaforo semaforos[SEM_MAX];


void seminit(void) {
    for (int i = 0; i < SEM_MAX; i++) {
        initlock(&semaforos[i].lock, "semaforo");
        semaforos[i].in_use = 0;
        semaforos[i].value = 0;
    }
}

uint64 sys_sem_open(void) {
    int sem, value;
    argint(0, &sem);
    argint(1, &value);

    if (sem < 1 || sem >= SEM_MAX || value < 0)
        return 0;

    acquire(&semaforos[sem].lock);
    if (semaforos[sem].in_use) {      // doble open: error
        release(&semaforos[sem].lock);
        return 0;
    }
    semaforos[sem].in_use = 1;
    semaforos[sem].value = value;
    release(&semaforos[sem].lock);
    return sem;
}

uint64 sys_sem_close(void) {
  int sem;
  argint(0, &sem);
    // Validamos el rango de sem y si está en uso
    if (sem < 1 || sem >= SEM_MAX) {
        return 0;
    }
    acquire(&semaforos[sem].lock);
    if (!semaforos[sem].in_use) {
        release(&semaforos[sem].lock);
        return 0;
    }
    semaforos[sem].in_use = 0;
    wakeup(&semaforos[sem]);
    release(&semaforos[sem].lock);
    return sem;
}

uint64 sys_sem_up(void) {
  int sem;
  argint(0, &sem);
    // Validamos rango y si está en uso
    if(sem < 1 || sem >= SEM_MAX) {
        return 0;
    }
    // adquirimos el cerrojo del semaforo
    acquire(&semaforos[sem].lock);
    if (!semaforos[sem].in_use) {
        release(&semaforos[sem].lock);
        return 0;
    }
    //Incrementamos el contador
    semaforos[sem].value++;
    //Despertamos los procesos que quedaron esperando
    wakeup(&semaforos[sem]);
    // Liberamos el cerrojo
    release(&semaforos[sem].lock);

    return sem;
}

uint64 sys_sem_down(void) {
  int sem;
  argint(0, &sem);
    //Validamos el rango y si está en uso
    if (sem < 1 || sem >= SEM_MAX) {
        return 0;
    }
    //Adquirimos el cerrojo del semaforo
    acquire(&semaforos[sem].lock);
    //Verificamos si el semaforo está cerrado
    if (!semaforos[sem].in_use) {
        release(&semaforos[sem].lock);
        return 0;
    }
    //Mientras el valor sea 0
    while(semaforos[sem].value == 0) {
        //Sie el semaforo este cerrado o el proceso fue terminado
        if (!semaforos[sem].in_use || killed(myproc())) {
            //Liberamos el lock
            release(&semaforos[sem].lock);
            return 0;
        }
        //Dormimos automaticamente liberando el lock
        sleep(&semaforos[sem], &semaforos[sem].lock);
    }
    //Al despertar y haber value > 0
    semaforos[sem].value--;
    release(&semaforos[sem].lock);

    return sem;
}