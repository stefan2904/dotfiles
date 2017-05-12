#!/bin/bash
str_state="state"
str_percentage="percentage"
command1="upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "
command2=" | awk '{print \$2}'"

percentage=$(eval $command1$str_percentage$command2 | sed 's/\([0-9]*\).*/\1/')
state=$(eval $command1$str_state$command2)


if (( $percentage<16 )); then
	foreground='foreground="#dc322f">'
	icon='  ' ;
elif (($percentage<39)); then
	foreground='foreground="#cb4b16">'
	icon='  ' ;
elif (($percentage<62)); then
	foreground='foreground="#b58900">'
	icon='  ' ;
elif (($percentage<84)); then
	foreground='foreground="#859900">'
	icon='  ' ;
else
	foreground='foreground="#00A86D">'
	icon='  ' ;
fi

if [ $state = "charging" ] || [ $state = "fully-charged" ]; then
	icon='  ';
fi

echo "<span background='#002b36' $foreground $icon $percentage%</span>";

if [ $percentage -lt 5 ]; then
	exit 33;
fi
