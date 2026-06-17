function oc-tmux --description "Start or attach to a persistent OpenCode tmux session"
    set -l session_name "oc"

    # Refuse to nest inside an existing tmux session
    if set -q TMUX
        echo "oc-tmux: already inside tmux. Use 'tmux attach -t $session_name' or detach first."
        return 1
    end

    if tmux has-session -t $session_name 2>/dev/null
        echo "Attaching to existing tmux session '$session_name'..."
        tmux attach -t $session_name
    else
        echo "Creating new tmux session '$session_name' with OpenCode..."
        # Launch via the `oc` function so the session attaches to the shared
        # headless server (live phone/Tailscale sync), not a private server.
        tmux new-session -s $session_name -n opencode "fish -lc oc; exec fish"
    end
end
