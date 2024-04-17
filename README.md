# dotfiles

## Installation

```sh
dot remote add origin git@github.com:tsankotsanev/dotfiles.git
git clone --separate-git-dir=$HOME/.files https://github.com/tsankotsanev/dotfiles.git dotfiles-tmp
rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
rm --recursive dotfiles-tmp
dot config status.showUntrackedFiles no
dot remote set-url origin git@github.com:tsankotsanev/dotfiles.git
```

## Usage

```sh
cd ~
dot status
dot add .config/fish/config.fish
dot commit -m "Add config.fish"
dot push
```

> [NOTE]
> New file or directory creations should be added manually with `dot add path/to/file`

## Resources

-   **[Tmux](https://github.com/tmux/tmux)**
    -   **[Configure colors](https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6)**
