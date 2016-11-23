// Generated by gencpp from file omni_shot/motors.msg
// DO NOT EDIT!


#ifndef OMNI_SHOT_MESSAGE_MOTORS_H
#define OMNI_SHOT_MESSAGE_MOTORS_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <std_msgs/Header.h>

namespace omni_shot
{
template <class ContainerAllocator>
struct motors_
{
  typedef motors_<ContainerAllocator> Type;

  motors_()
    : header()
    , m1(0.0)
    , m2(0.0)
    , m3(0.0)
    , m4(0.0)  {
    }
  motors_(const ContainerAllocator& _alloc)
    : header(_alloc)
    , m1(0.0)
    , m2(0.0)
    , m3(0.0)
    , m4(0.0)  {
  (void)_alloc;
    }



   typedef  ::std_msgs::Header_<ContainerAllocator>  _header_type;
  _header_type header;

   typedef float _m1_type;
  _m1_type m1;

   typedef float _m2_type;
  _m2_type m2;

   typedef float _m3_type;
  _m3_type m3;

   typedef float _m4_type;
  _m4_type m4;




  typedef boost::shared_ptr< ::omni_shot::motors_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::omni_shot::motors_<ContainerAllocator> const> ConstPtr;

}; // struct motors_

typedef ::omni_shot::motors_<std::allocator<void> > motors;

typedef boost::shared_ptr< ::omni_shot::motors > motorsPtr;
typedef boost::shared_ptr< ::omni_shot::motors const> motorsConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::omni_shot::motors_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::omni_shot::motors_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace omni_shot

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': True}
// {'geometry_msgs': ['/opt/ros/indigo/share/geometry_msgs/cmake/../msg'], 'std_msgs': ['/opt/ros/indigo/share/std_msgs/cmake/../msg'], 'omni_shot': ['/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::omni_shot::motors_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::omni_shot::motors_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::omni_shot::motors_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::omni_shot::motors_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::omni_shot::motors_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::omni_shot::motors_<ContainerAllocator> const>
  : TrueType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::omni_shot::motors_<ContainerAllocator> >
{
  static const char* value()
  {
    return "492dbdb298ee2a5efd67096e7383ada3";
  }

  static const char* value(const ::omni_shot::motors_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x492dbdb298ee2a5eULL;
  static const uint64_t static_value2 = 0xfd67096e7383ada3ULL;
};

template<class ContainerAllocator>
struct DataType< ::omni_shot::motors_<ContainerAllocator> >
{
  static const char* value()
  {
    return "omni_shot/motors";
  }

  static const char* value(const ::omni_shot::motors_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::omni_shot::motors_<ContainerAllocator> >
{
  static const char* value()
  {
    return "std_msgs/Header header\n\
float32 m1\n\
float32 m2\n\
float32 m3\n\
float32 m4\n\
================================================================================\n\
MSG: std_msgs/Header\n\
# Standard metadata for higher-level stamped data types.\n\
# This is generally used to communicate timestamped data \n\
# in a particular coordinate frame.\n\
# \n\
# sequence ID: consecutively increasing ID \n\
uint32 seq\n\
#Two-integer timestamp that is expressed as:\n\
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n\
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n\
# time-handling sugar is provided by the client library\n\
time stamp\n\
#Frame this data is associated with\n\
# 0: no frame\n\
# 1: global frame\n\
string frame_id\n\
";
  }

  static const char* value(const ::omni_shot::motors_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::omni_shot::motors_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.header);
      stream.next(m.m1);
      stream.next(m.m2);
      stream.next(m.m3);
      stream.next(m.m4);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct motors_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::omni_shot::motors_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::omni_shot::motors_<ContainerAllocator>& v)
  {
    s << indent << "header: ";
    s << std::endl;
    Printer< ::std_msgs::Header_<ContainerAllocator> >::stream(s, indent + "  ", v.header);
    s << indent << "m1: ";
    Printer<float>::stream(s, indent + "  ", v.m1);
    s << indent << "m2: ";
    Printer<float>::stream(s, indent + "  ", v.m2);
    s << indent << "m3: ";
    Printer<float>::stream(s, indent + "  ", v.m3);
    s << indent << "m4: ";
    Printer<float>::stream(s, indent + "  ", v.m4);
  }
};

} // namespace message_operations
} // namespace ros

#endif // OMNI_SHOT_MESSAGE_MOTORS_H
