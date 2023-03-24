array=$(yabai -m query --spaces | jq ".[].id")
focused=$(yabai -m query --spaces | jq ".[] | {id:.id,focused:.\"has-focus\"} | select(.focused == true) | .id")
stacks=""
for element in ${array[@]}
do
	temp="  "
	if [[ $element == $focused ]]; then
		temp="  "
	fi
	stacks="$stacks$temp"
done

#sketchybar -m --set $NAME label="$stacks"
sketchybar -m --set stacks icon="$stacks" label=""
