#!/bin/bash

sketchybar --add event aerospace_workspace_change

# Create space items for all non-empty workspaces.
SPACES=()
for sid in $(aerospace list-workspaces --monitor all --empty no); do
    sketchybar --add item space.$sid left \
        --set space.$sid \
        icon="$sid" \
        label.drawing=off \
        click_script="aerospace workspace $sid"
    SPACES+=("space.$sid")
done

# Create bracket to group spaces.
sketchybar --add bracket spaces "${SPACES[@]}" \
    --set spaces \
    background.drawing=on \
    background.color=$BG4 \
    background.corner_radius=8

# Create a hidden trigger item that runs the plugin on workspace change.
sketchybar --add item aerospace_trigger left \
    --subscribe aerospace_trigger aerospace_workspace_change \
    --set aerospace_trigger \
    drawing=off \
    updates=on \
    script="$PLUGIN_DIR/aerospace.sh"

# Highlight the focused workspace on load.
FOCUSED=$(aerospace list-workspaces --focused)
sketchybar --set space.$FOCUSED \
    icon.font="$FONT:Semibold:13.0" \
    icon.padding_left=8 \
    icon.padding_right=8 \
    background.drawing=on \
    background.border_color=$MAGENTA_SOFT2 \
    background.border_width=2

