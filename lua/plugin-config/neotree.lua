-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
-- NOTE: this is changed from v1.x, which used the old style of highlight groups
-- in the form "LspDiagnosticsSignWarning"

require("neo-tree").setup({
	close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
	--sync_root_with_cwd = true,
	popup_border_style = "rounded",
	enable_git_status = false,
	enable_diagnostics = true,
	open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
	sort_case_insensitive = false, -- used when sorting files and directories in the tree
	sort_function = nil, -- use a custom function for sorting files and directories in the tree
	-- sort_function = function (a,b)
	--       if a.type == b.type then
	--           return a.path > b.path
	--       else
	--           return a.type > b.type
	--       end
	--   end , -- this sorts files and directories descendantly
	default_component_configs = {
		file_size = {
			enable = true,
		},
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
		name = {
			trailing_slash = false,
			use_git_status_colors = true,
			highlight = "NeoTreeFileName",
		},
		git_status = {
			symbols = {
				-- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "", -- this can only be used in the git_status source
				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "",
				staged = "",
				conflict = "",
			},
		},
	},
	-- A list of functions, each representing a global custom command
	-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
	-- see `:h neo-tree-global-custom-commands`
	commands = {},
	window = {
		position = "left",
		width = 25,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["<space>"] = {
				"toggle_node",
				nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
			},
			["<2-LeftMouse>"] = "open",
			--["<cr>"] = function(state)
			--	--print(vim.inspect(state))
			--	state.commands.open_tab_drop()
			--end,
			["l"] = "open_drop",
			["<cr>"] = function(state)
				local tab_buffers = vim.fn.tabpagebuflist(vim.fn.tabpagenr())
				-- 遍历缓冲区
				-- 如果有一个filetype是dashboard 或者两个以上的buffer的filetype是nil或者"" 那么就是open
				local count = 0
				for _, bufnr in ipairs(tab_buffers) do
					local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
					local name = vim.fn.bufname(bufnr)
					if filetype == "dashboard" then
						state.commands.open_drop(state)
						return
					end
					if (filetype == nil or filetype == "") and (name == nil or name == "") then
						count = count + 1
					end
				end
				if count >= 2 then
					state.commands.open_drop(state)
					return
				end
				state.commands.open_tab_drop(state)
			end,
			["n"] = "revert_preview",
			["<tab>"] = { "toggle_preview" },
			--["l"] = "focus_preview",
			--["<tab>"] = "focus_preview",
			["S"] = "open_split",
			["s"] = "open_vsplit",
			["o"] = { "open", nowait = true },
			-- ["S"] = "split_with_window_picker",
			-- ["s"] = "vsplit_with_window_picker",
			["t"] = "open_tab_drop",
			["w"] = "",
			--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
			["C"] = "close_node",
			-- ['C'] = 'close_all_subnodes',

			["W"] = "close_all_nodes",
			["Z"] = "expand_all_nodes",
			["a"] = {
				"add",
				-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
				-- some commands may take optional config options, see `:h neo-tree-mappings` for details
				config = {
					show_path = "relative", -- "none", "relative", "absolute"
				},
			},
			["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
			["d"] = "delete",
			["r"] = "rename",

			["y"] = "copy_to_clipboard",
			["x"] = "cut_to_clipboard",
			["p"] = "paste_from_clipboard",
			["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
			-- ["c"] = {
			--  "copy",
			--  config = {
			--    show_path = "none" -- "none", "relative", "absolute"
			--  }
			--}
			["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
			["<"] = "prev_source",
			[">"] = "next_source",
		},
	},
	nesting_rules = {},
	filesystem = {
		filtered_items = {
			visible = false, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = true,
			hide_gitignored = true,
			hide_hidden = true, -- only works on Windows for hidden files/directories
			hide_by_name = {
				"node_modules",
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				".gitignored",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				--".DS_Store",
				--"thumbs.db"
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		-- time the current file is changed while the tree is open.
		group_empty_dirs = false, -- when true, empty folders will be grouped together
		hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
		-- in whatever position is specified in window.position
		-- "open_current",  -- netrw disabled, opening a directory opens within the
		-- window like netrw would, regardless of window.position
		-- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
		use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
		-- instead of relying on nvim autocmd events.
		window = {
			position = "float",
			mappings = {
				["<bs>"] = "navigate_up",
				["."] = "set_root",
				["H"] = "toggle_hidden",
				["/"] = "fuzzy_finder",
				["<c-f>"] = "fuzzy_finder",
				["-"] = "fuzzy_finder_directory",
				["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
				-- ["D"] = "fuzzy_sorter_directory",
				["f"] = "filter_on_submit",
				["<c-x>"] = "clear_filter",
				["[g"] = "prev_git_modified",
				["]g"] = "next_git_modified",
			},
			fuzzy_finder_mappings = {
				["<down>"] = "move_cursor_down",
				["<C-j>"] = "move_cursor_down",
				["<up>"] = "move_cursor_up",
				["<C-k>"] = "move_cursor_up",
			},
		},

		commands = {}, -- Add a custom command or override a global one using the same function name
	},
	buffers = {
		-- time the current file is changed while the tree is open.
		group_empty_dirs = true, -- when true, empty folders will be grouped together
		show_unloaded = true,
		window = {
			mappings = {
				["bd"] = "buffer_delete",
				["<bs>"] = "navigate_up",
				["."] = "set_root",
			},
		},
	},
	git_status = {
		window = {
			position = "float",
			mappings = {
				["A"] = "git_add_all",
				["a"] = "git_add_file",
				["u"] = "git_unstage_file",
				["r"] = "git_revert_file",
				["c"] = "git_commit",
				["p"] = "git_push",
				["P"] = "git_commit_and_push",
			},
		},
	},
})

local opt = { noremap = true, silent = true }

vim.keymap.set("n", "sg", ":Neotree<space>git_status<CR>", opt)
vim.keymap.set("n", "|", ":Neotree float toggle reveal<CR>", opt)
vim.keymap.set("n", "\\", ":Neotree source=filesystem position=float toggle<CR>", opt)
vim.keymap.set("n", "<A-m>", ":Neotree source=filesystem position=left toggle<CR>", opt)
