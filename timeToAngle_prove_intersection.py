#!/usr/bin/env python3

import math
import matplotlib as mpl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d import proj3d


Allow_Plane_Plot = True
rotAngle_rad = np.pi/4#45.0

def baseRotation(r_vec, phi: float):
    '''
    rotation is counter clockwise
    '''
    phi = -phi

    rotMatrix_y =      [[np.cos(phi), 0, np.sin(phi), 0],
                        [0, 1, 0, 0],
                        [-np.sin(phi), 0, np.cos(phi), 0],
                        [0, 0, 0, 1]]


    return [rotMatrix_y, rotMatrix_y]

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


def coord_transform_2(d, phi: float, rotAngle_rad, isNeg=False):
    '''
    rotation is counter clockwise
    '''
    phi = -phi

    #TODO FOV into this shi
    trans_x = 0#-1 #* np.sin(rotAngle_rad) * d
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

#new version
def ray_calculation(first_phi, secon_phi):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    rZero = [0, 0, 0, 1]

    r_ = plane_transformation(first_phi, [-1, 0, 0, 1], sweep=0)

    if Allow_Plane_Plot :
        print("\n==========\nFirst Plain rotation: (blue)")
        print(r_)
        print("\n")

        x = np.array([[0.0,r_[0][0]],[r_[1][0],r_[2][0]],[r_[3][0],r_[4][0]]])
        y = np.array([[0.0,r_[0][1]],[r_[1][1],r_[2][1]],[r_[3][1],r_[4][1]]])
        z = np.array([[0.0,r_[0][2]],[r_[1][2],r_[2][2]],[r_[3][2],r_[4][2]]])

        ax.plot_surface(x,z,y, color='b')
        #plt.show()

    p0 = [0,0,0]
    p1 = r_[2][0:3]
    p2 = r_[3][0:3]
    p3 = r_[4][0:3]

    r_ = plane_transformation(secon_phi, [-1, 0, 0, 1], sweep=1)

    if Allow_Plane_Plot :
        print("\n==========\nSecond Plain rotation: (red)")
        print(r_)
        print("\n")

        x = np.array([[0.0,r_[0][0]],[r_[1][0],r_[2][0]],[r_[3][0],r_[4][0]]])
        y = np.array([[0.0,r_[0][1]],[r_[1][1],r_[2][1]],[r_[3][1],r_[4][1]]])
        z = np.array([[0.0,r_[0][2]],[r_[1][2],r_[2][2]],[r_[3][2],r_[4][2]]])

        ax.plot_surface(x,z,y, color='r')
        #plt.show()


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

    if Allow_Plane_Plot:
        print("\n+++[RAY]+++")
        print(ray)
        print("\nprove that plane equation is correct ")
        print(np.dot(n1, p1 - p0))
        ax.plot(ray[0],ray[2],ray[1])
        plt.show()

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


if __name__ == "__main__":

    '''
    secondPhi = (223.6-180.0) * np.pi/180.0#avg_tick0 * 2 * np.pi
    firstPhi  = (124.5) * np.pi/180.0

    #secondPhi = (251-180.0) * np.pi/180.0#avg_tick0 * 2 * np.pi
    #firstPhi  = (107) * np.pi/180.0


    #links unten
    secondPhi = (184-180.0) * np.pi/180.0#avg_tick0 * 2 * np.pi
    firstPhi  = (83) * np.pi/180.0

    #rechts unten
    #secondPhi = (271-180.0) * np.pi/180.0#avg_tick0 * 2 * np.pi
    #firstPhi  = (170) * np.pi/180.0

    #links oben
    secondPhi = (201.8-180.0) * np.pi/180.0#avg_tick0 * 2 * np.pi
    firstPhi  = (60) * np.pi/180.0
    '''

    #=================================================

    #it was figured out that the center is at an angle of
    #[120, 240]deg ... this means
    #so 120 - 90 = 30 ,,,, 240-90 = 150

    tag = ['left bottom','right bottom','right top', 'left top','middel top', 'middel bottom']
    firstPhi = [184,271,291,201.8,218,257]
    secondPhi = [83,170,149.8,60,117,115.8]

    tag = ['mid bottom','left bottom','right bottom']
    #firstPhi = [221.88,185.82,267.569]
    #secondPhi = [120.62,84.43,166.3]
    firstPhi = [240,237.135641]
    secondPhi = [120,119.765881]

    #find the fucking error data dump
    #[24/2]az 91.546236 --- ele -1.314399 -- 237.139020/119.768509
    #[24/2]az 33.930657 --- ele -40.582393 -- 237.135641/119.765881
    firstPhi = [237.137143]
    secondPhi = [119.766632]


    #Tick1 = 62845.0
    #Tick2 = 70242.0

    #links oben
    #Tick1 = 2130.0
    #Tick2 = 62225.0

    #links oben
    #Tick1 = 35320
    #Tick2 = 62420

    #rechts unterhalb
    #Tick1 = 29797
    #Tick2 = 97634

    #links oben
    #Tick1 = 36721
    #Tick2 = 61445

    #hoch mitte
    #Tick1 = 67857
    #Tick2 = 91637

    #Sensor 1
    #try to center
    Tick1 = 37311
    Tick2 = 86833

    overload = 1000000
    TimeStamp1 = 127754
    TimeStamp2 = 7470570
    Tdelta = TimeStamp2 - TimeStamp1



    #what we figured out
    #one iteration takes time= 1_000_000
    # 1_000_000/24MHz * 50H ~= 1



    maxLfsrTicks = 2**17-1
    Tick1 = Tick1 * (1.0/maxLfsrTicks) * (360.0) #+30#+ 30 #- 30
    Tick2 = Tick2 * (1.0/maxLfsrTicks) * (360.0) #+30#+ 150 #- 30
    print("phi1 {}, phi2 {}".format(Tick1, Tick2))
    firstPhi = [Tick2]
    secondPhi = [Tick1]

    if Tdelta < 0:
        print("inv")
        #fac = int(round(overload/overload - 0.5)) #immer abrundne
        Tdelta = (overload - TimeStamp1) + TimeStamp2
    else:
        fac = int(round(Tdelta/overload - 0.5)) #immer abrundne
        Tdelta = (TimeStamp2 - TimeStamp1) - fac*overload

    deltaPhi = Tdelta/48000000*50

    print("TIME delta: {} .. {}..{}".format(Tdelta,fac,deltaPhi * 360) )



    firstPhi = [284.048 - 60,273.741 - 60,271.423 - 60]
    secondPhi = [83.036 + 60,88.010 + 60, 88.007 + 60]

     #[ 0/ 1]: az:-33.871	/el:35.696 	 FB: 1.622 	 SB: 290.637 	 AZ: 26.296 	 EL:-43.731
     #[ 0/ 0]: az:-34.432	/el:35.123 	 FB: 1.607 	 SB: 289.529 	 AZ: 124.432 	 EL:22.103

    #firstPhi = [290.637 - 60, 289.529 - 60,221.337 -60]
    #secondPhi = [1.622  + 60, 1.607  + 60,10.841 + 60]

    firstPhi = [311.677]
    secondPhi = [111.125 ]


    for i in range(0,len(firstPhi)):

        #phi1 = (firstPhi[i]-150)* np.pi/180.0
        phi1 = (secondPhi[i]+106.282-150-10)* np.pi/180.0
        phi2 = (secondPhi[i]-30)* np.pi/180.0
        print("\nPHI1: {:.3f} | PHI2: {:.3f}".format(phi1 * 180.0/np.pi,phi2 * 180.0/np.pi))
        #1.4651266148668105/0.879077566828931

        #phi1 = (secondPhi[i] + deltaPhi - 150) * np.pi/180.0
        #ray = ray_calculation(phi1,phi2)
        ray = ray_calculation(phi1,phi2)


        [azimuth, elevation] = vec2azimuth(ray)
        print("\nPosition {}".format(tag[i]))
        print("AZIMUT and ELEVATION")
        print("az: {:.3f} \t el:{:.3f}".format(azimuth* 180.0/np.pi, elevation*180.0/np.pi) )
        print('ray {}'.format(ray))



'''

def ray_calculation(firstPhi,secondPhi):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    u = np.linspace(0, 2 * np.pi, 100)
    v = np.linspace(0, np.pi, 100)
    dataPointsCnt = 100
    k = np.tan(45) #the plane has a 45deg angle

    #x = np.outer(np.linspace(-20, 20, dataPointsCnt),)
    #y = np.outer(k * x,)
    #z
    #y = 10 * np.outer(np.sin(u), np.sin(v))
    #z = 10 * np.outer(np.ones(np.size(u)), np.cos(v))

    # Plot the surface
    #ax.plot_surface(x, y, z, color='b')

    ##ax.plot_trisurf(x,y,z,antialiased=False)
    #foo1 = np.array([[0,1],[2,3],[4,5]])
    #foo2 = np.array([[10,10],[20,30],[40,50]])
    lighthouse_beam_open_angle = 160.0
    tmp_lh_angle = lighthouse_beam_open_angle/2.0


    #r = 1

    r = {'scalar':1,
        'frame0':{
            'zero':[0, 0, 0, 1],
            'vec':[-1, 0, 0, 1],
            'zero_new':[0, 0, 0, 1], #must be initatlised, 0 is just a place holder
            'vec_new':[0, 0, 0, 1] #must be initatlised, 0 is just a place holder
        },
        'frame1':{
            'zero':[0, 0, 0, 1],
            'vec':[-1, 0, 0, 1],
            'zero_new':[0, 0, 0, 1], #must be initatlised, 0 is just a place holder
            'vec_new':[0, 0, 0, 1] #must be initatlised, 0 is just a place holder
        },
        'trans01':{
            'zero':[0, 0, 0, 1],
            'vec':[-1, 0, 0, 1],#must be initatlised, 0 is just a place holder
        },
        'trans02':{
            'zero':[0, 0, 0, 1],
            'vec':[-1, 0, 0, 1],#must be initatlised, 0 is just a place holder
        }

        }

    [T, T_inv] = coord_transform_1(1, 0.0, rotAngle_rad)


    #====
    #FIRST SWEEP
    #====
    phi = firstPhi#3*np.pi/4#68.0/180*np.pi#np.pi/2  #60.0/180*np.pi
    [T, T_inv] = baseRotation(1, phi)
    r['frame0']['zero_new'] = r['frame0']['zero']
    r['frame0']['vec_new'] = np.dot(T_inv,r['frame0']['vec'])

    #main sweep


    [T, T_inv] = coord_transform_1(1, phi, rotAngle_rad)
    r['trans01']['zero'] = np.dot(T_inv,r['frame1']['zero'])
    r['trans01']['vec'] = np.dot(T_inv,r['frame1']['vec'])


    #x = np.array([[0.0,r['frame0']['vec_new'][0]],[r['trans01']['zero'][0],r['trans01']['vec'][0]]])
    #y = np.array([[0.0,r['frame0']['vec_new'][1]],[r['trans01']['zero'][1],r['trans01']['vec'][1]]])
    #z = np.array([[0.0,r['frame0']['vec_new'][2]],[r['trans01']['zero'][2],r['trans01']['vec'][2]]])

    #ax.plot_surface(x,z,y, color='b')

    [T, T_inv] = coord_transform_1(1, phi, rotAngle_rad, True)
    r['trans02']['zero'] = np.dot(T_inv,r['frame1']['zero'])
    r['trans02']['vec'] = np.dot(T_inv,r['frame1']['vec'])
    #print(T_inv)


    x = np.array([[0.0,r['frame0']['vec_new'][0]],[r['trans01']['zero'][0],r['trans01']['vec'][0]],[r['trans02']['zero'][0],r['trans02']['vec'][0]]])
    y = np.array([[0.0,r['frame0']['vec_new'][1]],[r['trans01']['zero'][1],r['trans01']['vec'][1]],[r['trans02']['zero'][1],r['trans02']['vec'][1]]])
    z = np.array([[0.0,r['frame0']['vec_new'][2]],[r['trans01']['zero'][2],r['trans01']['vec'][2]],[r['trans02']['zero'][2],r['trans02']['vec'][2]]])
    #x = np.array([[0.0,r['frame0']['vec_new'][0]],[r['trans01']['zero'][0],r['trans01']['vec'][0]]])
    #y = np.array([[0.0,r['frame0']['vec_new'][1]],[r['trans01']['zero'][1],r['trans01']['vec'][1]]])
    #z = np.array([[0.0,r['frame0']['vec_new'][2]],[r['trans01']['zero'][2],r['trans01']['vec'][2]]])

    ax.plot_surface(x,z,y, color='b')

    #plt.show()

    p0 = [0,0,0]
    p1 = r['trans01']['zero'][0:3]
    p2 = r['trans01']['vec'][0:3]
    p3 = r['trans02']['vec'][0:3]


    #====
    #SECOND SWEEP
    #====
    phi = secondPhi#37.0/180*np.pi#np.pi/2 #37.0/180*np.pi
    [T, T_inv] = baseRotation(1, phi)
    r['frame0']['zero_new'] = r['frame0']['zero']
    r['frame0']['vec_new'] = np.dot(T_inv,r['frame0']['vec'])

    [T, T_inv] = coord_transform_2(1, phi, rotAngle_rad)
    r['trans01']['zero'] = np.dot(T_inv,r['frame1']['zero'])
    r['trans01']['vec'] = np.dot(T_inv,r['frame1']['vec'])
    [T, T_inv] = coord_transform_2(1, phi, rotAngle_rad, True)
    r['trans02']['zero'] = np.dot(T_inv,r['frame1']['zero'])
    r['trans02']['vec'] = np.dot(T_inv,r['frame1']['vec'])

    #x = np.array([[0.0,r['frame0']['vec_new'][0]],[r['trans01']['zero'][0],r['trans01']['vec'][0]]])
    #y = np.array([[0.0,r['frame0']['vec_new'][1]],[r['trans01']['zero'][1],r['trans01']['vec'][1]]])
    #z = np.array([[0.0,r['frame0']['vec_new'][2]],[r['trans01']['zero'][2],r['trans01']['vec'][2]]])
    x = np.array([[0.0,r['frame0']['vec_new'][0]],[r['trans01']['zero'][0],r['trans01']['vec'][0]],[r['trans02']['zero'][0],r['trans02']['vec'][0]]])
    y = np.array([[0.0,r['frame0']['vec_new'][1]],[r['trans01']['zero'][1],r['trans01']['vec'][1]],[r['trans02']['zero'][1],r['trans02']['vec'][1]]])
    z = np.array([[0.0,r['frame0']['vec_new'][2]],[r['trans01']['zero'][2],r['trans01']['vec'][2]],[r['trans02']['zero'][2],r['trans02']['vec'][2]]])

    ax.plot_surface(x,z,y, color='r')

    #====
    #Plot Center
    #====
    ax.set_xlabel('X')
    ax.set_ylabel('Z')
    ax.set_zlabel('Y')
    ax.set_ylim(0,1.5)
    ax.set_zlim(0,1.5)



    p12 = r['trans01']['zero'][0:3]
    p22 = r['trans01']['vec'][0:3]
    p32 = r['trans02']['vec'][0:3]


    print(p2 - p1)
    print(p3 - p1)

    print("\n Normal")
    n1 = np.cross((p2 - p1),(p3 - p1))
    print(n1)
    n2 = np.cross((p22 - p12),(p32 - p12))
    print(n2)
    n = n1 - n2
    print(n)

    print("\nprove that plane equation is correct ")
    print(np.dot(n1, p1 - p0))
    #print(np.dot(n1, p2 - p0))
    #print(np.dot(n1, p3 - p0))
    #print(np.dot(n2, p12 - p0))
    #print(np.dot(n2, p22 - p0))


    #print("\n print points")
    #print(p1)
    #print(p2)
    #print(p3)
    #print(p12)
    #print(p22)
    #print(p32)



    z_assumed = -1
    x = -(z_assumed * n[2])/n[0]
    y = -(n1[0]*x + n1[2]*z_assumed)/n1[1]

    print("\n solution")
    print([x,y,z_assumed])



    #print("!!!!!!!!")
    #print("the following is custom code for a spezific problem ")
    #the following if was figured out empiricly
    #if x > 0:
    #    ray =  [[0, -x],
    #            [0, -y],
    #            [0, -z_assumed]]
    #else:
    #    ray =  [[0, x],
    #            [0, y],
    #            [0, z_assumed]]




    #original
    ray =  [[0, x],
            [0, y],
            [0, z_assumed]]


    ax.plot(ray[0],ray[2],ray[1])



    ## if we now assume z is always one (because it's irelevant how long the ray is)
    ## and x has
    ## n[1]*x  == -n[2]


    #ax.scatter(v[:,0],v[:,2], v[:,1])


    plt.show()

    return ray
'''
