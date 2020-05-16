Title: arduino
summary: place for stuff regarding getting ardiuno to do stuff
- - - 

# Basics

## Using the IDE

Download from arduino website
- create a new sketch with new
- write some code 
- check it with verify button
- push to arduino with upload button. Simplez

## Running from commandline

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
check it exists
```
# checks index for package name
arduino-cli lib search RTClib
# install
arduino-cli lib install RTClib
```


## basic blink

```
const int LED = 13; // LED connected to digital pin 13

void setup() {
  pinMode(LED, OUTPUT);  // sets digital pins as output
}

void loop() {
  digitalWrite(LED, HIGH);  // turn LED on
  delay(10);              // wait 1000 ms
  digitalWrite(LED, LOW);   // turn LED off
  delay(500);
}
```

## Terminology

- GND: ground or negative side of circuit

## Bugs / Issues/ Problems


### issue with uploading 

Restart the controlling device. If this is a Pi

```bash
Sketch uses 924 bytes (2%) of program storage space. Maximum is 32256 bytes.
Global variables use 9 bytes (0%) of dynamic memory, leaving 2039 bytes for local variables. Maximum is 2048 bytes.
uploading

avrdude: stk500_getparm(): (a) protocol error, expect=0x14, resp=0x00

avrdude: stk500_getparm(): (a) protocol error, expect=0x14, resp=0x80
avrdude: stk500_initialize(): (a) protocol error, expect=0x14, resp=0x98
avrdude: initialization failed, rc=-1
         Double check connections and try again, or use -F to override
         this check.

avrdude: stk500_disable(): protocol error, expect=0x14, resp=0x60
Error during Upload: uploading error: exit status 1
```

### Hooking up my external power source doesn't do anything!

[article](http://www.thebox.myzen.co.uk/Tutorial/Power_Supplies.html)

Basically you forgot that your external power must still go the arduino GND
