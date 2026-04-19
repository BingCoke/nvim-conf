local methods = vim.lsp.protocol.Methods


-- 防止vtsls 的 hover的类型过长, 如果过长就用....替代
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

vim.cmd("hi LspSignatureActiveParameter guibg=#3b4261")
-- 开启 hint
vim.lsp.inlay_hint.enable(true)



-- 配置keymap
local on_attach = function(client, bufnr)

	--vim.wo.signcolumn = "yes"
	-- keybind optionslsplsp
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local keymap = vim.keymap

	keymap.set("i", "<c-p>", vim.lsp.buf.signature_help, opts)

	-- set keybinds
	keymap.set("n", "gr", "<CMD>Lspsaga finder ref<CR>", opts) -- show definition, references
	--keymap.set("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
	--keymap.set("n", "gD", "<CMD>Glance definitions<CR>", opts)
	--keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "ga", "<cmd>tab split | Lspsaga goto_definition<CR>", opts)
	--keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)

	-- Go to type definition
	--keymap.set("n", "gt", "<CMD>Glance type_definitions<CR>", opts)
	keymap.set("n", "gy", "<CMD>lua vim.lsp.buf.type_definition()<CR>", opts)

	keymap.set("n", "gi", "<CMD>Lspsaga finder imp<CR>", opts)

	keymap.set("n", "<leader>s", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	--keymap.set("n", "<leader>s", "<cmd>LspUI code_action<CR>", opts) -- see available code actions

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

	--keymap.set({ "i" }, "<c-.>", function()
	--	addSymbolAtLineEnd(".")
	--end, opts)
end



-- 配置不同的类型的图标
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
})

local capabilities = require("util.cmp").getCapabilites()

local M = {}

vim.cmd("command! -nargs=0 OpenInGoogle !google-chrome-stable  --new-window % &;")

M.on_attach = on_attach
M.capabilities = capabilities

return M



