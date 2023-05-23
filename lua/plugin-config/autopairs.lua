local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
  check_ts = true,
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(" ,'"', "'" },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment",
  },
})

local ts_conds = require("nvim-autopairs.ts-conds")

local cond = require("nvim-autopairs.conds")

