# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "message_runtime;roboy_middleware_msgs;common_utilities;robot_localization;xmlrpcpp;pcl_ros".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lPoseEstimatorSensorCloud;-lTransform;-lTriangulate;-lLighthouseEstimator;-lLighthouseSimulator;-lSensor;-lTrackedObject".split(';') if "-lPoseEstimatorSensorCloud;-lTransform;-lTriangulate;-lLighthouseEstimator;-lLighthouseSimulator;-lSensor;-lTrackedObject" != "" else []
PROJECT_NAME = "darkroom"
PROJECT_SPACE_DIR = "/home/userdev/Projects/lighthouse/lighthouse2sandbox/10_first_release/lighthouse2_tracking/install"
PROJECT_VERSION = "0.0.0"
