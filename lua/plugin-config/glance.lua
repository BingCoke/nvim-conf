require("glance").setup({
  -- your configuration
  border = {
    enable = true, -- Show window borders. Only horizontal borders allowed
    top_char = "―",
    bottom_char = "―",
  },
  theme = {       -- This feature might not work properly in nvim-0.7.2
    enable = false, -- Will generate colors for the plugin based on your current colorscheme
    mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
  },
})

vim.cmd("hi GlanceWinBarFilename guibg=#fff")
vim.cmd("hi GlanceWinBarFilepath guibg=#fff")
vim.cmd("hi GlanceWinBarTitle guibg=#fff  guifg=##5084f3")
vim.cmd("hi GlancePreviewMatch guibg=#87abf7 ")
