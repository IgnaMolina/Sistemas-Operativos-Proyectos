# PROYECTO FUSE EQUIPO UBUNTU 2026

## Decisiones de Diseño

La primera decisión de diseño que tuvimos que enfrentar fue la ubicación del archivo de auditoría, el `events.bin`. Teníamos dos opciones: dejarlo como un archivo regular dentro del propio sistema de archivos o guardarlo externamente en el disco del sistema anfitrión.

Decidimos, principalmente por portabilidad, almacenarlo de la primera forma, ya que toda la auditoría viaja junto con la imagen y cualquier operación sobre ella es totalmente autocontenida. En nuestro código se ve la función `audit_ensure`, que utiliza las propias estructuras del árbol FUSE de la imagen.

La segunda decisión fue sobre el mecanismo de persistencia y registro de eventos transaccionales (`OP_UNLINK`, `OP_WRITE`, etc.). Debíamos implementar un sistema de registro basado en un archivo binario de eventos de tamaño fijo (`audit_event_t`) manejado por funciones dedicadas de *append*. Esto permite mantener un historial cronológico robusto de las operaciones de modificación, registrando metadatos clave que de otro modo se perderían al liberar los bloques en disco.

* **Almacenamiento de metadatos de respaldo en el evento de borrado (`cluster_chain` y `file_size`):** Copiar y guardar explícitamente en el evento `OP_UNLINK` la cadena completa de clusters y el tamaño exacto del archivo al momento de la eliminación. Cuando se marca una entrada como borrada (`0xE5`), la tabla FAT libera los punteros a los bloques y se pierde la traza de longitud. Guardar esta estructura en el evento de auditoría es lo que hace posible la restauración.
* **Gestión de colisiones y exclusión mutua con el archivo temporal:** Diseñar una validación inteligente durante la verificación de clusters ocupados que detecte si un bloque en conflicto está retenido exclusivamente por el proceso o archivo auxiliar de restauración. Esto evita falsos positivos de "clusters sobrescritos" al intentar restaurar un archivo, permitiendo liberar de manera controlada y temporal esos punteros para completar la recuperación de la cadena en la tabla FAT sin romper el volumen.
* **Reconstrucción directa del directorio y re-inserción dinámica en FUSE:** Restaurar la entrada de directorio original ubicando el marcador de borrado (`0xE5`), reescribiendo la base del nombre corto en formato 8.3 junto con sus clusters, y volviendo a inyectar el nodo en el árbol de directorios virtuales de memoria. Esto evita la necesidad de desmontar y volver a montar el sistema de archivos para ver los cambios, logrando que el archivo recuperado aparezca de forma transparente e inmediata para el usuario.

---

## Modularización del Código

Para este aspecto decidimos modularizar lo que más pudimos en el archivo `audit.c`, empezando por el logueo de la carpeta `/.audit` y el archivo `events.bin`. 

En este aspecto nos dimos cuenta de que la lógica era similar para ambos; sin embargo, debíamos duplicar el código que buscaba la información necesaria para cada uno, por eso creamos `audit_ensure`. Esa función toma un volumen, el nodo del padre, un path y un booleano que sirve para distinguir entre `/.audit` y `events.bin`. Luego, `audit_init` llama a esta función y crea o vincula el archivo.

Luego, al empezar a trabajar con las funciones de *write*, *unlink*, *mkdir* y *rmdir*, nos dimos cuenta de que muchas de ellas rellenan campos similares, por eso modularizamos las funciones `audit_append` y `audit_fill_common`. La primera tiene implementada la lógica de búsqueda de nodos, validación de punteros y escritura en disco dentro de cada función de registro; la segunda rellena los campos más comunes como *timestamp*, *operation type* o *filepath*. Además, la función *unlink* delega la función de recorrer la tabla FAT para rastrear los bloques.

Nos hubiera gustado modularizar algunas partes del *restore*, delegando responsabilidades; sin embargo, por falta de tiempo decidimos dejar el "choclo" de código. ¡Algún día lo implementaremos ^-^!

---

## ¿Qué guarda cada tipo de operación y por qué?

* **`OP_WRITE`:** Decidimos almacenar el *offset* de la escritura, el tamaño de los datos escritos y la cantidad de clusters. Esto nos permite auditar modificaciones sobre los archivos registrando con precisión dónde y cuánto se escribió.
* **`OP_UNLINK`:** Además de la información básica de `audit_fill_common`, acá debemos guardar el tamaño exacto del archivo (`file_size`), la cantidad total de clusters ocupados (`num_clusters`) y la cadena completa del bloque físico (`cluster_chain[]`). Decidimos almacenar estos datos porque esta operación es el núcleo del sistema de recuperación. Guardar explícitamente la cadena de clusters y el tamaño en el momento justo del borrado es el único medio que hace posible la reconstrucción del archivo; para eso necesitamos su tamaño exacto, la cantidad de clusters que debemos recuperar y la cadena de punteros que los conectan.
* **`OP_MKDIR` y `OP_RMDIR`:** Consideramos relevante guardar el cluster del directorio (`dir_cluster`) asociado a la operación. Esto nos permite llevar un control de la topología y la jerarquía dentro del sistema de archivos.

---

## Explicación del Sistema Restore

### 1. Extracción del Evento de Auditoría
El proceso inicia recorriendo secuencialmente el archivo `events.bin` para localizar el registro `OP_UNLINK` de la ruta solicitada. De allí se extraen metadatos críticos que la FAT estándar pierde al borrar: el tamaño exacto del archivo (`file_size`) y la cadena completa de bloques (`cluster_chain`).

### 2. Detección de Colisiones
Durante la recuperación, la herramienta utiliza un archivo temporal (`/.audit/.restore`). El algoritmo detecta si un bloque en conflicto pertenece exclusivamente a este proceso auxiliar, permitiendo liberarlo de forma temporal y controlada mediante `fat_table_set_next_cluster` para evitar falsos positivos de sobrescripción. Si el bloque pertenece a otro archivo real, la operación se aborta para prevenir corrupciones.

### 3. Descarte de la Estrategia `ioctl`
En la fase de diseño inicial se evaluó el uso de llamadas `ioctl` para comandar la restauración desde el kernel. Sin embargo, se descartó por complicaciones a la hora de compilar, por eso decidimos implementar la opción 2, con funciones de bajo nivel en C y manipulación de la FAT.

### 4. Reconstrucción y Re-inserción
* **Reconstrucción FAT:** Se re-enlazan los clusters en la tabla marcando el último con la marca de fin de cadena (`FAT_CLUSTER_END_OF_CHAIN_MAX`).
* **Restauración de la Dentry:** Se localiza la entrada borrada (`0xE5`) en el directorio padre, normalizando el nombre corto en mayúsculas (formato 8.3) y actualizando el tamaño y los punteros del cluster de inicio.
* **Inyección en FUSE:** Se instancia la estructura `fat_file` y se reinserta dinámicamente en el árbol virtual (`vol->file_tree`) mediante `fat_tree_insert`, haciendo que el archivo reaparezca de forma transparente e inmediata (accesible vía `cat`) sin necesidad de reiniciar el punto de montaje.

---

## Enlace al video
* **https://drive.google.com/drive/u/0/folders/16p_lEaXNqu2o-VY-YPUkK973pxhRSCk9

## Pérdida del primer carácter en la recuperación de archivos .txt:
* **Durante las pruebas de restauración, observamos que en algunos casos el primer carácter del archivo recuperado no coincide con el original o es reemplazado por un byte residual (por ejemplo, \0 o un carácter extraño). Inicialmente se sospechó de un error de cálculo en los desplazamientos (offsets) o en los punteros de los clústeres. Tambien podria ser algun tipo de "basura" que quede molestando ese bit de informacion.