# Lighthouse 2 Tracking 
This Project is based on the Project esptracker from cnlohr https://github.com/cnlohr/esptracker
## Structur 

## Flashing the esp32 (nina) module
### Hardware
First you have to press both buttons, after a second the reset button can be release.
Another second later the boot button can be released.
### Software
There are two posibilities

* Arduino IDE
* Commandline

#### Commandline
```
cd ~/ArduinoDarkroom/DarkRoom_esp8266/
arduino --upload DarkRoom_esp8266.ino --port /dev/ttyUSB0
```

### Debuging
i use pio for that but "screen" would also work.
```
pio device monitor --port /dev/ttyUSB0 --baud $( expr 115200 \* 4 )
```

### Real Debugging
```
python3 ~/esp/esp-idf/tools/idf_monitor.py  --port /dev/ttyUSB0 --baud $( expr 115200 \* 4 ) /tmp/arduino_build_317883/DarkRoom_esp8266.ino.elf
```

should spit out errors if you don't have aliased xtensa-esp32-elf-addr2line the following comand should spit out the msg:
```
~/esp/xtensa-esp32-elf/bin/xtensa-esp32-elf-addr2line -pfiaC -e /tmp/arduino_build_317883/DarkRoom_esp8266.ino.elf 0x40088b81
```







```
pip3 install esptool
```
