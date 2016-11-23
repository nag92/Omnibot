#include <BMSerial.h>
#include <RoboClaw.h>

#include <ArduinoHardware.h>
#include <Wire.h>

#include <omni_shot/motors.h>
#include <omni_shot/trajectory_poly.h>
#include <ros/time.h>
#if (ARDUINO >= 100)
#include <Arduino.h>
#else
#include <WProgram.h>
#endif
#include <ros.h>
#include <sensor_msgs/Imu.h>
#include <std_msgs/String.h>
#include <std_msgs/Bool.h>


//Roboclaw Address
#define address_12 0x80
#define address_34 0x81

//Velocity PID coefficients
#define Kp 35.38994
#define Ki 89.29913 
#define Kd 0
#define qpps 379020
//BMSerial terminal(0,1);
///////////
//led testing
//LED pins
#define M_1_F 13
#define M_1_R 12

#define M_2_F 10
#define M_2_R 9

#define M_3_F 7
#define M_3_R 6

#define M_4_F 4
#define M_4_R 3
////

//transform motor.msg to array
void sendCmdToMotor( double rawSpeeds[4] );
void motorToArray(const omni_shot::motors& msg);
void deadman(const std_msgs::Bool& msg);
void led(const omni_shot::motors& msg);
//Setup communcaitions with roboclaw. Use pins 10 and 11 with 10ms timeout
RoboClaw roboclaw_12(15,14,10000);
RoboClaw roboclaw_34(17,16,10000);



//set up ROS communication
ros::NodeHandle  nh;
omni_shot::motors motors;

int safe;

ros::Subscriber<omni_shot::motors> ball_velocity_sub("ball_velocity", motorToArray);



void setup() 
{
  //Open terminal and roboclaw serial ports
  nh.initNode();
  nh.subscribe(ball_velocity_sub);
 

  //terminal.begin(57600);
  roboclaw_12.begin(38400);
  roboclaw_34.begin(38400);
  
  
  //Set PID Coefficients
  roboclaw_12.SetM1VelocityPID(address_12,Kd,Kp,Ki,qpps);
  roboclaw_12.SetM2VelocityPID(address_12,Kd,Kp,Ki,qpps);  
  roboclaw_34.SetM1VelocityPID(address_34,Kd,Kp,Ki,qpps);
  roboclaw_34.SetM2VelocityPID(address_34,Kd,Kp,Ki,qpps); 

 

}

void loop() 
{

  nh.spinOnce();
  delay(1);

  //this is an attempt to send zeros to the claws of it loses communitation with ROS
  while (nh.connected())
  {
     nh.spinOnce();
     delay(1);
  }


  // double rawSpeeds[4];
  // rawSpeeds[0] = 0;
  // rawSpeeds[1] = 0;
  // rawSpeeds[2] = 0;
  // rawSpeeds[3] = 0;
  // sendCmdToMotor(rawSpeeds);

 
}

//convert a motors.msg to an array
void motorToArray(const omni_shot::motors& msg)
{
	double rawSpeeds[4];

  led(msg);
  rawSpeeds[0] = msg.m1;
  rawSpeeds[1] = msg.m2;
  rawSpeeds[2] = msg.m3;
  rawSpeeds[3] = msg.m4;
  sendCmdToMotor(rawSpeeds);
}



void sendCmdToMotor( double rawSpeeds[4])
{
  int minSpeed = 0;
  int maxSpeed = 100;
  double calSpeed[4];
  double tempSpeed; 
  
  //remap for roboclaw speeds
  for( unsigned int i = 0; i<4;i++)
  {
    tempSpeed =  map(abs(rawSpeeds[i]), minSpeed, maxSpeed, 0, 127);
    calSpeed[i] = constrain(tempSpeed, 0, 127);
  }

 
  //send to roboclaws
  if(rawSpeeds[0] >= 0)
    roboclaw_12.ForwardM1(address_12,calSpeed[0]);
  else
    roboclaw_12.BackwardM1(address_12, calSpeed[0] );
  
  if(rawSpeeds[1] >= 0)
    roboclaw_12.ForwardM2(address_12,calSpeed[1]);
  else
    roboclaw_12.BackwardM2(address_12, calSpeed[1] );
  
  if(rawSpeeds[2] >= 0)
    roboclaw_34.ForwardM1(address_34,calSpeed[2]);
  else
    roboclaw_34.BackwardM1(address_34, calSpeed[2] );
  
  if(rawSpeeds[3] >= 0)
    roboclaw_34.ForwardM2(address_34,calSpeed[3]);
  else
    roboclaw_34.BackwardM2(address_34, calSpeed[3] );

}
void led(const omni_shot::motors& msg)
{
  
  turnOff();
  
  double rawSpeeds[4];
  double calSpeeds[4];
  double tempSpeed = 0;
  double sensorMin = 0;
  double sensorMax = 100;
  rawSpeeds[0] = msg.m1;
  rawSpeeds[1] = msg.m2;
  rawSpeeds[2] = msg.m3;
  rawSpeeds[3] = msg.m4;
  
  for( unsigned int i = 0; i<4;i++)
  {
    tempSpeed =  map(abs(rawSpeeds[i]), sensorMin, sensorMax, 0, 255);
    calSpeeds[i] = constrain(tempSpeed, 0, 255);
  }
  
  //light up LEDs 
  if( rawSpeeds[0] > 0)
  {
    analogWrite(M_1_F,calSpeeds[0]);
  }
  else if( rawSpeeds[0]  < 0 )
  {
    analogWrite(M_1_R,calSpeeds[0]);
  } 
  
  if( rawSpeeds[1] > 0)
  {
    analogWrite(M_2_F,calSpeeds[1]);
  }
  else if( rawSpeeds[1]  < 0 )
  {
    analogWrite(M_2_R,calSpeeds[1]);
  } 
  
  
  if( rawSpeeds[2] > 0)
  {
    analogWrite(M_3_F,calSpeeds[2]);
  }
  else if( rawSpeeds[2]  < 0 )
  {
    analogWrite(M_3_R,calSpeeds[2]);
  } 
  
  
  if( rawSpeeds[3] > 0)
  {
    analogWrite(M_4_F,calSpeeds[3]);
  }
  else if( rawSpeeds[3]  < 0 )
  {
    analogWrite(M_4_R,calSpeeds[3]);
  } 
  
   
}



//turn off all LEDs
void turnOff()
{
  analogWrite(M_1_F,LOW);
  analogWrite(M_1_R,LOW);
  analogWrite(M_2_F,LOW);
  analogWrite(M_2_R,LOW);
  analogWrite(M_3_F,LOW);
  analogWrite(M_3_R,LOW);
  analogWrite(M_4_F,LOW);
  analogWrite(M_4_R,LOW); 
}
