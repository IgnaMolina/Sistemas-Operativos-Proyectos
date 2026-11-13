# Sistemas-Operativos-Proyectos

**Este repositorio cuenta con 3 sub carpetas, cada una correspondiente a un proyecto de la materia Sistemas Operativos**
---
## Laboratorio 2: Sistema de Semáforos y Sincronización en XV6
Este proyecto forma parte de la materia Sistemas Operativos (FaMAF - UNC) y consiste en el diseño e implementación de un sistema de semáforos nombrados en espacio de kernel para la versión RISC-V del sistema operativo académico XV6, permitiendo la sincronización segura entre procesos de usuario.

### Descripción General
Los semáforos implementados siguen una inspiración en el estándar POSIX y son administrados globalmente por el kernel. Para lograrlo, se diseñaron y añadieron llamadas al sistema (syscalls) de gestión, asegurando la exclusión mutua y evitando condiciones de carrera mediante el uso primitivas del kernel como ```acquire(), release(), sleep() y wakeup().```

### Archivos relevantes:

•kernel/sem.c: Núcleo de la lógica de administración de semáforos, manejo de colas de bloqueo e interacción con las estructuras de control de procesos.

•kernel/syscall.c y user/user.h: Registro y declaración de las nuevas syscalls en el espacio de usuario y kernel.

•user/pingpong.c: Implementación del programa de alternancia estricta por turnos.

•user/prodcons.c: Implementación del patrón de buffer acotado productor-consumidor.

### Compilacion:
Para compilar y correr este proyecto de forma local, es necesario contar con el emulador QEMU para arquitecturas RISC-V y un compilador compatible:

#### Instrucción de dependencias (Ubuntu):

```sudo apt-get install qemu-system-riscv64 gcc-riscv64-linux-gnu```

#### Compilación y Ejecuccion:
Si tu sistema operativo utiliza por defecto una versión superior de GCC (como GCC 15) que pueda generar incompatibilidades con los binarios de XV6, puedes forzar el uso del compilador o la versión adecuada ejecutando el comando de make de la siguiente manera:

```make qemu CC="riscv64-linux-gnu-gcc -std=gnu17"```

#### Comando de uso en la Shell de XV6
```
• make qemu

• pingpong n  (n siendo cualquier valor que el usuario desee)

• prodcons B N  (B siendo el buffer y N la cantidad de ítems)

• prodcons B N P C  (P cantidad de procesos productores y C cantidad de procesos consumidores)
```