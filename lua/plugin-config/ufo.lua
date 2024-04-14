--vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "s", "")
vim.keymap.set("n", "sc", ":foldclose<CR>")
vim.keymap.set("n", "sv", ":foldopen<CR>")
vim.keymap.set("n", "sR", require("ufo").openAllFolds)
vim.keymap.set("n", "sR", require("ufo").openAllFolds)
vim.keymap.set("n", "sM", require("ufo").closeAllFolds)
vim.keymap.set("n", "sr", require("ufo").openFoldsExceptKinds)
vim.keymap.set("n", "sm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

vim.keymap.set("n", "sk", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    -- choose one of coc.nvim and nvim lsp
    vim.lsp.buf.hover()
  end
end)

local config = {
  open_fold_hl_timeout = 150,
  close_fold_kinds_for_ft = {
    default = { "imports", "comment" }
  },
  preview = {
    win_config = {
      border = { "", "─", "", "", "", "─", "", "" },
      winhighlight = "Normal:Folded",
      winblend = 0,
    },
    mappings = {
      scrollU = "<C-u>",
      scrollD = "<C-d>",
      jumpTop = "[",
      jumpBot = "]",
    },
  }
}

require("ufo").setup(config)
