#include "lighthouse2Data.hpp"

LIGHTHOUSEDATACONV::LIGHTHOUSEDATACONV(){
  for (size_t i = 0; i < MAX_BASE_AMOUNT; i++) {
    init_Done[i] = 0;
  }


}

int8_t LIGHTHOUSEDATACONV::pushUartData(char *data){
  uint8_t buffer [UART_FRAME_SIZE];

  int32_t divTime = 0;

  for (size_t i = 0; i < UART_FRAME_SIZE; i++) {
    buffer[i] = *data;
    data++;
  }

  timestamp = (buffer[11]<<16) | (buffer[10]<<8) | (buffer[9]);
  beam_word = (buffer[8]<<16) | (buffer[7]<<8) | (buffer[6]);
  offset = (buffer[5]<<16) | (buffer[4]<<8) | (buffer[3]);
  first_word = (buffer[2]<<16) | (buffer[1]<<8) | (buffer[0]);

  if ((offset != 0xffffff) && (beam_word != 0xffffff) ){ // && (beam_word != 0xffffff)
    uint8_t sensor_temp = first_word & 0x03;
    int8_t sensor_add = offset - 1;//((offset >> 17) & 0x03 ) - 1;

    /*
    Serial.print("\n\nNO: ");Serial.print(sensor, HEX);

    //Serial.print(" ID_add: ");Serial.print(sensor_add, HEX);

    Serial.print(" OF: ");Serial.print(offset, HEX);
    //Serial.print(" sensor_add: ");Serial.print(sensor_add, HEX);
    //Serial.print(" identity: ");Serial.print(identity,HEX);
    Serial.print(" TS: ");Serial.print(timestamp, HEX);
    Serial.print(" TS-last : ");Serial.print(prevSweepTime[identity], HEX);
    Serial.print(" TimeDiv: ");Serial.print(divTime);
    Serial.print(" BW: ");Serial.print(beam_word, HEX);*/

    if ((offset & 0xffff00) != 0 ){
      //Serial.print("\n[ERROR] (offset & 0xffff00) != 0: ");Serial.print(offset, HEX);
      /*
      Serial.print(" ID: ");Serial.print(sensor, HEX);

      Serial.print(" OF: ");Serial.print(offset, HEX);
      Serial.print(" sensor_add: ");Serial.print(sensor_add, HEX);
      Serial.print(" identity: ");Serial.print(identity,HEX);
      Serial.print(" TS: ");Serial.print(timestamp, HEX);
    */

      return -1;
    }


    if(sensor_add < 0){
      //Serial.print("\n Might be an erro pls restart: ");
      sensor = sensor_temp;
    }else{
      sensor = (sensor_add * 4) + sensor_temp;
    }

    width = (first_word >> 8) & 0xffff;

    /*
    Serial.print("\nTS: ");Serial.print(timestamp, HEX);
  Serial.print("\nBW: ");Serial.print(beam_word, HEX);
  Serial.print("\nOF: ");Serial.print(offset, HEX);
  Serial.print("\nFW: ");Serial.print(first_word, HEX);
  Serial.print("\n===========");
    */

    nPoly_ok = ((first_word >> 7) & 0x01) == 0;
    identity = (first_word >> 2) & 0x1f;
    channel = identity >> 1;
    slow_bit = identity & 0x01;



    if(identity < 32){
      if ((nPoly_ok)){
        if(prevEwidth[identity] > width){
          divTime = timestamp - prevSweepTime[identity];

          /*
          //Serial.print("\n\nID_raw: ");Serial.print(sensor_temp, HEX);
          Serial.print("\n\nID: ");Serial.print(sensor, HEX);

          //Serial.print(" ID_add: ");Serial.print(sensor_add, HEX);

          Serial.print(" OF: ");Serial.print(offset, HEX);
          //Serial.print(" sensor_add: ");Serial.print(sensor_add, HEX);
          //Serial.print(" identity: ");Serial.print(identity,HEX);
          Serial.print(" TS: ");Serial.print(timestamp, HEX);
          Serial.print(" TS-last : ");Serial.print(prevSweepTime[identity], HEX);
          Serial.print(" TimeDiv: ");Serial.print(divTime);
          Serial.print(" BW: ");Serial.print(beam_word, HEX);
          */

          if(divTime < MAX_DELTA_TIME  && divTime > 30){//divTime < MAX_DELTA_TIME && divTime > 10){
            Serial.print("\nTimeDiv: ");Serial.print(divTime);
          //}
          //if(1){
            msg.SensorID = sensor;
            msg.BeamWord = beam_word;
            msg.Timestamp = timestamp;
            msg.E_width = prevBeamWord[identity];//width;
            msg.BaseStationID = channel + 1;
            msg.BaseStationChanel = slow_bit;



            prevSweepTime[identity] = timestamp;
            prevBeamWord[identity] = beam_word;
            prevEwidth[identity] = width;

            /*
            Serial.print("\n\nSensor ");Serial.print(sensor, HEX);
            Serial.print(" BW: ");Serial.print(beam_word, HEX);
            Serial.print(" TS: ");Serial.print(timestamp, HEX);
            Serial.print(" TS-last : ");Serial.print(prevSweepTime[identity], HEX);
            Serial.print(" TimeDiv: ");Serial.print(divTime);
            Serial.print(" IDEN: ");Serial.print(identity);
            Serial.print(" SBit: ");Serial.print(slow_bit);
            */

            return 1;
          }
          //if(init_Done[identity]  == 0){
            prevSweepTime[identity] = timestamp;
            prevBeamWord[identity] = beam_word;
            prevEwidth[identity] = width;
            init_Done[identity] = 1;
          //}
        }else{

          prevSweepTime[identity] = timestamp;
          prevBeamWord[identity] = beam_word;
          prevEwidth[identity] = width;
        }


      }else{
        prevEwidth[identity] = 0;
      }
   }

 }else {
   /*
   Serial.print("\n[ERROR] (offset != 0xffffff) && (beam_word != 0xffffff) : \nOFSET: ");
   Serial.print(offset, HEX);
   Serial.print("\nBeamword: ");
   Serial.print(beam_word, HEX);
   */

   //return -1;
 }

  return 0;
}
