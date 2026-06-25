-- Universal transparent background.
--
-- kitty runs at `background_opacity 0.6` (+ blur) and Hyprland blurs behind it,
-- so the terminal is see-through. That transparency only shows through Neovim
-- cells that have NO background colour. Most colorschemes paint a solid Normal
-- background, which hides it. This autocmd clears the "page background" groups
-- after ANY colorscheme loads, so every theme gets the same transparent look as
-- kitty/Hyprland — including themes with no transparency option of their own
-- (solarized-osaka, pywal16, and the custom `uylag`).
--
-- Only background-fill groups are cleared. Functional highlights that NEED a
-- background to be usable (Visual, Search, CursorLine, Pmenu/completion menu)
-- are left untouched on purpose.

-- Groups whose background should become transparent. Using `guibg=NONE
-- ctermbg=NONE` (instead of nvim_set_hl) keeps each group's existing foreground.
local transparent_groups = {
  -- Core editor surfaces
  "Normal", "NormalNC", "EndOfBuffer", "NonText", "SignColumn", "FoldColumn",
  "LineNr", "LineNrAbove", "LineNrBelow", "CursorLineNr",
  "WinSeparator", "VertSplit",
  -- Floating windows (LSP hover, which-key, fzf-lua, diagnostics, etc.)
  "NormalFloat", "FloatBorder", "FloatTitle",
  -- nvim-tree file explorer
  "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeEndOfBuffer",
  "NvimTreeWinSeparator", "NvimTreeVertSplit",
  -- Telescope / which-key floats (harmless if the group doesn't exist)
  "TelescopeNormal", "TelescopeBorder", "WhichKeyFloat",
}

local function make_transparent()
  for _, group in ipairs(transparent_groups) do
    -- pcall so a theme missing one of these groups can't break the others.
    pcall(vim.cmd, ("highlight %s guibg=NONE ctermbg=NONE"):format(group))
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("transparent_background", { clear = true }),
  pattern = "*",
  callback = make_transparent,
})

-- Apply immediately too, in case a colorscheme was set before this loaded.
make_transparent()
