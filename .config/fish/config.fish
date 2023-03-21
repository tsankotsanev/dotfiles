# Source config_private if exists
set -x config_private_path ~/.config/fish/functions/config_private.fish

if test -r $config_private_path -a -f $config_private_path
    source $config_private_path
end

### Set ###

set fish_greeting
set -gx TERM xterm-256color
set -gx EDITOR nvim

### Aliases ###

# Shorten frequently used commands
alias nv nvim
alias g git

# Change ls to exa
alias ls "exa -lh --icons"
alias la "ll -a"
alias l. "exa -a | grep -E '^\.'"
alias lt "ls --tree --level=2 --long --git"

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Night light
alias day "redshift -P -O 5600"
alias night "redshift -P -O 3400"

# System
alias update "sudo pacman -Syyu --noconfirm"

# Bare git repo alias for dotfiles
alias conf "/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME"

# Most opened files
alias nalacritty "$EDITOR ~/.config/alacritty/alacritty.yml"
alias nqtile "$EDITOR ~/.config/qtile/config.py"
alias nautostart "$EDITOR ~/.config/qtile/scripts/autostart.sh"
alias npicom "$EDITOR ~/.config/qtile/scripts/picom.conf"
alias nbash "$EDITOR ~/.bashrc"
alias nfish "$EDITOR ~/.config/fish/config.fish"
alias nbinds "$EDITOR ~/.config/qtile/sxhkd/sxhkdrc"
alias nvimrc "$EDITOR ~/.config/nvim/after/plugin/defaults.lua"

# Confirm before overwriting something
alias cp "cp -i"
alias mv "mv -i"
alias rm "rm -i"

### Functions ###

# Make a directory and cd into it
function mkdircd
    mkdir -p $argv
    cd $argv[-1]
end

function cx
  cd $argv[-1]
  ls
end

# Extractor for all kinds of archives
# usage: ex <file>
function ex
  if test -f $argv[1]
    switch (basename $argv[1])
      case '*.tar.bz2'
        tar xjf $argv[1]
      case '*.tar.gz'
        tar xzf $argv[1]
      case '*.bz2'
        bunzip2 $argv[1]
      case '*.rar'
        unrar x $argv[1]
      case '*.gz'
        gunzip $argv[1]
      case '*.tar'
        tar xf $argv[1]
      case '*.tbz2'
        tar xjf $argv[1]
      case '*.tgz'
        tar xzf $argv[1]
      case '*.zip'
        unzip $argv[1]
      case '*.Z'
        uncompress $argv[1]
      case '*.7z'
        7z x $argv[1]
      case '*.deb'
        ar x $argv[1]
      case '*.tar.xz'
        tar xf $argv[1]
      case '*.tar.zst'
        tar xf $argv[1]
      case '*'
        echo "'$argv[1]' cannot be extracted via ex()"
    end
  else
    echo "'$argv[1]' is not a valid file"
  end
end
