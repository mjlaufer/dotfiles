#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"
source "$CONFIG_DIR/colors.sh"

# Get current non-empty workspaces and focused workspace
WORKSPACES=$(aerospace list-workspaces --monitor all --empty no)
FOCUSED=$(aerospace list-workspaces --focused)

NEEDS_REORDER=false
ARGS=()

for sid in $WORKSPACES; do
    # Add item if it doesn't exist.
    if ! sketchybar --query space.$sid &>/dev/null; then
        sketchybar --add item space.$sid left --before aerospace_trigger \
            --set space.$sid \
            icon="$sid" \
            label.drawing=off \
            click_script="aerospace workspace $sid"
        NEEDS_REORDER=true
    fi

    # Build batched update args for focused/unfocused states.
    if [ "$sid" = "$FOCUSED" ]; then
        ARGS+=(--set space.$sid \
            icon.font="Lilex:Semibold:13.0" \
            icon.padding_left=8 \
            icon.padding_right=8 \
            background.drawing=on \
            background.border_color=$MAGENTA_SOFT2 \
            background.border_width=2)
    else
        ARGS+=(--set space.$sid \
            icon.font="Lilex:Medium:13.0" \
            icon.padding_left=4 \
            icon.padding_right=4 \
            background.drawing=off)
    fi
done

# Apply all updates.
sketchybar "${ARGS[@]}"

# Remove items for workspaces that are now empty.
for sid in $(aerospace list-workspaces --all); do
    if ! echo "$WORKSPACES" | grep -q "^${sid}$"; then
        sketchybar --remove space.$sid 2>/dev/null
    fi
done

# Update bracket and reorder when items changed.
if [ "$NEEDS_REORDER" = true ]; then
    ITEMS=$(echo "$WORKSPACES" | sed 's/^/space./' | tr '\n' ' ')
    sketchybar --set spaces members="$ITEMS" \
        --reorder $ITEMS front_app
fi
