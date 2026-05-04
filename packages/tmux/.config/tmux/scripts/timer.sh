#!/bin/bash
# Pomodoro timer for tmux status bar
# prefix+T = start 25min focus, prefix+B = start 5min break, prefix+S = stop
# Shows countdown when active, "⏱ 25:00" when idle

timer_file="/tmp/.tmux_timer"

if [ ! -f "$timer_file" ]; then
  echo "⏱ 25:00"
  exit 0
fi

# File format: end_timestamp:type (focus|break)
IFS=: read -r end_time timer_type < "$timer_file"

if [ -z "$end_time" ]; then
  echo "⏱ 25:00"
  exit 0
fi

now=$(date +%s)
remaining=$((end_time - now))

if [ "$remaining" -le 0 ]; then
  # Timer finished
  if [ "$timer_type" = "focus" ]; then
    echo "⏰ FOCUS DONE"
  elif [ "$timer_type" = "break" ]; then
    echo "⏰ BREAK DONE"
  else
    echo "⏰ DONE"
  fi
  exit 0
fi

mins=$((remaining / 60))
secs=$((remaining % 60))

if [ "$timer_type" = "focus" ]; then
  printf "🍅 %d:%02d" "$mins" "$secs"
elif [ "$timer_type" = "break" ]; then
  printf "☕ %d:%02d" "$mins" "$secs"
else
  printf "⏱ %d:%02d" "$mins" "$secs"
fi