local M = {}

M.blinkCmp = true

function M.getCapabilites()
	local cap
	if M.blinkCmp then
		cap = require("blink.cmp").get_lsp_capabilities(cap)
	else
		cap = require("cmp_nvim_lsp").default_capabilities()
	end

	cap.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	return cap
end

return M
