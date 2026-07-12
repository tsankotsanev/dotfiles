function __dotsync_pull --description "Fast-forward-only pull of one dotfiles repo"
    set -l repo $argv[1]
    set -l name (basename $repo)

    if not test -d $repo/.git
        echo "  ✗ $name: not a git repo ($repo)"
        return 1
    end

    git -C $repo fetch --quiet
    or begin
        echo "  ✗ $name: fetch failed"
        return 1
    end

    # Compute ahead/behind relative to upstream. Format: "<ahead>\t<behind>".
    set -l counts (git -C $repo rev-list --left-right --count HEAD...@{u} 2>/dev/null)
    if test -z "$counts"
        echo "  ✗ $name: no upstream configured"
        return 1
    end
    set -l ahead (echo $counts | awk '{print $1}')
    set -l behind (echo $counts | awk '{print $2}')

    if test $ahead -gt 0 -a $behind -gt 0
        echo "  ✗ $name: DIVERGED — resolve manually (ahead $ahead, behind $behind)"
        return 1
    else if test $behind -gt 0
        git -C $repo merge --ff-only @{u} --quiet
        or begin
            echo "  ✗ $name: fast-forward merge failed"
            return 1
        end
        echo "  ✓ $name: fast-forwarded ($behind new)"
    else
        echo "  ✓ $name: up to date"
    end
    return 0
end

function dotsync --description "Pull + apply dotfiles (public + private), stow, regenerate opencode config"
    set -l theme $DOTFILES_THEME
    if test -z "$theme"
        set theme catppuccin
    end

    set -l failed 0

    echo "→ Pulling dotfiles (fast-forward only)..."
    __dotsync_pull ~/dotfiles; or set failed 1
    __dotsync_pull ~/dotfiles-private; or set failed 1

    if test $failed -ne 0
        echo "✗ Pull step failed — aborting before stow/regen"
        return 1
    end

    echo "→ Stowing public dotfiles (theme=$theme)..."
    if env DOTFILES_THEME=$theme bash ~/dotfiles/install.sh
        echo "  ✓ public stow"
    else
        echo "  ✗ public stow"
        set failed 1
    end

    echo "→ Stowing private dotfiles..."
    if bash ~/dotfiles-private/install.sh
        echo "  ✓ private stow"
    else
        echo "  ✗ private stow"
        set failed 1
    end

    echo "→ Checking opencode .env..."
    if python3 ~/.config/opencode/setup.py --check
        echo "  ✓ setup.py --check"
    else
        echo "  ✗ setup.py --check"
        set failed 1
    end

    echo "→ Regenerating opencode config..."
    if python3 ~/.config/opencode/setup.py
        echo "  ✓ setup.py"
    else
        echo "  ✗ setup.py"
        set failed 1
    end

    if test $failed -ne 0
        echo "✗ dotsync completed with errors"
        return 1
    end
    echo "✓ dotsync complete"
    return 0
end
