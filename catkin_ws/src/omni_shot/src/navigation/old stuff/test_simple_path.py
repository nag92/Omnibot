#!/usr/bin/env python
# test class for test_simple_path
import rospy
from std_msgs.msg import String
import sending_simple_goals
from geometry_msgs.msg import Pose
from nav_msgs.msg import Path
import numpy as np

def move():
   
    my_path = sending_simple_goals.sending_simple_goals(2,60)
    rospy.init_node('gen_path', anonymous=True)
    #rate = rospy.Rate(10) # 10hz
    path_pub = rospy.Publisher("aPlan",Path,queue_size=1)

    
    path = list()
    for ii in xrange(20):
        loc = Pose()#moved in to for loop
        loc.position.x = ii
        loc.position.y = np.sin(ii)
        loc.position.z = 0
        loc.orientation.w = 1.0;
        path.append(loc)
    
    
    while not rospy.is_shutdown():
        #print path
        
        my_path.new_path(path)
        
        rate.sleep()

if __name__ == '__main__':
    try:
        move()
    except rospy.ROSInterruptException:
        pass