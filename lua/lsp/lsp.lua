local M = {}
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

local util = require("lspconfig.util")

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- 设置光标
  keymap.set("n", "<a-p>", "<cmd>lua require('illuminate').goto_prev_reference(true)<CR>", opts)
  keymap.set("n", "<a-n>", "<cmd>lua require('illuminate').goto_next_reference(true)<CR>", opts)

  -- set keybinds
  keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opts)     -- show definition, references
  --keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
  keymap.set("n", "gD", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
  -- Go to type definition
  keymap.set("n", "gy", "<cmd>Lspsaga goto_type_definition<CR>")
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)      -- go to implementation

  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)           -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                -- smart rename

  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)  -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor

  keymap.set("n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)          -- jump to previous diagnostic in buffer
  keymap.set("n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)          -- jump to next diagnostic in buffer
  -- Diagnostic jump with filters such as only jumping to an error
  keymap.set("n", "[e", function()
    require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
  end)
  keymap.set("n", "]e", function()
    require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
  end)

  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)      -- show documentation for what is under cursor
  keymap.set("n", "<A-a>", "<cmd>Lspsaga hover_doc<CR>", opts)  -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  keymap.set("n", "<leader>f", ":lua vim.lsp.buf.format()<CR>", opts)

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")    -- rename file and update imports
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>")  -- remove unused variables (not in youtube nvim video)
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local default_capabilities = require("cmp_nvim_lsp").default_capabilities()

--local default_capabilities  = vim.lsp.protocol.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

--
-- lua-lsp
lspconfig["lua_ls"].setup({
  --  capabilities = capabilities,
  on_attach = on_attach,
  capabilities = default_capabilities,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

-- configure cpp clangd
lspconfig["clangd"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
})

-- configure html server
lspconfig["html"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
})

lspconfig["cssls"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
})
-- configure emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
})


local rs_cap = vim.lsp.protocol.make_client_capabilities()
rs_cap.textDocument.completion.completionItem.snippetSupport = true

rs_cap.experimental = {
  hoverActions = true,
  hoverRange = true,
  serverStatusNotification = true,
  snippetTextEdit = true,
  codeActionGroup = true,
  ssr = true,
}
-- enable auto-import
rs_cap.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
-- rust analyzer goodies
rs_cap.experimental.commands = {
  commands = {
    "rust-analyzer.runSingle",
    "rust-analyzer.showReferences",
    "rust-analyzer.gotoLocation",
    "editor.action.triggerParameterHints",
  },
}
--rs_cap = vim.tbl_deep_extend("force", capabilities, default_capabilities or {})

lspconfig["rust_analyzer"].setup({
  capabilities = rs_cap,
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      hover = {
        actions = {
          enable = true,
        },
      },
    },
  },
})




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

lspconfig["pyright"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern(unpack(root_files)),
  settings = {
    autoImportCompletion = true,
    python = {
      analysis = {
        typeCheckingMode = "off",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
})

-- sh-lsp
-- bash-lsp
lspconfig["bashls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["marksman"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

M.on_attach = on_attach
M.capabilities = capabilities
M.default_capabilities = default_capabilities

return M
