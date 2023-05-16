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
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder = {
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
    on_insert = false,
    on_insert_follow = false,
    insert_winblend = 0,
    show_code_action = false,
    show_source = true,
    jump_num_shortcut = true,
    max_width = 0.7,
    max_height = 0.6,
    max_show_width = 0.9,
    max_show_height = 0.6,
    text_hl_follow = true,
    border_follow = true,
    extend_relatedInformation = false,
    keys = {
      exec_action = "o",
      quit = { "q" },
      expand_or_jump = "<CR>",
      quit_in_show = { "q", "<ESC>" },
    },
  },
})
