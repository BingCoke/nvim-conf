local lualine_require = require("lualine_require")
local M = lualine_require.require("lualine.component"):extend()
local config = require("rest-nvim.config")

local default_options = {
	fg = "#428890",
	icon = "",
}

function M:init(options)
	M.super.init(self, options)
	self.options = vim.tbl_deep_extend("keep", self.options or {}, default_options)
	self.icon = self.options.icon

	self.highlight_color = self:create_hl({ fg = self.options.fg }, "Rest")
end

function M:apply_icon()
	local default_highlight = self:get_default_hl()
	self.status = self:format_hl(self.highlight_color) .. self.icon .. " " .. default_highlight .. self.status
end

function M.update_status()
	--local current_filetype = vim.bo.filetype
	--if current_filetype == "http" then
		return config.get("env_file")
	--end
	--return ""
end

return M
