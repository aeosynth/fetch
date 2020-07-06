sub ffetch {
	open("f", "<", $_[0]) or die $!;
	my @r = <f>;
	close "f";
	return @r;
}

my $user = $ENV{'USER'};
my $hostname = (ffetch("/etc/hostname"))[0];
my $kernel = (split / /, (ffetch("/proc/version"))[0])[2];
my $term = $ENV{'TERM'};
my $shell = $ENV{'SHELL'};

opendir my($dir), "/proc" or die $!;
my $tasks = scalar (grep { /\d+$/ } readdir $dir);
closedir $dir;

my @mem = ffetch("/proc/meminfo");
my ($total, $x, $avail) = map {int(($_ =~ /(\d+)/)[0] / 1000)} @mem;

my @uptime = split / /, (ffetch("/proc/uptime"))[0];
my $d = int((($uptime[0] / 60) / 60) / 24);
my $h = (($uptime[0] / 60) / 60) % 24;
my $m = ($uptime[0] / 60) % 60;

print $user . "@" . $hostname
	. "kernel\t" . $kernel
	. "\nterm\t" . $term
	. "\nshell\t" . $shell
	. "\ntasks\t" . $tasks
	. "\nmem\t" . $avail . "m / " . $total . "m"
	. "\nuptime\t" . $d . "d " . $h . "h " . $m . "m";
