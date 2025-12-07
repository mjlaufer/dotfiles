#!/bin/bash

source "$CONFIG_DIR/icons.sh"

if ping -c 1 -t 1 8.8.8.8 &>/dev/null; then
    sketchybar --set $NAME icon=$WIFI_CONNECTED
else
    sketchybar --set $NAME icon=$WIFI_DISCONNECTED
fi
