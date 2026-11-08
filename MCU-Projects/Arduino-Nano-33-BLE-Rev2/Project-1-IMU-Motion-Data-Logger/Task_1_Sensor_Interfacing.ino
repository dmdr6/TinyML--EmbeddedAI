/*
 * Project 1: IMU Motion Data Logger - Task 1: Sensor Interfacing
 * Board: Arduino Nano 33 BLE Rev2 (nRF52840 + BMI270)
*/

#include <Arduino_BMI270_BMM150.h>

void setup() {
  // Initialize serial communication at 115200 baud for fast data transmission
  Serial.begin(115200);
  while (!Serial) {
    // Wait for the serial monitor to open
    delay(10);
  }

  Serial.println("Initializing BMI270 IMU...");

  // Initialize IMU sensor
  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU! Check hardware or wiring.");
    while (1) {
      // Halt execution if initialization fails
      delay(1000);
    }
  }

  Serial.println("BMI270 initialized successfully!");
  Serial.println("----------------------------------------------------------------");
  Serial.println("Accel_X (g), Accel_Y (g), Accel_Z (g), Gyro_X (dps), Gyro_Y (dps), Gyro_Z (dps)");
}

void loop() {
  float ax, ay, az;
  float gx, gy, gz;

  // Check if new sensor data is available to be read
  if (IMU.accelerationAvailable() && IMU.gyroscopeAvailable()) {

    // Read acceleration values in g's
    IMU.readAcceleration(ax, ay, az);

    // Read gyroscope values in degrees per second (dps)
    IMU.readGyroscope(gx, gy, gz);

    // Print CSV-formatted data to the Serial Monitor
    Serial.print(ax, 4); Serial.print(",");
    Serial.print(ay, 4); Serial.print(",");
    Serial.print(az, 4); Serial.print(",");
    Serial.print(gx, 4); Serial.print(",");
    Serial.print(gy, 4); Serial.print(",");
    Serial.println(gz, 4);
  }

  // Small delay to prevent flooding the serial buffer (adjust as needed for sampling rate tasks later)
  delay(10);
}
