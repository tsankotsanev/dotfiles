# source private configs if exists
if [ -e ~/.config/fish/config_work.fish ]
    and . ~/.config/fish/config_work.fish
end

if [ -e ~/.config/fish/config_private.fish ]
    and . ~/.config/fish/config_private.fish
end

### Set ###
fish_config theme choose "Rosé Pine"

set fish_greeting

set -gx PATH /home/whitez/.bin $PATH
set -gx PATH /home/whitez/Scripts/ $PATH
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx BROWSER brave

### Aliases ###

# fun
alias weather "curl -4 wttr.in"

# shorten
alias vim nvim
alias g git

# reload configs
alias .fish ". ~/.config/fish/config.fish"

# replace ls with exa
alias ls "exa -lh --icons"
alias la "ll -a"
alias l. "exa -a | grep -E '^\.'"
alias lt "ls --tree --level=2 --long --git"

# ip check
alias whatsmyip "curl --silent ifconfig.me | awk '{print $1}'"

# set wallpaper
alias nitrogen "nitrogen ~/Wallpapers/"

# redshift
alias day "redshift -P -O 5600 > /dev/null && echo 'Redshift set to daytime.'"
alias night "redshift -P -O 3400 > /dev/null && echo 'Redshift set to night-time.'"

# system
alias update "sudo pacman -Syyu --noconfirm"
alias sr "sudo reboot"
alias ss "sudo shutdown now"

# bare repos for dotfilles
alias dot "git --git-dir=$HOME/.files/ --work-tree=$HOME"
alias dotpvt "git --git-dir=$HOME/.filespvt/ --work-tree=$HOME"

# config files
alias valacritty "$EDITOR ~/.config/alacritty/alacritty.toml"
alias vqtile "$EDITOR ~/.config/qtile/config.py"
alias vautostart "$EDITOR ~/.config/qtile/scripts/autostart.sh"
alias vpicom "$EDITOR ~/.config/qtile/scripts/picom.conf"
alias vbash "$EDITOR ~/.bashrc"
alias vfish "$EDITOR ~/.config/fish/config.fish"
alias vfishwork "$EDITOR ~/.config/fish/config_work.fish"
alias vfishpvt "$EDITOR ~/.config/fish/config_private.fish"
alias vtmux "$EDITOR ~/.tmux.conf"
alias vbinds "$EDITOR ~/.config/qtile/sxhkd/sxhkdrc"
alias vstarship "$EDITOR ~/.config/starship.toml"


### Functions ###

function ex --description "Extractor for all kinds of archives."
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


function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# initialize starship prompt
starship init fish | .

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/whitez/Downloads/google-cloud-sdk/path.fish.inc' ]
    . '/home/whitez/Downloads/google-cloud-sdk/path.fish.inc'
end
