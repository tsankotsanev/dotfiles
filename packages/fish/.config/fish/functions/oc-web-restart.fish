function oc-web-restart --description "Restart the OpenCode web daemon"
    launchctl kickstart -k gui/(id -u)/sh.tsanko.opencode-web 2>&1
end
