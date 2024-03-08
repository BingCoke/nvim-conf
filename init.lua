-- sel
--package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
--package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
-- 常规
vim.loader.enable()
require("basic")
-- 快捷键映射
require("keybindings")
-- 插件设置
require("plugins")


vim.g.hlchunk_files = "*.ts,*.js,*.json,*.go,*.c,*.cpp,*.rs,*.h,*.hpp,*.lua,*.py,*.dart"

vim.o.switchbuf='useopen,usetab,newtab'

local group = vim.api.nvim_create_augroup("BufLast", { clear = true })
-- 如果当前关闭的buffer是最后一个buffer
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
