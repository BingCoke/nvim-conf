local tree_api = require("nvim-tree.api")

function find_directory_and_focus()
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	local function open_nvim_tree(prompt_bufnr, _)
		actions.select_default:replace(function()
			local api = require("nvim-tree.api")

			actions.close(prompt_bufnr)
			local selection = action_state.get_selected_entry()
			api.tree.open()
			api.tree.find_file(selection.cwd .. "/" .. selection.value)
		end)
		return true
	end

	require("telescope.builtin").find_files({
		find_command = { "fd", "--type", "directory", "--hidden", "--exclude", ".git/*" },
		attach_mappings = open_nvim_tree,
	})
end

local function tree(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings

	vim.keymap.set("n", "<C-]>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "<C-e>", api.node.open.replace_tree_buffer, opts("Open: In Place"))
	--vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
	vim.keymap.set("n", "<C-r>", api.fs.rename_sub, opts("Rename: Omit Filename"))
	--vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
	vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "S", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
	--vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
	vim.keymap.set("n", "<CR>", function()
		local tab_buffers = vim.fn.tabpagebuflist(vim.fn.tabpagenr())
		-- 遍历缓冲区
		-- 如果有一个filetype是dashboard 或者两个以上的buffer的filetype是nil或者"" 那么就是open
		local count = 0
		for _, bufn in ipairs(tab_buffers) do
			local filetype = vim.api.nvim_buf_get_option(bufn, "filetype")
			local name = vim.fn.bufname(bufn)
			if filetype == "dashboard" then
				api.node.open.drop()
				return
			end
			if (filetype == nil or filetype == "") and (name == nil or name == "") then
				count = count + 1
			end
		end
		if count >= 2 then
			api.node.open.drop()
			return
		end
		api.node.open.tab_drop()
	end, opts("Open"))
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
	vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
	vim.keymap.set("n", ".", api.node.run.cmd, opts("Run Command"))
	vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "a", api.fs.create, opts("Create File Or Directory"))
	vim.keymap.set("n", "bd", api.marks.bulk.delete, opts("Delete Bookmarked"))
	vim.keymap.set("n", "bt", api.marks.bulk.trash, opts("Trash Bookmarked"))
	vim.keymap.set("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
	vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle Filter: No Buffer"))
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Filter: Git Clean"))
	vim.keymap.set("n", "[c", api.node.navigate.git.prev, opts("Prev Git"))
	vim.keymap.set("n", "]c", api.node.navigate.git.next, opts("Next Git"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
	--vim.keymap.set("n", "D", api.fs.trash, opts("Trash"))
	vim.keymap.set("n", "E", api.tree.expand_all, opts("Expand All"))
	vim.keymap.set("n", "e", api.fs.rename_basename, opts("Rename: Basename"))
	vim.keymap.set("n", "]e", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
	vim.keymap.set("n", "[e", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
	vim.keymap.set("n", "F", api.live_filter.clear, opts("Live Filter: Clear"))
	vim.keymap.set("n", "f", api.live_filter.start, opts("Live Filter: Start"))
	vim.keymap.set("n", "g?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "ge", api.fs.copy.basename, opts("Copy Basename"))
	vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Filter: Dotfiles"))
	vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Filter: Git Ignore"))
	vim.keymap.set("n", "J", api.node.navigate.sibling.last, opts("Last Sibling"))
	vim.keymap.set("n", "K", api.node.navigate.sibling.first, opts("First Sibling"))
	vim.keymap.set("n", "L", api.node.open.toggle_group_empty, opts("Toggle Group Empty"))
	vim.keymap.set("n", "M", api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))
	vim.keymap.set("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
	--vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "O", api.node.open.no_window_picker, opts("Open: No Window Picker"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "P", api.node.navigate.parent, opts("Parent Directory"))
	vim.keymap.set("n", "q", api.tree.close, opts("Close"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
	--vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
	vim.keymap.set('n', 'o', api.node.run.system, opts('Run System'))
	--vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
	vim.keymap.set("n", "u", api.fs.rename_full, opts("Rename: Full Path"))
	vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Filter: Hidden"))
	vim.keymap.set("n", "W", api.tree.collapse_all, opts("Collapse"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
	-- custom mappings
	vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end
require("nvim-tree").setup({
	disable_netrw = true,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	--hijack_unnamed_buffer_when_opening = true,
	view = {
		float = {
			enable = true,
			quit_on_focus_loss = true,
			open_win_config = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * 0.6
				local window_h = screen_h * 0.6
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
		width = function()
			return math.floor(vim.opt.columns:get() * 0.6)
		end,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	git = {
		enable = false,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	on_attach = tree,
})

local opt = { noremap = true, silent = true }

vim.keymap.set("n", "\\", function()
	tree_api.tree.toggle({
		find_file = false,
		update_root = true,
	})
end, opt)

vim.keymap.set("n", "|", function()
	tree_api.tree.toggle({
		find_file = true,
		update_root = true,
	})
end, opt)
