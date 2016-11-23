


#if (ARDUINO >= 100)
#include <Arduino.h>
#else
#include <WProgram.h>
#endif
#include <ros.h>
#include <omni_shot/motors.h>

//LED pins
#define M_1_F 13
#define M_1_R 12

#define M_2_F 10
#define M_2_R 9

#define M_3_F 7
#define M_3_R 6

#define M_4_F 4
#define M_4_R 3

ros::NodeHandle  nh;

//functons

void motor(const omni_shot::motors& msg)
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



//calls motor when a message is sent
ros::Subscriber<omni_shot::motors> sub("ball_velocity", motor);




void setup()
{
  //set up ROS
  nh.initNode();
  nh.subscribe(sub);
  
  //set up LEDS
  pinMode(M_1_F, OUTPUT);
  pinMode(M_1_R, OUTPUT);
  pinMode(M_2_F, OUTPUT);
  pinMode(M_2_R, OUTPUT);
  pinMode(M_3_F, OUTPUT);
  pinMode(M_3_R, OUTPUT);
  pinMode(M_4_F, OUTPUT);
  pinMode(M_4_R, OUTPUT);
  
  
}


void loop()
{
  nh.spinOnce();
  delay(1);

  
  while (nh.connected())
  {
      nh.spinOnce();
      delay(1);
  }
}



