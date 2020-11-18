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
#include <std_msgs/Bool.h>
#include <udpInterface.hpp>
#include "LUT/lut.h"

#include <roboy_middleware_msgs/LighthousePoseCorrection.h>
#include <tf/tf.h>

#include <fstream>



// Different Ports for diverent Signals from the ESP32
const int32_t  sensorPort   = 8000; // will be received from host
const int32_t  commandPort  = 4210;
const int32_t  logginPort   = 8002;  // will be received from host
const int32_t  configPort   = 8001;
const int32_t  imuPort   = 0; // will be received from host


static float x = 0.0;
static float y = 0.0;
static float z = 0.0;

static float quat_w = 0.0;
static float quat_x = 0.0;
static float quat_y = 0.0;
static float quat_z = 0.0;

static uint8_t lhIsSwitched = 0;
static uint8_t lhIsSwitched_history = 0;

static void readOutInteractivData(){
  std::ifstream inFile;
  float inStream;


  while(1){
    inFile.open("/custom/controll/switched");
    if(!inFile){
      std::cout<<"ERROR unable to open config";
    }else{
      while(inFile >> inStream){
        lhIsSwitched = inStream;
        std::cout<<"config File lhIsSwitched" << lhIsSwitched;
      }
    }
    inFile.close();

    inFile.open("/custom/controll/base_x");
    if(!inFile){
      std::cout<<"ERROR unable to open config";
    }else{
      while(inFile >> inStream){
        x = inStream;
        std::cout<<"config File x " << x;
      }
    }
    inFile.close();

    inFile.open("/custom/controll/base_y");
    if(!inFile){
      std::cout<<"ERROR unable to open config";
    }else{
      while(inFile >> inStream){
        y= inStream;
        std::cout<<"config File y " << y;
      }
    }
    inFile.close();

    inFile.open("/custom/controll/base_z");
    if(!inFile){
      std::cout<<"ERROR unable to open config";
    }else{
      while(inFile >> inStream){
        z = inStream;
        std::cout<<"config File z " << z;
      }
    }
    inFile.close();

    //quat_w = 0.0;

    //inFile.open("/custom/controll/base_y");
    //inFile.open("/custom/controll/base_z");

    std::this_thread::sleep_for(std::chrono::seconds(10));
  }
}

int main(int argc, char *argv[])
{

  std::cout << "\nstart UDP Interface ... ";
  udpInterface *udp = new udpInterface("10.0.0.1");//TODO: set local ip automatically
  udp->initClientSocket("10.0.0.11","4210"); //IP of client in this case a esp32
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

  std::thread readConfig(readOutInteractivData);

  ros::Publisher pubHandl_correctBase;
  ros::Publisher pubHandl_swapBase;

  roboy_middleware_msgs::LighthousePoseCorrection lhmsg;
  std_msgs::Bool lhswap;

  pubHandl_correctBase = nh.advertise<roboy_middleware_msgs::LighthousePoseCorrection>("/roboy/middleware/DarkRoom/lhcorrect", 1);
  pubHandl_swapBase = nh.advertise<std_msgs::Bool>("/roboy/middleware/DarkRoom/lhswap", 1);

  tf::Transform tf;

  //tf::Quaternion orientation(x,y,z,w);


  lhmsg.id = 1;
  lhmsg.type = 1; //relativ==0 ; absolut ==1

  //ros::Subscriber sub_handler = nh.subscribe("/test/path2", 1, sub_callback);




  while (ros::ok())
  {
    tf::Vector3 position(x,y,z);
    tf::Quaternion orientation;//(x,quat_y,quat_z,quat_w);
    orientation.setRPY( 0, 0, 0 );

    tf.setOrigin(position);
    tf.setRotation(orientation);

    tf::transformTFToMsg(tf, lhmsg.tf);
    pubHandl_correctBase.publish(lhmsg);

    if(lhIsSwitched_history != lhIsSwitched){
      std::cout << "Lighthouse Base will be swapped";
      lhIsSwitched_history = lhIsSwitched;
      if(lhIsSwitched == 0){
        lhswap.data = false;
      }else{
        lhswap.data = true;
      }

      pubHandl_swapBase.publish(lhswap);
    }
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

  readConfig.join();

  printf("This Example shows how to make two threds for function in a class\n" );

  return 0;

}
