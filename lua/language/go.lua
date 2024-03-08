local lsp_conf = require("lsp.lsp")
local keymap = vim.keymap -- for conciseness

require("go").setup({
  -- other setups ....
  lsp_inlay_hints = {
    enable = false
  },
  lsp_cfg = {
    capabilities = lsp_conf.default_capabilities,
    on_attach = function(client, bufnr)
      lsp_conf.on_attach(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      keymap.set("n", "<leader>f", ":GoFmt<CR>", opts)
    end,
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      },
    },
    -- other setups
  },
})

local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup

require("lspconfig").gopls.setup({
  capabilities = lsp_conf.default_capabilities,
  on_attach = function(client, bufnr)
    lsp_conf.on_attach(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    keymap.set("n", "<leader>f", ":GoFmt<CR>", opts)
  end,
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})
