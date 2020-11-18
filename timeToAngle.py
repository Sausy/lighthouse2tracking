#!/usr/bin/env python3

import math
import matplotlib as mpl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d import proj3d

import re

import sys
import struct




f_perChannel = [50.0521, 50.1567, 50.3673, 50.5796, 50.6864, 50.9014, 51.0096, 51.1182, 51.2273, 51.6685, 52.2307, 52.6894, 52.9217, 53.2741, 53.7514, 54.1150]

PERIODS = [959000, 957000,
           953000, 949000,
           947000, 943000,
           941000, 939000,
           937000, 929000,
           919000, 911000,
           907000, 901000,
           893000, 887000]

poly = [0x1D258,
        0x17E04,
        0x1FF6B,
        0x13F67,
        0x1B9EE,
        0x198D1,
        0x178C7,
        0x18A55,
        0x15777,
        0x1D911,
        0x15769,
        0x1991F,
        0x12BD0,
        0x1CF73,
        0x1365D,
        0x197F5,
        0x194A0,
        0x1B279,
        0x13A34,
        0x1AE41,
        0x180D4,
        0x17891,
        0x12E64,
        0x17C72,
        0x19C6D,
        0x13F32,
        0x1AE14,
        0x14E76,
        0x13C97,
        0x130CB,
        0x13750,
        0x1CB8D]

def lfsr_tickResolv(nPoly,endpoint_value):
    #Todo implement the polynome iterator here

    #poly[]
    start_state = 0x00001
    period_limit = 131071
    polynome = poly[nPoly]

    #print("\n[{}] Polynom {:x} | ENDPOINT: {:x}".format(nPoly,polynome,endpoint_value))

    lfsr = start_state
    bit = 0                  # Must be 16-bit to allow bit<<15 later in the code
    period = 0
    end_state = 0x0001ffff & endpoint_value

    buffer = 0
    bitbuffer = 0

    buffer = 0x0001ffff & start_state & polynome
    #buffer = buffer
    #printf("bufferPoly: %x \n", buffer)

    while True:
        #print("exor {}".format(lfsr^end_state))
        if (lfsr^end_state) == 0:
            break

        buffer = 0x0001ffff & lfsr
        buffer = buffer & polynome
        bitbuffer = (buffer>>0) & 0x1

        for i in range(1,17):
            bitbuffer = (bitbuffer ^ (buffer>>i)) & 0x1

        bit = bitbuffer & 0x1 # & 0x1
        lfsr = (lfsr << 1) | (bit & 0x1)
        lfsr = 0x0001ffff & lfsr
        period = period + 1

        if period > period_limit: #maxPolySize-1
            break

    #print("period {}".format(period))
    return period


#The default vector in FRAME0 only needs rotation
#No Translation
def baseRotation(r_vec, phi: float):

    #rotation is counter clockwise
    phi = -phi

    rotMatrix_y =      [[np.cos(phi), 0, np.sin(phi), 0],
                        [0, 1, 0, 0],
                        [-np.sin(phi), 0, np.cos(phi), 0],
                        [0, 0, 0, 1]]


    return [rotMatrix_y, rotMatrix_y]

#The default vector Tranformation
#transformer for BASE SWEEP 1
def coord_transform_1(d, phi: float, rotAngle_rad, isNeg=False):
    #TODO FOV into this shi
    trans_x = 0#-1 #* np.sin(rotAngle_rad) * d
    trans_y = np.sin(rotAngle_rad) * d
    trans_z = np.cos(rotAngle_rad) * d

    '''
    rotation is counter clockwise
    '''
    phi = -phi

    if isNeg == True:
        trans_y = -1 * trans_y
        trans_z = -1 * trans_z


    TransposMatrix =   [[1, 0, 0, trans_x],
                        [0, 1, 0 ,trans_y],
                        [0, 0, 1 ,trans_z],
                        [0, 0, 0, 1]]

    rotMatrix_y =      [[np.cos(phi), 0, np.sin(phi), 0],
                        [0, 1, 0, 0],
                        [-np.sin(phi), 0, np.cos(phi), 0],
                        [0, 0, 0, 1]]

    T = np.dot(TransposMatrix,rotMatrix_y)
    T_inv = np.dot(rotMatrix_y, TransposMatrix)

    return [T, T_inv]

#The default vector Tranformation
#transformer for BASE SWEEP 2
def coord_transform_2(d, phi: float, rotAngle_rad, isNeg=False):
    #rotation is counter clockwise
    phi = -phi

    #TODO FOV into this shi
    trans_x = 0
    trans_y = -np.sin(rotAngle_rad) * d
    trans_z = np.cos(rotAngle_rad) * d

    if isNeg == True:
        trans_y = -1 * trans_y
        trans_z = -1 * trans_z


    TransposMatrix =   [[1, 0, 0, trans_x],
                        [0, 1, 0 ,trans_y],
                        [0, 0, 1 ,trans_z],
                        [0, 0, 0, 1]]

    rotMatrix_y =      [[np.cos(phi), 0, np.sin(phi), 0],
                        [0, 1, 0, 0],
                        [-np.sin(phi), 0, np.cos(phi), 0],
                        [0, 0, 0, 1]]

    T = np.dot(TransposMatrix,rotMatrix_y)
    T_inv = np.dot(rotMatrix_y, TransposMatrix)

    return [T, T_inv]


def plane_transformation(phi, default_vec,sweep=0):
    #from FRAME 0
    #=== rotate the default point (-1, 0, 0)
    [T, T_inv] = baseRotation(1, phi)
    r_0 = [0,0,0,1]
    r_0_new = r_0
    r_0_vec = np.dot(T_inv,default_vec)
    #r['frame0']['zero_new'] = r['frame0']['zero']
    #r['frame0']['vec_new'] = np.dot(T_inv,r['frame0']['vec'])

    #from FRAME 1
    #=== rotate the default point (-1, 0, 0)
    if sweep == 0:
        [T, T_inv] = coord_transform_1(1, phi, rotAngle_rad)
    else:
        [T, T_inv] = coord_transform_2(1, phi, rotAngle_rad)
    r_1 = [0,0,0,1]
    r_1_new = np.dot(T_inv,r_1)
    r_1_vec = np.dot(T_inv,default_vec)
    #r['trans01']['zero'] = np.dot(T_inv,r['frame1']['zero'])
    #r['trans01']['vec'] = np.dot(T_inv,r['frame1']['vec'])


    #from FRAME 2
    #=== rotate the default point (-1, 0, 0)
    if sweep == 0:
        [T, T_inv] = coord_transform_1(1, phi, rotAngle_rad, True)
    else:
        [T, T_inv] = coord_transform_2(1, phi, rotAngle_rad, True)

    r_2 = [0,0,0,1]
    r_2_new = np.dot(T_inv,r_2)
    r_2_vec = np.dot(T_inv,default_vec)
    #r['trans02']['zero'] = np.dot(T_inv,r['frame1']['zero'])
    #r['trans02']['vec'] = np.dot(T_inv,r['frame1']['vec'])

    #Return all 4 points of the new plain
    return [r_0_vec, r_1_new,r_1_vec,r_2_new,r_2_vec]


def ray_calculation(first_phi, secon_phi):

    rZero = [0, 0, 0, 1]

    r_ = plane_transformation(first_phi, [-1, 0, 0, 1], sweep=0)

    if Allow_Plane_Plot :
        x = np.array([[0.0,r_[0][0]],[r_[1][0],r_[2][0]],[r_[3][0],r_[4][0]]])
        y = np.array([[0.0,r_[0][1]],[r_[1][1],r_[2][1]],[r_[3][1],r_[4][1]]])
        z = np.array([[0.0,r_[0][2]],[r_[1][2],r_[2][2]],[r_[3][2],r_[4][2]]])

        ax.plot_surface(x,z,y, color='b')

    p0 = [0,0,0]
    p1 = r_[2][0:3]
    p2 = r_[3][0:3]
    p3 = r_[4][0:3]

    r_ = plane_transformation(secon_phi, [-1, 0, 0, 1], sweep=1)

    if Allow_Plane_Plot :
        x = np.array([[0.0,r_[0][0]],[r_[1][0],r_[2][0]],[r_[3][0],r_[4][0]]])
        y = np.array([[0.0,r_[0][1]],[r_[1][1],r_[2][1]],[r_[3][1],r_[4][1]]])
        z = np.array([[0.0,r_[0][2]],[r_[1][2],r_[2][2]],[r_[3][2],r_[4][2]]])

        ax.plot_surface(x,z,y, color='r')

    p12 = r_[2][0:3]
    p22 = r_[3][0:3]
    p32 = r_[4][0:3]

    #The following stuff is proberly described in the documentation
    #basicly its the default formular for plane intersection

    #First we get a "normale" for eache vector
    n1 = np.cross((p2 - p1),(p3 - p1))
    n2 = np.cross((p22 - p12),(p32 - p12))
    #now according to the equation
    #(a0-a1)x + (b0-b1)y + (c0-c1)z + d = 0
    #where d is always zero in our case because
    #(0,0,0) is always a member of each plane
    n = n1 - n2

    #now we assume that due to hardware limitation
    #the only valid z > 1
    #hence it can be assumed
    # z = 1

    # TODO: FIGURE OUT WHY DAFUQ IT HAS TO -1
    z_assumed = -1

    #due to the corelation between the two intersecting planes
    #(b0 - b1) has to be 0
    #solve the equation (a0-a1)x  + (c0-c1)z  = 0
    #for x
    x = -(z_assumed * n[2])/n[0]
    # instert this equation into one of the plane equations
    # can eather be plane 1 or plane 2
    #a0*x + b0*y + c0*z = 0
    y = -(n1[0]*x + n1[2]*z_assumed)/n1[1]

    ray =  [[0, x],
            [0, y],
            [0, z_assumed]]

    return ray

def vec2azimuth(vec):
    norm = np.sqrt(vec[0][1]**2 + vec[1][1]**2 + vec[2][1]**2)
    x = vec[0][1]/norm
    y = vec[1][1]/norm
    z = vec[2][1]/norm

    print("Vector = [{},{},{}]".format(vec[0][1],vec[1][1],vec[2][1]))
    print("NormVector = [{},{},{}]".format(x,y,z))
    #because we normed the vector
    #r=1
    #r = |vec|_{2} ....euclidische norm
    #np.sqrt(x**2 + y**2 + z**2) = 1
    r=1

    #in this case the azimuth
    #describes the angle betwenn x and -z
    #azimuth = np.arctan(y/x)
    #elevation = np.arctan(z/r)
    if x > 0:
        azimuth = np.arctan(-z/x)
    else:
        azimuth =  np.pi + np.arctan(-z/x)

    #in this case the elevation
    #describes the angle betwenn r_{x,-z} and y
    elevation = np.arctan(y/np.sqrt(x**2 + z**2))

    return [azimuth,elevation]


def pollUsbInterface(src):
    lastMeasurements = [0,] * 16
    reading = src.read(12)
    prevSweepTime = 0

    while(len(reading) == 12):
        timestamp = struct.unpack("<I", reading[9:] + b'\x00')[0]
        beam_word = struct.unpack("<I", reading[6:9] + b'\x00')[0]
        offset = struct.unpack("<I", reading[3:6] + b'\x00')[0]
        first_word = struct.unpack("<I", reading[:3] + b'\x00')[0]

        sensor = first_word & 0x03
        width = (first_word >> 8) & 0xffff

        nPoly_ok = ((first_word >> 7) & 0x01) == 0
        identity = (first_word >> 2) & 0x1f
        channel = identity >> 1
        slow_bit = identity & 1

        additional_id = ((offset >> 18) & 0xff) - 1
        real_id = (additional_id * 4) + sensor

        # Sync frame, ignore it
        if offset == 0xffffff:
            reading = src.read(12)
            continue

        # Detect new sweep
        if ((timestamp - prevSweepTime) & 0xffffff) > 10000:
            print("[Info] new Sweep")
        prevSweepTime = timestamp

        offset = offset & 0x01ffff
        if (nPoly_ok):
            print("Sensor: {}  TS:{:06x}  Width:{:4x}  Chan:{:2}({})  nPoly:{}  BeamWord:{:05x}\t".format(sensor, timestamp, width, channel + 1,
                slow_bit, identity, beam_word), end='')
            print("\noffset: {:6x} | additional_id {} ".format(offset, real_id))
        #else:
        #    print("Sensor: {}  TS:{:06x}  Width:{:4x}  Chan: None  nPoly:{} BeamWord:{:05x}\t".format(sensor, timestamp, width, identity,beam_word),
        #        end='')

        if offset != 0:
            if offset > (lastMeasurements[channel]+10000):
                firstBeam = ((lastMeasurements[channel] * 8.0) / PERIODS[identity >> 1]) * 2 * math.pi
                secondBeam = ((offset * 8.0) / PERIODS[identity >> 1]) * 2 * math.pi

                #azimuth, elevation = calculateAE(firstBeam, secondBeam)
                print("Sensor: {} | Chan:{:2}({}) | angleXY: {:3.3f}°, {:3.3f}°".format(real_id, channel + 1, slow_bit, math.degrees(azimuth), math.degrees(elevation)), end='')

            lastMeasurements[channel] = offset

        if (nPoly_ok):
            print()

        reading = src.read(12)



def openUsbInterface():
    if sys.argv[1].startswith("/dev/"):
        src = serial.Serial(sys.argv[1], 4*115200)
    else:
        src = open(sys.argv[1], "rb")

    print("Waiting for sync ...")
    sync = [b'\xff', b'\xff', b'\xff', b'\xff', b'\xff', b'\xff', b'\xff', b'\xff', b'\xff', b'\xff', b'\xff', b'\xff']
    syncBuffer = [b'\x00'] * len(sync)
    while sync != syncBuffer:
        b = src.read(1)
        if len(b) < 1:
            sys.exit(1)
        syncBuffer.append(b)
        syncBuffer = syncBuffer[1:]

    print("Found sync!")

    return src

class dataTypes(object):
    """docstring for dataTypes."""

    def __init__(self,id):
        self.id = id
        self.TS = []
        self.W = []
        self.CH = []
        self.SL = []
        self.nP = []
        self.BW = []
        self.OS = []


def openDataLog(path, maxSensors):
    regex = re.compile('ID:.,')
    f = open(path, "r")

    #Cpp convert ... make a data struct called data
    d = []
    for i in range(0,maxSensors):
        d.append(dataTypes(id=i))


    #push each log row to the coresponding struct
    for row in f:
        if re.match(regex, row):
            tmp_string = row.replace('\n','')
            tmp_string = tmp_string.replace('\t','')
            data = tmp_string.split(',')

            id = int(data[0].replace('ID:',''),base=10)
            TS = int(data[1].replace('TS:',''), base=10)
            W = int(data[2].replace('W:',''), base=10)
            foo  = data[3].replace('W:','')
            CH = int(foo.replace('CH:',''), base=10)
            SL = int(data[4].replace('SL:',''), base=10)
            nP = int(data[5].replace('nP:',''), base=10)
            BW = int(data[6].replace('BW:',''), base=10)
            OS = int(data[7].replace('OS:',''), base=10)

            if id < maxSensors:
                d[id].TS.append(TS)
                d[id].W.append(W)
                d[id].CH.append(CH)
                d[id].SL.append(SL)
                d[id].nP.append(nP)
                d[id].BW.append(BW)
                d[id].OS.append(BW)



    f.close()

    return d


if __name__ == "__main__":
    '''
        if port specified
    '''
    '''
    if len(sys.argv) < 2:
        print("Usage: {} <input.bin or /dev/tty...>".format(sys.argv[0]))
        #exit(1)
    else:
        src = openUsbInterface()
        pollUsbInterface(src)
    '''
    '''
    open Dump
    '''
    MAX_SENSORS = 8
    if len(sys.argv) < 2:
        print("Usage: {} <path to dump.txt>".format(sys.argv[0]))
        exit()
    else:
        dataRaw = openDataLog(sys.argv[1],MAX_SENSORS)

    '''
        PLOT STUFF
    '''
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    ax.set_xlabel('X')
    ax.set_ylabel('Z')
    ax.set_zlabel('Y')
    ax.set_ylim(0,1.5)
    ax.set_zlim(0,1.5)

    '''
        CONFIG STUFF
    '''
    #Just vor debuging to verify the planes
    Allow_Plane_Plot = False

    '''
        Read In Data
    '''
    ray =  [[0, 1],
            [0, 0],
            [0, 0]]

    average_tick0 = [0,0,0,0,0,0,0,0]
    average_tick1 = [0,0,0,0,0,0,0,0]
    average_tick_a = [0,0,0,0,0,0,0,0]
    average_tick_e = [0,0,0,0,0,0,0,0]
    tick_cnt = [0,0,0,0,0,0,0,0]

    for sensorID in range(0,MAX_SENSORS):
        print("ID: {} | size {}".format(sensorID,len(dataRaw[sensorID].TS)))
        for n in range(1,len(dataRaw[sensorID].TS)): #starting from 1 because we need 2 Beamwords

            #first_BeamWord = 0x01205
            #second_BeamWord = 0x1f1f3
            first_nPoly = dataRaw[sensorID].nP[n-1]
            second_nPoly = dataRaw[sensorID].nP[n]
            first_TS = dataRaw[sensorID].TS[n-1]
            second_TS = dataRaw[sensorID].TS[n]

            first_OS = dataRaw[sensorID].OS[n-1]
            second_OS = dataRaw[sensorID].OS[n]

            time_delta = second_TS - first_TS
            maxTimeDelta = 380000 #20ms/2 * 48Mhz = ticks for half of the period

            #if (first_nPoly == second_nPoly) and (time_delta < maxTimeDelta) and (second_TS > (first_TS + 1000) ):
            if first_OS == 0:
                print("ERROR")
                exit()
            if second_OS == 0:
                print("ERROR")
                exit()

            if (first_nPoly == second_nPoly) and (time_delta < maxTimeDelta) and (second_OS > (first_OS + 100) ):
                first_BeamWord = dataRaw[sensorID].TS[n-1]
                second_BeamWord = dataRaw[sensorID].TS[n]


                '''
                    STARTING WITH RAY CALCULATION
                '''

                #Max Time
                #we know the LFSR has a polynome with the size of
                # 17
                # hence 2^17-1 iterations
                # = 131071
                channel = 0#TODO: Prober Value that updates via data
                MAX_Time = 131071


                '''
                !!!!! INFO !!!!!
                CHECK IF first_time and second_time from is correct
                ....left right angle was working back then, check if the correct
                parameters are used to get the timestamp's

                Ich hab irgendwie im kopf das man die timeStamps
                gar nicht umrechnen braucht, wenn man Lighthouse 2
                verwendet
                '''

                #SYSTEM_CLK = 24000000.0 #24MHz System Clock
                #LFSR_CLK = 6000000.0
                #k = SYSTEM_CLK/LFSR_CLK #Correction Faktor
                #PERIOD = SYSTEM_CLK/f_perChannel[channel]

                #phi1 = (first_Ticks * k)/PERIOD * 2*np.pi
                #phi2 = (second_Ticks * k)/PERIOD * 2*np.pi - np.pi


                #ph1 and ph2 are the compareable to the time events
                #phi1 should be first_Ticks/MAX_Ticks * 2*PI ... because
                # after MAX_Ticks/2 = first_Ticks
                # phi1 is equal to PI
                #
                #phi2 should be scond_Time/MAX_Ticks * 2*PI - PI... because
                # after MAX_Ticks/2 = scond_Time
                # phi2 is equal to 0

                #TicksToSec = (1/f_perChannel[channel])


                #first_Ticks = lfsr_tickResolv(first_nPoly,first_BeamWord) #TODO replace with working stuff
                #second_Ticks = lfsr_tickResolv(second_nPoly,second_BeamWord) #TODO replace with working stuff
                #phi1 = first_Ticks/MAX_Time * 2 * np.pi
                #phi2 = second_Ticks/MAX_Time * 2 * np.pi - np.pi


                #first_Ticks = ((first_OS * 4.0) / PERIODS[first_nPoly >> 1])
                #second_Ticks = ((second_OS * 4.0) / PERIODS[second_nPoly >> 1])
                first_Ticks = ((first_OS * 8.0) / PERIODS[first_nPoly >> 1])
                second_Ticks = ((second_OS * 8.0) / PERIODS[second_nPoly >> 1])
                phi1 = first_Ticks * 2 * np.pi
                phi2 = second_Ticks * 2 * np.pi - np.pi

                average_tick0[sensorID] = average_tick0[sensorID] + first_Ticks
                average_tick1[sensorID] = average_tick1[sensorID] + second_Ticks
                tick_cnt[sensorID] = tick_cnt[sensorID] + 1

                average_tick0



                print("[{}]Phi1: {} | TK:{}\n[{}]Phi2: {} | TK:{}".format(sensorID,phi1,first_Ticks,sensorID,phi2,second_Ticks))

                #TODO: remove hardcoded debuging lines
                #phi1 = 3*np.pi/4
                #phi2 = 2*np.pi/4


                ray = ray_calculation(phi1,phi2)
                [az, ele] = vec2azimuth(ray)

                #if sensorID == 2:
                #    ax.plot(ray[0],ray[2],ray[1])

                average_tick_a[sensorID] = average_tick_a[sensorID] + az
                average_tick_e[sensorID] = average_tick_e[sensorID] + ele

                print("azimuth {} | eleation {}".format(az/np.pi*180, ele/np.pi*180))


    for sensorID in range(0,MAX_SENSORS):
        if tick_cnt[sensorID] > 0:
            avg_tick0 = average_tick0[sensorID]/tick_cnt[sensorID]
            avg_tick1 = average_tick1[sensorID]/tick_cnt[sensorID]
            print("[{}]AVRG TICK 1: {}".format(sensorID,avg_tick0))
            print("[{}]AVRG TICK 2: {}".format(sensorID,avg_tick1))
            print("[{}]AVRG azi   : {}".format(sensorID,average_tick_a[sensorID]/tick_cnt[sensorID] * 180.0/np.pi))
            print("[{}]AVRG ele   : {}".format(sensorID,average_tick_e[sensorID]/tick_cnt[sensorID] * 180.0/np.pi))

            avg_tick0 = avg_tick0 * 2 * np.pi
            avg_tick1 = avg_tick1 * 2 * np.pi - np.pi

            ray = ray_calculation(avg_tick0,avg_tick1)

            ax.plot(ray[0],ray[2],ray[1])


    ax.plot(ray[0],ray[2],ray[1])
    plt.show()
