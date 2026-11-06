const int ledPin = 13; // Constant pin mapping
int brightness = 0;    // Variable state

void setup() {
  pinMode(ledPin, OUTPUT);
}

void loop() {
  brightness = 150; // Changing variable state
  analogWrite(ledPin, brightness);
}
