import java.io.File

val user = System.getenv("USER")
val host = File("/etc/hostname").readLines()[0]
val kernel = File("/proc/version").readText().split(' ')[2]
val term = System.getenv("TERM")
val shell = System.getenv("SHELL")
val tasks = File("/proc").list().count { it.toIntOrNull() != null }

val mem = File("/proc/meminfo").readLines().take(3)
val (total, _, avail) = mem.map { it.split(Regex("\\s+"))[1].toInt() / 1000 }

val uptime = File("/proc/uptime").readText().split('.')[0].toInt()
val d = uptime / 60 / 60 / 24
val h = uptime / 60 / 60 % 24
val m = uptime / 60 % 60

println("$user@$host" +
"\nkernel\t$kernel" +
"\nterm\t$term" +
"\nshell\t$shell" +
"\ntasks\t$tasks" +
"\nmem\t${avail}m / ${total}m" +
"\nuptime\t${d}d ${h}h ${m}m")
