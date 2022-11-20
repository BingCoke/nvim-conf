vim.g.ranger_map_keys=0
local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }

map("n","<leader>rg",":Ranger<CR>",opt)
