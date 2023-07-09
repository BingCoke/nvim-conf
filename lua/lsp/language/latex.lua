vim.g.knap_settings = {
  textopdfviewerlaunch = "zathura", --synctex-editor-command 'nvim --headless -es --cmd \"lua require('\"'\"'knaphelper'\"'\"').relayjump('\"'\"'%servername%'\"'\"','\"'\"'%{input}'\"'\"',%{line},0)\"' %outputfile%",
  textopdfviewerrefresh = "none",
  textopdfforwardjump = "zathura", --synctex-forward=%line%:%column%:%srcfile% %outputfile%"
}

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexrun"
