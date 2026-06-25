-- Mason setup
require('mason').setup()

-- Snippet engine setup
local luasnip = require('luasnip')
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
local cmp = require('cmp')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- Added luasnip source
    { name = 'buffer' },
    { name = 'path' },
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Keymaps for snippet navigation
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
})

-- ---------------------------------------------------------------------------
-- LSP setup (mason-lspconfig v2 style)
--
-- v2 removed the old `handlers`/per-server `setup()` mechanism. Servers listed
-- in `ensure_installed` are installed and auto-enabled via vim.lsp.enable().
-- We therefore set keymaps with an LspAttach autocmd and shared options with
-- vim.lsp.config(), which is the supported path on Neovim 0.11+/0.12.
-- ---------------------------------------------------------------------------

-- Buffer-local keymaps whenever ANY language server attaches.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local function map(m, k, v)
      vim.keymap.set(m, k, v, { noremap = true, silent = true, buffer = bufnr })
    end
    map('n', 'gd', vim.lsp.buf.definition)
    map('n', 'K', vim.lsp.buf.hover)
    map('n', 'gi', vim.lsp.buf.implementation)
    map('n', '<leader>rr', vim.lsp.buf.references)
    map('n', '<leader>rn', vim.lsp.buf.rename)
    map('n', '<leader>ca', vim.lsp.buf.code_action)
    map('n', '[d', vim.diagnostic.goto_prev)
    map('n', ']d', vim.diagnostic.goto_next)
  end,
})

-- Give every server nvim-cmp's enhanced completion capabilities (snippets,
-- additionalTextEdits, etc.). Applies to all servers via the '*' wildcard.
vim.lsp.config('*', { capabilities = capabilities })

-- lua_ls: recognize the Neovim runtime so editing this config doesn't flag
-- `vim` as an "undefined global".
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Install + auto-enable the servers. (rust_analyzer: add when you get a good PC.
-- gopls: add once Go is installed on this machine.)
require('mason-lspconfig').setup({
  ensure_installed = {
    -- Frontend / React / Next.js / React Native (all TS/JS share ts_ls)
    "ts_ls", "cssls", "html", "tailwindcss", "emmet_language_server", "eslint",
    -- Config files you hit in every JS/TS project
    "jsonls", "yamlls",
    -- Backend / scripting / editing this very config
    "pyright", "lua_ls", "bashls",
  },
})