#!/bin/bash
# Now Playing for tmux status bar (macOS)
# Shows current Spotify track only when playing
# Default: "♫ —" when nothing is playing

# Check if Spotify is running and playing
state=$(osascript -e 'tell application "Spotify" to get player state' 2>/dev/null)

if [ "$state" != "playing" ]; then
  echo "♫ —"
  exit 0
fi

np=$(nowplaying-cli get title 2>/dev/null)

if [ -z "$np" ] || [ "$np" = "null" ]; then
  echo "♫ —"
  exit 0
fi

artist=$(nowplaying-cli get artist 2>/dev/null)

# Truncate long titles
np=$(echo "$np" | cut -c1-30)
artist=$(echo "$artist" | cut -c1-20)

if [ -n "$artist" ] && [ "$artist" != "null" ]; then
  echo "♫ ${artist} - ${np}"
else
  echo "♫ ${np}"
fi