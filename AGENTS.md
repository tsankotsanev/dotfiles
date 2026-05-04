# Agent Guide: dotfiles

This is a normal GNU Stow-based dotfiles repository.

## Safety rules

- Do not push unless the user explicitly asks.
- Do not commit secrets, tokens, credentials, VPN files, `.env` files, SSH keys, or machine-specific private data.
- Before committing or opening a PR, run a redacted secret scan if `gitleaks` is available:

  ```sh
  gitleaks detect --source . --redact --no-banner
  ```

- Keep this repository standalone. Do not document or reference any other private repository here.

## Repository layout

```text
packages/
  git/        -> ~/.gitconfig
  tmux/       -> ~/.tmux.conf
  fish/       -> ~/.config/fish
  nvim/       -> ~/.config/nvim
  alacritty/  -> ~/.config/alacritty
  starship/   -> ~/.config/starship.toml
  qtile/      -> ~/.config/qtile
```

## Fresh machine setup

Install prerequisites first:

```sh
# macOS
brew install git stow gh node python

# Ubuntu/Debian
sudo apt update
sudo apt install git stow gh nodejs npm python3 python3-venv

# Arch
sudo pacman -S git stow github-cli nodejs npm python python-virtualenv
```

Clone and install:

```sh
git clone git@github.com:tsankotsanev/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer runs:

```sh
stow --dir packages --target "$HOME" --no-folding --restow \
  git tmux fish nvim alacritty starship qtile
```

## Existing machine migration

If files already exist at the target paths, Stow may refuse to overwrite them.
Back up conflicting paths before running `./install.sh`:

```sh
mv ~/.config/fish ~/.config/fish.backup.$(date +%Y%m%d-%H%M%S)
mv ~/.config/nvim ~/.config/nvim.backup.$(date +%Y%m%d-%H%M%S)
mv ~/.tmux.conf ~/.tmux.conf.backup.$(date +%Y%m%d-%H%M%S)
```

Only back up paths that actually conflict.

## Daily workflow

After the Fish config is installed, the `dot` alias is available:

```fish
dot status
dot diff
dot add <files>
dot commit -m "update dotfiles"
dot push
```

Without Fish aliases, use:

```sh
git -C ~/dotfiles status
git -C ~/dotfiles diff
```

## Editing guidance

- Put files under the package that owns their target path.
- Prefer `$HOME` or `~` over hardcoded machine-specific paths.
- Keep generated state out of git, especially:
  - `fish_variables`
  - `.env`
  - credential files
  - local caches
- If adding a new package, update both `README.md` and `install.sh`.
