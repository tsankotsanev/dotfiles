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
  ghostty
  starship
  qtile
)

cd "$ROOT"
stow --dir packages --target "$TARGET" --no-folding --restow "${packages[@]}"

# --- Tmux Plugin Manager ---
TPM_DIR="$TARGET/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "Installing Tmux Plugin Manager..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "TPM already installed, updating..."
  git -C "$TPM_DIR" pull --ff-only
fi

# Install tmux plugins (requires tmux to be installed)
if command -v tmux >/dev/null 2>&1; then
  echo "Installing tmux plugins..."
  tmux start-server \; source-file "$TARGET/.tmux.conf" \; run-shell "$TPM_DIR/bin/install_plugins" 2>/dev/null || true
  echo "Tmux plugins installed. Run prefix+I inside tmux to finalize."
else
  echo "tmux not found — skipping plugin install. Run prefix+I inside tmux after installing tmux."
fi

echo "Installed public dotfiles into $TARGET"
