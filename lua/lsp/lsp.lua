local M = {}

local language = {
  "lua",
  "python",
  "rust",
  "markdown",
  "yaml",
  "flutter",
  -- "typescript",
}

-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end
vim.diagnostic.config({
  update_in_insert = false,
})

-- config lsp signature
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  -- Use a sharp border with `FloatBorder` highlights
  border = "single",
  title = { { "signature", "TitleString" } },
  --opt.title = { { "input", "TitleString" } }
})

vim.cmd("hi LspSignatureActiveParameter guibg=#3b4261")

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  keymap.set("i", "<c-p>", vim.lsp.buf.signature_help, opts)
  -- 设置光标
  keymap.set("n", "<a-p>", "<cmd>lua require('illuminate').goto_prev_reference(true)<CR>", opts)
  keymap.set("n", "<a-n>", "<cmd>lua require('illuminate').goto_next_reference(true)<CR>", opts)

  -- set keybinds
  keymap.set("n", "gr", "<CMD>Lspsaga finder ref<CR>", opts) -- show definition, references
  --keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
  keymap.set("n", "gD", "<CMD>Glance definitions<CR>", opts)
  keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
  -- Go to type definition
  keymap.set("n", "gt", "<CMD>Glance type_definitions<CR>", opts)
  keymap.set("n", "gy", "<CMD>:Lspsaga goto_type_definition<CR>", opts)

  keymap.set("n", "gi", "<CMD>Lspsaga finder imp<CR>", opts)

  keymap.set("n", "<leader>s", "<cmd>Lspsaga code_action<CR>", opts)            -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)                -- smart rename

  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics <CR>", opts) -- show  diagnostics for line
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

  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  keymap.set("n", "<A-a>", "<cmd>Lspsaga hover_doc<CR>", opts)  -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  keymap.set("n", "<leader>f", "<cmd>GuardFmt<CR>", opts)

  vim.keymap.set({ "i" }, "<c-d>", function()
    if not require("noice.lsp").scroll(4) then
      return "<c-d>"
    end
  end, opts)

  vim.keymap.set({ "i" }, "<c-u>", function()
    if not require("noice.lsp").scroll(-4) then
      return "<c-u>"
    end
  end, opts)

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>", opts)    -- rename file and update imports
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", opts) -- organize imports (not in youtube nvim video)
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>", opts)  -- remove unused variables (not in youtube nvim video)
  end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

capabilities.textDocument.completion.completionItem.snippetSupport = true

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

for index, value in ipairs(language) do
  require("lsp.language." .. value).setup(lspconfig, capabilities, on_attach)
end

-- configure cpp clangd
lspconfig["clangd"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
  settings = {
    clangd = {
      arguments = {},
    },
  },
})

lspconfig["awk_ls"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
})

-- configure html server
lspconfig["html"].setup({
  capabilities = default_capabilities,
  on_attach = function(client, bufnr)
    if client ~= nil then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
    end
    on_attach(client, bufnr)
  end,
  init_options = {
    provideFormatter = false,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
  settings = {
    html = {
      format = {
        enable = false,
      },
    },
  },
})

lspconfig.tailwindcss.setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
})

lspconfig["cssls"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
})

lspconfig["lemminx"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-- sh-lsp
-- bash-lsp
lspconfig["bashls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["taplo"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["ruby_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["volar"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["dartls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig.typst_lsp.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

M.on_attach = on_attach
M.capabilities = capabilities
M.lspconfig = lspconfig
M.default_capabilities = default_capabilities

vim.cmd("command! -nargs=0 OpenInGoogle !google-chrome-stable  --new-window % &;")
vim.cmd("command! -nargs=0 OpenThunar !thunar % &;")

return M
