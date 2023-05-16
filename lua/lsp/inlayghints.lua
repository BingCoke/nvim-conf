local conf = {
  inlay_hints = {
    parameter_hints = {
      prefix = " ",
    },
    type_hints = {
      prefix = " ",
    },
  },
}

local lsp_inlayhints = require("lsp-inlayhints").setup(conf)

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})

vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end
    local bufnf = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("lsp-inlayhints").on_attach(client, bufnf)
  end,
})
vim.cmd("hi LspInlayHint guifg=#7aa2f7 guibg=#3b4261")
