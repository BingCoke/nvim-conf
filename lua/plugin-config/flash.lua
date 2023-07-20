local map = vim.keymap.set



-- 复用 opt 参数
local opt = { noremap = true, silent = true }
local flash = require("flash")
flash.setup({
  search = {
    filetype_exclude = { "notify", "noice", "cmp_menu", "neo-tree", "popup-menu", "Pmenu", "pmenu" },
  },
  label = {
    -- add a label for the first match in the current window.
    -- you can always jump to the  for first match for with `<CR>`
    current = true,
    -- show the label after the match
    after = false, ---@type boolean|number[]
    -- show the label before the match
    before = true, ---@type boolean|number[]
    -- position of the label extmark
    style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
    -- flash tries to re-use labels that were already assigned to a position,
    -- when typing more characters. By default only lower-case labels are re-used.
    reuse = "lowercase", ---@type "lowercase" | "all"
  },
  highlight = {
    -- show a backdrop with hl FlashBackdrop
    backdrop = true,
    -- Highlight the search matches
    matches = true,
    -- extmark priority
    priority = 5000,
    groups = {
      match = "FlashMatch",
      current = "FlashCurrent",
      backdrop = "FlashBackdrop",
      label = "FlashLabel",
    },
  },
  modes = {
    search = {
      enabled = true,
    },
    char = {
      keys = { "f", "F", "t", "T", ";", "," },
      highlight = {
        backdrop = true,
        label = { before = false, after = false },
      },
    },
  },
})
map("n", "q", function()
  require("flash").jump()
end, opt)
map("n", "S", function()
  require("flash").treesitter()
end, opt)
