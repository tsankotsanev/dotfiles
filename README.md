# dotfiles

## Setup
```sh
git init --bare $HOME/.myconf
alias config='git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
config remote add origin git@github.com:tsankotsanev/dotfiles.git
```

## Replication
```sh
git clone --separate-git-dir=$HOME/.myconf https://github.com/tsankotsanev/dotfiles.git myconf-tmp
rsync --recursive --verbose --exclude '.git' myconf-tmp/ $HOME/
rm --recursive myconf-tmp
```

## Configuration
```sh
config config status.showUntrackedFiles no
config remote set-url origin git@github.com:tsankotsanev/dotfiles.git
```

## Usage
```sh
cd ~ 
config status
config add .config/fish/config.fish
config commit -m "Add config.fish"
config push
```
