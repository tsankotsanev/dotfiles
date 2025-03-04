# Dotfiles

## Setup


```sh
alias dot "git --git-dir=$HOME/.files/ --work-tree=$HOME"
git clone --separate-git-dir=$HOME/.files --branch work git@github.com:tsankotsanev/dotfiles.git $HOME/dot-tmp
rsync --recursive --verbose --exclude '.git' $HOME/dot-tmp/ $HOME/
rm --recursive $HOME/dot-tmp
git --git-dir=$HOME/.files --work-tree=$HOME config status.showUntrackedFiles no
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
