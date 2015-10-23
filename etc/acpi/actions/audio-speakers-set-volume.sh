#!/bin/sh
# This script expects you to give a value (same format that pactl accepts,
# see `man pactl`) as last argument.
USER=1000 # macgyver's UID
export XDG_RUNTIME_DIR=/run/user/$USER
export `/usr/bin/su -c "/usr/bin/systemctl --user show-environment" macgyver | /usr/bin/grep DBUS_SESSION_ADDRESS=`

for last; do : ; done
#logger -- "$last"

/usr/bin/su -c "/usr/bin/pactl set-sink-volume 1 $last" macgyver
