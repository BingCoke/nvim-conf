-- sel
-- 常规
vim.loader.enable()
require("basic")
-- 快捷键映射
require("keybindings")

--require('lsp.saga-keybinding')
-- 插件设置
require("plugins")

vim.g.hlchunk_files = "*.ts,*.js,*.json,*.go,*.c,*.cpp,*.rs,*.h,*.hpp,*.lua,*.py"

--require("language.utils").setup()
--vim

