local M = {}

function M.setup()
	-- global status
	vim.g.rime_enabled = false

	-- add rime to lspconfig as a custom server
	local lspconfig = require("lspconfig")
	local configs = require("lspconfig.configs")
	if not configs.rime_ls then
		configs.rime_ls = {
			default_config = {
				name = "rime_ls",
				-- cmd = { 'rime_ls' },
				-- cmd = { '/home/wlh/coding/rime-ls/target/debug/rime_ls' },
				-- -- cmd = { '/home/wlh/coding/rime-ls/target/release/rime_ls' },
				cmd = vim.lsp.rpc.connect("127.0.0.1", 9257),
				filetypes = { "*" },
				single_file_support = true,
			},
			settings = {},
			docs = {
				description = [[
https://www.github.com/wlh320/rime-ls

A language server for librime
]],
			},
		}
	end


end

return M
