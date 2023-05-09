local M = {}

M.cmd = vim.api.nvim_command
-- toggleFT func: 存在对应名称的窗口则toggle，否则新建
M.toggleFT = function(name, cmd)
  if vim.fn['floaterm#terminal#get_bufnr'](name) ~= -1 then
    vim.api.nvim_command(string.format('exec "FloatermToggle %s"', name))
  else
    vim.api.nvim_command(string.format('FloatermNew --name=%s %s', name, cmd))
  end
end

local function mmap(maps)
  for _, map in pairs(maps) do
    if map[4]["buffer"] then
      map[4]["buffer"] = nil
      vim.api.nvim_buf_set_keymap(0, map[1], map[2], map[3], map[4])
    else
      vim.api.nvim_set_keymap(map[1], map[2], map[3], map[4])
    end
  end
end

-- 用于快速设定floatterm的相关map
function M.setFTToggleMap(key, name, cmd)
  mmap({
    { 'n', key, string.format(":lua require('plugin-config.fterm').toggleFT('%s', '%s')<cr>", name, cmd),                                                                                 { silent = true, noremap = true } },
    { 't', key, "&ft == \"floaterm\" ? printf('<c-\\><c-n>:FloatermHide<cr>%s', floaterm#terminal#get_bufnr('" .. name .. "') == bufnr('%') ? '' : '" .. key .. "') : '" .. key .. "'", { silent = true, expr = true } },
  })
end



-- 特殊func 定义了F5行为时根据当前文件类型调用不同的命令
function M.runFile()
  M.cmd('w')
  local ft = vim.api.nvim_eval('&ft')
  local run_cmd = {
    javascript = 'node',
    typescript = 'ts-node',
    html = 'google-chrome-stable',
    python = 'python',
    go = 'go run main.go',
    sh = 'bash',
    lua = 'lua',
    rust = 'cargo run'
  }
  if run_cmd[ft] then
    M.toggleFT('RUN', run_cmd[ft] .. ' %')
  elseif ft == 'markdown' then
    M.cmd('MarkdownPreview')
  elseif ft == 'java' then
    M.toggleFT('RUN', 'javac % && java %<')
  elseif ft == 'c' then
    M.toggleFT('RUN', 'gcc % -o %< && ./%< && rm %<')
  end
end

function M.config()
  vim.g.floaterm_title = ''
  vim.g.floaterm_width = 0.8
  vim.g.floaterm_height = 0.8
  vim.g.floaterm_autoclose = 0
  vim.g.floaterm_opener = 'edit'
  --M.cmd( vim "au BufEnter * if &buftype == 'terminal' | :call timer_start(50, { -> execute('startinsert!') }, { 'repeat': 3 }) | endif")
  --M.cmd("hi FloatermBorder ctermfg=fg ctermbg=none")

  M.setFTToggleMap('<a-t>', 'TERM', '')
  M.setFTToggleMap('<a-f>', 'RANGER', 'ranger')
  mmap({
    { 'n', '<a-r>', ':lua require("plugin-config.fterm").runFile()<cr>',                                                                                         { silent = true, noremap = true } },
    { 'i', '<a-r>', '<esc>:lua require("plugin-config.fterm").runFile()<cr>',                                                                                    { silent = true, noremap = true } },
    { 't', '<a-r>', "&ft == \"floaterm\" ? printf('<c-\\><c-n>:FloatermHide<cr>%s', floaterm#terminal#get_bufnr('RUN') == bufnr('%') ? '' : '<a-r>') : '<a-r>'", { silent = true, expr = true } }
  })
end

function M.setup()
  -- do nothing
end

return M
