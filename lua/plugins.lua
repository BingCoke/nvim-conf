local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local border_chars = {
	{ "╭" },
	{ "─" },
	{ "╮" },
	{ "│" },
	{ "╯" },
	{ "─" },
	{ "╰" },
	{ "│" },
}
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)
-- Example using a list of specs with the default options
require("lazy").setup({
	{ import = "lazy.lsp" },
	{ import = "lazy.dap" },
	{ import = "lazy.cmp" },
	{ import = "lazy.markdown" },
	{ import = "lazy.base" },
	{ import = "lazy.code" },
	{ import = "lazy.useful" },
}, {
	ui = {
		--border = "solider",
		border = border_chars,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				--"matchit",
				--"matchparen",
				--"netrwPlugin",
				"tarPlugin",
				--"tohtml",
				--"tutor",
				"zipPlugin",
			},
		},
	},
})
