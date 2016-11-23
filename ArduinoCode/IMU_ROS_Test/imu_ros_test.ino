#include <ArduinoHardware.h>
#include <Wire.h>
#include <BMSerial.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <omni_shot/my_imu.h>

#if (ARDUINO >= 100)
#include <Arduino.h>
#else
#include <WProgram.h>
#endif
#include <ros.h>
#include <sensor_msgs/Imu.h>
#include <std_msgs/String.h>

#define BNO055_SAMPLERATE_DELAY_MS (100)

ros::NodeHandle  nh;
omni_shot::imu_msg imu_msg;



ros::Publisher imu_sensor("imu", &imu_msg);

void setUpIMU();


Adafruit_BNO055 bno = Adafruit_BNO055(55);

void setup() 
{
    nh.initNode();
   
    
    imu_msg.header.frame_id =   "/imu";
    imu_msg.header.stamp=nh.now();
    nh.advertise(imu_sensor);
    //bno.begin();
    if (!bno.begin())
    {
        /* There was a problem detecting the BNO055 ... check your connections */
        
        while (1);
    }
    ///setUpIMU();
 


}

void loop() 
{
  // put your main code here, to run repeatedly: 
   
    nh.spinOnce();
    imu::Vector<3> gyro = bno.getVector(Adafruit_BNO055::VECTOR_GYROSCOPE);
    imu::Vector<3> accelerometer = bno.getVector(Adafruit_BNO055::VECTOR_ACCELEROMETER);
    imu::Quaternion quat = bno.getQuat();
    

    // sensor_msgs::Imu imu_msg;
    imu_msg.orientation.x = quat.x();
    imu_msg.orientation.y = quat.y();
    imu_msg.orientation.z = quat.z();
    imu_msg.orientation.w = quat.w();

    imu_msg.angular_velocity.x = gyro.x();
    imu_msg.angular_velocity.y = gyro.y();
    imu_msg.angular_velocity.z = gyro.z();

    imu_msg.linear_acceleration.x = accelerometer.x();
    imu_msg.linear_acceleration.y = accelerometer.y();
    imu_msg.linear_acceleration.z = accelerometer.z();
    
    imu_sensor.publish(&imu_msg);
    //delay(BNO055_SAMPLERATE_DELAY_MS);
  
    //delay(1000);
}



//calibrate IMU
void setUpIMU()
{
    adafruit_bno055_offsets_t calibrationData;

    calibrationData.accel_offset_x = 65523;
    calibrationData.accel_offset_y = 65529;
    calibrationData.accel_offset_z = 16;

    calibrationData.gyro_offset_x = 65531;
    calibrationData.gyro_offset_y = 1;
    calibrationData.gyro_offset_z = 65535;

    calibrationData.mag_offset_x = 65515;
    calibrationData.mag_offset_y = 65;
    calibrationData.mag_offset_z = 65507;

    calibrationData.accel_radius = 1000;
    calibrationData.mag_radius = 1116;
    bno.setSensorOffsets(calibrationData);


}