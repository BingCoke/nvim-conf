-- import mason plugin safely
local mason = require "mason"

-- import mason-lspconfig plugin safely
local mason_lspconfig = require "mason-lspconfig"

-- import mason-null-ls plugin safely
local mason_null_ls = require "mason-null-ls"

-- enable mason
mason.setup()

-- http://www.baidu.com
mason_lspconfig.setup({
  -- list of servers for mason to install
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "emmet_ls",
    "clangd",
  },
})

mason_null_ls.setup({
  -- list of formatters & linters for mason to install
  ensure_installed = {
    "prettier", -- ts/js formatter
    "stylua", -- lua formatter
    "eslint_d", -- ts/js linter
  },
  -- auto-install configured formatters & linters (with null-ls)
  automatic_installation = true,
})
