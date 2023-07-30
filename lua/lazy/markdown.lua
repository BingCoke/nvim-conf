return {

	{
		"iamcco/markdown-preview.nvim",
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
}
