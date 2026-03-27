local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

local ts_conds = require('nvim-autopairs.ts-conds')

npairs.setup({
	check_ts = true,
})


--npairs.add_rules({
--  Rule('{{', ' }', 'vue')
--    :set_end_pair_length(2)
--    :with_pair(ts_conds.is_ts_node('text'))
--})
