#!/usr/bin/env python

import rospy 
from omni_shot.msg import my_imu
import numpy as np
import csv
from tf.transformations import euler_from_quaternion

def make_euler(imu):

	euler = euler_from_quaternion([ imu.orientation.x,imu.orientation.y,imu.orientation.z,imu.orientation.w ])

	print "roll " + str( euler[0] * 180/np.pi)
	print "pitch " + str( euler[1]* 180/np.pi)
	print "yaw " + str( euler[2]* 180/np.pi)
	print "---------------------------------"

if __name__ == '__main__':
 
    rospy.init_node('imu_testing', anonymous=True)   
    rospy.Subscriber("imu", my_imu, make_euler)
    
    rospy.spin()