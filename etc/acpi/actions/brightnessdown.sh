#!/bin/bash

# Firmware interface. Appears to use specific trigger values.
# These use a logarithmic scale to translate to actual brightness.
# Trigger values can be found with findbacklighttriggers.sh
# Trigger value at 5, with brightness 9
# Trigger value at 10, with brightness 15
# Trigger value at 20, with brightness 24
# Trigger value at 25, with brightness 30
# Trigger value at 30, with brightness 39
# Trigger value at 35, with brightness 45
# Trigger value at 40, with brightness 54
# Trigger value at 45, with brightness 75
# Trigger value at 50, with brightness 102
# Trigger value at 55, with brightness 138
# Trigger value at 60, with brightness 186
# Trigger value at 65, with brightness 252
# Trigger value at 70, with brightness 330
# Trigger value at 80, with brightness 441
# Trigger value at 90, with brightness 579
# Trigger value at 100, with brightness 765
INTERFACE=/sys/class/backlight/acpi_video0

# Raw interface.
RAW=/sys/class/backlight/intel_backlight

BRIGHTNESS=`cat $INTERFACE/brightness`
logger Read $BRIGHTNESS
# Now find out what the brightness actually was. Since we're decreasing, do some rounding.
# Assuming we never read when it's already decreased by 5, this will give the correct value.
BRIGHTNESS=$((($BRIGHTNESS - 1) / 5 * 5 + 5))

# Max should be 100
MAXBRIGHTNESS=`cat $INTERFACE/max_brightness`
MINBRIGHTNESS=5
if [ $MAXBRIGHTNESS -ne 100 ]; then
	logger Max brightness has unexpected value: $MAXBRIGHTNESS
	exit 1
fi

# Set brightness step based on above trigger values.
[[ $BRIGHTNESS -le 70 && $BRIGHTNESS -gt 20 || $BRIGHTNESS -le 10 ]] && BRIGHTNESSSTEP=5 || BRIGHTNESSSTEP=10

BRIGHTNESS=$(($BRIGHTNESS - $BRIGHTNESSSTEP))

[ $BRIGHTNESS -lt $MINBRIGHTNESS ] && BRIGHTNESS=$MINBRIGHTNESS

logger Brightness down, setting to $BRIGHTNESS

# Set brightness to new value.
echo $BRIGHTNESS > $INTERFACE/brightness

