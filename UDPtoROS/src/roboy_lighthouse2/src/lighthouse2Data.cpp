#include <lighthouse2Data.hpp>

LIGHTHOUSEDATACONV::LIGHTHOUSEDATACONV(){




}

bool LIGHTHOUSEDATACONV::pushUartData(char *data){
  uint8_t buffer [UART_FRAME_SIZE];

  for (size_t i = 0; i < UART_FRAME_SIZE; i++) {
    buffer[i] = *data++;
  }

  timestamp = (buffer[11]<<16) | (buffer[10]<<8) | (buffer[9]);
  beam_word = (buffer[8]<<16) | (buffer[7]<<8) | (buffer[6]);
  offset = (buffer[5]<<16) | (buffer[4]<<8) | (buffer[3]);
  first_word = (buffer[2]<<16) | (buffer[1]<<8) | (buffer[0]);

  if ((offset != 0xffffff)){ // && (width >= 10) and (beam_word != 0xffffff)){
    sensor = first_word & 0x03;
    width = (first_word >> 8) & 0xffff;

    nPoly_ok = ((first_word >> 7) & 0x01) == 0;
    identity = (first_word >> 2) & 0x1f;
    channel = identity >> 1;
    slow_bit = identity & 0x01;

    if (nPoly_ok){
      if(prevEwidth[channel] > width){
        if((prevSweepTime[channel]-timestamp) > MAX_DELTA_TIME){
          msg.SensorID = sensor;
          msg.BeamWord = beam_word;
          msg.Timestamp = timestamp;
          msg.E_width = prevBeamWord[channel];//width;
          msg.BaseStationID = channel + 1;
          msg.BaseStationChanel = slow_bit;

          prevSweepTime[channel] = timestamp;
          prevBeamWord[channel] = beam_word;
          prevEwidth[channel] = width;

          return true;
        }
      }else{
        prevSweepTime[channel] = timestamp;
        prevBeamWord[channel] = beam_word;
        prevEwidth[channel] = width;
      }

    }

  }

  return false;
}



LightHouseDataProcessing::LightHouseDataProcessing(){

}

#define P (60.0 * M_PI / 180.0)
#define P1 (120.0 * M_PI / 180.0)
#define P2 (tan( P / 2.0 ))
#define PREBEAM (8.0 * 2.0 * M_PI)
void LightHouseDataProcessing::angleCalc(uint32_t firstBeamTick, uint32_t secondBeamTick, uint32_t channel, struct angleData * retAngle){


    //retAngle->azimuth = 0.1;
    //retAngle->elevation = 0.2;
    //std::cout << "\nFirst TICK: " << firstBeamTick << " Second TICK: " << secondBeamTick;
    //long double BeamBuffer1 = firstBeamTick * 2 * 2 * M_PI;//* PREBEAM;
    //long double BeamBuffer2 = secondBeamTick * 2 * 2 * M_PI;// * PREBEAM;
    long double BeamBuffer1 = (long double)firstBeamTick * 1.0;//* PREBEAM;
    long double BeamBuffer2 = (long double)secondBeamTick * 1.0;

    BeamBuffer1 = (long double)(BeamBuffer1 * PREBEAM);//* PREBEAM;
    BeamBuffer2 = (long double)(BeamBuffer2 * PREBEAM);

    /*
    long double secondBeamBuffer = (secondBeam - PERIODS[channel-1]/2);
    if(secondBeamBuffer < PERIODS[channel-1]/2){
      BeamBuffer2 = secondBeamBuffer * PREBEAM;// * PREBEAM;
    }else{
      secondBeamBuffer = secondBeam * PREBEAM;// * PREBEAM;
      BeamBuffer2 = (secondBeamBuffer - PERIODS[channel-1]/2);
    }*/

    long double firstBeam  = (BeamBuffer1  / PERIODS[channel-1]);
    long double secondBeam = (BeamBuffer2  / PERIODS[channel-1]);//((secondBeamTick * 8.0) / PERIODS[channel-1]) * 2 * M_PI;

    //std::cout << "\nFirst Beam: " << firstBeam << " Second Beam: " << secondBeam;


    //long double BeamDiv = (secondBeamBuffer - firstBeam);
    long double BeamDiv = (secondBeam - firstBeam);
    //long double BeamAdd = (secondBeamBuffer + firstBeam);
    long double BeamAdd = (secondBeam + firstBeam);
    long double BeamAddHalf = BeamAdd/2.0;

    retAngle->azimuth = BeamAddHalf - M_PI;

    //double p    = P;
    long double beta = BeamDiv - P1;
    //long double calcBuffer = sin(beta/2);
    long double calcBuffer = sin(beta/2.0);
    long double calcBuffer2 = calcBuffer/P2;
    //std::cout << "\nP1: " << P1;
    //std::cout << "\ncalc Buffer: " << calcBuffer << "\ncalc Buffer2: " << calcBuffer2;

    retAngle->elevation =  atan(  calcBuffer2 );


    /*

    //Generall calculation
    long double factor45deg = sqrt(2)/2;
    long double T = PERIODS[channel-1]/2;

    //The system keeps track of the time with a counter that increments with 24MHz, to correct the 6MHz clock of the LFSR the correction factor is:
    //k = 24Mhz/6Mhz = 4
    long double k = 24/6;

    //BrainERROR... divied or multiply
    //k = f/6Mhz   T = f/50Hz  .... ticks * k/T = ticks * 6Mhz/50Hz
    long double t1 = firstBeamTick * k; // firstBeamTick/k
    long double t2 = secondBeamTick * k; // secondBeamTick/k
    t2 = t2 - T/2;

    long double TimeAngleRelation1 = t1 / (T/2); //Soll ja
    long double TimeAngleRelation2 = t2 / (T/2);

    long double phi1 = asin(TimeAngleRelation1);
    long double phi2 = asin(TimeAngleRelation2);

    //resulting vector ray
    long double r1[3] = {};
    long double r2[3] = {};
    long double r[3] = {};

    r1[0]  = -factor45deg * cos(phi1);
    r2[0]  = factor45deg * cos(phi2);

    r1[1]  = -r1[0];
    r2[1]  = r2[0];

    r1[2]  = TimeAngleRelation1;
    r2[2]  = TimeAngleRelation2;

    r[0] = r1[0] + r2[0];
    r[1] = r1[1] + r2[1];
    r[2] = r1[2] + r2[2];

    retAngle->azimuth = atan(r[0]/r[1]);
    retAngle->elevation = atan(r[2]/r[1]);

    */

}
