#!/usr/bin/env python
# Nathaniel Goldfarb 1/24/15
# test class for testing the way_point_navigation
# it sets a series of wayp_points for the robot to follow.

import rospy
from std_msgs.msg import String

from omni_shot.msg import way_points, way_point
from geometry_msgs.msg import Pose, Twist
from nav_msgs.msg import Path
import numpy as np

def move():
   
	
	
	via_points = []
	path = way_points()
	path.sample = 1
	path.header.stamp = rospy.Time.now()
	
	# loc1 = Pose()#moved in to for loop
	# vel1 = Twist()
	# point1 = way_point()

	# loc2 = Pose()#moved in to for loop
	# vel2 = Twist()
	# point2 = way_point()


	# loc3 = Pose()#moved in to for loop
	# vel3 = Twist()
	# point3 = way_point()

	# loc1.position.x = 0
	# vel1.linear.x = 0
	# point1.pose = loc1
	# point1.velocity =vel1
	# point1.time = 0
	# via_points.append(point1)

	# loc2.position.x = 10
	# loc2.position.y = 5    
	# vel2.linear.x = 0
	# vel2.linear.y = 0
	# point2.pose = loc2
	# point2.velocity = vel2
	# point2.time = 3
	# via_points.append(point2)
	# path.sample = 1

	# loc3.position.y = -5
	# vel3.linear.y = 0
	# point3.pose = loc3
	# point3.velocity = vel3
	# point3.time = 10
	# via_points.append(point3)
	# path.sample = 1

	



	loc = Pose()#moved in to for loop
	vel = Twist()
	point = way_point()
	point.header.stamp = rospy.Time.now()
	loc.position.x = 0
	loc.position.y = 0
	loc.position.z = 0
	loc.orientation.w = 1.0;
	vel.linear.x = 1
	vel.linear.y = 1
	vel.angular.z = 0
	point.pose = loc
	point.velocity = vel
	point.time = 0
	via_points.append(point)

	t = time = 0
	points = 101
	#create a path using way_points.msg 
	for ii in xrange(points):
		loc = Pose()#moved in to for loop
		vel = Twist()
		point = way_point()
		point.header.stamp = rospy.Time.now()
		loc.position.x = 5*np.cos(t*np.pi)
		loc.position.y = 5*np.sin(t*np.pi)
		loc.position.z = 0
		
		loc.orientation.w= 1.0;
		vel.linear.x =  1
		vel.linear.y =  1
		vel.angular.z = 0
		t = t + 0.02
		point.pose = loc
		point.velocity = vel
		time = time + float(.3)
		print time
		point.time = time
		via_points.append(point)


	loc = Pose()#moved in to for loop
	vel = Twist()
	point = way_point()
	point.header.stamp = rospy.Time.now()
	loc.position.x = 0
	loc.position.y = 0
	loc.position.z = 0
	loc.orientation.w = 1.0;
	vel.linear.x = 0
	vel.linear.y = 0
	vel.angular.z = 0
	point.pose = loc
	point.velocity = vel
	point.time = (time+float(1))
	via_points.append(point)

	path.path = via_points
	
	
	
	#publish the "path"
	rate = rospy.Rate(10) # 10hz
	count = 0
	while not rospy.is_shutdown():
		if ( count == 2 ):
			path_pub.publish(path)
		word.publish("hello")

		count = count + 1
		rate.sleep()	

if __name__ == '__main__':
	rospy.init_node('gen_path', anonymous=True) 
	rate = rospy.Rate(10) # 10hz
	path_pub = rospy.Publisher("way_points", way_points, queue_size=2)
	word = rospy.Publisher("word", String, queue_size=2)
	
	try:
		move()
	except rospy.ROSInterruptException:
		pass
	
		
