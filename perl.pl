sub ffetch {
	open("f", "<", $_[0]) or die $!;
	my @r = <f>;
	close "f";
	return @r;
}

my $hostname = (ffetch("/etc/hostname"))[0];
my $version = (split / /, (ffetch("/proc/version"))[0])[2];
my @times = split / /, (ffetch("/proc/uptime"))[0];
my @fi = ffetch("/proc/meminfo");

my ($total, $avail) = (int(( $fi[0] =~ /(\d+)/ )[0] / 1000), int(( $fi[2] =~ /(\d+)/ )[0] / 1000));

opendir my($dh), "/proc" or die $!;
my $tasks = scalar (grep { /\d+$/ } readdir $dh);
closedir $dh;

my $user = $ENV{'USER'}
my $term = $ENV{'TERM'}
my $shell = $ENV{'SHELL'}
my $d = int((($times[0] / 60) / 60) / 24);
my $h = (($times[0] / 60) / 60) % 24;
my $m = ($times[0] / 60) % 60;
print $user . "@" . $hostname
	. "kernel\t" . $version
	. "\nterm\t" . $term
	. "\nshell\t" . $shell
	. "\ntasks\t" . $tasks
	. "\nmem\t" . $avail . "m / " . $total . "m"
	. "\nuptime\t" . $d . "d " . $h . "h " . $m . "m"
	. "\n";
