//#include "kindyn/vrpuppet.hpp"
#include <thread>
#include <roboy_middleware_msgs/MotorCommand.h>
#include <roboy_middleware_msgs/ControlMode.h>
#include <roboy_middleware_msgs/MotorConfigService.h>
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
#include <darkroom/Transform.hpp>
#include <boost/filesystem.hpp>
#include <common_utilities/rviz_visualization.hpp>
#include <sstream>
#include <string>

using namespace std;
using namespace boost::filesystem;




//public cardsflow::vrpuppet::Robot
class TrackerClass {
public:
    /**
     * Constructor
     * @param urdf path to urdf
     * @param cardsflow_xml path to cardsflow xml
     */
     TrackerClass();

     void correctPose(const roboy_middleware_msgs::LighthousePoseCorrection &msg);
     void interactiveMarkersFeedback(const visualization_msgs::InteractiveMarkerFeedback &msg);
     void resetLighthousePoses();
     void updateTrackedObjectInfo();
     void transformPublisher();
     bool addTrackedObject(const char *config_file_path);
     void showRays();

     void receiveSensorStatus(const roboy_middleware_msgs::DarkRoomStatus::ConstPtr &msg);


    ros::NodeHandlePtr nh; /// ROS nodehandle
    ros::Publisher motor_command; /// motor command publisher
    ros::Subscriber pose_correction_sub, interactive_marker_sub, sensor_status_sub;

    //ros::AsyncSpinner *spinner;

    boost::shared_ptr<ros::AsyncSpinner> spinner;


    boost::shared_ptr<tf::TransformListener> listener;
    vector<TrackedObjectPtr> trackedObjects;
    //vector<TrackedObjectInfo> trackedObjectsInfo;
    vector<LighthouseSimulatorPtr> lighthouseSimulator;

    bool publish_transform = true;
    tf::TransformBroadcaster tf_broadcaster;
    mutex mux;

    boost::shared_ptr<std::thread> transform_thread = nullptr, update_tracked_object_info_thread = nullptr;

    static tf::Transform lighthouse1, lighthouse2, tf_world, tf_map,
            simulated_object_lighthouse1, simulated_object_lighthouse2;
    vector<pair<LighthouseSimulatorPtr,LighthouseSimulatorPtr>> lighthouse_simulation;


    rviz_visualization rvizVis;

    float random_pose_x = 0, random_pose_y = 0, random_pose_z = 0, random_pose_roll = 0, random_pose_pitch = 0, random_pose_yaw = 0;

    bool random_pose = false;
    bool simulated = false;
    bool update_tracked_object_info = false;
    vector<string> trackedObjectsIDs;
};

tf::Transform TrackerClass::lighthouse1;
tf::Transform TrackerClass::lighthouse2;
tf::Transform TrackerClass::simulated_object_lighthouse1;
tf::Transform TrackerClass::simulated_object_lighthouse2;
tf::Transform TrackerClass::tf_world;
tf::Transform TrackerClass::tf_map;


TrackerClass::TrackerClass(){

    if (!ros::isInitialized()) {
        int argc = 0;
        char **argv = NULL;
        ros::init(argc, argv, "tracker");
    }
    nh = ros::NodeHandlePtr(new ros::NodeHandle);


    /*
    pose_correction_sub = nh->subscribe("/roboy/middleware/DarkRoom/LighthousePoseCorrection", 1,
                                        &TrackerClass::correctPose, this);
    sensor_sub = nh->subscribe("/roboy/middleware/DarkRoom/sensors", 1, &TrackerClass::receiveSensorData, this);

    statistics_sub = nh->subscribe("/roboy/middleware/DarkRoom/Statistics", 2, &TrackerClass::receiveStatistics, this);
    ootx_sub = nh->subscribe("/roboy/middleware/DarkRoom/ootx", 1, &TrackerClass::receiveOOTXData, this);
    aruco_pose_sub = nh->subscribe("/roboy/middleware/ArucoPose", 1, &TrackerClass::receiveArucoPose, this);
    */

    sensor_status_sub = nh->subscribe("/roboy/middleware/DarkRoom/status", 1, &TrackerClass::receiveSensorStatus, this);

    /*
    spinner = boost::shared_ptr<ros::AsyncSpinner>(new ros::AsyncSpinner(1));
    spinner->startObjectPoseEstimationSensorCloud();
    */
    //spinner = new ros::AsyncSpinner(0);
    spinner = boost::shared_ptr<ros::AsyncSpinner>(new ros::AsyncSpinner(1));
    spinner->start();

    resetLighthousePoses();

    publish_transform = true;
    transform_thread = boost::shared_ptr<std::thread>(new std::thread(&TrackerClass::transformPublisher, this));
    transform_thread->detach();

    update_tracked_object_info = true;
    update_tracked_object_info_thread = boost::shared_ptr<std::thread>(
            new std::thread(&TrackerClass::updateTrackedObjectInfo, this));
    update_tracked_object_info_thread->detach();

    //interactive_marker_sub = nh->subscribe("/interactive_markers/feedback", 1,
    //                                       &TrackerClass::interactiveMarkersFeedback, this);



    /*
    if (nh->hasParam("simulated")) {
        nh->getParam("simulated", simulated);
    }*/




    rvizVis.make6DofMarker(false, visualization_msgs::InteractiveMarkerControl::MOVE_ROTATE_3D, lighthouse1.getOrigin(),
                   true, 0.1, "world", "lighthouse1", "");
    rvizVis.make6DofMarker(false, visualization_msgs::InteractiveMarkerControl::MOVE_ROTATE_3D, lighthouse2.getOrigin(),
                   true, 0.1, "world", "lighthouse2", "");




    std::string msg;
    std::stringstream ss;
    //ss << ros::package::getPath("robots") << "/" << "exohaptic" << "/lighthouseSensors/left_link5.yaml";
    ss <<  "/usr/games/robots" << "/" << "exohaptic" << "/lighthouseSensors/base.yaml";
    msg = ss.str();

    addTrackedObject(msg.c_str());





    vector<string> joint_names;
    nh->getParam("joint_names", joint_names);


    showRays();
    //LighthouseEstimator::publishRays
    //publishRays

    ROS_INFO("Finished setup");
}

void TrackerClass::receiveSensorStatus(const roboy_middleware_msgs::DarkRoomStatus::ConstPtr &msg){
  int active_sensors = 0;
  for(auto status:msg->sensor_state){
      if(status == 1)
          active_sensors++;
  }
  ptrdiff_t pos = find(trackedObjectsIDs.begin(), trackedObjectsIDs.end(), msg->object_id) - trackedObjectsIDs.begin();
  if(pos<trackedObjects.size())
      trackedObjects[pos]->active_sensors = active_sensors;
}

void TrackerClass::correctPose(const roboy_middleware_msgs::LighthousePoseCorrection &msg) {
    mux.lock();
    tf::Transform tf;
    tf::transformMsgToTF(msg.tf, tf);
    if (msg.id == LIGHTHOUSE_A) {
        if (msg.type == 0) // relativ
            lighthouse1 = tf * lighthouse1;
        else    // absolut
            lighthouse1 = tf;
    } else {
        if (msg.type == 0) // relativ
            lighthouse2 = tf * lighthouse2;
        else    // absolut
            lighthouse2 = tf;
    }
    mux.unlock();
}

/*
void TrackerClass::transformPublisher() {
    ros::Rate rate(60);
    while (publish_transform && ros::ok()) {
        tf_broadcaster.sendTransform(
                tf::StampedTransform(lighthouse1, ros::Time::now(), "world", "lighthouse1"));
        tf_broadcaster.sendTransform(
                tf::StampedTransform(lighthouse2, ros::Time::now(), "world", "lighthouse2"));
        rate.sleep();
    }
}

*/

void TrackerClass::interactiveMarkersFeedback(const visualization_msgs::InteractiveMarkerFeedback &msg) {
    mux.lock();
    tf::Vector3 position(msg.pose.position.x, msg.pose.position.y, msg.pose.position.z);
    tf::Quaternion orientation(msg.pose.orientation.x, msg.pose.orientation.y,
                               msg.pose.orientation.z, msg.pose.orientation.w);
    if (strcmp(msg.marker_name.c_str(), "lighthouse1") == 0) {
        lighthouse1.setOrigin(position);
        lighthouse1.setRotation(orientation);
    } else if (strcmp(msg.marker_name.c_str(), "lighthouse2") == 0) {
        lighthouse2.setOrigin(position);
        lighthouse2.setRotation(orientation);
    } else if (strcmp(msg.marker_name.c_str(), "trackedObject") == 0) {
        for (auto &object:trackedObjects) {
            object->pose.setOrigin(position);
            object->pose.setRotation(orientation);
        }
    }
    mux.unlock();
}


void TrackerClass::resetLighthousePoses() {
    ROS_DEBUG("reset lighthouse poses");
    tf_world.setOrigin(tf::Vector3(0, 0, 0));
    tf_map.setOrigin(tf::Vector3(0, 0, 0));
    tf::Quaternion quat;
    quat.setRPY(0, 0, 0);
    tf_world.setRotation(quat);
    tf_map.setRotation(quat);
    bool ok;
    quat.setRPY(0, 0, 0);
    lighthouse1.setRotation(quat);
//    lighthouse1.setOrigin(tf::Vector3(1, -2, 0));
    lighthouse1.setOrigin(tf::Vector3(0, -1, 0));
    lighthouse2.setRotation(quat);
//    lighthouse2.setOrigin(tf::Vector3(-1, -2, 0));
    lighthouse2.setOrigin(tf::Vector3(-0.825, -1, 0));
}


void TrackerClass::updateTrackedObjectInfo() {
    ros::Rate rate(1);
    while (update_tracked_object_info) {
        mux.lock();
        for (int i = 0; i < trackedObjects.size(); i++) {
            char str[100];
            sprintf(str, "%d/%d", trackedObjects[i]->active_sensors, (int) trackedObjects[i]->sensors.size());
            //trackedObjectsInfo[i].activeSensors->setText(str);
        }
        mux.unlock();
        rate.sleep();
    }
}


void TrackerClass::transformPublisher() {
    ros::Rate rate(30);
    Vector3d pos(0,0,0), vel(0.3,0.3,0.3);
    double boundary = 0.5;
    while (publish_transform) {
        mux.lock();
        tf_broadcaster.sendTransform(tf::StampedTransform(lighthouse1, ros::Time::now(), "world", "lighthouse1"));
        tf_broadcaster.sendTransform(tf::StampedTransform(lighthouse2, ros::Time::now(), "world", "lighthouse2"));
            if (random_pose) {
                // randomly moves all objects
                for (auto &object:trackedObjects) {
                    object->pose.setOrigin( tf::Vector3(pos(0),pos(1),pos(2)));
                    tf::Quaternion q(0, 0, 0, 1);
                    q.setRPY(random_pose_roll, random_pose_pitch, random_pose_yaw);
                    object->pose.setRotation(q);

                    pos(0) += vel(0)*1/1000.0+(rand()/(double)RAND_MAX-0.5)*0.001;
                    pos(1) += vel(1)*1/1000.0+(rand()/(double)RAND_MAX-0.5)*0.001;
                    pos(2) += vel(2)*1/1000.0+(rand()/(double)RAND_MAX-0.5)*0.001;
                    random_pose_roll += rand()/(double)RAND_MAX*1/1000.0;
                    random_pose_pitch += rand()/(double)RAND_MAX*1/1000.0;
                    random_pose_yaw += rand()/(double)RAND_MAX*1/1000.0;

                    if(pos(0)>boundary || pos(0)<-boundary)
                        vel(0) = -(vel(0)+(rand()/(double)RAND_MAX-0.5));
                    if(pos(1)>boundary || pos(1)<-boundary)
                        vel(1) = -(vel(1)+(rand()/(double)RAND_MAX-0.5));
                    if(pos(2)>boundary || pos(2)<-boundary)
                        vel(2) = -(vel(2)+(rand()/(double)RAND_MAX-0.5));
//
                }
            }
            for (auto &object:trackedObjects) {
                tf_broadcaster.sendTransform(tf::StampedTransform(object->pose, ros::Time::now(),
                                                                  "world", object->name.c_str()));
            }
//        }
        mux.unlock();
        rate.sleep();
    }
}


bool TrackerClass::addTrackedObject(const char *config_file_path) {
    mux.lock();
    TrackedObjectPtr newObject = TrackedObjectPtr(new TrackedObject(nh));


    if (!newObject->init(config_file_path))
        return false;
    if (simulated) {
        pair<LighthouseSimulatorPtr, LighthouseSimulatorPtr> simulation;

        vector<fs::path> parts = {config_file_path};

        simulation.first.reset(new LighthouseSimulator(LIGHTHOUSE_A, parts));
        simulation.second.reset(new LighthouseSimulator(LIGHTHOUSE_B, parts));
        simulation.first->startSensorPublisher();
        simulation.second->startSensorPublisher();
        lighthouse_simulation.push_back(simulation);
    }


    ROS_DEBUG_STREAM("adding tracked object " << config_file_path);
    trackedObjects.push_back(newObject);
    trackedObjectsIDs.push_back(newObject->objectID);
    //object_counter++;

    //TrackedObjectInfo info;


    //trackedObjectsInfo.push_back(info);

    mux.unlock();

    return true;
}


void TrackerClass::showRays() {
    ROS_DEBUG("show rays clicked");

    for (uint i = 0; i < trackedObjects.size(); i++) {
        trackedObjects[i]->mux.lock();

        ROS_INFO("starting rays thread i:%d", i);
        trackedObjects[i]->rays = true;
        trackedObjects[i]->rays_thread = boost::shared_ptr<boost::thread>(
                new boost::thread(
                        [this, i]() { this->trackedObjects[i]->publishRays(); }
                ));
        trackedObjects[i]->rays_thread->detach();

        trackedObjects[i]->mux.unlock();
    }
}

int main(int argc, char *argv[]) {
    if (!ros::isInitialized()) {
        int argc = 0;
        char **argv = NULL;
        ros::init(argc, argv, "lighthouse_tracker");
    }
    ros::NodeHandle nh;



  /*  if (argc < 2 ){
      ROS_FATAL("USAGE: <programm> sensor_config.xml");
      return 0;
    }*/

    /*string urdf, cardsflow_xml;
    if(nh.hasParam("urdf_file_path") && nh.hasParam("cardsflow_xml")) {
        nh.getParam("urdf_file_path", urdf);
        nh.getParam("cardsflow_xml", cardsflow_xml);
    }else {
        ROS_FATAL("USAGE: rosrun kindyn test_robot path_to_urdf path_to_viapoints_xml");
        return 1;
    }
    ROS_INFO("\nurdf file path: %s\ncardsflow_xml %s", urdf.c_str(), cardsflow_xml.c_str());
    */

    //string s = argv[2];




    TrackerClass robot;

    /*ros::Publisher pubHandl_Sensor;
    pubHandl_Sensor = nh.advertise<roboy_middleware_msgs::DarkRoomSensorV2>("/roboy/middleware/DarkRoom/sensorsLH2", 1);
    roboy_middleware_msgs::DarkRoomSensorV2 ros_msg;*/

    ros::Rate rate(30);
    while(ros::ok()){
        //robot.read();
        //robot.write();
        ros::spinOnce();
        rate.sleep();

        /*for (size_t i = 0; i < 6; i++) {
          ros_msg.object_id = "1";
          ros_msg.base = 1;
          ros_msg.SensorID =  i;
          ros_msg.elevation = 0.5;
          ros_msg.azimuth = 0.6;
          pubHandl_Sensor.publish(ros_msg);

        }*/

        //robot.showRays();

    }

    ROS_INFO("TERMINATING...");

    return 0;
}
