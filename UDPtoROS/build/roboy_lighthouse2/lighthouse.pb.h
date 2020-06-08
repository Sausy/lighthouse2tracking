/* Automatically generated nanopb header */
/* Generated by nanopb-0.4.2-dev */

#ifndef PB_DARKROOMPROTOBUF_LIGHTHOUSE_PB_H_INCLUDED
#define PB_DARKROOMPROTOBUF_LIGHTHOUSE_PB_H_INCLUDED
#include <pb.h>

#if PB_PROTO_HEADER_VERSION != 40
#error Regenerate this file with the current version of nanopb generator.
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* Struct definitions */
typedef struct _DarkRoomProtobuf_commandObject {
    int32_t command;
} DarkRoomProtobuf_commandObject;

typedef struct _DarkRoomProtobuf_configObject {
    uint32_t ip;
    int32_t logging_port;
    int32_t sensor_port;
    int32_t imu_port;
} DarkRoomProtobuf_configObject;

typedef struct _DarkRoomProtobuf_imuObject {
    int32_t id;
    pb_size_t quaternion_count;
    float quaternion[4];
    pb_size_t acc_count;
    int32_t acc[3];
    pb_size_t gravity_count;
    float gravity[3];
} DarkRoomProtobuf_imuObject;

typedef struct _DarkRoomProtobuf_lighthouseMsg {
    uint32_t SensorID;
    uint32_t BeamWord;
    uint32_t Timestamp;
    uint32_t E_width;
    uint32_t BaseStationID;
    bool BaseStationChanel;
} DarkRoomProtobuf_lighthouseMsg;

typedef struct _DarkRoomProtobuf_loggingObject {
    bool has_message;
    char message[40];
} DarkRoomProtobuf_loggingObject;

typedef struct _DarkRoomProtobuf_trackedObjectConfig {
    uint32_t ip;
    int32_t command_port;
} DarkRoomProtobuf_trackedObjectConfig;


/* Initializer values for message structs */
#define DarkRoomProtobuf_configObject_init_default {0, 0, 0, 0}
#define DarkRoomProtobuf_trackedObjectConfig_init_default {0, 0}
#define DarkRoomProtobuf_loggingObject_init_default {false, ""}
#define DarkRoomProtobuf_commandObject_init_default {0}
#define DarkRoomProtobuf_imuObject_init_default  {0, 0, {0, 0, 0, 0}, 0, {0, 0, 0}, 0, {0, 0, 0}}
#define DarkRoomProtobuf_lighthouseMsg_init_default {0, 0, 0, 0, 0, 0}
#define DarkRoomProtobuf_configObject_init_zero  {0, 0, 0, 0}
#define DarkRoomProtobuf_trackedObjectConfig_init_zero {0, 0}
#define DarkRoomProtobuf_loggingObject_init_zero {false, ""}
#define DarkRoomProtobuf_commandObject_init_zero {0}
#define DarkRoomProtobuf_imuObject_init_zero     {0, 0, {0, 0, 0, 0}, 0, {0, 0, 0}, 0, {0, 0, 0}}
#define DarkRoomProtobuf_lighthouseMsg_init_zero {0, 0, 0, 0, 0, 0}

/* Field tags (for use in manual encoding/decoding) */
#define DarkRoomProtobuf_commandObject_command_tag 1
#define DarkRoomProtobuf_configObject_ip_tag     1
#define DarkRoomProtobuf_configObject_logging_port_tag 2
#define DarkRoomProtobuf_configObject_sensor_port_tag 3
#define DarkRoomProtobuf_configObject_imu_port_tag 4
#define DarkRoomProtobuf_imuObject_id_tag        1
#define DarkRoomProtobuf_imuObject_quaternion_tag 2
#define DarkRoomProtobuf_imuObject_acc_tag       3
#define DarkRoomProtobuf_imuObject_gravity_tag   4
#define DarkRoomProtobuf_lighthouseMsg_SensorID_tag 1
#define DarkRoomProtobuf_lighthouseMsg_BeamWord_tag 2
#define DarkRoomProtobuf_lighthouseMsg_Timestamp_tag 3
#define DarkRoomProtobuf_lighthouseMsg_E_width_tag 4
#define DarkRoomProtobuf_lighthouseMsg_BaseStationID_tag 5
#define DarkRoomProtobuf_lighthouseMsg_BaseStationChanel_tag 6
#define DarkRoomProtobuf_loggingObject_message_tag 1
#define DarkRoomProtobuf_trackedObjectConfig_ip_tag 1
#define DarkRoomProtobuf_trackedObjectConfig_command_port_tag 2

/* Struct field encoding specification for nanopb */
#define DarkRoomProtobuf_configObject_FIELDLIST(X, a) \
X(a, STATIC,   REQUIRED, UINT32,   ip,                1) \
X(a, STATIC,   REQUIRED, INT32,    logging_port,      2) \
X(a, STATIC,   REQUIRED, INT32,    sensor_port,       3) \
X(a, STATIC,   REQUIRED, INT32,    imu_port,          4)
#define DarkRoomProtobuf_configObject_CALLBACK NULL
#define DarkRoomProtobuf_configObject_DEFAULT NULL

#define DarkRoomProtobuf_trackedObjectConfig_FIELDLIST(X, a) \
X(a, STATIC,   REQUIRED, UINT32,   ip,                1) \
X(a, STATIC,   REQUIRED, INT32,    command_port,      2)
#define DarkRoomProtobuf_trackedObjectConfig_CALLBACK NULL
#define DarkRoomProtobuf_trackedObjectConfig_DEFAULT NULL

#define DarkRoomProtobuf_loggingObject_FIELDLIST(X, a) \
X(a, STATIC,   OPTIONAL, STRING,   message,           1)
#define DarkRoomProtobuf_loggingObject_CALLBACK NULL
#define DarkRoomProtobuf_loggingObject_DEFAULT NULL

#define DarkRoomProtobuf_commandObject_FIELDLIST(X, a) \
X(a, STATIC,   REQUIRED, INT32,    command,           1)
#define DarkRoomProtobuf_commandObject_CALLBACK NULL
#define DarkRoomProtobuf_commandObject_DEFAULT NULL

#define DarkRoomProtobuf_imuObject_FIELDLIST(X, a) \
X(a, STATIC,   REQUIRED, INT32,    id,                1) \
X(a, STATIC,   REPEATED, FLOAT,    quaternion,        2) \
X(a, STATIC,   REPEATED, INT32,    acc,               3) \
X(a, STATIC,   REPEATED, FLOAT,    gravity,           4)
#define DarkRoomProtobuf_imuObject_CALLBACK NULL
#define DarkRoomProtobuf_imuObject_DEFAULT NULL

#define DarkRoomProtobuf_lighthouseMsg_FIELDLIST(X, a) \
X(a, STATIC,   REQUIRED, UINT32,   SensorID,          1) \
X(a, STATIC,   REQUIRED, UINT32,   BeamWord,          2) \
X(a, STATIC,   REQUIRED, UINT32,   Timestamp,         3) \
X(a, STATIC,   REQUIRED, UINT32,   E_width,           4) \
X(a, STATIC,   REQUIRED, UINT32,   BaseStationID,     5) \
X(a, STATIC,   REQUIRED, BOOL,     BaseStationChanel,   6)
#define DarkRoomProtobuf_lighthouseMsg_CALLBACK NULL
#define DarkRoomProtobuf_lighthouseMsg_DEFAULT NULL

extern const pb_msgdesc_t DarkRoomProtobuf_configObject_msg;
extern const pb_msgdesc_t DarkRoomProtobuf_trackedObjectConfig_msg;
extern const pb_msgdesc_t DarkRoomProtobuf_loggingObject_msg;
extern const pb_msgdesc_t DarkRoomProtobuf_commandObject_msg;
extern const pb_msgdesc_t DarkRoomProtobuf_imuObject_msg;
extern const pb_msgdesc_t DarkRoomProtobuf_lighthouseMsg_msg;

/* Defines for backwards compatibility with code written before nanopb-0.4.0 */
#define DarkRoomProtobuf_configObject_fields &DarkRoomProtobuf_configObject_msg
#define DarkRoomProtobuf_trackedObjectConfig_fields &DarkRoomProtobuf_trackedObjectConfig_msg
#define DarkRoomProtobuf_loggingObject_fields &DarkRoomProtobuf_loggingObject_msg
#define DarkRoomProtobuf_commandObject_fields &DarkRoomProtobuf_commandObject_msg
#define DarkRoomProtobuf_imuObject_fields &DarkRoomProtobuf_imuObject_msg
#define DarkRoomProtobuf_lighthouseMsg_fields &DarkRoomProtobuf_lighthouseMsg_msg

/* Maximum encoded size of messages (where known) */
#define DarkRoomProtobuf_configObject_size       39
#define DarkRoomProtobuf_trackedObjectConfig_size 17
#define DarkRoomProtobuf_loggingObject_size      41
#define DarkRoomProtobuf_commandObject_size      11
#define DarkRoomProtobuf_imuObject_size          79
#define DarkRoomProtobuf_lighthouseMsg_size      32

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif
