local common = require("lsp.common-config")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags ,
  --filetypes = {"js","javascript","javascript.jsx"},
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
