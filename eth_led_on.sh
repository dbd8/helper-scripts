#!/bin/bash

sudo sed -i 's/.*dtparam=eth_led0=14/#dtparam=eth_led0=14/g' /boot/config.txt
sudo sed -i 's/.*dtparam=eth_led1=14/#dtparam=eth_led1=14/g' /boot/config.txt
