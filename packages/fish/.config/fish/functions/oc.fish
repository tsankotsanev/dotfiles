function oc --description "OpenCode attached to the shared web server (live Tailscale/phone sync); daily @cortexkit/*@latest cache refresh"
    set -l stamp ~/.cache/opencode/.cortexkit-update-check
    set -l ttl_seconds 86400  # 24h
    set -l now (date +%s)
    set -l last 0
    if test -f $stamp
        set last (cat $stamp 2>/dev/null; or echo 0)
    end

    if test (math "$now - $last") -ge $ttl_seconds
        if test $last -eq 0
            # First run after install — synchronous so user gets immediate benefit
            __oc_check_plugin_updates
        else
            # Subsequent runs: background, never blocks launch
            __oc_check_plugin_updates &
            disown 2>/dev/null
        end
        mkdir -p (dirname $stamp)
        echo $now > $stamp
    end

    # --- Live sync ---------------------------------------------------------
    # By default, attach to the shared headless server (the same one the phone
    # reaches over Tailscale). Messages typed here then stream to every
    # connected client in real time, instead of living in a private per-terminal
    # server that the phone can never see live.
    #
    #   oc                 -> attach to the shared server in the current dir
    #   oc --continue      -> attach and continue the last session (live on phone)
    #   oc -s <id>         -> attach and open a specific session (live on phone)
    #   oc --standalone    -> force an isolated private session (old behavior)
    # -----------------------------------------------------------------------
    set -l shared_url http://127.0.0.1:4096
    set -l envf /etc/opencode-web.env

    if contains -- --standalone $argv
        set -l rest (string match -v -- --standalone $argv)
        command opencode $rest
        return
    end

    if test -r $envf; and curl -s -o /dev/null --max-time 2 $shared_url/
        # Pass creds via env (read by `opencode attach`) so the password never
        # appears in the process list / shell history.
        set -lx OPENCODE_SERVER_USERNAME (string replace -r '^OPENCODE_SERVER_USERNAME=' '' -- (grep -m1 '^OPENCODE_SERVER_USERNAME=' $envf))
        set -lx OPENCODE_SERVER_PASSWORD (string replace -r '^OPENCODE_SERVER_PASSWORD=' '' -- (grep -m1 '^OPENCODE_SERVER_PASSWORD=' $envf))
        command opencode attach $shared_url --dir (pwd) $argv
    else
        # Shared server not reachable (e.g. opencode-web.service down) —
        # fall back to a standalone session so `oc` always works.
        command opencode $argv
    end
end
