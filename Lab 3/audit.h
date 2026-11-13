#ifndef AUDIT_H
#define AUDIT_H

#include <stdint.h>
#include "fat_volume.h"


/* Operation types for audit logging */
typedef enum {
    OP_WRITE = 0,
    OP_UNLINK = 1,
    OP_MKDIR = 2,
    OP_RMDIR = 3,
    OP_MKNOD = 4,
} operation_type_t;

/* Maximum number of clusters that can be tracked for different operations */
#define MAX_WRITE_CLUSTERS 8
#define MAX_UNLINK_CLUSTERS 32

typedef struct __attribute__((packed)) {
    uint64_t event_id;
    uint64_t timestamp;
    uint32_t operation_type;
    char username[64];
    char filepath[256];

    union {
        struct {
            uint64_t offset;
            uint64_t size;
            uint32_t clusters_used[MAX_WRITE_CLUSTERS];
            uint32_t num_clusters;
        } write_data;

        struct {
            uint32_t cluster_chain[MAX_UNLINK_CLUSTERS];
            uint32_t file_size;
            uint32_t num_clusters;
        } unlink_data;

        struct {
            uint32_t dir_cluster;
        } dir_data;

        struct {
            uint32_t start_cluster;
        } mknod_data;
    } data;

    uint8_t _padding[36];
} audit_event_t;

_Static_assert(sizeof(audit_event_t) == 512, "audit_event_t debe medir exactamente 512 bytes");

int audit_init(fat_volume vol);
int audit_log_write(fat_volume vol, const char *path, off_t offset, size_t size);
int audit_log_unlink(fat_volume vol, const char *filepath, fat_file file);
int audit_log_mkdir(fat_volume vol, const char *path, uint32_t dir_cluster);
int audit_log_rmdir(fat_volume vol, const char *path, uint32_t dir_cluster);
int audit_restore_file(fat_volume vol, char *path);

#endif /* AUDIT_H */