# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "omni_shot: 5 messages, 0 services")

set(MSG_I_FLAGS "-Iomni_shot:/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/indigo/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(omni_shot_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/my_imu.msg" NAME_WE)
add_custom_target(_omni_shot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omni_shot" "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/my_imu.msg" "geometry_msgs/Vector3:std_msgs/Header:geometry_msgs/Quaternion"
)

get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg" NAME_WE)
add_custom_target(_omni_shot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omni_shot" "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg" "geometry_msgs/Point:geometry_msgs/Vector3:std_msgs/Header:geometry_msgs/Quaternion:geometry_msgs/Pose:geometry_msgs/Twist"
)

get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_points.msg" NAME_WE)
add_custom_target(_omni_shot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omni_shot" "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_points.msg" "geometry_msgs/Point:geometry_msgs/Quaternion:omni_shot/way_point:geometry_msgs/Vector3:std_msgs/Header:geometry_msgs/Pose:geometry_msgs/Twist"
)

get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/motors.msg" NAME_WE)
add_custom_target(_omni_shot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omni_shot" "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/motors.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/trajectory_poly.msg" NAME_WE)
add_custom_target(_omni_shot_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "omni_shot" "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/trajectory_poly.msg" "std_msgs/Header"
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/my_imu.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omni_shot
)
_generate_msg_cpp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omni_shot
)
_generate_msg_cpp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_points.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omni_shot
)
_generate_msg_cpp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/motors.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omni_shot
)
_generate_msg_cpp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/trajectory_poly.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omni_shot
)

### Generating Services

### Generating Module File
_generate_module_cpp(omni_shot
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omni_shot
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(omni_shot_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(omni_shot_generate_messages omni_shot_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/my_imu.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_cpp _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_cpp _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_points.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_cpp _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/motors.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_cpp _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/trajectory_poly.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_cpp _omni_shot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(omni_shot_gencpp)
add_dependencies(omni_shot_gencpp omni_shot_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS omni_shot_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/my_imu.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omni_shot
)
_generate_msg_lisp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omni_shot
)
_generate_msg_lisp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_points.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omni_shot
)
_generate_msg_lisp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/motors.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omni_shot
)
_generate_msg_lisp(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/trajectory_poly.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omni_shot
)

### Generating Services

### Generating Module File
_generate_module_lisp(omni_shot
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omni_shot
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(omni_shot_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(omni_shot_generate_messages omni_shot_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/my_imu.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_lisp _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_lisp _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_points.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_lisp _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/motors.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_lisp _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/trajectory_poly.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_lisp _omni_shot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(omni_shot_genlisp)
add_dependencies(omni_shot_genlisp omni_shot_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS omni_shot_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/my_imu.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot
)
_generate_msg_py(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot
)
_generate_msg_py(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_points.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/indigo/share/geometry_msgs/cmake/../msg/Twist.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot
)
_generate_msg_py(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/motors.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot
)
_generate_msg_py(omni_shot
  "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/trajectory_poly.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/indigo/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot
)

### Generating Services

### Generating Module File
_generate_module_py(omni_shot
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(omni_shot_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(omni_shot_generate_messages omni_shot_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/my_imu.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_py _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_point.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_py _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/way_points.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_py _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/motors.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_py _omni_shot_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/nathaniel/Documents/Omnibot/code/catkin_ws/src/omni_shot/msg/trajectory_poly.msg" NAME_WE)
add_dependencies(omni_shot_generate_messages_py _omni_shot_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(omni_shot_genpy)
add_dependencies(omni_shot_genpy omni_shot_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS omni_shot_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omni_shot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/omni_shot
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(omni_shot_generate_messages_cpp std_msgs_generate_messages_cpp)
add_dependencies(omni_shot_generate_messages_cpp geometry_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omni_shot)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/omni_shot
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(omni_shot_generate_messages_lisp std_msgs_generate_messages_lisp)
add_dependencies(omni_shot_generate_messages_lisp geometry_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/omni_shot
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(omni_shot_generate_messages_py std_msgs_generate_messages_py)
add_dependencies(omni_shot_generate_messages_py geometry_msgs_generate_messages_py)
