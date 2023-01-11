-- 常规
require('basic')

-- 快捷键映射

require('keybindings')

--require('lsp.saga-keybinding')
-- 插件设置
require('plugins')
-- 主题配置
require('colorscheme')
-- 插件配置S
-- 设置文件列表
require("plugin-config.nvim-tree")
-- 设置标签页
require("plugin-config.bufferline")
-- 设置底部状态栏
require("plugin-config.lualine")
-- 搜索
require("plugin-config.telescope")
-- 启动页面
require("plugin-config.dashboard")
-- project
require("plugin-config.project")
-- 代码高亮
require("plugin-config.nvim-treesitter")
-- lsp

--require("lsp.setup")
--require("lsp.cmp")
--require("lsp.ui")
require("coc.coc-basic")
require("coc.coc-need")
--require("lsp.null-ls")
-- dap debug
-- require("dap.mason")
-- require("dap.dap-require")
-- require("dap.dap-ui")
-- require("dap.dap-text")
-- autotag 智能标签	
require("plugin-config.aotutag")
-- 注释
require("plugin-config.coment")
-- pairs

require("plugin-config.auto-pairs")
-- translate
require('plugin-config.translate')
-- require("plugin-config.easymotion")

require("plugin-config.leap-conf")
-- 设置 tmux关闭
-- os.execute("tmux set status off")
require("plugin-config.ranger")

require("plugin-config.vimspector")

