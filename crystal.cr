user = ENV["USER"]
host = System.hostname
kernel = File.read("/proc/version").split[2]
term = ENV["TERM"]
shell = ENV["SHELL"]
tasks = Dir.entries("/proc").count { |x| x.to_i? }

mem = File.read("/proc/meminfo").lines
def getsize(s) s.split[1].to_i // 1000 end
total = getsize(mem[0])
avail = getsize(mem[2])

uptime = File.read("/proc/uptime").split[0].to_f
d = (uptime / 60 / 60 / 24).to_i
h = (uptime / 60 / 60 % 24).to_i
m = (uptime / 60 % 60).to_i

puts "#{user}@#{host}
kernel\t#{kernel}
term\t#{term}
shell\t#{shell}
tasks\t#{tasks}
mem\t#{avail}m / #{total}m
uptime\t#{d}d #{h}h #{m}m"
