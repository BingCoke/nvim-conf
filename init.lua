  -- sel
-- 常规
require('basic')
-- 快捷键映射
require('keybindings')

--require('lsp.saga-keybinding')
-- 插件设置
require('plugins')

vim.g.hlchunk_files = '*.ts,*.js,*.json,*.go,*.c,*.cpp,*.rs,*.h,*.hpp,*.lua,*.py'

local api = vim.api
local function generate_highlight()
  api.nvim_command("highlight! CmpItemMenu ctermbg=237 guibg=#576486")
  -- gray
  api.nvim_command("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
  -- blue
  api.nvim_command("highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6")
  api.nvim_command("highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch")
  -- light blue
  api.nvim_command("highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE")
  api.nvim_command("highlight! link CmpItemKindInterface CmpItemKindVariable")
  api.nvim_command("highlight! link CmpItemKindText CmpItemKindVariable")
  -- pink
  api.nvim_command("highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0")
  api.nvim_command("highlight! link CmpItemKindMethod CmpItemKindFunction")
  -- front
  api.nvim_command("highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4")
  api.nvim_command("highlight! link CmpItemKindProperty CmpItemKindKeyword")
  api.nvim_command("highlight! link CmpItemKindUnit CmpItemKindKeyword")
end
generate_highlight()
