#include <stdlib.h>
#include <iostream>
#include <pb_encode.h>
#include <pb_decode.h>

#include <string>
#include <vector>
#include <atomic>

/*
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
*/

#include <ros/ros.h>
//#include <ros/package.h>
#include <udpInterface.hpp>
#include "LUT/lut.h"



// Different Ports for diverent Signals from the ESP32
const int32_t  sensorPort   = 8000; // will be received from host
const int32_t  commandPort  = 4210;
const int32_t  logginPort   = 8002;  // will be received from host
const int32_t  configPort   = 8001;
const int32_t  imuPort   = 0; // will be received from host




int main(int argc, char *argv[])
{

  std::cout << "\nstart UDP Interface ... ";
  udpInterface *udp = new udpInterface("192.168.1.1");//TODO: set local ip automatically
  udp->initClientSocket("192.168.1.10","4210"); //IP of client in this case a esp32
  (void)udp->initServerSocket("8000");

  std::thread thread1 = udp->member1Thread(logginPort,sensorPort,imuPort);
  std::thread thread2 = udp->member2Thread();

  std::cout << "\nstart ROS";

  //init ros
  if (!ros::isInitialized()){
    int argc = 0;
    char **argv = NULL;
    ros::init(argc, argv, "lighthouse2ToRosMainFrame");
  }

  ros::NodeHandle nh;
  ros::Rate loop_rate(200);

  std::cout << "\nstart Check if master is up";
  while(!ros::master::check()){
    loop_rate.sleep();
  }


  //ros::Subscriber sub_handler = nh.subscribe("/test/path2", 1, sub_callback);

  


  while (ros::ok())
  {
    /*
    std_msgs::String msg;
    std::stringstream ss;
    ss << "Hello world";
    msg.data = ss.str();
    pub_handler.publish(msg);*/



    ros::spinOnce();
    loop_rate.sleep();

  }


  thread1.join();
  thread2.join();

  printf("This Example shows how to make two threds for function in a class\n" );

  return 0;

}
