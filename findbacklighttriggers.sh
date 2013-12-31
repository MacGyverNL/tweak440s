#!/bin/bash

MAXBRIGHTNESS=`cat /sys/class/backlight/acpi_video0/max_brightness`
OLDBRIGHTNESS=`cat /sys/class/backlight/intel_backlight/brightness`
for (( t = 0; t <= $MAXBRIGHTNESS; t += 1 )); do
	echo $t > /sys/class/backlight/acpi_video0/brightness
	BRIGHTNESS=`cat /sys/class/backlight/intel_backlight/brightness`
	[ $OLDBRIGHTNESS -ne $BRIGHTNESS ] && echo Trigger value at $t, with brightness $BRIGHTNESS
	OLDBRIGHTNESS=$BRIGHTNESS
done

	
