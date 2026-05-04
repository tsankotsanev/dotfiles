# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Layout

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

## Install

```sh
git clone git@github.com:tsankotsanev/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The installer uses `stow --no-folding`, so package contents are symlinked into
`$HOME` while the repo remains a normal Git checkout.

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
