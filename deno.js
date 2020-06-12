function readFile(path) {
  const file = Deno.openSync(path, { read: true });
  const buf = Deno.readAllSync(file);
  Deno.close(file.rid);
  return new TextDecoder().decode(buf);
}

const user = Deno.env.get("USER");
const host = readFile("/etc/hostname").trimRight();
const kernel = readFile("/proc/version").split(" ")[2];
const term = Deno.env.get("TERM");
const shell = Deno.env.get("SHELL");

let tasks = 0;
for (const dirEntry of Deno.readDirSync("/proc")) {
  if (Number(dirEntry.name)) {
    tasks++;
  }
}

const mem = readFile("/proc/meminfo").split("\n");
const total = Math.floor(Number(mem[0].match(/\d+/)[0]) / 1000);
const avail = Math.floor(Number(mem[2].match(/\d+/)[0]) / 1000);

const uptime = Number(readFile("/proc/uptime").split(" ")[0]);
const days = Math.floor(uptime / 60 / 60 / 24);
const hours = Math.floor(uptime / 60 / 60) % 24;
const minutes = Math.floor(uptime / 60) % 60;

console.log(`${user}@${host}
kernel\t${kernel}
term\t${term}
shell\t${shell}
tasks\t${tasks}
mem\t${avail}m / ${total}m
uptime\t${days}d ${hours}h ${minutes}m`);
