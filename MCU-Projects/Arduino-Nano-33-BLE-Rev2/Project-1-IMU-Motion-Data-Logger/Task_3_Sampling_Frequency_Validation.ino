/*
 * Project 1: IMU Motion Data Logger - Task 3: Sampling Frequency Validation
 * Board: Arduino Nano 33 BLE Rev2 (nRF52840 + BMI270)
*/

#include <Arduino_BMI270_BMM150.h>

// Timing and statistics variables
unsigned long previousMicros = 0;
unsigned long sampleCount = 0;
unsigned long windowStartTime = 0;

// Jitter tracking variables
unsigned long minDelta = 0xFFFFFFFF;  // Initialize to max possible value
unsigned long maxDelta = 0;

const unsigned long statsIntervalMs = 1000;  // Print stats every 1 second

void setup() {
  // Initialize serial communication at high baud rate to minimize transmission bottlenecks
  Serial.begin(115200);
  while (!Serial) {
    // Wait for the serial monitor to open
    delay(10);
  }

  Serial.println("Initializing BMI270 for Sampling Frequency Validation...");

  // Initialize IMU sensor
  if (!IMU.begin()) {
    Serial.println("Failed to initialize IMU! Check hardware or wiring.");
    while (1) {
      // Halt execution if initialization fails
      delay(1000);
    }
  }

  Serial.println("IMU Initialized successfully.");
  Serial.println("------------------------------------------------------------------------------------------------");
  Serial.println("Monitoring sampling frequency, delta times, and jitter...");

  previousMicros = micros();
  windowStartTime = millis();
}

void loop() {
  float ax, ay, az;
  float gx, gy, gz;

  if (IMU.accelerationAvailable() & IMU.gyroscopeAvailable()) {
    unsigned long currentMicros = micros();
    unsigned long deltaMicros = currentMicros - previousMicros;
    previousMicros = currentMicros;

    sampleCount++;

    // Update min and max delta tracking (ignoring the very first sample startup spike)
    if (sampleCount > 1) {
      if (deltaMicros < minDelta) minDelta = deltaMicros;
      if (deltaMicros > maxDelta) maxDelta = deltaMicros;
    }

    // Read sensor data
    IMU.readAcceleration(ax, ay, az);
    IMU.readGyroscope(gx, gy, gz);

    // Every 1 second, print a diagnostic summary of the sampling frequency and jitter
    unsigned long currentMillis = millis();
    if (currentMillis - windowStartTime >= statsIntervalMs) {
      float avgDeltaUs = (float)(currentMillis - windowStartTime) * 1000.0f / sampleCount;
      float calculatedFs = 1000000.0f / avgDeltaUs;

      Serial.println("-----------------------------------------------");
      Serial.print("Diagnostics Summary (Last 1s):\n");
      Serial.print("  Total Samples: "); Serial.println(sampleCount);
      Serial.print("  Average Fs:    "); Serial.print(calculatedFs, 2); Serial.println("Hz");
      Serial.print("  Min Delta:     "); Serial.print(minDelta); Serial.println(" us");
      Serial.print("  Max Delta:     "); Serial.print(maxDelta); Serial.println(" us");
      Serial.print("  Jitter Range:  "); Serial.print(maxDelta - minDelta); Serial.println(" us");
      Serial.println("-----------------------------------------------");

      // Reset window counters
      sampleCount = 0;
      windowStartTime = currentMillis;
      minDelta = 0xFFFFFFFF;
      maxDelta = 0;
    }
  }
}
