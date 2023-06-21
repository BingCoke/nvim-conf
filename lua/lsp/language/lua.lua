local M = {}
local keymap = vim.keymap -- for conciseness

function M.setup(lspconfig, capabilities, on_attach)
  -- lua-lsp
  lspconfig["lua_ls"].setup({
    --  capabilities = capabilities,
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
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
        hint = {
          enable = true,
          arrayIndex = "Auto",
          await = true,
          paramName = "All",
          paramType = true,
          semicolon = "SameLine",
          setType = false,
        },
      },
    },
  })
end

return M
