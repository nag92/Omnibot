; Auto-generated. Do not edit!


(cl:in-package omni_shot-msg)


;//! \htmlinclude trajectory_poly.msg.html

(cl:defclass <trajectory_poly> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (linear
    :reader linear
    :initarg :linear
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray))
   (angular
    :reader angular
    :initarg :angular
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray))
   (time
    :reader time
    :initarg :time
    :type std_msgs-msg:Float32
    :initform (cl:make-instance 'std_msgs-msg:Float32))
   (theta
    :reader theta
    :initarg :theta
    :type std_msgs-msg:Float32
    :initform (cl:make-instance 'std_msgs-msg:Float32)))
)

(cl:defclass trajectory_poly (<trajectory_poly>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <trajectory_poly>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'trajectory_poly)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omni_shot-msg:<trajectory_poly> is deprecated: use omni_shot-msg:trajectory_poly instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <trajectory_poly>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:header-val is deprecated.  Use omni_shot-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'linear-val :lambda-list '(m))
(cl:defmethod linear-val ((m <trajectory_poly>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:linear-val is deprecated.  Use omni_shot-msg:linear instead.")
  (linear m))

(cl:ensure-generic-function 'angular-val :lambda-list '(m))
(cl:defmethod angular-val ((m <trajectory_poly>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:angular-val is deprecated.  Use omni_shot-msg:angular instead.")
  (angular m))

(cl:ensure-generic-function 'time-val :lambda-list '(m))
(cl:defmethod time-val ((m <trajectory_poly>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:time-val is deprecated.  Use omni_shot-msg:time instead.")
  (time m))

(cl:ensure-generic-function 'theta-val :lambda-list '(m))
(cl:defmethod theta-val ((m <trajectory_poly>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:theta-val is deprecated.  Use omni_shot-msg:theta instead.")
  (theta m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <trajectory_poly>) ostream)
  "Serializes a message object of type '<trajectory_poly>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'linear) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'angular) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'time) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'theta) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <trajectory_poly>) istream)
  "Deserializes a message object of type '<trajectory_poly>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'linear) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'angular) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'time) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'theta) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<trajectory_poly>)))
  "Returns string type for a message object of type '<trajectory_poly>"
  "omni_shot/trajectory_poly")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'trajectory_poly)))
  "Returns string type for a message object of type 'trajectory_poly"
  "omni_shot/trajectory_poly")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<trajectory_poly>)))
  "Returns md5sum for a message object of type '<trajectory_poly>"
  "8942c7dfe1dfeaa3e61836ef4edc7e77")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'trajectory_poly)))
  "Returns md5sum for a message object of type 'trajectory_poly"
  "8942c7dfe1dfeaa3e61836ef4edc7e77")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<trajectory_poly>)))
  "Returns full string definition for message of type '<trajectory_poly>"
  (cl:format cl:nil "Header header~%std_msgs/Float32MultiArray linear~%std_msgs/Float32MultiArray angular~%std_msgs/Float32 time~%std_msgs/Float32 theta~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding bytes at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%================================================================================~%MSG: std_msgs/Float32~%float32 data~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'trajectory_poly)))
  "Returns full string definition for message of type 'trajectory_poly"
  (cl:format cl:nil "Header header~%std_msgs/Float32MultiArray linear~%std_msgs/Float32MultiArray angular~%std_msgs/Float32 time~%std_msgs/Float32 theta~%~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding bytes at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%================================================================================~%MSG: std_msgs/Float32~%float32 data~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <trajectory_poly>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'linear))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'angular))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'time))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'theta))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <trajectory_poly>))
  "Converts a ROS message object to a list"
  (cl:list 'trajectory_poly
    (cl:cons ':header (header msg))
    (cl:cons ':linear (linear msg))
    (cl:cons ':angular (angular msg))
    (cl:cons ':time (time msg))
    (cl:cons ':theta (theta msg))
))
