local M = {}
local keymap = vim.keymap -- for conciseness
local util = require("lspconfig.util")

function M.setup(lspconfig, capabilities, on_attach)
  -- configure pyright server
  -- py-lsp
  -- python-lsp
  local root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    "__init__.py",
  }

  local py_cap = vim.lsp.protocol.make_client_capabilities()
  py_cap.textDocument.completion.completionItem.snippetSupport = true
  --[[ lspconfig['pylsp'].setup({
  capabilities = py_cap,
  on_attach = on_attach,
  root_dir = util.root_pattern(unpack(root_files)),
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        },
        rope_autoimport = {
          enabled = true
        }
      }
    }

  }
  }) ]]
  lspconfig["pyright"].setup({
    capabilities = py_cap,
    on_attach = on_attach,
    root_dir = util.root_pattern(unpack(root_files)),
    settings = {
      python = {
        analysis = {
          autoImportCompletions = true,
          typeCheckingMode = "off",
          diagnosticMode = "workspace",
          --stubPath = "/usr/lib/python3.11",
        },
      },
    },
  })
end

return M
