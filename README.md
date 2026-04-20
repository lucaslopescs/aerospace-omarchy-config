# aerospace-omarchy-config

An [AeroSpace](https://github.com/nikitabobko/AeroSpace) configuration for macOS that borrows the feel of [Omarchy](https://github.com/basecamp/omarchy) (DHH's Hyprland-based Arch setup): keyboard-driven workflow, single-keystroke app launchers, numbers-only workspaces, and a styled cheatsheet popup.

If you're coming from Omarchy / Hyprland / i3, this should feel immediately familiar — just swap the `SUPER` key for macOS `alt`.

## What's in the repo

| File | Purpose |
|---|---|
| `aerospace.toml` | The AeroSpace config — bindings, gaps, workspace-to-monitor assignments |
| `cheatsheet.html` | Styled keybinding reference, opens in a Chrome app window |
| `show-cheatsheet.sh` | Launcher script for the cheatsheet (bound to `alt-k`) |
| `SETUP.md` | Step-by-step install instructions for humans or AI agents |

## Key bindings at a glance

Press `alt-k` any time to see this in a styled popup inside macOS.

### Window management
| Keys | Action |
|---|---|
| `alt + ←↓↑→` | Focus window in direction |
| `alt-shift + ←↓↑→` | Move focused window |
| `alt-−` / `alt-=` | Resize smaller / larger |
| `alt-/` | Toggle tiles horizontal ↔ vertical |
| `alt-,` | Toggle accordion horizontal ↔ vertical |
| `alt-f` | Toggle focused window float / tile |
| `alt-shift-f` | Fullscreen toggle |

### Workspaces
| Keys | Action |
|---|---|
| `alt-1` … `alt-9` | Jump to workspace N |
| `alt-shift-1` … `alt-shift-9` | Send window to workspace N |
| `alt-tab` | Previous workspace |
| `alt-shift-tab` | Send workspace to next monitor |

### Service mode (`alt-shift-;` to enter)
| Keys | Action |
|---|---|
| `esc` | Reload config, exit |
| `r` | Reset (flatten) workspace layout |
| `f` | Float/tile toggle |
| `backspace` | Close all windows but current |
| `alt-shift + ←↓↑→` | Join window with neighbor |

### App launchers
| Keys | App |
|---|---|
| `alt-a` / `alt-shift-a` | Claude / ChatGPT |
| `alt-b` | Google Chrome |
| `alt-c` | VS Code |
| `alt-t` | Ghostty |
| `alt-o` | Obsidian |
| `alt-d` | Discord |
| `alt-m` | Messages |
| `alt-n` / `alt-shift-n` | Finder / Notion |

### URL shortcuts (open in a fresh Chrome window)
| Keys | URL |
|---|---|
| `alt-x` | x.com |
| `alt-g` | Gmail |
| `alt-y` | YouTube |
| `alt-shift-g` | GitHub |

### System Settings panels
| Keys | Panel |
|---|---|
| `alt-ctrl-w` | Wi-Fi |
| `alt-ctrl-b` | Bluetooth |
| `alt-ctrl-u` | Sound |
| `alt-ctrl-d` | Displays |

### Help
| Keys | Action |
|---|---|
| `alt-k` | Show the cheatsheet popup |

## How this differs from Omarchy

| Omarchy (Hyprland) | This (AeroSpace) |
|---|---|
| `SUPER` key | `alt` key |
| Walker launcher (`SUPER-SPACE`) | macOS Spotlight / Raycast (unchanged, `cmd-space`) |
| Wallpaper / theme menus | Not included — macOS handles theming |
| Clipboard manager | Not included — install Raycast or Maccy |
| Focus-follows-mouse (native Hyprland) | **Not supported by AeroSpace** — optional add-on: [AutoRaise](https://github.com/sbmpost/AutoRaise) (not configured here) |
| Screenshots via `SUPER-PRINT` | Use macOS native `cmd-shift-4` |

## Requirements

- macOS (tested on Tahoe / Darwin 25.x)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace) 0.20.0-Beta or newer
- [Google Chrome](https://www.google.com/chrome/) (for URL shortcuts + styled cheatsheet)
- Apps referenced in the launchers (Claude, ChatGPT, VS Code, Ghostty, Obsidian, Discord, Notion) — bindings that reference uninstalled apps will silently no-op

## Installation

See [SETUP.md](SETUP.md) for a step-by-step guide that an AI agent can follow.

**Quick version:**

```bash
brew install --cask aerospace
git clone https://github.com/lucaslopescs/aerospace-omarchy-config.git
mkdir -p ~/.config/aerospace
cp aerospace-omarchy-config/{aerospace.toml,cheatsheet.html,show-cheatsheet.sh} ~/.config/aerospace/
chmod +x ~/.config/aerospace/show-cheatsheet.sh
open -a AeroSpace
```

## Customization

- **Add / remove app launchers:** edit the `# App launchers` section of `aerospace.toml`
- **Add URL shortcuts:** copy the `alt-x` block in `aerospace.toml` and swap the URL
- **Rework the cheatsheet:** `cheatsheet.html` is plain HTML/CSS — edit freely
- **Change workspace-to-monitor layout:** `[workspace-to-monitor-force-assignment]` block in `aerospace.toml`

## Credits

- [nikitabobko/AeroSpace](https://github.com/nikitabobko/AeroSpace) — the tiling window manager this config targets
- [basecamp/omarchy](https://github.com/basecamp/omarchy) — inspiration for the keybinding philosophy

## License

MIT — do whatever you want. See aerospace.toml for inline comments where the logic lives.
