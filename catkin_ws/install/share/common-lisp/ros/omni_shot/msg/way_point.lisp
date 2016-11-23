; Auto-generated. Do not edit!


(cl:in-package omni_shot-msg)


;//! \htmlinclude way_point.msg.html

(cl:defclass <way_point> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (velocity
    :reader velocity
    :initarg :velocity
    :type geometry_msgs-msg:Twist
    :initform (cl:make-instance 'geometry_msgs-msg:Twist))
   (time
    :reader time
    :initarg :time
    :type cl:float
    :initform 0.0))
)

(cl:defclass way_point (<way_point>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <way_point>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'way_point)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omni_shot-msg:<way_point> is deprecated: use omni_shot-msg:way_point instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <way_point>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:header-val is deprecated.  Use omni_shot-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <way_point>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:pose-val is deprecated.  Use omni_shot-msg:pose instead.")
  (pose m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <way_point>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:velocity-val is deprecated.  Use omni_shot-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'time-val :lambda-list '(m))
(cl:defmethod time-val ((m <way_point>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:time-val is deprecated.  Use omni_shot-msg:time instead.")
  (time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <way_point>) ostream)
  "Serializes a message object of type '<way_point>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <way_point>) istream)
  "Deserializes a message object of type '<way_point>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'time) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<way_point>)))
  "Returns string type for a message object of type '<way_point>"
  "omni_shot/way_point")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'way_point)))
  "Returns string type for a message object of type 'way_point"
  "omni_shot/way_point")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<way_point>)))
  "Returns md5sum for a message object of type '<way_point>"
  "7a2108d72ba8b9d071bebbbcd7bc09af")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'way_point)))
  "Returns md5sum for a message object of type 'way_point"
  "7a2108d72ba8b9d071bebbbcd7bc09af")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<way_point>)))
  "Returns full string definition for message of type '<way_point>"
  (cl:format cl:nil "Header header~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%float32 time~%~%	~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'way_point)))
  "Returns full string definition for message of type 'way_point"
  (cl:format cl:nil "Header header~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%float32 time~%~%	~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <way_point>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <way_point>))
  "Converts a ROS message object to a list"
  (cl:list 'way_point
    (cl:cons ':header (header msg))
    (cl:cons ':pose (pose msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':time (time msg))
))
