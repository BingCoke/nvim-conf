vim.opt.termguicolors = true
local bufferline = require("bufferline")

bufferline.setup({
	options = {
		-- 关闭 Tab 的命令
		mode = "tabs",
		close_command = "tabclose! %d",
		always_show_bufferline = false,
		enforce_regular_tabs = true,
		left_mouse_command = "tabnext %d", -- can be a string | function | false, see "Mouse actions"
		right_mouse_command = "bdelete!", -- can be a string | function | false, see "Mouse actions"
		left_trunc_marker = "",
		right_trunc_marker = "",
		separator_style = "thick",
		numbers = "none",
		themable = false,
		padding = 0,
		tab_size = 16,
		truncate_names = false,
		diagnostics = "nvim_lsp",
		show_close_icon = false,
		show_buffer_close_icons = false,
		show_tab_indicators = false,
		show_duplicate_prefix = false,
	},
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local function goTo(num)
	bufferline.go_to(num)
end

map("n", "<a-w>", "<Cmd>tabclose<CR>", opts)
map("n", "<leader>sw", "<Cmd>BufferLinePick<CR>", opts)

map("n", "<c-h>", "<Cmd>BufferLineCyclePrev<CR>", opts)
map("n", "<c-l>", "<Cmd>BufferLineCycleNext<CR>", opts)

map("n", "<leader>bl", "<Cmd>BufferCloseRight<CR>", opts)
map("n", "<leader>bh", "<Cmd>BufferCloseLeft<CR>", opts)

map("n", "<A-i>", "<Cmd>tabmove -1<CR>", opts)
map("n", "<A-o>", "<Cmd>tabmove +1<CR>", opts)

map("n", "<A-]>", "<cmd>tabnext #<CR>", opts)
map("n", "<A-[>", "<cmd>tabnext -<CR>", opts)

map("n", "<C-M-1>", function()
	goTo(1)
end, opts)

map("n", "<C-M-2>", function()
	goTo(2)
end, opts)

map("n", "<C-M-3>", function()
	goTo(3)
end, opts)

map("n", "<C-M-4>", function()
	goTo(4)
end, opts)

map("n", "<C-M-5>", function()
	goTo(5)
end, opts)

map("n", "<C-M-6>", function()
	goTo(6)
end, opts)

map("n", "<C-M-7>", function()
	goTo(7)
end, opts)

map("n", "<C-M-8>", function()
	goTo(8)
end, opts)

map("n", "<C-M-9>", function()
	goTo(9)
end, opts)

map("n", "<C-M-0>", function()
	goTo(10)
end, opts)

