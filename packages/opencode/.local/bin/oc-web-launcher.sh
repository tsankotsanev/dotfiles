#!/bin/bash
# oc-web-launcher.sh — launchd entry point for the OpenCode web/serve daemon.
# Pulls the Basic Auth password from macOS Keychain at startup, binds the
# server to the Tailscale interface only (no LAN/wifi exposure), and execs
# `opencode serve` so launchd sees the real process.

set -euo pipefail

# 1) Resolve tailnet IPv4 — wait briefly if tailscale isn't up yet at login.
TS_BIN=/usr/local/bin/tailscale
TAILNET_IP=""
for _ in 1 2 3 4 5 6 7 8 9 10; do
  TAILNET_IP=$("$TS_BIN" ip -4 2>/dev/null | head -n1 || true)
  [ -n "$TAILNET_IP" ] && break
  sleep 2
done
if [ -z "$TAILNET_IP" ]; then
  echo "[$(date -u +%FT%TZ)] FATAL: tailscale not reachable; refusing to bind 0.0.0.0" >&2
  exit 1
fi

# 2) Pull password from login keychain. -w prints just the password to stdout.
OPENCODE_SERVER_PASSWORD=$(/usr/bin/security find-generic-password \
  -s opencode-server -a opencode -w 2>/dev/null || true)
if [ -z "$OPENCODE_SERVER_PASSWORD" ]; then
  echo "[$(date -u +%FT%TZ)] FATAL: keychain item opencode-server/opencode not found" >&2
  exit 1
fi

export OPENCODE_SERVER_PASSWORD
export OPENCODE_SERVER_USERNAME=opencode

# 3) Hand off to opencode serve. exec so launchd tracks the right PID.
OC_BIN=/opt/homebrew/bin/opencode
echo "[$(date -u +%FT%TZ)] starting opencode serve on $TAILNET_IP:4096 (auth on)" >&2
exec "$OC_BIN" serve \
  --hostname "$TAILNET_IP" \
  --port 4096 \
  --print-logs \
  --log-level INFO
