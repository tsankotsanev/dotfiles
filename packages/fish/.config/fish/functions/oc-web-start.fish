function oc-web-start --description "Load + start the OpenCode web launchd agent"
    launchctl load -w ~/Library/LaunchAgents/sh.tsanko.opencode-web.plist 2>&1
end
