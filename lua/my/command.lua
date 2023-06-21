local M = {}

function M.snip_edit()
    require("luasnip.loaders").edit_snippet_files()
end
return M
