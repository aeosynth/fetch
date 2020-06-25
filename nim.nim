import os, strutils

let user = getEnv("USER")
let host = readFile("/etc/hostname")
let kernel = readFile("/proc/version").split()[2]
let term = getEnv("TERM")
let shell = getEnv("SHELL")

var tasks = 0
for _, path in walkDir("/proc", true):
    if not path.contains(Allchars - Digits):
        tasks += 1

let mem = readFile("/proc/meminfo").splitLines()
proc getsize(s: string): int = parseInt(s.splitWhitespace()[1]) div 1000
let total = getsize(mem[0])
let avail = getsize(mem[2])

let uptime = parseFloat(readFile("/proc/uptime").split()[0])
let d = toInt(uptime / 60 / 60 / 24)
let h = toInt(uptime / 60 / 60) mod 24
let m = toInt(uptime / 60) mod 60

echo user, "@", host,
    "kernel\t", kernel,
    "\nterm\t", term,
    "\nshell\t", shell,
    "\ntasks\t", tasks,
    "\nmem\t", avail, "m / ", total, "m",
    "\nuptime\t", d, "d ", h, "h ", m, "m"
