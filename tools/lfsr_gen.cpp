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



unsigned lfsr(uint32_t start_state, uint32_t  endstate,  uint32_t polynome, uint32_t period_limit, ofstream &myfile)
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
      myfile << "0x" << std::hex << lfsr << ",\n";
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
  uint32_t data[2] = {0x1fe72,0x0bd25};
  uint32_t t1 = 0x0C552F;
  uint32_t t2 = 0x0C5808;
  std::stringstream ss;

  if(argc == 3){
    std::string s1 = argv[1];
    std::string s2 = argv[2];
    //printf("\nInitPoly %s, EndState %s\n", argv[1], argv[2]);

    data[0] = stoi(s1, 0, 16);
    data[1] = stoi(s2, 0, 16);

  }



  //printf("Poly: %x | %x | %x\n", polyPool[31], data[0], data[1]);

  uint16_t polySearchSize = 32;

  uint32_t period = 0;
  uint32_t period1 = 0;
  uint32_t nPoly = 0;



  for (uint16_t i = 0; i < polySearchSize; i++) {

    std::stringstream ss;
    ss << "preCalcPoly_" << std::dec << i;
    ofstream myfile;
    myfile.open(ss.str());

    period = lfsr(default_init, default_init, polyPool[i], LFSR_MAX_ITERATION, myfile);
    myfile.close();
    /*if(period < LFSR_MAX_ITERATION){
      printf("[FOUND Div] period: %u  \n===Poly %x [%u]\n", period, polyPool[i], i);
      nPoly = i;
      //break;
    }*/
  }





  return 0;
}
