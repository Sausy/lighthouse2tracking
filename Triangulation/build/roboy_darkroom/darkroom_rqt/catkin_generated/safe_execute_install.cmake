execute_process(COMMAND "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/roboy_darkroom/darkroom_rqt/catkin_generated/python_distutils_install.sh" RESULT_VARIABLE res)

if(NOT res EQUAL 0)
  message(FATAL_ERROR "execute_process(/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/roboy_darkroom/darkroom_rqt/catkin_generated/python_distutils_install.sh) returned error code ")
endif()
