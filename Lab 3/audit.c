#include "fat_file.h"
#include "fat_fs_tree.h"
#include "fat_table.h"
#include "fat_types.h"
#include "audit.h"
#include "fat_fuse_ops.h"
#include "fat_volume.h"

#include <fuse/fuse.h>
#include <pwd.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <libgen.h>
#include "fat_filename_util.h"

#define AUDIT_DIR_PATH "/.audit"
#define AUDIT_LOG_PATH "/.audit/events.bin"

static uint64_t event_counter;

/* Búsqueda y creación segura de nodos */
static fat_tree_node audit_ensure(fat_volume vol, fat_tree_node parent_node, const char *path, bool is_dir) {
    fat_tree_node node = fat_tree_node_search(vol->file_tree, path);
    if (node != NULL) {
        return node;
    }
    fat_file parent = fat_tree_get_file(parent_node);
    if (parent == NULL) {
        return NULL;
    }

    fat_file f = fat_file_init(vol->table, is_dir, strdup(path));
    if (f == NULL) {
        return NULL;
    }

    f->pos_in_parent = parent->dir.nentries;
    fat_file_add_child_direntry(parent, f->dentry, f->pos_in_parent);
    parent->dir.nentries++;

    vol->file_tree = fat_tree_insert(vol->file_tree, parent_node, f);
    
    return fat_tree_node_search(vol->file_tree, path);
}

/* Escritura blindada en el archivo de eventos */
static int audit_append(fat_volume vol, audit_event_t *ev) {
    fat_tree_node dir_node = fat_tree_node_search(vol->file_tree, AUDIT_DIR_PATH);
    if (dir_node == NULL) {
        return -1;
    }
    
    fat_tree_node node = fat_tree_node_search(vol->file_tree, AUDIT_LOG_PATH);
    if (node == NULL) {
        node = audit_ensure(vol, dir_node, AUDIT_LOG_PATH, false);
        if (node == NULL) {
            return -1;
        }
    }

    fat_file file = fat_tree_get_file(node);
    fat_file parent = fat_tree_get_file(dir_node);
    if (file == NULL || file->dentry == NULL || parent == NULL) {
        return -1;
    }

    ev->event_id = event_counter;

    ssize_t written = fat_file_pwrite(file, ev, sizeof(audit_event_t),
                                      event_counter * sizeof(audit_event_t), parent);
    if (written != (ssize_t)sizeof(audit_event_t)) {
        return -1; 
    }
    
    event_counter++;
    return 0;
}

int audit_init(fat_volume vol) {
    fat_tree_node root = fat_tree_node_search(vol->file_tree, "/");
    if (root == NULL) {
        return 1;
    }

    fat_tree_node dir = audit_ensure(vol, root, "/.audit", true);
    if (dir == NULL) {
        return 1;
    }

    fat_tree_node log = audit_ensure(vol, dir, "/.audit/events.bin", false);
    if (log == NULL) {
        return 1;
    }
    
    fat_file file = fat_tree_get_file(log);
    if (file == NULL || file->dentry == NULL) {
        return -1;
    }

    uint32_t file_size = file->dentry->file_size;
    event_counter = file_size / sizeof(audit_event_t);
    return 0;
}

static void audit_fill_common(audit_event_t *ev, operation_type_t op, const char* path){
    ev->timestamp = (uint64_t)time(NULL);
    ev->operation_type = (uint64_t)op;

    if(path != NULL){
        strncpy(ev->filepath, path, sizeof(ev->filepath) - 1);
    }

    struct fuse_context *ctx = fuse_get_context();
    if(ctx != NULL){
        struct passwd *pw = getpwuid(ctx->uid);
        if(pw != NULL){
            strncpy(ev->username, pw->pw_name, sizeof(ev->username) - 1);
        } else {
            snprintf(ev->username, sizeof(ev->username), "%u", (unsigned)ctx->uid);
        }
    }
}

int audit_log_write(fat_volume vol, const char *path, off_t offset, size_t size) {
    if (path == NULL || strncmp(path, AUDIT_DIR_PATH, strlen(AUDIT_DIR_PATH)) == 0) {
        return 0; // Evita bucles infinitos de reentrancia al escribir en events.bin
    }

    audit_event_t ev = {0};
    audit_fill_common(&ev, OP_WRITE, path);
    ev.data.write_data.offset = (uint64_t)offset;
    ev.data.write_data.size = (uint64_t)size;
    ev.data.write_data.num_clusters = 0; 

    return audit_append(vol, &ev);
}

static uint32_t audit_collect_chain(fat_file file, uint32_t *out, uint32_t max) {
    uint32_t n = 0, c = file->start_cluster;
    while (c >= 2 && !fat_table_cluster_is_EOC(c) && n < max) {
        out[n++] = c;
        c = fat_table_read_cluster_value(file->table, c);
    }
    return n;
}

int audit_log_unlink(fat_volume vol, const char *path, fat_file file) {
    if (path == NULL || file == NULL) {
        return -1;
    }
    if (strncmp(path, AUDIT_DIR_PATH, strlen(AUDIT_DIR_PATH)) == 0) {
        return 0;
    }
    audit_event_t ev = {0};
    audit_fill_common(&ev, OP_UNLINK, path);

    uint32_t temp_chain[MAX_UNLINK_CLUSTERS];
    uint32_t collected = audit_collect_chain(file, temp_chain, MAX_UNLINK_CLUSTERS);

    ev.data.unlink_data.num_clusters = collected;
    for (uint32_t j = 0; j < collected; j++) {
        ev.data.unlink_data.cluster_chain[j] = temp_chain[j];
    }

    ev.data.unlink_data.file_size = file->dentry->file_size;
    return audit_append(vol, &ev);
}

int audit_log_mkdir(fat_volume vol, const char *path, uint32_t dir_cluster) {
    if (path == NULL || strncmp(path, AUDIT_DIR_PATH, strlen(AUDIT_DIR_PATH)) == 0)
        return 0;

    audit_event_t ev = {0};
    audit_fill_common(&ev, OP_MKDIR, path);
    ev.data.dir_data.dir_cluster = dir_cluster; 
    return audit_append(vol, &ev);
}

int audit_log_rmdir(fat_volume vol, const char *path, uint32_t dir_cluster) {
    if (path == NULL) {
        return -1;
    }
    if (strncmp(path, AUDIT_DIR_PATH, strlen(AUDIT_DIR_PATH)) == 0) {
        return 0;
    }

    audit_event_t ev = {0};
    audit_fill_common(&ev, OP_RMDIR, path);
    ev.data.dir_data.dir_cluster = dir_cluster;

    return audit_append(vol, &ev);
}

int audit_restore_file(fat_volume vol, char *path) {
    if (vol == NULL || path == NULL) {
        return -1;
    }

    fat_tree_node log_node = fat_tree_node_search(vol->file_tree, "/.audit/events.bin");
    if (log_node == NULL) {
        fprintf(stderr, "Error: No se pudo acceder a events.bin.\n");
        return -1;
    }
    fat_file log_file = fat_tree_get_file(log_node);
    fat_file log_parent = fat_tree_get_parent(log_node);
    if (log_file == NULL || log_file->dentry == NULL || log_parent == NULL) {
        return -1;
    }

    uint32_t file_size = log_file->dentry->file_size;
    if (file_size == 0) {
        fprintf(stderr, "Error: El archivo de log está vacío.\n");
        return -1;
    }

    size_t total_events = file_size / sizeof(audit_event_t);
    
    audit_event_t ev = {0};
    audit_event_t target_ev = {0};
    bool found = false;
    uint32_t num_clusters = 0;

    for (size_t i = 0; i < total_events; i++) {
        ssize_t bytes_read = fat_file_pread(log_file, &ev, sizeof(audit_event_t), i * sizeof(audit_event_t), log_parent); 
        if (bytes_read != (ssize_t)sizeof(audit_event_t)) {
            break; 
        }

        if (ev.operation_type == OP_UNLINK && strcmp(ev.filepath, path) == 0) {
            target_ev = ev; 
            found = true;
            num_clusters = ev.data.unlink_data.num_clusters;
            if (num_clusters > MAX_UNLINK_CLUSTERS) {
                num_clusters = MAX_UNLINK_CLUSTERS;
            }
        }
    }
    
    if (!found) {
        fprintf(stderr, "Error: No se encontró un registro de eliminación para '%s'.\n", path);
        return -1; 
    }
    
    if (num_clusters == 0) {
        fprintf(stderr, "Error: El archivo no tiene clusters registrados.\n");
        return -1;
    }

    //Verificación de colisión de clusters (ignorando si lo ocupa temporalmente .restore)
    for (uint32_t j = 0; j < num_clusters; j++) {
        uint32_t cluster = target_ev.data.unlink_data.cluster_chain[j];
        if (fat_table_is_cluster_used(vol->table, cluster)) {
            fat_tree_node restore_node = fat_tree_node_search(vol->file_tree, "/.audit/.restore");
            bool used_by_restore = false;
            if (restore_node != NULL) {
                fat_file restore_file = fat_tree_get_file(restore_node);
                if (restore_file != NULL) {
                    uint32_t c = restore_file->start_cluster;
                    while (c >= 2 && !fat_table_cluster_is_EOC(c)) {
                        if (c == cluster) {
                            used_by_restore = true;
                            break;
                        }
                        c = fat_table_read_cluster_value(vol->table, c);
                    }
                }
            }

            if (!used_by_restore) {
                fprintf(stderr, "Error: No se puede restaurar '%s'. Clusters ocupados/sobrescritos.\n", path);
                return -1; 
            } else {
                fat_table_set_next_cluster(vol->table, cluster, FAT_CLUSTER_FREE);
            }
        }
    }

    //Reconstrucción de la cadena en la FAT
    for (uint32_t k = 0; k < num_clusters - 1; k++) {
        uint32_t cur = target_ev.data.unlink_data.cluster_chain[k];
        uint32_t next = target_ev.data.unlink_data.cluster_chain[k+1];
        fat_table_set_next_cluster(vol->table, cur, next);
    }
    
    if (num_clusters > 0) {
        uint32_t last = target_ev.data.unlink_data.cluster_chain[num_clusters - 1];
        fat_table_set_next_cluster(vol->table, last, FAT_CLUSTER_END_OF_CHAIN_MAX);
    }

    //Restaurar la Dentry en el directorio padre y reinsertar en el árbol de FUSE
    char *path_copy = strdup(path);
    char *parent_path = dirname(path_copy);
    fat_tree_node parent_node = fat_tree_node_search(vol->file_tree, parent_path);
    free(path_copy);

    if (parent_node != NULL) {
        fat_file parent_file = fat_tree_get_file(parent_node);
        u32 bytes_per_cluster = fat_table_bytes_per_cluster(vol->table);
        u8 *buf = alloca(bytes_per_cluster);
        u32 cur_cluster = parent_file->start_cluster;
        bool restored_dentry = false;
        u32 pos = 0;

        while (fat_table_cluster_is_valid(cur_cluster) && !restored_dentry) {
            off_t cur_offset = fat_table_cluster_offset(vol->table, cur_cluster);
            if (full_pread(vol->table->fd, buf, bytes_per_cluster, cur_offset) != bytes_per_cluster) {
                break;
            }
            fat_dir_entry dentry_ptr = (fat_dir_entry)buf;
            u32 entries_per_cluster = bytes_per_cluster / sizeof(struct fat_dir_entry_s);

            for (u32 e = 0; e < entries_per_cluster; e++, pos++) {
                if (dentry_ptr[e].base_name[0] == 0x00) break; // Fin del directorio

                // Verificamos si es una entrada borrada (0xE5) cuyo nombre coincida
                if (dentry_ptr[e].base_name[0] == 0xE5) {
                    u8 expected_base[8];
                    u8 expected_ext[3];
                    
                    char *p_copy = strdup(path);
                    split_filepath_to_filename(basename(p_copy), expected_base, expected_ext);
                    free(p_copy);

                    // Comparamos la extensión y el resto del nombre
                    if (memcmp(dentry_ptr[e].extension, expected_ext, 3) == 0 &&
                        memcmp(dentry_ptr[e].base_name + 1, expected_base + 1, 7) == 0) {
                        
                        // Restauramos los 8 bytes completos de la base (recuperando la inicial)
                        memcpy(dentry_ptr[e].base_name, expected_base, 8);
                        dentry_ptr[e].file_size = target_ev.data.unlink_data.file_size;
                        
                        // Asignamos el start cluster correcto
                        u32 start_c = target_ev.data.unlink_data.cluster_chain[0];
                        u32 start_c_le = cpu_to_le32(start_c);
                        char *src = (char *)&start_c_le;
                        dentry_ptr[e].start_cluster_low = le16_to_cpu(*(le16*)&src[0]);
                        dentry_ptr[e].fat32_start_cluster_high = le16_to_cpu(*(le16*)&src[2]);

                        // Escribimos el cluster del padre actualizado a disco
                        full_pwrite(vol->table->fd, buf, bytes_per_cluster, cur_offset);

                        // Creamos la estructura fat_file y la reinsertamos en el árbol de FUSE
                        fat_file restored_file = calloc(1, sizeof(struct fat_file_s));
                        restored_file->dentry = calloc(1, sizeof(struct fat_dir_entry_s));
                        memcpy(restored_file->dentry, &dentry_ptr[e], sizeof(struct fat_dir_entry_s));
                        restored_file->start_cluster = start_c;
                        restored_file->table = vol->table;
                        restored_file->filepath = strdup(path);
                        strncpy(restored_file->name, basename(path), MAX_FILENAME - 1);
                        restored_file->pos_in_parent = pos;

                        vol->file_tree = fat_tree_insert(vol->file_tree, parent_node, restored_file);
                        restored_dentry = true;
                        break;
                    }
                }
            }
            cur_cluster = fat_table_read_cluster_value(vol->table, cur_cluster);
        }
    }

    fprintf(stdout, "Éxito: El archivo '%s' ha sido restaurado completamente.\n", path);
    return 0;
}