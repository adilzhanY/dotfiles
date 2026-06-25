# Neovim Configuration

A fast, modern Neovim setup focused on web development with TypeScript/React, featuring auto-session management, LSP support, and theme switching.

## ✨ Features

- **LSP Support**: TypeScript, CSS, HTML, Tailwind CSS with auto-completion
- **Smart Editing**: Auto-pairs, auto-tags, comment toggling, snippets
- **File Management**: Fuzzy finding (fzf-lua), file tree (nvim-tree)
- **Git Integration**: Gitsigns for inline git indicators
- **Session Management**: Auto-save and restore sessions
- **Theme Switching**: Toggle between multiple themes with `<leader>p`
- **Markdown Support**: Live rendering with concealment
- **Linting & Formatting**: Async linting and formatting on save
- **Terminal Integration**: Floating terminals and quick launchers

## 📋 Prerequisites

Before installing, ensure you have:

- **Neovim** >= 0.9.0
- **Git**
- **Node.js** & **npm** (for LSP servers)
- **A Nerd Font** (for icons) - [Download here](https://www.nerdfonts.com/)
- **ripgrep** (for fzf-lua grep)
- **fd** (optional, for faster file finding)

### Install Prerequisites (Arch Linux):
```bash
sudo pacman -S neovim git nodejs npm ripgrep fd
```

### Install Prerequisites (Ubuntu/Debian):
```bash
sudo apt install neovim git nodejs npm ripgrep fd-find
```

### Install Prerequisites (macOS):
```bash
brew install neovim git node ripgrep fd
```

## 🚀 Installation

1. **Backup your existing config** (if any):
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. **Clone this repository**:
```bash
git clone https://github.com/adilzhanY/nvim-config.git ~/.config/nvim
```

3. **Install external tools** (linters, formatters):
```bash
# Python tools
pip install black ruff

# Node.js tools
npm install -g prettier stylua

# System tools (Arch Linux)
sudo pacman -S luajit cppcheck bash shellcheck htmlhint stylelint
```

4. **Launch Neovim**:
```bash
nvim
```

On first launch:
- Lazy.nvim will auto-install
- Plugins will install automatically
- LSP servers will install via Mason
- You may see some errors - just press Enter and restart Neovim

5. **Restart Neovim** after initial installation to load everything properly.

## 📦 Included Plugins

### Core UI & Experience
- **nvim-tree/nvim-web-devicons** - File icons
- **nvim-lualine/lualine.nvim** - Statusline
- **romgrk/barbar.nvim** - Buffer tabs
- **goolord/alpha-nvim** - Startup screen
- **lukas-reineke/indent-blankline.nvim** - Indent guides
- **folke/which-key.nvim** - Keybinding popup
- **folke/twilight.nvim** - Dim inactive code
- **nvim-tree/nvim-tree.lua** - File explorer
- **ibhagwan/fzf-lua** - Fuzzy finder
- **numToStr/FTerm.nvim** - Floating terminal

### Themes
- **catppuccin/nvim** - Catppuccin theme
- **ellisonleao/gruvbox.nvim** - Gruvbox theme
- **uZer/pywal16.nvim** - Pywal integration
- **rebelot/kanagawa.nvim** - Kanagawa theme
- **miikanissi/modus-themes.nvim** - Modus themes
- **norcalli/nvim-colorizer.lua** - Color preview

### Editing Features
- **numToStr/Comment.nvim** - Smart commenting
- **windwp/nvim-autopairs** - Auto close brackets
- **windwp/nvim-ts-autotag** - Auto close HTML tags
- **nvim-treesitter/nvim-treesitter** - Syntax highlighting
- **mfussenegger/nvim-lint** - Linting
- **stevearc/conform.nvim** - Formatting
- **rmagatti/auto-session** - Session management
- **lewis6991/gitsigns.nvim** - Git indicators
- **MeanderingProgrammer/render-markdown.nvim** - Markdown rendering
- **emmanueltouzery/decisive.nvim** - CSV alignment

### LSP & Completion
- **neovim/nvim-lspconfig** - LSP configurations
- **williamboman/mason.nvim** - LSP installer
- **williamboman/mason-lspconfig.nvim** - Mason + lspconfig bridge
- **hrsh7th/nvim-cmp** - Completion engine
- **hrsh7th/cmp-nvim-lsp** - LSP completion source
- **hrsh7th/cmp-buffer** - Buffer completion
- **hrsh7th/cmp-path** - Path completion
- **L3MON4D3/LuaSnip** - Snippet engine
- **rafamadriz/friendly-snippets** - Snippet collection

## ⌨️ Key Mappings

**Leader key**: `Space`

### Essential
| Key | Action |
|-----|--------|
| `<Space>w` | Save file |
| `<Space>q` | Close buffer |
| `<Space>Q` | Force close buffer |
| `<Space>U` | Close all buffers |
| `jj` / `jk` | Exit insert mode |

### Navigation
| Key | Action |
|-----|--------|
| `Shift+h` | Previous buffer |
| `Shift+l` | Next buffer |
| `Alt+1-9` | Jump to buffer 1-9 |
| `Ctrl+h/j/k/l` | Navigate windows |
| `Alt+j/k` | Move line down/up |

### File Management
| Key | Action |
|-----|--------|
| `<Space>f` | Find files in cwd |
| `<Space>g` | Grep in files |
| `<Space>G` | Grep word under cursor |
| `<Space>b` | Find open buffers |
| `<Space>t` | Toggle file tree |
| `<Space>Fr` | Resume last search |

### Terminal
| Key | Action |
|-----|--------|
| `<Space>z` | Open floating terminal |
| `<Space>H` | Open htop |
| `<Space>tg` | Open git terminal |
| `<Space>tf` | Open fish terminal |
| `Esc` | Close terminal |

### Editing
| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment |
| `gc` | Toggle comment (visual) |
| `<Space>fm` | Format file |
| `<Space>s` | Search & replace |
| `<Space>W` | Toggle line wrap |

### Themes & UI
| Key | Action |
|-----|--------|
| `<Space>p` | Cycle themes |
| `<Space>l` | Toggle Twilight (dim) |
| `<Space>nn` | Toggle relative line numbers |

### LSP
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `gi` | Go to implementation |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code actions |

## 🎨 Theme Switching

Themes are saved persistently. Toggle with `<Space>p`:
1. Catppuccin Frappe
2. Gruvbox
3. Pywal16
4. Kanagawa Wave
5. Kanagawa Dragon
6. Kanagawa Lotus
7. Modus Vivendi (high contrast dark)
8. Modus Operandi (light)

Theme preference is saved in `lua/config/saved_theme`.

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── autocmd.lua        # Auto-commands
│   │   ├── comment.lua        # Comment config
│   │   ├── mappings.lua       # Keybindings
│   │   ├── options.lua        # Vim options
│   │   ├── snippets.lua       # Custom snippets
│   │   ├── theme.lua          # Theme switcher
│   │   └── saved_theme        # Current theme (generated)
│   └── plugins/
│       ├── alpha.lua          # Startup screen
│       ├── auto-session.lua   # Session management
│       ├── autopairs.lua      # Auto-pairs config
│       ├── autotag.lua        # Auto-tag config
│       ├── barbar.lua         # Buffer tabs
│       ├── colorizer.lua      # Color preview
│       ├── colorscheme.lua    # Theme settings
│       ├── comment.lua        # Comment plugin
│       ├── conform.lua        # Formatter config
│       ├── fterm.lua          # Floating terminal
│       ├── fzf-lua.lua        # Fuzzy finder
│       ├── gitsigns.lua       # Git indicators
│       ├── indent-blankline.lua # Indent guides
│       ├── kanagawa.lua       # Kanagawa theme
│       ├── lsp.lua            # LSP configuration
│       ├── lualine.lua        # Statusline
│       ├── modus-themes.lua   # Modus themes
│       ├── nvim-lint.lua      # Linter config
│       ├── nvim-tree.lua      # File tree
│       ├── render-markdown.lua # Markdown rendering
│       ├── treesitter.lua     # Syntax highlighting
│       ├── twilight.lua       # Code dimming
│       └── which-key.lua      # Keybinding helper
└── .gitignore
```

## 🔧 Customization

### Adding LSP Servers

Edit `lua/plugins/lsp.lua`:
```lua
require('mason-lspconfig').setup({
  ensure_installed = { "ts_ls", "cssls", "html", "tailwindcss", "your_server" },
  -- ...
})
```

### Adding Linters

Edit `lua/plugins/nvim-lint.lua`:
```lua
require('lint').linters_by_ft = {
  python = {'ruff'},
  your_filetype = {'your_linter'},
}
```

### Adding Formatters

Edit `lua/plugins/conform.lua`:
```lua
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    your_filetype = { "your_formatter" },
  },
})
```

### Adding Keybindings

Edit `lua/config/mappings.lua`:
```lua
map("n", "<leader>key", ":YourCommand<CR>")
```

## 🐛 Troubleshooting

### Icons not showing
Install a Nerd Font and configure your terminal to use it.

### LSP not working
Run `:Mason` and ensure servers are installed. Run `:LspInfo` to check status.

### Plugins not loading
Check if Lazy.nvim is installed. Restart Neovim and plugins should auto-install.

### Slow startup
Check which plugins are taking time with `:Lazy profile`.

### Session issues with terminals
Terminal buffers are automatically cleaned before session save in `lua/plugins/auto-session.lua`.

## 📝 Notes

- **Auto-save**: Files auto-save after 1 second of inactivity
- **Sessions**: Automatically saved/restored per directory
- **Relative line numbers**: Auto-toggle on focus
- **Clipboard**: System clipboard integration enabled
- **Shell**: Configured for Fish shell (change in `lua/config/options.lua`)

---

**Enjoy your Neovim setup! 🚀**
