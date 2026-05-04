#!/bin/bash
# Uptime for tmux status bar
# Output: "up 3d 5h" or "up 5h 12m" or "up 12m"

boot_time=$(sysctl -n kern.boottime 2>/dev/null | awk -F'[ ,]' '{print $4}')
if [ -n "$boot_time" ]; then
  now=$(date +%s)
  uptime_s=$((now - boot_time))
  
  days=$((uptime_s / 86400))
  hours=$(( (uptime_s % 86400) / 3600 ))
  mins=$(( (uptime_s % 3600) / 60 ))
  
  if [ "$days" -gt 0 ]; then
    echo "up ${days}d ${hours}h"
  elif [ "$hours" -gt 0 ]; then
    echo "up ${hours}h ${mins}m"
  else
    echo "up ${mins}m"
  fi
else
  echo "up ?"
fi