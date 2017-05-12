#!/bin/bash
echo "<span background=\"#002b36\" foreground=\"#cb4b16\">  $(sensors coretemp-isa-0000 | awk '/Physical/ { print $4 }') </span>"
