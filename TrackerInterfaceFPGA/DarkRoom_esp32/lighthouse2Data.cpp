#include "lighthouse2Data.hpp"

LIGHTHOUSEDATACONV::LIGHTHOUSEDATACONV(){
  for (size_t i = 0; i < MAX_BASE_AMOUNT; i++) {
    init_Done[i] = 0;
  }


}

int8_t LIGHTHOUSEDATACONV::pushUartData(char *data){
  static uint8_t buffer [UART_FRAME_SIZE];
  uint8_t identity_swap = 0;

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
    //uint8_t sensor_temp = first_word & 0x03;
    sensor = first_word & 0x03;
    int8_t sensor_add = ((offset >> 18) & 0xff) - 1;//((offset >> 17) & 0x03 ) - 1;

    offset = offset & 0x01ffff;

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

    //if ((offset & 0xffff00) != 0 ){
    //if ((beam_word & 0x00007f) != 0 ){
      //Serial.print("\n[ERROR] (offset & 0xffff00) != 0: ");Serial.print(offset, HEX);
      /*
      Serial.print(" ID: ");Serial.print(sensor, HEX);

      Serial.print(" OF: ");Serial.print(offset, HEX);
      Serial.print(" sensor_add: ");Serial.print(sensor_add, HEX);
      Serial.print(" identity: ");Serial.print(identity,HEX);
      Serial.print(" TS: ");Serial.print(timestamp, HEX);
    */

    //  return -1;
    //}


    if(sensor_add < 0){
      Serial.print("\n Might be an erro pls restart: ");
      return -1;
      //sensor = sensor_temp;
    }else{
      sensor = (sensor_add * 4) + sensor;//sensor_temp;
    }

    width = (first_word >> 8) & 0xffff;

    //if offset > (lastMeasurements[channel]+10000):

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

    identity_swap = identity & (0xfe);
    identity_swap = identity_swap | ( !slow_bit );




    if(identity < 32 && sensor < 16){
      /*Serial.print(" [ID:");
      Serial.print(sensor);
      Serial.print("] ");
      Serial.print(" Chan: ");
      Serial.print(channel + 1);
      Serial.print(" (");
      Serial.print(slow_bit);
      Serial.print(")");*/
      if (offset > (prevOfset[identity]+10000)){

        msg.SensorID = sensor;
        msg.BeamWord = offset;
        msg.Timestamp = timestamp;
        msg.E_width = prevOfset[identity];//width;
        msg.BaseStationID = channel + 1;
        msg.BaseStationChanel = slow_bit;

        prevOfset[identity] = offset;
        prevSweepTime[identity] = timestamp;

        return 1;
      }
      else if (prevOfset[identity_swap] > (offset+10000)) {
        Serial.print("!!REV");
        msg.SensorID = sensor;
        msg.BeamWord = prevOfset[identity_swap]; //offset
        msg.Timestamp = prevSweepTime[identity_swap];//timestamp
        msg.E_width = offset; //offset
        msg.BaseStationID = channel + 1;
        msg.BaseStationChanel = slow_bit;

        prevOfset[identity] = offset;

        prevSweepTime[identity] = timestamp;
        prevBeamWord[identity] = beam_word;
        prevEwidth[identity] = width;

        return 1;
      }
      //Serial.print("\nOFSET ERROR: ");Serial.print(offset);
      //Serial.print("\nPREV: ");Serial.print(prevOfset[identity]);
      //Serial.flush();


      prevOfset[identity] = offset;

      prevSweepTime[identity] = timestamp;
      prevBeamWord[identity] = beam_word;
      prevEwidth[identity] = width;

      return -1;
    }

    Serial.print("\nID ERROR: ");Serial.print(identity);
    Serial.print("\nSensor: ");Serial.print(sensor);
    /*
      if ((nPoly_ok)){
        if (offset > (prevOfset[identity][sensor]+10000)){


        }
        if(prevEwidth[identity] > width){
          divTime = timestamp - prevSweepTime[identity];


          ////Serial.print("\n\nID_raw: ");Serial.print(sensor_temp, HEX);
          //Serial.print("\n\nID: ");Serial.print(sensor, HEX);

          ////Serial.print(" ID_add: ");Serial.print(sensor_add, HEX);

          //Serial.print(" OF: ");Serial.print(offset, HEX);
          ////Serial.print(" sensor_add: ");Serial.print(sensor_add, HEX);
          ////Serial.print(" identity: ");Serial.print(identity,HEX);
          //Serial.print(" TS: ");Serial.print(timestamp, HEX);
          //Serial.print(" TS-last : ");Serial.print(prevSweepTime[identity], HEX);
          //Serial.print(" TimeDiv: ");Serial.print(divTime);
          //Serial.print(" BW: ");Serial.print(beam_word, HEX);


          if(divTime < MAX_DELTA_TIME  && divTime > 30){//divTime < MAX_DELTA_TIME && divTime > 10){
            Serial.print("\nTimeDiv: ");Serial.print(divTime);
          //}
          //if(1){


            //prevOfset

            msg.SensorID = sensor;
            msg.BeamWord = offset;
            msg.Timestamp = timestamp;
            msg.E_width = prevOfset[identity];//width;
            msg.BaseStationID = channel + 1;
            msg.BaseStationChanel = slow_bit;



            prevSweepTime[identity] = timestamp;
            prevBeamWord[identity] = beam_word;
            prevEwidth[identity] = width;
            prevOfset[identity] = offset;


            //Serial.print("\n\nSensor ");Serial.print(sensor, HEX);
            //Serial.print(" BW: ");Serial.print(beam_word, HEX);
            //Serial.print(" TS: ");Serial.print(timestamp, HEX);
            //Serial.print(" TS-last : ");Serial.print(prevSweepTime[identity], HEX);
            //Serial.print(" TimeDiv: ");Serial.print(divTime);
            //Serial.print(" IDEN: ");Serial.print(identity);
            //Serial.print(" SBit: ");Serial.print(slow_bit);


            return 1;
          }
          //if(init_Done[identity]  == 0){
            prevSweepTime[identity] = timestamp;
            prevBeamWord[identity] = beam_word;
            prevEwidth[identity] = width;
            init_Done[identity] = 1;
            prevOfset[identity] = offset;
          //}
        }else{

          prevSweepTime[identity] = timestamp;
          prevBeamWord[identity] = beam_word;
          prevEwidth[identity] = width;
          prevOfset[identity] = offset;
        }


      }else{
        prevEwidth[identity] = 0;
      }
      */
   //}

 }else {
   Serial.print("\n[ERROR] (offset != 0xffffff) && (beam_word != 0xffffff) : \nOFSET: ");
   /*
   Serial.print("\n[ERROR] (offset != 0xffffff) && (beam_word != 0xffffff) : \nOFSET: ");
   Serial.print(offset, HEX);
   Serial.print("\nBeamword: ");
   Serial.print(beam_word, HEX);
   */

   //return -1;
   return 0;
 }

  return 0;
}
