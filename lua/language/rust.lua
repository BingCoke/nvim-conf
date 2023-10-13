local M = {}
function M.setup()
  --local lsp_conf = require("lsp.lsp")
  -- import rust-tools plugin safely
  --local rust_setup, rt = pcall(require, "rust-tools")

end



local lldb_path = "/usr/lib/codelldb/"

-- The liblldb extension is .so for linux and .dylib for macOS
--[[ rt.setup({
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    capabilities = lsp_conf.default_capabilities,
  },
  server = {
    --capabilities = lsp_conf.default_capabilities,
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      lsp_conf.on_attach(client, bufnr)
      vim.keymap.set("n", "<leader>-", function()
          local opt = {
            title = { { "input args", "TitleString" } },
            ---@diagnostic disable-next-line: redefined-local
            fn = function(input)
              rt_dap.exec_args = dapuil.str2arglist(input)
            end,
          }
          inputuils.get_user_input(opt)
      end,opts)
      -- Hover actions
      vim.keymap.set("n", "<F9>", rt.hover_actions.hover_actions, opts)
    end,
  },
  tools = {
    hover_actions = {
      auto_focus = true,
    },
    inlay_hints = {
      auto = true,
    },
  },
  open = {
  },
}) ]]
return M
