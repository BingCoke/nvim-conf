local M = {}
local function create_selection_box(items,opt)
  if opt == nil then
    opt = {}
  end
  if opt.title == nil then
    opt.title = { { "select", "TitleString" } }
  end
	-- 设置边框字符
	local border_chars = {
		{ "╭" },
		{ "─" },
		{ "╮" },
		{ "│" },
		{ "╯" },
		{ "─" },
		{ "╰" },
		{ "│" },
	}

	-- 获取当前窗口的尺寸
	local win_width = vim.api.nvim_win_get_width(0)
	local win_height = vim.api.nvim_win_get_height(0)

	-- 计算选择框位置
	local selection_width = math.floor(win_width * 0.6) -- 设置为窗口宽度的 60%
	local selection_height = #items + 2 -- 每个选项一行，再增加一行作为底部边框行
	local row = math.floor((win_height - selection_height) / 2)
	local col = math.floor((win_width - selection_width) / 2)

	-- 创建空白缓冲区
	local buf = vim.api.nvim_create_buf(false, true)

	-- 创建边框窗口
	local border_win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = selection_width,
		height = selection_height,
		row = row,
		col = col,
		style = "minimal",
		border = border_chars,
    title = opt.title,
    title_pos = "center",
	})

	-- 设置选项
	--vim.api.nvim_buf_set_option(buf, 'modifiable', true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, items)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)

	-- 切换到边框窗口
	vim.api.nvim_set_current_win(border_win)

	-- 返回边框窗口的句柄和缓冲区，以便后续使用
	return border_win, buf
end

M.get_user_selection = function(map,opt)
	-- 创建选择框并设置选项

	local key_list = {}
  local fnMap = {}
	for key, v in pairs(map) do
		table.insert(key_list, v.name)
    fnMap[v.name] = v.fn
	end

	local selection_box_win, selection_box_buf = create_selection_box(key_list,opt)

	-- 注册回车按键事件
	vim.keymap.set("n", "<CR>", M.process_selection(fnMap,opt), { nowait = true, silent = true, buffer = selection_box_buf })

	vim.api.nvim_buf_set_keymap(
		selection_box_buf,
		"n",
		"q",
		"<Esc>:lua vim.api.nvim_win_close(0, true)<CR>",
		{ nowait = true, silent = true }
	)

	-- 切换到选择框窗口的缓冲区
	vim.api.nvim_set_current_buf(selection_box_buf)
end

M.process_selection = function(map,opt)
	return function()
		-- 关闭选择框窗口
		local selected_line = vim.api.nvim_get_current_line()
		vim.api.nvim_win_close(0, true)
		-- 获取当前行的内容
		map[selected_line](opt)

	end
end

return M
