-- theme choice is saved in a file for persistence on restart
-- could use a plugin instead, but hey, this is more fun
-- lualine theme gets stored separately due to possible naming differences

local theme_file = vim.fn.stdpath("config") .. "/lua/config/saved_theme"

_G.load_theme = function()
    local file = io.open(theme_file, "r")
	if file then
		local ok = pcall(vim.cmd, "colorscheme " .. file:read("*l"))
		if ok then
			require("lualine").setup({ options = { theme = file:read("*l") } })
		end
	file:close() end
end

-- pywal16 needs wal colors on disk; only offer it when they exist
local has_wal = vim.fn.filereadable(vim.fn.expand("~/.cache/wal/colors")) == 1

local themes = { --add more themes here, if installed
	{ "solarized-osaka", "auto" },  -- Solarized Osaka (craftzdog)
	{ "uylag", "uylag" },  -- New custom purple theme
	{ "catppuccin", "catppuccin-nvim" },
	{ "gruvbox", "gruvbox" },
	{ "kanagawa-wave", "kanagawa" }, -- Default variant
	{ "kanagawa-dragon", "kanagawa" }, -- Dark variant for late nights
	{ "kanagawa-lotus", "kanagawa" }, -- Light variant
	{ "modus_vivendi", "modus_vivendi" },  -- Dark theme (BLACK CONTRAST!)
	{ "modus_operandi", "modus_operandi" }, -- Light theme (if you want it later)
}

if has_wal then
	table.insert(themes, 5, { "pywal16", "pywal16-nvim" })
end

-- ii follows the Quickshell wallpaper palette; only offer it when the
-- generated colors exist
local has_ii = vim.fn.filereadable(
	vim.fn.expand("~/.local/state/quickshell/user/generated/material_colors.scss")) == 1
if has_ii then
	table.insert(themes, 1, { "ii", "ii" })
end

local current_theme_index = 1

_G.switch_theme = function()
	current_theme_index = current_theme_index % #themes + 1
	local colorscheme, lualine = unpack(themes[current_theme_index])
	local ok, err = pcall(vim.cmd, "colorscheme " .. colorscheme)
	if not ok then
		vim.notify("Theme '" .. colorscheme .. "' failed to load, skipping: " .. err, vim.log.levels.WARN)
		return _G.switch_theme()
	end
	require("lualine").setup({ options = { theme = lualine } })
	local file = io.open(theme_file, "w")
	if file then file:write(colorscheme .. "\n" .. lualine) file:close() end
end
