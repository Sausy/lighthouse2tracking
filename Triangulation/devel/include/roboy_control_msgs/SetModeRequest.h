// Generated by gencpp from file roboy_control_msgs/SetModeRequest.msg
// DO NOT EDIT!


#ifndef ROBOY_CONTROL_MSGS_MESSAGE_SETMODEREQUEST_H
#define ROBOY_CONTROL_MSGS_MESSAGE_SETMODEREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace roboy_control_msgs
{
template <class ContainerAllocator>
struct SetModeRequest_
{
  typedef SetModeRequest_<ContainerAllocator> Type;

  SetModeRequest_()
    : id(0)
    , mode(0)  {
    }
  SetModeRequest_(const ContainerAllocator& _alloc)
    : id(0)
    , mode(0)  {
  (void)_alloc;
    }



   typedef int8_t _id_type;
  _id_type id;

   typedef int8_t _mode_type;
  _mode_type mode;





  typedef boost::shared_ptr< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> const> ConstPtr;

}; // struct SetModeRequest_

typedef ::roboy_control_msgs::SetModeRequest_<std::allocator<void> > SetModeRequest;

typedef boost::shared_ptr< ::roboy_control_msgs::SetModeRequest > SetModeRequestPtr;
typedef boost::shared_ptr< ::roboy_control_msgs::SetModeRequest const> SetModeRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator1> & lhs, const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator2> & rhs)
{
  return lhs.id == rhs.id &&
    lhs.mode == rhs.mode;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator1> & lhs, const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace roboy_control_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "7911b8f814c694bc650d2e32c11b7cdf";
  }

  static const char* value(const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x7911b8f814c694bcULL;
  static const uint64_t static_value2 = 0x650d2e32c11b7cdfULL;
};

template<class ContainerAllocator>
struct DataType< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "roboy_control_msgs/SetModeRequest";
  }

  static const char* value(const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int8 id\n"
"int8 mode\n"
;
  }

  static const char* value(const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.id);
      stream.next(m.mode);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct SetModeRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::roboy_control_msgs::SetModeRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::roboy_control_msgs::SetModeRequest_<ContainerAllocator>& v)
  {
    s << indent << "id: ";
    Printer<int8_t>::stream(s, indent + "  ", v.id);
    s << indent << "mode: ";
    Printer<int8_t>::stream(s, indent + "  ", v.mode);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROBOY_CONTROL_MSGS_MESSAGE_SETMODEREQUEST_H