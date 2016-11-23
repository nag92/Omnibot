#!/usr/bin/env python
'''
Created on May 11, 2015

@author: nathaniel
This class takes in joystick readings. Then scales them to get the desired velocity and publishes them under a Twist topic
'''


import rospy
import roslib
import numpy as np
import sys
from omni_shot.msg import motors
from geometry_msgs.msg import Twist, TwistStamped, Quaternion
from sensor_msgs.msg import Joy
from std_msgs.msg import Bool



def getAxis(axis):

	vel = Twist()
	ball_vel_msg = motors()
	ball_vel = [] 
	maxScale = 100
	minScale = 50
	accelRate = 1
	deadman = 1
	vx = vy = omega = 0
	if axis.buttons[5]:#right trigger

		#if the robot is not moving then use the joystick 
		if getAxis.choice == 0:

			if axis.buttons[3]:
				getAxis.choice = 1
		


		if getAxis.choice == 0:
		#normilize the joystick readings 	
			vX = np.interp(axis.axes[0],[-1,1],[-1*getAxis.scale,getAxis.scale])
			vY = np.interp(axis.axes[1],[-1,1],[-1*getAxis.scale,getAxis.scale])
			wZ = np.interp(axis.axes[3],[-1,1],[-1*getAxis.scale,getAxis.scale])
			

			#change the accelration rate so that the robot does not acclerate to fast
			#Kevin, this is the same thing we put on the videoray

			if(vX > getAxis.lastVX and getAxis.xSpeed + accelRate <= getAxis.scale ):
				getAxis.xSpeed = getAxis.xSpeed + accelRate
			elif( vX < getAxis.lastVX and getAxis.xSpeed - accelRate >= -getAxis.scale  ):
				getAxis.xSpeed = getAxis.xSpeed - accelRate

			if(vY > getAxis.lastVY and getAxis.ySpeed + accelRate <= getAxis.scale ):
				getAxis.ySpeed = getAxis.ySpeed + accelRate
			elif( vY < getAxis.lastVY and getAxis.ySpeed - accelRate >= -getAxis.scale  ):
				getAxis.ySpeed = getAxis.ySpeed - accelRate

			if(wZ > getAxis.lastWZ and getAxis.zSpeed + accelRate <= getAxis.scale ):
				getAxis.zSpeed = getAxis.zSpeed + accelRate
			elif( wZ < getAxis.lastWZ and getAxis.zSpeed - accelRate >= -getAxis.scale ):
				getAxis.zSpeed = getAxis.zSpeed - accelRate

			
			getAxis.lastVX = getAxis.xSpeed
			getAxis.lastVY = getAxis.ySpeed
			getAxis.lastWZ = getAxis.zSpeed


			vel.linear.x  =  -1*getAxis.xSpeed
			vel.linear.y  =  getAxis.ySpeed
			vel.angular.z =  -1*getAxis.zSpeed

			ball_vel = velocity_manger.wheel_vel_transform([vel.linear.x, vel.linear.y, vel.angular.z])

		else:
			(vx,vy,omega) = auto_move(getAxis.choice, getAxis.time)
			ball_vel = velocity_manger.wheel_vel_transform([vx,vy,omega])
			getAxis.time = getAxis.time + .1 
		

	#if the trigger is not being moved make velocity 0
	else:

		getAxis.lastWZ = 0
		getAxis.lastVY = 0
		getAxis.lastVX = 0
		getAxis.xSpeed = 0
		getAxis.ySpeed = 0
		getAxis.zSpeed = 0
		vel.linear.x = 0
		vel.linear.y = 0
		vel.angular.z = 0
		getAxis.time = 0
		getAxis.choice = 0
		ball_vel = velocity_manger.wheel_vel_transform([vel.linear.x, vel.linear.y, vel.angular.z])


	
	ball_vel_msg.m1 = ball_vel[0]
	ball_vel_msg.m2 = ball_vel[1]
	ball_vel_msg.m3 = ball_vel[2]
	ball_vel_msg.m4 = ball_vel[3]
	vel.linear.x = vx
	vel.linear.y = vy
	vel.angular.z = omega
	pub_sim.publish(vel)
	pub_ball_vel.publish(ball_vel_msg)

def auto_move(choice, time):

	if choice == 1:
		(vx,vy,omega) = open_loop_commands.generate_circle(time)

	return (vx,vy,omega)
	
	

if __name__ == '__main__':

	#set up the node
	if __package__ is None:
		import sys
		from os import path
		sys.path.append( path.dirname( path.dirname( path.abspath(__file__) ) ) )
		from velocity_calculator import velocity_manger
		from navigation import open_loop_commands
	else:
		from ..velocity_calculator import velocity_manger
		from ..navigation import open_loop_commands

	rospy.init_node('joy_stick', anonymous=True)
	pub_deadman = rospy.Publisher("deadman",Bool ,queue_size=0) 
	pub_ball_vel = rospy.Publisher("ball_velocity",motors ,queue_size=0)
	pub_sim = rospy.Publisher("/cmd_vel",Twist ,queue_size=0)
	rospy.Subscriber("joy", Joy, getAxis)

	getAxis.scale = 100
	getAxis.lastVX = 0
	getAxis.lastVY = 0
	getAxis.lastWZ = 0
	getAxis.xSpeed = 0
	getAxis.ySpeed = 0
	getAxis.zSpeed = 0
	getAxis.choice = 0
	rospy.spin()