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
  require("lsp-inlayhints").on_attach(client, bufnr)
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
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()()<CR>", opts)    -- go to implementation

  keymap.set("n", "<leader>s", "<cmd>Lspsaga code_action<CR>", opts)            -- see available code actions
  --keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)           -- see available code actions
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

--[[ lspconfig["yamlls"].setup({
  capabilities = default_capabilities,
  on_attach = on_attach,
}) ]]
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

lspconfig["awk_ls"].setup({
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

local rs_cap = require("cmp_nvim_lsp").default_capabilities()


rs_cap.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

rs_cap.textDocument.completion.completionItem.snippetSupport = true

rs_cap.experimental = {}
rs_cap.experimental.hoverActions = true
rs_cap.experimental.hoverRange = true
rs_cap.experimental.codeActionGroup = true
rs_cap.experimental.serverStatusNotification = true
rs_cap.experimental.ssr = true

--[[ rs_cap.experimental.commands = {
  commands = {
    "rust-analyzer.runSingle",
    "rust-analyzer.debugSingle",
    "rust-analyzer.showReferences",
    "rust-analyzer.gotoLocation",
  },
} ]]
 --[[ rs_cap.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
} ]]

-- rust analyzer goodies
--
local function get_workspace_dir(cmd)
  local co = assert(coroutine.running())

  local stdout = {}
  local stderr = {}
  local jobid = vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      data = table.concat(data, "\n")
      if #data > 0 then
        stdout[#stdout + 1] = data
      end
    end,
    on_stderr = function(_, data, _)
      stderr[#stderr + 1] = table.concat(data, "\n")
    end,
    on_exit = function()
      coroutine.resume(co)
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })

  if jobid <= 0 then
    vim.notify(
      ("[lspconfig] cmd (%q) failed:\n%s"):format(table.concat(cmd, " "), table.concat(stderr, "")),
      vim.log.levels.WARN
    )
    return
  end

  coroutine.yield()
  if next(stdout) == nil then
    return nil
  end
  stdout = vim.json.decode(table.concat(stdout, ""))
  return stdout and stdout["workspace_root"] or nil
end

-- 检查文件路径是否在文件夹路径中
local function isPathInFolder(filePath, folderPath)
    -- 使用路径分隔符来确保精确匹配
    filePath = string.gsub(filePath, "\\","/")
    folderPath = string.gsub(folderPath, "\\","/")

    -- 确保文件路径和文件夹路径以斜杠结尾
    if string.sub(filePath, -1) ~= "/" then
        filePath = filePath .. "/"
    end
    if string.sub(folderPath, -1) ~= "/" then
        folderPath = folderPath .. "/"
    end

    -- 使用字符串匹配判断文件路径是否在文件夹路径中
    local matchPattern = "^" .. folderPath .. ".*"
    if string.match(filePath, matchPattern) then
        return true
    else
        return false
    end
end

lspconfig["rust_analyzer"].setup({
  capabilities = rs_cap,
  on_attach = on_attach,
  root_dir = function(fname)
   -- print(fname)
    local cargo_crate_dir = util.root_pattern("Cargo.toml")(fname)
    local cmd = { "cargo", "metadata", "--no-deps", "--format-version", "1" }
    if cargo_crate_dir ~= nil then
      cmd[#cmd + 1] = "--manifest-path"
      cmd[#cmd + 1] = util.path.join(cargo_crate_dir, "Cargo.toml")
    end

    local cargo_workspace_root = get_workspace_dir(cmd)
    --print(cargo_workspace_root)

    if cargo_workspace_root then
      cargo_workspace_root = util.path.sanitize(cargo_workspace_root)
    end
    if isPathInFolder(cargo_workspace_root,"/home/bk/.rustup") or isPathInFolder(cargo_workspace_root,"/home/bk/.cargo") then
      return ""
    end

    return cargo_workspace_root
        or cargo_crate_dir
        or util.root_pattern("rust-project.json")(fname)
        or util.find_git_ancestor(fname)
  end,

  --rust-analyzer.cargo.buildScripts.invocationStrategy
  --rust-analyzer.files.excludeDirs
  settings = {
    ["rust-analyzer"] = {
      files = {
        excludeDirs = {
          "/home/bk/.rustup/**",
          "/home/bk/.cargo/**",
        },
      },
      cargo = {
        allFeatures = true,
      },
      completion = {
        snippets = {
          custom = {
            ["ok"] = {
              ["postfix"] = "ok",
              ["body"] = "Ok(${receiver})",
              ["scope"] = "expr",
            },
            ["Some"] = {
              ["postfix"] = "some",
              ["body"] = "Some(${receiver})",
              ["scope"] = "expr",
            },
          },
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

capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig["pyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = util.root_pattern(unpack(root_files)),
  settings = {
    autoImportCompletion = true,
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
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

lspconfig["marksman"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

lspconfig["taplo"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
M.on_attach = on_attach
M.capabilities = capabilities
M.default_capabilities = default_capabilities

return M
