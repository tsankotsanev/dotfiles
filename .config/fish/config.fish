# Source configs and scripts

if [ -e ~/.config/fish/config_work.fish ]
    and source ~/.config/fish/config_work.fish
end

if [ -e ~/.config/fish/config_private.fish ]
    and source ~/.config/fish/config_private.fish
end

if [ -e ~/.config/fish/config_private.fish ]
    and set -gx PATH ~/Scripts $PATH
end

### Set ###

# Rose pine theme
fish_config theme choose "Rosé Pine"

set -gx PATH /home/whitez/.bin $PATH
set fish_greeting
set -gx TERM xterm-256color
set -gx EDITOR nvim

### Aliases ###

# Frequently used commands
alias vim nvim
alias g git

# Change ls to exa
alias ls "exa -lh --icons"
alias la "ll -a"
alias l. "exa -a | grep -E '^\.'"
alias lt "ls --tree --level=2 --long --git"

# Night light
alias day "redshift -P -O 5600"
alias night "redshift -P -O 3400"

# System
alias update "sudo pacman -Syyu --noconfirm"

# Bare git repo alias for dotfiles
alias conf "/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME"

# Most opened files
alias valacritty "$EDITOR ~/.config/alacritty/alacritty.yml"
alias vqtile "$EDITOR ~/.config/qtile/config.py"
alias vautostart "$EDITOR ~/.config/qtile/scripts/autostart.sh"
alias vpicom "$EDITOR ~/.config/qtile/scripts/picom.conf"
alias vbash "$EDITOR ~/.bashrc"
alias vfish "$EDITOR ~/.config/fish/config.fish"
alias vbinds "$EDITOR ~/.config/qtile/sxhkd/sxhkdrc"
alias vstarship "$EDITOR ~/.config/starship.toml"

# Shutdown
alias sr "sudo reboot"
alias ss "sudo shutdown now"

# Utils
alias whatsmyip "curl --silent ifconfig.me | awk '{print $1}'"

### Functions ###

# Make a directory and cd into it
function mkdircd
    mkdir -p $argv
    cd $argv[-1]
end

# Change to directory and list the files if there are any
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

# Execute starship prompt
starship init fish | source

export PATH="$PATH:/home/whitez/.bin"
