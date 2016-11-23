

#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>
#include <EEPROM.h>

#define BNO055_SAMPLERATE_DELAY_MS (100)

Adafruit_BNO055 bno = Adafruit_BNO055(55);

void displaySensorOffsets(const adafruit_bno055_offsets_t &calibrationData)
{
  
    Serial.print("Accelerometer: ");
    Serial.print(calibrationData.accel_offset_x); Serial.print(" ");
    Serial.print(calibrationData.accel_offset_y); Serial.print(" ");
    Serial.print(calibrationData.accel_offset_z); Serial.print(" ");

    Serial.print("\nGyro: ");
    Serial.print(calibrationData.gyro_offset_x); Serial.print(" ");
    Serial.print(calibrationData.gyro_offset_y); Serial.print(" ");
    Serial.print(calibrationData.gyro_offset_z); Serial.print(" ");

    Serial.print("\nMag: ");
    Serial.print(calibrationData.mag_offset_x); Serial.print(" ");
    Serial.print(calibrationData.mag_offset_y); Serial.print(" ");
    Serial.print(calibrationData.mag_offset_z); Serial.print(" ");

    Serial.print("\nAccel Radius: ");
    Serial.print(calibrationData.accel_radius);

    Serial.print("\nMag Radius: ");
    Serial.print(calibrationData.mag_radius);
    
}

void displayCalStatus(void)
{
    /* Get the four calibration values (0..3) */
    /* Any sensor data reporting 0 should be ignored, */
    /* 3 means 'fully calibrated" */
    uint8_t system, gyro, accel, mag;
    system = gyro = accel = mag = 0;
    bno.getCalibration(&system, &gyro, &accel, &mag);

    /* The data should be ignored until the system calibration is > 0 */
    Serial.print("\t");
    if (!system)
    {
        Serial.print("! ");
    }

    /* Display the individual values */
    Serial.print("Sys:");
    Serial.print(system, DEC);
    Serial.print(" G:");
    Serial.print(gyro, DEC);
    Serial.print(" A:");
    Serial.print(accel, DEC);
    Serial.print(" M:");
    Serial.print(mag, DEC);
}
void setup() 
{
  Serial.begin(115200);
  delay(1000);
    
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
  //bno.setSensorOffsets(calibrationData);
  // put your setup code here, to run once:

}

void loop() 
{
  // put your main code here, to run repeatedly:
  displayCalStatus();
}
