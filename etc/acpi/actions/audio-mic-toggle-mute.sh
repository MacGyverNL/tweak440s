#!/bin/sh
USER=1000 # macgyver's UID
export XDG_RUNTIME_DIR=/run/user/$USER
export `/usr/bin/su -c "/usr/bin/systemctl --user show-environment" macgyver | /usr/bin/grep DBUS_SESSION_ADDRESS=`

/usr/bin/su -c "/usr/bin/pactl set-source-mute 2 toggle" macgyver
