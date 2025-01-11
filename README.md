# Dotfiles

My personal dotfiles, managed with GNU Stow, for setting up a lightweight and efficient workspace.

---

## Features

- **Window Manager**: i3
- **Status Bar Manager**: i3blocks
- **App Launcher**: rofi
- **Terminal**: ghostty  
  - **Dependencies**: `xdotool` (for running `ghostty-git_repo.sh` script).
- **Wallpaper**: feh
- **Shell**: zsh

---

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/raihandotmd/dotfiles.git ~/dotfiles
   ```

2. Install GNU Stow:
   For Debian/Ubuntu:
   ```bash
   sudo apt install stow
   ```
   Or use your package manager for other distros

4. Use `stow` to symlink configurations:
   ```bash
   cd ~/dotfiles
   stow .
   ```

   This will create symlinks in your home directory for the respective configurations.

5. Reload configurations:
   - For i3: Press `Alt+Shift+R` (or restart i3).
   - For Zsh: Run `source ~/.zshrc`.

---

## Cheat Sheet

### Zsh Aliases

| Alias | Command                          | Description                     |
|-------|----------------------------------|---------------------------------|
| `ls`  | `ls --color`                    | List files with color.          |
| `vim` | `nvim`                          | Use Neovim as the default editor. |
| `hub` | `cd ~/hub`                      | Quickly navigate to the `hub` directory. |
| `gp`  | `~/.config/ghostty/ghostty-git_repo.sh` | Run the Git repository finder. |

---

### i3 Keybinds (Mod key: `Alt`)

#### Window Controls
| Keybind       | Action                          |
|---------------|---------------------------------|
| `Alt+Return`  | Open terminal.                 |
| `Alt+Shift+Q` | Kill focused window.           |
| `Alt+T`       | Toggle title bars.            |

#### Focus Control
| Keybind       | Action                          |
|---------------|---------------------------------|
| `Alt+H/J/K/L` | Focus left/down/up/right.      |

#### Window Movement
| Keybind           | Action                          |
|-------------------|---------------------------------|
| `Alt+Shift+H/J/K/L` | Move window left/down/up/right. |

#### Layout Controls
| Keybind          | Action                          |
|------------------|---------------------------------|
| `Alt+U`          | Split horizontally.            |
| `Alt+B`          | Split vertically.              |
| `Alt+F`          | Toggle fullscreen.             |
| `Alt+Comma`      | Tabbed layout.                 |
| `Alt+Period`     | Toggle split layout.           |

#### Workspace Management
| Keybind       | Action                          |
|---------------|---------------------------------|
| `Alt+ 1-0`       | Switch to workspace 1-10.     |
| `Alt+Shift+ 1-0` | Move container to workspace 1-10. |

#### System Controls
| Keybind           | Action                          |
|-------------------|---------------------------------|
| `Alt+Shift+R`     | Reload i3 config.              |
| `Alt+Shift+P`     | Restart i3.                    |
| `Alt+Shift+E`     | Exit i3 session.               |

---

### Ghostty Keybinds

#### Split Navigation and Management
| Keybind         | Action                          |
|-----------------|---------------------------------|
| `Ctrl+A > B`    | Create new split (down).        |
| `Ctrl+A > V`    | Create new split (vertically to right).       |
| `Ctrl+A > R`    | Reload config.                 |
| `Ctrl+A > X`    | Close current surface.         |

#### Navigation
| Keybind         | Action                          |
|-----------------|---------------------------------|
| `Ctrl+A > J/K/H/L` | Navigate between splits (down/up/left/right). |

#### Resize Splits
| Keybind          | Action                          |
|------------------|---------------------------------|
| `Ctrl+A > ↑/↓/←/→` | Resize split (up/down/left/right). |

#### Tabs
| Keybind           | Action                          |
|-------------------|---------------------------------|
| `Ctrl+A > C`      | Create new tab.                |
| `Ctrl+A > Shift+[ ]` | Switch to next/previous tab. |

#### Quick Tab Switching
| Keybind         | Action                          |
|-----------------|---------------------------------|
| `Ctrl+A > 1-9`  | Switch to tab 1-9.             |
