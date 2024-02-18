local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "<c-h>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<c-l>", "<Cmd>BufferNext<CR>", opts)
-- Re-order to previous/next
map("n", "<A-i>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A-o>", "<Cmd>BufferMoveNext<CR>", opts)
-- Goto buffer in position...
map("n", "<C-M-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<C-M-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<C-M-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<C-M-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<C-M-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<C-M-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<C-M-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<C-M-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<C-M-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<C-M-0>", "<Cmd>BufferLast<CR>", opts)

-- Pin/unpin buffer
--map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map("n", "<a-w>", "<Cmd>bdelete<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map("n", "<leader>bk", "<Cmd>BufferPick<CR>", opts)
-- Sort automatically by...
map("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

require("barbar").setup({
	separator = { left = "", right = "" },
	animation = false,
	-- Enable/disable auto-hiding the tab bar when there is a single buffer
	auto_hide = false,
	exclude_ft = {},
	exclude_name = {},
	-- A buffer to this direction will be focused (if it exists) when closing the current buffer.
	-- Valid options are 'left' (the default), 'previous', and 'right'
	focus_on_close = "right",
	-- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
	hide = { inactive = false },
	-- Disable highlighting file icons in inactive buffers
	highlight_inactive_file_icons = true,
	-- Disable highlighting alternate buffers
	highlight_alternate = false,

	icons = {
		diagnostics = {
			[vim.diagnostic.severity.ERROR] = { enabled = true, icon = signs.Error },
			[vim.diagnostic.severity.WARN] = { enabled = true, icon = signs.Warn },
			[vim.diagnostic.severity.INFO] = { enabled = true, icon = signs.Info },
			[vim.diagnostic.severity.HINT] = { enabled = true, icon = signs.Hint },
		},
		button = " ",
		modified = { button = " ●" },
		-- Configure the icons on the bufferline based on the visibility of a buffer.
		-- Supports all the base icon options, plus `modified` and `pinned`.
		alternate = { filetype = { enabled = false }, button = " ", buffer_index = true },
		current = { buffer_index = true },
		inactive = { buffer_index = true, button = " " },
		visible = { modified = { buffer_number = false }, button = " ", buffer_index = true },
	},
	-- Sets the maximum padding width with which to surround each tab
	maximum_padding = 0,

	-- Sets the minimum padding width with which to surround each tab
	minimum_padding = 0,
})
