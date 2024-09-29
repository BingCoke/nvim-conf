local server = vim.v.servername
require("toggleterm").setup({
	shade_terminals = false,
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		border = "curved",
		title_pos = "center",
	},
})

local Terminal = require("toggleterm.terminal").Terminal

local map = vim.keymap.set
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

local term = Terminal:new({
	direction = "float",
	close_on_exit = true,
	display_name = "term",
	env = {
		NVIM_SERVER = server,
		EDITOR = "nvim_remote",
	},
	on_open = function(term)
		--vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
	end,
})

map({ "n", "i", "t" }, "<M-e>", function()
	term:toggle()
end, opt)

server = vim.v.servername
local yazi = Terminal:new({
	display_name = "yazi",
	direction = "float",
	close_on_exit = true,
	cmd = "yazi",
	env = {
		EDITOR = "nvim_remote",
		NVIM_SERVER = server,
	},
	on_open = function()
		vim.cmd("startinsert!")
	end,
})
map({ "n", "i", "t" }, "<M-f>", function()
	yazi:toggle()
end, opt)

local git = Terminal:new({
	cmd = "lazygit",
	direction = "float",
	close_on_exit = true,
	display_name = "git",
	on_open = function(term)
		vim.cmd("startinsert!")
	end,
})

map({ "n", "i", "t" }, "<M-g>", function()
	git:toggle()
end, opt)

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<Esc>", { noremap = true, silent = true })

	-- 使用 <C-\><C-n> 退出终端模式
	vim.api.nvim_buf_set_keymap(0, "t", "<C-\\><C-n>", "<C-\\><C-n>", { noremap = true, silent = true })
	--vim.api.nvim_buf_set_keymap(0, "t", "<leader><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
