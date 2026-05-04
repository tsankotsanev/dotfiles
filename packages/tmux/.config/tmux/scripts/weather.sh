#!/bin/bash
# Weather for tmux status bar via wttr.in
# Output: "15°C ☁️" (cached for 30 min)

cache_file="/tmp/.tmux_weather_cache"
cache_max_age=1800  # 30 minutes

# Return cached if fresh
if [ -f "$cache_file" ]; then
  cache_age=$(( $(date +%s) - $(stat -f %m "$cache_file" 2>/dev/null || echo 0) ))
  if [ "$cache_age" -lt "$cache_max_age" ]; then
    cat "$cache_file"
    exit 0
  fi
fi

# Fetch from wttr.in
weather=$(curl -s --max-time 5 "wttr.in?format=%c%t" 2>/dev/null)

# Clean up — wttr sometimes returns HTML entities or extra whitespace
weather=$(echo "$weather" | sed 's/&nbsp;/ /g; s/  */ /g' | tr -s ' ' | xargs)

if [ -z "$weather" ]; then
  weather="🌡 —"
fi

echo "$weather" > "$cache_file"
echo "$weather"