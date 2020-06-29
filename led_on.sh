#!/bin/bash

sudo sh -c 'echo 1 > /sys/class/leds/led1/brightness'
#sudo sh -c 'echo 1 > /sys/class/leds/led0/brightness'
sudo sh -c 'echo "mmc0" >/sys/class/leds/led0/trigger'
