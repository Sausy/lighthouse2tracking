#!/usr/bin/env python3

import numpy as np
import csv

from os import listdir
from os.path import isfile, join


class preprocess:
    def __init__(self,path):
        onlyfiles = [f for f in listdir(path) if isfile(join(path, f))]
        print("\n\nAvailabe Files\n==============")
        print(onlyfiles)
        #data = pd.read_csv('a.csv',header=0) #names=featureList
        #data = data.drop(0, axis=0)
        self.firstLine = -1 #row counter ... index of first row with values
        self.MaxColumn = -1

    def select(self):
        self.path = input('InputFileName: \n')

    def cutOutComment(self,identify=";"):
        print("needs to be done")

    def preprocessDSViewer(self):
        print("\n\npreprocessDSViewer\n==============")
        #cutOutComment(identify=";")

        print(self.path)

        self.firstLine = -1
        self.MaxColumn = -1

        f= open(self.path,"r")
        outFile = open('out.csv',"w+")

        f_line = f.readlines()
        #for rowData in f_line:
        for num, rowData in enumerate(f_line, start=0):
            if self.firstLine >= 0:
                if rowData.count(',') != self.MaxColumn:
                    rowData = rowData.replace(',', '.', 1)
                    #print(rowData)


            if rowData.find('Time(s),') != -1 and self.firstLine == -1: #search for the first Line that indicates the Data column
                self.firstLine = num + 1
                print(rowData)
                self.MaxColumn = rowData.count(',')


            outFile.write(rowData)


        outFile.close()
        f.close()



def main():
    iData = preprocess(path="./")
    iData.select()
    iData.preprocessDSViewer()


if __name__ == "__main__":
    main()
