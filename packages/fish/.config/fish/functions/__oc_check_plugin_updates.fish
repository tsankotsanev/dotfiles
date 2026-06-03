function __oc_check_plugin_updates --description "Refresh stale @cortexkit/*@latest plugin caches"
    set -l cache_root ~/.cache/opencode/packages/@cortexkit
    test -d $cache_root; or return 0

    for dir in $cache_root/*@latest
        test -d $dir; or continue
        set -l pkg (basename $dir | string replace '@latest' '')
        set -l pj $dir/node_modules/@cortexkit/$pkg/package.json
        test -f $pj; or continue

        set -l cache_ver (jq -r '.version' $pj 2>/dev/null)
        set -l npm_ver (npm view @cortexkit/$pkg version 2>/dev/null)
        test -n "$npm_ver"; or continue  # offline / npm failed → leave alone

        if test "$cache_ver" != "$npm_ver"
            echo "oc: refreshing @cortexkit/$pkg cache ($cache_ver → $npm_ver)" >&2
            rm -rf $dir
        end
    end
end
