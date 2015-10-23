#!/bin/sh
logger $* 

BATTERY=/sys/class/power_supply/BAT0
SLEEPMODE=suspend.target


if { test -e $BATTERY && test -e $BATTERY/energy_now && test -e $BATTERY/energy_full_design; } then
	if { expr `cat $BATTERY/energy_full_design` / \( `cat $BATTERY/energy_now` + 1 \) \>= 10 ; } then
		logger Internal battery at less than 10% energy. Using hybrid sleep.
		SLEEPMODE=hybrid-sleep.target
	else
		logger Internal battery at more than 10% energy. Using normal suspend.
		SLEEPMODE=suspend.target
	fi
else
	logger No internal battery present. Using hybrid-sleep.
	SLEEPMODE=hybrid-sleep.target
fi

logger $SLEEPMODE
/etc/acpi/actions/screenlock.sh
/usr/bin/systemctl start $SLEEPMODE

