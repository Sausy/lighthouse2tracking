#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

/* ROS */
#include <ros/ros.h>
#include "std_msgs/String.h"
#include "std_msgs/Float32MultiArray.h"


/* Project */
#include <usbHidInterface.h>
#include <hdk_parser.hpp>
#include <rayFinder.hpp>

#define MAX_SENSORS 24
#define MAX_BUFFER_SIZE 128

static uint8_t buffer[MAX_BUFFER_SIZE];


void sub_callback(const std_msgs::String::ConstPtr& msg){
    printf("%s", msg->data.c_str());
}


int main(int argc, char const *argv[]) {

  double ray[2][3] = {0};


  double first_phi[MAX_SENSORS][32] = {0};
  double secon_phi[MAX_SENSORS][32] = {0};
  double angle_old[MAX_SENSORS][32] = {0};

  double azimut = 0.0;
  double elevation = 0.0;

  double p1 =0.0;
  double p2 = 0.0;

  /*
  //======[TestBench]==========
  //links unten
  //double first_phi_ = 83.0  *M_PI/180.0;
  //double secon_phi_ = 184.0 *M_PI/180.0;

  //rechts unten
  //double first_phi_ = 170.0 *M_PI/180.0;
  //double secon_phi_ = 271.0 *M_PI/180.0;

  //links oben
  //double first_phi_ = 60.0  *M_PI/180.0;
  //double secon_phi_ = 201.8 *M_PI/180.0;

  //rechts oben
  //double first_phi_ = 149.79 *M_PI/180.0;
  //double secon_phi_ = 291.3  *M_PI/180.0;
  double first_phi_ = 120.0 *M_PI/180.0;
  double secon_phi_ = 240.0 *M_PI/180.0;

  //tag = ['mid bottom','left bottom','right bottom']
  //firstPhi = [221.88,185.82,267.569]
  //secondPhi = [120.62,84.43,166.3]

  //find the fucking error data dump
  //[24/2]az 91.546236 --- ele -1.314399 -- 237.139020/119.768509
  //[24/2]az 33.930657 --- ele -40.582393 -- 237.135641/119.765881
  secon_phi_ = 237.135641 *M_PI/180.0;
  first_phi_ = 119.765881 *M_PI/180.0;

  //secon_phi_ = 237.135641;
  //first_phi_ = 119.765881;

  ray_calculation(secon_phi_, first_phi_, &ray);
  vec2azimuth(&ray, &azimut, &elevation);

  printf("\nPhi1 %f\nPhi2 %f\n======",first_phi, secon_phi);
  for (uint8_t i = 0; i < 3; i++) {
    printf("\nRay [%u] = %g",i, ray[1][i]);
  }
  printf("\naz %f\nele %f\n======",azimut*180/M_PI, elevation*180/M_PI);

  return 0;

  */
  //======[TestBench END]==========



  //init vive dongle
  (void)HID_init("/dev/hidraw1");
  (void)HID_send_config();

  //init ros
  if (!ros::isInitialized()){
    int argc = 0;
    char **argv = NULL;
    ros::init(argc, argv, "usbhid_node");
  }
  ros::NodeHandle nh;
  ros::Rate loop_rate(10);

  //ros::Publisher pub_handler = nh.advertise<std_msgs::String>("/test/path", 1);
  ros::Subscriber sub_handler = nh.subscribe("/test/path2", 1, sub_callback);

  ros::Publisher pub_handler = nh.advertise<std_msgs::Float32MultiArray>("/lh/ray", 1);



  viveParse dataParser;
  uint8_t ros_msg_cnt = 0;
  bool firstRosCnt = false;
  uint8_t ChannelBuffer = 0xff;

  int res = -1;
  while (ros::ok()){
    std_msgs::Float32MultiArray msg;
    //msg.layout.dim.push_back(std_msgs::MultiArrayDimension());

    res = HID_read(&dataParser.buffer[0]);
    if(res != -1){
      //process raw data

      if(dataParser.usbHandl()){
        //for (uint8_t i = 0; i < 10; i++) {
        //  printf("%x ", dataParser.buffer[i]);
        //}

        lightV2 * le = &dataParser.lightData[0];

        firstRosCnt = false;
        ros_msg_cnt = 0;
        for (uint8_t i = 0; i < dataParser.pollLength; i++) {

          //Todo sometimes the timeDiv values are way to big
          double angle_buffer = (double)le->TimeDiv/959000.0;
          double angle_rad = angle_buffer * 2 * M_PI;
          double angle  = angle_buffer * 360.0;

          //printf("\n[V2][%u]%u/ %u | %d | %f", le->id, le->channel, le->TimeStamp, le->TimeDiv, angle);

          //TODO:
          // angle 180 is not sofisticated enough ... because both angle can be under 180
          if(angle > 180){
            //secon_phi[le->id][le->channel] = angle_rad;//(double)le->TimeDiv/959000.0 * 2*M_PI;
            //printf("\nfirst_phi,secon_phi [%f,%f] [%f,%f]",angle_rad * 180.0/M_PI,first_phi[le->id][le->channel] * 180.0/M_PI, angle, angle_old[le->id][le->channel]);
            ray_calculation(angle_rad, first_phi[le->id][le->channel], &ray);
            vec2azimuth(&ray, &azimut, &elevation);
            //printf("\n[%u/%u]az %f --- ele %f -- %f/%f",le->id,le->channel,azimut*180.0/M_PI, elevation*180.0/M_PI, angle, angle_old[le->id][le->channel]);
            printf("\n[%u/%u]%f/%f",le->id,le->channel,azimut*180.0/M_PI, elevation*180.0/M_PI);

            if(firstRosCnt){
              //if(ros_msg_cnt < 2){
              if(ChannelBuffer == le->channel){
                ros_msg_cnt++;
                msg.layout.dim.push_back(std_msgs::MultiArrayDimension());
                msg.layout.dim[ros_msg_cnt].stride=i;
                msg.layout.dim[ros_msg_cnt].label=le->channel;
                ChannelBuffer = le->channel;

              }
            }else{
              msg.layout.dim.push_back(std_msgs::MultiArrayDimension());
              msg.layout.dim[ros_msg_cnt].stride=i;
              msg.layout.dim[ros_msg_cnt].label=le->channel;
              ChannelBuffer = le->channel;
              firstRosCnt = true;
            }


            //msg.layout.dim[0].label='h';
            msg.data.push_back((float)le->id);
            msg.data.push_back((float)azimut);
            msg.data.push_back((float)elevation);



          }else{
            angle_old[le->id][le->channel] =  angle;
            first_phi[le->id][le->channel] = angle_rad;

          }


          le++;
        }


        pub_handler.publish(msg);
      }


      //---print azimuth, elevation ---


      //parseIMU();


    }

  }

  return 0;
}
