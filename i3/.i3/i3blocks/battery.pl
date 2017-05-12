#!/usr/bin/perl
#
# Copyright 2014 Pierre Mavro <deimos@deimos.fr>
# Copyright 2014 Vivien Didelot <vivien@didelot.org>
#
# Licensed under the terms of the GNU GPL v3, or any later version.
#
# This script is meant to use with i3blocks. It parses the output of the "acpi"
# command (often provided by a package of the same name) to read the status of
# the battery, and eventually its remaining time (to full charge or discharge).
#
# The color will gradually change for a percentage below 85%, and the urgency
# (exit code 33) is set if there is less that 5% remaining.

use strict;
use warnings;
use utf8;

my $acpi;
my $status;
my $percent;
my $full_text;
my $short_text;
my $bat_number = $ENV{BLOCK_INSTANCE} || 0;

# read the first line of the "acpi" command output
# open (ACPI, "acpi -b | grep 'Battery $bat_number' |") or die;
open (ACPI, "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | awk '{print \$2}'") or die;
$acpi = <ACPI>;
close(ACPI);

# fail on unexpected output
if ($acpi !~ /: (\w+), (\d+)%/) {
	die "$acpi\n";
}

$status = $1;
$percent = $2;
$full_text = " $percent%";

if ($status eq 'Discharging') {
	if ($percent < 16) {
		$full_text .= '   ';
	} elsif ($percent < 39) {
		$full_text .= '   ';
	} elsif ($percent < 62) {
		$full_text .= '   ';
	} elsif ($percent < 84) {
		$full_text .= '   ';
	} elsif ($percent >= 84) {
		$full_text .= '   ';
	}
} elsif ($status eq 'Charging') {
	$full_text .= '   ';
}

$short_text = $full_text;

#if ($acpi =~ /(\d\d:\d\d):/) {
#	$full_text .= " ($1)";
#}

# print text
print "<span background=\"#002b36\">$full_text</span>\n";
print "<span background=\"#002b36\">$short_text</span>\n";

# consider color and urgent flag only on discharge
if ($percent < 16) {
	print "#dc322f\n";
} elsif ($percent < 39) {
	print "#cb4b16\n";
} elsif ($percent < 62) {
	print "#b58900\n";
} elsif ($percent < 84) {
	print "#859900\n";
} elsif ($percent >= 84) {
	print "#00A86D\n";
}

if ($percent < 5) {
	exit(33);
}

exit(0);
