cmake_minimum_required(VERSION 3.15)
project(ros_usbhid_interface)

SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g")
#SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -std=gnu99 -rdynamic -Werror=incompatible-pointer-types -Wall -Wno-unused-variable -Wno-switch -Wno-parentheses -Wno-missing-braces -Werror=implicit-function-declaration -Wpedantic -Werror=return-type -fvisibility=hidden -Werror=vla")

SET(CMAKE_BUILD_TYPE Debug)


#==============================================================================
# Dependencies
#==============================================================================
find_package(catkin REQUIRED COMPONENTS
        roscpp
        std_msgs
        message_generation
        )

catkin_package(CATKIN_DEPENDS
        message_runtime
        )

include_directories(
        ${catkin_INCLUDE_DIRS}
)


FILE(GLOB SRC_FILES src/*.cpp)
FILE(GLOB LIB_FILES lib/*.hpp)


include_directories(
        include
        lib
)

add_library(usbLowLevelInterface
        include/usbHidInterface.cpp
        include/usbHidInterface.h
        )

add_executable( ros_usbhid_interface
        main.cpp
        ${SRC_FILES}
        ${LIB_FILES}
        )


target_link_libraries( ros_usbhid_interface usbLowLevelInterface -lpthread -lusb-1.0 -lrt ${catkin_LIBRARIES} )
