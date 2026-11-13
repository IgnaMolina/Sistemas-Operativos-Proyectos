#include <check.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

#include "../audit.h"      // ajustá la ruta
#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wformat-truncation"
#endif

static char test_image[256];
static char mount_point[256];
static pid_t fuse_pid = 0;

static void get_test_path(char *buffer, size_t size, const char *filename) {
    snprintf(buffer, size, "%s/%s", mount_point, filename);
}

void setup_clean_dir(void) {
    DIR *dir = opendir(mount_point);
    if (!dir) return;
    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0 ||
            strcmp(entry->d_name, ".audit") == 0)      // no tocar el log
            continue;
        char filepath[512], cmd[600];
        snprintf(filepath, sizeof(filepath), "%s/%s", mount_point, entry->d_name);
        unlink(filepath);
        rmdir(filepath);
        snprintf(cmd, sizeof(cmd), "rm -rf %s 2>/dev/null", filepath);
        system(cmd);
    }
    closedir(dir);
}




void setup_mount_fs(void) {
    printf("\n⏳ Setting up filesystem (once per suite)...\n");

    // Create unique temporary paths
    snprintf(test_image, sizeof(test_image), "/tmp/test_fat_%d.img",
             getpid());
    snprintf(mount_point, sizeof(mount_point), "/tmp/fuse_mnt_%d", getpid());

    // Copy base image from resources
    char cmd[512];
    printf("  Copying base image to: %s\n", test_image);
    snprintf(cmd, sizeof(cmd), "cp ../resources/test_empty.img %s",
             test_image);
    int ret = system(cmd);
    ck_assert_msg(ret == 0, "Failed to copy base image");

    // Create mount point directory
    printf("  Creating mount point: %s\n", mount_point);
    ret = mkdir(mount_point, 0755);
    ck_assert_msg(ret == 0, "Failed to create mount point: %s",
                  strerror(errno));

    // Mount filesystem in background
    printf("  Mounting filesystem...\n");
    fuse_pid = fork();
    ck_assert_msg(fuse_pid >= 0, "Failed to fork: %s", strerror(errno));

    if (fuse_pid == 0) {
        // Child process: execute fat-fuse
        // Redirect output to avoid clutter
        freopen("/dev/null", "w", stdout);
        freopen("/dev/null", "w", stderr);
        execlp("../fat-fuse", "fat-fuse", test_image, mount_point, NULL);
        exit(1); // Should not reach here
    } 

    // Wait for filesystem to mount
    sleep(2);

    // Verify mount succeeded by trying to open the directory
    DIR *dir = opendir(mount_point);
    ck_assert_msg(dir != NULL, "Failed to open mount point: %s",
                  strerror(errno));
    closedir(dir);

    printf("✅ Filesystem mounted successfully\n\n");
}

/**
 * @brief Teardown: Unmount and cleanup filesystem
 *
 * This runs ONCE after all tests in the suite.
 */
void teardown_unmount_fs(void) {
    printf("\n🧹 Cleaning up filesystem...\n");

    // Unmount filesystem
    char cmd[512];
#ifdef __APPLE__
    snprintf(cmd, sizeof(cmd), "umount %s 2>/dev/null || "
                                "diskutil unmount force %s 2>/dev/null",
             mount_point, mount_point);
#else
    snprintf(cmd, sizeof(cmd), "fusermount -u %s 2>/dev/null || "
                                "umount %s 2>/dev/null",
             mount_point, mount_point);
#endif
    system(cmd);

    // Wait for fuse process to exit
    if (fuse_pid > 0) {
        int status;
        waitpid(fuse_pid, &status, 0);
    }

    // Remove mount point and image
    rmdir(mount_point);
    unlink(test_image);

    printf("✅ Cleanup complete\n\n");
}

void teardown_verify(void) {
    // Could add checks here to verify FS is still accessible
    // For now, just verify we can still read the directory
    DIR *dir = opendir(mount_point);
    ck_assert_msg(dir != NULL, "Filesystem became inaccessible");
    closedir(dir);
}

/*static int read_events(audit_event_t *out, int max) {
    char path[512];
    get_test_path(path, sizeof(path), ".audit/events.bin");
    FILE *f = fopen(path, "rb");
    if (!f) return -1;
    int n = fread(out, sizeof(audit_event_t), max, f);
    fclose(f);
    return n;   // cantidad de eventos leídos
}*/

static int count_events(void) {
    char p[512];
    get_test_path(p, sizeof(p), ".audit/events.bin");
    struct stat st;
    if (stat(p, &st) != 0) return -1;
    return st.st_size / sizeof(audit_event_t);
}

static int read_last_event(audit_event_t *ev) {
    char p[512];
    get_test_path(p, sizeof(p), ".audit/events.bin");
    int n = count_events();
    if (n <= 0) return -1;
    FILE *f = fopen(p, "rb");
    if (!f) return -1;
    fseek(f, (long)(n - 1) * sizeof(audit_event_t), SEEK_SET);
    int ok = fread(ev, sizeof(*ev), 1, f);
    fclose(f);
    return ok == 1 ? 0 : -1;
}

static void assert_last_event(operation_type_t op, const char *path) {
    audit_event_t ev;
    ck_assert_int_eq(read_last_event(&ev), 0);
    ck_assert_int_eq(ev.operation_type, op);
    ck_assert_str_eq(ev.filepath, path);
}

START_TEST(test_audit_dir_exists){
    char path[512];
    get_test_path(path,sizeof(path),".audit");

    struct stat st;
    int ret =stat(path,&st);
    ck_assert_msg(ret == 0, ".audit no existe: %s", strerror(errno));
    ck_assert_msg(S_ISDIR(st.st_mode), ".audit no es un directorio");
}
END_TEST

START_TEST(test_audit_log_exists){
    char path[512];
    get_test_path(path,sizeof(path),".audit/events.bin");

    struct stat st;
    int ret =stat(path,&st);
    ck_assert_msg(ret == 0, "events.bin no existe: %s", strerror(errno));
    ck_assert_msg(S_ISREG(st.st_mode), "events.bin no es un archivo");
}
END_TEST

START_TEST(test_mkdir_is_logged){
    char dir1[512];
    get_test_path(dir1, sizeof(dir1), "creado");
    
    int antes =count_events();

    ck_assert_int_eq(mkdir(dir1, 0755), 0);
    sleep(2);
    int despues = count_events();

    ck_assert_int_eq(despues, antes+1);
    
    assert_last_event(OP_MKDIR, "/creado");

}
END_TEST

START_TEST(test_rmdir_is_logged){
    char dir[512];
    get_test_path(dir, sizeof(dir), "borrame");

    ck_assert_int_eq(mkdir(dir, 0755), 0);

    int antes =count_events();
    ck_assert_int_eq(rmdir(dir), 0);
    sleep(2);
    int despues= count_events();

    ck_assert_int_eq(despues, antes+1);
    
    assert_last_event(OP_RMDIR, "/borrame");
}
END_TEST

START_TEST(test_write_is_logged) {
    char p[512];
    get_test_path(p, sizeof(p), "datos.txt");

    // Preparación: crear el archivo vacío
    FILE *f = fopen(p, "w");
    ck_assert_ptr_nonnull(f);
    fclose(f);

    int antes = count_events();              // contar después de preparar

    // La operación: escribir
    f = fopen(p, "w");
    ck_assert_ptr_nonnull(f);
    fprintf(f, "hola");
    fclose(f);                               // importante: fuerza el write

    sleep(2);
    int despues = count_events();
    ck_assert_int_gt(despues, antes);        // al menos un evento nuevo

    assert_last_event(OP_WRITE, "/datos.txt");
}
END_TEST

START_TEST(test_unlink_is_logged) {
    char p[512];
    get_test_path(p, sizeof(p), "borrame.txt");

    // Preparación: crear archivo con contenido (genera sus propios eventos de write)
    FILE *f = fopen(p, "w");
    ck_assert_ptr_nonnull(f);
    fprintf(f, "hola");          // 4 bytes
    fclose(f);

    int antes = count_events();  // contar DESPUÉS de preparar
    ck_assert_int_eq(unlink(p), 0);
    sleep(2);
    int despues = count_events();

    ck_assert_int_eq(despues, antes + 1);   // exactamente un evento: el unlink

    audit_event_t ev;
    ck_assert_int_eq(read_last_event(&ev), 0);
    ck_assert_int_eq(ev.operation_type, OP_UNLINK);
    ck_assert_str_eq(ev.filepath, "/borrame.txt");
    ck_assert_uint_eq(ev.data.unlink_data.file_size, 4);
    //ck_assert_uint_eq(ev.data.unlink_data.num_clusters, 1);   // 4 bytes caben en un cluster
}
END_TEST

Suite *audit_test(void){
    Suite *s = suite_create("Audit");
    TCase *tc = tcase_create("Audit");
    tcase_add_unchecked_fixture(tc, setup_mount_fs, teardown_unmount_fs);
    tcase_add_checked_fixture(tc, setup_clean_dir, teardown_verify);
    tcase_set_timeout(tc, 60);

    tcase_add_test(tc, test_audit_dir_exists);
    tcase_add_test(tc, test_audit_log_exists);
    tcase_add_test(tc, test_mkdir_is_logged);
    tcase_add_test(tc, test_rmdir_is_logged);
    tcase_add_test(tc, test_write_is_logged);
    tcase_add_test(tc, test_unlink_is_logged);

    suite_add_tcase(s, tc);
    return s;
}




int main(void) {
    int number_failed;
    Suite *s = audit_test();
    SRunner *sr = srunner_create(s);

    // Run tests
    srunner_run_all(sr, CK_VERBOSE);
    number_failed = srunner_ntests_failed(sr);
    srunner_free(sr);

    return (number_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}

#if defined(__GNUC__) && !defined(__clang__)
#pragma GCC diagnostic pop
#endif