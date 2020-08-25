#!/usr/bin/env python3

import numpy as np
import pandas as pd

import matplotlib.pyplot as plt


class InputData:
    def __init__(self,path='out.csv',initRow=4):
        #self.data = pd.read_csv(path,header=4) #names=featureList
        self.data = pd.read_csv('test.csv',header=4) #names=featureList

        print(self.data)

        self.MaxSamples = 512
        #print(path)
        #data = data.drop(0, axis=0)

        #plt.plot(self.data.values[:300,0],self.data.values[:300,2])
        #plt.show()

    def extrapolate(self,sampleRateMHz=100):
        print("\n\nextrapolation of edge times to sample Data\n==============")
        deltaT = sampleRateMHz*(10**6)
        deltaT = 1/deltaT
        currentTime = deltaT

        dataBuffer = np.array([self.data.values[0,:]])

        print(dataBuffer)

        #print(self.data.values.shape[0])

        itcnt = 1
        for i in range(1,self.MaxSamples):
            #print(self.data.values[itcnt])



#            dataBuffer = np.append(dataBuffer,np.array([self.data.values[itcnt,:]]), axis=0)
            #print(dataBuffer)
#            dataBuffer[i,0] = currentTime


            if currentTime > self.data.values[itcnt,0]:
                print("currentTime {} vs {}".format(currentTime, self.data.values[itcnt,0]))
                itcnt = itcnt + 1

                if itcnt >= self.data.values.shape[0]:
                    print("End of file reached")
                    break

                if currentTime > self.data.values[itcnt,0]:
                    print("EERRROOORRR")

            dataBuffer = np.append(dataBuffer,np.array([self.data.values[itcnt,:]]), axis=0)
            print("itcnt {}".format(itcnt))
            print(np.array([self.data.values[itcnt,:]]))
            print(dataBuffer)

            #dataBuffer[i,1:] = self.data.values[itcnt,1:]
            dataBuffer[i,0] = currentTime


            currentTime = currentTime + deltaT




        print(dataBuffer)

        plt.plot(self.data.values[:,0],self.data.values[:,1],self.data.values[:,0],self.data.values[:,2])
        plt.show()

        plt.plot(dataBuffer[:,0],dataBuffer[:,1],dataBuffer[:,0],dataBuffer[:,2])
        plt.show()


def main():
    iData = InputData()
    iData.extrapolate(sampleRateMHz=100)


if __name__ == "__main__":
    main()
