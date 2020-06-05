// Generated by gencpp from file roboy_cognition_msgs/AssertPropertyRequest.msg
// DO NOT EDIT!


#ifndef ROBOY_COGNITION_MSGS_MESSAGE_ASSERTPROPERTYREQUEST_H
#define ROBOY_COGNITION_MSGS_MESSAGE_ASSERTPROPERTYREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace roboy_cognition_msgs
{
template <class ContainerAllocator>
struct AssertPropertyRequest_
{
  typedef AssertPropertyRequest_<ContainerAllocator> Type;

  AssertPropertyRequest_()
    : object()
    , property()
    , instance()  {
    }
  AssertPropertyRequest_(const ContainerAllocator& _alloc)
    : object(_alloc)
    , property(_alloc)
    , instance(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _object_type;
  _object_type object;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _property_type;
  _property_type property;

   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _instance_type;
  _instance_type instance;





  typedef boost::shared_ptr< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> const> ConstPtr;

}; // struct AssertPropertyRequest_

typedef ::roboy_cognition_msgs::AssertPropertyRequest_<std::allocator<void> > AssertPropertyRequest;

typedef boost::shared_ptr< ::roboy_cognition_msgs::AssertPropertyRequest > AssertPropertyRequestPtr;
typedef boost::shared_ptr< ::roboy_cognition_msgs::AssertPropertyRequest const> AssertPropertyRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator1> & lhs, const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator2> & rhs)
{
  return lhs.object == rhs.object &&
    lhs.property == rhs.property &&
    lhs.instance == rhs.instance;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator1> & lhs, const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace roboy_cognition_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsFixedSize< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "6b9f7854589f70a806316754de9a72fb";
  }

  static const char* value(const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x6b9f7854589f70a8ULL;
  static const uint64_t static_value2 = 0x06316754de9a72fbULL;
};

template<class ContainerAllocator>
struct DataType< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "roboy_cognition_msgs/AssertPropertyRequest";
  }

  static const char* value(const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string object\n"
"string property\n"
"string instance\n"
;
  }

  static const char* value(const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.object);
      stream.next(m.property);
      stream.next(m.instance);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct AssertPropertyRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::roboy_cognition_msgs::AssertPropertyRequest_<ContainerAllocator>& v)
  {
    s << indent << "object: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.object);
    s << indent << "property: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.property);
    s << indent << "instance: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.instance);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROBOY_COGNITION_MSGS_MESSAGE_ASSERTPROPERTYREQUEST_H