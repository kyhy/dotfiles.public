#!/usr/bin/env sh

source "$HOME/.config/sketchybar/colors.sh" # Loads all defined colors

ICON=""
if [ "$SELECTED" = "true" ]; then
  ICON=""
fi

sketchybar --animate tanh 20 --set           \
        $NAME                                \
        icon=$ICON                           \
        icon.highlight=$SELECTED             
