sub ffetch {
	open("f", "<", $_[0]) or die $!;
	my @r = <f>;
	close "f";
	return @r;
}

my @hostname = ffetch("/etc/hostname") ;
my @version = split / /, (ffetch("/proc/version"))[0];
my @times = split / /, (ffetch("/proc/uptime"))[0];
my @fi = ffetch("/proc/meminfo");

( my $total ) = ( $fi[0] =~ /(\d+)/ );
( my $avail ) = ( $fi[2] =~ /(\d+)/ );

opendir my($dh), "/proc" or die $!;
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
print $user . "@" . $hostname[0]
	. "kernel\t" . $version[2]
	. "\nterm\t" . $term
	. "\nshell\t" . $shell
	. "\ntasks\t" . $tasks
	. "\nmem\t" . $avail . "m / " . $total . "m"
	. "\nuptime\t" . $d . "d " . $h . "h " . $m . "m"
	. "\n";
