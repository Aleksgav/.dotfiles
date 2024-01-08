#!/bin/bash

# Variable
temp=$(cat /sys/class/thermal/thermal_zone0/temp)
cputemp=$(expr $temp / 1000)
echo $cputemp

exit
