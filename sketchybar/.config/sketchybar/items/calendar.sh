#!/bin/bash

calendar=(
	icon=cal
	icon.font="$SYMBOL_FONT:Medium:15.0"
	icon.padding_right=12
	label.width=45
	label.align=right
	padding_left=12
	update_freq=30
	script="$PLUGIN_DIR/calendar.sh"
)

sketchybar --add item calendar right \
	--set calendar "${calendar[@]}" \
	--subscribe calendar system_woke
