
local M = {}
-- create floating window
-- content = {"str1","str2"}
-- opt = {
--  title =  { { "title", "TitleString" } }
--  title_pos = "center"
--  col = vim.api.nvim_win_get_width(0) - width - 1
--  row =  vim.api.nvim_win_get_height(0) - height - 1
--  timeout = 1000
-- }
-- 通知
function M.create_notify_floating_window(content, opt)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local height = #content + 2

  local maxLen = 0

  for _, str in ipairs(content) do
    local len = string.len(str)
    if len > maxLen then
      maxLen = len
    end
  end

  local width = maxLen
  local default_opt = {
    col = vim.api.nvim_win_get_width(0) - width - 1,
    row = vim.api.nvim_win_get_height(0) - height - 1,
    width = width,
    height = height,
    timeout = 1000,
    title = { { "notify", "TitleString" } },
  }
  opt = vim.tbl_deep_extend("force", {}, default_opt, opt or {})

  local win_opts = {
    relative = "editor",
    width = opt.width,
    height = opt.height,
    col = opt.col,
    row = opt.row,
    style = "minimal",
    border = "single",
    title = opt.title,
  }

  win_opts.title_pos = opt.title_pos or "center"

  local winnr = vim.api.nvim_open_win(bufnr, false, win_opts)

  vim.api.nvim_buf_set_option(bufnr, "modifiable", true)
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, content)
  vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

  -- autoclose
  vim.defer_fn(function()
    vim.api.nvim_win_close(winnr, true)
  end, opt.timeout)
end

return M
