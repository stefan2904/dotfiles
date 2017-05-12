#!/bin/bash
str_state="state"
str_percentage="percentage"
str_empty="'time to empty'"
command1="upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep "
command2=" | awk '{print \$2}'"
command3=" | awk '{print \$4 \$5}'"

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
elif [ $state = "discharging" ]; then
	timeleft=$(eval $command1$str_empty$command3)
fi

echo "<span background='#002b36' $foreground $icon $percentage% $timeleft</span>";

if [ $percentage -lt 5 ]; then
	exit 33;
fi
