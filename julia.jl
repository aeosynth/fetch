user = ENV["USER"]
host = readlines("/etc/hostname")[1]
kernel = split(readlines("/proc/version")[1])[3]
term = ENV["TERM"]
shell = ENV["SHELL"]

tasks = length(filter(x -> isa(tryparse(Int, x), Int), readdir("/proc")))

mem = readlines("/proc/meminfo")
function getsize(s) fld(parse(Int, split(s)[2]), 1000) end
total = getsize(mem[1])
avail = getsize(mem[3])

uptime = parse(Int, split(readlines("/proc/uptime")[1], '.')[1])
d = trunc(Int, (uptime / 60 / 60 / 24))
h = trunc(Int, (uptime / 60 / 60 % 24))
m = trunc(Int, (uptime / 60 % 60))

print("$user@$host
kernel\t$kernel
term\t$term
shell\t$shell
tasks\t$tasks
mem\t$(avail)m / $(total)m
uptime\t$(d)d $(h)h $(m)m")
