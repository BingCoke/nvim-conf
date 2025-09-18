local M = {}

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

local on_attach = function(client, bufnr)
	--print(vim.inspect(client.server_capabilities.completionProvider.triggerCharacters))

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

local default_capabilities = require("util.cmpUtil").getCapabilites()

--local default_capabilities  = vim.lsp.protocol.default_capabilities()

-- Change the Diagnostic symbols in the sign column (gutter)
-- (not in youtube nvim video)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

M.on_attach = on_attach
M.capabilities = capabilities
M.default_capabilities = default_capabilities

vim.cmd("command! -nargs=0 OpenInGoogle !google-chrome-stable  --new-window % &;")
vim.cmd("command! -nargs=0 OpenThunar !thunar % &;")

return M
