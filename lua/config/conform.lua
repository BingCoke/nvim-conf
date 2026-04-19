local conform = require("conform")
local util = require("conform.util")

local biomeLint = {
  command = util.from_node_modules("biome"),
  stdin = false,
  cwd = require("conform.util").root_file({ "biome.json" }),
  require_cwd = true,
  args = { "lint", "--apply", "$FILENAME" },
}

local esLint = {
  command = util.from_node_modules("eslint"),
  stdin = false,
  args = { "--fix", "$FILENAME" },
}

conform.setup({
  formatters = {
    esLint = esLint,
    biomeLint = biomeLint,
    biome = {
      cwd = require("conform.util").root_file({ "biome.json" }),
      require_cwd = true,
    },
    prettier_d = require("formatters.prettierd"),
  },
  formatters_by_ft = {
    javascript = { "prettier_d", "biome", lsp_format = "fallback", stop_after_first = true },
    javascriptreact = { "prettier_d", "biome", stop_after_first = true },
    typescript = { "prettier_d", lsp_format = "fallback", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", lsp_format = "fallback", stop_after_first = true },
    svelte = { "prettier_d", lsp_format = "fallback", stop_after_first = true },
    vue = { "prettierd" },
    xml = { "xmlformatter" },
    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd", lsp_format = "fallcack" },
    json = { "biome", "prettierd" },
    jsonc = { "biome", "prettierd" },
    lua = { "stylua" },
    python = { "black" },
    yaml = { "yamlfmt" },
    shell = { "shfmt" },
    rust = { "rustfmt" },
    go = { "gofmt" },

    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "codespell" },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  conform.format({
    lsp_format = "fallback",
    timeout_ms = 1000,
    async = true,
  })
end)
