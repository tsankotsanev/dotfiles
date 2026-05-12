#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${TARGET:-$HOME}"
DOTFILES_THEME="${DOTFILES_THEME:-catppuccin}"

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

known_theme_packages=(
  nvim-catppuccin
  tmux-catppuccin
  ghostty-catppuccin
  nvim-onedark
  tmux-onedark
  ghostty-onedark
)

case "$DOTFILES_THEME" in
  catppuccin|onedark) ;;
  *)
    echo "DOTFILES_THEME must be one of: catppuccin, onedark" >&2
    exit 1
    ;;
esac

theme_packages=()
for app in nvim tmux ghostty; do
  package="${app}-${DOTFILES_THEME}"
  if [ -d "$ROOT/packages/$package" ]; then
    theme_packages+=("$package")
  else
    echo "Required theme package '$package' not found" >&2
    exit 1
  fi
done

cd "$ROOT"
stow --dir packages --target "$TARGET" --no-folding --restow "${packages[@]}"

# Remove any previously-stowed theme package after the shared packages succeed,
# so switching from Catppuccin to OneDark (or back) replaces
# colorscheme.local.lua/theme.conf instead of hitting Stow conflicts.
stow --dir packages --target "$TARGET" --no-folding --delete "${known_theme_packages[@]}"
stow --dir packages --target "$TARGET" --no-folding --restow "${theme_packages[@]}"

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

echo "Installed public dotfiles into $TARGET (theme: $DOTFILES_THEME)"
