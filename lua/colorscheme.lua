local colorscheme = "tokyonight"
--local colorscheme = "neofusion"
require("monokai").setup({ palette = require("monokai").ristretto })
require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = true, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true, bold = true },
		keywords = { italic = true, bold = true },
		--functions = { bold = true },
		variables = { bold = true },
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent", -- style for sidebars, see below
		floats = "transparent", -- style for floating windows
	},
	sidebars = { "qf", "help", "lualine" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = false, -- dims inactive windows
	lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
})

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)

if not status_ok then
	vim.notify("colorscheme " .. colorscheme .. " 没有找到！")
	return
end

vim.cmd("highlight! BufferLineSeparatorVisible guifg=#82aaff guibg=NONE")
vim.cmd("highlight! BufferLineSeparatorSelected guifg=#82aaff guibg=NONE")
vim.cmd("highlight! BufferLineSeparator guifg=#82aaff guibg=NONE")

--vim.cmd("highlight! MatchParen guifg=#f7768e guibg=#7980ab gui=bold cterm=bold")

vim.cmd("highlight! MatchParen guifg=None guibg=#7980ab gui=bold cterm=bold")
vim.cmd("highlight! Cursor guifg=#222436 guibg=#8291bf")
--vim.cmd("highlight! TermCursor guifg=#222436 guibg=#8291bf")


--vim.cmd("highlight! CursorIM guifg=#222436 guibg=#8291bf ")
--vim.cmd("highlight! lCursor guifg=#222436 guibg=#8291bf ")
vim.cmd("highlight! CursorLine guibg=#3b4261")
vim.cmd("highlight! DiagnosticUnnecessary guifg=#747da6")
vim.cmd("highlight! Comment cterm=bold,italic gui=bold,italic guifg=#747da6")
vim.cmd("highlight! LspInlayHint guifg=#6d7594")

--vim.cmd("hi LspInlayHint guifg=#7aa2f7 guibg=#3b4261")
--vim.cmd("highlight FidgetTitle ctermfg=110 guifg=#6cb6eb")
--vim.cmd("highlight link FidgetTitle Variable")
--pcall(vim.cmd,"hi Cursor guifg=NONE guibg=NONE")
