return {

	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && yarn install",
		config = function()
			vim.g.mkdp_path_to_chrome = "google-chrome-stable"
			vim.g.mkdp_theme = "dark"
			vim.g.mkdp_command_for_global = 1
			vim.g.mkdp_auto_close = 0
		end,
		ft = { "markdown" },
	},
	{
		"jbyuki/venn.nvim",
		ft = "markdown",
	},
	{
		"yaocccc/nvim-hl-mdcodeblock.lua",
		config = function(self, opts)
			require("hl-mdcodeblock").setup({
				-- option
			})
		end,
		ft = { "markdown" },
	},
	--{
	--	"HakonHarnes/img-clip.nvim",
	--	opts = {
	--		relative_to_current_file = true,
	--	},
	--	ft = "markdown",
	--	keys = {
	--		{
	--			"<c-,>",
	--			function()
	--				require("img-clip").pasteImage({
	--					use_absolute_path = false,
	--					file_name = "image.png",
	--				})
	--			end,
	--			desc = "Paste clipboard image",
	--		},
	--	},
	--},
	--{
	--	"3rd/image.nvim",
	--	rocks = { "magick" },
	--	config = function()
	--		require("image").setup({
	--			backend = "kitty",
	--			integrations = {
	--				markdown = {
	--					enabled = true,
	--					clear_in_insert_mode = false,
	--					download_remote_images = true,
	--					only_render_image_at_cursor = false,
	--					filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
	--				},
	--			},
	--			max_height_window_percentage = 50,
	--			window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
	--			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
	--			editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
	--			tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
	--			hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
	--		})
	--	end,
	--	ft = 'markdown'
	--},
	{
		"askfiy/nvim-picgo",
		config = function()
			-- it doesn't require you to do any configuration
			require("nvim-picgo").setup()
		end,
		ft = "markdown",
	},
	{
		"Zeioth/markmap.nvim",
		build = "yarn global add markmap-cli",
		ft = "markdown",
		config = function()
			require("markmap").setup({
				hide_toolbar = true,
			})
		end,
	},
}
