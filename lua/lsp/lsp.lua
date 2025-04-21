local M = {}

local language = {
	"lua",
	"python",
	"rust",
	"markdown",
	"yaml",
	--"ts",
}

local util = require("lspconfig.util")

local methods = vim.lsp.protocol.Methods

local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if client and (client.name == "vtsls") then
		if result == nil then
			return
		end
		---@diagnostic disable-next-line: undefined-field

		result = vim.iter(result)
			:map(function(hint)
				local label = hint.label
				local new = {}
				if label ~= nil and #label < 6 then
				else
					for i = 0, 5 do
						new[i] = label[i]
					end
					new[6] = {
						value = " ..",
					}
					hint.label = new
				end
				return hint
			end)
			:totable()
	end

	inlay_hint_handler(err, result, ctx, config)
end

-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

vim.diagnostic.config({
	update_in_insert = false,
})

vim.lsp.inlay_hint.enable(true)

-- config lsp signature
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	-- Use a sharp border with `FloatBorder` highlights
	border = "single",
	title = { { "signature", "TitleString" } },
})

vim.cmd("hi LspSignatureActiveParameter guibg=#3b4261")

local keymap = vim.keymap -- for conciseness

local function addSymbolAtLineEnd(symbol)
	local line_contents = vim.api.nvim_get_current_line()

	local last_char = line_contents:sub(-1)
	local setCur = ""
	if last_char == symbol then
		setCur = line_contents:sub(0, string.len(line_contents) - 1)
	else
		setCur = line_contents .. symbol
	end
	vim.api.nvim_set_current_line(setCur)

	local line = vim.fn.line(".")
	local line_end = vim.fn.col("$")
	vim.fn.cursor(line, line_end)
end

-- enable keybinds only for when lsp server available

local on_attach = function(_, bufnr)
	vim.wo.signcolumn = "yes"
	-- keybind optionslsplsp
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("i", "<c-p>", vim.lsp.buf.signature_help, opts)
	-- 设置光标
	keymap.set("n", "<a-p>", "<cmd>lua require('illuminate').goto_prev_reference(true)<CR>", opts)
	keymap.set("n", "<a-n>", "<cmd>lua require('illuminate').goto_next_reference(true)<CR>", opts)

	-- set keybinds
	keymap.set("n", "gr", "<CMD>Lspsaga finder ref<CR>", opts) -- show definition, references
	--keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
	keymap.set("n", "gD", "<CMD>Glance definitions<CR>", opts)
	keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
	keymap.set("n", "ga", "<cmd>tab split | Lspsaga goto_definition<CR>", opts)
	--keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)

	-- Go to type definition
	--keymap.set("n", "gt", "<CMD>Glance type_definitions<CR>", opts)
	keymap.set("n", "gy", "<CMD>lua vim.lsp.buf.type_definition()<CR>", opts)

	keymap.set("n", "gi", "<CMD>Lspsaga finder imp<CR>", opts)

	--keymap.set("n", "<leader>s", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>s", "<cmd>LspUI code_action<CR>", opts) -- see available code actions

	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

	keymap.set(
		"n",
		"<leader>d",
		"<cmd>Trouble diagnostics toggle win.type = split win.position=bottom filter.buf=0<CR>",
		opts
	) -- show  diagnostics for line

	keymap.set("n", "K", vim.lsp.buf.hover, opts)

	--keymap.set("n", "<A-a>", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

	--keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	vim.keymap.set({ "i" }, "<c-d>", function()
		if not require("noice.lsp").scroll(4) then
			return "<c-d>"
		end
	end, opts)

	vim.keymap.set({ "i" }, "<c-u>", function()
		if not require("noice.lsp").scroll(-4) then
			return "<c-u>"
		end
	end, opts)

	keymap.set("i", "<c-;>", function()
		addSymbolAtLineEnd(";")
	end, opts)

	keymap.set({ "i" }, "<c-.>", function()
		addSymbolAtLineEnd(".")
	end, opts)
end

--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("util.cmpUtil").getCapabilites()

capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

capabilities.textDocument.completion.completionItem.snippetSupport = true

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
--local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
--local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local default_capabilities = require("util.cmpUtil").getCapabilites()

--local default_capabilities  = vim.lsp.protocol.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

for _, value in ipairs(language) do
	require("lsp.language." .. value).setup(lspconfig, default_capabilities, on_attach)
end

lspconfig["awk_ls"].setup({
	capabilities = default_capabilities,
	on_attach = on_attach,
})

-- configure html server
lspconfig["html"].setup({
	capabilities = default_capabilities,
	root_dir = util.root_pattern(".git", "turbo.json", "pnpm-workspace.yaml"),
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end,
	init_options = {
		provideFormatter = false,
		configurationSection = { "html", "css", "javascript" },
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
	},
})

require("tailwind-tools").setup({
	server = {
		override = true,
		settings = {
			filetypes = {
				"templ",
				"vue",
				"html",
				"astro",
				"javascript",
				"typescript",
				"react",
				"htmlangular",
			},
			experimental = {
				-- https://github.com/paolotiu/tailwind-intellisense-regex-list#tailwind-merge
				classRegex = {
					{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					{ "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"`]([^'\"`,;]*)[`'\"`]" },
					{ "classNames\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
					{ "windVars\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
				},
			},
			classAttributes = { "class", "classList", "className", ".*Style", ".*Class", ".*ClassName" },
		},
	},
})
--lspconfig.tailwindcss.setup({
--	--root_dir = function(fname)
--	--	return vim.fs.dirname(vim.fs.find("package.json", { path = fname, upward = true })[1])
--	--		or vim.fs.dirname(vim.fs.find("node_modules", { path = fname, upward = true })[1])
--	--		or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
--	--end,
--	capabilities = capabilities,
--	on_attach = on_attach,
--	settings = {
--		tailwindCSS = {
--			filetypes = {
--				"templ",
--				"vue",
--				"html",
--				"astro",
--				"javascript",
--				"typescript",
--				"react",
--				"htmlangular",
--			},
--			experimental = {
--				-- https://github.com/paolotiu/tailwind-intellisense-regex-list#tailwind-merge
--				classRegex = {
--					{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
--					{ "(?:twMerge|twJoin)\\(([^\\);]*)[\\);]", "[`'\"`]([^'\"`,;]*)[`'\"`]" },
--					{ "classNames\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
--					{ "windVars\\(([^)]*)\\)", "[\"'`]([^\"'`]*)[\"'`]" },
--					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
--				},
--			},
--			classAttributes = { "class", "classList", "className", ".*Style", ".*Class", ".*ClassName" },
--			--classAttributes = { "class", "classList", "className", ".*Class", ".*ClassName", ".*styles", ".*style" },
--		},
--	},
--})

lspconfig.stylelint_lsp.setup({
	filetypes = {
		"css",
		"less",
		"scss",
		"sugarss",
		"vue",
		"wxss",
	},
	capabilities = capabilities,
	on_attach = function(a, b)
		on_attach(a, b)
	end,
	settings = {
		stylelintplus = {
			autoFixOnFormat = true,
		},
	},
})

lspconfig["cssls"].setup({
	capabilities = default_capabilities,
	on_attach = on_attach,
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		less = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
})

lspconfig["lemminx"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["bashls"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["taplo"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

--lspconfig["ruby_ls"].setup({
--	capabilities = capabilities,
--	on_attach = on_attach,
--})

lspconfig.kotlin_language_server.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["prismals"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.intelephense.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	init_options = {
		licenceKey = "/Users/bingcoke/.config/intelephense/licence",
	},
	settings = {},
})

lspconfig.arduino_language_server.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.lemminx.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.astro.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.thriftls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.buf_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.graphql.setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig.omnisharp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

--lspconfig.clangd.setup({
--	capabilities = capabilities,
--	on_attach = on_attach,
--})

lspconfig.ccls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = {
		debounce_text_changes = 150,
	},
	init_options = {
		cache = {
			directory = "/tmp/ccls-cache",
		},
		clang = {
			extraArgs = { "-std=c++11" },
		},
	},
})

lspconfig["tsp_server"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["css_variables"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
})

lspconfig["eslint"].setup({
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = function(filename, bufnr)
		if string.find(filename, "node_modules/") then
			return nil
		end

		return require("lspconfig/util").root_pattern(
			"eslint.config.js",
			"eslint.config.mjs",
			"eslint.config.cjs",
			"eslint.config.ts",
			"eslint.config.mts",
			"eslint.config.cts"
		)()
	end,
})

require("lsp.language.rime").setup()

lspconfig.rime_ls.setup({
	init_options = {
		enabled = false,
		--shared_data_dir = "/usr/share/rime-data",
		--user_data_dir = "~/.local/share/rime-ls",
		log_dir = "/tmp",
		max_candidates = 9,
		paging_characters = { ",", "." },
		trigger_characters = {},
		schema_trigger_character = "&",
		max_tokens = 0,
		always_incomplete = false,
		preselect_first = false,
		show_filter_text_in_label = false,
		long_filter_text = true,
	},
	settings = {
		ignorePattern = { "node_modules/**" },
	},
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		local toggle_rime = function()
			client.request("workspace/executeCommand", { command = "rime-ls.toggle-rime" }, function(_, result, ctx, _)
				if ctx.client_id == client.id then
					vim.g.rime_enabled = result
				end
			end)
		end
		-- keymaps for executing command
		vim.keymap.set("n", "<leader>rr", toggle_rime, { desc = "Toggle [R]ime" })
		vim.keymap.set("i", "<C-s>", toggle_rime, { desc = "Toggle Rime" })
		vim.keymap.set("n", "<leader>rs", function()
			vim.lsp.buf.execute_command({ command = "rime-ls.sync-user-data" })
		end, { desc = "[R]ime [S]ync" })
	end,
	capabilities = capabilities,
})

M.on_attach = on_attach
M.capabilities = capabilities
M.lspconfig = lspconfig
M.default_capabilities = default_capabilities
M.tsserverAttached = false
M.volarAttached = false

vim.cmd("command! -nargs=0 OpenInGoogle !google-chrome-stable  --new-window % &;")
vim.cmd("command! -nargs=0 OpenThunar !thunar % &;")

return M
