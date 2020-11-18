#!/usr/bin/env python3

import math
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np


def baseRotation(r_vec, phi: float):

    rotMatrix_y =      [[np.cos(phi), 0, np.sin(phi), 0],
                        [0, 1, 0, 0],
                        [-np.sin(phi), 0, np.cos(phi), 0],
                        [0, 0, 0, 1]]


    return [rotMatrix_y, rotMatrix_y]

def coord_transform(d, phi: float, rotAngle_rad, isNeg=False):

    #TODO FOV into this shi
    trans_x = 0#-1 #* np.sin(rotAngle_rad) * d
    trans_y = np.sin(rotAngle_rad) * d
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

rotAngle_rad = np.pi/4.0#45.0
#r = 1

r = {'scalar':1,
    'frame0':{
        'zero':[0, 0, 0, 1],
        'ex':[-1, 0, 0, 1],
        'zero_new':[0, 0, 0, 1], #must be initatlised, 0 is just a place holder
        'ex_new':[0, 0, 0, 1] #must be initatlised, 0 is just a place holder
    },
    'frame1':{
        'zero':[0, 0, 0, 1],
        'ex':[-1, 0, 0, 1],
        'zero_new':[0, 0, 0, 1], #must be initatlised, 0 is just a place holder
        'ex_new':[0, 0, 0, 1] #must be initatlised, 0 is just a place holder
    },
    'trans01':{
        'zero':[0, 0, 0, 1],
        'ex':[-1, 0, 0, 1],#must be initatlised, 0 is just a place holder
    }

    }
print(r['frame0']['zero'])
r_vec = [-1, 0, 0]

r_vec0 = [0.0,  0.0, 0.0, 1.0]
r_vec1 = [-1.0, 0.0, 0.0, 1.0]

r_vec0_new = [0.0,  0.0, 0.0, 1.0]
r_vec1_new = [-1.0, 0.0, 0.0, 1.0]

phi = [0.0, 3*np.pi/4, np.pi/2, np.pi]

[T, T_inv] = coord_transform(1, phi[0], rotAngle_rad)

print("\nT_inv")


'''
x = np.array([[0.0,-1.0],[r_vec0[0],r_vec0[1]]])
y = np.array([[0.0,0.0],[r_vec0[0],r_vec0[0]]])
z = np.array([[0.0,0.0],[r_vec0[0],r_vec0[0]]])
'''


c = ['b', 'r','g','b']
v = [[0.0,0.0,0.0,1.0]]
foo_ = np.linspace(0,np.pi,20)

for i in range(0,20):
    [T, T_inv] = coord_transform(1, foo_[i], rotAngle_rad)
    if i == 0:
        v = [np.dot(T_inv,r_vec0)]
        #v = [np.dot(T,r_vec0)]
        print(v)
    else:
        v = np.append(v,[np.dot(T_inv,r_vec0)],axis=0)
        #v = np.append(v,[np.dot(T,r_vec0)],axis=0)

print(v)
#print(v[:,0])
#x_zero = np.zeros(20)
ax.scatter(v[:,0],v[:,2], v[:,1])


for i in range(0,4):
    print("\n full vector {}".format(phi[i]))

    [T, T_inv] = baseRotation(1, phi[i])
    r['frame0']['zero_new'] = r['frame0']['zero']
    r['frame0']['ex_new'] = np.dot(T_inv,r['frame0']['ex'])


    [T, T_inv] = coord_transform(1, phi[i], rotAngle_rad)

    r['trans01']['zero'] = np.dot(T_inv,r['frame1']['zero'])
    r['trans01']['ex'] = np.dot(T_inv,r['frame1']['ex'])
    print("\ntrans01 {}".format(phi[i]))
    print(r['trans01'])


    print(r['trans01']['zero'])
    print(r['trans01']['ex'])

    print(r['frame0']['zero_new'])
    print(r['frame0']['ex_new'])
    #print(r_vec0_new)
    #print(np.dot(T,r_vec3))
    #print(r_vec1_new)

    x = np.array([[0.0,r['frame0']['ex_new'][0]],[r['trans01']['zero'][0],r['trans01']['ex'][0]]])
    y = np.array([[0.0,r['frame0']['ex_new'][1]],[r['trans01']['zero'][1],r['trans01']['ex'][1]]])
    z = np.array([[0.0,r['frame0']['ex_new'][2]],[r['trans01']['zero'][2],r['trans01']['ex'][2]]])

    #!!! IMPORTANT !!!
    #THE PLOT swaps y and z
    ax.plot_surface(x,z,y, color=c[i])

plt.show()

print("\n=====[HENCE PROVEN that the vector Transformation works]")


plt.show()
