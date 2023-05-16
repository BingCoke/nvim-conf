local M = {
  last_args = {},
  config = {},
}
local dap = require("dap")
local select = require("my.select")

local daputil = require("dap.dap-utils")

local notify = require("my.notify")
local lautils = require("language.utils")

local Job = require("plenary.job")
local function contains(list, item)
  for _, val in ipairs(list) do
    if item == val then
      return true
    end
  end
  return false
end

local function debug(args)
  Job
      :new({
        command = "cargo",
        args = args.cargoArgs,
        cwd = args.workspaceRoot,
        on_exit = function(j, code)
          if code and code > 0 then
            notify.create_notify_floating_window(
              { "An error occurred while compiling. Please fix all compilation issues and try again." },
              { timeout = 3000 }
            )
            return
          end

          vim.schedule(function()
            local executables = {}

            for _, value in pairs(j:result()) do
              local status, artifact = pcall(function()
                -- code
                return vim.json.decode(value)
              end)

              -- only process artifact if it's valid json object and it is a compiler artifact
              if not status or type(artifact) ~= "table" or artifact.reason ~= "compiler-artifact" then
                goto loop_end
              end

              local is_binary = contains(artifact.target.crate_types, "bin")
              local is_build_script = contains(artifact.target.kind, "custom-build")
              local is_test = ((artifact.profile.test == true) and (artifact.executable ~= nil))
                  or contains(artifact.target.kind, "test")
              -- only add executable to the list if we want a binary debug and it is a binary
              -- or if we want a test debug and it is a test
              if
                  (args.cargoArgs[1] == "build" and is_binary and not is_build_script)
                  or (args.cargoArgs[1] == "test" and is_test)
              then
                table.insert(executables, artifact.executable)
              end

              ::loop_end::
            end

            -- only 1 executable is allowed for debugging - error out if zero or many were found
            if #executables <= 0 then
              notify.create_notify_floating_window({
                "No compilation artifacts found.",
              }, { timeout = 3000 })
              return
            end
            if #executables > 1 then
              notify.create_notify_floating_window({
                "Multiple compilation artifacts are not supported.",
              }, { timeout = 3000 })
              return
            end

            if #args.executableArgs == 0 then
              args.executableArgs = M.exec_args
            end

            M.last_args = args

            -- create debug configuration
            local dap_config = {
              name = "debug cur",
              type = "codelldb",
              request = "launch",
              program = executables[1],
              args = function()
                return args.executableArgs or daputil.str2arglist(daputil.arg)
              end,
              cwd = args.workspaceRoot,
              stopOnEntry = false,

              runInTerminal = false,
            }
            -- start debugging
            dap.run(dap_config)
          end)
        end,
      })
      :start()
end

local function debug_cur()
  lautils.debug(function(args)
    debug(args)
  end)
end

local function build()
  table.insert(M.config, {
    name = " Debug Cur",
    fn = function()
      debug_cur()
    end,
  })

  table.insert(M.config, {
    name = " Debug Last",
    fn = function(opt)
      debug(M.last_args)
    end,
  })
end

local function scheduled_error(err)
  vim.schedule(function()
    vim.notify(err, vim.log.levels.ERROR)
  end)
end

M.setup = function()
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }
  build()
end

M.run = function()
  local opt = {}
  opt.title = { { "rust select", "TitleString" } }

  select.get_user_selection(M.config, opt)
end

return M
