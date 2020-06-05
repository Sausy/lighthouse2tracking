#include <SPI.h>
#include "wirelessLove.h"


 const char  TestBuffer[] ="Hello World";
 const int    timestampSize = 2;

static int xBit_blocking = 0;

static WiFiUDP  UDP;

WIFI_LOVE::WIFI_LOVE(const char* SSID, const char* PASSWD, IPAddress &broadcastIP):
broadcastIP(broadcastIP){
  xBit_blocking++;

    //WiFi.persistent(false);
    sprintf(pass,PASSWD);
    sprintf(ssid,SSID);

    WiFi.mode(WIFI_STA);
    WiFi.begin(SSID, PASSWD);

    hostIP = IPAddress(192,168,1,1);
    //hostIP_static = IPAddress(192,168,1,1);
    xBit_blocking--;
}

void WIFI_LOVE::DBG_func(){

  //WiFi.persistent(false);
//  sprintf(pass,PASSWD);
//  sprintf(ssid,SSID);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);

  hostIP = IPAddress(192,168,1,1);

  //Serial.print("SSID");Serial.print(ssid);Serial.print("\n");
  //printIP(hostIP);
  //Serial.print(WiFi.status());
  //Serial.print(" | ");
  //Serial.print(WL_CONNECTED);
  //Serial.print("\n");

  Serial.flush();
}

int WIFI_LOVE::printWifiStatus(void)
{
    xBit_blocking++;
    Serial.print("SSID: ");
    Serial.println(WiFi.SSID());

    IPAddress ip = WiFi.localIP();
    printIP(ip);

    long rssi = WiFi.RSSI();
    Serial.print("signal strength (RSSI):");
    Serial.print(rssi);
    Serial.println(" dBm");

    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::initWifi(void)
{
    xBit_blocking++;
    uint32_t timoutCounter = 0;

    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }

    printWifiStatus();
    LoveStatus = WL_CONNECTED;
    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::initUDPSockets(void)
{
    xBit_blocking++;
    if (0 == UDP.begin(commandPort)){
        return (int) ES_WIFI_FAIL_UDP_SOCKET;
    }

    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::fmsgTest_s(void)
{
    xBit_blocking++;
    //Serial.printf("print udp data to hostIP\n");
    //UDP.beginPacket(hostIP, sensorPort);
    //UDP.printf("%s",TestBuffer);
    //UDP.endPacket();

    //Serial.printf("RealDataTest\n");

    //uint8_t TempTestBuffer = TestBuffer
    uint8_t res = ES_WIFI_ERROR;

    const uint8_t  stringBuff[] = "Hello World";
    const uint8_t * buffer = stringBuff;
    int size = sizeof(stringBuff);

    if(0 == UDP.beginPacket(hostIP, sensorPort))
    {
        LOG(logWARNING, "Can not connect to the supplied IP or PORT");
        return  res;
    }
    if(size != UDP.write(buffer, size)){
        Serial.println("Size of the UDP Package to big! Truncated overlapping data");
    }

    //UDP.beginPacket(hostIP, sensorPort);
    //UDP.printf("%s",TestBuffer);
    if(0 == UDP.endPacket()){
      Serial.println("[WiFI ERROR] couldn't endPacket");
    }


    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}


//TODO: this is just a workaround, because there was always a core dump



int WIFI_LOVE::lighthouse2DataStream(DarkRoomProtobuf_lighthouseMsg msg)
{
    xBit_blocking++;

    //hostIP_static = IPAddress(192,168,1,1);
    //res_static = ES_WIFI_ERROR;

    uint16_t sensorPort_static = 8000;

    IPAddress hostIP_static;
    int ret_beginPacket = 0;
    pb_byte_t buffer_static[512] = {0};

    bool status_static;
    uint32_t msg_len_static;
    DarkRoomProtobuf_lighthouseMsg msg_static;
    msg_static = msg;
    uint8_t res_static = ES_WIFI_ERROR;

    hostIP_static = IPAddress(192,168,1,1);

    pb_ostream_t stream = pb_ostream_from_buffer(buffer_static, 512);
    status_static = pb_encode(&stream, DarkRoomProtobuf_lighthouseMsg_fields, &msg_static);
    msg_len_static = stream.bytes_written;

    //printIP(hostIP_static);

    if(!status_static){

        Serial.print("\nPROTOFAILED");
        Serial.flush();

        LOG(logERROR, "Encoding failed!");
        Serial.println(PB_GET_ERROR(&stream));
    }else{

      //printIP(hostIP_static);
      //Serial.flush();
      //Serial.print("\nxBit: ");Serial.print(xBit_blocking);
      //Serial.print("\nCheck if socket up: ");printIP(hostIP_static); Serial.print(sensorPort_static);
      //Serial.print("\nxBit: ");Serial.print(xBit_blocking);
      //Serial.flush();

      ret_beginPacket = 0;

      //try{
      //while(xBit_blocking > 1){
      //  ;
      //}
      /*
      if(xBit_blocking > 1){
        for (size_t i = 0; i < 6000; i++) {
          ;
        }
        //vTaskDelay(1000 / portTICK_PERIOD_MS);
      }*/
      ret_beginPacket = UDP.beginPacket(hostIP_static, sensorPort_static);

      //}catch(const std::exception& ex){
      //  Serial.print("\n========ERROR");
      //}

      if(0 == ret_beginPacket)
      {
          //Serial.print("\nNOT UP");
          //Serial.flush();
          LOG(logWARNING, "Can not connect to the supplied IP or PORT");
          return  res_static;
      }

      //Serial.print("\n[DEBUG] Checking msg_len");
      //Serial.flush();

      if(msg_len_static != UDP.write(buffer_static, msg_len_static)){
          Serial.println("Size of the UDP Package to big! Truncated overlapping data");
      }


      //UDP.beginPacket(hostIP, sensorPort);
      //UDP.printf("%s",TestBuffer);

      //Serial.print("\n[DEBUG] endPacket");
      //Serial.flush();
      //vTaskDelay(1000 / portTICK_PERIOD_MS);
      //UDP.endPacket();
      if(0 == UDP.endPacket()){
        Serial.println("[WiFI ERROR] couldn't endPacket_");
      }

      //Serial.print("\n[DEBUG] UDP end ");
      //Serial.flush();

      xBit_blocking--;
      return (int) ES_WIFI_SUCCESS;
    }



    //const uint8_t  stringBuff[] = "Hello World";
    //const uint8_t * buffer = stringBuff;
    //int size = sizeof(stringBuff);


    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::fmsgBroadcast_s(const uint8_t * buffer, size_t size)
{
    xBit_blocking--;
    uint8_t res = ES_WIFI_ERROR;
    if(0 == UDP.beginPacket(broadcastIP, configPort))
    {
        LOG(logWARNING, "Can not connect to the supplied IP or PORT");
        return  res;
    }

    if(size != UDP.write(buffer, size)){
        Serial.println("Size of the UDP Package to big! Truncated overlapping data");
    }
    UDP.endPacket();

    xBit_blocking++;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::fmsgLogging_s(const uint8_t * buffer, size_t size)
{
    xBit_blocking++;
    if(UDP.beginPacket(hostIP, logginPort) == 0){
      LOG(logWARNING, "Can not connect to the supplied IP or PORT");
    }
    if(size != UDP.write(buffer, size)){
        Serial.println("Size of the UDP Package to big! Truncated overlapping data");
    }
    UDP.endPacket();

    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::fmsgSensorDataT_s(const uint8_t * buffer, size_t size)
{
    xBit_blocking++;
    LOG_d(logVERBOSE, "Send UDP Packet with Timestamp, size: ", size + timestampSize);
    if(UDP.beginPacket(broadcastIP, sensorPort) == 0){
      LOG(logWARNING, "Can not connect to the supplied IP or PORT");
    }
    unsigned long t = millis();
    uint8_t *addr = (uint8_t*) &t;
    for(int i =  0; i < timestampSize; i++){
        UDP.write(addr[i]);
    }

    if(size != UDP.write(buffer, size)){
        Serial.println("Size of the UDP Package to big! Truncated overlapping data");
    }

    UDP.endPacket();

    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::fmsgSensorData_s(const uint8_t * buffer, size_t size)
{
    xBit_blocking++;

    printIP(hostIP);
    UDP.beginPacket(broadcastIP, sensorPort);
    if(size != UDP.write(buffer, size)){
        LOG(logERROR,"Size of the UDP Package to big! Truncated overlapping data");
    }
    UDP.endPacket();

    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::fmsgImuData_s(const uint8_t * buffer, size_t size)
{
    xBit_blocking++;
    UDP.beginPacket(broadcastIP, imuPort);
    if(size != UDP.write(buffer, size)){
        LOG(logERROR,"Size of the UDP Package to big! Truncated overlapping data");
    }
    UDP.endPacket();
    xBit_blocking--;
    return (int) ES_WIFI_SUCCESS;
}

int WIFI_LOVE::getConnectionStatus(void)
{
    xBit_blocking++;
    int dV = LoveStatus;
    xBit_blocking--;
    return dV;
}

bool WIFI_LOVE::receiveCommand(){
  xBit_blocking++;
  int packetSize = UDP.parsePacket();
  if(packetSize > 0 )
  {
//      if(packetSize > 1){
      unsigned char buffer[255];
      size_t len = UDP.read(buffer , sizeof buffer);
      if(len > 0 && len < 60)
      {
          buffer[len] = '\0';
          if(protoLove.decode_command_Proto(buffer, len)){
             command = protoLove.commandObjMsg.command;
          }
      }
//      }else if(packetSize==1){
//         LOG(logINFO, "triggered!");
//         digitalWrite(TRIGGER_PIN, HIGH);
//         delay(1);
//         digitalWrite(TRIGGER_PIN, LOW);
//      }
  }

  xBit_blocking--;
}

void WIFI_LOVE::checkHostConfig(){
    // wait for a config message
    xBit_blocking++;
    bool receivedConfig = false;
    while(!receivedConfig)
    {
        if(protoLove.encode_trackedObjConfig( WiFi.localIP(), commandPort, buffer, msg_len)){
            if(fmsgBroadcast_s(buffer, msg_len)){
                LOG(logINFO, "trackedObjectConfig protobuffer successfully sent via UDP Socket");
            }else{
                LOG(logERROR, "Sending failed!");
            }
        }
        int packetSize = UDP.parsePacket();
        LOG_d(logINFO, "check if command rcvd ", packetSize);
        if(packetSize > 0 )
        {
            unsigned char buffer[255];
            LOG(logINFO, "rcvd command from host...");
            size_t len = UDP.read(buffer , sizeof buffer);
            if(len > 0 && len < 60)
            {
                printf("dataLength %d\n", len);
                //buffer[len] = '\0';
                protoLove.decode_config_Proto(buffer, len);

                printIP(hostIP);
                hostIP = protoLove.configObjMsg.ip;
                logginPort = protoLove.configObjMsg.logging_port;
                if(protoLove.configObjMsg.sensor_port == 0){
                  sensorPort = 8000;
                }else{
                  sensorPort = protoLove.configObjMsg.sensor_port;
                }
                imuPort = protoLove.configObjMsg.imu_port;

                printIP(hostIP);
                Serial.printf("Logging Port Target PC :  %d\n", logginPort);
                Serial.printf("Sensor Port Target PC  :  %d\n", sensorPort);
                Serial.printf("Imu Port Target PC  :  %d\n", imuPort);

                LOG_d(logINFO, "Logging Port Target PC :  ", protoLove.configObjMsg.logging_port);
                LOG_d(logINFO, "Sensor Port Target PC  :  ", protoLove.configObjMsg.sensor_port);
                LOG_d(logINFO, "Imu Port Target PC  :  ", protoLove.configObjMsg.imu_port);
                receivedConfig = true;
            }
        }
        delay(1000);
    }
    if(protoLove.encode_loggingObject( "connection established", buffer, msg_len)){
        if(fmsgLogging_s(buffer, msg_len)){
          LOG(logINFO, "logging sent");
        }else{
          LOG(logERROR, "Sending failed!");
        }
    }

    xBit_blocking--;
}

void WIFI_LOVE::printIP(uint32_t ip){
    Serial.printf("IP: %d.%d.%d.%d\n", (ip>>0)&0xff, (ip>>8)&0xff, (ip>>16)&0xff, (ip>>24)&0xff);
}

bool WIFI_LOVE::sendImuData(Quaternion &q, VectorInt16 &acc, VectorFloat &gravity){
    bool status = protoLove.encode_imuObjConfig(q,acc,gravity,buffer,msg_len);
    fmsgImuData_s(buffer,msg_len);
    return status;
}
