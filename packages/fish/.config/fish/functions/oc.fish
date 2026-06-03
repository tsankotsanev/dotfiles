function oc --description "OpenCode with daily @cortexkit/*@latest cache refresh"
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

    command opencode $argv
end
