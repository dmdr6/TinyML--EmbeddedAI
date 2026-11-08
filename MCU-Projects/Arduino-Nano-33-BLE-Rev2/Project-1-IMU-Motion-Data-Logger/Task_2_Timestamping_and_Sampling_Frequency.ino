/*
 * Project 1: IMU Motion Data Logger - Task 2: Timestamping & Sampling Frequency
 * Board: Arduino Nano 33 BLE Rev2 (nRF52840 + BMI270)
*/

#include <Arduino_BMI270_BMM150.h>

// Variables for timing calculations
unsigned long previousMicros = 0;

void setup() {
  // Initialize serial communication at high baud rate to minimize transmission bottlenecks
  Serial.begin(115200);
  while (!Serial) {
    // Wait for the serial monitor to open
    delay(10);
  }

  Serial.println("Initializing BMI270 IMU for Data Acquisition & Timing...");

  // Initialize IMU sensor
  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU! Check hardware or wiring.");
    while (1) {
      // Halt execution if initialization fails
      delay(1000);
    }
  }

  Serial.println("IMU Initialized successfully.");
  Serial.println("------------------------------------------------------------------------------");

  // Print structured CSV Header
  Serial.println("Timestamp_us,Delta_us,Fs_Hz,Accel_X_g,Accel_Y_g,Accel_Z_g,Gyro_X_dps,Gyro_Y_dps,Gyro_Z_dps");

  // Initialize baseline timestamp
  previousMicros = micros();
}

void loop() {
  float ax, ay, az;
  float gx, gy, gz;

  // Poll the IMU to check if new data is ready
  if (IMU.accelerationAvailable() && IMU.gyroscopeAvailable()) {

    // Capture high-resolution timestamp immediately upon data availability
    unsigned long currentMicros = micros();

    // Calculate delta time (dt) since the last sample
    unsigned long deltaMicros = currentMicros - previousMicros;
    previousMicros = currentMicros;

    // Calculate instantaneous sampling frequency in Hz (avoid division by zero)
    float samplingFreq = (deltaMicros > 0) ? (1000000.0 / deltaMicros) : 0.0f; 

    // Read raw sensor values into variables
    IMU.readAcceleration(ax, ay, az);
    IMU.readGyroscope(gx, gy, gz);

    // Format and output data as a structured CSV row
    Serial.print(currentMicros); Serial.print(",");
    Serial.print(deltaMicros); Serial.print(",");
    Serial.print(samplingFreq, 2); Serial.print(",");
    Serial.print(ax, 4); Serial.print(",");
    Serial.print(ay, 4); Serial.print(",");
    Serial.print(az, 4); Serial.print(",");
    Serial.print(gx, 4); Serial.print(",");
    Serial.print(gy, 4); Serial.print(",");
    Serial.println(gz, 4);
  }
}

