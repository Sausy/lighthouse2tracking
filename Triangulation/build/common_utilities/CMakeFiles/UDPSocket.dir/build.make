# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build

# Include any dependencies generated for this target.
include common_utilities/CMakeFiles/UDPSocket.dir/depend.make

# Include the progress variables for this target.
include common_utilities/CMakeFiles/UDPSocket.dir/progress.make

# Include the compile flags for this target's objects.
include common_utilities/CMakeFiles/UDPSocket.dir/flags.make

common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o: common_utilities/CMakeFiles/UDPSocket.dir/flags.make
common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o: /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src/common_utilities/src/UDPSocket.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o"
	cd /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/common_utilities && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o -c /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src/common_utilities/src/UDPSocket.cpp

common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.i"
	cd /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/common_utilities && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src/common_utilities/src/UDPSocket.cpp > CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.i

common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.s"
	cd /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/common_utilities && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src/common_utilities/src/UDPSocket.cpp -o CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.s

common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o.requires:

.PHONY : common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o.requires

common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o.provides: common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o.requires
	$(MAKE) -f common_utilities/CMakeFiles/UDPSocket.dir/build.make common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o.provides.build
.PHONY : common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o.provides

common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o.provides.build: common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o


# Object files for target UDPSocket
UDPSocket_OBJECTS = \
"CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o"

# External object files for target UDPSocket
UDPSocket_EXTERNAL_OBJECTS =

/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: common_utilities/CMakeFiles/UDPSocket.dir/build.make
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libroslib.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/librospack.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libpython2.7.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libboost_program_options.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libtinyxml2.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libinteractive_markers.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libtf_conversions.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libkdl_conversions.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/liborocos-kdl.so.1.4.0
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libtf.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libtf2_ros.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libactionlib.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libmessage_filters.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libtf2.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libroscpp.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libboost_filesystem.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/librosconsole.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/librosconsole_log4cxx.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/librosconsole_backend_interface.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/liblog4cxx.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libboost_regex.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libxmlrpcpp.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libroscpp_serialization.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/librostime.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /opt/ros/melodic/lib/libcpp_common.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libboost_system.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libboost_thread.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libboost_chrono.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libboost_date_time.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libboost_atomic.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libpthread.so
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: /usr/lib/aarch64-linux-gnu/libconsole_bridge.so.0.4
/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so: common_utilities/CMakeFiles/UDPSocket.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so"
	cd /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/common_utilities && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/UDPSocket.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
common_utilities/CMakeFiles/UDPSocket.dir/build: /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/devel/lib/libUDPSocket.so

.PHONY : common_utilities/CMakeFiles/UDPSocket.dir/build

common_utilities/CMakeFiles/UDPSocket.dir/requires: common_utilities/CMakeFiles/UDPSocket.dir/src/UDPSocket.cpp.o.requires

.PHONY : common_utilities/CMakeFiles/UDPSocket.dir/requires

common_utilities/CMakeFiles/UDPSocket.dir/clean:
	cd /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/common_utilities && $(CMAKE_COMMAND) -P CMakeFiles/UDPSocket.dir/cmake_clean.cmake
.PHONY : common_utilities/CMakeFiles/UDPSocket.dir/clean

common_utilities/CMakeFiles/UDPSocket.dir/depend:
	cd /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/src/common_utilities /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/common_utilities /home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/build/common_utilities/CMakeFiles/UDPSocket.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : common_utilities/CMakeFiles/UDPSocket.dir/depend
