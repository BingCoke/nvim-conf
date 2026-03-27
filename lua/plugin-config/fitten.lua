local fittencode = require("fittencode")
fittencode.setup({
	action = {
		document_code = {
			-- Show "Fitten Code - Document Code" in the editor context menu, when you right-click on the code.
			show_in_editor_context_menu = true,
		},
		edit_code = {
			-- Show "Fitten Code - Edit Code" in the editor context menu, when you right-click on the code.
			show_in_editor_context_menu = true,
		},
		explain_code = {
			-- Show "Fitten Code - Explain Code" in the editor context menu, when you right-click on the code.
			show_in_editor_context_menu = true,
		},
		find_bugs = {
			-- Show "Fitten Code - Find Bugs" in the editor context menu, when you right-click on the code.
			show_in_editor_context_menu = true,
		},
		generate_unit_test = {
			-- Show "Fitten Code - Generate UnitTest" in the editor context menu, when you right-click on the code.
			show_in_editor_context_menu = true,
		},
		start_chat = {
			-- Show "Fitten Code - Start Chat" in the editor context menu, when you right-click on the code.
			show_in_editor_context_menu = true,
		},
		identify_programming_language = {
			-- Identify programming language of the current buffer
			-- * Unnamed buffer
			-- * Buffer without file extension
			-- * Buffer no filetype detected
			identify_buffer = true,
		},
	},
	disable_specific_inline_completion = {
		-- Disable auto-completion for some specific file suffixes by entering them below
		-- For example, `suffixes = {'lua', 'cpp'}`
		--suffixes = { "lua" },
	},
	inline_completion = {
		-- Enable inline code completion.
		---@type boolean
		enable = true,
		-- Disable auto completion when the cursor is within the line.
		---@type boolean
		disable_completion_within_the_line = true,
		-- Disable auto completion when pressing Backspace or Delete.
		---@type boolean
		disable_completion_when_delete = true,
		-- Auto triggering completion
		---@type boolean
		auto_triggering_completion = true,
		-- Accept Mode
		-- Available options:

		accept_mode = "commit",
	},
	delay_completion = {
		-- Delay time for inline completion (in milliseconds).
		---@type integer
		delaytime = 0,
	},
	prompt = {
		-- Maximum number of characters to prompt for completion/chat.
		max_characters = 1000000,
	},
	chat = {
		-- Highlight the conversation in the chat window at the current cursor position.
		highlight_conversation_at_cursor = false,
		-- Style
		-- Available options:
		-- * `sidebar` (Siderbar style, also default)
		-- * `floating` (Floating style)
		style = "sidebar",
		sidebar = {
			-- Width of the sidebar in characters.
			width = 42,
			-- Position of the sidebar.
			-- Available options:
			-- * `left`
			-- * `right`
			position = "right",
		},
		floating = {
			-- Border style of the floating window.
			-- Same border values as `nvim_open_win`.
			border = "rounded",
			-- Size of the floating window.
			-- <= 1: percentage of the screen size
			-- >  1: number of lines/columns
			size = { width = 0.8, height = 0.8 },
		},
	},
	-- Enable/Disable the default keymaps in inline completion.
	use_default_keymaps = false,
	-- Default keymaps
	keymaps = {
		inline = {
			--["<M-l>"] = "accept_all_suggestions",
			["<C-Down>"] = "accept_line",
			["<C-Right>"] = "accept_word",
			["<C-Up>"] = "revoke_line",
			["<C-Left>"] = "revoke_word",
			["<M-;>"] = "triggering_completion",
		},
		chat = {
			["q"] = "close",
			["[c"] = "goto_previous_conversation",
			["]c"] = "goto_next_conversation",
			["c"] = "copy_conversation",
			["C"] = "copy_all_conversations",
			["d"] = "delete_conversation",
			["D"] = "delete_all_conversations",
		},
	},
	-- Setting for source completion.
	source_completion = {
		-- Enable source completion.
		enable = true,
		-- trigger characters for source completion.
		-- Available options:
		-- * A  list of characters like {'a', 'b', 'c', ...}
		-- * A function that returns a list of characters like `function() return {'a', 'b', 'c', ...}`
		trigger_chars = {},
	},
	-- Set the mode of the completion.
	-- Available options:
	-- * 'inline' (VSCode style inline completion)
	-- * 'source' (integrates into other completion plugins)
	completion_mode = "inline",
	---@class LogOptions
	log = {
		-- Log level.
		level = vim.log.levels.WARN,
		-- Max log file size in MB, default is 10MB
		max_size = 10,
	},
})

local map = vim.keymap.set
-- 复用 opt 参数
local opt = { noremap = true, silent = true }
map("n", "<leader>ac", "<cmd>Fitten toggle_chat<cr>", opt)
map("i", "<M-l>", function()
	pcall(function()
		require("fittencode").accept("all")
	end)
end, opt)

map({ "n", "v" }, "<leader>af", function()
	-- 复制选中内容到寄存器
	vim.cmd('normal! "xy')
	-- 返回寄存器x的内容
	local text = vim.fn.getreg("x")
	print(text)
	vim.ui.select({
		"start chat",
		"edit code",
		"explain code",
		"find bugs",
		"optimize code",
		"refactor code",
		"implement feature",
		"document code",
	}, {
		prompt = "选择fitten的功能",
	}, function(choice)
		-- 获得当前visual模式选择的文本
		-- 根据不同的选择 调用不同的函数
		if choice == "start chat" then
			fittencode.start_chat({
				content = text,
			})
		elseif choice == "edit code" then
			fittencode.edit_code({
				content = text,
			})
		elseif choice == "explain code" then
			fittencode.explain_code({
				content = text,
			})
		elseif choice == "find bugs" then
			fittencode.find_bugs({
				content = text,
			})
		elseif choice == "optimize code" then
			fittencode.optimize_code({
				content = text,
			})
		elseif choice == "refactor code" then
			fittencode.refactor_code({
				content = text,
			})
		elseif choice == "implement feature" then
			fittencode.implement_feature({
				content = text,
			})
		elseif choice == "document code" then
			fittencode.document_code({
				content = text,
			})
		end
	end)
end, opt)
--print(vim.inspect(fittencode.get_status()))
-- use <leader>ac to toggle chat window
-- use <leader>af to select fitten function and apply it to the selected text
