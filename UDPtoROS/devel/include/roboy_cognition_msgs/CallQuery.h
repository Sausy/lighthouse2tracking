// Generated by gencpp from file roboy_cognition_msgs/CallQuery.msg
// DO NOT EDIT!


#ifndef ROBOY_COGNITION_MSGS_MESSAGE_CALLQUERY_H
#define ROBOY_COGNITION_MSGS_MESSAGE_CALLQUERY_H

#include <ros/service_traits.h>


#include <roboy_cognition_msgs/CallQueryRequest.h>
#include <roboy_cognition_msgs/CallQueryResponse.h>


namespace roboy_cognition_msgs
{

struct CallQuery
{

typedef CallQueryRequest Request;
typedef CallQueryResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct CallQuery
} // namespace roboy_cognition_msgs


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::roboy_cognition_msgs::CallQuery > {
  static const char* value()
  {
    return "5404d412a67bedecd70067ff4e66aff8";
  }

  static const char* value(const ::roboy_cognition_msgs::CallQuery&) { return value(); }
};

template<>
struct DataType< ::roboy_cognition_msgs::CallQuery > {
  static const char* value()
  {
    return "roboy_cognition_msgs/CallQuery";
  }

  static const char* value(const ::roboy_cognition_msgs::CallQuery&) { return value(); }
};


// service_traits::MD5Sum< ::roboy_cognition_msgs::CallQueryRequest> should match
// service_traits::MD5Sum< ::roboy_cognition_msgs::CallQuery >
template<>
struct MD5Sum< ::roboy_cognition_msgs::CallQueryRequest>
{
  static const char* value()
  {
    return MD5Sum< ::roboy_cognition_msgs::CallQuery >::value();
  }
  static const char* value(const ::roboy_cognition_msgs::CallQueryRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::roboy_cognition_msgs::CallQueryRequest> should match
// service_traits::DataType< ::roboy_cognition_msgs::CallQuery >
template<>
struct DataType< ::roboy_cognition_msgs::CallQueryRequest>
{
  static const char* value()
  {
    return DataType< ::roboy_cognition_msgs::CallQuery >::value();
  }
  static const char* value(const ::roboy_cognition_msgs::CallQueryRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::roboy_cognition_msgs::CallQueryResponse> should match
// service_traits::MD5Sum< ::roboy_cognition_msgs::CallQuery >
template<>
struct MD5Sum< ::roboy_cognition_msgs::CallQueryResponse>
{
  static const char* value()
  {
    return MD5Sum< ::roboy_cognition_msgs::CallQuery >::value();
  }
  static const char* value(const ::roboy_cognition_msgs::CallQueryResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::roboy_cognition_msgs::CallQueryResponse> should match
// service_traits::DataType< ::roboy_cognition_msgs::CallQuery >
template<>
struct DataType< ::roboy_cognition_msgs::CallQueryResponse>
{
  static const char* value()
  {
    return DataType< ::roboy_cognition_msgs::CallQuery >::value();
  }
  static const char* value(const ::roboy_cognition_msgs::CallQueryResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ROBOY_COGNITION_MSGS_MESSAGE_CALLQUERY_H