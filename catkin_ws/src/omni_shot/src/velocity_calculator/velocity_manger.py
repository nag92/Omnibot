#!/usr/bin/env python
'''
Created on 2/11/16

@author: nathaniel
This program handles a varity of transformation for velocity  

'''
import numpy as np
import math

raduis_robot = 1#0.3048
raduis_ball = 0.121285
g = 9.81
inverse_N = 16.66
mass = 22.6796
mu = 0
stall_toque = [5 for _ in xrange(4)]
no_load_vel = [683.296401375 for _ in xrange(4)] 

def wheel_vel_transform(vel):
	"""calculates the ball velocity based on the body velocity"""
	#raduis of robot
	r = raduis_robot

	#velocity of the robot
	input_vel = np.matrix([ [vel[0]],#v_x
					 		[vel[1]],#v_y
					 		[vel[2]]]) #z


	#transformation matrix
	trans = np.matrix([[ 1,0 , r],#v_x
					   [0, -1, r],#v_y	
					   [-1, 0, r],
					   [0,  1, r]])#z	
	
	# trans = np.matrix([[ 0,1 , r],#v_x
	# 				   [-1, 0, r],#v_y	
	# 				   [0, -1, r],
	# 				   [1,  0, r]])#z	


	new_vel = np.dot(trans,input_vel)
	
	return new_vel

def torque_cal(vel):
	"""calculates the ball torque based on velocity"""
	
	torque = []
	m = 1
	for i in xrange(len(vel)):
		if ( vel[i] == 0):
			torque.append(0)
		else:	
			# tau_b = inverse_N*stall_toque[i]*0 + vel[i]* ((1/raduis_ball)*(stall_toque[i]/no_load_vel[i]))
			# tau_g = mu*mass*g*raduis_ball
			# torque.append(tau_b - tau_g)
			torque.append( inverse_N*(0.00540148*0.0381*vel[i])  )

	return torque

def differentiat(x0,t0,x1,t1):
	"""differentiation of values, used for encoder readings"""

	return (x1-x0)/(t1-t0)



