#include <Arduino_BMI270_BMM150.h>

// Target sampling frequency: 50 Hz -> Period = 20 milliseconds
const unsigned long SAMPLE_INTERVAL_MS = 20;
unsigned long lastSampleTime = 0;

void setup() {
  // Initialize USB Serial communication at 115200 baud
  Serial.begin(115200);
  while (!Serial);  // Wait for the Serial Monitor to open

  // Initialize the IMU sensor
  if (!IMU.begin()) {
    Serial.println("ERROR: Failed to initialize BMI270 IMU!");
    while(1); // Halt execution if sensor fails
  }
  
  // Print CSV header row
  Serial.println("timestamp_ms, acc_x, acc_y, acc_z, gyro_x, gyro_y, gyro_z");
}

void loop() {
  unsigned long currentTime = millis();

  // Check if 20ms have elapsed to maintain ~50 Hz sampling rate
  if (currentTime - lastSampleTime >= SAMPLE_INTERVAL_MS) {
    lastSampleTime = currentTime; // Reset our timer anchor

    float accX, accY, accZ;
    float gyroX, gyroY, gyroZ;

    // Read accelerometer data (in g-forces) and gyroscope data (in degrees/sec)
    if (IMU.accelerationAvailable() && IMU.gyroscopeAvailable()) {
      IMU.readAcceleration(accX, accY, accZ);
      IMU.readGyroscope(gyroX, gyroY, gyroZ);

      // Print data out in CSV format
      Serial.print(currentTime);
      Serial.print(",");
      Serial.print(accX, 4);
      Serial.print(",");
      Serial.print(accY, 4);
      Serial.print(",");
      Serial.print(accZ, 4);
      Serial.print(",");
      Serial.print(gyroX, 4);
      Serial.print(",");
      Serial.print(gyroY, 4);
      Serial.print(",");
      Serial.println(gyroZ, 4);
    }
  }
}
