#!/bin/bash

# Raw interface.
INTERFACE=/sys/class/backlight/intel_backlight
BRIGHTNESS=`cat $INTERFACE/actual_brightness`
MAXBRIGHTNESS=`cat $INTERFACE/max_brightness`
BRIGHTNESSSTEP=$(($BRIGHTNESS / 10))
MINBRIGHTNESS=5

[[ $BRIGHTNESSSTEP -lt 5 ]] && BRIGHTNESSSTEP=5

BRIGHTNESS=$(($BRIGHTNESS + $BRIGHTNESSSTEP))

[[ $BRIGHTNESS -gt $MAXBRIGHTNESS ]] && BRIGHTNESS=$MAXBRIGHTNESS

logger Brightness up, setting to $BRIGHTNESS

echo $BRIGHTNESS > $INTERFACE/brightness
