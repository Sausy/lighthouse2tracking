# include <stdint.h>
# include <iostream>
//# include <cstdint>
//# include <conio.h>
#include <stdlib.h>
#include <sstream>
#include <string>

#include <fstream>

using namespace std;


int main(int argc, char* argv[]){
 // printf("Test Out Multifile Read in ... preCalcPoly_..\n");
  int cntMAX = 8;
  int j= 0;
  for (size_t i = 0; i < cntMAX*4; i++) {
    //j = i*4;
    printf("{#include preCalcPoly_%d.bin}\n", i);
    if(i%4 == 0){
	printf("\n");
    }
    //cout << foo[i] << "\n";
  }

  printf("\n");
  for (size_t i = 0; i < cntMAX; i++) {
    j = i*4;
    printf("#define fileGen%d {genName(%d)},{genName(%d)},{genName(%d)},{genName(%d)}\n", i, j, j+1, j+2,j+3);
    //cout << foo[i] << "\n";
  }
  printf("\n--\n#define fileGen ");
  for (size_t i = 0; i < cntMAX; i++) {
    j = i*4;
    printf("fileGen%d,", i);
    //cout << foo[i] << "\n";
  }
  int tempVar = cntMAX*4 + 3;
  printf("\n--\nstatic std::string const readInData[%d] = { \n\tfileGen\n};", tempVar);


  return 0;
}
