#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Uso: %s <punto_de_montaje> <path_del_archivo>\n", argv[0]);
        return 1;
    }

    char restore_path[4096];
    snprintf(restore_path, sizeof(restore_path), "%s/.audit/.restore", argv[1]);

    int fd = open(restore_path, O_WRONLY | O_CREAT, 0644);
    if (fd < 0) {
        perror("Error al abrir el archivo de control de restauración");
        return 1;
    }

    ssize_t written = write(fd, argv[2], strlen(argv[2]));
    if (written < 0) {
        perror("Error en la restauración (escritura falló)");
        close(fd);
        return 1;
    }

    close(fd);
    fprintf(stdout, "Éxito: Petición de restauración enviada para '%s'.\n", argv[2]);
    return 0;
}