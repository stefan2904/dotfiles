#!/bin/bash
printf "<span background=\"#002b36\" foreground=\"#93a1a1\"> RAM %3.1f/%3.1f Gb </span>" $(free | grep Mem | awk '{print $3/1024/1024" "$2/1024/1024}')
