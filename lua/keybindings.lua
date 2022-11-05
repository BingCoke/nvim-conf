vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }
-- 取消 s 默认功能
map("n", "s", "", opt)
-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
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
map("n", "Q", ":q<CR>", opt)
map("n", "S", ":w<CR>", opt)
-- 设置插件快捷键
local pluginKeys = {}
--translate
map("n", "tw", ":TranslateW<CR>", opt)
map("v", "tw", ":TranslateW<CR>", opt)
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
map("n", "bk", ":BufferLinePick<CR>", opt)
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
map("n", "sw", ":Telescope buffers<CR>", opt)

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

-- 改用 lspsaga.nvim 的ui显示
-- lsp 回调函数快捷键设置
pluginKeys.mapLSP = function(mapbuf)
	--   -- rename
	--   mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
	--   -- code action
	--   mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)

	mapbuf("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
	--   mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
	mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
	mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
	mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
	mapbuf("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt)
	--   -- diagnostic
	--   mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
	--   mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
	--   mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
	--vim.lsp.buf.format({async = true,})
	--   -- 没用到
	--    mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
	--    --mapbuf("n", "<C-i>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)
	--   -- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
	--   -- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
	--   -- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
end

--map("n", "<leader>f", "<cmd>lua require'lsp'.buf.format())<CR>", opt)
map("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opt)
map("n","se","<cmd>LspStart emmet_ls<CR>",opt)
map("n","te","<cmd>LspStop emmet_ls<CR>",opt)
-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
	local feedkey = function(key, mode)
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
	end

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end
	return {
		-- 出现补全
		["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		["<A-,>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- 上一个
		["<C-k>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- 确认
		["<TAB>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- 确认
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- 如果窗口内容太多，可以滚动
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		-- 自定义代码段跳转到下一个参数
		["<C-l>"] = cmp.mapping(function(_)
			if vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			end
		end, { "i", "s" }),

		-- 自定义代码段跳转到上一个参数
		["<C-h>"] = cmp.mapping(function()
			if vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	}
end

return pluginKeys
