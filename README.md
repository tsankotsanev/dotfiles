# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Layout

```text
packages/
  git/              -> ~/.gitconfig
  tmux/             -> ~/.tmux.conf
  fish/             -> ~/.config/fish
  nvim/             -> ~/.config/nvim
  alacritty/        -> ~/.config/alacritty
  ghostty/            -> ~/.config/ghostty
  starship/           -> ~/.config/starship.toml
  qtile/              -> ~/.config/qtile
  nvim-catppuccin/    -> Catppuccin Neovim theme override
  tmux-catppuccin/    -> Catppuccin tmux theme override
  ghostty-catppuccin/ -> Catppuccin Ghostty theme override
  nvim-onedark/       -> OneDark Neovim theme override
  tmux-onedark/       -> OneDark tmux theme override
  ghostty-onedark/    -> OneDark Ghostty theme override
```

## Install

```sh
git clone git@github.com:tsankotsanev/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh                         # default: Catppuccin theme packages
DOTFILES_THEME=onedark ./install.sh  # OneDark theme packages
```

The installer uses `stow --no-folding`, so package contents are symlinked into
`$HOME` while the repo remains a normal Git checkout. Theme-specific packages
are selected with `DOTFILES_THEME` and currently cover Neovim, tmux, and
Ghostty.

## Theme switching

This repo keeps shared config theme-neutral and uses small Stow packages for
theme-specific files:

| Theme | Packages |
|---|---|
| Catppuccin | `nvim-catppuccin`, `tmux-catppuccin`, `ghostty-catppuccin` |
| OneDark | `nvim-onedark`, `tmux-onedark`, `ghostty-onedark` |

Switch the machine theme by re-running install with the target theme:

```sh
DOTFILES_THEME=catppuccin ./install.sh
DOTFILES_THEME=onedark ./install.sh
```

OpenCode is intentionally not stowed here because its global config can contain
private provider and MCP settings. To match the terminal/editor theme, merge the
right theme into `~/.config/opencode/tui.json` or select it with `/theme`:

```json
{
  "$schema": "https://opencode.ai/tui.json",
  "theme": "catppuccin"
}
```

For OneDark, use:

```json
{
  "$schema": "https://opencode.ai/tui.json",
  "theme": "one-dark"
}
```

## Daily workflow

After installing, Fish defines:

```fish
dot # git -C ~/dotfiles
```

Common commands:

```sh
dot status
dot diff
dot add packages/fish/.config/fish/config.fish
dot commit -m "update fish config"
dot push
```

## Safety rules

Do not commit secrets, tokens, VPN files, generated `.env` files, or
machine-specific credentials. Keep raw secrets in local ignored files.

Before pushing public changes, run:

```sh
git diff --cached
rg -n --hidden --glob '!.git/**' 'token|secret|password|api[_-]?key|credential|BEGIN|\.ovpn|proxy'
```
