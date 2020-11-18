#!/usr/bin/env python3

import serial
import math


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

    print("please use the one in tools this one is obsolete")
    exit
    import sys
    import struct
    if len(sys.argv) < 2:
        print("Usage: {} <input.bin or /dev/tty...>".format(sys.argv[0]))
        exit(1)

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

    lastMeasurements = [0,] * 16


    reading = src.read(12)
    prevSweepTime = 0
    prevBeam = 0

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
        real_id = (additional_id * 4) + sensor;

        # Sync frame, ignore it
        if offset == 0xffffff:
            reading = src.read(12)
            continue

        # Detect new sweep
        if ((timestamp - prevSweepTime) & 0xffffff) > 90000:
            print("[DIV ERROR]TS:{:06x} nPoly:{}  BeamWord:{:05x} |DIV {} ".format(prevSweepTime,identity, prevBeam, timestamp - prevSweepTime))
        prevSweepTime = timestamp
        prevBeam = beam_word

        offset = offset & 0x01ffff
        if (nPoly_ok):
            print("Sensor: {}  TS:{}  Width:{:4x}  Chan:{:2}({})  nPoly:{}  BeamWord:{:05x}\t".format(real_id, timestamp, width, channel + 1,
                slow_bit, identity, beam_word), end='')
            print("\noffset: {} | additional_id {} ".format(offset, real_id))
        else:
            print("[Info] nPoly not ok  TS:{:06x} nPoly:{}  BeamWord:{:05x}".format(timestamp,identity, beam_word))
        #    print("Sensor: {}  TS:{:06x}  Width:{:4x}  Chan: None  nPoly:{} BeamWord:{:05x}\t".format(sensor, timestamp, width, identity,beam_word),
        #        end='')

        if offset != 0:
            if offset > (lastMeasurements[channel]+100):
                firstBeam = ((lastMeasurements[channel] * 8.0) / PERIODS[identity >> 1]) * 2 * math.pi
                secondBeam = ((offset * 8.0) / PERIODS[identity >> 1]) * 2 * math.pi
                azimuth, elevation = calculateAE(firstBeam, secondBeam)
                print("Sensor: {} | Chan:{:2}({}) | angleXY: {:3.3f}°, {:3.3f}°".format(real_id, channel + 1, slow_bit, math.degrees(azimuth), math.degrees(elevation)), end='')

            lastMeasurements[channel] = offset

        if (nPoly_ok):
            print()

        reading = src.read(12)
