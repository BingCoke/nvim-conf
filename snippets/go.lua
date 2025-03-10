local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local fmt = extras.fmt
local m = extras.m
local l = extras.l
local postfix = require("luasnip.extras.postfix").postfix
local matches = require("luasnip.extras.postfix").matches

local function iferr(parm)
	local boff = vim.fn.wordcount().cursor_bytes
	local data = vim.fn.systemlist(("iferr" .. " -pos " .. boff), vim.fn.bufnr("%"))
	if vim.v.shell_error ~= 0 then
		error("iferr failed: " .. data)
	end
	data[1] = string.gsub(data[1], "err", parm)
	data[2] = string.gsub(data[2], "err", parm)
	return data
end

return {
	postfix(".vp", {
		f(function(_, parent)
			return 'fmt.Printf("'
				.. parent.snippet.env.POSTFIX_MATCH
				.. ': %+v\\n", '
				.. parent.snippet.env.POSTFIX_MATCH
				.. ")"
		end, {}),
	}),
	postfix({ trig = ".iferr", matches = matches.line }, {
		f(function(_, parent)
			local parm = parent.snippet.env.POSTFIX_MATCH
			return iferr(parm)
		end),
	}),
}
