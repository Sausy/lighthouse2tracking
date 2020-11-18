/*
    BSD 3-Clause License

    Copyright (c) 2018, Roboy
            All rights reserved.

    Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

    * Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
            IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
    DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
            FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
            DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
            SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
            CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
    OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

    author: Simon Trendel ( simon.trendel@tum.de ), 2018
    description: rqt gui plugin for darkroom lighthouse tracking
*/

#pragma once

#ifndef Q_MOC_RUN

#include <ros/ros.h>
#include <ros/package.h>

#include <thread>
#include <roboy_middleware_msgs/LighthousePoseCorrection.h>
#include <roboy_middleware_msgs/ArucoPose.h>
#include <roboy_middleware_msgs/DarkRoom.h>
#include <roboy_middleware_msgs/DarkRoomStatistics.h>
#include <roboy_middleware_msgs/DarkRoomStatus.h>
#include <roboy_middleware_msgs/DarkRoomOOTX.h>
#include <common_utilities/CommonDefinitions.h>
#include <roboy_control_msgs/SetControllerParameters.h>
#include <std_srvs/Empty.h>
#include <tf/tf.h>
#include <tf/transform_listener.h>
#include <tf/transform_broadcaster.h>
#include <darkroom/TrackedObject.hpp>
#include <darkroom/LighthouseSimulator.hpp>
#include <boost/filesystem.hpp>
#include <common_utilities/rviz_visualization.hpp>
#include <map>

#endif

using namespace std;

class RoboyDarkRoom
        : public rqt_gui_cpp::Plugin, rviz_visualization, DarkRoom::Transform {
    Q_OBJECT
public:
    RoboyDarkRoom();
    ~RoboyDarkRoom();

    void init();


public Q_SLOTS:

    void connectObject();
    /**
     * Clears all visualizations in rviz
     */
    void clearAll();
    /**
     * Resets the lighthouse poses to slider values
     */
    void resetLighthousePoses();
    /**
     * Toggles recording sensor values for all tracked objects
     */
    void record();
    /**
     * Toggles visualization of lighthouse rays
     */
    void showRays();


private:
    int counter = 0;
    ros::NodeHandlePtr nh;
    boost::shared_ptr<ros::AsyncSpinner> spinner;
    boost::shared_ptr<std::thread> transform_thread = nullptr, update_tracked_object_info_thread = nullptr;
    ros::Subscriber pose_correction_sub, interactive_marker_sub, sensor_sub, sensor_status_sub, statistics_sub, ootx_sub, aruco_pose_sub;
    tf::TransformListener tf_listener;
    tf::TransformBroadcaster tf_broadcaster;
    static tf::Transform lighthouse1, lighthouse2, tf_world, tf_map,
            simulated_object_lighthouse1, simulated_object_lighthouse2, imu_foo;
    atomic<bool> publish_transform, update_tracked_object_info;
    int object_counter = 0, values_in_plot = 300, message_counter[4] = {0}, message_counter_statistics[2] = {0};
    vector<TrackedObjectPtr> trackedObjects;
    vector<string> trackedObjectsIDs;
    SharedMutex mux;

    bool simulate = false;
    float random_pose_x = 0, random_pose_y = 0, random_pose_z = 0, random_pose_roll = 0, random_pose_pitch = 0, random_pose_yaw = 0;
    vector<pair<LighthouseSimulatorPtr,LighthouseSimulatorPtr>> lighthouse_simulation;

    struct TrackedObjectInfo{
        QWidget *widget;
        QCheckBox *selected;
        QLabel* name;
        QLabel* activeSensors;
    };
    vector<TrackedObjectInfo> trackedObjectsInfo;
    map<int,Vector3d> aruco_position_mean;
    map<int,Vector3d> aruco_position_variance;
    map<int,long> receive_counter;
    LighthouseCalibration calibration[2][2];
};
