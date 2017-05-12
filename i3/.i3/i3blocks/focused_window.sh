#!/bin/bash
strlen=100;
printf "<span background=\"#002b36\" foreground=\"#9fbc00\"> "
if [ $(xdotool getactivewindow getwindowname | wc -c) -gt $strlen ]; then
	printf "…"; 
fi 

wintitle=$(xdotool getactivewindow getwindowname | tail -c $strlen | iconv -t 'UTF-8')
printf "$wintitle </span>"
