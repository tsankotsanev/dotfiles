function dotpush --description "Commit + push a dotfiles repo with the correct GitHub account"
    set -l which $argv[1]
    set -l msg $argv[2..-1]

    if test -z "$which"
        echo "usage: dotpush public|private <message>"
        return 2
    end

    set -l repo
    switch $which
        case public
            set repo ~/dotfiles
        case private
            set repo ~/dotfiles-private
        case '*'
            echo "usage: dotpush public|private <message>"
            echo "  (first arg must be 'public' or 'private')"
            return 2
    end

    if test -z "$msg"
        echo "error: commit message required"
        echo "usage: dotpush public|private <message>"
        return 2
    end

    git -C $repo add -A

    # Commit; tolerate "nothing to commit".
    if git -C $repo commit -m "$msg"
        echo "  ✓ committed: $msg"
    else
        echo "  ◌ nothing to commit (pushing existing commits)"
    end

    # Push as the personal account, ALWAYS restoring work account afterward.
    gh auth switch --user tsankotsanev
    git -C $repo push
    set -l rc $status
    gh auth switch --user tsanko-svg

    if test $rc -eq 0
        echo "  ✓ pushed $which ($repo)"
    else
        echo "  ✗ push failed for $which (rc=$rc)"
    end
    return $rc
end
