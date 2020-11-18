#pragma once

#include <matrix.hpp>

#define VECSIZE 4
#define MAX_SENSORS 32
#define MAX_RINGBUFFER_SIZE 4
#define TRANSFORMMATRIX_SIZE 4

static const int k_features = 3;
static const int K_features = k_features + 1;

class calibration
{
  public:
    //dataIdent_0 refers to channel of the LighthouseBase 0
    //dataIdent_1 refers to channel of the LighthouseBase 1
    //this is needed to match the data in the function "pushData"
    uint8_t dataIdent_0;
    uint8_t dataIdent_1;
    calibration(uint8_t dataIdent_0_, uint8_t dataIdent_1_);
    //dataIdent to match the data to dataIdent_0 or dataIdent_1
    void pushData(double azimuth, double elevation, uint8_t dataIdent, uint8_t SensorID);

    void cameraCoefficient();
    void cameraCorelation();

    void testBench_main();

    void restartCalibration();

    matrixClass m;


  private:
    void transform2CameraPlane();
    void vecCros(double *A_, double *B, double *retVec);
    void matrixDotVector(double A_[][4], double *B, uint8_t m, double *retMatrix);
    void matrixDotMatrix(double A_[][4], double B[][4], uint8_t m, uint8_t n, double retMatrix[][3]);



    void azimuthToPlaneProjection(double azimuth, double elevation, double *ray);
    uint8_t checkAmountData();
    void pushMatrix(double *ray,bool *history, double *ret);

    //const uint16_t amountOfDataPoints = 3;
    uint16_t ringBufferCnt;
    bool sensorHistory_X[MAX_SENSORS] = {0};
    bool sensorHistory_Y[MAX_SENSORS] = {0};
    double X_buffer[MAX_SENSORS][VECSIZE] = {0};
    double Y_buffer[MAX_SENSORS][VECSIZE] = {0};

    //double A[TRANSFORMMATRIX_SIZE+1][VECSIZE] = {0};
    //double Y[TRANSFORMMATRIX_SIZE][VECSIZE] = {0};
    //the following buffer is needed due to segmentation fuck ups no clue why
    //double Avec_buffer[VECSIZE][TRANSFORMMATRIX_SIZE+1] = {0};
    //the following buffer is needed due to segmentation fuck ups no clue why
    //double Yvec_buffer[VECSIZE][TRANSFORMMATRIX_SIZE] = {0};

    std::vector<std::vector<double>> A;// = std::vector<double>(TRANSFORMMATRIX_SIZE+1, std::vector<double> (VECSIZE));
    std::vector<std::vector<double>> Y; //= std::vector<double>(VECSIZE, std::vector<double>(TRANSFORMMATRIX_SIZE, 0));


    uint16_t waitCntPush;
};
