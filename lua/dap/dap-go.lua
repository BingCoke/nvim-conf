local M = {
	last_testname = "",
	last_testpath = "",
	config = {},
}

local dap = require("dap")

local select = require("my.select")
local daputil = require("dap.dap-utils")

local function build()
	M.config = {}
	table.insert(M.config, {
		name = " Debug",
		fn = function(opt)
			local file = opt.file
			local dir = opt.dir

			print(file)
			dap.run({
				type = "delve",
				name = "Debug",
				request = "launch",
				program = dir,
				args = function()
					return daputil.str2arglist(daputil.arg)
				end,
			})
		end,
	})

	table.insert(M.config, {
		name = " Debug cur test",
		fn = function(opt)
			if opt.cur_fun == "" then
				vim.notify("no test found")
				return
			end

			M.last_testpath = opt.path
			M.last_testname = opt.cur_fun

			dap.run({
				type = "delve",
				name = opt.cur_fun,
				request = "launch",
				mode = "test",
				program = opt.path,
				args = { "-test.run", opt.cur_fun },
			})
		end,
	})

	table.insert(M.config, {
		name = " Debug last test",
		fn = function(_)
			if M.last_testname == "" then
				vim.notify("no last test found")
				return
			end

			dap.run({
				type = "delve",
				name = M.last_testname,
				request = "launch",
				mode = "test",
				program = M.last_testpath,
				args = { "-test.run", M.last_testname },
			})
		end,
	})

	table.insert(M.config, {
		name = " Debug test",
		fn = function(opt)
			local file = opt.file
			local dir = opt.dir
			dap.run({
				type = "delve",
				name = "Debug test", -- configuration for debugging test files
				request = "launch",
				mode = "test",
				program = dir,
				args = function()
					return daputil.str2arglist(daputil.arg)
				end,
			})
		end,
	})

	table.insert(M.config, {
		name = " Debug test (go.mod)",
		fn = function(opt)
			local work_dir = opt.work_dir
			dap.run({
				type = "delve",
				name = "Debug test (go.mod)",
				request = "launch",
				mode = "test",
				program = work_dir,
				args = function()
					return daputil.str2arglist(daputil.arg)
				end,
			})
		end,
	})


end

M.setup = function()
	-- go-dap
	-- delve
	dap.adapters.delve = {
		type = "server",
		port = "${port}",
		executable = {
			command = "dlv",
			args = { "dap", "-l", "127.0.0.1:${port}" },
		},
	}
	dap.adapters.go = {
		type = "executable",
		command = "node",
		args = { os.getenv("HOME") .. "/.local/share/nvim/lazy/vscode-go/extension/dist/debugAdapter.js" },
	}

	build()
end

M.run = function()
	local opt = daputil.build_dap_runner_opt()

	opt.title = { { "go select", "TitleString" } }
	select.get_user_selection(M.config, opt)
end

return M
