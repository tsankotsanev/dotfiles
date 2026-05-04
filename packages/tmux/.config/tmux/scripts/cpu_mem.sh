#!/bin/bash
# CPU and MEM usage for tmux status bar
# Output: "CPU 12% MEM 45%"

# CPU: average across all cores (0-100%)
ncores=$(sysctl -n hw.ncpu 2>/dev/null || echo 1)
cpu_raw=$(ps -A -o %cpu 2>/dev/null | awk '{s+=$1} END {printf "%.0f", s}')
if [ -n "$cpu_raw" ] && [ "$ncores" -gt 0 ]; then
  cpu_pct=$((cpu_raw / ncores))
  [ "$cpu_pct" -gt 100 ] && cpu_pct=100
else
  cpu_pct="?"
fi

# MEM: percentage of used vs total
mem_pct=$(vm_stat 2>/dev/null | awk '/Pages free/ {free=$3} /Pages active/ {active=$3} /Pages inactive/ {inactive=$3} /Pages speculative/ {spec=$3} /Pages wired/ {wired=$3} END {used=active+wired; total=used+free+inactive+spec; if(total>0) printf "%.0f", (used/total)*100; else printf "0"}')

# Fallback if vm_stat didn't work
if [ -z "$mem_pct" ] || [ "$mem_pct" = "0" ]; then
  mem_pct=$(memory_pressure 2>/dev/null | awk '/System-wide memory free percentage/ {printf "%.0f", 100-$NF}' || echo "?")
fi

echo "CPU ${cpu_pct}% MEM ${mem_pct}%"