my ($user, $term, $shell) = %*ENV<USER TERM SHELL>;
my $host = '/etc/hostname'.IO.lines[0];
my $kernel = '/proc/version'.IO.words[2];
my $tasks = '/proc'.IO.dir(test => /\d+/).elems;

my @mem = '/proc/meminfo'.IO.lines;
sub get-size($s){Int($s.words[1]) div 1000};
my $total = get-size @mem[0];
my $avail = get-size @mem[2];

my $uptime = '/proc/uptime'.IO.words[0];
my $d = Int($uptime / 60 / 60 / 24);
my $h = Int($uptime / 60 / 60 % 24);
my $m = Int($uptime / 60 % 60);

say "$user@$host
kernel\t$kernel
term\t$term
shell\t$shell
tasks\t$tasks
mem\t{$avail}m / {$total}m
uptime\t{$d}d {$h}h {$m}m"
