#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${TARGET:-$HOME}"

if ! command -v stow >/dev/null 2>&1; then
  echo "GNU Stow is required. Install it first:" >&2
  echo "  macOS: brew install stow" >&2
  echo "  Arch:  sudo pacman -S stow" >&2
  echo "  Ubuntu/Debian: sudo apt install stow" >&2
  exit 1
fi

packages=(
  git
  tmux
  fish
  nvim
  alacritty
  starship
  qtile
)

cd "$ROOT"
stow --dir packages --target "$TARGET" --no-folding --restow "${packages[@]}"

echo "Installed public dotfiles into $TARGET"
