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

-- 关闭当前
map("n", "<leader>sc", "<C-w>c", opt)

map("n", "<A-d>", "<C-w>c", opt)
map("i", "<A-d>", "<C-w>c", opt)
-- 关闭其他
map("n", "<leader>so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
--map("n", "gx", "<Plug>NetrwBrowseX", opt)

vim.s = 12
-- 左右比例控制

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

map("n", "<leader>q", "<cmd>qa<CR>", opt)
map("n", "<leader>i", "<cmd>qa<CR>", opt)
map("n", "<leader>W", "<cmd>w !sudo tee %<CR>", {})

-- 设置插件快捷键
local pluginKeys = {}
--translate

-- 设置文件搜索
-- Telescope
-- 查找文件
map("n", "<C-p>", function()
	vim.cmd([[Neotree close]])
	local tab_buffers = vim.fn.tabpagebuflist(vim.fn.tabpagenr())
	--local count = 0
	for _, bufnr in ipairs(tab_buffers) do
		local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
		local name = vim.fn.bufname(bufnr)
		if filetype == "dashboard" then
			require("telescope").extensions.my_file_find.find_files({})
			return
		end
		--if (filetype == nil or filetype == "") and (name == nil or name == "") then
		--	count = count + 1
		--end
	end
	--if count >= 2 then
	--	require("telescope").extensions.my_file_find.find_files({})
	--	return
	--end
	vim.cmd([[Telescope find_files]])
end, opt)

-- 全局搜索
map("n", "<C-f>", function()
	vim.cmd([[Neotree close]])
	vim.cmd([[Telescope live_grep]])
end, opt)

map("n", "sw", "<cmd>Telescope buffers<CR>", opt)
map("n", "<leader>p", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", opt)
-- dap

-- treesitter

map("n", "<c-w>", "<c-w>w", opt)



-- nvim-tree
-- alt+m 键 打开关闭tree
--map("n", "<A-m>", ":NvimTreeToggle<CR>", opt)

vim.keymap.set("n", "<leader>t", "<cmd>SymbolsOutline<CR>", { noremap = true, silent = false })

return pluginKeys
