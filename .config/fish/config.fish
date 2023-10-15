export PATH="$PATH:/home/whitez/.bin"
export PATH="$PATH:/home/whitez/Scripts"

if [ -e ~/.config/fish/config_work.fish ]
    and source ~/.config/fish/config_work.fish
end

if [ -e ~/.config/fish/config_private.fish ]
    and source ~/.config/fish/config_private.fish
end

### Set ###

fish_config theme choose "Rosé Pine"

set -gx PATH /home/whitez/.bin $PATH
set fish_greeting
set -gx TERM xterm-256color

### Aliases ###
alias vim nvim
alias g git

alias ls "exa -lh --icons"
alias la "ll -a"
alias l. "exa -a | grep -E '^\.'"
alias lt "ls --tree --level=2 --long --git"

alias day "redshift -P -O 5600"
alias night "redshift -P -O 3400"

alias update "sudo pacman -Syyu --noconfirm"

alias conf "/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME"
alias confpvt="git --git-dir=$HOME/.confpvt/ --work-tree=$HOME"

alias valacritty "vim ~/.config/alacritty/alacritty.yml"
alias vqtile "vim ~/.config/qtile/config.py"
alias vautostart "vim ~/.config/qtile/scripts/autostart.sh"
alias vpicom "vim ~/.config/qtile/scripts/picom.conf"
alias vbash "vim ~/.bashrc"
alias vfish "vim ~/.config/fish/config.fish"
alias vfishwork "vim ~/.config/fish/config_work.fish"
alias vfishpvt "vim ~/.config/fish/config_private.fish"
alias vbinds "vim ~/.config/qtile/sxhkd/sxhkdrc"
alias vstarship "vim ~/.config/starship.toml"

alias sr "sudo reboot"
alias ss "sudo shutdown now"

alias whatsmyip "curl --silent ifconfig.me | awk '{print $1}'"

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

starship init fish | source
