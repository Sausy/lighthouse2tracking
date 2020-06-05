// Generated by gencpp from file roboy_middleware_msgs/InverseKinematicsMultipleFramesRequest.msg
// DO NOT EDIT!


#ifndef ROBOY_MIDDLEWARE_MSGS_MESSAGE_INVERSEKINEMATICSMULTIPLEFRAMESREQUEST_H
#define ROBOY_MIDDLEWARE_MSGS_MESSAGE_INVERSEKINEMATICSMULTIPLEFRAMESREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <geometry_msgs/Pose.h>

namespace roboy_middleware_msgs
{
template <class ContainerAllocator>
struct InverseKinematicsMultipleFramesRequest_
{
  typedef InverseKinematicsMultipleFramesRequest_<ContainerAllocator> Type;

  InverseKinematicsMultipleFramesRequest_()
    : endeffector()
    , type(0)
    , target_frames()
    , poses()
    , weights()  {
    }
  InverseKinematicsMultipleFramesRequest_(const ContainerAllocator& _alloc)
    : endeffector(_alloc)
    , type(0)
    , target_frames(_alloc)
    , poses(_alloc)
    , weights(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _endeffector_type;
  _endeffector_type endeffector;

   typedef int8_t _type_type;
  _type_type type;

   typedef std::vector<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > , typename ContainerAllocator::template rebind<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::other >  _target_frames_type;
  _target_frames_type target_frames;

   typedef std::vector< ::geometry_msgs::Pose_<ContainerAllocator> , typename ContainerAllocator::template rebind< ::geometry_msgs::Pose_<ContainerAllocator> >::other >  _poses_type;
  _poses_type poses;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _weights_type;
  _weights_type weights;





  typedef boost::shared_ptr< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> const> ConstPtr;

}; // struct InverseKinematicsMultipleFramesRequest_

typedef ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<std::allocator<void> > InverseKinematicsMultipleFramesRequest;

typedef boost::shared_ptr< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest > InverseKinematicsMultipleFramesRequestPtr;
typedef boost::shared_ptr< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest const> InverseKinematicsMultipleFramesRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator1> & lhs, const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator2> & rhs)
{
  return lhs.endeffector == rhs.endeffector &&
    lhs.type == rhs.type &&
    lhs.target_frames == rhs.target_frames &&
    lhs.poses == rhs.poses &&
    lhs.weights == rhs.weights;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator1> & lhs, const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace roboy_middleware_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "a3d5e92ea119b29fcfb04845d2f5be78";
  }

  static const char* value(const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xa3d5e92ea119b29fULL;
  static const uint64_t static_value2 = 0xcfb04845d2f5be78ULL;
};

template<class ContainerAllocator>
struct DataType< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "roboy_middleware_msgs/InverseKinematicsMultipleFramesRequest";
  }

  static const char* value(const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"string endeffector\n"
"\n"
"int8 type\n"
"\n"
"string[] target_frames\n"
"\n"
"geometry_msgs/Pose[] poses\n"
"\n"
"float64[] weights\n"
"\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Pose\n"
"# A representation of pose in free space, composed of position and orientation. \n"
"Point position\n"
"Quaternion orientation\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Point\n"
"# This contains the position of a point in free space\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Quaternion\n"
"# This represents an orientation in free space in quaternion form.\n"
"\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"float64 w\n"
;
  }

  static const char* value(const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.endeffector);
      stream.next(m.type);
      stream.next(m.target_frames);
      stream.next(m.poses);
      stream.next(m.weights);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct InverseKinematicsMultipleFramesRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::roboy_middleware_msgs::InverseKinematicsMultipleFramesRequest_<ContainerAllocator>& v)
  {
    s << indent << "endeffector: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.endeffector);
    s << indent << "type: ";
    Printer<int8_t>::stream(s, indent + "  ", v.type);
    s << indent << "target_frames[]" << std::endl;
    for (size_t i = 0; i < v.target_frames.size(); ++i)
    {
      s << indent << "  target_frames[" << i << "]: ";
      Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.target_frames[i]);
    }
    s << indent << "poses[]" << std::endl;
    for (size_t i = 0; i < v.poses.size(); ++i)
    {
      s << indent << "  poses[" << i << "]: ";
      s << std::endl;
      s << indent;
      Printer< ::geometry_msgs::Pose_<ContainerAllocator> >::stream(s, indent + "    ", v.poses[i]);
    }
    s << indent << "weights[]" << std::endl;
    for (size_t i = 0; i < v.weights.size(); ++i)
    {
      s << indent << "  weights[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.weights[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROBOY_MIDDLEWARE_MSGS_MESSAGE_INVERSEKINEMATICSMULTIPLEFRAMESREQUEST_H