local M = {}

M.config = {}
M.run = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
	if M.config[filetype] == nil then
		require("my.notify").create_notify_floating_window({ filetype .. " is not found for debug" })
	else
		M.config[filetype].run()
	end
end

local function setUp(filetype, func)
	vim.api.nvim_create_autocmd({
		"FileType",
	}, {
		--group = vim.api.nvim_create_augroup("httpFile", { clear = true }),
		callback = function()
			local current_filetype = vim.bo.filetype
			if current_filetype ~= filetype then
				return
			end

			func()

			local buf = vim.api.nvim_get_current_buf()
			local opt = { noremap = true, silent = true, buffer = buf }
			local keymap = vim.keymap -- for conciseness
			keymap.set("n", "<leader>e", function()
				require("telescope").extensions.rest.select_env()
			end, opt)

		end,
	})
end

setUp("go", function()
	-- dap-go
	local dap_go = require("dap.dap-go")
	dap_go.setup()
	M.config.go = dap_go
end)

setUp("python", function()
	-- dap-python
	local dap_py = require("dap.dap-python")
	dap_py.setup()
	M.config.python = dap_py
end)

setUp("rust", function()
	-- dap-rust
	local dap_rs = require("dap.dap-rs")
	dap_rs.setup()
	M.config.rust = dap_rs
end)

local dap_ts = require("dap.dap-ts")
dap_ts.setup()

M.config.ts = dap_ts

return M
