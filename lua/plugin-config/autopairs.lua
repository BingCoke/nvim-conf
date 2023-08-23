local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
	check_ts = false,
})

-- auto pair
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local handlers = require("nvim-autopairs.completion.handlers")

--local default_handler = cmp_autopairs.filetypes["*"]["("].handler
--[[ cmp_autopairs.filetypes["*"]["("].handler = function(char, item, bufnr, rules, commit_character)
  local node_type = ts_utils.get_node_at_cursor():type()
  if ts_node_func_parens_disabled[node_type] then
    if item.data then
      item.data.funcParensDisabled = true
    else
      char = ""
    end
  end
  print(vim.inspect({ char, item, bufnr, rules, commit_character }))
  default_handler(char, item, bufnr, rules, commit_character)
end ]]

--[[local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done({
		filetypes = {
			sh = false,
			css = false,
			html = false,
			rust = false,
			javascript = false,
			javascriptreact = false,
			typescript = false,
			typescriptreact = false,
			dart = false,
			["*"] = {
				["("] = {
					kind = {
						cmp.lsp.CompletionItemKind.Function,
						cmp.lsp.CompletionItemKind.Method,
					},
					handler = handlers["*"],
				},
			},
		},
	})
)]]
