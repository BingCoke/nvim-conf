local M = {
  is = true,
}
local status_ok, dapui = pcall(require, "dapui")
if not status_ok then
  vim.notify("dapui not found")
  return
end

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "o", "<2-LeftMouse>", "<CR>" },
    open = "O",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

-- 这里一定要先配置好dap
local dap = require("dap")

local debug_open = function()
  dapui.open()
  vim.api.nvim_command("DapVirtualTextEnable")
end
local debug_close = function()
  dap.repl.close()
  vim.api.nvim_command("DapVirtualTextDisable")
  -- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  if M.is then
    debug_open()
    M.is = false
  end

end
dap.listeners.before.event_terminated["dapui_config"] = function()
  --debug_close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  debug_close()
end
dap.listeners.before.disconnect["dapui_config"] = function()
  debug_close()
end

return M
