-- 如果找不到lualine 组件，就不继续执行
-- 设置tmux的时候不显示状态栏
-- local r = os.getenv("TMUX");
--[[ 
if r == nil then
  -- vim.o.laststatus = 2
  vim.o.laststatus = 0
  vim.o.cmdheight = 1
  vim.o.showmode = true
  return
else
  vim.o.laststatus = 0
  vim.o.cmdheight = 1
  vim.o.showmode = true
  return
end
 ]]


local status, lualine = pcall(require, "lualine")
if not status then
  vim.notify("没有找到 lualine")
  return
end

lualine.setup({
  options = {
    theme = "nightfly",
    component_separators = { left = "|", right = "|" },
    -- https://github.com/ryanoasis/powerline-extra-symbols
    section_separators = { left = " ", right = "" },
    globalstatus = false,
  },
  extensions = { "nvim-tree", "toggleterm" },
  sections = {
    lualine_c = {
      "filename",
      {
        "lsp_progress",
        spinner_symbols = { " ", " ", " ", " ", " ", " " },
      },
    },
    lualine_x = {
      "filesize",
      {
        "fileformat",
        symbols = {
          unix = '', -- e712
          dos = '', -- e70f
          mac = '', -- e711
        },
        --        symbols = {
        --          unix = "LF",
        --          dos = "CRLF",
        --          mac = "CR",
        --        },
      },
      "encoding",
      "filetype",
    },
  },
})
