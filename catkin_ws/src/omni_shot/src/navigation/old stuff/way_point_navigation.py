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

    #get all the way points
    for i in xrange(div-1):
        destination.append( way_points.path[i*way_points.sample] )

    destination.append(way_points.path[-1])

    #move through all the points
    for i in xrange(len(destination) - 1 ):

        #write data to a CSV file
        #write(destination[i])
        
        # Get the coefs of the polynomial

        ###to close the loop change destination[i] to output of EKF
        # to use a 3rd order fit
        #(a0,a1,a2,a3 ) = make_poly_3rd_order( destination[i], destination[i+1])

        # to use a 5th order fit
        (a0,a1,a2,a3,a4,a5 ) = make_poly_5th_order( destination[i], destination[i+1])
        


        #start adn end tiem
        t1 = float(destination[i].time)
        t2 = float(destination[i+1].time)
        print "t2 - t1 "  + str(float(t2)-t1)
        t = 0
        # time step
       

        #send time to EQ
        while (t < float(t2)-t1 ):
            t = t + EKF.my_dt
            print t
            my_vel = []
            pose_output = []
            #print t
            
            #move through x,y,theta
            for d in xrange(len(a1)):
                
                #use the deritive of the EQ to get the velocity in each direction

                #3rd order
                #temp = a1[d] + 2*a2[d]*(t) + 3*a3[d]*((t)**2)
                #temp_pose = a0[d] + a1[d]*t + a2[d]*(t)**2 + a3[d]*((t)**3)

                #5th order
                temp = a1[d] + 2*a2[d]*(t) + 3*a3[d]*((t)**2) + 4*a4[d]*((t)**3) + 5*a5[d]*((t)**4) 
                temp_pose = a0[d] + a1[d]*t + a2[d]*(t)**2 + a3[d]*((t)**3) + a4[d]*((t)**4) + a5[d]*((t)**5)
                
                
                my_vel.append(temp)
                pose_output.append(temp_pose)
                
            
            pose_output.append(destination[i].pose.position.x)
            pose_output.append(destination[i].pose.position.y)
            outputWriter.writerow(pose_output)
            #publish the velocity
            vel = Twist()
            vel_stamp = TwistStamped()
            vel.linear.x = my_vel[0]
            vel.linear.y = my_vel[1]
            vel.angular.z  = my_vel[2]  
            #print my_vel[1]
            vel_stamp.header.stamp = rospy.Time.now()
            vel_stamp.twist = vel
            path_vel.publish(vel)
            stamp_vel.publish(vel_stamp)
            #simulate the time
            rospy.sleep(EKF.my_dt)
            

    #close the file
    print "done"
    outputFile.close()

# does not work
# def do_ekf(vel, odom):

#     print "message resieved" 
#     mag_vel = np.sqrt( vel.twist.linear.x**2 + vel.twist.linear.y**2 )
#     euler = euler_from_quaternion([odom.pose.pose.orientation.x, 
#                            odom.pose.pose.orientation.y, 
#                            odom.pose.pose.orientation.z, 
#                            odom.pose.pose.orientation.w])
    
#     control = [ mag_vel , vel.twist.angular.z + .01 ]
#     u = [control, control,control]
#     pos = [ odom.pose.pose.position.x, odom.pose.pose.position.y, euler[2]  ] 
#     z = [ pos, pos, pos ]
  
#     pos = my_EKF.update( u,z )
#     outputWriter.writerow(pos[0])

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

def write(destination):

    #wite to file
    p0 = destination
    print "hello"
    
    (trans,root) = listener.lookupTransform( "/odom","/base_link", rospy.Time(0))

    way_point_theta = euler_from_quaternion([p0.pose.orientation.x, p0.pose.orientation.y, p0.pose.orientation.z, p0.pose.orientation.w])
    real_theta = euler_from_quaternion([root[0],root[1],root[2],root[3],  ])

    #outputWriter.writerow(["Waypoint X","Real X","Waypoint Y","Real Y", "Waypoint Theta", "Real Theta" ])
    outputWriter.writerow( [p0.pose.position.x, EKF.kalman[0] ,
                            p0.pose.position.y,EKF.kalman[1],
                            way_point_theta[2],EKF.kalman[2] ])


#get the coefficients use a 3rd order EQ
#takes in starting and ending way_point
def make_poly_3rd_order(p0, p1):

    #convert the way_points angle to euler
    p0_euler = euler_from_quaternion([p0.pose.orientation.x, p0.pose.orientation.y, p0.pose.orientation.z, p0.pose.orientation.w])
    p1_euler = euler_from_quaternion([p1.pose.orientation.x, p1.pose.orientation.y, p1.pose.orientation.z, p1.pose.orientation.w])
    
    #get the way_points pose and velocity
    pose0 = [ p0.pose.position.x, p0.pose.position.y,p0_euler[2]]
    pose1 = [ p1.pose.position.x, p1.pose.position.y,p1_euler[2]]
    
    vel0  = [ p0.velocity.linear.x,p0.velocity.linear.y,p0.velocity.angular.z]
    vel1  = [ p1.velocity.linear.x,p1.velocity.linear.y,p1.velocity.angular.z]

    #find time diff
    dt = float(p1.time - p0.time)
    print "p0 " + str(p0.time)
    print "p1 " + str(p1.time)

    #save the values for the coefs
    a0 = pose0
    a1 = vel0
    a2 = []
    a3 = []
    
    #calculate the other coefs for x,y,theta
    for i in xrange(len(pose0)):

        temp_a2 = 3* float(pose1[i] - pose0[i]) - float( 2*vel0[i]  + vel1[i])*dt
        temp_a3 = 2*float(pose0[i] - pose1[i]) + float( vel0[i]  + vel1[i])*dt
        

        a2.append(temp_a2/(dt**2))
        a3.append(temp_a3/(dt**3))

    #return the coefs
    return (a0,a1,a2,a3 )   



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


#does not work
# def setupEKF():

#     z1 = lambda x : x[0]  + 0*x[1] + 0*x[2] 
#     z2 = lambda x :0*x[0] +   x[1] + 0*x[2] 
#     z3 = lambda x :0*x[0] + 0*x[1] +   x[2] 
    
#     x = lambda x,u: x[0] - (u[0]/u[1])*np.sin(x[2]) + (u[0]/u[1])*np.sin(x[2] + u[1]*my_dt)  
#     y = lambda x,u: x[1] + (u[0]/u[1])*np.cos(x[2]) - (u[0]/u[1])*np.cos(x[2] + u[1]*my_dt) 
#     theta = lambda x,u: x[2] + u[1]*my_dt
    

   
   
#     g = [x,y,theta]
#     h = [z1,z2,z3]
#     start = [0,0,0]
#     x = [ start,start,start ]
#     loc = np.matrix( [ start,start,start ])
#     Q = np.eye(np.matrix([start]).shape[0])*2
#     R = np.eye(np.matrix([start]).shape[0])*.5
#     sigma = np.eye(loc.shape[0])
#     return EKF.EKF(g,h,sigma,Q,R,x)

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
    outputFile = open('trig_vel.csv', 'wb')
    outputWriter = csv.writer(outputFile)
    outputWriter.writerow(["X", "Y","Theta" ,"waypoint X" , "waypoint Y" ])
    
    listener = tf.TransformListener()
    
    rospy.spin()