local M = {}
local keymap = vim.keymap -- for conciseness
-- {
--[[ "name": "my_app",
            "request": "launch",
            "type": "dart"
        },
        {
            "name": "my_app (profile mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "profile"
        },
        {
            "name": "my_app (release mode)",
            "request": "launch",
            "type": "dart",
            "flutterMode": "release"
        } ]]

function M.setup(lspconfig, capabilities, on_attach)
  require("flutter-tools").setup({
    ui = {
      notification_style = "plugin",
    },
    lsp = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
    debugger = {
      enabled = true,
      run_via_dap = true,
      register_configurations = function(paths)
        require("dap").configurations.dart = {}
        require("dap.ext.vscode").load_launchjs()
      end,
    },
  })
end

return M
