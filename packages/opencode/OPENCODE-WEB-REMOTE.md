# OpenCode web from any device on the tailnet

Run OpenCode in your phone's Safari (or any browser) by reaching the
local `opencode serve` daemon over Tailscale. No port forwarding, no
public DNS, no exposed services — just your tailnet + Basic Auth.

## Architecture

```
┌─────────────┐                  ┌──────────────────────────┐
│ iPhone /    │   Tailscale      │  Mac                     │
│ second PC   │  (WireGuard)     │  ┌────────────────────┐  │
│             ├─────────────────►│  │ launchd            │  │
│ Safari /    │   100.x.y.z:4096 │  │  └── opencode      │  │
│ opencode    │   Basic Auth     │  │       serve (4096) │  │
│ attach      │                  │  └────────────────────┘  │
└─────────────┘                  └──────────────────────────┘
```

* **Network confidentiality**: every byte goes over Tailscale's WireGuard mesh.
* **App-level auth**: opencode rejects unauthenticated requests (`401`).
* **Bound to tailnet IP only**: the server does NOT listen on `0.0.0.0`; café/hotel wifi can't touch it even if you're on the same SSID.
* **Password**: 32 chars, stored in macOS Keychain (`security`), pulled by the launchd wrapper at start, never written to any dotfile.

## Components

| File | Purpose |
|---|---|
| `Library/LaunchAgents/sh.tsanko.opencode-web.plist` | launchd unit (auto-start at login, restart on crash) |
| `.local/bin/oc-web-launcher.sh` | Wrapper that pulls Keychain password, resolves tailnet IP, execs `opencode serve` |
| `~/.local/share/opencode/web.log` | Daemon logs |
| Keychain item `opencode-server / opencode` | Basic Auth password |

Helper functions in `packages/fish/.config/fish/functions/`:

| Command | What it does |
|---|---|
| `oc-web-status` | launchd state + tailnet IP + listening socket |
| `oc-web-url` | Print MagicDNS / FQDN / IP URLs for the phone |
| `oc-web-password-copy` | Copy Basic Auth password to clipboard |
| `oc-web-password-reset` | Rotate the password and restart the daemon |
| `oc-web-start` / `oc-web-stop` / `oc-web-restart` | launchctl wrappers |
| `oc-web-logs` | `tail -f` the daemon log |

## Using it from iPhone

1. Install **Tailscale** from the App Store, sign in to the **same** account as the Mac.
2. Confirm the Mac appears in the Tailscale app on the phone.
3. On the Mac, run `oc-web-url` and `oc-web-password-copy`.
4. In iPhone Safari, paste the **Short URL** (`http://users-macbook-pro:4096/`).
5. When Safari prompts for username/password, username is `opencode`, paste the password.
6. (Optional) Add to Home Screen for an app-like icon.

The iPhone's Tailscale tunnel makes `users-macbook-pro` resolvable via MagicDNS — no IP needed.

## Using it from a second PC (Windows + WSL)

### Step 1 — Tailscale

Install **Tailscale for Windows** (https://tailscale.com/download/windows) on the Windows side. Sign in to the same personal account. Tailscale runs as a Windows service and is shared into WSL automatically — WSL apps can reach `users-macbook-pro` immediately, no config inside WSL.

To confirm from WSL:
```bash
tailscale status         # should show the Mac
ping users-macbook-pro   # MagicDNS resolves
```

If `tailscale` isn't on PATH inside WSL, alias it: `alias tailscale=/mnt/c/Program\ Files/Tailscale/tailscale.exe`.

### Step 2 — Two patterns for "second PC also runs opencode"

#### Pattern A — Each machine independent, you choose which to use

Run `opencode serve` (or just `opencode`) on the second PC too. Sessions on each machine stay local to that machine.

- From iPhone Safari: hit whichever URL you want (`http://users-macbook-pro:4096` or `http://second-pc:4096`).
- From either PC: just launch `opencode` locally.

Best when the two PCs work on different projects.

#### Pattern B — One brain, the other PC attaches

Mac runs the daemon. Second PC's *interactive* sessions attach to the Mac instead of having their own:

```bash
# On the second PC (WSL):
opencode attach http://users-macbook-pro:4096
```

The phone, the second PC, and the Mac all share one session brain.

Best when both PCs work on the same project and you want zero session divergence.

#### Pattern C — Both PCs independent, but share memories

Each machine runs its own opencode. Sync magic-context's memory DB with Syncthing or rclone:

```
~/.local/share/cortexkit/magic-context/context.db
```

Sessions stay per-machine; long-term memories pool across both. Good middle ground.

## Security notes

* If you ever sense the password leaked, run `oc-web-password-reset`. Rotates Keychain, kicks the daemon, all old sessions invalidated.
* The daemon refuses to start if Tailscale is down. There's no way for the server to accidentally bind to `0.0.0.0` and expose itself to non-tailnet networks.
* `OPENCODE_SERVER_PASSWORD` is read once at process start. If you want to change it without restart, you can't — `oc-web-password-reset` does both atomically.
* HTTP, not HTTPS: traffic inside Tailscale is already WireGuard-encrypted, so there's nothing to add by terminating TLS at the server. If you want a green padlock in the browser bar, enable Tailscale HTTPS at https://login.tailscale.com/admin/dns and use `tailscale serve` to front the port; not required for safety.
