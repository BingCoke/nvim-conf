local config = require("session_manager.config")
require("session_manager").setup({
  --  autosave_last_session = false,
  --autoload_mode = config.AutoloadMode.Disabled,
  autosave_ignore_dirs = {
    "/",
  },
})

local opt = { noremap = true, silent = true }

vim.keymap.set("n", "sh", ":SessionManager load_session<CR>", opt)
vim.keymap.set("n", "sd", ":SessionManager delete_session<CR>", opt)
vim.keymap.set("n", "ss", ":SessionManager save_current_session<CR>", opt)
