# Install script for directory: /home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_cognition_msgs/msg" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/AudioData.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/AudioInfo.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/DirectionVector.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/FaceCoordinates.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/FacialFeatures.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/SpeechSynthesis.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/AudioLocation.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/RecognizedFaces.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/Faces.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/RecognizedSpeech.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/msg/IceCream.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_cognition_msgs/srv" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/ApplyFilter.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/AssertProperty.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/CallQuery.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/CheckProperty.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/CheckQuery.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/CreateInstance.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/DataQuery.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/DescribeScene.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/DetectFace.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/DetectIntent.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/DriveToLocation.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/EvalSeq2Seq.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/FindInstances.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/FindObject.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/GenerateAnswer.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/GetObject.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/LookAtSpeaker.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/Payment.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/PlaySound.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/QualityOfTone.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/QualityOfTones.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/RecognizeFaces.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/RecognizeObject.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/RecognizeSpeech.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/SaveObject.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/ShowInstances.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/ShowProperty.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/ShowPropertyValue.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/Talk.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/TalkToFile.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/TrainSeq2Seq.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/WhichTones.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/DetectIceCream.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/srv/LocalizeObject.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_cognition_msgs/action" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/action/OrderIceCream.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_cognition_msgs/msg" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roboy_cognition_msgs/msg/OrderIceCreamAction.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roboy_cognition_msgs/msg/OrderIceCreamActionGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roboy_cognition_msgs/msg/OrderIceCreamActionResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roboy_cognition_msgs/msg/OrderIceCreamActionFeedback.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roboy_cognition_msgs/msg/OrderIceCreamGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roboy_cognition_msgs/msg/OrderIceCreamResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roboy_cognition_msgs/msg/OrderIceCreamFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_cognition_msgs/cmake" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_cognition_msgs/catkin_generated/installspace/roboy_cognition_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/include/roboy_cognition_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/roseus/ros/roboy_cognition_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/common-lisp/ros/roboy_cognition_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/share/gennodejs/ros/roboy_cognition_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/lib/python2.7/dist-packages/roboy_cognition_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/devel/lib/python2.7/dist-packages/roboy_cognition_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_cognition_msgs/catkin_generated/installspace/roboy_cognition_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_cognition_msgs/cmake" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_cognition_msgs/catkin_generated/installspace/roboy_cognition_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_cognition_msgs/cmake" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_cognition_msgs/catkin_generated/installspace/roboy_cognition_msgsConfig.cmake"
    "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/build/roboy_communication/roboy_cognition_msgs/catkin_generated/installspace/roboy_cognition_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_cognition_msgs" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2tracking/UDPtoROS/src/roboy_communication/roboy_cognition_msgs/package.xml")
endif()

