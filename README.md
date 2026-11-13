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
---

## Laboratorio 3: Sistema de Auditoria Forense FAT32-FUSE
Este proyecto forma parte de la materia Sistemas Operativos (FaMAF - UNC) y consiste en el diseño e implementación de un sistema de registro de operaciones criticas del filesystem en un log binario y desarollar un sistema que permite recuperar archivos.

### Descripcion General:
El proyecto consiste en un sistema de auditoría y recuperación forense integrado a un sistema de archivos FAT32 montado mediante FUSE. Su objetivo principal es registrar de manera persistente las operaciones críticas del filesystem en un log binario estructurado y proveer un mecanismo robusto para la recuperación de archivos borrados, detectando de forma automática conflictos ante la posible sobrescritura de clusters.

### Características Principales
1. Sistema de logs persistentes:

	•Creación automática de la estructura de auditoría al montar el filesystem.   

	•Estructura de eventos de tamaño fijo optimizada para registrar operaciones a bajo nivel.   

	•Registro detallado de operaciones críticas del sistema de archivos: write, unlink, mkdir y rmdir.   

2. Herramienta de Inspección:

	•Utilidad en C para leer y decodificar el archivo binario de eventos, mostrando un historial legible con marcas de tiempo, IDs secuenciales, tipos de operación y rutas.   

3. Recuperación de Archivos Borrados:

	•Implementación de la recuperación mediante comunicación con FUSE (vía ioctl o archivo de control).   

	•Análisis del historial de logs para reconstruir la cadena exacta de clusters de un archivo eliminado.   

	•Detección de colisiones: Verificación automática para comprobar si los clusters del archivo borrado fueron reutilizados o sobrescritos por operaciones posteriores, evitando reconstrucciones inconsistentes.   

### Decisiones de Arquitectura y Diseño:

1. Modularización: El código de auditoría se aísla de la lógica central del FUSE para mantener la mantenibilidad y limpieza del proyecto, implementando funciones dedicadas para la inicialización, escritura y lectura de eventos.   

2. Estructura de tamaño fijo (audit_event_t): Diseñada con un tamaño uniforme para facilitar el acceso aleatorio y la serialización binaria en disco, adaptándose a las limitaciones de los clusters del filesystem (por defecto, 512 bytes).   

### Compilación y Ejecución:

1. Montar el filesystem y compilar los componentes provistos:

	```make```

2. Ejecutar el lector de auditoría:

	```./audit_reader /mnt/fuse/.audit/events.bin```

3. Recuperar un archivo borrado
	
	```./restore /mnt/fuse /dir1/file.txt```V