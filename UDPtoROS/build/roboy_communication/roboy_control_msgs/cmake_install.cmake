# Install script for directory: /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/install")
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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/msg" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/Behavior.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/ControlLeds.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/Emotion.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/DangerNotification.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/ErrorNotification.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/WarningNotification.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/DebugNotification.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/InfoNotification.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/StartRecordTrajectory.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/msg/Strings.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/srv" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/srv/ListItems.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/srv/MoveYaw.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/srv/SetMode.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/srv/SetControllerParameters.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/srv/ShowEmotion.srv"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/srv/TranslationalPTPMotion.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/action" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/action/LookAt.action"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/action/MoveEndEffector.action"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/action/PerformMovement.action"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/action/PerformMovements.action"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/msg" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/LookAtAction.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/LookAtActionGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/LookAtActionResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/LookAtActionFeedback.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/LookAtGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/LookAtResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/LookAtFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/msg" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/MoveEndEffectorAction.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/MoveEndEffectorActionGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/MoveEndEffectorActionResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/MoveEndEffectorActionFeedback.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/MoveEndEffectorGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/MoveEndEffectorResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/MoveEndEffectorFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/msg" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementAction.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementActionGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementActionResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementActionFeedback.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/msg" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementsAction.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementsActionGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementsActionResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementsActionFeedback.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementsGoal.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementsResult.msg"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roboy_control_msgs/msg/PerformMovementsFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/cmake" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/build/roboy_communication/roboy_control_msgs/catkin_generated/installspace/roboy_control_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/include/roboy_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/roseus/ros/roboy_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/common-lisp/ros/roboy_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/share/gennodejs/ros/roboy_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/lib/python2.7/dist-packages/roboy_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/devel/lib/python2.7/dist-packages/roboy_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/build/roboy_communication/roboy_control_msgs/catkin_generated/installspace/roboy_control_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/cmake" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/build/roboy_communication/roboy_control_msgs/catkin_generated/installspace/roboy_control_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs/cmake" TYPE FILE FILES
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/build/roboy_communication/roboy_control_msgs/catkin_generated/installspace/roboy_control_msgsConfig.cmake"
    "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/build/roboy_communication/roboy_control_msgs/catkin_generated/installspace/roboy_control_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roboy_control_msgs" TYPE FILE FILES "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/ws/src/roboy_communication/roboy_control_msgs/package.xml")
endif()

