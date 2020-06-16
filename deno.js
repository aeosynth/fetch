const { SHELL: shell, TERM: term, USER: user } = Deno.env.toObject();
const host = Deno.readTextFileSync("/etc/hostname").trimRight();
const kernel = Deno.readTextFileSync("/proc/version").split(" ")[2];
const tasks =
  Array.from(Deno.readDirSync("/proc")).filter((x) => Number(x.name)).length;

const mem = Deno.readTextFileSync("/proc/meminfo").split("\n");
const getsize = (s) => Math.floor(Number(s.match(/\d+/)) / 1000);
const total = getsize(mem[0]);
const avail = getsize(mem[2]);

const uptime = Number(Deno.readTextFileSync("/proc/uptime").split(" ")[0]);
const d = Math.floor(uptime / 60 / 60 / 24);
const h = Math.floor(uptime / 60 / 60 % 24);
const m = Math.floor(uptime / 60 % 60);

console.log(`${user}@${host}
kernel\t${kernel}
term\t${term}
shell\t${shell}
tasks\t${tasks}
mem\t${avail}m / ${total}m
uptime\t${d}d ${h}h ${m}m`);
