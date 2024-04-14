local rest = require("rest-nvim")
local state = require("telescope.actions.state")
local conf = require("telescope.config").values
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

rest.setup({
	-- Skip SSL verification, useful for unknown certificates
	env_file = ".env",
	skip_ssl_verification = false,
	-- Encode URL before making request
	encode_url = true,
	-- Highlight request on run
	highlight = {
		enable = true,
		timeout = 150,
	},
	result = {
		behavior = {

			formatters = {
				json = "jq",
				html = function(body)
					return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
				end,
			},
			show_info = {

			}
		},
		split = {
			horizontal = false,
			stay_in_current_window_after_split = true,
		}
	},
	-- Jump to request line on run
	custom_dynamic_variables = {},
})

--local function getEnvFile(prompt_title, fn)
--	local pattern = "\\.env$"
--	local command = string.format("fd -H '%s'", pattern)
--	local result = io.popen(command):read("*a")
--	-- 初始化一个空表
--	local lines = {}
--
--	-- 分割成行并保存到表中
--	for line in result:gmatch("[^\r\n]+") do
--		table.insert(lines, line)
--	end
--
--	pickers
--		.new({}, {
--			prompt_title = prompt_title,
--			finder = finders.new_table({
--				results = lines,
--			}),
--			attach_mappings = function(prompt_bufnr, map)
--				actions.select_default:replace(function()
--					local selection = action_state.get_selected_entry()
--					actions.close(prompt_bufnr)
--					if selection == nil then
--						return
--					end
--
--					fn(selection[1])
--				end)
--				map("i", "<c-o>", function()
--					local selection = state.get_selected_entry(prompt_bufnr)
--					actions.close(prompt_bufnr)
--					if selection == nil then
--						return
--					end
--					vim.api.nvim_command("tabedit " .. selection[1])
--				end)
--				return true
--			end,
--			previewer = conf.grep_previewer({}),
--		})
--		:find()
--end
--
vim.api.nvim_create_autocmd({
	"FileType",
}, {

	--group = vim.api.nvim_create_augroup("httpFile", { clear = true }),
	callback = function()
		local current_filetype = vim.bo.filetype
		if current_filetype ~= "http" then
			return
		end

		local buf = vim.api.nvim_get_current_buf()
		local opt = { noremap = true, silent = true, buffer = buf }
		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<F5>", "<cmd>lua require('rest-nvim').run()<cr>", opt)
		keymap.set("n", "<F6>", "<cmd>lua require('rest-nvim').last()<cr>", opt)
		keymap.set("n", "<F7>", function()
			require("telescope").extensions.rest.select_env()
			--getEnvFile("Select Env", function(file)
			--	rest.select_env(file)
			--end)
		end, opt)
	end,
})
