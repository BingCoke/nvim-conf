vim.loader.enable()
---@diagnostic disable-next-line: undefined-field
OS = vim.loop.os_uname().sysname
require("basic")
require("keybindings")
require("plugins")
require("neovide")

vim.g.hlchunk_files = "*.ts,*.js,*.json,*.go,*.c,*.cpp,*.rs,*.h,*.hpp,*.lua,*.py,*.dart"

vim.o.switchbuf = "useopen,usetab,newtab"

local group = vim.api.nvim_create_augroup("BufLast", { clear = true })

vim.api.nvim_create_autocmd("BufDelete", {
	group = group,
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local opt = { noremap = true, silent = true, buffer = buf }
		local keymap = vim.keymap -- for conciseness
		local name = vim.fn.expand("%:t")
		if name == nil or name == "" then
			keymap.set("n", "<c-p>", function()
				require("telescope").extensions.my_file_find.find_files({})
			end, opt)
		end
	end,
})
