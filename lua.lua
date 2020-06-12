function read(path)
  local file = io.open(path)
  local s = file:read("a")
  file:close()
  return s
end

function match(s, pattern)
  local t = {}
  for m in string.gmatch(s, pattern) do
    table.insert(t, m)
  end
  return t
end

user = os.getenv('USER')
host = read('/etc/hostname')
kernel = match(read('/proc/version'), '%S+')[3]
term = os.getenv('TERM')
shell = os.getenv('SHELL')
tasks = 0

mem = match(read('/proc/meminfo'), '%C+')
total = math.floor(tonumber(match(mem[1], '%S+')[2]) / 1000)
avail = math.floor(tonumber(match(mem[3], '%S+')[2]) / 1000)

uptime = tonumber(match(read('/proc/uptime'), '%S+')[1])
d = math.floor(uptime / 60 / 60 / 24)
h = math.floor(uptime / 60 / 60 % 24)
m = math.floor(uptime / 60 % 60)

print(user .. "@" .. host ..
"kernel\t" .. kernel ..
"\nterm\t" .. term ..
"\nshell\t" .. shell ..
"\ntasks\t" .. tasks ..
"\nmem\t" .. avail .. "m / " .. total .. "m" ..
"\nuptime\t" .. d .. "d " .. h .. "h " .. m .. "m")
