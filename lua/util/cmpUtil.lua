local M = {}

M.blinkCmp = true

function M.getCapabilites(cap)
	local cap = {
		completionProvider = {
			resolveProvider = true,
			triggerCharacters = {
				--".",
				--'"',
				--"'",
				--"`",
				--"/",
				--"$",
				--"!",
			},
		},
	}

	if M.blinkCmp then
		return require("blink.cmp").get_lsp_capabilities(cap)
	else
		return require("cmp_nvim_lsp").default_capabilities()
	end
end

return M
