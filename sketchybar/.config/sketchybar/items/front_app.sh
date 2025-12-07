#!/bin/bash

front_app=(
	label.font="$FONT:Medium:13.0"
	icon.background.drawing=on
	icon.background.image.scale=0.75
	display=active
    padding_left=16
	script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
	--set front_app "${front_app[@]}" \
	--subscribe front_app front_app_switched
