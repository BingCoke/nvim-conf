local g = require("gConfig")
local language = g.language
local ts = g.ts
return {

	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("plugin-config.nvim-treesitter")
		end,
		ft = language,
	},
}
