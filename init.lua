-- sel
-- 常规
vim.loader.enable()
require("basic")
-- 快捷键映射
require("keybindings")
-- 插件设置
require("plugins")

require("neovide")
vim.g.hlchunk_files = "*.ts,*.js,*.json,*.go,*.c,*.cpp,*.rs,*.h,*.hpp,*.lua,*.py,*.dart"
