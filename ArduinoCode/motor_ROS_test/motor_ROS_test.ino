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
#define address 0x80

//Velocity PID coefficients
#define Kp 1.0
#define Ki 0.5
#define Kd 0.25
#define qpps 44000

void send_cmd_to_motor( double rawSpeeds[4] );
void motorToArray(const omni_shot::motors& msg);


BMSerial terminal(0,1);

//Setup communcaitions with roboclaw. Use pins 10 and 11 with 10ms timeout
RoboClaw roboclaw(15,14,10000);



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

  //terminal.begin(57600);
  roboclaw.begin(38400);

      
  //Set PID Coefficients
  roboclaw.SetM1VelocityPID(address,Kd,Kp,Ki,qpps);
  roboclaw.SetM2VelocityPID(address,Kd,Kp,Ki,qpps);  
}

void loop() 
{
  nh.spinOnce();
  
  
  delay(1);
  
}

void sendEncoders()
{
  uint8_t status1,status2,status3,status4;
  bool valid1,valid2,valid3,valid4;
  int32_t speed1 = roboclaw.ReadSpeedM1(address, &status1, &valid1);
  int32_t speed2 = roboclaw.ReadSpeedM1(address, &status2, &valid1);
  int32_t speed3 = roboclaw.ReadSpeedM1(address, &status3, &valid2);
  int32_t speed4 = roboclaw.ReadSpeedM1(address, &status4, &valid4);

  if(valid1)
  {
    encoders.m1 = speed1;
    encoders_msg.publish(&encoders);  
  }
  else
  {
    encoders.m1 = 1089;
    encoders_msg.publish(&encoders);  

  }
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


/*This function takes in a motor msg and sends it to the roboclaw
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

  if(rawSpeeds[0] >= 0)
    roboclaw.ForwardM1(address,calSpeed[0]);
  else
    roboclaw.BackwardM1(address, calSpeed[0] );

  if(calSpeed[1] >= 0)
    roboclaw.ForwardM2(address,calSpeed[1]);
  else
    roboclaw.BackwardM2(address,calSpeed[1]);

// if(msg.m1 >= 0)
//   roboclaw.ForwardM1(address,msg.m1);
// else
//   roboclaw.BackwardM1(address,abs(msg.m1));

// if(msg.m1 >= 0)
//   roboclaw.ForwardM1(address,msg.m1);
// else
//   roboclaw.BackwardM1(address,abs(msg.m1));

}