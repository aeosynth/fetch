read _ _ KERNEL _ </proc/version

TASKS=0
for dir in /proc/*; do
  if [[ ${dir##*/} =~ ^[0-9]+$ ]]; then
    TASKS=$((TASKS + 1))
  fi
done

IFS=$'\n' read -d "" -a arr </proc/meminfo
read -a tmp <<< "${arr[0]}"
TOTAL=$((tmp[1] / 1000))
read -a tmp <<< "${arr[2]}"
AVAIL=$((tmp[1] / 1000))

read -d '.' tmp </proc/uptime
DAY=$((tmp / 60 / 60 / 24))
HOUR=$((tmp / 60 / 60 % 24))
MINUTE=$((tmp / 60 % 60))

printf "$USER@$HOSTNAME
kernel\t$KERNEL
term\t$TERM
shell\t$SHELL
tasks\t$TASKS
mem\t${AVAIL}m / ${TOTAL}m
uptime\t${DAY}d ${HOUR}h ${MINUTE}m"
