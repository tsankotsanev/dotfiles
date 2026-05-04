#!/bin/bash
# Git status for tmux status bar
# Output: "main ●2↑1" (branch + dirty count + ahead count)
# Or: "main ✓" (clean, up to date)

# Get current directory's git info
git_dir=$(git -C "${TMUX_PANE_DIR:-$(pwd)}" rev-parse --git-dir 2>/dev/null)

if [ -z "$git_dir" ]; then
  # Try the pane's current path from tmux
  pane_path=$(tmux display-message -p "#{pane_current_path}" 2>/dev/null)
  git_dir=$(git -C "$pane_path" rev-parse --git-dir 2>/dev/null)
fi

if [ -z "$git_dir" ]; then
  exit 0
fi

pane_path=$(tmux display-message -p "#{pane_current_path}" 2>/dev/null)
cd "$pane_path" 2>/dev/null || exit 0

branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)

if [ -z "$branch" ]; then
  exit 0
fi

# Dirty files count
dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

# Ahead/behind
ahead=$(git log --oneline "@{upstream}..HEAD" 2>/dev/null | wc -l | tr -d ' ')
behind=$(git log --oneline "HEAD..@{upstream}" 2>/dev/null | wc -l | tr -d ' ')

# Stash count
stash=$(git stash list 2>/dev/null | wc -l | tr -d ' ')

result="${branch}"

if [ "$dirty" -gt 0 ]; then
  result="${result} ●${dirty}"
fi

if [ "$ahead" -gt 0 ]; then
  result="${result} ↑${ahead}"
fi

if [ "$behind" -gt 0 ]; then
  result="${result} ↓${behind}"
fi

if [ "$stash" -gt 0 ]; then
  result="${result} ⚑${stash}"
fi

echo "$result"