# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/) and git.

> **Repo:** https://github.com/raihandotmd/dotfiles

---

## Stack

| Category        | Tool                                 |
|-----------------|--------------------------------------|
| Window Manager  | [Hyprland](https://hyprland.org/)    |
| Terminal        | [Ghostty](https://ghostty.org/)      |
| Shell           | Zsh + [zinit](https://github.com/zdharma-continuum/zinit) |
| Multiplexer     | [tmux](https://github.com/tmux/tmux) |
| Editor          | [Neovim](https://neovim.io/)         |
| Status Bar      | [Waybar](https://github.com/Alexays/Waybar) |
| App Launcher    | [tofi](https://github.com/philj56/tofi) |
| Notifications   | [Dunst](https://dunst-project.org/)  |
| Dotfile Manager | [chezmoi](https://www.chezmoi.io/)   |

---

## Structure

```
~/.local/share/chezmoi/
├── dot_zshrc                    # ~/.zshrc
└── dot_config/
    ├── hypr/
    │   └── hyprland.conf        # Hyprland WM config
    ├── ghostty/
    │   └── config               # Ghostty terminal config
    ├── tmux/
    │   └── tmux.conf            # tmux config
    ├── nvim/
    │   ├── init.lua             # Neovim entry point
    │   └── lua/
    │       ├── config/
    │       │   ├── init.lua
    │       │   ├── keymaps.lua  # Keybindings
    │       │   ├── lazy.lua     # Plugin manager setup
    │       │   └── opts.lua     # Vim options
    │       └── plugins/         # Individual plugin configs
    ├── waybar/
    │   ├── config               # Waybar modules
    │   └── style.css            # Waybar styling
    ├── tofi/
    │   └── config               # tofi launcher config
    └── dunst/
        └── dunstrc              # Dunst notification config
```

---

## Installation

### Prerequisites

Install the required tools before applying dotfiles:

- `chezmoi`, `git`, `zsh`
- `hyprland`, `waybar`, `dunst`, `tofi`
- `ghostty`, `tmux`, `neovim`
- `zoxide`, `fzf`
- `tpm` (tmux plugin manager)

### Apply dotfiles

```bash
# Clone and apply in one command
chezmoi init --apply https://github.com/raihandotmd/dotfiles.git

# Or if already cloned
chezmoi apply
```

### Post-install

**tmux** — install plugins after first launch:
```
prefix + I
```

**Neovim** — plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and will auto-install on first launch.

**Zsh** — zinit and all plugins will auto-install on first shell session.

---

## Highlights

### Zsh

- Prompt: [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- Plugins: `zsh-syntax-highlighting`, `zsh-autosuggestions`, `zsh-completions`, `fzf-tab`
- Smart history (5000 entries, deduplication)
- `cd` replaced by [zoxide](https://github.com/ajeetdsouza/zoxide)
- Fuzzy find with [fzf](https://github.com/junegunn/fzf)

### Neovim

- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)
- Colorscheme: `habamax`
- Key plugins:

| Plugin | Purpose |
|--------|---------|
| telescope | Fuzzy finder |
| harpoon | File navigation |
| treesitter | Syntax highlighting |
| lsp | Language server protocol |
| fugitive | Git integration |
| tmux-navigator | Seamless tmux/nvim navigation |
| copilot | AI code completion |
| claudecode | Claude AI integration |
| flutter-tools | Flutter/Dart development |
| lualine | Status line |
| which-key | Keybinding hints |
| trouble | Diagnostics list |

**Leader key:** `<Space>`

### Hyprland

- Dual monitor: `DP-1` (1366x768) + `HDMI-A-1` (1920x1080)
- Keyboard layout: **Dvorak**, Caps Lock remapped to Ctrl
- Layout engine: Dwindle
- Gaps: 2px inner, 5px outer
- Active border: `#85d623`

Key bindings:

| Bind | Action |
|------|--------|
| `SUPER + Return` | Open terminal (Ghostty) |
| `SUPER + h/j/k/l` | Move window focus |
| `SUPER + 1-0` | Switch workspace |
| `SUPER + SHIFT + 1-0` | Move window to workspace |
| `SUPER + V` | Toggle floating |
| `F4` | Open app launcher (tofi) |
| `SUPER + C` | Close window |

### tmux

- TPM plugin manager
- Plugins: `tmux-sensible`, `tmux-yank`, `vim-tmux-navigator`
- Status bar at top, custom minimal theme
- Vi copy mode
- `prefix + r` — reload config
- `prefix + C-f` / `C-j` — session manager via `tms`

### Ghostty

- Shell: `zsh` with shell integration
- Theme: Adwaita Dark, background `#1e1e1e`
- Font size: 20
- `ctrl+g > r` — reload config
- `ctrl+g > t` — toggle window decorations

### Waybar

- Position: bottom
- Left: workspaces, CPU, memory
- Center: clock (Asia/Jakarta, updates every second)
- Right: tray, audio (PulseAudio)

---

## Managing Dotfiles

```bash
# Check what files are being tracked
chezmoi managed

# Edit a tracked file
chezmoi edit ~/.zshrc

# See diff before applying
chezmoi diff

# Apply changes
chezmoi apply

# Add a new file to chezmoi
chezmoi add ~/.config/someapp/config

# Pull latest from git and apply
chezmoi update
```

---

## Theme / Color Palette

| Role | Color |
|------|-------|
| Accent / Active | `#85d623` |
| Background | `#1e1e1e` / `#2e2e2e` |
| Inactive | `#727272` |
| Critical | `#fab387` |
