#!/bin/bash
read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
prev_total=$((user + nice + system + idle + iowait + irq + softirq))
prev_idle=$((idle + iowait))
sleep 1
read cpu user nice system idle iowait irq softirq steal guest < /proc/stat
total=$((user + nice + system + idle + iowait + irq + softirq))
idle_time=$((idle + iowait))
diff_total=$((total - prev_total))
diff_idle=$((idle_time - prev_idle))
usage=$((100 * (diff_total - diff_idle) / diff_total))
echo "CPU:${usage}%"

