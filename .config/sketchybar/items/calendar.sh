#!/usr/bin/env sh

sketchybar --add item     calendar right                    \
           --set calendar icon=cal                          \
                          icon.font="$FONT:Black:14.0"      \
                          icon.padding_right=0              \
                          label.width=50                    \
                          label.align=right                 \
                          label.font="$FONT:Black:14.0"      \
                          background.padding_left=15        \
                          update_freq=30                    \
                          script="$PLUGIN_DIR/calendar.sh"  \
                          click_script="$PLUGIN_DIR/zen.sh"
