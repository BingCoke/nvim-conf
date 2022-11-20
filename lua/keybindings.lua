vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }
-- 取消 s 默认功能
-- map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "<leader>sv", ":vsp<CR>", opt)
map("n", "<leader>sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "<leader>sc", "<C-w>c", opt)
-- 关闭其他
map("n", "<leader>so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)


-- 左右比例控制
map("n", "<C-Left>", ":vertical resize +2<CR>", opt)
map("n", "<C-Right>", ":vertical resize -2<CR>", opt)
-- 上下比例控制
map("n", "<C-Down>", ":resize +2<CR>", opt)
map("n", "<C-Up>", ":resize -2<CR>", opt)
-- Terminal相关
-- 打开terminal
map("n", "<leader>h", ":sp | terminal<CR>", opt)
map("n", "<leader>v", ":vsp | terminal<CR>", opt)
map("t", "`", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)
-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 上下滚动浏览
map("n", "<C-j>", "4j", opt)
map("n", "<C-k>", "4k", opt)
map("v", "<C-j>", "4j", opt)
map("v", "<C-k>", "4k", opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "9k", opt)
map("n", "<C-d>", "9j", opt)
map("v", "<C-u>", "9k", opt)
map("v", "<C-d>", "9j", opt)
-- 设置退出并,保存

map("n", "Q", ":wq<CR>", opt)
map("n", "<leader>i", ":q<CR>", opt)
map("n", "<leader>w", ":w<CR>", {})
-- 设置插件快捷键
local pluginKeys = {}
--translate
map("n", "<leader>tw", ":TranslateW<CR>", opt)
map("v", "<leader>tw", ":TranslateW<CR>", opt)
map("v", "th", "TranslateH<CR>", opt)
map("n", "th", "TranslateH<CR>", opt)

-- bufferline
-- 左右Tab切换
map("n", "<C-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<C-l>", ":BufferLineCycleNext<CR>", opt)
-- 关闭
--"moll/vim-bbye"
map("n", "<C-w>", ":Bdelete!<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)
-- 选择打开的tab
map("n", "<leader>bk", ":BufferLinePick<CR>", opt)
map("n", "<A-1>", ":BufferLineGoToBuffer 1<CR>", opt)
map("n", "<A-2>", ":BufferLineGoToBuffer 2<CR>", opt)
map("n", "<A-3>", ":BufferLineGoToBuffer 3<CR>", opt)
map("n", "<A-4>", ":BufferLineGoToBuffer 4<CR>", opt)
map("n", "<A-5>", ":BufferLineGoToBuffer 5<CR>", opt)
map("n", "<A-6>", ":BufferLineGoToBuffer 6<CR>", opt)
map("n", "<A-7>", ":BufferLineGoToBuffer 7<CR>", opt)
map("n", "<A-8>", ":BufferLineGoToBuffer 8<CR>", opt)
map("n", "<A-9>", ":BufferLineGoToBuffer 9<CR>", opt)
map("n", "<A-0>", ":BufferLineGoToBuffer 10<CR>", opt)
--tab置换
map("n", "<A-i>", ":BufferLineMoveNext<CR>", opt)
map("n", "<A-o>", ":BufferLineMovePrev<CR>", opt)
-- 设置文件搜索
-- Telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)
-- 查看tab show window
map("n", "<leader>sw", ":Telescope buffers<CR>", opt)

-- easymotion
map("n","<leader>r","<plug>(easymotion-s)",opt)
map("n","<leader>e","<plug>(easymotion-f)",opt)
-- dap
map("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", opt)
map("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", opt)
map("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", opt)
map("n", "<F12>", "<Cmd>lua require'dap'.step_out()<CR>", opt)
map("n", "<Leader>b", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opt)
map("n", "<Leader>B", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opt)
map("n", "<Leader>lp", "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opt)
map("n", "<Leader>dr", "<Cmd>lua require'dap'.repl.open()<CR>", opt)
map("n", "<Leader>dl", "<Cmd>lua require'dap'.run_last()<CR>", opt)
map("n", "<Leader>k", "<Cmd>lua require'dapui'.eval()<CR>", opt)

-- treesitter
map("n","<leader>se","<cmd>lua require('vim.treesitter').stop()<CR>",opt)


map("n","<leader>gh",":Dashboard",opt)
map("n","<leader>nt",":DashboardNewFile",opt)

-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		-- 历史记录
		["<C-n>"] = "cycle_history_next",
		["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

-- nvim-tree
-- alt+m 键 打开关闭tree
map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)
-- 列表快捷键
-- tab 浏览文件
pluginKeys.nvimTreeList = {
	-- 打开文件或文件夹
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
	-- 分屏打开文件
	{ key = "<C-v>", action = "vsplit" },
	{ key = "<c-h>", action = "split" },
	-- 显示隐藏文件
	{ key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
	{ key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
	-- 文件操作
	{ key = "R", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "D", action = "remove" },
	{ key = "d", action = "trash" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "s", action = "system_open" },
}


return pluginKeys
