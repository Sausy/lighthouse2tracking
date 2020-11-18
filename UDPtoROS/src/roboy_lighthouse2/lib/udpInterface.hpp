#ifndef _UDP_CLASS_HPP_
#define _UDP_CLASS_HPP_

//#define System_IS_ESP
/*
#ifdef System_IS_ESP
  #include "logging.h"
  #include "lighthouse.pb.h"
  #include "helper_3dmath.h"
  #include "pb.h"
  #include "pb_encode.h"
  #include "pb_decode.h"
#endif
#ifndef System_IS_ESP
  #include <cmath>
  #include <stdlib.h>
  #include <iostream>
  #include <lighthouse.pb.h>
  #include <pb_encode.h>
  #include <pb_decode.h>
#endif
*/


#include <thread>
#include <iostream>

#include <sys/types.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <memory.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <errno.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include <sstream>
#include <iomanip>

//allows us to only execute the thread every now and then
#include <chrono>

#include <lighthouse.pb.h>
#include <pb_encode.h>
#include <pb_decode.h>

#include <protoLighthouse.h>

#include "../LUT/lut.h"
#include "lighthouse2Data.hpp"
#include <ros/ros.h>
#include <roboy_middleware_msgs/DarkRoomSensorV2.h>
#include <roboy_middleware_msgs/LighthousePoseCorrection.h>
#include <tf/tf.h>
#include <ros/package.h>

class udpInterface {
   public:
      udpInterface(const char * localIP_);
      void initClientSocket(const char* hostname, const char* port);
      int initServerSocket(const char* port);

      void sendData(const uint8_t * buffer, uint16_t buffer_length);
      void receiveData();

      std::thread member1Thread(int32_t logginPort_l, int32_t sensorPort_l, int32_t imuPort_l);
      std::thread member2Thread();

      uint8_t testVar;

      uint32_t ip_address;
      uint32_t localIp;

      sockaddr_in SockAddr = {}; // zero-int, sin_port is 0, which picks a random port for bind.
      sockaddr_storage addrDest = {};
      int fd;

      sockaddr_in ClientSockAddr = {}; // zero-int, sin_port is 0, which picks a random port for bind.
      int ServerFd;

    private:
      ros::NodeHandlePtr  nh;
      ros::Publisher pubHandl_Sensor, pubHandl_Sensor_Raw, pubHandl_Sensor_IMU, pubHandl_correctBase;
      roboy_middleware_msgs::DarkRoomSensorV2 ros_msg;
      void sendConfigObject (int32_t logginPort_l, int32_t sensorPort_l, int32_t imuPort_l);

      uint32_t ipDataConverter(const char * ipAdrresString);
      int resolvehelper(const char* hostname, int family, const char* service, sockaddr_storage* pAddr);

      uint16_t outTimeBufferCnt;


};


#endif
