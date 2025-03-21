#!/bin/bash

# Maximum and Minimum Brightness
MAX_BRIGHTNESS=100
MIN_BRIGHTNESS=10

# Get current brightness
CURRENT_BRIGHTNESS=$(xbacklight -get)

# Function to adjust brightness and send notification
adjust_brightness() {
  local new_brightness=$1
  local brightness_percentage=$((new_brightness))

  # Ensure the brightness is within bounds
  if (( brightness_percentage > MAX_BRIGHTNESS )); then
    brightness_percentage=$MAX_BRIGHTNESS
  elif (( brightness_percentage < MIN_BRIGHTNESS )); then
    brightness_percentage=$MIN_BRIGHTNESS
  fi

  # Set the new brightness
  xbacklight -set $brightness_percentage

  # Show the notification using dunst
  notify-send "Brightness: $brightness_percentage%" -i brightness
}

# Check if an argument was provided for increasing or decreasing
if [ "$1" == "increase" ]; then
  NEW_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS + 10" | bc)
  adjust_brightness $NEW_BRIGHTNESS
elif [ "$1" == "decrease" ]; then
  NEW_BRIGHTNESS=$(echo "$CURRENT_BRIGHTNESS - 10" | bc)
  adjust_brightness $NEW_BRIGHTNESS
else
  echo "Usage: $0 {increase|decrease}"
  exit 1
fi
