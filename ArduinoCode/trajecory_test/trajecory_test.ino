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

//transform motor.msg to array
void sendCmdToMotor( double rawSpeeds[4] );
//
void motorToArray(const omni_shot::motors& msg);
void followPath(const omni_shot::trajectory_poly& msg);


BMSerial terminal(0,1);

//Setup communcaitions with roboclaw. Use pins 10 and 11 with 10ms timeout
RoboClaw roboclaw_12(15,14,10000);
RoboClaw roboclaw_34(17,16,10000);


//set up ROS communication
ros::NodeHandle  nh;
omni_shot::motors motors;
omni_shot::motors encoders;
omni_shot::motors encoderSpeeds;
std_msgs::Bool safe;

ros::Subscriber<omni_shot::motors> ball_velocity_sub("ball_velocity", motorToArray);
ros::Subscriber<omni_shot::trajectory_poly> followPath_sub("followPath", followPath);

ros::Publisher encoders_msg("encoders", &encoders);
ros::Publisher encoderSpeeds_msg("encoderSpeeds", &encoderSpeeds);
ros::Publisher safe_msg("safe", &safe);

void setup() 
{
  //Open terminal and roboclaw serial ports
  nh.initNode();
  nh.subscribe(ball_velocity_sub);
  nh.subscribe(followPath_sub);
  nh.advertise(encoders_msg);
  nh.advertise(encoderSpeeds_msg);
  nh.advertise(safe_msg);



  //terminal.begin(57600);
  roboclaw_12.begin(38400);
  roboclaw_34.begin(38400);
  
  
  //Set PID Coefficients
  roboclaw_12.SetM1VelocityPID(address_12,Kd,Kp,Ki,qpps);
  roboclaw_12.SetM2VelocityPID(address_12,Kd,Kp,Ki,qpps);  
  roboclaw_34.SetM1VelocityPID(address_34,Kd,Kp,Ki,qpps);
  roboclaw_34.SetM2VelocityPID(address_34,Kd,Kp,Ki,qpps); 

  safe.data = true; 
}

void loop() 
{

  
    sendEncoders();
    sendSpeed();
    nh.spinOnce();
    delay(1);
      
  
 
  omni_shot::motors kill;
  kill.m1 = 0;
  kill.m2 = 0;
  kill.m3 = 0;
  kill.m4 = 0;
  motorToArray(kill);
  
}

/*This function use the "encoders" */
void sendEncoders()
{
  uint8_t status1,status2,status3,status4;
  bool valid[4];
  int32_t readings[4];
  int32_t speed[4];
  encoders.header.stamp = nh.now();
  speed[0] = roboclaw_12.ReadEncM1(address_12, &status1, &valid[0]);
  speed[1] = roboclaw_12.ReadEncM2(address_12, &status2, &valid[1]);
  speed[2] = roboclaw_34.ReadEncM1(address_34, &status3, &valid[2]);
  speed[3] = roboclaw_34.ReadEncM2(address_34, &status4, &valid[3]);


  for( unsigned int i  = 0; i<4; i++)
  {
  	if(valid[i])
  	{
    	readings[i] = speed[i];
  	}	
  	else
  	{
    	readings[i] = 1089;
      safe.data = 0;
  	}
  }

  encoders.m1 = readings[0];
  encoders.m2 = readings[1];
  encoders.m3 = readings[2];
  encoders.m4 = readings[3];

  encoders_msg.publish(&encoders);

}

void sendSpeed()
{
 
  uint8_t status1,status2,status3,status4;
  bool valid[4];
  int32_t readings[4];
  int32_t speed[4];
  encoderSpeeds.header.stamp = nh.now();
  speed[0] = roboclaw_12.ReadSpeedM1(address_12, &status1, &valid[0]);
  speed[1] = roboclaw_12.ReadSpeedM2(address_12, &status2, &valid[1]);
  speed[2] = roboclaw_34.ReadSpeedM1(address_34, &status3, &valid[2]);
  speed[3] = roboclaw_34.ReadSpeedM2(address_34, &status4, &valid[3]);


  for( unsigned int i  = 0; i<4; i++)
  {
    if(valid[i])
    {
      readings[i] = 60*(speed[i]/(1024*4));
    } 
    else
    {
      readings[i] = 1089;
      safe.data = 0;
    }
  }

  encoderSpeeds.m1 = readings[0];
  encoderSpeeds.m2 = readings[1];
  encoderSpeeds.m3 = readings[2];
  encoderSpeeds.m4 = readings[3];

  encoderSpeeds_msg.publish(&encoderSpeeds);
}


//called when a path is sent the to the arduino
void followPath(const omni_shot::trajectory_poly& msg )
{
    double dt = 0.01;
    double myTime  = 0;
    double v = 0;
    double omega = 0;
    double vx = 0, vy = 0;
    


    while( getSafe() && myTime <=  msg.time)    
    {
      v = msg.linear[1] + 2*msg.linear[2]*myTime + 3*msg.linear[3]*myTime*myTime;
      omega = msg.angular[1] + 2*msg.angular[2]*myTime + 3*msg.angular[3]*myTime*myTime;
      vx = v*cos(msg.theta);
      vy = v*sin(msg.theta);
      sendCmdToMotor( convertToWheels(vx,vy,omega) );
      myTime = myTime + dt;
      delay(dt*10);
    }
}

bool getSafe()
{
  safe_msg.publish(&safe);
  return safe.data;
}

double* convertToWheels(double x,double y, double theta)
{
  double r = 0.3048;
  double motors[4];

  motors[0] = x  + theta*r;
  motors[1] = -y + theta*r;
  motors[2] = -x + theta*r;
  motors[3] = y  + theta*r;

  return motors;

}


//convert a motors.msg to an array
void motorToArray(const omni_shot::motors& msg)
{

  double rawSpeeds[4];
  rawSpeeds[0] = msg.m1;
  rawSpeeds[1] = msg.m2;
  rawSpeeds[2] = msg.m3;
  rawSpeeds[3] = msg.m4;
  sendCmdToMotor(rawSpeeds);


}

/*This function takes in a motor msg and sends it to the roboclaw
  It utlizes the Foward and Backward commands
  */

void sendCmdToMotor( double rawSpeeds[4])
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