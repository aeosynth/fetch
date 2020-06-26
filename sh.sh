read _ _ KERNEL _ </proc/version

[ -z "$HOSTNAME" ] && read HOSTNAME </etc/hostname

TASKS=0
for dir in /proc/*; do
  case $dir in
  	*[0-9]*) TASKS=$((TASKS + 1)) ;;
  esac
done

set --

while IFS=$'\n' read -r l; do
	set -- $@ $l
done </proc/meminfo

TOTAL=$(($2 / 1000))
AVAIL=$(($8 / 1000))

IFS=. read tmp _ </proc/uptime
DAY=$(($tmp / 60 / 60 / 24))
HOUR=$(($tmp / 60 / 60 % 24))
MINUTE=$(($tmp / 60 % 60))

printf "$USER@$HOSTNAME
kernel\t$KERNEL
term\t$TERM
shell\t$SHELL
tasks\t$TASKS
mem\t${AVAIL}m / ${TOTAL}m
uptime\t${DAY}d ${HOUR}h ${MINUTE}m"
