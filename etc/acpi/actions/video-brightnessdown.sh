#!/bin/bash

# Raw interface.
INTERFACE=/sys/class/backlight/intel_backlight
BRIGHTNESS=`cat $INTERFACE/actual_brightness`
MAXBRIGHTNESS=`cat $INTERFACE/max_brightness`
BRIGHTNESSSTEP=$(($BRIGHTNESS / 10))
MINBRIGHTNESS=5

[[ $BRIGHTNESSSTEP -lt 5 ]] && BRIGHTNESSSTEP=5

BRIGHTNESS=$(($BRIGHTNESS - $BRIGHTNESSSTEP))

[[ $BRIGHTNESS -lt $MINBRIGHTNESS ]] && BRIGHTNESS=$MINBRIGHTNESS

logger Brightness down, setting to $BRIGHTNESS

echo $BRIGHTNESS > $INTERFACE/brightness
