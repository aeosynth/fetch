const fs = require("fs");

const { SHELL: shell, TERM: term, USER: user } = process.env;
const host = require("os").hostname();
const kernel = fs.readFileSync("/proc/version", "utf8").split(" ")[2];
const tasks = fs.readdirSync("/proc").filter((s) => Number(s)).length;

const mem = fs.readFileSync("/proc/meminfo", "utf8").split("\n");
const getsize = (s) => Math.floor(Number(s.match(/\d+/)) / 1000);
const total = getsize(mem[0]);
const avail = getsize(mem[2]);

const uptime = Number(fs.readFileSync("/proc/uptime", "utf8").split(" ")[0]);
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
