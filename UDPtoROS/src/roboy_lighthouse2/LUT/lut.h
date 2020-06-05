#ifndef _LUT_H_
#define _LUT_H_

static uint32_t const polyPool[32] = {
  #include "polyLut.bin"
};
#define LFSR_SIZE 17
#define pwrtwo(x) (1<<(x))
#define LFSR_MAX_ITERATION ((pwrtwo(LFSR_SIZE))-1)

//#define genVar (#include "preCalcPoly_.bin")

static uint32_t const readInData[32][LFSR_MAX_ITERATION] = {
  #include "preCalcPoly_0"
  #include "preCalcPoly_1"
  #include "preCalcPoly_2"
  #include "preCalcPoly_3"
  #include "preCalcPoly_4"
  #include "preCalcPoly_5"
  #include "preCalcPoly_6"
  #include "preCalcPoly_7"
  #include "preCalcPoly_8"
  #include "preCalcPoly_9"
  #include "preCalcPoly_10"
  #include "preCalcPoly_11"
  #include "preCalcPoly_12"
  #include "preCalcPoly_13"
  #include "preCalcPoly_14"
  #include "preCalcPoly_15"
  #include "preCalcPoly_16"
  #include "preCalcPoly_17"
  #include "preCalcPoly_18"
  #include "preCalcPoly_19"
  #include "preCalcPoly_20"
  #include "preCalcPoly_21"
  #include "preCalcPoly_22"
  #include "preCalcPoly_23"
  #include "preCalcPoly_24"
  #include "preCalcPoly_25"
  #include "preCalcPoly_26"
  #include "preCalcPoly_27"
  #include "preCalcPoly_28"
  #include "preCalcPoly_29"
  #include "preCalcPoly_30"
  #include "preCalcPoly_31"
};

#endif
