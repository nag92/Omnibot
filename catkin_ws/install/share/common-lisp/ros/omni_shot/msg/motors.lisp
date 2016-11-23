; Auto-generated. Do not edit!


(cl:in-package omni_shot-msg)


;//! \htmlinclude motors.msg.html

(cl:defclass <motors> (roslisp-msg-protocol:ros-message)
  ((m1
    :reader m1
    :initarg :m1
    :type cl:float
    :initform 0.0)
   (m2
    :reader m2
    :initarg :m2
    :type cl:float
    :initform 0.0)
   (m3
    :reader m3
    :initarg :m3
    :type cl:float
    :initform 0.0)
   (m4
    :reader m4
    :initarg :m4
    :type cl:float
    :initform 0.0))
)

(cl:defclass motors (<motors>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <motors>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'motors)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name omni_shot-msg:<motors> is deprecated: use omni_shot-msg:motors instead.")))

(cl:ensure-generic-function 'm1-val :lambda-list '(m))
(cl:defmethod m1-val ((m <motors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:m1-val is deprecated.  Use omni_shot-msg:m1 instead.")
  (m1 m))

(cl:ensure-generic-function 'm2-val :lambda-list '(m))
(cl:defmethod m2-val ((m <motors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:m2-val is deprecated.  Use omni_shot-msg:m2 instead.")
  (m2 m))

(cl:ensure-generic-function 'm3-val :lambda-list '(m))
(cl:defmethod m3-val ((m <motors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:m3-val is deprecated.  Use omni_shot-msg:m3 instead.")
  (m3 m))

(cl:ensure-generic-function 'm4-val :lambda-list '(m))
(cl:defmethod m4-val ((m <motors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader omni_shot-msg:m4-val is deprecated.  Use omni_shot-msg:m4 instead.")
  (m4 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <motors>) ostream)
  "Serializes a message object of type '<motors>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'm1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'm2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'm3))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'm4))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <motors>) istream)
  "Deserializes a message object of type '<motors>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'm1) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'm2) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'm3) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'm4) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<motors>)))
  "Returns string type for a message object of type '<motors>"
  "omni_shot/motors")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'motors)))
  "Returns string type for a message object of type 'motors"
  "omni_shot/motors")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<motors>)))
  "Returns md5sum for a message object of type '<motors>"
  "a77d45638d7a3263f394e6caf58a02e5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'motors)))
  "Returns md5sum for a message object of type 'motors"
  "a77d45638d7a3263f394e6caf58a02e5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<motors>)))
  "Returns full string definition for message of type '<motors>"
  (cl:format cl:nil "float32 m1~%float32 m2~%float32 m3~%float32 m4~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'motors)))
  "Returns full string definition for message of type 'motors"
  (cl:format cl:nil "float32 m1~%float32 m2~%float32 m3~%float32 m4~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <motors>))
  (cl:+ 0
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <motors>))
  "Converts a ROS message object to a list"
  (cl:list 'motors
    (cl:cons ':m1 (m1 msg))
    (cl:cons ':m2 (m2 msg))
    (cl:cons ':m3 (m3 msg))
    (cl:cons ':m4 (m4 msg))
))
