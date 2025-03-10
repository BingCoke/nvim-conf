M = {}

M.open_file = function(path)

	require("plugin-config.toggleterm").yazi:close()

	local tab_buffers = vim.fn.tabpagebuflist(vim.fn.tabpagenr())
	-- 遍历缓冲区
	-- 如果有一个filetype是dashboard 或者两个以上的buffer的filetype是nil或者"" 那么就是open
	local count = 0
	for _, bufn in ipairs(tab_buffers) do
		local filetype = vim.api.nvim_buf_get_option(bufn, "filetype")
		local name = vim.fn.bufname(bufn)
		if filetype == "dashboard" then
			vim.cmd("edit " .. path)
			return
		end
		if (filetype == nil or filetype == "") and (name == nil or name == "") then
			count = count + 1
		end
	end
	if count >= 2 then
		vim.cmd("edit " .. path)
		return
	end
	vim.cmd("tabedit " .. path)
end

return M
