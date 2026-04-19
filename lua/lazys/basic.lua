return {
  -- icons
  {
    "nvim-tree/nvim-web-devicons"
  },
  -- color picker
  {
    "uga-rosa/ccc.nvim",
    config = function()
      require("ccc").setup({})
    end,
    event = "VeryLazy",
  },

  -- terminal tool
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      local M = {}

      require("toggleterm").setup({
        shade_terminals = false,
        float_opts = {
          border = "curved",
          title_pos = "center",
        },
      })

      local Terminal = require("toggleterm.terminal").Terminal

      local map = vim.keymap.set
      -- 复用 opt 参数
      local opt = { noremap = true, silent = true }


      M.term = Terminal:new({
        direction = "float",
        close_on_exit = true,
        display_name = "term",
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      map({ "n", "i", "t" }, "<M-e>", function()
        M.term:toggle()
      end, opt)

      map({ "n", "i", "t" }, "<M-f>", function()
        if M.yazi == nil then
          M.yazi = Terminal:new({
            display_name = "yazi",
            direction = "float",
            close_on_exit = true,
            dir = vim.fn.getcwd(),
            cmd = "yazi",
            on_exit = function()
              M.yazi = nil
            end,
            on_open = function()
              vim.cmd("startinsert!")
            end,
          })
        end

        M.yazi:toggle()
      end, opt)

      M.git = Terminal:new({
        cmd = "lazygit",
        direction = "float",
        close_on_exit = true,
        display_name = "git",
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      map({ "n", "i", "t" }, "<M-g>", function()
        M.git:toggle()
      end, opt)

      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", "<Esc>", { noremap = true, silent = true })

        -- 使用 <C-\><C-n> 退出终端模式
        vim.api.nvim_buf_set_keymap(0, "t", "<C-\\><C-n>", "<C-\\><C-n>", { noremap = true, silent = true })
        -- vim.api.nvim_buf_set_keymap(0, "t", "<leader><Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

      return M
    end,
  },
  {
    "glepnir/dashboard-nvim",
    config = function ()
      require("config.dashboard")
    end
  }
}
