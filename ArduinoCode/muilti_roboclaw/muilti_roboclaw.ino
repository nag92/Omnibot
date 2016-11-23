#include <BMSerial.h>
#include <RoboClaw.h>

#include <ArduinoHardware.h>
#include <Wire.h>

#include <omni_shot/motors.h>

#if (ARDUINO >= 100)
#include <Arduino.h>
#else
#include <WProgram.h>
#endif
#include <ros.h>
#include <sensor_msgs/Imu.h>
#include <std_msgs/String.h>


//Roboclaw Address
#define address_12 0x80
#define address_34 0x81

//Velocity PID coefficients
#define Kp 1.0
#define Ki 0.5
#define Kd 0.25
#define qpps 44000

//transform motor.msg to array
void send_cmd_to_motor( double rawSpeeds[4] );
//
void motorToArray(const omni_shot::motors& msg);


BMSerial terminal(0,1);

//Setup communcaitions with roboclaw. Use pins 10 and 11 with 10ms timeout
RoboClaw roboclaw_12(15,14,10000);
RoboClaw roboclaw_34(17,16,10000);

//set up ROS communication
ros::NodeHandle  nh;
omni_shot::motors motors;
ros::Subscriber<omni_shot::motors> sub("ball_velocity", motorToArray);
omni_shot::motors encoders;
ros::Publisher encoders_msg("encoders", &encoders);


void setup() 
{
  //Open terminal and roboclaw serial ports
  nh.initNode();
  nh.subscribe(sub);
  nh.advertise(encoders_msg);

  terminal.begin(57600);
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
  
  sendEncoders();
  delay(1);
  
}

void sendEncoders()
{
  uint8_t status1,status2,status3,status4;
  bool valid[4];
  int32_t readings[4];
  int32_t speed[4];

  speed[0] = roboclaw_12.ReadSpeedM1(address_12, &status1, &valid[0]);
  speed[1] = roboclaw_12.ReadSpeedM1(address_12, &status2, &valid[1]);
  speed[2] = roboclaw_34.ReadSpeedM1(address_34, &status3, &valid[2]);
  speed[3] = roboclaw_34.ReadSpeedM1(address_34, &status4, &valid[3]);


  for( unsigned int i  = 0; i<4; i++)
  {
  	if(valid[i])
  	{
    	readings[i] = speed[i];
  	}	
  	else
  	{
    	readings[i] = 1089;
  	}
  }

  encoders.m1 = readings[0];
  encoders.m2 = readings[1];
  encoders.m3 = readings[2];
  encoders.m4 = readings[3];


}

void motorToArray(const omni_shot::motors& msg)
{

  double rawSpeeds[4];
  rawSpeeds[0] = msg.m1;
  rawSpeeds[1] = msg.m2;
  rawSpeeds[2] = msg.m3;
  rawSpeeds[3] = msg.m4;
  send_cmd_to_motor(rawSpeeds);

}


/*
  This function takes in a motor msg and sends it to the roboclaw
  It utlizes the Foward and Backward commands
  */

void send_cmd_to_motor( double rawSpeeds[4])
{
  int minSpeed = 0;
  int maxSpeed = 100;
  double calSpeed[4];
 
  double tempSpeed; 
  
  
  for( unsigned int i = 0; i<4;i++)
  {
    tempSpeed =  map(abs(rawSpeeds[i]), minSpeed, maxSpeed, 0, 127);
    calSpeed[i] = constrain(tempSpeed, 0, 127);
  }

  
  // terminal.print("m1 ");
  // terminal.println(rawSpeeds[0]);
  // terminal.print("m2 ");
  // terminal.println(rawSpeeds[1]);
  // terminal.print("m3 ");
  // terminal.println(rawSpeeds[2]);
  // terminal.print("m4 ");
  // terminal.println(rawSpeeds[3]);

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