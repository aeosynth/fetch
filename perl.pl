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

open("f", "<", "/proc/meminfo");
my @fi = <f>;
close "f";
( my $total ) = ( $fi[0] =~ /(\d+)/ );
( my $avail ) = ( $fi[2] =~ /(\d+)/ );

opendir my($dh), "/proc";
my @tasks = grep { /^[+-]?\d+$/ } readdir $dh;
closedir $dh;

my $user = $ENV{'USER'};
my $term = $ENV{'TERM'};
my $shell = $ENV{'SHELL'};
my $tasks = $#tasks + 1;
$total = int($total / 1000);
$avail = int($avail / 1000);
my $d = int((($times[0] / 60) / 60) / 24);
my $h = (($times[0] / 60) / 60) % 24;
my $m = ($times[0] / 60) % 60;
print $user . "@" . $hostname
	. "kernel\t" . $version[2]
	. "\nterm\t" . $term
	. "\nshell\t" . $shell
	. "\ntasks\t" . $tasks
	. "\nmem\t" . $avail . "m / " . $total . "m"
	. "\nuptime\t" . $d . "d " . $h . "h " . $m . "m"
	. "\n";
