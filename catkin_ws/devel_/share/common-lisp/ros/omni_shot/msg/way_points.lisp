; Auto-generated. Do not edit!


(cl:in-package omni_shot-msg)


;//! \htmlinclude way_points.msg.html

(cl:defclass <way_points> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (path
    :reader path
    :initarg :path
    :type (cl:vector omni_shot-msg:way_point)
   :initform (cl:make-array 0 :element-type 'omni_shot-msg:way_point :initial-element (cl:make-instance 'omni_shot-msg:way_point)))
   (sample
    :reader sample
    :initarg :sample
    :type cl:fixnum
    :initform 0))
)

(cl:defclass way_points (<way_points>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <way_points>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'way_points)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omni_shot-msg:<way_points> is deprecated: use omni_shot-msg:way_points instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <way_points>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:header-val is deprecated.  Use omni_shot-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'path-val :lambda-list '(m))
(cl:defmethod path-val ((m <way_points>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:path-val is deprecated.  Use omni_shot-msg:path instead.")
  (path m))

(cl:ensure-generic-function 'sample-val :lambda-list '(m))
(cl:defmethod sample-val ((m <way_points>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:sample-val is deprecated.  Use omni_shot-msg:sample instead.")
  (sample m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <way_points>) ostream)
  "Serializes a message object of type '<way_points>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'path))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'path))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'sample)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <way_points>) istream)
  "Deserializes a message object of type '<way_points>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'path) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'path)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'omni_shot-msg:way_point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'sample)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<way_points>)))
  "Returns string type for a message object of type '<way_points>"
  "omni_shot/way_points")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'way_points)))
  "Returns string type for a message object of type 'way_points"
  "omni_shot/way_points")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<way_points>)))
  "Returns md5sum for a message object of type '<way_points>"
  "1847c8a7cc942338a5e4611b252b7e5a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'way_points)))
  "Returns md5sum for a message object of type 'way_points"
  "1847c8a7cc942338a5e4611b252b7e5a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<way_points>)))
  "Returns full string definition for message of type '<way_points>"
  (cl:format cl:nil "Header header~%omni_shot/way_point[] path~%uint8 sample~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: omni_shot/way_point~%Header header~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%float32 time~%~%	~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'way_points)))
  "Returns full string definition for message of type 'way_points"
  (cl:format cl:nil "Header header~%omni_shot/way_point[] path~%uint8 sample~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: omni_shot/way_point~%Header header~%geometry_msgs/Pose pose~%geometry_msgs/Twist velocity~%float32 time~%~%	~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of postion and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Twist~%# This expresses velocity in free space broken into its linear and angular parts.~%Vector3  linear~%Vector3  angular~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <way_points>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'path) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <way_points>))
  "Converts a ROS message object to a list"
  (cl:list 'way_points
    (cl:cons ':header (header msg))
    (cl:cons ':path (path msg))
    (cl:cons ':sample (sample msg))
))
