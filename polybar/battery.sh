#!/bin/bash

# Check if the system is plugged in (check for the AC directory)
if [ -d "/sys/class/power_supply/ACAD" ]; then
    AC_ONLINE=1
else
    AC_ONLINE=0
fi

BATTERY_PATH=/sys/class/power_supply/BAT1/capacity
ICON_CHARGING=""
FORMAT_ICONS=( "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" )

# If the system is plugged in, display the charging icon and percentage
if [ $AC_ONLINE -eq 1 ]; then
    echo -e "$ICON_CHARGING $(cat $BATTERY_PATH)%"
else
    # If the system is not plugged in, display battery percentage with icons based on the level
    BATTERY=$(cat $BATTERY_PATH)
    
    # Debugging output: Print battery level
    # echo "Battery Level: $BATTERY"
    
    INDEX=$((BATTERY / 10))
    if [ $INDEX -gt 10 ]; then
        INDEX=10
    fi
    echo -e "${FORMAT_ICONS[$INDEX]} ${BATTERY}%"
fi

