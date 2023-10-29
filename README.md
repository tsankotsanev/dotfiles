# dotfiles

## Setup

```sh
git init --bare $HOME/.myconf
alias conf='git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
conf remote add origin git@github.com:tsankotsanev/dotfiles.git
```

## Replication

```sh
git clone --separate-git-dir=$HOME/.myconf https://github.com/tsankotsanev/dotfiles.git myconf-tmp
rsync --recursive --verbose --exclude '.git' myconf-tmp/ $HOME/
rm --recursive myconf-tmp
```

## Configuration

```sh
conf config status.showUntrackedFiles no
conf remote set-url origin git@github.com:tsankotsanev/dotfiles.git
```

## Usage

```sh
cd ~
conf status
conf add .config/fish/config.fish
conf commit -m "Add config.fish"
conf push
```

## Resources

- **[Tmux](https://github.com/tmux/tmux)**
  - **[Configure colors](https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6)**
