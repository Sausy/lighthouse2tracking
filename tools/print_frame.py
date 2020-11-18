#!/usr/bin/env python3

import serial
import math
import csv
import numpy as np


rotAngle_rad = np.pi/4 #Angle between the two sweeping planes
Allow_Plane_Plot = False

def loadPolyLut():
    f = open("polyLut.bin", "r")
    lines = f.read().split(",")
    retData = []
    for s in lines:
        buf = s.replace('\n', "")
        buf = buf.replace("0x", "")
        retData.append(int(buf,base=16))

    #lines = lines.
    #retData = int(lines,base=16)
    print(retData)

    return retData

def searchPosTickLfsr(polynome,endstate,start_state=0x00000001):
    lfsr = start_state
    bit  = 0     #Must be 16-bit to allow bit<<15 later in the code
    period = 0
    end_state = 0x0001ffff & endstate

    maxPoly = 2**17-1
    period_limit = maxPoly

    buffer = 0
    bitbuffer = 0

    buffer = 0x0001ffff & start_state & polynome
    #print("bufferPoly: %x \n", buffer);

    while True:
        #myfile << "0x" << std::hex << lfsr << ",\n";
        buffer = 0x0001ffff & lfsr & polynome
        bitbuffer = (buffer >> 0) & 0x00000001

        #for(int i = 1 ; i < 17 ; i++){
        for i in range(1,17):
            bitbuffer = (bitbuffer ^ (buffer >> i)) & 0x00000001
         #printf("bitbuffer: %x \n", bitbuffer)


        bit = bitbuffer & 0x00000001 # & 1u */
        #printf("bit: %x \n", bit)
        lfsr = (lfsr << 1) | (bit & 0x00000001)
        lfsr = 0x0001ffff & lfsr
        period = period + 1


        if period > period_limit : #maxPolySize-1
            break

        #while (lfsr^end_state);
        exitFlag = lfsr^end_state
        if exitFlag == 0:
            break


    return period


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

    #print("Vector = [{},{},{}]".format(vec[0][1],vec[1][1],vec[2][1]))
    #print("NormVector = [{},{},{}]".format(x,y,z))
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



def calculateAE(firstBeam, secondBeam):
    azimuth = ((firstBeam + secondBeam) / 2) - math.pi
    p = math.radians(60)
    beta = (secondBeam - firstBeam) - math.radians(120)
    elevation = math.atan(math.sin(beta/2)/math.tan(p/2))
    return (azimuth, elevation)


PERIODS = [959000, 957000,
           953000, 949000,
           947000, 943000,
           941000, 939000,
           937000, 929000,
           919000, 911000,
           907000, 901000,
           893000, 887000]

if __name__ == "__main__":
    import sys
    import struct

    if len(sys.argv) < 2:
        print("Usage: {} <input.bin or /dev/tty...>".format(sys.argv[0]))
        exit(1)

    if sys.argv[1].startswith("/dev/"):
        src = serial.Serial(sys.argv[1], 4*115200)
    else:
        src = open(sys.argv[1], "rb")

    #load known Lfsr polynomes to an array
    polyArray = loadPolyLut()

    #calculate the max lfsr size
    maxLfsrTicks = 2**17-1

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

    lastMeasurements = [0,] * 16


    reading = src.read(12)
    prevEwidth = [0] * 32
    prevSweepTime = [0] * 32
    prevSweepTime2 = [0] * 32 #prevSweepTime = 0
    prevBeamWord = [0] * 32
    prevBeam = 0

    histTick = [[0] * 25] * 32
    #histTime = [[0] * 25] * 32
    histTime = [0] * 25
    prevOfset = [0] * 32
    prevOfset2 = [0] * 32
    prevOfset3 = [0] * 32
    prevOfset4 = [0] * 32

    prevSweepTime_ch = [[0] * 25] * 32
    print("history size: {}".format(np.shape(histTick)))

    Tick = 0

    while(len(reading) == 12):
        timestamp = struct.unpack("<I", reading[9:] + b'\x00')[0]
        beam_word = struct.unpack("<I", reading[6:9] + b'\x00')[0]
        offset = struct.unpack("<I", reading[3:6] + b'\x00')[0]
        first_word = struct.unpack("<I", reading[:3] + b'\x00')[0]


        if (offset != 0xffffff) and (beam_word != 0xffffff) :
            sensor = first_word & 0x03
            sensor_add = ((offset >> 18) & 0xff) - 1#((offset >> 17) & 0x03 ) - 1;
            offset = offset & 0x01ffff

            if sensor_add < 0:
                print("\n Might be an erro pls restart: ")
            else:
                sensor = (sensor_add * 4) + sensor

            width = (first_word >> 8) & 0xffff

            nPoly_ok = ((first_word >> 7) & 0x01) == 0
            identity = (first_word >> 2) & 0x1f
            channel = identity >> 1
            slow_bit = identity & 0x01

            identity_swap = identity & (0xfe)
            identity_swap = identity_swap | ( ~slow_bit )

            if (identity < 32) and (sensor < 16):
                tdiv_ch = timestamp - prevSweepTime_ch[identity][sensor]
                tdiv_sen = timestamp - prevSweepTime[sensor]
                tdiv_hist = timestamp - prevSweepTime2[sensor]
                #if tdiv_sen < 1000000:
                dphi_ch = (tdiv_ch/PERIODS[identity >> 1]) * 360
                dphi_sen = (tdiv_sen/PERIODS[identity >> 1]) * 360
                tdiv_hist = (tdiv_hist/PERIODS[identity >> 1]) * 360
                #if (tdiv_hist < 200) and (tdiv_hist > 150):
                #    print("[{:2d}/{:2d}]dphi_ch: {:.2f}\t hist:{:.2f}\t === dphi_ch: {:.2f}\t hist:{:.2f}\t".format(sensor,identity,dphi_sen, tdiv_hist,dphi_ch * 2,tdiv_hist * 2))


                prevSweepTime_ch[identity][sensor] = timestamp
                prevSweepTime2[sensor] = prevSweepTime[sensor]

                if (offset > (prevOfset[identity]+1000)):
                    Tick1 = offset * (1.0/maxLfsrTicks) * (360.0)
                    Tick2 = prevOfset[identity] * (1.0/maxLfsrTicks) * (360.0)

                    #phi1 = (Tick2-150)* np.pi/180.0
                    #phi2 = (Tick1-30)* np.pi/180.0
                    phi1 = (Tick2)* np.pi/180.0
                    phi2 = (Tick1)* np.pi/180.0
                    #ray = ray_calculation(phi1,phi2)
                    #[azimu_,eleve_] = vec2azimuth(ray)

                    #print("[{:2d}/{:2d}]: OS0: {} | OS1: {} === az:{:.3f} | el:{:.3f} === {:.3f}/{:.3f}".format(sensor,identity,prevOfset[identity],offset, azimu_* 180.0/np.pi, eleve_ * 180.0/np.pi, Tick1, Tick2))

                    firstBeam = (( prevOfset[identity]  * 8.0) / PERIODS[identity >> 1]) * 2 * np.pi
                    secondBeam = ((offset * 8.0) / PERIODS[identity >> 1]) * 2 * np.pi
                    #firstBeam = (( prevOfset[identity] ) / maxLfsrTicks) * 2 * np.pi
                    #secondBeam = ((offset ) / maxLfsrTicks) * 2 * np.pi

                    firstPhi = secondBeam * 180.0/np.pi - 60
                    secondPhi = firstBeam * 180.0/np.pi + 60
                    phi1 = (firstPhi-150)* np.pi/180.0
                    phi2 = (secondPhi-30)* np.pi/180.0
                    #print("===\nphi {:5.3f}/{:5.3f}".format(phi1,phi2))
                    ray = ray_calculation(phi1,phi2)
                    [azimu_,eleve_] = vec2azimuth(ray)
                    azimu_ = azimu_  * 180.0/np.pi
                    eleve_ = eleve_  * 180.0/np.pi

                    #print("[{:2d}/{:2d}]: OS0: {} | OS1: {} === az:{:.3f} | el:{:.3f} === {:.3f}/{:.3f}".format(sensor,identity,prevOfset[identity],offset, azimu_* 180.0/np.pi, eleve_ * 180.0/np.pi, Tick1, Tick2))

                    azimuth, elevation = calculateAE(secondBeam, firstBeam)

                    print("[{:2d}/{:2d}]: az:{:5.3f}\t/el:{:5.3f} \t FB: {:5.3f} \t SB: {:5.3f} \t AZ: {:5.3f} \t EL:{:5.3f}".format(sensor,identity, azimuth* 180.0/np.pi, elevation * 180.0/np.pi, firstBeam * 180.0/np.pi, secondBeam * 180.0/np.pi, azimu_,eleve_))

                    '''
                    firstBeam = (( prevOfset2[identity]  * 8.0) / PERIODS[identity >> 1]) * 2 * np.pi

                    firstPhi = secondBeam * 180.0/np.pi - 60
                    phi1 = (firstPhi-150)* np.pi/180.0
                    #print("===\nphi {:5.3f}/{:5.3f}".format(phi1,phi2))
                    ray = ray_calculation(phi1,phi2)
                    [azimu_,eleve_] = vec2azimuth(ray)
                    azimu_ = azimu_  * 180.0/np.pi
                    eleve_ = eleve_  * 180.0/np.pi

                    #print("[{:2d}/{:2d}]: OS0: {} | OS1: {} === az:{:.3f} | el:{:.3f} === {:.3f}/{:.3f}".format(sensor,identity,prevOfset[identity],offset, azimu_* 180.0/np.pi, eleve_ * 180.0/np.pi, Tick1, Tick2))

                    azimuth, elevation = calculateAE(secondBeam, firstBeam)

                    print(" [{:2d}/{:2d}]: az:{:5.3f}\t/el:{:5.3f} \t FB: {:5.3f} \t SB: {:5.3f} \t AZ: {:5.3f} \t EL:{:5.3f}".format(sensor,identity, azimuth* 180.0/np.pi, elevation * 180.0/np.pi, firstBeam * 180.0/np.pi, secondBeam * 180.0/np.pi, azimu_,eleve_))

                    firstBeam2 = (( prevOfset3[identity]  * 8.0) / PERIODS[identity >> 1]) * 2 * np.pi

                    firstBeam3 = (( prevOfset4[identity]  * 8.0) / PERIODS[identity >> 1]) * 2 * np.pi

                    #print("[{:2d}/{:2d}]: OS0: {} | OS1: {} === az:{:.3f} | el:{:.3f} === {:.3f}/{:.3f}".format(sensor,identity,prevOfset[identity],offset, azimu_* 180.0/np.pi, eleve_ * 180.0/np.pi, Tick1, Tick2))
                    print("  [{:2d}/{:2d}]: FB1: {:.3f} \tFB2: {:.3f} \t FB3: {:.3f} \t==W:{:.3f} \t W2:{:.3f}".format(sensor,identity, firstBeam * 180/np.pi, firstBeam2 * 180/np.pi,firstBeam3 * 180/np.pi, width,prevEwidth[identity]))

                    #print("  divTime: {} \t{}".format(timestamp - prevSweepTime[sensor] , (timestamp - prevSweepTime[sensor] )/PERIODS[identity >> 1] * 360))

                    azimuth, elevation = calculateAE(secondBeam, firstBeam)

                    '''

                    prevOfset4[identity] = prevOfset3[identity]
                    prevOfset3[identity] = prevOfset2[identity]
                    prevOfset2[identity] = prevOfset[identity]
                    prevOfset[identity] = offset
                    #prevSweepTime[identity] = timestamp
                    prevSweepTime[sensor]= timestamp

                    prevEwidth[identity] = width


                elif (prevOfset[identity_swap] > (offset+10000)) :
                    Tick1 = prevOfset[identity] * (1.0/maxLfsrTicks) * (360.0)
                    Tick2 = offset * (1.0/maxLfsrTicks) * (360.0)

                    phi2 = (Tick1)* np.pi/180.0
                    ray = ray_calculation(phi1,phi2)
                    [azimu_,eleve_] = vec2azimuth(ray)
                    print("REV[{}/{}]: OS0: {} | OS1: {} === az:{:.3f} | el:{:.3f} === {:.3f}/{:.3f}".format(sensor,identity,prevOfset[identity],offset, azimu_* 180.0/np.pi, eleve_ * 180.0/np.pi, Tick1, Tick2))

                    prevOfset4[identity] = prevOfset3[identity]
                    prevOfset3[identity] = prevOfset2[identity]
                    prevOfset2[identity] = prevOfset[identity]
                    prevOfset[identity] = offset
                    prevOfset[identity_swap] = offset

                    #prevSweepTime[identity] = timestamp
                    prevSweepTime[sensor]= timestamp
                    prevBeamWord[identity] = beam_word
                    prevEwidth[identity] = width

                else:

                    prevOfset4[identity] = prevOfset3[identity]
                    prevOfset3[identity] = prevOfset2[identity]
                    prevOfset2[identity] = prevOfset[identity]
                    prevOfset[identity] = offset

                    #prevSweepTime[identity] = timestamp;
                    prevSweepTime[sensor]= timestamp
                    prevBeamWord[identity] = beam_word;
                    prevEwidth[identity] = width;


        '''
        sensor = first_word & 0x03
        width = (first_word >> 8) & 0xffff

        nPoly_ok = ((first_word >> 7) & 0x01) == 0
        identity = (first_word >> 2) & 0x1f
        channel = identity >> 1
        slow_bit = identity & 1

        additional_id = ((offset >> 18) & 0xff) - 1
        real_id = (additional_id * 4) + sensor;

        # Sync frame, ignore it
        if offset == 0xffffff:
            reading = src.read(12)
            continue

        # Detect new sweep
        #if ((timestamp - prevSweepTime) & 0xffffff) > 90000:
        #    print("[DIV ERROR]TS:{:06x} nPoly:{}  BeamWord:{:05x} |DIV {} ".format(prevSweepTime,identity, prevBeam, timestamp - prevSweepTime))
        prevSweepTime = timestamp
        prevBeam = beam_word

        offset = offset & 0x01ffff
        if (nPoly_ok):
            #search for the proper time
            Tick = searchPosTickLfsr(polyArray[identity],beam_word)
            #get azimuth via intersecting planes

            if real_id < 25:
                tdiv = timestamp-histTime[real_id]
                if (tdiv < 1000000) and (tdiv > -1000000):
                    if tdiv < 0:
                        tdiv = (1000000 - -histTime[real_id]) + timestamp

                    dphi = tdiv * 50/48000000 * 360.0
                    print("dphi[{}]: {} | div: {}".format(real_id,dphi, tdiv))

        '''
        '''
                #TODO: should be more sofisticated
                #but for now it does the job
                if Tick > histTick[identity][real_id]:
                    Tick2 = Tick * (1.0/maxLfsrTicks) * (360.0)
                    Tick1 = histTick[identity][real_id] * (1.0/maxLfsrTicks) * (360.0)
                else:
                    Tick1 = Tick * (1.0/maxLfsrTicks) * (360.0)
                    Tick2 = histTick[identity][real_id] * (1.0/maxLfsrTicks) * (360.0)

                firstPhi = Tick2
                secondPhi = Tick1

                if (Tick1 < 220) and (Tick2 > 120) and (Tick1 > 20) :
                    phi1 = (firstPhi-150)* np.pi/180.0
                    phi2 = (secondPhi-30)* np.pi/180.0


                    ray = ray_calculation(phi1,phi2)
                    [azimu_,eleve_] = vec2azimuth(ray)
                    #azimu_ = np.pi - azimu_;
                    #histTick[identity][real_id] = Tick


                    print("Sensor: {}  TS:{}  Width:{:4x}  Chan:{:2}({})  nPoly:{}  BeamWord:{:05x} \t".format(real_id, timestamp, width, channel + 1,
                        slow_bit, identity, beam_word), end='')
                    print("\noffset: {} | additional_id {} | tick {} | az:{} | ele:{}  ".format(offset, real_id, Tick, azimu_ * 180/np.pi,eleve_* 180/np.pi))
                    print("Tick {}/{} | phi {}/{}".format(Tick2,Tick1,phi2, phi1))
        '''
        '''
                histTick[identity][real_id] = Tick
                histTime[real_id] = timestamp

        else:
            print("[Info] nPoly not ok  TS:{:06x} nPoly:{}  BeamWord:{:05x}\n".format(timestamp,identity, beam_word))
        #    print("Sensor: {}  TS:{:06x}  Width:{:4x}  Chan: None  nPoly:{} BeamWord:{:05x}\t".format(sensor, timestamp, width, identity,beam_word),
        #        end='')

        if offset != 0:
            if offset > (lastMeasurements[channel]+100):
                firstBeam = ((lastMeasurements[channel] * 8.0) / PERIODS[identity >> 1]) * 2 * math.pi
                secondBeam = ((offset * 8.0) / PERIODS[identity >> 1]) * 2 * math.pi
                azimuth, elevation = calculateAE(firstBeam, secondBeam)
                #print("Sensor: {} | Chan:{:2}({}) | angleXY: {:3.3f}°, {:3.3f}°".format(real_id, channel + 1, slow_bit, math.degrees(azimuth), math.degrees(elevation)), end='')

            lastMeasurements[channel] = offset

        if (nPoly_ok):
            print()

        '''

        reading = src.read(12)
