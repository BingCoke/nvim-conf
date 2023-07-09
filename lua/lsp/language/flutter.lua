local M = {}
local keymap = vim.keymap -- for conciseness

function M.setup(lspconfig, capabilities, on_attach)
  require("flutter-tools").setup({
    ui = {
      notification_style = "plugin",
    },
    lsp = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
  })
end

return M
