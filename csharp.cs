using System;
using System.IO;
using System.Linq;

public class Fetch {
  public static void Main(string[] args) {
    var user = Environment.GetEnvironmentVariable("USER");
    var host = File.ReadAllText("/etc/hostname").Trim();
    var kernel = File.ReadAllText("/proc/version").Split()[2];
    var term = Environment.GetEnvironmentVariable("TERM");
    var shell = Environment.GetEnvironmentVariable("SHELL");
    var tasks = Directory.EnumerateDirectories("/proc").Count(s =>
        int.TryParse(s.Split('/')[2], out _));

    var mem = File.ReadAllText("/proc/meminfo").Split('\n');
    Func<string, int> getsize = s =>
      int.Parse(s.Split(' ', StringSplitOptions.RemoveEmptyEntries)[1]) / 1000;
    var total = getsize(mem[0]);
    var avail = getsize(mem[2]);

    var uptime = int.Parse(File.ReadAllText("/proc/uptime").Split('.')[0]);
    var d = uptime / 60 / 60 / 24;
    var h = uptime / 60 / 60 % 24;
    var m = uptime / 60 % 60;

    Console.WriteLine($"{user}@{host}
kernel\t{kernel}
term\t{term}
shell\t{shell}
tasks\t{tasks}
mem\t{avail}m / {total}m
uptime\t{d}d {h}h {m}m");
  }
}
