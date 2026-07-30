-- Adilzhan's Neovim Config
-- Keymaps are in lua/config/mappings.lua
-- Install a patched font & ensure your terminal supports glyphs

------------------------------------------------------------
-- Auto-install vim-plug if missing
------------------------------------------------------------
local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
  vim.cmd('silent !curl -fLo ' .. data_dir .. '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  vim.o.runtimepath = vim.o.runtimepath
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

------------------------------------------------------------
-- Plugin Initialization
------------------------------------------------------------
local vim = vim
local Plug = vim.fn['plug#']

vim.g.start_time = vim.fn.reltime()
vim.loader.enable()

-- Silence a deprecation warning printed at startup: nvim-treesitter's legacy
-- `master` branch still calls vim.tbl_flatten (deprecated in 0.12). Replace it
-- with the modern equivalent so no warning is shown. Remove if you ever move to
-- the nvim-treesitter `main` branch.
vim.tbl_flatten = function(t)
  return vim.iter(t):flatten(math.huge):totable()
end

vim.call('plug#begin')

------------------------------------------------------------
-- Core UI & Experience
------------------------------------------------------------
Plug('nvim-tree/nvim-web-devicons') -- Pretty icons
Plug('karb94/neoscroll.nvim') -- Smooth animated scrolling
Plug('nvim-lualine/lualine.nvim') -- Statusline
Plug('romgrk/barbar.nvim') -- Bufferline
Plug('goolord/alpha-nvim') -- Startup screen
Plug('lukas-reineke/indent-blankline.nvim') -- Indent guides
Plug('folke/which-key.nvim') -- Keymap helper
Plug('folke/twilight.nvim') -- Dim inactive text
Plug('nvim-tree/nvim-tree.lua') -- File explorer
Plug('ibhagwan/fzf-lua') -- Fuzzy finder
Plug('numToStr/FTerm.nvim') -- Floating terminal

------------------------------------------------------------
-- Themes & Colors
------------------------------------------------------------
Plug('catppuccin/nvim', { ['as'] = 'catppuccin' })
Plug('ellisonleao/gruvbox.nvim', { ['as'] = 'gruvbox' })
Plug('uZer/pywal16.nvim', { ['as'] = 'pywal16' })
Plug('rebelot/kanagawa.nvim')
Plug('miikanissi/modus-themes.nvim')
Plug('craftzdog/solarized-osaka.nvim')
Plug('norcalli/nvim-colorizer.lua') -- Color preview

------------------------------------------------------------
-- Editing Features
------------------------------------------------------------
Plug('numToStr/Comment.nvim') -- Comments
Plug('windwp/nvim-autopairs') -- Auto pairs
Plug('windwp/nvim-ts-autotag') -- Auto-close HTML tags
Plug('nvim-treesitter/nvim-treesitter', { ['branch'] = 'master' }) -- Syntax highlighting
Plug('mfussenegger/nvim-lint') -- Async linter
Plug('stevearc/conform.nvim') -- Formatter
Plug('rmagatti/auto-session') -- Session management
Plug('lewis6991/gitsigns.nvim') -- Git indicators
Plug('emmanueltouzery/decisive.nvim') -- CSV viewer
Plug('ron-rs/ron.vim') -- RON syntax highlighting
Plug('SyedM-dev/PicVim') -- Image viewer (kitty graphics: zoom/pan/rotate)

------------------------------------------------------------
-- LSP & Completion
------------------------------------------------------------
Plug('neovim/nvim-lspconfig')
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('L3MON4D3/LuaSnip')
Plug('saadparwaiz1/cmp_luasnip')
Plug('rafamadriz/friendly-snippets')

vim.call('plug#end')

------------------------------------------------------------
-- Core Configs
------------------------------------------------------------
require("config.theme")
require("config.mappings")
require("config.options")
require("config.autocmd")
require("config.transparent") -- transparent bg for every theme (matches kitty/Hyprland)

------------------------------------------------------------
-- Plugin Configs
------------------------------------------------------------
require("config.snippets")
require("plugins.treesitter")
require("plugins.autopairs")
require("plugins.autotag")

require("plugins.alpha")
require("plugins.barbar")
require("plugins.colorizer")
require("plugins.colorscheme")
require("plugins.kanagawa")
require("plugins.modus-themes")
require("plugins.neoscroll")
require("plugins.nvim-tree")
require("plugins.comment")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.nvim-lint")
require("plugins.indent-blankline")
require("plugins.lsp")
require("plugins.auto-session")
require("plugins.conform")
require("plugins.picvim")
require("config.pdfview")

------------------------------------------------------------
-- Deferred Loading (non-essential plugins)
------------------------------------------------------------
vim.defer_fn(function()
  require("plugins.fterm")
  require("plugins.fzf-lua")
  require("plugins.twilight")
  require("plugins.which-key")
end, 100)

------------------------------------------------------------
-- Theme Loader
------------------------------------------------------------
-- sync 'background' with the end-4 palette BEFORE the colorscheme loads,
-- so adaptive schemes (catppuccin auto, gruvbox) pick the right variant
require("config.daynight").setup()
load_theme()

------------------------------------------------------------
-- Autosave
------------------------------------------------------------
local autosave_timer = vim.loop.new_timer()
local autosave_interval = 1000  -- milliseconds

vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
  pattern = "*",
  callback = function()
    autosave_timer:stop()
    autosave_timer:start(autosave_interval, 0, vim.schedule_wrap(function()
      if vim.bo.modifiable and vim.bo.filetype ~= "gitcommit" then
        vim.cmd("silent write")
      end
    end))
  end
})
