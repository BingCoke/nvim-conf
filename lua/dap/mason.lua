
local status, mason = pcall(require, "mason")
if not status then
 vim.notify("没有找到 mason")
 return
end
--[[ local status, mason_config = pcall(require, "mason-lspconfig")
if not status then
 vim.notify("没有找到 mason-lspconfig")
 return
end

local statusconfig, lspconfig = pcall(require, "lspconfig")
if not statusconfig then
 vim.notify("没有找到 lspconfig")
 return
end ]]

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
