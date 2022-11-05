local common = require("lsp.common-config")

require('lspconfig').gopls.setup({
    settings = {
        gopls = {
            gofumpt = true
        }
    }
})

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(client, bufnr)
    --common.disableFormat(client)
    common.keyAttach(bufnr)
  end,
    -- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
