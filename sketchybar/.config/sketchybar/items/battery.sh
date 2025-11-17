#!/bin/bash

# Check if there's a battery percentage.
PERCENTAGE="$(pmset -g batt 2>/dev/null | grep -Eo "\d+%" | cut -d% -f1)"

if [ -n "$PERCENTAGE" ]; then
  battery=(
    script="$PLUGIN_DIR/battery.sh"
    icon.font="$FONT:Regular:19.0"
    padding_right=5
    padding_left=0
    label.drawing=off
    update_freq=120
    updates=on
  )

  sketchybar --add item battery right      \
             --set battery "${battery[@]}" \
             --subscribe battery power_source_change system_woke
fi
