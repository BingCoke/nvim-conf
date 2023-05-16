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
			local file = opt.file
			dap.run({
				type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
				request = "launch",
				name = "Python: Launch file",
				program = file, -- This configuration will launch the current file if used.
				args = function()
					return daputil.str2argtable(daputil.arg)
				end,
				pythonPath = venv_path and (venv_path .. "/bin/python") or nil,
			})
		end,
	})
end

M.setup = function()
	dap.adapters.python = {
		type = "executable",
		command = "/usr/bin/python3",
		args = {
			"-m",
			"debugpy.adapter",
		},
	}

	build()
end

M.run = function()
	local opt = daputil.build_dap_runner_opt()

	opt.title = { { "python select", "TitleString" } }
	select.get_user_selection(M.config, opt)
end
return M
