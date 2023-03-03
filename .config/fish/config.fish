### Set ###

set fish_greeting ""
set -gx TERM xterm-256color
set -gx EDITOR nvim

### Aliases ###

# List
alias ls "exa --icons"
alias la "ls -a"
alias ll "exa -lh --icons"
alias lla "ll -a"
alias l.="exa -a| grep -E '^\.'"

# Night light
alias day "redshift -P -O 5600"
alias night "redshift -P -O 3400"

# System
alias update="sudo pacman -Syyu --noconfirm"
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'

# Quicker navigation
alias nb="$EDITOR ~/.bashrc"
alias nf="$EDITOR ~/.config/fish/config.fish"

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


