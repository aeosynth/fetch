import os

def read(path):
    with open(path) as f:
        return f.read()

user = os.environ['USER']
host = read('/etc/hostname').rstrip()
kernel = read('/proc/version').split()[2]
term = os.environ['TERM']
shell = os.environ['SHELL']

tasks = 0
for f in os.listdir('/proc'):
    if f.isdigit():
        tasks += 1

mem = read('/proc/meminfo').split('\n')
total = int(float(mem[0].split()[1]) / 1000)
avail = int(float(mem[2].split()[1]) / 1000)

uptime = float(read('/proc/uptime').split()[0])
d = int(uptime / 60 / 60 / 24)
h = int(uptime / 60 / 60 % 24)
m = int(uptime / 60 % 60)

print(f"""{user}@{host}
kernel\t{kernel}
term\t{term}
shell\t{shell}
tasks\t{tasks}
mem\t{avail}m / {total}m
uptime\t{d}d {h}h {m}m""")
