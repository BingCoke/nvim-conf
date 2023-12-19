-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip = require("luasnip")

-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
	return
end

local types = require("cmp.types")
local compare = cmp.config.compare

local kind_icons = {
	Text = "",
	Method = "",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "ﴯ",
	Interface = "",
	Module = "",
	Property = "ﰠ",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

-- load snippets from path/of/your/nvim/config/my-cool-snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets" } })
require("luasnip.loaders.from_vscode").lazy_load()

require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })

--require("cmp_nvim_ultisnips").setup {}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
			--vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = {
		["<c-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<c-j>"] = cmp.mapping.select_next_item(), -- next suggestion

		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),

		["<A-Space>"] = cmp.mapping.complete(), -- show completion suggestions

		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),

		["<c-l>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end

			--[[if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
			else
				fallback()
			end]]
		end, { "i", "s" }),

		["<c-h>"] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
			--[[if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				return vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_backward)"), "m", true)
			else
				fallback()
			end]]
		end, { "i", "s" }),
	},
	preselect = cmp.PreselectMode.None,
	-- sources for autocompletion
	sources = cmp.config.sources({
		{
			name = "nvim_lsp",
		},
		{
			name = "luasnip",
		},
		{
			name = "path",
		},
	}, {
		{ name = "buffer" },
	}),
	formatting = {
		format = function(entry, item)
			if item.kind == "Color" then
				item = require("cmp-tailwind-colors").format(entry, item)
				if item.kind ~= "Color" then
					item.menu = "Color"
					return item
				end
			end

			item.menu = item.kind
			item.kind = kind_icons[item.kind] .. " "
			return item
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = {
			border = border("CmpDocBorder"),
			winhighlight = "Normal:CmpDoc",
			max_width = 20,
		},
	},
	sorting = {
		comparators = {
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.locality,
			compare.kind,
			compare.length,
			compare.order,
		},
	},
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}),
})

cmp.setup.filetype("dart", {
	sorting = {
		comparators = {
			compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
			function(entry1, entry2)
				local kind1 = entry1:get_kind() --- @type lsp.CompletionItemKind | number
				local kind2 = entry2:get_kind() --- @type lsp.CompletionItemKind | number

				if kind1 == types.lsp.CompletionItemKind.Method and kind2 == types.lsp.CompletionItemKind.Method then
					return nil
				end
				if kind1 ~= types.lsp.CompletionItemKind.Method and kind2 ~= types.lsp.CompletionItemKind.Method then
					return nil
				end
				if kind1 == types.lsp.CompletionItemKind.Method then
					return true
				end
				if kind2 == types.lsp.CompletionItemKind.Method then
					return false
				end
				return nil
			end,
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.locality,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
			compare.scopes, -- what?
			-- compare.sort_text,
		},
	},
})

cmp.setup.filetype("css", {
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "cmp-tw2css" },
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
})

local js = { "javascript", "typescript", "typescriptreact", "javascriptreact" }

for key, value in pairs(js) do
	cmp.setup.filetype(value, {
		sorting = {
			comparators = {
				function(entry1, entry2)
					local kind1 = entry1:get_kind() --- @type lsp.CompletionItemKind | number
					local kind2 = entry2:get_kind() --- @type lsp.CompletionItemKind | number
					if
						kind1 == types.lsp.CompletionItemKind.Text
						and kind2 == types.lsp.CompletionItemKind.Property
					then
						return false
					end
					if
						kind2 == types.lsp.CompletionItemKind.Text
						and kind1 == types.lsp.CompletionItemKind.Property
					then
						return true
					end

					return nil
				end,
				compare.offset,
				compare.exact,
				compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
				compare.recently_used,
				compare.locality,
				compare.kind,
				compare.length,
				compare.order,
				-- compare.scopes, -- what?
				-- compare.sort_text,
			},
		},
	})
end

local api = vim.api
local function generate_highlight()
	-- gray
	api.nvim_command("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
	-- blue
	api.nvim_command("highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6")
	api.nvim_command("highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch")
	-- light blue
	api.nvim_command("highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE")
	api.nvim_command("highlight! link CmpItemKindInterface CmpItemKindVariable")
	api.nvim_command("highlight! link CmpItemKindText CmpItemKindVariable")
	-- pink
	api.nvim_command("highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0")
	api.nvim_command("highlight! link CmpItemKindMethod CmpItemKindFunction")
	-- front
	api.nvim_command("highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4")
	api.nvim_command("highlight! link CmpItemKindProperty CmpItemKindKeyword")
	api.nvim_command("highlight! link CmpItemKindUnit CmpItemKindKeyword")
end

generate_highlight()

-- 创建自定义命令
vim.cmd('command! -nargs=0 SnipEdit lua require("my.command").snip_edit();')
