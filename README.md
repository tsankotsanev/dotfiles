# dotfiles

## Installation

```sh
git clone --separate-git-dir=$HOME/.files https://github.com/tsankotsanev/dotfiles.git $HOME/dotfiles-tmp
rsync --recursive --verbose --exclude '.git' $HOME/dotfiles-tmp/ $HOME/
rm --recursive $HOME/dotfiles-tmp
dot config status.showUntrackedFiles no
```

## Usage

```sh
cd ~
dot status
dot add .config/fish/config.fish
dot commit -m "Add config.fish"
dot push
```

> [!NOTE]
> New file or directory creations should be added manually with `dot add path/to/file`

## Resources

-   **[Tmux](https://github.com/tmux/tmux)**
    -   **[Configure colors](https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6)**
