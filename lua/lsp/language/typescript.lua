-- local typescript_setup, typescript = pcall(require, "typescript")
local typescript = require("typescript")
local M = {}

function M.setup(lsp, default_capabilities, on_attach)
  require("typescript").setup({
    debug = false, -- enable debug logging for commands
    server = {   -- pass options to lspconfig's setup method
      on_attach = on_attach,
      capabilities = default_capabilities,
    },
  }) -- configure typescript server with plugin
end

return M
