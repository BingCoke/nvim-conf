-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

-- import typescript plugin safely
local typescript_setup, typescript = pcall(require, "typescript")
if not typescript_setup then
  return
end

-- import rust-tools plugin safely
local rust_setup, rt = pcall(require, "rust-tools")
if not rust_setup then
  return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }


  -- set keybinds
  keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  --keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
  keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
  -- Go to type definition
  keymap.set("n", "gy", "<cmd>Lspsaga goto_type_definition<CR>")
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation

  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename

  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor

  keymap.set("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  -- Diagnostic jump with filters such as only jumping to an error
  keymap.set("n", "[e", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
  keymap.set("n", "]e", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)

  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<A-a>", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
  end

  if client.name == "rust_analyzer" then
      -- Hover actions
      vim.keymap.set("n", "<Leader>b", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  end
  if client.name == "rust-analyzer" then
      -- Hover actions
      vim.keymap.set("n", "<Leader>b", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  end


end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- configure typescript server with plugin
typescript.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  },
})



-- for go
--
require('go').setup({
  -- other setups ....
  lsp_cfg = {
    capabilities = capabilities,
    on_attach = on_attach,
    -- other setups
  },
})


local cfg = require'go.lsp'.config() -- config() return the go.nvim gopls setup

lspconfig.gopls.setup(cfg)

-- configure rust server with plugin
rt.setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      ['rust-analyzer'] = {
        ['completion'] = {
          ['snippets'] = {
            ['custom'] = {
              ["Arc::new"] = {
                ["postfix"] = "arc",
                ["body"] = "Arc::new(${receiver})",
                ["requires"] = "std::sync::Arc",
                ["description"] = "sync::Arc",
                ["scope"] = "expr"
              },
              ["Ok"] = {
                ["postfix"] = "ok",
                ["body"] = "Ok(${receiver})",
                ["description"] = "Result::Ok",
                ["scope"] = "expr"
              },
              ["Err"] = {
                ["postfix"] = "err",
                ["body"] = "Err(${receiver})",
                ["description"] = "Result::Err",
                ["scope"] = "expr"
              },
              ["Some"] = {
                ["postfix"] = "some",
                ["body"] = "Some(${receiver})",
                ["description"] = "Option::Some",
                ["scope"] = "expr"
              },
              ["Println"] = {
                ["postfix"] = "pln",
                ["body"] = "println!(${receiver})",
                ["description"] = "get pln",
                ["scope"] = "expr"
              },
              ["Box::pin"] = {
                ["postfix"] = "pinb",
                ["body"] = "Box::pin",
                ["description"] = "get pln",
                ["scope"] = "expr"
              }
            }
          }
        }

      }

    }
  },
})

lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    }
  }
})

-- configure cpp clangd
lspconfig["clangd"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure html server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-- configure emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})

-- configure pyright server
lspconfig["pyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    pyright = {
      autoImportCompletion = true,
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          typeCheckingMode = "off",
        },
      },
    },
  },
})

