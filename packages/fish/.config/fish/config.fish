# source private configs if exists
if [ -e ~/.config/fish/config_work.fish ]
    and . ~/.config/fish/config_work.fish
end

if [ -e ~/.config/fish/config_private.fish ]
    and . ~/.config/fish/config_private.fish
end

### Set ###
# fish_config theme choose "Rosé Pine"

set fish_greeting

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.bin"
fish_add_path "$HOME/Scripts"
set -gx TERM xterm-256color
set -gx EDITOR nvim

### Aliases ###

# fun
alias weather "curl wttr.in"

# shorten
alias vim nvim
alias g git

# replace ls with eza
alias ls "eza -lh --icons"
alias la "eza -lha --icons"
alias l. "eza -a | grep -E '^\.'"
alias lt "eza --tree --level=2 --long --icons --git"

# ip check
alias whatsmyip "curl --silent ifconfig.me | awk '{print $1}'"

# dotfiles repo
alias dot "git -C $HOME/dotfiles"

# hunk diff viewer — custom One Dark theme matching Ghostty terminal
function hunk --description "Hunk diff viewer with One Dark theme"
    # --theme is a subcommand-level flag for visual commands only
    set -l visual_cmds diff show stash patch pager difftool
    if contains -- $argv[1] $visual_cmds
        command hunk $argv[1] --theme custom $argv[2..]
    else
        command hunk $argv
    end
end

# config files
alias vfish "$EDITOR ~/.config/fish/config.fish"
alias vtmux "$EDITOR ~/.tmux.conf"
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

# opencode
fish_add_path "$HOME/.opencode/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "/opt/homebrew/share/google-cloud-sdk/path.fish.inc" ]
    . "/opt/homebrew/share/google-cloud-sdk/path.fish.inc"
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
