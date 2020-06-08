#ifndef _LH2DATA_H_
#define _LH2DATA_H_


//#include <iostream>
#include <stdlib.h>
#include "protoLighthouse.h"

#define MAX_SENSORS 12
#define MAX_BASE_AMOUNT 33
#define MAX_DELTA_TIME 240000  //10ms * 24MHz 240000 (due to the fact that we should position the lighthouse anyway 1.5meters away)...20ms * 24MHz = 480000  with buffer 25ms * 24MHz = 528000
#define UART_SUBFRAME_SIZE_PERBYTE 3
#define UART_FRAME_SIZE (4*UART_SUBFRAME_SIZE_PERBYTE)

class LIGHTHOUSEDATACONV{
  public:
    LIGHTHOUSEDATACONV();

    int8_t pushUartData(char *data);

    uint32_t timestamp = 0;
    uint32_t beam_word = 0;
    uint32_t offset = 0;
    uint32_t first_word = 0;
    uint8_t sensor = 0;
    uint16_t width = 0;
    bool nPoly_ok = 0;
    uint8_t identity = 0;
    uint8_t channel = 0;
    bool slow_bit = 0;

    uint8_t lut_Poly_id = 0;


    DarkRoomProtobuf_lighthouseMsg msg = DarkRoomProtobuf_lighthouseMsg_init_zero;

  private:
    uint32_t prevSweepTime[MAX_BASE_AMOUNT]= {0};
    uint32_t prevOfset[MAX_BASE_AMOUNT]= {0};
    uint32_t prevBeamWord[MAX_BASE_AMOUNT]= {0};
    uint16_t prevEwidth[MAX_BASE_AMOUNT] = {0};
    //bool wasLast
    //
    //uint32_t prev = false;
    bool init_Done[MAX_BASE_AMOUNT];
};



#endif
