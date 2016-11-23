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
from std_msgs.msg import Float64

import sys



def move(vel):
	
	pub1.publish(vel.m1)
	pub2.publish(vel.m2)
	pub3.publish(vel.m3*-1)	
	pub4.publish(vel.m4*-1)
	

	
if __name__ == '__main__':
	#set up the node
	rospy.init_node('simMotors', anonymous=True)
	pub1 = rospy.Publisher("/mybot/m1_effort_controller/command",Float64 ,queue_size=1)
	pub2 = rospy.Publisher("/mybot/m2_effort_controller/command",Float64 ,queue_size=1)
	pub3 = rospy.Publisher("/mybot/m3_effort_controller/command",Float64 ,queue_size=1)
	pub4 = rospy.Publisher("/mybot/m4_effort_controller/command",Float64 ,queue_size=1)
	rospy.Subscriber("ball_velocity", motors, move);
	
	#rospy.Subscriber("joy", Joy, getAxis);
	rospy.spin()