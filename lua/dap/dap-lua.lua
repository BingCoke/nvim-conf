local M = {}
M.config = {}
local dap = require("dap")
local daputil = require("dap.dap-utils")
local select = require("my.select")

local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")

local build = function()
  table.insert(M.config, {
    name = " Debug",
    fn = function(opt)
      dap.run({
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
        cwd = opt.word_dir,
        host = function()
          local value = vim.fn.input("Host [127.0.0.1]: ")
          if value ~= "" then
            return value
          end
          return "127.0.0.1"
        end,
        port = function()
          local val = tonumber(vim.fn.input("Port: "))
          assert(val, "Please provide a port number")
          return val
        end,
      })
    end,
  })
end

M.setup = function()
  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host, port = config.port })
  end

  build()
end

M.run = function()
  local opt = daputil.build_dap_runner_opt({ cur_fun = false })

  opt.title = { { "lua select", "TitleString" } }
  select.get_user_selection(M.config, opt)
end
return M
