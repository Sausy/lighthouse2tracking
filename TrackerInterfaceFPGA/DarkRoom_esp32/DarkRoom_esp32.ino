/*
    DarkRoom SPI slave
    Connect the SPI Master device to the following pins on the esp8266:
    GPIO    NodeMCU   Name  |   Uno
  ===================================
     15       D8       SS   |   D10
     13       D7      MOSI  |   D11
     12       D6      MISO  |   D12
     14       D5      SCK   |   D13
    Note: If the ESP is booting at a moment when the SPI Master has the Select line HIGH (deselected)
    the ESP8266 WILL FAIL to boot!
    See SPISlave_SafeMaster example for possible workaround
*/

//#include "SPISlave.h"
//#include <SPI.h>
#include "wirelessLove.h"
#include "fifo.h"
#include "logging.h"
//#include "I2Cdev.h"
//#include "MPU6050_6Axis_MotionApps20.h"
//#include "Wire.h"
#include <ESPmDNS.h>
#include <SPI.h>
#include "protoLighthouse.h"
#include "lighthouse2Data.hpp"

static const int spiClk = 1000000; // 1 MHz

#define mainQUEUE_LENGTH (1)
#if CONFIG_FREERTOS_UNICORE
#define ARDUINO_RUNNING_CORE 0
#else
#define ARDUINO_RUNNING_CORE 1
#endif

static char reset_frame = 0b10111100;
const uint8_t cmd_sende[4] = {0xff,0xff,0xbc,0xcf};


static bool xbit_cfgserial = 0;

//uninitalised pointers to SPI objects
SPIClass * vspi = NULL;

static QueueHandle_t uart2_queue;

enum COMMAND{
    TRACKING = 1,
    MPU = 2,
    SENSOR = 3,
    RESET = 4
};

bool new_data_available = false;
uint8_t spi_frame[256];
unsigned int sensor_value_counter = 0, sensor_value_counter_prev = 0;

static IPAddress broadcastIP(192,168,1,255);
static WIFI_LOVE whylove("roboy", "wiihackroboy", broadcastIP);
//MPU6050 mpu;

#define OUTPUT_READABLE_YAWPITCHROLL

#define INTERRUPT_PIN 2  // use pin 2 on Arduino Uno & most boards

// MPU control/status vars
bool dmpReady = false;  // set true if DMP init was successful
uint8_t mpuIntStatus;   // holds actual interrupt status byte from MPU
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint16_t fifoCount;     // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer

// orientation/motion vars
Quaternion q;           // [w, x, y, z]         quaternion container
VectorInt16 aa;         // [x, y, z]            accel sensor measurements
VectorInt16 aaReal;     // [x, y, z]            gravity-free accel sensor measurements
VectorInt16 aaWorld;    // [x, y, z]            world-frame accel sensor measurements
VectorFloat gravity;    // [x, y, z]            gravity vector
float euler[3];         // [psi, theta, phi]    Euler angle container
float ypr[3];           // [yaw, pitch, roll]   yaw/pitch/roll container and gravity vector

// packet structure for InvenSense teapot demo
uint8_t teapotPacket[14] = { '$', 0x02, 0,0, 0,0, 0,0, 0,0, 0x00, 0x00, '\r', '\n' };

volatile bool mpuInterrupt = false;     // indicates whether MPU interrupt pin has gone high
void dmpDataReady() {
    mpuInterrupt = true;
}

void printBits(uint32_t val){
  int i=0;
 for(uint32_t mask = 0x80000000; mask; mask >>= 1){
    if(i%8==0)
         Serial.print(' ');
    i++;
    if(mask  & val)
       Serial.print('1');
    else
       Serial.print('0');

 }
}

void setup()
{
    // set trigger pin
    pinMode(TRIGGER_PIN, OUTPUT);
    digitalWrite(TRIGGER_PIN, LOW);

    Serial.begin(115200*4);

    Serial.println("");
    Serial.println("------------------------------------------------------");
    Serial.println("                    DARKROOM ESP");
    Serial.println("------------------------------------------------------");




    //I changed this   original 192,168,255,255
    //IPAddress broadcastIP(192,168,1,255);
    //whylove = new WIFI_LOVE ("roboy", "wiihackroboy", broadcastIP);
    //whylove = new WIFI_LOVE ("WG_Netzwerk", "4baf7d9cda", broadcastIP);

    //whylove = new WIFI_LOVE ("roboy", "wiihackroboy", broadcastIP);

    Serial.printf("IP: %d.%d.%d.%d\n", (broadcastIP>>0)&0xff, (broadcastIP>>8)&0xff, (broadcastIP>>16)&0xff, (broadcastIP>>24)&0xff);
    //whylove("roboy", "wiihackroboy", broadcastIP);
    whylove.DBG_func();

    /************** WIFI *****************************/
    if(ES_WIFI_SUCCESS != whylove.initWifi()){
        Serial.println("Error in initializing the WiFi!");
    }else{
        whylove.printWifiStatus();
    }

    /*if(ES_WIFI_SUCCESS != whylove->initUDPSockets()){
        Serial.println("Error in initializing the UDP Sockets!");
    }*/

    enableLogging = false;

    Serial.print("\n[INFO] Testing Socket ");
    (void)whylove.fmsgTest_s();

//    whylove->checkHostConfig();
//    LOG(logINFO, "received config");

    /************** SET UP SPI SLAVE OF FPGA*****************/
    /*
    SPISlave.onData([](uint8_t * data, size_t len) {
        if(sensor_value_counter%100==0){
          Serial.printf("received %d sensor frames, this frame:\n", sensor_value_counter);
          char str[33];
          for(uint i=0;i<len;i+=4){
            uint32_t val = uint32_t(data[i+3]<<24|data[i+2]<<16|data[i+1]<<8|data[i]);
            Serial.printf("%d:\t",i);
            printBits(val);
            Serial.println();
            Serial.printf("   \t%d\t%d\t%d\t%d\t\n", data[i+3], data[i+2], data[i+1], data[i] );

          }
        }
        sensor_value_counter++;
        whylove->fmsgSensorDataT_s( data, sizeof(uint8_t)*len);
    });

//     SPISlave.onStatusSent([]() {
//        Serial.println("Status Read By FPGA");
//    });

    // Setup SPI Slave registers and pins
    SPISlave.begin();

//    while(true){
//      delay(1000);
//      Serial.println(sensor_value_counter);
//    }
*/


    /************** SET UP MPU6050 *****************/
 /*
    Wire.begin();
    Wire.setClock(400000); // 400kHz I2C clock

    // initialize device
    Serial.println(F("Initializing I2C devices..."));
    mpu.initialize();
    pinMode(INTERRUPT_PIN, INPUT);

    // verify connection
    Serial.println(F("Testing device connections..."));
    Serial.println(mpu.testConnection() ? F("MPU6050 connection successful") : F("MPU6050 connection failed"));

    // load and configure the DMP
    Serial.println(F("Initializing DMP..."));
    devStatus = mpu.dmpInitialize();

    // supply your own gyro offsets here, scaled for min sensitivity
    mpu.setXGyroOffset(220);
    mpu.setYGyroOffset(76);
    mpu.setZGyroOffset(-85);
    mpu.setZAccelOffset(1788); // 1688 factory default for my test chip

    // make sure it worked (returns 0 if so)
    if (devStatus == 0) {
        // turn on the DMP, now that it's ready
        Serial.println(F("Enabling DMP..."));
        mpu.setDMPEnabled(true);

        // enable Arduino interrupt detection
        Serial.println(F("Enabling interrupt detection (Arduino external interrupt 0)..."));
        attachInterrupt(digitalPinToInterrupt(INTERRUPT_PIN), dmpDataReady, RISING);
        mpuIntStatus = mpu.getIntStatus();

        dmpReady = true;

        // get expected DMP packet size for later comparison
        packetSize = mpu.dmpGetFIFOPacketSize();
    } else {
        // ERROR!
        // 1 = initial memory load failed
        // 2 = DMP configuration updates failed
        // (if it's going to break, usually the code will be 1)
        Serial.print(F("DMP Initialization failed (code "));
        Serial.print(devStatus);
        Serial.println(F(")"));
    }
    */


    //=========== Lighthouse 2 SPI setup ============
    /*vspi = new SPIClass(VSPI);
    //SCLK = 18, MISO = 19, MOSI = 23, SS = 5
    vspi->begin();
    pinMode(5, OUTPUT); //VSPI SS
    digitalWrite(5, HIGH);
    */
    //115200


    //Serial.print("\n[INFO]Reduce BufferSize ");
    //Serial.print(Serial1.setRxBufferSize(24));


    //Serial.println("\n[TODO] FFS ADD THE CHECKHOST ROUTIN AGAIN...but a functional one");
    //whylove->checkHostConfig();



    Serial.print("\n[INFO] Starting reconfiger task ");
    Serial.print("\n[INFO] this also is a whatchdog for the serial cfg");


    xTaskCreate(
                    reconfigTs4231,          /* Task function. */
                    "reconfigTs4231",        /* String with name of task. */
                    10000,            /* Stack size in bytes. */
                    NULL,             /* Parameter passed as input of the task */
                    1,                /* Priority of the task. */
                    NULL);            /* Task handle. */


    //Serial.println("\n[Info] Found Master");


    pinMode(19,INPUT);
    pinMode(23,OUTPUT);

    Serial.println("\n[INFO] Clear old FPGA Serial connection");
    Serial1.flush();
    Serial1.end();
    Serial.println("\n[INFO] Starting Connection to FPGA");

    Serial1.begin(430800,SERIAL_8N1,19,23,false);
    Serial.println("\n[INFO] FPGA Serial flush()");
    Serial1.flush();

    xbit_cfgserial = 1;


    //Serial1.write(reset_frame);
    //Serial1.write(cmd_sende,4);
    //Serial.println("\n[INFO] Starting Connection to FPGA...Done");






    /*
    Serial.println("\n[INFO] Starting Tasks");
    xQueue = xQueueCreate(
      mainQUEUE_LENGTH,
      sizeof(uint32_t)
    );*/

    //=========== CREAT CHECKING TASK ============
    //xTaskCreate(
                    //WifiCheckHostIp,          /* Task function. */
                    //"WifiCheckHostIp",        /* String with name of task. */
                    //10000,            /* Stack size in bytes. */
                    //NULL,             /* Parameter passed as input of the task */
                    //1,                /* Priority of the task. */
                    //NULL);            /* Task handle. */
    //xTaskCreate(
                    //lighthouse2Data,          /* Task function. */
                    //"lighthouse2Data",        /* String with name of task. */
                    //10000,            /* Stack size in bytes. */
                    //NULL,             /* Parameter passed as input of the task */
                    //2,                /* Priority of the task. */
                    //NULL);            /* Task handle. */
    //xTaskCreate(
                    //&sensorReadIn,          /* Task function. */
                    //"sensorReadIn",        /* String with name of task. */
                    //10000,            /* Stack size in bytes. */
                    //NULL,             /* Parameter passed as input of the task */
                    //5,                /* Priority of the task. */
                    //NULL);            /* Task handle. */
  xTaskCreatePinnedToCore(
                  sensorReadIn,          /* Task function. */
                  "sensorReadIn",        /* String with name of task. */
                  10000,            /* Stack size in bytes. */
                  NULL,             /* Parameter passed as input of the task */
                  4,                /* Priority of the task. */
                  NULL,
                  ARDUINO_RUNNING_CORE);            /* Task handle. */

    //vTaskStartScheduler();
    //WifiCheckHostIp();



}

static uint16_t xCnt_restart = 0;
static void reconfigTs4231(void * parameter){
  Serial.print("\n[SYSTEM] waiting for Serial1");

  while(xbit_cfgserial != 1){
    //vTaskDelay(pdMS_TO_TICKS(100));
    vTaskDelay(100 / portTICK_PERIOD_MS);
    xCnt_restart++;
    if(xCnt_restart > 80){
      xCnt_restart = 0;
      Serial.print("\n[SYSTEM] Seems to be frozen restart");
      Serial.flush();
      ESP.restart();
      //Serial1.end();
    }
  }


  /*
  uint32_t reconfiger_fpga = 0;
  reconfiger_fpga++;
  if(reconfiger_fpga > 6000000){
    reconfiger_fpga = 0;
    Serial.print("\nsending reset frame");
    Serial1.write(reset_frame);
  }*/
  uint8_t i = 0;

  /*
  for (i = 0; i < 4; i++) {
    //vTaskDelay(pdMS_TO_TICKS(5000));
    vTaskDelay(5000 / portTICK_PERIOD_MS);
    Serial.print("\n[INFO] sending reset CMD to FPGA");
    //Serial1.write(reset_frame);
    //Serial1.write(0b10111101);
    //Serial1.write(reset_frame);
    //vTaskDelay(500 / portTICK_PERIOD_MS);
    Serial1.write(cmd_sende,4);
    //Serial1.write(0b10111101);
    //vTaskDelay(500 / portTICK_PERIOD_MS);
    //Serial1.write(reset_frame);
    //Serial1.write(0b10111101);
    vTaskDelay(2000 / portTICK_PERIOD_MS);
    Serial.print("\n[INFO] REST Sensors");
    Serial1.write(0b10111101);
    Serial1.write(reset_frame);
    //vTaskDelay(1000 / portTICK_PERIOD_MS);
    //Serial.print("\n[INFO] ...no clue ");
    //Serial1.write(0b10111101);


  }*/


  Serial.print("\n[SYSTEM] ENDING RECONFIG TASK");
  vTaskSuspend( NULL );
}

void WifiCheckHostIp( void * parameter ){
  //uint8_t WifiCheckHostCnt = 0;

//  while (WifiCheckHostIp < 100){

  //}
  whylove.checkHostConfig();

  //vTaskDelete( NULL );
  //vTaskSuspend( NULL );
}

/*
static uint32_t StaticSensorID = 22;
// Beamword length is acuall 17 bit
static uint32_t StaticBeamWord = 33;
static uint32_t StaticTimestamp = 44;
static uint32_t StaticE_width = 55;
static uint32_t StaticBaseStationID = 66;
static bool StaticBaseStationChanel = true;
static bool newData = 0;


void lighthouse2Data( void * parameter ){

  DarkRoomProtobuf_lighthouseMsg msg = DarkRoomProtobuf_lighthouseMsg_init_zero;


/*


  while(1){
    if(newData){
      msg.SensorID = StaticSensorID;
      msg.BeamWord = StaticBeamWord;
      msg.Timestamp = StaticTimestamp;
      msg.E_width = StaticE_width;
      msg.BaseStationID = StaticBaseStationID;
      msg.BaseStationChanel = StaticBaseStationChanel;
      newData = 0;

      (void)whylove->lighthouse2DataStream(msg);
    }


    //vTaskDelay(10 / portTICK_PERIOD_MS);
  }

  //vTaskDelete( NULL );
  vTaskSuspend( NULL );
}*/

//LIGHTHOUSEDATACONV * lh = NULL;

/*
static void sensorReadIn_static(void * parameter){

  uart_event_t event;
    size_t buffered_size;
    bool exit_condition = false;

    while(1){
       if(xQueueReceive(uart2_queue, (void * )&event, (portTickType)portMAX_DELAY)) {

       }

    }

}
*/

#define DATA_LENGTH 12
#define BUFFER_SIZE_MULTIPLYER 10
#define BUFFER_SIZE ( DATA_LENGTH * BUFFER_SIZE_MULTIPLYER )

static int syncCnt = 0;
static unsigned char singleByteBuffer;
static uint8_t buffer_Cnt = 0;
static char buffer [BUFFER_SIZE] = {};
//static char data_inputs[DATA_LENGTH][BUFFER_SIZE_MULTIPLYER] = {};
static char buffer_dump;


static uint8_t payload_counter = 0;
static void readRx_buffer( size_t size_max ){

  size_t amount_of_data_rdy = Serial1.available();
  size_t cnt = 0;
  //buffer_Cnt = 0;
  int dump_cnt = 0;
  syncCnt = 0;
  int shiftcount = 0;

  if(amount_of_data_rdy < DATA_LENGTH-1){
    buffer_Cnt = 0;
      //Serial.print("\nNewBuffer: RESET");
    //Serial.print(amount_of_data_rdy);
    return;
  }


  if( BUFFER_SIZE < amount_of_data_rdy ){
    dump_cnt = amount_of_data_rdy - BUFFER_SIZE;
  }

  if( dump_cnt > 0){
    for (size_t i = 0; i < dump_cnt; i++) {
      for (size_t j = 0; j < 12; j++) {
        buffer[0] = Serial1.read();
        i++;
      }
    }
  }

  while(cnt < amount_of_data_rdy){
    buffer[buffer_Cnt] = Serial1.read();

    if(buffer[buffer_Cnt] == 0xff){
      syncCnt++;
    }else{
      syncCnt = 0;
    }

    buffer_Cnt++;
    cnt++;

    if(syncCnt >= DATA_LENGTH){
      buffer_Cnt=0;
      //cnt = 0;
      buffer[buffer_Cnt] = 0;
      /*
      if(buffer_Cnt <= DATA_LENGTH){
        buffer_Cnt = 0;
      }else{
        shiftcount = buffer_Cnt % syncCnt;
        buffer_Cnt = buffer_Cnt - DATA_LENGTH;

        for (size_t j = 0; j < buffer_Cnt; j++) {
          buffer[j] = buffer[j + shiftcount];
        }

        //for (size_t j = buffer_Cnt; j < 12; j++) {
        //  buffer[j] = 0;
        //}

      }*/
      syncCnt = 0;
    }


  }

  //Serial.print("\nB:");
  //Serial.print(buffer_Cnt);



}

static uint8_t xBit_block_udp = 0;
static LIGHTHOUSEDATACONV lh2d[MAX_SENSORS];

static void sensorReadIn( void * parameter ) {
  portMUX_TYPE myMuex = portMUX_INITIALIZER_UNLOCKED;

  Serial.print("\nData grabber Task started");
  Serial.flush();



  (void)whylove.lighthouse2DataStream(lh2d[0].msg);


  size_t buffer_size = 8;
  size_t foo;

  uint32_t foo_timeoutTester = 0;

  //uint32_t RxBuffer_RdySize = 0;

  //Serial.print("\nReduce BufferSize ");
  //Serial.print(Serial1.setRxBufferSize(24));
  Serial.print("\n[INFO] clear Serial1 input buffer");
  Serial.print("\n[INFO] looking for device");
  Serial.flush();
  Serial1.flush();

  //syncData();

  Serial.print("\n[INFO] found device\n");



  uint32_t offset_temp = 0;
  uint32_t beam_word_temp = 0;
  uint32_t timestamp_temp = 0;
  uint32_t first_word_temp = 0;


  uint8_t sensor_temp;
  int32_t sensor_add;


  //DarkRoomProtobuf_lighthouseMsg msg = DarkRoomProtobuf_lighthouseMsg_init_zero;

  //uint32_t firstBeamData[MAX_SENSORS];

  static uint8_t currentSensorID = 0;
  uint8_t resync_cnt = 0;
  //Serial.print("\n[INFO] SIZE of buffer");Serial.print(sizeof(buffer));

Serial.print("\n[INFO] BufferSize: ");
Serial.print(BUFFER_SIZE);



  while(1){
      foo_timeoutTester = 0;
      payload_counter = 0;

      //syncCnt = 0;
      //for (size_t i = 0; i < sizeof(buffer); i++) {
      //  buffer[i] = 0;
      //}

      /*if(resync_cnt == 1){
        Serial.print("\nResync: ");Serial.print(Serial1.available());
        syncData();
        resync_cnt = 0;
      }*/

      //while(Serial1.available() < 12) {
          //char t = Serial1.read();
      //}

      /*
      buffer_Cnt = 0;
      while(buffer_Cnt < 12){
        while(Serial1.available() > 0) {
            buffer[buffer_Cnt] = Serial1.read();
            buffer_Cnt++;
            if(buffer_Cnt > 12){
                buffer[12] = 0xff;
                buffer[13] = 0xff;
                buffer_Cnt = 0;
            }else if(buffer_Cnt == 12){
              buffer[12] = 0xb0;
              buffer[13] = 0x0b;
            }
        }
      }
      buffer_Cnt = 0;*/

      /*
      reconfiger_fpga++;
      if(reconfiger_fpga > 6000000){
        reconfiger_fpga = 0;
        Serial.print("\nsending reset frame");
        Serial1.write(reset_frame);
      }
      */

      readRx_buffer(BUFFER_SIZE);
      if(buffer_Cnt >= 12){
        uint16_t buffer_Cnt_temp = buffer_Cnt;
        while (buffer_Cnt > 0){

          timestamp_temp = (buffer[11]<<16) | (buffer[10]<<8) | (buffer[9]);
          beam_word_temp = (buffer[8]<<16) | (buffer[7]<<8) | (buffer[6]);
          offset_temp = (buffer[5]<<16) | (buffer[4]<<8) | (buffer[3]);
          first_word_temp  = (buffer[2]<<16) | (buffer[1]<<8) | (buffer[0]);

          //sensor_add = offset_temp - 1;//((offset >> 17) & 0x03 ) - 1;
          sensor_add = ((offset_temp >> 18) & 0xff) - 1;

          /*
          Serial.print("\nxTS: ");Serial.print(timestamp_temp, HEX);
          Serial.print("\nxBW: ");Serial.print(beam_word_temp, HEX);
          Serial.print("\nxOF: ");Serial.print(offset_temp, HEX);
          Serial.print("\nxFW: ");Serial.print(first_word_temp, HEX);
          Serial.print("\n");
          Serial.print(buffer_Cnt);
          Serial.print("++");
          */

          //(offset_temp & 0xffff00) == 0 && (offset_temp & 0x0000ff) != 0 &&
          // Hier koennte sich ein decoding fehler eingeschlichen haben
          // (beam_word_temp & 0x00007f) == 0 sollte glaube ich  (beam_word_temp & 0xfe0000) == 0 sein
          if((beam_word_temp & 0xfe0000) == 0 && (beam_word_temp & 0x01ffff) != 0 && (offset_temp & 0xf20000) == 0 && sensor_add >= 0 && sensor_add < 2 && timestamp_temp > 20){ // buffer[2]  >= 0xf0
            offset_temp = offset_temp & 0x01ffff;
            sensor_temp = buffer[0] & 0x03;

            //buffer_Cnt = 0;
              //Serial.print("\n====[SUCESS] === ");Serial.print(buffer_Cnt);
              xBit_block_udp = 0;
              uint16_t sent_count = 0;
              for (size_t i = 12; i <= buffer_Cnt; i=i+12) {

              //  data_inputs[]
                while(xBit_block_udp){
                  vTaskDelay(1 / portTICK_PERIOD_MS);
                }
                sent_count = i;
                xBit_block_udp++;
                currentSensorID = (sensor_add * 4) + sensor_temp;
                //buffer_Cnt = 0;
                //taskENTER_CRITICAL(&myMuex);
                vTaskDelay(1 / portTICK_PERIOD_MS);
                int8_t ret = lh2d[currentSensorID].pushUartData(&buffer[i]);
                if (ret == 1){//(offset[0] != 0xffffff)){ // && (width >= 10) and (beam_word != 0xffffff)){
                    //Serial.print("\nlh2d\n");

                    Serial.print(" [ID:");
                    Serial.print(currentSensorID);
                    Serial.print("] TS: ");
                    Serial.print(lh2d[currentSensorID].timestamp, HEX);
                    Serial.print(" Width: ");
                    Serial.print(lh2d[currentSensorID].width, HEX);
                    Serial.print(" Chan: ");
                    Serial.print(lh2d[currentSensorID].channel + 1);
                    Serial.print(" (");
                    Serial.print(lh2d[currentSensorID].slow_bit);
                    Serial.print(")");
                    Serial.print(" Poly: ");
                    Serial.print(lh2d[currentSensorID].identity, HEX);
                    Serial.print(" BeamWord: ");
                    Serial.print(lh2d[currentSensorID].beam_word, HEX);
                    Serial.print(" BeamWord2: ");
                    Serial.print(lh2d[currentSensorID].msg.E_width, HEX);

                    Serial.print("\n");


                    (void)whylove.lighthouse2DataStream(lh2d[currentSensorID].msg);

                    if(xBit_block_udp > 1){
                        Serial.print("\n===== WE FOUND THE ERROR ");
                    }
                    //vTaskDelay(10 / portTICK_PERIOD_MS);

                    vTaskDelay(5 / portTICK_PERIOD_MS);



                    //Serial.print(sensor, HEX);
                    //Serial.print("Sensor: %d  TS:{%x}  Width:{%x}  Chan:{%d}({%d})  nPoly:{%x}  BeamWord:{%x}\n", sensor, timestamp, width, channel + 1, slow_bit, identity, beam_word);

                }else if (ret == -1){
                    resync_cnt=1;

                }
                  //taskEXIT_CRITICAL(&myMuex);
                  xBit_block_udp = 0;
            }

            //TODO clear out remaining buffer data
            buffer_Cnt = buffer_Cnt - sent_count;// - 1;
            for (size_t i = 0; i < buffer_Cnt; i++) {
              /* code */
            }



            //for (size_t i = 0; i < buffer_Cnt; i++) {
          //   buffer[i] = buffer[i+1];
          //  }


            Serial.print("\nNewBuffer: ");Serial.print(buffer_Cnt);
            //buffer_Cnt = 0;
            break;
          }else{
            if(buffer_Cnt > 11){
              if ((beam_word_temp & 0xfe0000) == 0)
                Serial.print("\ntest 1");
              if ((beam_word_temp & 0x01ffff) != 0)
                Serial.print("\ntest 2");
              if ((offset_temp & 0xf20000) == 0)
                Serial.print("\ntest 3");
              if (sensor_add >= 0)
                Serial.print("\ntest 4");
              if ( sensor_add < 2)
                Serial.print("\ntest 5");
              if ( timestamp_temp > 20)
                Serial.print("\ntest 6");

                Serial.print("\nxTS: ");Serial.print(timestamp_temp, HEX);
                Serial.print("\nxBW: ");Serial.print(beam_word_temp, HEX);
                Serial.print("\nxOF: ");Serial.print(offset_temp, HEX);
                Serial.print("\nxFW: ");Serial.print(first_word_temp, HEX);
                Serial.print("\n");
                Serial.print(buffer_Cnt);
                Serial.print("++");

              for (size_t i = 0; i < buffer_Cnt; i++) {
                buffer[i] = buffer[i+1];
              }
              //Serial.print("\nBuffer -1");
              buffer_Cnt--;


            }else{
              Serial.print("\nNo valid data found ");
              buffer_Cnt = 0;
              //break;
            }
          }

        }

      }





  }
  Serial.print("=====\nERROR WTF\n======\nTASK WAS KILLED");
  vTaskSuspend( NULL );
}

void loop() {
    // if programming failed, don't try to do anything
    if (!dmpReady) return; //Fails on ESP32



    //Serial.print("SPI Stuff");
    //vspiCommand();


    //Serial.print(".");
    //whylove->fmsgTest_s();
    //whylove->fmsgTest_s();


    /*
    // wait for MPU interrupt or extra packet(s) available
    do {
        whylove->fmsgTest_s();
        if(whylove->receiveCommand()){
          // this command will be read by the fpga regularily
          //SPISlave.setStatus(whylove->command);
          switch(whylove->command & 0xF){
            case RESET:
              Serial.println("rebooting ESP in 3 seconds");
              delay(3000);
              //ESP.reset(); //ESP82
              ESP.restart(); //ESP32
              break;
            case MPU:
              Serial.printf("Received MPU6050 toggle %s", (whylove->command>>4)?"true":"false");
              dmpReady = whylove->command>>4;
              break;
            case TRACKING:
              Serial.printf("Received Tracking toggle %s", (whylove->command>>4)?"true":"false");
              break;
          }
        }
        yield();
    }while (!mpuInterrupt && fifoCount < packetSize);

    /*
    // reset interrupt flag and get INT_STATUS byte
    mpuInterrupt = false;
    mpuIntStatus = mpu.getIntStatus();

    // get current FIFO count
    fifoCount = mpu.getFIFOCount();

    // check for overflow (this should never happen unless our code is too inefficient)
    if ((mpuIntStatus & 0x10) || fifoCount == 1024) {
        // reset so we can continue cleanly
        mpu.resetFIFO();
        Serial.println(F("FIFO overflow!"));

    // otherwise, check for DMP data ready interrupt (this should happen frequently)
    } else if (mpuIntStatus & 0x02) {
        // wait for correct available data length, should be a VERY short wait
        while (fifoCount < packetSize) fifoCount = mpu.getFIFOCount();

        // read a packet from FIFO
        mpu.getFIFOBytes(fifoBuffer, packetSize);

        // track FIFO count here in case there is > 1 packet available
        // (this lets us immediately read more without waiting for an interrupt)
        fifoCount -= packetSize;

        // display real acceleration, adjusted to remove gravity
        mpu.dmpGetQuaternion(&q, fifoBuffer);
        mpu.dmpGetAccel(&aa, fifoBuffer);
        mpu.dmpGetGravity(&gravity, &q);

        whylove->sendImuData(q,aa,gravity);
    }
    */
  }



  /*if( resync_cnt > 4){
        ///Serial1.flush();
        unsigned char singleByteBuffer2;
        int syncCnt2 = 0;
        Serial.print("\n[INFO] Starting resync\n");
        Serial.flush();
        Serial1.flush();
        while(Serial1.available() > 0) {
            char t = Serial1.read();
        }


        //Serial.print("\n[INFO] lock scheduler to this task");
        //vTaskSuspendAll();
        //const uint32_t xValue = 100UL;
        //while(Serial1.available() < 12){
          //xQueueSend(xQueue, &xValue, 0);
        //};
        */

        /*
        foo_timeoutTester = 0;
        while(Serial1.available() < 12){
          foo_timeoutTester++;
          if(foo_timeoutTester > 1000){
            foo_timeoutTester = 0;
            vTaskDelay(2 / portTICK_PERIOD_MS);
          }
        }*/

        /*
        //taskENTER_CRITICAL(&myMuex);
        int syncCnt = 0;
        unsigned char singleByteBuffer;
        while (syncCnt < 12){
          //singleByteBuffer = Serial1.read();
          //unsigned char singleByteBuffer[8];
          //foo = Serial1.read(singleByteBuffer,sizeof(singleByteBuffer));
          if(Serial1.available() > 0){
            singleByteBuffer = Serial1.read();
            //Serial.print(singleByteBuffer, HEX);
            if(singleByteBuffer == 0xff){
              syncCnt++;
            }else{
              syncCnt = 0;
            }
          }

        }
        resync_cnt = 0;
        Serial.print("\n[INFO] resync Sucess");
    }
    */


    //taskEXIT_CRITICAL(&myMuex);

    /*
    offset_temp = (buffer[5]<<16) | (buffer[4]<<8) | (buffer[3]);
    sensor_temp = buffer[0] & 0x03;
    sensor_add = offset_temp - 1;//((offset >> 17) & 0x03 ) - 1;
    if(sensor_add < 0){
      //Serial.print("\n Might be an erro pls restart: ");
      currentSensorID = sensor_temp;
    }else{
      currentSensorID = (sensor_add * 4) + sensor_temp;
      //Serial.print(offset_temp, HEX);
    }
    */

    //taskENTER_CRITICAL(&myMuex);
    /*
    while(buffer_Cnt < 64){
        buffer[buffer_Cnt] = Serial1.read();
      //if(Serial1.available() > 0){
        //buffer[buffer_Cnt] = Serial1.read();
        //Serial1.read(buffer,12);

        buffer_Cnt++;
      //}//else if(buffer_Cnt >= 11){
        //Serial.print("\n Incount: ");
        //Serial.print(buffer_Cnt);
      //  break;
      //}
      if(buffer_Cnt >= 12){
        //timestamp[0] = (buffer[11]<<16) | (buffer[10]<<8) | (buffer[9]);
        //beam_word[0] = (buffer[8]<<16) | (buffer[7]<<8) | (buffer[6]);
        offset_temp = (buffer[5]<<16) | (buffer[4]<<8) | (buffer[3]);
        //first_word[0] = (buffer[2]<<16) | (buffer[1]<<8) | (buffer[0]);

        //Serial1.flush();
        //currentSensorID = (buffer[0] & 0x03);
        sensor_temp = buffer[0] & 0x03;
        sensor_add = offset_temp - 1;//((offset >> 17) & 0x03 ) - 1;
        if(sensor_add < 0){
          //Serial.print("\n Might be an erro pls restart: ");
          currentSensorID = sensor_temp;
        }else{
          currentSensorID = (sensor_add * 4) + sensor_temp;
          //Serial.print(offset_temp, HEX);
        }
        break;
      }
      //if(Serial1.available() <= 0){
      //  break;
      //}
    }
    */
    //taskEXIT_CRITICAL(&myMuex);



    //static void syncData(){
      //Serial1.flush();

      //Clearing the Readbuffer.
      /*
      for (size_t i = 0; i < sizeof(buffer); i++) {
        buffer[i] = 0;
      }*/

      /*Serial.print("\nCurrently av. data: ");Serial.print(Serial1.available());

      while(Serial1.available() > 0) {
          char t = Serial1.read();
      }*/
/*
      syncCnt = 0;
      uint32_t offset = 0;
      uint32_t beam_word = 0;
      uint32_t timestamp = 0;
      Serial.print("\nStarting to search sync string\n");
      buffer_Cnt = 0;
      while (syncCnt < 12){
        //singleByteBuffer = Serial1.read();
        //unsigned char singleByteBuffer[8];
        //foo = Serial1.read(singleByteBuffer,sizeof(singleByteBuffer));
        if(Serial1.available() > 0){
          singleByteBuffer = Serial1.read();
          //Serial.print(singleByteBuffer, HEX);
          buffer[buffer_Cnt] = Serial1.read();
          buffer_Cnt++;


          if(buffer_Cnt >= 12){
            if(buffer_Cnt > 12){
              for (size_t i = 0; i < buffer_Cnt; i++) {
                buffer[i] = buffer[i+1];
              }
              buffer_Cnt--;
            }
            timestamp = (buffer[11]<<16) | (buffer[10]<<8) | (buffer[9]);
            beam_word = (buffer[8]<<16) | (buffer[7]<<8) | (buffer[6]);
            offset = (buffer[5]<<16) | (buffer[4]<<8) | (buffer[3]);

          }
        //  if(buffer_Cnt >= 12){
        //    buffer_Cnt=0;
          //}

          if((offset & 0xffff00) != 0 && (beam_word & 0x00007f) != 0 ){
            Serial.print("\nShould be resynced via pattern");
            break;
          }

          if(singleByteBuffer == 0xff){
            syncCnt++;
          }else{

            syncCnt = 0;
          }
        }else{
          //Serial.print("\ncnt: ");Serial.print(syncCnt);
          vTaskDelay(pdMS_TO_TICKS(1));
        }

      }


      syncCnt = 0;
      while(1) {
        if(Serial1.available() >= 11){
          break;
        }//else if(Serial1.available() > 0){
        //  Serial.print("=");
        //}else{
        //  Serial.print(".");
        ///}

          //char t = Serial1.read();
      }

      buffer_Cnt = 0;
      while(Serial1.available() > 0) {
          buffer[buffer_Cnt] = Serial1.read();
          buffer_Cnt++;
          if(buffer_Cnt > sizeof(buffer)){
              buffer_Cnt=0;
          }
      }
      buffer_Cnt = 0;
      */

//    }
