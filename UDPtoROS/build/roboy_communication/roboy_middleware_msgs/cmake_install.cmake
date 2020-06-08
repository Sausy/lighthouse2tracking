# Install script for directory: /home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_middleware_msgs/msg" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/ADCvalue.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/ArmStatus.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/ArucoPose.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/ControllerState.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/DanceCommand.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/DarkRoom.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/DarkRoomOOTX.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/DarkRoomSensor.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/DarkRoomSensorV2.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/DarkRoomStatistics.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/DarkRoomStatus.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/HandCommand.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/JointStatus.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/LighthousePoseCorrection.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/MagneticSensor.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/MotorAngle.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/MotorCommand.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/MotorConfig.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/msg/MotorStatus.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_middleware_msgs/srv" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/ControlMode.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/DanceTrajectory.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/EmergencyStop.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/FrameIK.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/ForwardKinematics.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/InverseKinematics.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/InverseKinematicsMultipleFrames.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/JointController.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/MotorCalibrationService.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/MotorConfigService.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/MyoBrickCalibrationService.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/SetInt16.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/SystemCheck.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/TorqueControl.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/srv/XL320.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_middleware_msgs/cmake" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_middleware_msgs/catkin_generated/installspace/roboy_middleware_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/include/roboy_middleware_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roseus/ros/roboy_middleware_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/common-lisp/ros/roboy_middleware_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/gennodejs/ros/roboy_middleware_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/lib/python2.7/dist-packages/roboy_middleware_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/lib/python2.7/dist-packages/roboy_middleware_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_middleware_msgs/catkin_generated/installspace/roboy_middleware_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_middleware_msgs/cmake" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_middleware_msgs/catkin_generated/installspace/roboy_middleware_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_middleware_msgs/cmake" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_middleware_msgs/catkin_generated/installspace/roboy_middleware_msgsConfig.cmake"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_middleware_msgs/catkin_generated/installspace/roboy_middleware_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_middleware_msgs" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_middleware_msgs/package.xml")
endif()

