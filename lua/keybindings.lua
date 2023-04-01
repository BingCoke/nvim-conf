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
map("n", "<A-d>", "<C-w>c", opt)
map("i", "<A-d>", "<C-w>c", opt)
-- 关闭其他
map("n", "<leader>so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<A-h>", "<C-w>h", opt)
map("n", "<A-j>", "<C-w>j", opt)
map("n", "<A-k>", "<C-w>k", opt)
map("n", "<A-l>", "<C-w>l", opt)


vim.s = 12;
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
map("t", "<esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

map("v", "<a-c>", "\"+y", opt)
map("v", "<c-c>", "\"+y", opt)
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

map("n", "<leader>q", ":wq<CR>", opt)
map("n", "<leader>i", ":q<CR>", opt)
map("n", "<leader>w", ":w<CR>", {})
map("n", "<leader>W", ":w !sudo tee %<CR>", {})

-- 设置插件快捷键
local pluginKeys = {}
--translate

-- 设置文件搜索
-- Telescope
-- 查找文件
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", ":Telescope live_grep<CR>", opt)
map("n", "<A-f>", ":Telescope coc document_symbols<CR>", opt)
-- 查看tab show window
map("n", "<leader>sw", ":Telescope buffers<CR>", opt)

-- dap


-- treesitter

map("n","<c-w>","<c-w>w",opt)

map("n","<leader>gh",":Dashboard<CR>",opt)
map("n","<leader>nt",":DashboardNewFile<CR>",opt)

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
