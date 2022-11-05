local keybindings = require("keybindings")
local common = require("lsp.common-config")
local opts = {
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
	on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		common.disableFormat(client)
		common.keyAttach(bufnr)
	end,
}

return {
	on_setup = function(server)
		server:setup(opts)
	end,
}
