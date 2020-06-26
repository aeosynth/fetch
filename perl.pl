use strict;
use warnings;

open("f", "<", "/etc/hostname");
my $hostname = <f>;
close "f";

open("f", "<", "/proc/version");
my @version = split / /, <f>;
close "f";

open("f", "<", "/proc/uptime");
my @times = split / /, <f>;
close "f";

opendir my($dh), "/proc";
my @tasks = grep { /^[+-]?\d+$/ } readdir $dh;
closedir $dh;

my $user = $ENV{'USER'};
my $term = $ENV{'TERM'};
my $shell = $ENV{'SHELL'};
my $tasks = "";
my $avail = "";
my $total = "";
my $d = int((($times[0] / 60) / 60) / 24);
my $h = (($times[0] / 60) / 60) % 24;
my $m = ($times[0] / 60) % 60;
print $user . "@" . $hostname
	. "kernel\t" . $version[2]
	. "\nterm\t" . $term
	. "\nshell\t" . $shell
	. "\ntasks\t" . $#tasks
	. "\nmem\t" . $avail . "m / " . $total . "m"
	. "\nuptime\t" . $d . "d " . $h . "h " . $m . "m"
	. "\n";
