#!/usr/bin/env sh

SPACE_ICONS=("" "" "" "")
SPACE_CLICK_SCRIPT="yabai -m space --focus \$SID 2>/dev/null"

ICON_PADDING=8

sid=0
for i in "${!SPACE_ICONS[@]}"
do
  sid=$(($i+1))
  sketchybar --add space      space.$sid left                               \
             --set space.$sid associated_space=$sid                         \
                              icon.font="$FONT:Bold:16.0"                   \
                              icon.padding_left=$ICON_PADDING               \
                              icon.padding_right=$ICON_PADDING              \
                              icon.highlight_color=$MAGENTA                 \
                              script="$PLUGIN_DIR/space.sh"                 \
                              click_script="$SPACE_CLICK_SCRIPT"
done
