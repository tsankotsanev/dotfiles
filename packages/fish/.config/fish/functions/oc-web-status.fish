function oc-web-status --description "Show OpenCode web daemon status (launchd + port)"
    set -l label sh.tsanko.opencode-web
    set -l line (launchctl list | grep $label)
    if test -z "$line"
        echo "not loaded in launchd"
        return 1
    end
    echo "launchd: $line"
    echo
    set -l tip (tailscale ip -4 2>/dev/null | head -n1)
    if test -z "$tip"
        echo "tailscale: down — server can't bind"
        return 1
    end
    echo "tailnet ip: $tip"
    set -l listening (lsof -nP -iTCP:4096 -sTCP:LISTEN 2>/dev/null | tail -n +2)
    if test -n "$listening"
        echo "listening:  $listening"
    else
        echo "listening:  (nothing on :4096 — check ~/.local/share/opencode/web.log)"
    end
end
