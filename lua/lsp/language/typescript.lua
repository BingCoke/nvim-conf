-- local typescript_setup, typescript = pcall(require, "typescript")
local typescript = require("typescript")
local M = {}

function M.setup(lsp, default_capabilities, on_attach)
  require("typescript").setup({
    debug = false, -- enable debug logging for commands
    server = {   -- pass options to lspconfig's setup method
      on_attach = function(client, bufnr)
        if client ~= nil then
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
        end
        on_attach(client, bufnr)
      end,
      capabilities = default_capabilities,
    },
  }) -- configure typescript server with plugin
end

return M
