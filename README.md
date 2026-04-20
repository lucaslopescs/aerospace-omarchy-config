# aerospace-omarchy-config

An [AeroSpace](https://github.com/nikitabobko/AeroSpace) configuration for macOS that borrows the feel of [Omarchy](https://github.com/basecamp/omarchy) (DHH's Hyprland-based Arch setup): keyboard-driven workflow, single-keystroke app launchers via a **Caps Lock → Hyper key**, numbers-only workspaces, and a styled cheatsheet popup.

If you're coming from Omarchy / Hyprland / i3, this should feel immediately familiar — just swap their `SUPER` key for **Caps Lock**.

## The Hyper key

This config uses **Caps Lock as a Hyper key** via [Hyperkey.app](https://hyperkey.app/). Caps Lock gets remapped to `Cmd+Ctrl+Opt` (three modifiers — not four, so `Shift` stays free to distinguish bindings like `Caps+A` vs `Caps+Shift+A`).

Throughout this README, **⇪** means "hold Caps Lock."

## What's in the repo

| File | Purpose |
|---|---|
| `aerospace.toml` | AeroSpace config — bindings, gaps, workspace-to-monitor assignments |
| `cheatsheet.html` | Styled keybinding reference, opens in a Chrome app window |
| `show-cheatsheet.sh` | Launcher script for the cheatsheet (bound to ⇪K) |
| `ghostty/config` | Ghostty companion config — remaps `cmd+t` to split (avoids fighting the tiling WM) |
| `SETUP.md` | Step-by-step install instructions for humans or AI agents |

## Key bindings at a glance

Press **⇪K** any time to see this in a styled popup.

### Window management
| Keys | Action |
|---|---|
| ⇪ `←↓↑→` | Focus window in direction |
| ⇪ `⇧` `←↓↑→` | Move focused window |
| ⇪ `−` / ⇪ `=` | Resize smaller / larger |
| ⇪ `/` | Toggle tiles horizontal ↔ vertical |
| ⇪ `,` | Toggle accordion horizontal ↔ vertical |
| ⇪ `F` | Toggle focused window float / tile |
| ⇪ `⇧` `F` | Fullscreen toggle |

### Workspaces
| Keys | Action |
|---|---|
| ⇪ `1` … ⇪ `9` | Jump to workspace N |
| ⇪ `⇧` `1` … ⇪ `⇧` `9` | Send window to workspace N |
| ⇪ `⇥` | Previous workspace |
| ⇪ `⇧` `⇥` | Send workspace to next monitor |

### Service mode (⇪⇧`;` to enter)
| Keys | Action |
|---|---|
| `esc` | Reload config, exit |
| `r` | Reset (flatten) workspace layout |
| `f` | Float/tile toggle |
| `⌫` | Close all windows but current |
| ⇪ `⇧` `←↓↑→` | Join window with neighbor |

### App launchers
| Keys | App |
|---|---|
| ⇪ `A` / ⇪ `⇧` `A` | Claude / ChatGPT |
| ⇪ `B` | Google Chrome |
| ⇪ `C` | VS Code |
| ⇪ `T` | Ghostty |
| ⇪ `O` | Obsidian |
| ⇪ `D` | Discord |
| ⇪ `M` | Messages |
| ⇪ `N` / ⇪ `⇧` `N` | Finder / Notion |

### URL shortcuts (open in a fresh Chrome window)
| Keys | URL |
|---|---|
| ⇪ `X` | x.com |
| ⇪ `G` | Gmail |
| ⇪ `Y` | YouTube |
| ⇪ `⇧` `G` | GitHub |

### System Settings panels
| Keys | Panel |
|---|---|
| ⇪ `⇧` `W` | Wi-Fi |
| ⇪ `⇧` `B` | Bluetooth |
| ⇪ `⇧` `U` | Sound |
| ⇪ `⇧` `D` | Displays |

### Help
| Keys | Action |
|---|---|
| ⇪ `K` | Show the cheatsheet popup |

## How this differs from Omarchy

| Omarchy (Hyprland) | This (AeroSpace) |
|---|---|
| `SUPER` key | ⇪ Caps Lock (Hyper via Hyperkey.app) |
| Walker launcher (`SUPER-SPACE`) | macOS Spotlight / Raycast (unchanged, `cmd-space`) |
| Wallpaper / theme menus | Not included — macOS handles theming |
| Clipboard manager | Not included — install Raycast or Maccy |
| Focus-follows-mouse (native Hyprland) | **Not supported by AeroSpace** — optional add-on: [AutoRaise](https://github.com/sbmpost/AutoRaise) (not configured here) |
| Screenshots via `SUPER-PRINT` | Use macOS native `cmd-shift-4` |

## Requirements

- macOS 13+ (tested on Tahoe / Darwin 25.x)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace) 0.20.0-Beta or newer
- [Hyperkey.app](https://hyperkey.app/) (for the Caps Lock → Hyper remap)
- [Google Chrome](https://www.google.com/chrome/) (for URL shortcuts + styled cheatsheet)
- Apps referenced in the launchers (Claude, ChatGPT, VS Code, Ghostty, Obsidian, Discord, Notion). Bindings that reference uninstalled apps will silently no-op.

## Installation

See [SETUP.md](SETUP.md) for a step-by-step guide that an AI agent can follow.

**Quick version:**

```bash
brew install --cask aerospace hyperkey
git clone https://github.com/lucaslopescs/aerospace-omarchy-config.git
mkdir -p ~/.config/aerospace
cp aerospace-omarchy-config/{aerospace.toml,cheatsheet.html,show-cheatsheet.sh} ~/.config/aerospace/
chmod +x ~/.config/aerospace/show-cheatsheet.sh
open -a AeroSpace
open -a Hyperkey
```

Then in Hyperkey: select Caps Lock as trigger, enable ⌘ Command + ⌃ Control + ⌥ Option, **disable** ⇧ Shift, and grant Accessibility permission.

## Customization

- **Add / remove app launchers:** edit the `# App launchers` section of `aerospace.toml`
- **Add URL shortcuts:** copy one of the `cmd-alt-ctrl-x` blocks in `aerospace.toml` and swap the URL
- **Rework the cheatsheet:** `cheatsheet.html` is plain HTML/CSS — edit freely
- **Change workspace-to-monitor layout:** `[workspace-to-monitor-force-assignment]` block in `aerospace.toml`
- **Prefer a 4-modifier Hyper (cmd+ctrl+opt+shift)?** Enable Shift in Hyperkey and remove the `shift` variants from `aerospace.toml` (they'll collide with their non-shift counterparts)

## Credits

- [nikitabobko/AeroSpace](https://github.com/nikitabobko/AeroSpace) — the tiling window manager this config targets
- [raycast/Hyperkey](https://hyperkey.app/) — Caps Lock → Hyper remap
- [basecamp/omarchy](https://github.com/basecamp/omarchy) — inspiration for the keybinding philosophy

## License

MIT — do whatever you want.
