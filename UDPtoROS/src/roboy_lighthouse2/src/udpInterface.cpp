#include <udpInterface.hpp>

#define localIP "192.168.1.1"

udpInterface::udpInterface(const char * localIP_){
  //if(isServer_)
  //testVar = testVar_;

  if (!ros::isInitialized()) {
    int argc = 0;
    char **argv = NULL;
    ros::init(argc, argv, "lighthouse2ToRos");
  }
  nh = ros::NodeHandlePtr(new ros::NodeHandle);

  ROS_INFO("init[STARTED]...lighthouse2Data");

  pubHandl_Sensor = nh->advertise<roboy_middleware_msgs::DarkRoomSensorV2>("/roboy/middleware/DarkRoom/sensorsLH2", 1);

  ROS_INFO("init[DONE]...lighthouse2Data");

  localIp =ipDataConverter(localIP_);

  uint8_t ipAddr_firstByte = 192;
  uint8_t ipAddr_seconByte = 168;
  uint8_t ipAddr_thirdByte = 1;
  uint8_t ipAddr_fourthByte = 1;

  ip_address = (ipAddr_fourthByte<<24) | (ipAddr_thirdByte<<16) | (ipAddr_seconByte<<8) | (ipAddr_firstByte);
}

/*

void udpInterface::function2(const char *arg1, unsigned arg2) {
    for(uint8_t i = 0; i < 100; i++){
      std::cout << "i am member2 and my first arg is (" << arg1 << ") and second arg is (" << arg2 << ")" << std::endl;
    }
}
*/
//=============================================================================
void udpInterface::initClientSocket(const char* hostname, const char* port){


  int result = 0;
  fd  = socket(AF_INET, SOCK_DGRAM, 0);

  char szIP[100];

  ip_address = ipDataConverter(hostname);

  SockAddr.sin_family = AF_INET;
  result = bind(fd, (sockaddr*)&SockAddr, sizeof(SockAddr));
  if (result == -1)
  {
     int lasterror = errno;
     std::cout << "error: " << lasterror;
     exit(1);
  }


  //
  result = resolvehelper(hostname, AF_INET, port, &addrDest);
  if (result != 0)
  {
     int lasterror = errno;
     std::cout << "error: " << lasterror;
     exit(1);
  }


  //const uint8_t buffer[] = "HelloFucker";
  //(void)sendData(buffer,sizeof(buffer));
}

//=============================================================================
int udpInterface::initServerSocket(const char* port){
  int PORT = std::stoi(port);
  printf("\nStartingSocketServer with Port %d\n", PORT);
  int result = 0;
  char buffer[512] = {0};

  ServerFd = socket(AF_INET, SOCK_DGRAM, 0);

  if (ServerFd < 0) {
      printf("\nsocket");
      return 1;
  }

  u_int yes = 1;
  if (setsockopt(ServerFd, SOL_SOCKET, SO_REUSEADDR, (char*) &yes, sizeof(yes)) < 0){
     printf("\nReusing ADDR failed");
     return 1;
  }

  // set up destination address
  //

  ClientSockAddr.sin_family = AF_INET;
  ClientSockAddr.sin_addr.s_addr = htonl(INADDR_ANY); // differs from sender
  ClientSockAddr.sin_port = htons(PORT);

  // bind to receive address
  //
  if (bind(ServerFd, (struct sockaddr*) &ClientSockAddr, sizeof(ClientSockAddr)) < 0) {
      printf("\nbind");
      return 1;
  }

  return 0;
}



void udpInterface::receiveData(){

      do{
        char msgbuf[512];
        socklen_t addrlen = sizeof(ClientSockAddr);

        struct sockaddr_in* pV4Addr = (struct sockaddr_in*)&ClientSockAddr;
        struct in_addr ipAddr = pV4Addr->sin_addr;
        char str[INET_ADDRSTRLEN];
        inet_ntop( AF_INET, &pV4Addr->sin_addr, str, INET_ADDRSTRLEN );

        int nbytes = recvfrom(
            ServerFd,
            msgbuf,
            512,
            0,
            (struct sockaddr *) &ClientSockAddr,
            &addrlen
        );
        if (nbytes < 0) {
            printf("\nrecvfrom");
            return;
        }
        msgbuf[nbytes] = '\0';

        //printf("server: got connection from %s port %d\n",
        //    inet_ntoa(ClientSockAddr.sin_addr), ntohs(ClientSockAddr.sin_port));

        //printf("\nNBytes %d", nbytes);
        //puts(msgbuf);
        //rx_data.push_back(msgbuf);
        //*rx_data = msgbuf;
        //rx_data++;

        pb_byte_t buffer[512];

        for (size_t i = 0; i < 512; i++) {
          buffer[i] = msgbuf[i];
        }
        // = msgbuf;
        size_t rcvd_msg_len = nbytes;

        DarkRoomProtobuf_lighthouseMsg msg;

        pb_istream_t stream = pb_istream_from_buffer(buffer, rcvd_msg_len);
        bool status = pb_decode(&stream, DarkRoomProtobuf_lighthouseMsg_fields, &msg);



        if(status){
          /*
          printf("\n");
          printf(" SensorID %2d", msg.SensorID);
          printf(" BeamWord %6x", msg.BeamWord);
          printf(" LastBeamWord %6x", msg.E_width);
          printf(" Timestamp %d", msg.Timestamp);
          printf(" BaseStationID %4d", msg.BaseStationID);
          printf(" BaseStationChanel %4d", msg.BaseStationChanel);*/

          uint8_t lut_Poly_id = ((msg.BaseStationID-1)<<1) | msg.BaseStationChanel;
          //printf(" BaseStationID %d(%d) = %d", msg.BaseStationID, msg.BaseStationChanel, lut_Poly_id);

          uint32_t lut_iteration_first = 0;
          uint32_t lut_iteration_second = 0;

          LightHouseDataProcessing acalc;
          struct angleData aData;
          aData.azimuth = 0.7;
          aData.elevation = 0.7;
          uint32_t foo_wtf = msg.E_width & 0x00f80000;
          if( foo_wtf != 0){
            ROS_ERROR("[SID:%d]there was an incorrect Beamword ... [First] %x ",msg.SensorID, msg.E_width);
          }
          if( (msg.BeamWord&0x00f80000) == 0xf80000){
            ROS_ERROR("[SID:%d]there was an incorrect Beamword ... [Second] %x",msg.SensorID, msg.BeamWord);
          }


          if(lut_Poly_id < 32){
                //firstBeam = ((lastMeasurements[channel] * 8.0) / PERIODS[identity >> 1]) * 2 * math.pi
                //secondBeam = ((offset * 8.0) / PERIODS[identity >> 1]) * 2 * math.pi
                ///azimuth, elevation = calculateAE(firstBeam, secondBeam)

                acalc.angleCalc(msg.BeamWord,msg.E_width, msg.BaseStationID, &aData);

                //printf("\n");
                //printf(" readInData %x [%d] ", readInData[lut_Poly_id][lut_iteration_first], lut_iteration_first);
                //printf(" readInData %x [%d]", readInData[lut_Poly_id][lut_iteration_second], lut_iteration_second);
                //printf(" BeamWord %x", msg.BeamWord);
                //printf(" LastBeamWord %x", msg.E_width);
                //printf(" Timestamp %x", msg.Timestamp);
                //printf("\n===========FUCK YEA=========\n%x [%d] %x", msg.BeamWord,i, readInData[lut_Poly_id][i] );
                //std::cout << aData.elevation;
                //printf("[Sensor:%2d] Azimuth %.9f | % 3.6f\n",  msg.SensorID, aData.azimuth, aData.elevation);
                std::string client_ip = inet_ntoa(ClientSockAddr.sin_addr);
                std::cout << "[BID:" << std::setw(2) << msg.BaseStationID << "ID:" << std::setw(1) << msg.SensorID << "] Azimuth " << std::fixed << aData.azimuth*180/3.1415 << " | " << aData.elevation*180/3.1415 << " | ip:" << client_ip << "\n";

                std::stringstream ss_;
                ss_ << "LightHouseV2_Position_" << client_ip;

                ros_msg.object_id = ss_.str();
                ros_msg.base = (uint8_t)msg.BaseStationID;
                ros_msg.SensorID =  (uint8_t)msg.SensorID;
                ros_msg.elevation = aData.azimuth;
                ros_msg.azimuth = aData.elevation;

                pubHandl_Sensor.publish(ros_msg);


                  /*
            for (lut_iteration_first = 0; lut_iteration_first < LFSR_MAX_ITERATION; lut_iteration_first++) {
              if(readInData[lut_Poly_id][lut_iteration_first] == msg.E_width ){
                //printf("\n===========FUCK YEA=========\n%x [%d] %x", msg.BeamWord,i, readInData[lut_Poly_id][i] );
                for (lut_iteration_second = lut_iteration_first+2; lut_iteration_second < LFSR_MAX_ITERATION; lut_iteration_second++) {
                  if(readInData[lut_Poly_id][lut_iteration_second] ==  msg.BeamWord ){

                    //printf("\n");
                    //printf(" readInData %x [%d] ", readInData[lut_Poly_id][lut_iteration_first], lut_iteration_first);
                    //printf(" readInData %x [%d]", readInData[lut_Poly_id][lut_iteration_second], lut_iteration_second);
                    //printf(" BeamWord %x", msg.BeamWord);
                    //printf(" LastBeamWord %x", msg.E_width);
                    //printf(" Timestamp %x", msg.Timestamp);
                    //printf("\n===========FUCK YEA=========\n%x [%d] %x", msg.BeamWord,i, readInData[lut_Poly_id][i] );
                    acalc.angleCalc(lut_iteration_first,lut_iteration_second, msg.BaseStationID, &aData);
                    //std::cout << aData.elevation;
                    //printf("[Sensor:%2d] Azimuth %.9f | % 3.6f\n",  msg.SensorID, aData.azimuth, aData.elevation);
                    std::string client_ip = inet_ntoa(ClientSockAddr.sin_addr);
                    std::cout << "[BID:" << std::setw(2) << msg.BaseStationID << "ID:" << std::setw(1) << msg.SensorID << "] Azimuth " << std::fixed << aData.azimuth << " | " << aData.elevation << " | ip:" << client_ip << "\n";

                    std::stringstream ss_;
                    ss_ << "LightHouseV2_Position_" << client_ip;

                    ros_msg.object_id = ss_.str();
                    ros_msg.base = (uint8_t)msg.BaseStationID;
                    ros_msg.SensorID =  (uint8_t)msg.SensorID;
                    ros_msg.elevation = aData.azimuth;
                    ros_msg.azimuth = aData.elevation;

                    pubHandl_Sensor.publish(ros_msg);


                      //std_msgs::String msg;
                      //std::stringstream ss;
                      //ss << "Hello world";
                      //msg.data = ss.str();
                      //pub_handler.publish(msg);

                    break;
                  }
                }
                break;
              }
            }
            */


          }

        }else{
            printf("FAild Encoding\n");
        }

        //printf("\nRX-DATA=:%s", msgbuf);

    }while(1);
}


//=============================================================================
void udpInterface::sendData(const uint8_t * buffer, uint16_t buffer_length){

  int result  = sendto(fd, buffer, buffer_length, 0, (sockaddr*)&addrDest, sizeof(addrDest));

}

//=============================================================================
void udpInterface::sendConfigObject (int32_t logginPort_l, int32_t sensorPort_l, int32_t imuPort_l){
  while(1){
    PROTO_LOVE pb;
    //ip_address


    pb_byte_t buffer[512] = {0};
    //const uint8_t buffer[] = "HelloFucker";

    size_t msg_len;
    if(pb.ecode_config_Proto(localIp,  logginPort_l, sensorPort_l, imuPort_l, buffer, msg_len )){
        printf("Encoded");
    }

    //(void)sendData(buffer,sizeof(buffer));
    (void)sendData(buffer,msg_len);
    std::this_thread::sleep_for(std::chrono::seconds(30));
  }


}

std::thread udpInterface::member1Thread(int32_t logginPort_l, int32_t sensorPort_l, int32_t imuPort_l) {
    return std::thread(&udpInterface::sendConfigObject, this, logginPort_l, sensorPort_l, imuPort_l);
}

std::thread udpInterface::member2Thread() {
      return std::thread(&udpInterface::receiveData, this);
}




//=============================================================================
int udpInterface::resolvehelper(const char* hostname, int family, const char* service, sockaddr_storage* pAddr)
{
    int result;
    addrinfo* result_list = NULL;
    addrinfo hints = {};
    hints.ai_family = family;
    hints.ai_socktype = SOCK_DGRAM; // without this flag, getaddrinfo will return 3x the number of addresses (one for each socket type).
    result = getaddrinfo(hostname, service, &hints, &result_list);
    if (result == 0)
    {
        //ASSERT(result_list->ai_addrlen <= sizeof(sockaddr_in));
        memcpy(pAddr, result_list->ai_addr, result_list->ai_addrlen);
        freeaddrinfo(result_list);
    }

    return result;
}



///====================
uint32_t udpInterface::ipDataConverter(const char * ipAdrresString){
  //std::string ip ="192.168.1.54";
  std::string ipString(ipAdrresString);
  std::stringstream ss(ipString);
  int a,b,c,d; //to store the 4 ints
  char ch; //to temporarily store the '.'
  ss >> a >> ch >> b >> ch >> c >> ch >> d;

  uint32_t genIP = ((uint8_t)d<<24) | ((uint8_t)c<<16) | ((uint8_t)b<<8) | ((uint8_t)a);
  return genIP;
}
