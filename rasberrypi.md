Title: Raspberry Pi 
- - - 

# raspberry pi

## setup

open up the config menu. 
You can use this menu in order 
```bash
sudo raspi-config
```

## update hostname on network

edit 
```
/etc/hostname
```



# give a pi a static address on a network

[read this](https://pimylifeup.com/raspberry-pi-static-ip-address/)




# GPIO PORT

## Basic Switching 

Using the GPIO port connect GND and one of the numbered pins.
Always connect a resistor in the circuit to avoid damaging the circuit.
Power to the light or switch can be controlled using the GPIO python module. 
See lightswitch.py
SPI / PIFACE
Documentation
http://piface.github.io/pifacedigitalio/pifacedigital.html
Enabling SPI loading
>>>raspi-config 
-> interfaces -> spi
SETUP Piface
See http://www.piface.org.uk/
CONTROL LIGHTS On Board
See 


