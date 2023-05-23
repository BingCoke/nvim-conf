local M = {}

local function process_input(fn)
  return function()
    local input = vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]
    -- 关闭输入框窗口
    vim.api.nvim_win_close(0, true)

    if fn ~= nil then
      fn(input)
    end
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
  end
end

local function create_input_box(opt)
  -- 设置边框字符
  local border_chars = {
    { "╭" },
    { "─" },
    { "╮" },
    { "│" },
    { "╯" },
    { "─" },
    { "╰" },
    { "│" },
  }

  -- 创建空白缓冲区
  local buf = vim.api.nvim_create_buf(false, true)

  -- 获取当前窗口的尺寸
  local win_width = vim.api.nvim_win_get_width(0)
  local win_height = vim.api.nvim_win_get_height(0)

  -- 计算输入框位置
  local input_width = 40
  local input_height = 1
  local row = math.floor((win_height - input_height) / 2)
  local col = math.floor((win_width - input_width) / 2)

  if opt.title == nil then
    opt.title = { { "input", "TitleString" } }
  end

  -- 创建边框窗口
  local border_win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = 40,
    height = 1,
    row = row,
    col = col,
    style = "minimal",
    border = border_chars,
    title = opt.title,
    title_pos = "center",
  })

  -- 切换到边框窗口的缓冲区
  vim.api.nvim_set_current_buf(buf)

  -- 返回边框窗口的句柄和缓冲区，以便后续使用
  return border_win, buf
end

local function get_user_input(opt)
  if opt == nil then
    opt = {}
  end

  -- 创建输入框
  local input_box_win, input_box_buf = create_input_box(opt)

  -- 注册回车按键事件
  vim.keymap.set("i", "<CR>", process_input(opt.fn), { buffer = input_box_buf })
  vim.keymap.set("n", "<CR>", process_input(opt.fn), { nowait = true, silent = true, buffer = input_box_buf })

  vim.api.nvim_buf_set_keymap(
    input_box_buf,
    "n",
    "<ESC>",
    "<Esc>:lua vim.api.nvim_win_close(0, true)<CR>",
    { nowait = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    input_box_buf,
    "n",
    "<c-c>",
    "<Esc>:lua vim.api.nvim_win_close(0, true)<CR>",
    { nowait = true, silent = true }
  )

  vim.api.nvim_buf_set_keymap(
    input_box_buf,
    "n",
    "q",
    "<Esc>:lua vim.api.nvim_win_close(0, true)<CR>",
    { nowait = true, silent = true }
  )

  local cmp = require("cmp")
  cmp.setup.buffer({
    sources = {
      { name = "vsnip" },
      { name = "buffer" }, -- text within current buffer
      { name = "path" }, -- file system paths
    },
  })

  -- 进入插入模式
  vim.api.nvim_command("startinsert!")
end

M.process_input = process_input
M.get_user_input = get_user_input

return M
