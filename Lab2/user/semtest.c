#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

/*
 * semtest — harness de pruebas de syscalls (kickstarter; alumnos y docentes).
 * Usa sem_open() como en el enunciado. Si la implementación solo expone
 * sem_init(), el alias de abajo permite correr los tests igual.
 */


#define TEST_SEM 1

static void usage(void) {
  printf("semtest: uso: semtest <noinit|init N|closeuse|exhaust|grow|reopen>\n");
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    usage();
    exit(1);
  }
  if (strcmp(argv[1], "noinit") == 0) {
    int ok = sem_down(TEST_SEM);
    if (ok == 0) {
      printf("error: semáforo no inicializado\n");
    } else {
      printf("inesperado: down exitoso sin open\n");
    }
    exit(0);
  } else if (strcmp(argv[1], "init") == 0) {
    int v = 0;
    if (argc >= 3) v = atoi(argv[2]);
    if (sem_open(TEST_SEM, v)) {
      printf("init: %d\n", v);
      printf("value=%d\n", v);
      sem_close(TEST_SEM);
    } else {
      printf("error: init falló\n");
    }
    exit(0);
  } else if (strcmp(argv[1], "closeuse") == 0) {
    if (!sem_open(TEST_SEM, 1)) {
      printf("error: init falló\n");
      exit(0);
    }
    sem_close(TEST_SEM);
    int ok = sem_up(TEST_SEM);
    if (ok == 0) {
      printf("cerrado (closed)\n");
      printf("error: no se puede usar tras cierre\n");
    } else {
      printf("inesperado: up exitoso tras cierre\n");
    }
    exit(0);
  } else if (strcmp(argv[1], "exhaust") == 0) {
    if (!sem_open(TEST_SEM, 1)) {
      printf("error: init falló\n");
      exit(0);
    }
    if (sem_down(TEST_SEM)) {
      printf("agotado (exhausted)\n");
    } else {
      printf("error: down falló\n");
    }
    sem_close(TEST_SEM);
    if (sem_open(TEST_SEM, 1)) {
      printf("reutilización (reuse)\n");
      sem_close(TEST_SEM);
    } else {
      printf("error: abrir para reutilización falló\n");
    }
    exit(0);
  } else if (strcmp(argv[1], "grow") == 0) {
    if (!sem_open(TEST_SEM, 0)) {
      printf("error: init falló\n");
      exit(0);
    }
    if (sem_up(TEST_SEM) && sem_up(TEST_SEM)) {
      printf("grow ok\n");
      printf("contador supera valor inicial\n");
    } else {
      printf("error: sem_up no permitió crecer mas alla del valor inicial\n");
    }
    sem_close(TEST_SEM);
    exit(0);
  } else if (strcmp(argv[1], "reopen") == 0) {
    if (!sem_open(TEST_SEM, 1)) {
      printf("error: primer open falló\n");
      exit(0);
    }
    if (sem_open(TEST_SEM, 5) == 0) {
      printf("error: doble open rechazado\n");
    } else {
      printf("inesperado: doble open permitido\n");
    }
    sem_close(TEST_SEM);
    exit(0);
  } else {
    usage();
    exit(1);
  }
}
