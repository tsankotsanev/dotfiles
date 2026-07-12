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

## New-machine onboarding

### Personal machine

```sh
# 1. Public dotfiles
git clone git@github.com:tsankotsanev/dotfiles.git ~/dotfiles
cd ~/dotfiles
DOTFILES_THEME=catppuccin ./install.sh

# 2. Private dotfiles (opencode config, work skills/agents)
git clone <private-repo-url> ~/dotfiles-private
cd ~/dotfiles-private
cp packages/opencode/.config/opencode/.env.personal.example \
   packages/opencode/.config/opencode/.env      # then edit: set OPENAI_API_KEY, CONFIG_DIR
./install.sh

# 3. Generate opencode config from the profile
python3 ~/.config/opencode/setup.py
```

### Work machine (HyperadAI)

Same as personal, but use the work profile and fill in the secret vars:

```sh
cp packages/opencode/.config/opencode/.env.work-hyperad.example \
   packages/opencode/.config/opencode/.env      # then fill secrets (Jira, GCP, Firestore, ...)
./install.sh
python3 ~/.config/opencode/setup.py
```

The two `.env.*.example` profiles are the "profile system": the personal profile
turns work MCPs/skills/agents OFF, the work profile turns them ON. See the
private repo's README for the toggle reference.

## Sync tooling

Two Fish functions ship with the `fish` package (auto-stowed):

```fish
# Pull (fast-forward only) both repos, re-stow, and regenerate opencode config.
# Honors DOTFILES_THEME (default: catppuccin). Aborts if either repo has diverged.
dotsync

# Commit + push a repo under the correct GitHub account (personal), then
# always restore the work account afterward.
dotpush public  "update fish config"
dotpush private "tune opencode toggles"
```

`dotsync` never force-pushes and never merges a diverged branch — if a repo is
both ahead and behind upstream it prints `DIVERGED — resolve manually` and stops.

## Machine-local git overrides

The tracked `packages/git/.gitconfig` is **portable only** (aliases, colors,
personal identity, and an `includeIf gitdir:~/Projects/` that applies the work
email to work repos). Machine-specific bits live in two untracked files that are
`.gitignore`d and silently ignored when absent:

| File | Purpose |
|---|---|
| `~/.gitconfig.local` | Per-machine `difftool`, the `d` alias, and the credential helper (e.g. `gh auth git-credential` on this Mac). Pulled in via `[include]` at the end of the tracked config. |
| `~/.gitconfig-work` | Work email (`user.email`) applied to `~/Projects/` repos via `[includeIf]`. |

On a bare machine, create `~/.gitconfig.local` with the appropriate difftool and
credential helper for that OS; `~/.gitconfig-work` only needs the work `[user]`
email if you clone work repos under `~/Projects/`.

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
