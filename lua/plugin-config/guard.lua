local ft = require("guard.filetype")

-- use clang-format and clang-tidy for c files
ft("c"):fmt("clang-format"):lint("clang-tidy")

-- use stylua to format lua files and no linter
ft("lua"):fmt("stylua")

ft("rust"):fmt("rustfmt")

-- use lsp to format first then use golines to format
--[[ ft('go'):fmt('lsp')
        :append('golines')
        :lint('golangci') ]]

-- multiple files register
ft("typescript,javascript,typescriptreact,html,css,scss"):fmt("prettier")

ft("json"):fmt("lsp")
ft("kotlin"):fmt("lsp")
ft("dart"):fmt("lsp")

-- call setup LAST
require("guard").setup({
	-- the only option for the setup function
	fmt_on_save = false,
})
