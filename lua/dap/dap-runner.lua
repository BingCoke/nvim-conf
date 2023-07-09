local M = {}

M.config = {}
M.run = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  print(filetype)
  if M.config[filetype] == nil then
    require("my.notify").create_notify_floating_window({filetype .. " is not found for debug"})
  else
    M.config[filetype].run()
  end
end

-- dap-go
local dap_go = require("dap.dap-go")
dap_go.setup()
M.config.go = dap_go

-- dap-python
local dap_py = require("dap.dap-python")
dap_py.setup()
M.config.python = dap_py

-- dap-rust
local dap_rs = require("dap.dap-rs")
dap_rs.setup()
M.config.rust = dap_rs

local dap_ts = require("dap.dap-ts")
dap_ts.setup()

M.config.ts = dap_ts

return M
