// Generated by gencpp from file roboy_middleware_msgs/XL320Request.msg
// DO NOT EDIT!


#ifndef ROBOY_MIDDLEWARE_MSGS_MESSAGE_XL320REQUEST_H
#define ROBOY_MIDDLEWARE_MSGS_MESSAGE_XL320REQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace roboy_middleware_msgs
{
template <class ContainerAllocator>
struct XL320Request_
{
  typedef XL320Request_<ContainerAllocator> Type;

  XL320Request_()
    : type(false)
    , motor(0)
    , address(0)
    , value(0)  {
    }
  XL320Request_(const ContainerAllocator& _alloc)
    : type(false)
    , motor(0)
    , address(0)
    , value(0)  {
  (void)_alloc;
    }



   typedef uint8_t _type_type;
  _type_type type;

   typedef uint8_t _motor_type;
  _motor_type motor;

   typedef uint8_t _address_type;
  _address_type address;

   typedef int16_t _value_type;
  _value_type value;





  typedef boost::shared_ptr< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> const> ConstPtr;

}; // struct XL320Request_

typedef ::roboy_middleware_msgs::XL320Request_<std::allocator<void> > XL320Request;

typedef boost::shared_ptr< ::roboy_middleware_msgs::XL320Request > XL320RequestPtr;
typedef boost::shared_ptr< ::roboy_middleware_msgs::XL320Request const> XL320RequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator1> & lhs, const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator2> & rhs)
{
  return lhs.type == rhs.type &&
    lhs.motor == rhs.motor &&
    lhs.address == rhs.address &&
    lhs.value == rhs.value;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator1> & lhs, const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace roboy_middleware_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >
{
  static const char* value()
  {
    return "d0b3c3391dc54fe3a913cbf9ecf628c0";
  }

  static const char* value(const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xd0b3c3391dc54fe3ULL;
  static const uint64_t static_value2 = 0xa913cbf9ecf628c0ULL;
};

template<class ContainerAllocator>
struct DataType< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >
{
  static const char* value()
  {
    return "roboy_middleware_msgs/XL320Request";
  }

  static const char* value(const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
"bool type\n"
"uint8 motor\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"uint8 address\n"
"int16 value\n"
;
  }

  static const char* value(const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.type);
      stream.next(m.motor);
      stream.next(m.address);
      stream.next(m.value);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct XL320Request_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::roboy_middleware_msgs::XL320Request_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::roboy_middleware_msgs::XL320Request_<ContainerAllocator>& v)
  {
    s << indent << "type: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.type);
    s << indent << "motor: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.motor);
    s << indent << "address: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.address);
    s << indent << "value: ";
    Printer<int16_t>::stream(s, indent + "  ", v.value);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROBOY_MIDDLEWARE_MSGS_MESSAGE_XL320REQUEST_H