
local nu_shell_options = {
  shell = "nu",
  shellcmdflag = "--login --stdin --no-newline -c",
  shellpipe = "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record",
  shellquote = "",
  shellredir = "out+err> %s",
  shelltemp = false,
  shellxescape = "",
  shellxquote = "",
}

if vim.fn.executable("nu") == 1 then
  for k, v in pairs(nu_shell_options) do
    vim.opt[k] = v
  end
end
