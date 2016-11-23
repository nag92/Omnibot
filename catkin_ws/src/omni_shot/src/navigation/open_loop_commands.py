#!/usr/bin/env python
'''
Created on Jul 11, 2015

@author: nathaniel
This class calculate open loop commands
'''
import numpy as np

def generate_circle(time):
	T = 10
	r = 1
	omega = 2*np.pi/T
	vx = -r*omega*np.sin(omega*time)
	vy = r*omega*np.cos(omega*time)
	theta_dot = 0
	return (vx,vy,theta_dot)