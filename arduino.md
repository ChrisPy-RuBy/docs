Title: Arduino
summary: place for stuff regarding getting ardiuno to do stuff
- - - 

# Basics

## Using the IDE

Download from arduino website
- create a new sketch with new
- write somecode 
- check it with verify button
- push to arduino with upload button. Simplez

## Running from eommandline

brew install arduino-cli

### Setup
- arduino-cli core update-index
- arduino-cli board list # make note of the Core, FQBN and PORT
- arduino-cli core install <core>
# create a sketch
- arduino-cli sketch new MyFirstSketch
# compile sketch
- arduino-cli compile --fqbn <FQBN> MyFirstSketch
# upload
- arduino-cli upload -p <PORT> --fqbn <FQBN> MyFirstSketch

## installing packages

find the package that you want.
check it exisits
```
# checks index for package name
arduino-cli lib search RTClib
# install
arduino-cli lib install RTClib
```


## basic blink

```c
const int LED = 13; // LED connected to digital pin 13

void setup() {
  pinMode(LED, OUTPUT);  // sets digital pins as output
}
§
void loop() {
  digitalWrite(LED, HIGH);  // turn LED on
  delay(10);              // wait 1000 ms
  digitalWrite(LED, LOW);   // turn LED off
  delay(500);
}
```

## Terminology

- GND: ground or negative side of circuit
