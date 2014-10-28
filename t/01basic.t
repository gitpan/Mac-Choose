#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 1;

use Mac::Choose qw(choose);

open my $fh, '|-','osascript','-e','delay 1','-e','tell applications "System Events" to keystroke return';

my $answer = choose "please wait","do not press anything","this dialog should close","within two seconds";
is $answer, "please wait";

close $fh;
