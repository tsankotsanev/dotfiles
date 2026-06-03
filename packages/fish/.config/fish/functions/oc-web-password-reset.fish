function oc-web-password-reset --description "Rotate OpenCode web Basic Auth password (Keychain + daemon restart)"
    set -l new (openssl rand -base64 24 | tr -d '/+=' | head -c 32)
    security delete-generic-password -s opencode-server -a opencode 2>/dev/null
    security add-generic-password -s opencode-server -a opencode -w $new -j "OpenCode server Basic Auth password (rotated "(date -u +%FT%TZ)")" -U
    echo "rotated"
    oc-web-restart
end
