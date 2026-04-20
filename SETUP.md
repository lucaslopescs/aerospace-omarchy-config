# Setup Guide (for AI agents and humans)

This guide takes a fresh macOS machine from nothing to a fully-working AeroSpace config with a Caps Lock Hyper key. Each step is small, idempotent, and verifiable.

If you are an AI agent: run the commands, check the "Expected output" after each, and stop if anything mismatches. Don't guess — ask the human if a step fails.

---

## Prerequisites

| Need | How to verify | How to install |
|---|---|---|
| macOS 13+ (Sonoma or newer) | `sw_vers -productVersion` | n/a |
| Homebrew | `brew --version` | https://brew.sh |
| git | `git --version` | `xcode-select --install` |

---

## Step 1 — Install AeroSpace and Hyperkey

```bash
brew install --cask aerospace hyperkey
```

**Expected:** both casks install. Verify:

```bash
aerospace --version
```

**Expected output:** two lines starting with `aerospace CLI client version:` and `AeroSpace.app server version:` (0.20.0-Beta or newer).

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

---

## Step 3 — Clone this repository

```bash
cd /tmp
git clone https://github.com/lucaslopescs/aerospace-omarchy-config.git
cd aerospace-omarchy-config
```

Verify:

```bash
ls
```

**Expected:** `aerospace.toml`, `cheatsheet.html`, `show-cheatsheet.sh`, `README.md`, `SETUP.md`.

---

## Step 4 — Install the config files

```bash
mkdir -p "$HOME/.config/aerospace" "$HOME/.config/ghostty"
cp aerospace.toml    "$HOME/.config/aerospace/aerospace.toml"
cp cheatsheet.html   "$HOME/.config/aerospace/cheatsheet.html"
cp show-cheatsheet.sh "$HOME/.config/aerospace/show-cheatsheet.sh"
cp ghostty/config    "$HOME/.config/ghostty/config"
chmod +x "$HOME/.config/aerospace/show-cheatsheet.sh"
```

Verify:

```bash
ls -la "$HOME/.config/aerospace/" "$HOME/.config/ghostty/"
```

`show-cheatsheet.sh` should be marked executable (`-rwxr-xr-x`).

The Ghostty config remaps `cmd+t` from "new native macOS window (which merges into a tab bar)" to "new in-window split" — otherwise AeroSpace tiles the invisible tab-grouped window and leaves half your screen empty. If you don't use Ghostty, you can skip copying the ghostty config.

---

## Step 5 — Launch AeroSpace and grant Accessibility permission

```bash
open -a AeroSpace
```

When macOS prompts, go to `System Settings → Privacy & Security → Accessibility` and toggle **AeroSpace** on.

Verify:

```bash
pgrep -x AeroSpace
```

**Expected:** a PID is printed.

---

## Step 6 — Configure Hyperkey (Caps Lock → Hyper)

```bash
open -a Hyperkey
```

**In the Hyperkey UI:**

1. Under **Trigger**, select **Caps Lock**.
2. Under **Modifiers**, enable:
   - ☑ **⌘ Command**
   - ☑ **⌃ Control**
   - ☑ **⌥ Option**
   - ☐ **⇧ Shift** *(must be off — Shift stays free to distinguish bindings like `Caps+A` vs `Caps+Shift+A`)*
3. Grant **Accessibility** permission when macOS prompts.
4. (Optional) Toggle **Launch at login** on.

**This step must be done by a human.** An AI agent cannot click the toggles.

Verify Hyperkey is active:

```bash
pgrep -x Hyperkey
```

**Expected:** a PID is printed. Also look for the Hyperkey menu-bar icon.

---

## Step 7 — Verify keybindings work

Open two terminal windows on workspace 1, then try:

| Keys | Expected |
|---|---|
| `Caps + ←` / `Caps + →` | Focus moves between the two windows |
| `Caps + 2` | Workspace indicator changes to `2`, screen empties |
| `Caps + 1` | Returns to workspace 1 |
| `Caps + K` | Styled cheatsheet opens in a Chrome app window |
| `Caps + A` | Claude launches or focuses |
| `Caps + Shift + A` | ChatGPT launches or focuses |

If any fail, see Troubleshooting.

---

## Troubleshooting

### "The cheatsheet doesn't open"

1. Chrome must be at `/Applications/Google Chrome.app`
2. Script must be executable: `ls -l $HOME/.config/aerospace/show-cheatsheet.sh`
3. Try running it directly: `$HOME/.config/aerospace/show-cheatsheet.sh`

### "Caps + letter does nothing"

1. Is Hyperkey running? `pgrep -x Hyperkey` should return a PID.
2. Is Hyperkey's Accessibility permission granted?
3. Are the right modifiers enabled in Hyperkey (Cmd + Ctrl + Opt, **not** Shift)?
4. Has AeroSpace reloaded? `aerospace reload-config`

### "Caps + letter triggers the old Caps Lock (capitalize text)"

Hyperkey's "Trigger" may be set incorrectly. Open Hyperkey, confirm Caps Lock is selected as the trigger key.

### "Caps + A launches some weird app, not Claude"

The binding uses `open -a "Claude"`. Verify it exists:

```bash
ls /Applications | grep -i claude
```

If missing, install Claude or edit the `cmd-alt-ctrl-a` binding in `~/.config/aerospace/aerospace.toml`.

### "Rogue workspaces 10, 11, … appear when I plug in external monitors"

This config pins workspaces to monitors to prevent that. If it still happens:

```bash
aerospace list-windows --workspace 10 --format "%{window-id}" | \
  xargs -I{} aerospace move-node-to-workspace --window-id {} 3
```

Empty workspaces auto-dissolve.

### "I want focus-follows-mouse like Hyprland in Omarchy"

Not supported by AeroSpace ([issue #12](https://github.com/nikitabobko/AeroSpace/issues/12)). Workaround: [AutoRaise](https://github.com/sbmpost/AutoRaise) (not configured here).

---

## Rollback

```bash
# Restore a prior config
cp "$HOME/.config/aerospace/aerospace.toml.bak" "$HOME/.config/aerospace/aerospace.toml"
aerospace reload-config

# Or go back to the stock AeroSpace default
rm "$HOME/.config/aerospace/aerospace.toml"
aerospace reload-config

# Remove Hyperkey (reverts Caps Lock to normal)
brew uninstall --cask hyperkey
```

---

## Uninstall everything

```bash
brew uninstall --cask aerospace hyperkey
rm -rf "$HOME/.config/aerospace"
```

---

## Summary checklist for an AI agent

- [ ] Homebrew, git installed
- [ ] `brew install --cask aerospace hyperkey`
- [ ] Existing config backed up (if any)
- [ ] Repo cloned
- [ ] Config files copied to `~/.config/aerospace/`
- [ ] `show-cheatsheet.sh` chmod +x
- [ ] AeroSpace running (PID exists)
- [ ] **Human** granted AeroSpace Accessibility permission
- [ ] Hyperkey configured: Caps trigger, Cmd+Ctrl+Opt on, **Shift off**
- [ ] **Human** granted Hyperkey Accessibility permission
- [ ] Verified `Caps + 1`, `Caps + ←`, `Caps + K` all work
