-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 100


-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

local keyset = vim.keymap.set
local map = vim.api.nvim_set_keymap
-- Auto completes
--[[ function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end ]]

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
local opts = { silent = true, noremap = true }
local opt = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<c-j>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opt)
keyset("i", "<c-k>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opt)
keyset("i", "<c-d>", 'coc#pum#visible() ? coc#pum#next(5) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opt)
keyset("i", "<c-u>", [[coc#pum#visible() ? coc#pum#prev(5) : "\<C-h>"]], opt)

vim.g.coc_snippet_next = '<c-l>'
vim.g.coc_snippet_prev = '<c-h>'
-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "<TAB>"]], opt)
-- Use <c-j> to trigger snippets
keyset("i", "<A-i>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion.
keyset("i", "<A-space>", "coc#refresh()", { silent = true, expr = true })
-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })
keyset("n", "[e", "<Plug>(coc-diagnostic-prev-error)", { silent = true })
keyset("n", "]e", "<Plug>(coc-diagnostic-next-error)", { silent = true })

-- GoTo code navigation.
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Use K to show documentation in preview window.
function _G.show_docs()
  local cw = vim.fn.expand('<cword>')
  if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
    vim.api.nvim_command('h ' .. cw)
  elseif vim.api.nvim_eval('coc#rpc#ready()') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
  end
end

keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })



-- Highlight the symbol and its references when holding the cursor.
--[[ vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
}) ]]


-- Symbol renaming.
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })


-- Formatting selected code.
--keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
--keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
local opt_2 = { silent = true, nowait = true }

keyset("x", "<leader>s", "<Plug>(coc-codeaction-selected)", opt_2)
keyset("n", "<leader>s", "<Plug>(coc-codeaction-selected)", opt_2)

-- Remap keys for applying codeAction to the current buffer.
keyset("n", "<leader>qf", "<Plug>(coc-codeaction)", { silent = true, noremap = true })
keyset("n", "<leader>qr", "<plug>(coc-codeaction-cuuent)", opt_2)

-- Apply AutoFix to problem on the current line.
keyset("n", "<leader>qv", "<Plug>(coc-fix-current)", opt_2)


-- Run the Code Lens action on the current line.
keyset("n", "<leader>ac", "<Plug>(coc-codelens-action)", opt_2)


-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })


-- Add `:Format` command to format current buffer.
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer.
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

keyset("n", "<leader>f", "<cmd>Format<CR>", opts)





local opt_3 = { silent = true, nowait = true }
-- Show commands.
keyset("n", "<leader>c", ":CocCommand<CR>", opt_3)

-- Find symbol of current document.
keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
-- Show all diagnostics.
keyset("n", "<leader>sa", "<CMD>CocList diagnostics<CR>", opt_3)


-- Resume latest coc list.
keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opt_3)

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
keyset("x", "if", "<Plug>(coc-funcobj-i)", opt_3)
keyset("o", "if", "<Plug>(coc-funcobj-i)", opt_3)
keyset("x", "af", "<Plug>(coc-funcobj-a)", opt_3)
keyset("o", "af", "<Plug>(coc-funcobj-a)", opt_3)
keyset("x", "ic", "<Plug>(coc-classobj-i)", opt_3)
keyset("o", "ic", "<Plug>(coc-classobj-i)", opt_3)
keyset("x", "ac", "<Plug>(coc-classobj-a)", opt_3)
keyset("o", "ac", "<Plug>(coc-classobj-a)", opt_3)


local opt_win = { silent = true, nowait = true, expr = true }
keyset("n", "<A-n>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<A-p>"', opt_win)
keyset("n", "<A-p>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<A-n>"', opt_win)
keyset("i", "<A-n>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opt_win)
keyset("i", "<A-p>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opt_win)
keyset("v", "<A-n>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<A-p>"', opt_win)
keyset("v", "<A-p>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<A-n>"', opt_win)



-- Remap keys for apply refactor code actions.
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
