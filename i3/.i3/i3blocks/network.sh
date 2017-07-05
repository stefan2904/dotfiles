#!/bin/bash
# Copyright (C) 2014 Julien Bonjean <julien@bonjean.info>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#INTERFACE="${BLOCK_INSTANCE:-eth0}"

if [[ -n $BLOCK_INSTANCE ]]; then
	INTERFACE=$BLOCK_INSTANCE
else
	INTERFACE=$(ip route | awk '/^default/ { print $5 ; exit }')
fi

PFX="<span background=\"#021215\">"

if [[ $INTERFACE == "eth0" ]]; then
	ICON=
	ESSID=""
	QUALITY="$(cat /sys/class/net/$INTERFACE/QUALITY 2> /dev/null)"
	SFX="Mbits/s </span>"
else
	ICON=
	ESSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -c 5-)
	QUALITY="$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')"
	SFX="% </span>"
fi


state="$(cat /sys/class/net/$INTERFACE/operstate)"

if [ "$state" != "up" ]; then
	vpncommand1="nmcli -p | grep 'VPN connection' | cut -d ' ' -f 1";
	vpnstate1=$(eval $vpncommand1);
	if [ ! -z "$vpnstate1" ]; then
	    echo "VPN: $vpnstate1";
	else
		vpncommand2="nmcli -p | grep 'tun0'";
		vpnstate2=$(eval $vpncommand2);
		if [ ! -z "$vpnstate2" ]; then
		    echo "VPN";
		else
			echo "✖";
		fi
	fi

	echo "✖"
	echo "#dc322f"
	exit 0
fi


ipaddr="$(ip addr show $INTERFACE | perl -n -e'/inet (.+)\// && print $1')"
ipaddr="${ipaddr:-0.0.0.0}"

# full text
echo -n "$PFX $ICON $ESSID $ipaddr"
[ -n "$QUALITY" ] && echo " $QUALITY$SFX" || echo " </span>"

# short text
echo -n "$PFX $ICON $ESSID $ipaddr"
[ -n "$QUALITY" ] && echo " $QUALITY$SFX" || echo " </span>"
# short text
#echo "$ipaddr"

# color
if [ $INTERFACE == "wlan0" ]; then
	if [[ $QUALITY -ge 80 ]]; then
	    echo "#2aa198"
	elif [[ $QUALITY -lt 80 ]]; then
	    echo "#859900"
	elif [[ $QUALITY -lt 60 ]]; then
	    echo "#b58900"
	elif [[ $QUALITY -lt 40 ]]; then
		echo "#dc322f"
	fi
else
	echo "#268bd2"
fi

