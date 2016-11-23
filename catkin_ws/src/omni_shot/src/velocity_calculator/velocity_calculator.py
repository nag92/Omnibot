#!/usr/bin/env python
'''
Created on Jul 9, 2015

@author: nathaniel
This program takes in Vx,Vy,Wz and outputs the motor velocties 

'''
import numpy as np
from omni_shot.msg import motors


import rospy
import roslib
import math
import tf
#import outlier_filter
from geometry_msgs.msg import Twist, TwistStamped, Quaternion
from sensor_msgs.msg import Joy

import sys



def make_ball_velocity(vel):

	#message to send with motor velocity

	
	motor_vel = motors()

	#raduis of robot
	r = 0.30
	#velocity of the robot
	input_vel = np.matrix([ [vel.linear.x],#v_x
					 		[vel.linear.y],#v_y
					 		[vel.angular.z]])#z


	#transformation matrix
	trans = np.matrix([[ 0, 1, r],#v_x
					   [-1, 0, r],#v_y	
					   [0, -1, r],
					   [1,  0, r]])#z	


	new_vel = np.dot(trans,input_vel)
	
	motor_vel.m1 = new_vel[0]
	motor_vel.m2 = new_vel[1]
	motor_vel.m3 = new_vel[2]
	motor_vel.m4 = new_vel[3]
	
	pub.publish(motor_vel)


if __name__ == '__main__':
	#set up the node
	rospy.init_node('VeloityCalculator', anonymous=True)
	pub = rospy.Publisher("ball_velocity",motors ,queue_size=10)
	rospy.Subscriber("robot_velocity", TwistStamped, make_ball_velocity);
	rospy.Subscriber("/cmd_vel", Twist, make_ball_velocity);
	#rospy.Subscriber("joy", Joy, getAxis);
	rospy.spin()