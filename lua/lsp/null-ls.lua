local status, null_ls = pcall(require, "null-ls")
if not status then
  vim.notify("没有找到 null-ls")
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
null_ls.setup({
  debug = false,
  sources = {
    -- Formatting ---------------------
    --  brew install shfmt
    formatting.shfmt,
    -- StyLua
    formatting.stylua,
    -- frontend
    formatting.prettier.with({ -- 只比默认配置少了 markdown
      filetypes = {
        "js",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
        "graphql",
        "nginx",
      },
    }),
    diagnostics_format = "[#{s}] #{m}",
    -- json
    -- npm install -g fixjson
    formatting.fixjson,
  },
--  -- 保存自动格式化
--  on_attach = function(client)
--    if client.resolved_capabilities.document_formatting then
--      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
--    end
--  end,
})
