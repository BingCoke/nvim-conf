local conf = {
  inlay_hints = {
    parameter_hints = {
      prefix = " ",
    },
    type_hints = {
      prefix = " ",
    },
  },
  --debug_mode = true,
}

require("lsp-inlayhints").setup(conf)


vim.cmd("hi LspInlayHint guifg=#7aa2f7 guibg=#3b4261")
