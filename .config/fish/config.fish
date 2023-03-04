### Set ###

set fish_greeting ""
set -gx TERM xterm-256color
set -gx EDITOR nvim

### Aliases ###

alias vim nvim

# List
alias ls "exa --icons"
alias la "ls -a"
alias ll "exa -lh --icons"
alias lla "ll -a"
alias l. "exa -a | grep -E '^\.'"
alias lt "ls --tree --level=2 --long --git"

# Night light
alias day "redshift -P -O 5600"
alias night "redshift -P -O 3400"

# System
alias update "sudo pacman -Syyu --noconfirm"

# Git
alias config "/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME"

# Quick navigation
alias valacritty "$EDITOR ~/.config/alacritty/alacritty.yml"
alias vqtile "$EDITOR ~/.config/qtile/config.py"
alias vbash "$EDITOR ~/.bashrc"
alias vfish "$EDITOR ~/.config/fish/config.fish"

# Scripts
# usage: rescrape <spider_name> <num_runs>
alias rescrape "~/Scripts/rescrape.sh"

### Functions ###

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


