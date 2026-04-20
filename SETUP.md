# Setup Guide (for AI agents and humans)

This guide takes a fresh macOS machine from nothing to a fully-working AeroSpace config. Each step is small, idempotent, and verifiable.

If you are an AI agent: run the commands, check the "Expected output" after each, and stop if anything mismatches. Don't guess — ask the human if a step fails.

---

## Prerequisites

| Need | How to verify | How to install |
|---|---|---|
| macOS 13+ (Sonoma or newer recommended) | `sw_vers -productVersion` | n/a |
| Homebrew | `brew --version` | https://brew.sh |
| git | `git --version` | Comes with Xcode CLT: `xcode-select --install` |

---

## Step 1 — Install AeroSpace

```bash
brew install --cask aerospace
```

**Expected:** command succeeds. Verify:

```bash
aerospace --version
```

**Expected output:** two lines starting with `aerospace CLI client version:` and `AeroSpace.app server version:` (version 0.20.0-Beta or newer).

---

## Step 2 — Back up any existing AeroSpace config

```bash
if [ -f "$HOME/.config/aerospace/aerospace.toml" ]; then
  cp "$HOME/.config/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml.bak"
  echo "Backed up existing config to aerospace.toml.bak"
else
  echo "No existing config — nothing to back up"
fi
```

**Expected:** one of the two messages. No errors.

---

## Step 3 — Clone this repository

```bash
cd /tmp
git clone https://github.com/lucaslopescs/aerospace-omarchy-config.git
cd aerospace-omarchy-config
```

**Expected:** `aerospace.toml`, `cheatsheet.html`, `show-cheatsheet.sh`, `README.md`, `SETUP.md` all present.

Verify:

```bash
ls
```

---

## Step 4 — Install the config files

```bash
mkdir -p "$HOME/.config/aerospace"
cp aerospace.toml    "$HOME/.config/aerospace/aerospace.toml"
cp cheatsheet.html   "$HOME/.config/aerospace/cheatsheet.html"
cp show-cheatsheet.sh "$HOME/.config/aerospace/show-cheatsheet.sh"
chmod +x "$HOME/.config/aerospace/show-cheatsheet.sh"
```

**Expected:** all four commands succeed silently.

Verify:

```bash
ls -la "$HOME/.config/aerospace/"
```

Should list `aerospace.toml`, `cheatsheet.html`, and `show-cheatsheet.sh` (the last one marked executable with `-rwxr-xr-x`).

---

## Step 5 — Launch AeroSpace

If AeroSpace is not already running:

```bash
open -a AeroSpace
```

If it's already running, reload the config instead:

```bash
aerospace reload-config
```

**Expected:**
- If launching: an icon appears in the macOS menu bar showing the current workspace number.
- If reloading: exit code 0 with no output. An error message means TOML syntax is invalid — check `~/.config/aerospace/aerospace.toml`.

---

## Step 6 — Grant Accessibility permission

The first time AeroSpace runs, macOS will prompt for Accessibility permission. Without it, AeroSpace cannot move windows.

1. Open `System Settings → Privacy & Security → Accessibility`
2. Toggle **AeroSpace** on
3. You may need to quit and relaunch AeroSpace

**This step must be done by the human.** An AI agent cannot click the toggle.

Verify:

```bash
pgrep -x AeroSpace
```

**Expected:** a PID is printed.

---

## Step 7 — Verify a keybinding works

Open two terminal windows on workspace 1, then:

| Key | What should happen |
|---|---|
| `alt-←` / `alt-→` | Focus moves between the two windows |
| `alt-2` | Workspace indicator in the menu bar changes to `2`, screen empties |
| `alt-1` | Returns to workspace 1 |
| `alt-k` | Cheatsheet opens in a Chrome app window |

If any of these don't work, check:
- Accessibility permission (Step 6)
- Config syntax: `aerospace reload-config`
- You're pressing `alt` (aka `option` ⌥), not `cmd`

---

## Troubleshooting

### "The cheatsheet doesn't open"

The `show-cheatsheet.sh` script launches Chrome with `--app=...`. Verify:

1. Chrome is installed at `/Applications/Google Chrome.app`
2. The script is executable: `ls -l $HOME/.config/aerospace/show-cheatsheet.sh`
3. Try running it directly: `$HOME/.config/aerospace/show-cheatsheet.sh`

### "alt-a / alt-b / alt-c launches the wrong app or nothing"

Those bindings use `open -a "<AppName>"`. Verify each referenced app exists:

```bash
ls /Applications | grep -iE "claude|chatgpt|chrome|visual|ghostty|obsidian|discord|notion"
```

Apps that aren't installed will silently fail. Either install them or remove their binding from `aerospace.toml`.

### "Rogue workspaces 10, 11, ... appear when I plug in external monitors"

This config pins workspaces to monitors via `[workspace-to-monitor-force-assignment]` to prevent exactly this, but if it still happens:

```bash
# Move windows out of the rogue workspace into workspace 3
aerospace list-windows --workspace 10 --format "%{window-id}" | \
  xargs -I{} aerospace move-node-to-workspace --window-id {} 3
```

Empty rogue workspaces auto-dissolve.

### "I want focus-follows-mouse like Hyprland in Omarchy"

AeroSpace does not natively support FFM ([issue #12](https://github.com/nikitabobko/AeroSpace/issues/12)). The community workaround is [AutoRaise](https://github.com/sbmpost/AutoRaise), which is **not configured** by this repo.

---

## Rollback

If you want to revert to the previous (or default) config:

```bash
# If you backed up in Step 2
cp "$HOME/.config/aerospace/aerospace.toml.bak" "$HOME/.config/aerospace/aerospace.toml"
aerospace reload-config

# Or restore the stock AeroSpace default
rm "$HOME/.config/aerospace/aerospace.toml"
open -a AeroSpace  # AeroSpace will recreate the default
```

---

## Uninstall

```bash
brew uninstall --cask aerospace
rm -rf "$HOME/.config/aerospace"
```

---

## Summary checklist for an AI agent

- [ ] Homebrew, git, AeroSpace installed
- [ ] Existing config backed up (if any)
- [ ] Repo cloned
- [ ] `aerospace.toml`, `cheatsheet.html`, `show-cheatsheet.sh` copied to `~/.config/aerospace/`
- [ ] `show-cheatsheet.sh` chmod +x
- [ ] AeroSpace running (PID exists)
- [ ] `aerospace reload-config` exits 0
- [ ] **Human** granted Accessibility permission
- [ ] Verified `alt-1` / `alt-←` / `alt-k` work
