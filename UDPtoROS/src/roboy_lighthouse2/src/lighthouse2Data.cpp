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

#define P (60 * M_PI / 180)
#define P1 (120 * M_PI / 180)
#define P2 (tan( P / 2 ))
#define PREBEAM (8.0 * 2 * M_PI)
void LightHouseDataProcessing::angleCalc(uint32_t firstBeamTick, uint32_t secondBeamTick, uint32_t channel, struct angleData * retAngle){

    //retAngle->azimuth = 0.1;
    //retAngle->elevation = 0.2;
    //std::cout << "\nFirst TICK: " << firstBeamTick << " Second TICK: " << secondBeamTick;
    long double BeamBuffer1 = firstBeamTick * PREBEAM;
    long double BeamBuffer2 = secondBeamTick * PREBEAM;
    long double firstBeam  = (BeamBuffer1  / PERIODS[channel-1]);
    long double secondBeam = (BeamBuffer2  / PERIODS[channel-1]);//((secondBeamTick * 8.0) / PERIODS[channel-1]) * 2 * M_PI;
    //std::cout << "\nFirst Beam: " << firstBeam << " Second Beam: " << secondBeam;

    long double BeamDiv = (secondBeam - firstBeam);
    long double BeamAdd = (secondBeam + firstBeam);
    long double BeamAddHalf = BeamAdd/2;

    retAngle->azimuth = BeamAddHalf - M_PI;
    //double p    = P;
    long double beta = BeamDiv - P1;
    long double calcBuffer = sin(beta/2);
    long double calcBuffer2 = calcBuffer/P2;
    //std::cout << "\nP1: " << P1;
    //std::cout << "\ncalc Buffer: " << calcBuffer << "\ncalc Buffer2: " << calcBuffer2;

    retAngle->elevation =  atan(  calcBuffer2 );




}
