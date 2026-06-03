function oc-web-password-copy --description "Copy OpenCode web Basic Auth password to clipboard"
    set -l pw (security find-generic-password -s opencode-server -a opencode -w 2>/dev/null)
    if test -z "$pw"
        echo "no keychain item — run oc-web-password-reset first" >&2
        return 1
    end
    printf '%s' $pw | pbcopy
    echo "copied (length: "(string length $pw)") — paste into iPhone Safari when it prompts"
end
