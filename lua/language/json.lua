local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end
local lspconf = require("lsp.lsp")

lspconfig["jsonls"].setup({
  capabilities = lspconf.default_capabilities,
  on_attach = lspconf.on_attach,
  settings = {
    json = {
      -- for get more schemas https://www.schemastore.org/json/
      --schemas = require("schemastore").yaml.schemas(),
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "http://json.schemastore.org/tsconfig",
        },
      },
    },
  },
})
