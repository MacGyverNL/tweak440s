#!/bin/sh
USER=1000 # macgyver's UID
export XDG_RUNTIME_DIR=/run/user/$USER

#logger `/usr/bin/su -c "/usr/bin/systemctl --user show-environment" macgyver 2>&1`
export `/usr/bin/su -c "/usr/bin/systemctl --user show-environment" macgyver | /usr/bin/grep DISPLAY=`

/usr/bin/su -c "/usr/bin/xflock4" macgyver
#/bin/su macgyver -c "/usr/bin/systemctl --user start i3lock@0"
