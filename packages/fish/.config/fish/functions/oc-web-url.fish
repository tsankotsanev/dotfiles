function oc-web-url --description "Print the URL to reach OpenCode web from this tailnet"
    set -l short (tailscale status --json 2>/dev/null | jq -r '.Self.DNSName' | string trim --right --chars=. | string split . | head -n1)
    set -l fqdn (tailscale status --json 2>/dev/null | jq -r '.Self.DNSName' | string trim --right --chars=.)
    set -l tip (tailscale ip -4 2>/dev/null | head -n1)
    set -l user "opencode"
    set -l pw (security find-generic-password -s opencode-server -a $user -w 2>/dev/null)

    echo "From any device on your tailnet:"
    echo
    echo "  Short (MagicDNS):  http://$short:4096/"
    echo "  Full (FQDN):       http://$fqdn:4096/"
    echo "  Raw IP fallback:   http://$tip:4096/"
    echo
    echo "Basic auth:"
    echo "  username: $user"
    if test -n "$pw"
        echo "  password: (in Keychain, run 'oc-web-password-copy' to copy to clipboard)"
    else
        echo "  password: (NOT FOUND in Keychain — run oc-web-password-reset)"
    end
end
