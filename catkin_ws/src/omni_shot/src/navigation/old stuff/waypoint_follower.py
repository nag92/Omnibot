#!/usr/bin/env python
''' 
Nathaniel Goldfarb 1/24/16
This program control the path of the robot by calculating the trajectory 
It uses a via-points method to accomplish this. 
it fit a 5th order polynomial bwtween the points. (a 3rd order option is also possable)
see Robots and automation for more detail
'''

import numpy as np
import csv
import EKF
import message_filters
import rospy
from std_msgs.msg import String
import tf
from omni_shot.msg import way_points, way_point
from tf.transformations import euler_from_quaternion
from geometry_msgs.msg import Twist, PoseStamped, TwistStamped
from geometry_msgs.msg import Pose
from nav_msgs.msg import Path
from nav_msgs.msg import Odometry


#function called when a path is sent
def start_path(way_points):

    
    #draw the path
    draw_path(way_points)
   
    #Get the number to break up the path
    div = len(way_points.path)/way_points.sample

    destination = []
    vel = Twist()
    my_vel = []
    x = y = 0

    #get all the way points
    for i in xrange(div-1):
        destination.append( way_points.path[i*way_points.sample] )

    destination.append(way_points.path[-1])

    #move through all the points
    for i in xrange(len(destination) - 1 ):

        
        # Get the coefs of the polynomial
        (a,b,c,d) = make_poly_3rd_order( destination[i], destination[i+1])

        #start adn end tieme
        t1 = float(destination[i].time)
        t2 = float(destination[i+1].time)
        print "t2 - t1 "  + str(t2-t1)
        delta_y = float(destination[i+1].pose.position.y) - destination[i].pose.position.y
        delta_x = float(destination[i+1].pose.position.x) - destination[i].pose.position.x
        theta = np.arctan2(delta_y,delta_x)
        t = 0
        # time step
       

        #send time to EQ
        while (t < float(t2)-t1 ):

            t = t + EKF.my_dt
            pose_output = []
                 

            #move through x,y,theta   
            #use the deritive of the EQ to get the velocity in each direction

            #3rd order
            #temp_pose = a[0] + a[1]*t + a[2]*(t)**2 + a[3]*((t)**3)
            linear_vel = b[0] + 2.*c[0]*t + 3.*d[0]*(t**2)
            linear_accl =  2*c[0] + 6*d[0]*t

            angular_vel = b[1] + 2.*c[1]*t + 3.*d[1]*(t**2)
            angular_accl =  2.*c[1] + 6.*d[1]*t


            v_x = linear_vel*np.cos(theta)
            v_y = linear_vel*np.sin(theta)

            #guess the state
            x = x + v_x*EKF.my_dt + .5*linear_accl*float(np.cos(theta))*EKF.my_dt*EKF.my_dt
            y = y + v_y*EKF.my_dt + .5*linear_accl*float(np.sin(theta))*EKF.my_dt*EKF.my_dt
            
           
            #write to file
            pose_output.append(x)
            pose_output.append(y)
            pose_output.append(destination[i].pose.position.x)
            pose_output.append(destination[i].pose.position.y)
            outputWriter.writerow(pose_output)

            #publish the velocity
            vel = Twist()
            vel.linear.x = v_x
            vel.linear.y = v_y
            path_vel.publish(vel)
            #simulate the time
            rospy.sleep(EKF.my_dt)
            

    #close the file
    print "done"
    outputFile.close()


def do_ekf(vel, odom):

    print "message resieved" 

    euler = euler_from_quaternion([ odom.pose.pose.orientation.x, 
                                    odom.pose.pose.orientation.y, 
                                    odom.pose.pose.orientation.z, 
                                    odom.pose.pose.orientation.w])
    
    u = [ vel.twist.linear.x, vel.twist.linear.y, vel.twist.angular.z ]
    
    z = [ [odom.pose.pose.position.x], [odom.pose.pose.position.y], [euler[2]]  ] 
    

    pos = my_EKF.update( u,z )
    EKF.kalman =[pos.tolist()[0][0],pos.tolist()[1][0],pos.tolist()[2][0]]
    print EKF.kalman
        #outputWriter.writerow(pos[0])
    

         
#draw the path
def draw_path(path):

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


#get the coefficients use a 3rd order EQ
#takes in starting and ending way_point
def make_poly_3rd_order(p0, p1):

    #convert the way_points angle to euler
    p0_euler = euler_from_quaternion([p0.pose.orientation.x, p0.pose.orientation.y, p0.pose.orientation.z, p0.pose.orientation.w])
    p1_euler = euler_from_quaternion([p1.pose.orientation.x, p1.pose.orientation.y, p1.pose.orientation.z, p1.pose.orientation.w])
    
    delta_x = float(p1.pose.position.x) - p0.pose.position.x
    delta_y = float(p1.pose.position.y) - p0.pose.position.y

    pho = np.sqrt( (delta_x)**2 + (delta_y )**2 ) 
    vel_i = np.sqrt( (p0.velocity.linear.x)**2 + (p0.velocity.linear.y)**2  )
    vel_f = np.sqrt( (p1.velocity.linear.x)**2 + (p1.velocity.linear.y)**2  )
    
    dt = float(p1.time) - p0.time

    a = [0,p0_euler[2]]
    b = [vel_i, p0.velocity.angular.z]

    angular_c = 3.* float(p1_euler[2] - p0_euler[2]) - (float( 2*p0.velocity.angular.z )  + p0.velocity.angular.z)*dt
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


#get the coefficients use a 5th order EQ
#takes in starting and ending way_point
def make_poly_5th_order(p0, p1):

    #convert the way_points angle to euler
    p0_euler = euler_from_quaternion([p0.pose.orientation.x, p0.pose.orientation.y, p0.pose.orientation.z, p0.pose.orientation.w])
    p1_euler = euler_from_quaternion([p1.pose.orientation.x, p1.pose.orientation.y, p1.pose.orientation.z, p1.pose.orientation.w])
    
    #get the way_points pose and velocity
    pose0 = [ p0.pose.position.x, p0.pose.position.y,p0_euler[2]]
    pose1 = [ p1.pose.position.x, p1.pose.position.y,p1_euler[2]]
    
    #find time diff
    vel0  = [ p0.velocity.linear.x,p0.velocity.linear.y,p0.velocity.angular.z]
    vel1  = [ p1.velocity.linear.x,p1.velocity.linear.y,p1.velocity.angular.z]

    dt = p1.time - p0.time


    #save the values for the coefs
    a0 = pose0
    a1 = vel0
    a2 = []
    a3 = []
    a4 = []
    a5 = []
    
    #calculate the other coefs for x,y,theta
    for i in xrange(len(pose0)):

        A = pose1[i] - pose0[i] - vel0[i]*dt
        B = vel1[i] - vel0[i]

        temp_a3 = 2*(5*A -2*B)/(dt**3)
        temp_a4 = (7*B - 15*A)/(dt**4)
        temp_a5 = 3*( 2*A + B*(dt**6) - 2*B)/(dt**5)
        
        a2.append(0)
        a3.append(temp_a3)
        a4.append(temp_a4)
        a5.append(temp_a5)

    #return the coefs
    return (a0,a1,a2,a3,a4,a5)


def setupEKF():

    z1 = lambda x :   x[0] + 0*x[1] + 0*x[2] 
    z2 = lambda x : 0*x[0] +   x[1] + 0*x[2] 
    z3 = lambda x : 0*x[0] + 0*x[1] +   x[2] 
    
    x  = lambda x,u: x + u*EKF.my_dt  
    y  = lambda x,u: x + u*EKF.my_dt  
    theta  = lambda x,u: x + u*EKF.my_dt   
     
    g = [x,y,theta]
    h = [z1,z2,z3]

    loc = np.matrix( [[0], [0], [0] ] )

    Q = np.eye( np.matrix(loc).shape[0] )
    R = np.eye( np.matrix(loc).shape[0] )

    sigma = np.eye(loc.shape[0])
    
    return EKF.EKF(g,h,sigma,Q,R,loc)



if __name__ == '__main__':
    
    #time step
    EKF.my_dt = 0.01
    #EKF 
    my_EKF = setupEKF()
    EKF.kalman = [0,0,0]
    
    rospy.init_node('path_follower', anonymous=True)

    path_pub = rospy.Publisher("my_plan",Path,queue_size=1)
    path_vel = rospy.Publisher("/cmd_vel",Twist,queue_size=1)
    stamp_vel = rospy.Publisher("/my_vel",TwistStamped,queue_size=1)
    
    # vel = message_filters.Subscriber('/my_vel', TwistStamped)
    # odom = message_filters.Subscriber('/odom',Odometry )
    # ts = message_filters.TimeSynchronizer([vel, odom], 1)    
    # ts.registerCallback(do_ekf)
    
    rospy.Subscriber("way_points", way_points, start_path)

    #write data to file
    outputFile = open('coupled_points.csv', 'wb')
    outputWriter = csv.writer(outputFile)
    outputWriter.writerow(["X", "Y" ,"waypoint X" , "waypoint Y" ])
    
    listener = tf.TransformListener()
    
    rospy.spin()