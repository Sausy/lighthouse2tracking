# include <stdint.h>
# include <iostream>
//# include <cstdint>
//# include <conio.h>
#include <stdlib.h>
#include <sstream>
#include <string>

#include <fstream>

using namespace std;

//#define MaxIteration 131071
//{0x1D258, 0x17E04, 0x1FF6B, 0x13F67, 0x1B9EE, 0x198D1, 0x178C7, 0x18A55, 0x15777, 0x1D911, 0x15769, 0x1991F, 0x12BD0, 0x1CF73, 0x1365D, 0x197F5, 0x194A0, 0x1B279, 0x13A34, 0x1AE41, 0x180D4, 0x17891, 0x12E64, 0x17C72, 0x19C6D, 0x13F32, 0x1AE14, 0x14E76, 0x13C97, 0x130CB, 0x13750, 0x1CB8D};
static uint32_t const polyPool[32] = {
  #include "polyLut.bin"
};
#define LFSR_SIZE 17
#define pwrtwo(x) (1<<(x))
#define LFSR_MAX_ITERATION ((pwrtwo(LFSR_SIZE))-1)


//#define cntStringMacro(x) ("\""(x)"\"")
//#define genVar(x) ((preString) (cntStringMacro(x)) (postString))
#define STR2_(x) #x
#define STR1_(x) STR2_(x)


#define genName(num) \
   "LUT/preCalcPoly_" STR1_(num) ".bin"

//#define testInclude(x) #include #x

#define fileGen0 {genName(0)},{genName(1)},{genName(2)},{genName(3)}
#define fileGen1 {genName(4)},{genName(5)},{genName(6)},{genName(7)}
#define fileGen2 {genName(8)},{genName(9)},{genName(10)},{genName(11)}
#define fileGen3 {genName(12)},{genName(13)},{genName(14)},{genName(15)}
#define fileGen4 {genName(16)},{genName(17)},{genName(18)},{genName(19)}
#define fileGen5 {genName(20)},{genName(21)},{genName(22)},{genName(23)}
#define fileGen6 {genName(24)},{genName(25)},{genName(26)},{genName(27)}
#define fileGen7 {genName(28)},{genName(29)},{genName(30)},{genName(31)}


#define fileGen fileGen0,fileGen1,fileGen2,fileGen3,fileGen4,fileGen5,fileGen6,fileGen7


static std::string const foo[35] = {
	fileGen
};

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

/*
static uint32_t const polyPool[32] = {
  #include "polyLut.bin"
};*/


int main(int argc, char* argv[]){
  printf("Test Out Multifile Read in ... preCalcPoly_..\n");

  for (size_t i = 0; i < 35; i++) {
    //printf("%s\n", foo[i]);
    cout << readInData[0][i] << " | ";
    cout << readInData[1][i] << "\n";
  }


  return 0;
}
