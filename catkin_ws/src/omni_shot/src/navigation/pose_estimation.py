#!/usr/bin/env python
#import EKF
#import kalman_filter
import rospy 
import numpy as np
import csv
from std_msgs.msg import Float32MultiArray, String, Bool
import itertools
from omni_shot.msg import my_imu, motors


def wheel_senor_update(z):

  wheel_filter.update(z)

def encoderUpdate(z):
  ball_vel = []
  ratio = 0.0617
  ball_vel.append([z.m1*ratio])
  ball_vel.append([z.m2*ratio])
  ball_vel.append([z.m3*ratio])
  ball_vel.append([z.m4*ratio])
  wheel_senor_update(ball_vel)

def wheel_cmd(u):
  cmd = list(u.data)
  [cmd.append(0) for _ in xrange(4)]
  U = np.matrix(cmd).T
  wheel_filter.predict(U)
  print "wheel "  + str(wheel_filter.get_state())
  body_cmd( wheel_filter.get_state() )


def body_cmd(u):
  cmd = u.tolist()[0:4]
  U = list(itertools.chain(*cmd))
  temp  = body_filter.update([U,U,U,U])
  outputWriter.writerow( temp)

  print "body " + str( temp)
  

def body_setup():
  """set up the EKF for the body of the robot"""
  alpha_1 = 0
  alpha_2 = np.pi/2.0
  alpha_3 = np.pi
  alpha_4 = 1.5*np.pi
  pho = np.pi
  r = 0.3048
  
  angular_speed = np.sin(pho)/r

  x = lambda x, u,: x[0] + u[0]*np.cos(x[2]+alpha_1)*dt + u[1]*np.cos(x[2]+alpha_2)*dt + u[2]*np.cos(x[1]+alpha_3)*dt + u[3]*np.cos(x[2]+alpha_4)*dt 
  y = lambda x, u,: x[1] + u[0]*np.sin(x[2]+alpha_1)*dt + u[1]*np.sin(x[2]+alpha_2)*dt  + u[2]*np.sin(x[1]+alpha_3)*dt + u[3]*np.sin(x[2]+alpha_4)*dt
  theta = lambda x, u,: x[2] + u[0]*angular_speed*dt + u[1]*angular_speed*dt + u[2]*angular_speed*dt + u[3]*angular_speed*dt
  omega_4 = lambda x, u,: x[3]

  z1 = lambda x :  x[0] + 0 * x[1] + 0 * x[2] + 0 * x[3]
  z2 = lambda x :0 * x[0] + x[1] + 0 * x[2] + 0 * x[3]
  z3 = lambda x :0 * x[0] + 0 * x[1] + x[2] + 0 * x[3]
  z4 = lambda x :0 * x[0] + 0 * x[1] + 0 * x[2] + x[3]

  g = [ x,y,theta, omega_4]
  h = [z1, z2, z3, z4]
  start = [ [0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0],]
  pos = np.matrix([ [0], [0], [0], [0] ])
  v = 0

  u = [ v, v, v, v ]
  Q = np.eye(pos.shape[0]) 
  R = np.eye(pos.shape[0]) 
  sigma = np.eye(pos.shape[0])
  body_filter = EKF.EKF(g, h, sigma, Q, R, start)
  return body_filter


  
def wheel_setup():
    """set up the ball KF"""
    
    J = 0.000672041666667
    vel = dt/J 
    accel = (0.5*dt*dt)/J
    q = 1
    r = 1
    print "vel " + str(vel)
    print "accel " + str(accel)

    A = np.matrix([ [ 1, 0, 0, 0, 0, 0, 0,  0 ],#omega 1 
                    [ 0, 1, 0 ,0, 0, 0, 0,  0 ],#omega 2
                    [ 0, 0, 1, 0, 0, 0, 0,  0 ],#omega 3
                    [ 0, 0, 0, 1, 0, 0, 0,  0 ],#omega 4
                    [ dt, 0, 0, 0, 1, 0, 0, 0 ],#theta 1
                    [ 0, dt, 0 ,0, 0, 1, 0, 0 ],#theta 2
                    [ 0, 0, dt, 0, 0, 0, 1, 0 ],#theta 3
                    [ 0, 0, 0, dt, 0, 0, 0, 1 ]])#theta 4


    

    B =np.matrix( [ [ vel, 0, 0, 0, 0, 0, 0, 0   ],#omega 1 
                    [ 0, vel, 0 ,0, 0, 0, 0, 0   ],#omega 2
                    [ 0, 0, vel, 0, 0, 0, 0, 0   ],#omega 3
                    [ 0, 0, 0, vel, 0, 0, 0, 0   ],#omega 4
                    [ accel, 0, 0, 0, 0, 0, 0, 0 ],#theta 1
                    [ 0, accel, 0,0 , 0, 0, 0, 0 ],#theta 2
                    [ 0, 0, accel, 0, 0, 0, 0, 0 ],#theta 3
                    [ 0, 0, 0, accel, 0, 0, 0, 0 ]])#theta 4
    
    pos = np.matrix([[0],  # v_1
                     [0],  # v_2
                     [0],  # v_3
                     [0],  # v_4
                     [0],    
                     [0],
                     [0],
                     [0]])  # 

    C = np.eye(pos.shape[0]) 
    Q = np.eye(pos.shape[0]) * q
    R = np.eye(pos.shape[0]) * r
    P = np.eye(pos.shape[0])
    U = np.matrix([[0]])
    Z = np.matrix([[0], [0], [0], [0], [0], [0]])
    my_filter = kalman_filter.kalman_filter(A, B, C, Q, P, R, pos)
    
    return my_filter

def setup():
  """set up the filters"""

    wheel = wheel_setup()
    body = body_setup() 
    return (wheel, body)


def temp(s):
  """This is a hacked way of closing a open file I am writing to"""
  outputFile.close()

if __name__ == '__main__':
    
    #time step
    dt = 0.01
    #EKF 
    outputFile = open('estimate_pose3.csv', 'wb')
    outputWriter = csv.writer(outputFile)
    outputWriter.writerow(["X", "Y","Theta"])

    if __package__ is None:
        import sys
        from os import path
        sys.path.append( path.dirname( path.dirname( path.abspath(__file__) ) ) )
        from filters import kalman_filter 
        from filters import EKF 
    else:
        from ..filters import kalman_filter
        from ..filters import EKF 
        

    (wheel_filter, body_filter)  = setup()
    rospy.init_node('estimate_pose', anonymous=True)   
    rospy.Subscriber("torque", Float32MultiArray, wheel_cmd)
    rospy.Subscriber("close", String, temp)
    rospy.Subscriber("encoderSpeeds", motors, encoderUpdate)
    

    rospy.spin()