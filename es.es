#!/usr/bin/es --
mem=<={%split ' ' `{free -mh| head -n 2 | tail -n 1}}
up=<={%split ' ' `{cat /proc/uptime}}
days=`{echo $up(1)' / 60 / 60 / 24' | bc}
hours=`{echo $up(1)' / 60 / 60 % 24' | bc}
minutes=`{echo $up(1)' / 60 % 60' | bc}

echo $USER^'@'`{cat /etc/hostname}
echo 'kernel	'`{uname -r}
echo 'term	'$TERM
echo 'shell	'$SHELL
echo 'tasks	'`{ps -aux | wc -l}
echo 'mem	'$mem(3)' / '$mem(2)
echo 'uptime	'$days'd '$hours'h '$minutes'm'
