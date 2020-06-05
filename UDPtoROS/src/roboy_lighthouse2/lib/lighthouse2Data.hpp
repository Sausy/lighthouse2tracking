#ifndef _LH2DATA_H_
#define _LH2DATA_H_


//#include <iostream>
#include <stdlib.h>
#include "protoLighthouse.h"
#include <math.h>


#define MAX_SENSORS 64
#define MAX_BASE_CHANNEL 2
#define MAX_DELTA_TIME 720000  //20ms * 1/24MHz with buffer 30ms * 1/24MHz = 720000
#define UART_SUBFRAME_SIZE_PERBYTE 3
#define UART_FRAME_SIZE (4*UART_SUBFRAME_SIZE_PERBYTE)

class LIGHTHOUSEDATACONV{
  public:
    LIGHTHOUSEDATACONV();

    bool pushUartData(char *data);

    uint32_t timestamp = 0;
    uint32_t beam_word = 0;
    uint32_t offset = 0;
    uint32_t first_word = 0;
    uint32_t sensor = 0;
    uint32_t width = 0;
    uint32_t nPoly_ok = 0;
    uint32_t identity = 0;
    uint32_t channel = 0;
    bool slow_bit = 0;

    uint8_t lut_Poly_id = 0;


    DarkRoomProtobuf_lighthouseMsg msg = DarkRoomProtobuf_lighthouseMsg_init_zero;


  private:
    uint32_t prevSweepTime[MAX_BASE_CHANNEL];
    uint32_t prevBeamWord[MAX_BASE_CHANNEL];
    uint32_t prevEwidth[MAX_BASE_CHANNEL];
    //
    //uint32_t prev = false;
};

struct angleData {   // Declare PERSON struct type
    long double azimuth;
    long double elevation;
};



class LightHouseDataProcessing{
  public:
    LightHouseDataProcessing();

    void angleCalc(uint32_t firstBeamTick, uint32_t secondBeamTick, uint32_t channel , struct angleData * retAngle);

  private:
    const uint32_t PERIODS[16] = {959000, 957000,
           953000, 949000,
           947000, 943000,
           941000, 939000,
           937000, 929000,
           919000, 911000,
           907000, 901000,
           893000, 887000};

};



#endif
