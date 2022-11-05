local common = require("lsp.common-config")
local opts = {
	filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    --common.disableFormat(client)
    common.keyAttach(bufnr)
  end,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
