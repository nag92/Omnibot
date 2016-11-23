
(cl:in-package :asdf)

(defsystem "omni_shot-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "trajectory_poly" :depends-on ("_package_trajectory_poly"))
    (:file "_package_trajectory_poly" :depends-on ("_package"))
    (:file "motors" :depends-on ("_package_motors"))
    (:file "_package_motors" :depends-on ("_package"))
    (:file "way_points" :depends-on ("_package_way_points"))
    (:file "_package_way_points" :depends-on ("_package"))
    (:file "my_imu" :depends-on ("_package_my_imu"))
    (:file "_package_my_imu" :depends-on ("_package"))
    (:file "way_point" :depends-on ("_package_way_point"))
    (:file "_package_way_point" :depends-on ("_package"))
  ))