local typescript_setup, typescript = pcall(require, "typescript")
local lspconf = require("lsp.lsp")
if not typescript_setup then
  return
end


-- configure typescript server with plugin
typescript.setup({
  server = {
    --capabilities = capabilities,
    capabilities = lspconf.default_capabilities,
    on_attach = lspconf.on_attach,
  },
})
