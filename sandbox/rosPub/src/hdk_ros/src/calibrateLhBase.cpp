#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

#include <iostream>
#include <iomanip>
#include <stdexcept>
#include <vector>
#include <math.h>

#include <unistd.h>


#include <calibrateLhBase.hpp>


calibration::calibration(uint8_t dataIdent_0_, uint8_t dataIdent_1_){
  dataIdent_0 = dataIdent_0_;
  dataIdent_1 = dataIdent_1_;

  //Initi Size of Matrix A and Y
  //A.resize(VECSIZE, std::vector<double>(TRANSFORMMATRIX_SIZE+1, 0));
  A.resize(MAX_RINGBUFFER_SIZE, std::vector<double>(k_features+1, 0));
  Y.resize(MAX_RINGBUFFER_SIZE, std::vector<double>(k_features, 0));

  m.printMatrix(A);
  m.printMatrix(Y);

  for(std::size_t i = 0; i < A.size(); i++) {
    A[i][0] = 1;
  }



  ringBufferCnt = 0;
  waitCntPush = 0;


  //cameraCorelation();
}

void calibration::cameraCoefficient(){
}




//TODO: gather more samples for each buffer
//to prevent an outlier is taken for x_bufffer and Y_buffer
void calibration::pushData(double azimuth, double elevation, uint8_t dataIdent, uint8_t SensorID){

  if(SensorID >= MAX_SENSORS){
    printf("\n[Sensor Num: %u]\n", SensorID);
    fflush(stdout);
    throw std::runtime_error("There was a SensorID higher than the hardcoded max ");
  }
  //TODO:
  //don't use this ugly workaround to delay till proper data comes in
  if(waitCntPush < 100){
    waitCntPush++;
    return;
  }

  double ray[VECSIZE] = {0};
  azimuthToPlaneProjection(azimuth,elevation,ray);

  //Match the data to the coresponding identifier
  //printf("\nRay [%u/%u]%f,%f,%f,%f [%f/%f]",SensorID,dataIdent,ray[0],ray[1],ray[2],ray[3],azimuth*180.0/M_PI,elevation*180.0/M_PI);
  //fflush(stdout);

  if(dataIdent == dataIdent_0){
    //printf("\nRAY_X [%u/%u]%f,%f,%f,%f [%f/%f]",SensorID,dataIdent,ray[0],ray[1],ray[2],ray[3],azimuth*180.0/M_PI,elevation*180.0/M_PI);
    pushMatrix(ray, &sensorHistory_X[SensorID], &X_buffer[SensorID][0]);

  }else if(dataIdent == dataIdent_1){
    pushMatrix(ray, &sensorHistory_Y[SensorID], &Y_buffer[SensorID][0]);
  }

  if(checkAmountData() >= TRANSFORMMATRIX_SIZE){

    printf("\n===========================");
    //fflush(stdout);

    printf("\n========CALIBRATE==========");
    printf("\n=====BASE CORELATION=======");
    printf("\n===========================");
    //cut away the z value of the Array because it's always the same
    printf("\nSize %d/%d", A.size(), A[0].size());
    A[0].resize(k_features);
    //A.resize(MAX_RINGBUFFER_SIZE, std::vector<double>(k_features));
    printf("\nSize %d/%d", A.size(), A[0].size());
    Y[0].resize(k_features-1);
    //Y.resize(MAX_RINGBUFFER_SIZE, std::vector<double>(k_features-1));

    printf("\n\nMatrix A\n");
    m.printMatrix(A);
    printf("\n\nMatrix Y\n");
    m.printMatrix(Y);
    fflush(stdout);

    cameraCorelation();

  }
}

void calibration::cameraCorelation(){


  //double A[TRANSFORMMATRIX_SIZE+1][VECSIZE] = {0};
  //double Y[TRANSFORMMATRIX_SIZE][VECSIZE] = {0};

  //T = A^+ * Y  ... where A^+ means the pseudo inverse
  //A = [[1,1,...], X]  ... the A matrix is the X matrix with a one column added
  printf("\nSize m:%u/n:%u", A.size(), A[0].size());


  //fflush(stdout);

  std::vector<std::vector<double>> Y_(m.getTranspose(Y));
  std::vector<std::vector<double>> A_T(m.getTranspose(A));

  std::cout<<"\n\nDot\n";
  m.printMatrix(m.dotProduct(A_T,A));

  std::cout<<"\n\nMain\n";
  m.printMatrix(m.dotProduct(m.dotProduct(m.getInverse(m.dotProduct(A_T,A)),A_T),Y));

  /*
  1.69786  1.50049 -0.116669
         0        0        0
         0        0        0
  -0.844129 0.0211099 0.883331

  -99.3964 -39.5474   69.875
       0        0        0
       0        0        0
-105.663 -42.0315  74.3125
  */

/*
  std::cout<<"\n\nMATRIX Y\n";
  //fflush(stdout);
  m.printMatrix(Y);
  //fflush(stdout);

  //std::vector<std::vector<double>> A_T(A[0].size(), std::vector<double> (A.size()));


  std::vector<std::vector<double>> A_SYM(VECSIZE, std::vector<double> (VECSIZE));
  std::vector<std::vector<double>> A_INV(VECSIZE, std::vector<double> (VECSIZE));
  std::vector<std::vector<double>> A_DOT(TRANSFORMMATRIX_SIZE, std::vector<double> (TRANSFORMMATRIX_SIZE));

  std::vector<std::vector<double>> T(TRANSFORMMATRIX_SIZE, std::vector<double> (TRANSFORMMATRIX_SIZE));

  //std::cout<<"\n\nMATRIX A\n";
  //m.printMatrix(A);
  //A_T = m.getTranspose(A);
  //std::cout<<"\n\nMATRIX A Trans\n";
  //m.printMatrix(A_T);
  A_SYM = m.dotProduct(A_T,A);
  //std::cout<<"\n\nMATRIX A dotProduct\n";
  //m.printMatrix(A_SYM);
  A_INV = m.getInverse(A_SYM);
  //std::cout<<"\n\nMATRIX A INV\n";
  //m.printMatrix(A_INV);

  A_DOT = m.dotProduct(A_INV,A_T);
  std::cout<<"\n\nMATRIX A DoT\n";
  m.printMatrix(A_DOT);



  T = m.dotProduct(A_DOT,Y);
  std::cout<<"\n\nSolution T\n";
  m.printMatrix(T);

  std::cout<<"\n\nAlternativ T2\n";
  m.printMatrix(m.dotProduct(m.dotProduct(m.getInverse(m.dotProduct(A_T,A)),A_T),Y));

  std::cout<<"\n\nAlternativ T\n";
  m.printMatrix(m.dotProduct(Y,m.dotProduct(A_T,m.getInverse(m.dotProduct(A,A_T)))));
  */


  /*


  */




  //m.calcPseudoInversMatrix(matrix);


  //double A_pseudo
  //m.calcPseudoInversMatrix(matrix);

}


void calibration::vecCros(double *A_, double *B, double *retVec){
}
void calibration::matrixDotVector(double A_[][4], double *B, uint8_t m, double *retMatrix){
}
void calibration::matrixDotMatrix(double A_[][4], double B[][4], uint8_t m, uint8_t n, double retMatrix[][3]){
}


void calibration::testBench_main(){

  //for (size_t i = 0; i < 6; i++) {
  //pushData(-1.0/2.0 * M_PI, 0.0, dataIdent_0,  0);
  //pushData(-1.0/2.0 * M_PI, 0.0, dataIdent_1,  0);

  pushData(-45 * M_PI/180.0, 0.0, dataIdent_0,  0);
  //}

}





void calibration::azimuthToPlaneProjection(double azimuth, double elevation, double *ray){
  double z = -1.0; //distance to plane

  double x = z/tan(azimuth);
  double r1 = sqrt(pow(x,2)+pow(z,2));
  double y = r1 * tan(elevation);

  ray[0] = x;
  ray[1] = y;
  ray[2] = z;
  ray[3] = 1;

}

uint8_t calibration::checkAmountData(){
  uint8_t ret = 0;
  for (uint8_t i = 0; i < MAX_SENSORS; i++) {

    //printf("\nhist_x %d/%d ", sensorHistory_X[i], sensorHistory_Y[i]);
    //if(sensorHistory_X[i] == true){

    //}
    if ((sensorHistory_X[i] == true) && (sensorHistory_Y[i] == true)) {
      //printf("\n++++++++");
      //printf("\nsensorHistory wAS true %d", ret);

      //usleep(1000000);
      //printf("\nHist 1");
      //fflush(stdout);

      for (uint8_t j = 0; j < k_features; j++) {
        if(ret < A.size()){
          A.at(ret).at(j+1) = X_buffer[i][j];
          Y.at(ret).at(j) =  Y_buffer[i][j];
        }else{
          return ret;
        }

      }
      //printf("\nret %u",ret);
      //fflush(stdout);
      ret++;
    }
  }
  return ret;
}

void calibration::pushMatrix(double *ray, bool *history, double *ret){
  uint8_t similarityCnt = 0;

  double sqrtRoot = 0.0;

  if(*history == false){
    //printf("\nRAY_ [%u/%u]%f,%f,%f,%f [%f/%f]",SensorID,dataIdent,ray[0],ray[1],ray[2],ray[3],azimuth*180.0/M_PI,elevation*180.0/M_PI);

    for (size_t i = 0; i < VECSIZE; i++){
      //check if last and current vaules are close enough
      //printf("\nDiv %f", abs(ret[i] - ray[i]));
      if(abs(ret[i] - ray[i]) < 0.05){

        similarityCnt++;
      }
      sqrtRoot += pow(ray[i],2);

    }
    sqrtRoot = sqrtRoot - 1;
    //check if the vector has the norm length of one
    if(sqrtRoot > 2.0){
      similarityCnt = 0;
    }
    //if we found two consequtive values for a Sensor
    //we store it permanently
    //printf("\nsimilarityCnt %d", similarityCnt);
    if(similarityCnt >= VECSIZE-1){
      *history = true;
    }

    for (size_t i = 0; i < VECSIZE; i++) {
      ret[i] = ray[i];
    }
  }

}
