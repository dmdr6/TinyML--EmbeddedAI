#include <Arduino_BMI270_BMM150.h>

// --- Configuration Constants ---
const unsigned long TARGET_INTERVAL_US = 20000; // 20 ms -> 50 Hz
const int BUFFER_SIZE = 50;                     // 1 second window at 50 Hz

// --- Struct for Sensor Data ---
struct SensorSample {
  unsigned long timestamp_us;
  float accX, accY, accZ;
  float gyroX, gyroY, gyroZ;
};

// --- Circular Buffer ---
SensorSample sensorBuffer[BUFFER_SIZE];
int bufferHead = 0;
int sampleCount = 0;

// --- Gyroscope Calibration Offsets ---
float gyroBiasX = 0.0f;
float gyroBiasY = 0.0f;
float gyroBiasZ = 0.0f;

// --- Timing Variables ---
unsigned long lastSampleMicros = 0;
unsigned long executionStatsTimer = 0;
unsigned long sampleCounterStats = 0;

void calibrateGyro() {
  Serial.println("CALIBRATION: Keep the board completely still...");
  delay(1000); // Allow user to settle the board

  const int numSamples = 200;
  float sumX = 0, sumY = 0, sumZ = 0;
  int collected = 0;

  while (collected < numSamples) {
    if (IMU.gyroscopeAvailable()) {
      float gx, gy, gz;
      IMU.readGyroscope(gx, gy, gz);
      sumX += gx;
      sumY += gy;
      sumZ += gz;
      collected++;
      delay(5); // small pause between calibration reads
    }
  }

  gyroBiasX = sumX / numSamples;
  gyroBiasY = sumY / numSamples;
  gyroBiasZ = sumZ / numSamples;

  Serial.print("CALIBRATION COMPLETE. Offsets -> X: ");
  Serial.print(gyroBiasX, 4);
  Serial.print(" | Y: ");
  Serial.print(gyroBiasY, 4);
  Serial.print(" | Z: ");
  Serial.println(gyroBiasZ, 4);
}

void setup() {
  Serial.begin(115200);
  while (!Serial);

  if (!IMU.begin()) {
    Serial.println("ERROR: Failed to initialize BMI270 IMU!");
    while (1);
  }

  // Run startup gyroscope calibration
  calibrateGyro();

  Serial.println("timestamp_us,acc_x,acc_y,acc_z,gyro_x_corr,gyro_y_corr,gyro_z_corr,actual_dt_us,jitter_us");
  lastSampleMicros = micros();
  executionStatsTimer = millis();
}
