#!/bin/bash

wifi=(
	script="$PLUGIN_DIR/wifi.sh"
	icon=$WIFI_CONNECTED
	label.drawing=off
	update_freq=30
)

sketchybar --add item wifi right \
	--set wifi "${wifi[@]}" \
	--subscribe wifi wifi_change
