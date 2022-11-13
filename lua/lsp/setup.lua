local status, mason = pcall(require, "mason")
if not status then
 vim.notify("没有找到 mason")
 return
end
local status, mason_config = pcall(require, "mason-lspconfig")
if not status then
 vim.notify("没有找到 mason-lspconfig")
 return
end

local statusconfig, lspconfig = pcall(require, "lspconfig")
if not statusconfig then
 vim.notify("没有找到 lspconfig")
 return
end

-- :h mason-default-settings
mason.setup({
 ui = {
  icons = {
    package_installed = "✓",
    package_pending = "➜",
    package_uninstalled = "✗",
  },
 },
})
-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require("mason-lspconfig").setup({
 -- 确保安装，根据需要填写
 ensure_installed = {
  "sumneko_lua",
  "tsserver",
 --  "tailwindcss",
  "bashls",
  "cssls",
 "dockerls",
  "emmet_ls",
  "html",
  "jsonls",
  "volar",
 -- "jdtls",
  --  "pyright",
  --  "rust_analyzer",
 --  "taplo",
  "yamlls",
  "gopls",
 },
})

-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
 --lua-language-server
 bashls = require("lsp.config.bash"),
 sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
 html = require("lsp.config.html"),
 --jdtls = require("lsp.config.java"),
  -- quick_lint_js = require("lsp.config.js"),
 denols = require("lsp.config.js"),
 volar = require("lsp.config.vue"),
 emmet_ls = require('lsp.config.emmet'),
 gopls = require("lsp.config.go"),
 cssls = require("lsp.config.css"),
 jsonls = require('lsp.config.json'),
 tsserver = require("lsp.config.ts"),
}
for name, config in pairs(servers) do
 if config ~= nil and type(config) == "table" then
  -- 自定义初始化配置文件必须实现on_setup 方法
  config.on_setup(lspconfig[name])
 else
  -- 使用默认参数
  lspconfig[name].setup({})
 end
end
