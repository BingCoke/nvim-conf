local M = {}
local keymap = vim.keymap -- for conciseness

function M.setup(lspconfig, capabilities, on_attach)
  local yaml_capabilities = vim.lsp.protocol.make_client_capabilities()
  yaml_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  lspconfig["yamlls"].setup({
    capabilities = yaml_capabilities,
    on_attach = on_attach,
  })
end

return M
