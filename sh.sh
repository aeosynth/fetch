read _ _ KERNEL _ </proc/version

read HOSTNAME </etc/hostname

TASKS=0
for dir in /proc/*; do
  	[ "${dir##*/}" -gt -1 ] 2>/dev/null && TASKS=$((TASKS + 1))
done

while IFS=$'\n' read -r l; do
	set -- $l
	case "$1" in
		MemTotal:)
			TOTAL=$2 ;;
		MemAvailable:)
			AVAIL=$2 ;;
	esac
done </proc/meminfo

TOTAL=$(($TOTAL / 1000))
AVAIL=$(($AVAIL / 1000))

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
