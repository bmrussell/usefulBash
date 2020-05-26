#!/bin/bash

# Check every 5' with
# crontab -e
# */5 * * * * /home/brian/bin/checkBattery

POWERSUPPLY="/sys/class/power_supply/BAT0/status" 
TOO_LOW=333# how low is too low?
NOT_CHARGING="Discharging"
ICON="/usr/share/icons/Papirus/24x24/panel/battery-low.svg" # eye candy

export DISPLAY=:0

BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')
STATUS=$(cat $POWERSUPPLY)

if [ $BATTERY_LEVEL -le $TOO_LOW -a $STATUS = $NOT_CHARGING ]
then
    /usr/bin/notify-send -u critical -i "$ICON" -t 3000 "Battery low" "Battery level is ${BATTERY_LEVEL}%!"
fi

exit 0
