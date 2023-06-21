require("lspsaga").setup({
  ui = {
    -- 用这些 kind 字体不支持
    -- 看这里跟着改
    -- https://github.com/nvimdev/lspsaga.nvim/blob/main/lua/lspsaga/lspkind.lua
    kind = {
      ["Number"] = { " ", "Number" },
      ["Function"] = { " ", "Function" },
      ["Unit"] = { " ", "Number" },
      ["String"] = { " ", "String" },
      ["Array"] = { " ", "Type" },
      ["Null"] = { " ", "Constant" },
      ["Text"] = { " ", "String" },
    },
  },
  scroll_preview = {
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
  lightbulb = {
    enable = false,
  },
  finder = {
    max_height = 0.5,
    min_width = 30,
    force_max_height = false,
    keys = {
      jump_to = "p",
      expand_or_jump = "o",
      vsplit = "s",
      split = "i",
      tabe = "t",
      tabnew = "<CR>",
      quit = { "q", "<ESC>" },
      close_in_preview = "<ESC>",
    },
  },
  diagnostic = {
    show_code_action = false,
    --show_source = true,
    --jump_num_shortcut = true,
    keys = {
      exec_action = "o",
      quit = "q",
      expand_or_jump = "<CR>",
      quit_in_show = { "q", "<ESC>" },
    },
  },
})
