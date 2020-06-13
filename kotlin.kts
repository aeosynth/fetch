import java.io.File

val user = System.getenv("USER")
val host = File("/etc/hostname").readLines()[0]
val kernel = File("/proc/version").readText().split(' ')[2]
val term = System.getenv("TERM")
val shell = System.getenv("SHELL")

var tasks = 0
File("/proc").list().forEach {
  if (it.toIntOrNull() != null) tasks += 1
}

val mem = File("/proc/meminfo").readLines()
fun getSize(s: String) = s.split(Regex("\\s+"))[1].toInt() / 1000
val total = getSize(mem[0])
val avail = getSize(mem[2])

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
