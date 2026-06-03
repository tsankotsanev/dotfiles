function oc-web-stop --description "Unload the OpenCode web launchd agent"
    launchctl unload -w ~/Library/LaunchAgents/sh.tsanko.opencode-web.plist 2>&1
end
