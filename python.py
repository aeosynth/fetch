import os

def read(path):
    with open(path) as f:
        return f.read()

user, term, shell = [os.environ[x] for x in ["USER", "TERM", "SHELL"]]
host = read('/etc/hostname').rstrip()
kernel = read('/proc/version').split()[2]
tasks = len([x for x in os.listdir('/proc') if x.isdigit()])

mem = read('/proc/meminfo').split('\n')[:3]
(total, _, avail) = [int(x.split()[1]) // 1000 for x in mem]

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
