#!/usr/bin/env python
'''
Nathaniel Goldfarb 1/13/16 
omni_shot
This function displays a path for the robot to follow. 
Then moves the robot along that path in  steps
'''

import roslib
import rospy
import actionlib
from actionlib_msgs.msg import *
from geometry_msgs.msg import Pose, PoseWithCovarianceStamped, Point, Quaternion, Twist, PoseStamped
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal
from nav_msgs.msg import Path
from std_msgs.msg import String

class sending_simple_goals():
    """docstring fosend_goals_nav"""
    
    def __init__(self, step,break_out_time):
        self.move_base = actionlib.SimpleActionClient("move_base", MoveBaseAction)
        self.path_pub = rospy.Publisher("aPlan",Path,queue_size=1)
       
        #how many steps to skip in the path
        self.step = step
        #time to wait to break out of the path
        self.break_out_time = break_out_time
        
            
    #make the path and send the Poses to move robot
    def new_path(self,path):

        #check to make sure there is a enough poses to make a path
        if len(path) < 2:
            rospy.loginfo("NO PATH")
            return
       
        #posestamped list
        pose_list = list()
        #path to send the Rviz
        my_path = Path()
        my_path.header.stamp = rospy.Time.now()
        my_path.header.frame_id = "odom"
        
        #make the poses into posestamped
        for loc in path:
            #make all the Pose() a PoseStamped() and add it to a list
            pose = PoseStamped()
            pose.header.frame_id = "odom"
            pose.pose = loc
            pose_list.append(pose)
            my_path.poses.append(pose)

        
        #Publish the Path for Rviz 
        self.path_pub.publish(many_path)
        #move robot along path
        self.go_through_path(pose_list)


    #Send the Poses to to the Nav_stack
    def go_through_path(self,pose_list ):

        ii = self.step
        #loop through all the points in the list
        while ii  < len(pose_list):
            pose_list[ii].header.stamp = rospy.Time.now()
            self.move(pose_list[ii])
            ii = ii + self.step 
        #send the last pose
        self.move(pose_list[-1])
        
    
    #move the robot
    def move(self,pose):

        goal = MoveBaseGoal()
        goal.target_pose.header.stamp = rospy.Time.now()
        #set the new goal
        goal.target_pose =  pose
        # Send the goal pose to the MoveBaseAction server
        self.move_base.send_goal(goal)
        #get time 
        # Allow 1 minute to get there
        finished_within_time = self.move_base.wait_for_result(rospy.Duration(self.break_out_time)) 
  
        # If we don't get there in time, abort the goal
        if not finished_within_time:
            self.move_base.cancel_goal()
            rospy.loginfo("Timed out achieving goal")
            print "time out"
        else:
            # We made it!
            state = self.move_base.get_state()
            if state == GoalStatus.SUCCEEDED:
                rospy.loginfo("Goal succeeded!")
                print "goal"


    def send_comands(self, pos):

        try:
            (trans,rot) = listener.lookupTransform('odom', 'base_footprint', rospy.Time(0))
        except (tf.LookupException, tf.ConnectivityException, tf.ExtrapolationException):
            continue 

        

