user <- Sys.getenv("USER")
hostname <- readLines("/etc/hostname")
kernel <- strsplit(readLines("/proc/version"), " ")[[1]][3]
term <- Sys.getenv("TERM")
shell <- Sys.getenv("SHELL")
tasks <- length(dir("/proc")[ grepl("^[0-9]{1,}$", dir("/proc")) ])
tmem <- as.numeric(strsplit(readLines("/proc/meminfo")[1], "\\D+")[[1]][-1]) %/% 1000
amem <- as.numeric(strsplit(readLines("/proc/meminfo")[3], "\\D+")[[1]][-1]) %/% 1000
uptime <- as.numeric(strsplit(readLines("/proc/uptime"), " ")[[1]][1])
d <- trunc(((uptime / 60) / 60) / 24)
h <- trunc(((uptime / 60) / 60) %% 24)
m <- trunc((uptime / 60) %% 60)
cat(user, "@", hostname,
    "\nkernel\t", kernel,
    "\nterm\t", term,
    "\nshell\t", shell,
    "\ntasks\t", tasks,
    "\nmem\t", amem, "m / ", tmem,
    "m\nuptime\t", d, "d ", h, "h ", m, "m", "\n", 
    sep="")
