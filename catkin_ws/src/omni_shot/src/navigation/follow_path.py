#!/usr/bin/env python
''' 
Nathaniel Goldfarb 2/15/16
This program generate the velocities for the robot to travel
It starts with "start_path" by taking in a way_points. It then moves throught them 
It works on closed loop system by taking the TF frame to close the loop

'''

import numpy as np
import csv
import EKF
import message_filters
import rospy
from std_msgs.msg import String
import tf
import time
from omni_shot.msg import way_points, way_point, trajectory_poly
from tf.transformations import euler_from_quaternion
from geometry_msgs.msg import Twist, PoseStamped, TwistStamped
from geometry_msgs.msg import Pose
from nav_msgs.msg import Path
from std_msgs.msg import Float32MultiArray
#from ..velocity_calculator import velocity_manger





def start_path(way_points):
    
    '''This is called when a way_points message is recived. It is a polynomial to create a trajectory.
    in then waits for a TF frame to update the POS'''

    draw_path(way_points)
    traveling = True
    lenght_of_path = len(way_points.path)
    
    rate = rospy.Rate(my_dt)

    # run through the waypoints
    for ii in xrange(lenght_of_path - 1 ):
        print "hellos"
        
        #see if it is safe to move
        if safe:
            pose = Pose()
            point = way_point()

        #update the pose with the TF
            if not rospy.is_shutdown():

                try:
                    (trans,rot) = listener.lookupTransform("/odom", "/base_link", rospy.Time(0))
                    print "have Frame"
                except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
                    print "Do not have Frame"
                    continue

                #grab the pose
                pose.position.x = trans[0]
                pose.position.y = trans[1]
                pose.position.z = trans[2]
                
                pose.orientation.x = 0#rot[0]
                pose.orientation.y = 0#rot[1]
                pose.orientation.z = 0#rot[2]
                pose.orientation.w = 1#rot[3]
                point = make_waypoint(way_points.path[ii], pose)
                #move the robot from waypoint to waypoints
                
                move( point,way_points.path[ii+1])

#old dont use-> replaced with generate
def move(p0,p1):
    '''calculate the new trajectory and move the robot'''
    trajectory = trajectory_poly()
    torque_list = Float32MultiArray()

    #calculate the trajecory
    (a,b,c,d) = make_poly_3rd_order( p0,p1)
    
    #start and end tieme
    t1 = float(p0.time)
    t2 = float(p1.time)
    delta_y = float(p1.pose.position.y) - p0.pose.position.y
    delta_x = float(p1.pose.position.x) - p0.pose.position.x
    theta = np.arctan2(delta_y,delta_x)
    t = 0
    #create message to send to arduino
    trajectory.linear = [ a[0],b[0],c[0],d[0] ]
    trajectory.angular = [ a[1],b[1],c[1],d[1] ]
    trajectory.time = t2 - t1
    trajectory.theta = theta
    

    #check if it is safe to move 
    #move from t = 0 -> t = dt by 0.01
    while ( safe and (t < float(t2)-t1 ) ):

        #advance time
        t = t + my_dt

        #get lin and ang velocity
        linear_vel = b[0] + 2.*c[0]*t + 3.*d[0]*(t**2)
        angular_vel = b[1] + 2.*c[1]*t + 3.*d[1]*(t**2)

        v_x = linear_vel*np.cos(theta)
        v_y = linear_vel*np.sin(theta)

        #publish the velocity
        vel = Twist()
        vel.linear.x = v_x
        vel.linear.y = v_y
        vel.angular.z = angular_vel
        wheel_vel = vm.wheel_vel_transform( [ v_x,v_y,angular_vel  ] )
        torque = vm.torque_cal(wheel_vel)
        torque_list.data = torque
        path_vel.publish(vel)
        torque_pub.publish(torque_list)
        #simulate the time
        time.sleep(my_dt)


def make_poly_3rd_order(p0, p1):
    '''takes in two way_points returns the polynomial'''
    
    #convert the way_points angle to euler
    p0_euler = euler_from_quaternion([p0.pose.orientation.x, p0.pose.orientation.y, p0.pose.orientation.z, p0.pose.orientation.w])
    p1_euler = euler_from_quaternion([p1.pose.orientation.x, p1.pose.orientation.y, p1.pose.orientation.z, p1.pose.orientation.w])
    
    delta_x = float(p1.pose.position.x) - p0.pose.position.x
    delta_y = float(p1.pose.position.y) - p0.pose.position.y

    #couple the x and y
    pho = np.sqrt( (delta_x)**2 + (delta_y )**2 ) 
    vel_i = np.sqrt( (p0.velocity.linear.x)**2 + (p0.velocity.linear.y)**2  )
    vel_f = np.sqrt( (p1.velocity.linear.x)**2 + (p1.velocity.linear.y)**2  )
    
    #get time difference
    dt = float(p1.time) - p0.time

    #use boundary conditions to solve the polynomal
    a = [0,p0_euler[2]]
    b = [vel_i, p0.velocity.angular.z]


    angular_c =  3.* float(p1_euler[2] - p0_euler[2]) - (float( 2*p0.velocity.angular.z )  + p0.velocity.angular.z)*dt
    angular_c = angular_c/(float(dt**2))
    
    angular_d = 2.*(float(p0_euler[2]) - p0_euler[2])  +  (float( p0.velocity.angular.z ) + p1.velocity.angular.z)*dt
    angular_d = angular_d/(float(dt**3))
    
    linear_c = 3.*(pho - vel_i*dt) - (vel_f - vel_i)*dt
    linear_c  = linear_c/float(dt**2)

    linear_d = (float(vel_f) - vel_i)*dt - 2.*(pho - float(vel_i*dt))
    linear_d = linear_d/float(dt**3)

    c = [linear_c, angular_c]
    d = [linear_d, angular_d]

    return  (a, b, c, d )

def draw_path(path):
    '''takes in a way_points and draws a path in Rviz'''

    #check to make sure there is a enough poses to make a path
    if len(path.path) < 2:
        rospy.loginfo("NO PATH")
        return   
    #posestamped list
    pose_list = list()
    #path to send the Rviz
    my_path = Path()
    my_path.header.stamp = rospy.Time.now()
    my_path.header.frame_id = "base_link"
        
    #make the poses into posestamped
    for loc in path.path:
        #make all the Pose() a PoseStamped() and add it to a list
        pose = PoseStamped()
        pose.header.frame_id = "base_link"
        pose.pose = loc.pose
        pose_list.append(pose)
        my_path.poses.append(pose)  
        
    #Publish the Path for Rviz 
    path_pub.publish(my_path)


def make_waypoint(point, pose):
    '''converts a pose to way_point'''  
    new_point = way_point()
    new_point.velocity = point.velocity
    
    new_point.pose.position = pose.position
    new_point.pose.orientation = pose.orientation
    new_point.time = point.time
    return new_point


def is_safe(message):
    '''checks if it is safe to move'''
    safe = False
    rospy.logfatal(message, safe)


if __name__ == '__main__':
    
    if __package__ is None:
        import sys
        from os import path
        sys.path.append( path.dirname( path.dirname( 
            path.abspath(__file__) ) ) )
        from velocity_calculator import velocity_manger as vm
    else:
        from ..velocity_calculator import velocity_manger as vm

    rospy.init_node('path_follower', anonymous=True)

    path_pub = rospy.Publisher("my_plan",Path,queue_size=1)
    trajectory_pub = rospy.Publisher("coef", trajectory_poly,queue_size=100)
    path_vel = rospy.Publisher("/cmd_vel",Twist,queue_size=1)

    torque_pub = rospy.Publisher("torque",Float32MultiArray,queue_size=1)
    rospy.Subscriber("way_points", way_points, start_path)
    rospy.Subscriber("is_safe", String, is_safe)
    
    listener = tf.TransformListener()
    my_dt = 0.01
    safe = True
    
    rospy.spin()