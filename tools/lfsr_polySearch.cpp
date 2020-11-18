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



unsigned lfsr(uint32_t start_state, uint32_t  endstate,  uint32_t polynome, uint32_t period_limit)//, ofstream &myfile)
{

  uint32_t lfsr = start_state;
  uint32_t bit;                    /* Must be 16-bit to allow bit<<15 later in the code */
  uint32_t period = 0;
  uint32_t end_state = 0x0001ffff & endstate;

   uint32_t buffer = 0;
   uint32_t bitbuffer = 0;

   buffer = 0x0001ffff & start_state & polynome;
   //printf("bufferPoly: %x \n", buffer);


  do
  {
      //myfile << "0x" << std::hex << lfsr << ",\n";
      buffer = 0x0001ffff & lfsr & polynome;
      bitbuffer = (buffer>>0) & 1u;

      for(int i = 1; i < 17; i++){
         bitbuffer = (bitbuffer ^ (buffer>>i)) & 1u;
         //printf("bitbuffer: %x \n", bitbuffer);
      }
      bit = bitbuffer & 1u; /* & 1u */;
      //printf("bit: %x \n", bit);
      lfsr = (lfsr << 1) | (bit & 1u);
      lfsr = 0x0001ffff & lfsr;
      ++period;


       if(period > period_limit) //maxPolySize-1
         break;
  }
  while (lfsr^end_state);

  return period;
}



/*
static uint32_t const preCalcLut =
{
    0x00001;

};*/

int main(int argc, char* argv[]){

  printf("%d\n", LFSR_MAX_ITERATION);
  uint32_t default_init = 0x00001;
  //uint32_t data[4] = {0x1fe72,0x0bd25};
  //uint32_t data[4] = {0x1,0x19af6,0x1,0x1f97d};//sensor 0 second
  uint32_t data[4] = {0x1,0x0ea18,0x1,0x11a06};

  //uint32_t data[4] = {0x1,0x019ed,0x1,0x01207};
  //uint32_t data[4] = {0x1,0x1f018,0x1,0x1658b};


  //uint32_t t1 = 0x0C552F;
  //uint32_t t2 = 0x0C5808;
  std::stringstream ss;
  std::string s1, s2, s3;
  uint16_t polySearchSize = 32;

  switch (argc) {
    case 3:
      s1 = argv[1];
      s2 = argv[2];
      //printf("\nInitPoly %s, EndState %s\n", argv[1], argv[2]);

      data[0] = stoi(s1, 0, 16);
      data[1] = stoi(s2, 0, 16);
      break;
    case 4:
      s1 = argv[1];
      s2 = argv[2];

      //printf("\nInitPoly %s, EndState %s\n", argv[1], argv[2]);

      data[0] = stoi(s1, 0, 16);
      data[1] = stoi(s2, 0, 16);
      polySearchSize = stoi(argv[3], 0, 10) + 1;
    default:
      break;

  }


  printf("Poly: %x | %x | %x\n", polyPool[31], data[0], data[1]);



  //uint32_t period = 0;
  uint32_t period[polySearchSize];
  uint32_t period2[polySearchSize];
  uint32_t nPoly = 0;



  for (uint16_t i = 0; i < polySearchSize; i++) {

    period[i] = lfsr(data[0], data[1], polyPool[i], LFSR_MAX_ITERATION);
    period2[i] = lfsr(data[2], data[3], polyPool[i], LFSR_MAX_ITERATION);

    if(period[i] < LFSR_MAX_ITERATION){
      printf("[FOUND Div] period: %u  \n===Poly %x [%u]\n", period[i], polyPool[i], i);
      nPoly = i;
      //break;
    }
  }

  int currentDiff = 0;
  int minDiff = 100000;
  int minIdent = 0;
  int minIdent2 = 0;


  for (uint16_t i = 0; i < polySearchSize; i++) {
    //for (uint16_t j = 0; j < polySearchSize; j++) {
      //currentDiff = period2[j] - period[i];
      currentDiff = period2[i] - period[i];
      if( currentDiff < 0)
        currentDiff = currentDiff * (-1);

      if(currentDiff < 6000)
        printf("\ns-------- Diff %d ", i);
        //printf("\ns-------- Diff %d | %d", i, j);

      if( currentDiff < minDiff ){
        minDiff = currentDiff;
        //minIdent2 =j;
        minIdent2 = i;
        minIdent = i;
      }
    //}

  }
  printf("\n\n--------\nMin Diff %d | %d\n", minIdent, minIdent2);
  printf("%d",minDiff);
  int foo1 = period[5] - period2[5];
  int foo2 = period[4] - period2[4];
  printf("\n [4]%d | [5]%d", foo2, foo1);


  for (uint16_t i = 0; i < polySearchSize; i++) {
    for (uint16_t j = 0; j < polySearchSize; j++) {
      currentDiff = period2[j] - period[i];
      if( currentDiff < 0)
        currentDiff = currentDiff * (-1);

      if(currentDiff < 400)
        printf("\ns-------- Diff %d | %d", i, j);

      if( currentDiff < minDiff ){
        minDiff = currentDiff;
        minIdent2 = j;
        minIdent = i;
      }
    }

  }

  printf("\n\n--------\nMin Diff %d | %d\n", minIdent, minIdent2);
  printf("%d",minDiff);
  foo1 = period[5] - period2[5];
  foo2 = period[4] - period2[4];
  printf("\n [4]%d | [5]%d", foo2, foo1);



  printf("\n");
  return 0;
}
