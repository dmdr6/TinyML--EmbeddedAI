#include <cstdint>

uint8_t sensorAddress = 0x68;   // 1-byte I2C address
uint16_t rawADCReading = 1023;  // 2-byte ADC sample
uint32_t timestampMs = 86400000UL;  // 4-byte millisecond counter
