vim.g.mapleader = " "
vim.g.maplocalleader = " "

--local map = vim.api.nvim_set_keymap
local map = vim.keymap.set
-- 复用 opt 参数
local opt = { noremap = true, silent = true }
map("n", "Q", "q", opt)
map("n", "q", "", opt)
map("i", "<c-`>", "`", opt)

-- 取消 s 默认功能
map("n", "s", "", opt)

-- windows 分屏快捷键
map("n", "<leader>sv", ":vsp<CR>", opt)
map("n", "<leader>sh", ":sp<CR>", opt)

map({ "n", "v", "i" }, "<c-a>", "<esc>ggVG", opt)

map("n", "<leader>f", "ggVG=<c-o>", opt)
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
--map("n", "gx", "<Plug>NetrwBrowseX", opt)

vim.s = 12
-- 左右比例控制
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opt)
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opt)

map("n", "<esc>", "<cmd>noh<cr><esc>", opt)
map("i", "<esc>", "<cmd>noh<cr><esc>", opt)

-- save file
map("i", "<C-s>", "<cmd>w<cr><esc>", opt)
map("x", "<C-s>", "<cmd>w<cr><esc>", opt)
map("n", "<C-s>", "<cmd>w<cr><esc>", opt)
map("s", "<C-s>", "<cmd>w<cr><esc>", opt)

map("n", "<leader>w", "<cmd>w<cr><esc>", opt)

-- 上下比例控制
map("n", "<C-Down>", "<cmd>resize -2<CR>", opt)
map("n", "<C-Up>", "<cmd>resize +2<CR>", opt)
-- Terminal相关
-- 打开terminal
map("n", "<leader>h", "<cmd>sp | terminal<CR>", opt)
map("n", "<leader>v", "<cmd>vsp | terminal<CR>", opt)
map("t", "<esc>", "<C-\\><C-n>", opt)
map("t", "<A-h>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "<A-j>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "<A-k>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "<A-l>", [[ <C-\><C-N><C-w>l ]], opt)

map("v", "<c-c>", '"+y', opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- 上下移动选中文本
map("v", "<a-j>", "<cmd>move '>+1<CR>gv-gv", opt)
map("v", "<a-k>", "<cmd>move '<-2<CR>gv-gv", opt)

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

map("n", "<leader>q", "<cmd>w<CR>", opt)
map("n", "<leader>i", "<cmd>qa<CR>", opt)
map("n", "<leader>W", "<cmd>w !sudo tee %<CR>", {})

-- 设置插件快捷键
local pluginKeys = {}
--translate

-- 设置文件搜索
-- Telescope
-- 查找文件
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", opt)

map("n", "<leader>p", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opt)
-- 查看tab show window
map("n", "<leader>sw", "<cmd>Telescope buffers<CR>", opt)

-- dap

-- treesitter

map("n", "<c-w>", "<c-w>w", opt)

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
--map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

vim.keymap.set("n", "<leader>t", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = false })

return pluginKeys
