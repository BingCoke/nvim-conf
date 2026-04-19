return {
  {
    "akinsho/bufferline.nvim",
    config = function()
      vim.opt.termguicolors = true
      local bufferline = require("bufferline")

      local closeBuf = function(bufnr)
        print("close buf")
        local bufs = vim.fn.getbufinfo({ buflisted = 1 })

        if #bufs == 1 then
          vim.cmd("enew")
          vim.api.nvim_buf_delete(bufnr, { force = false })
          return
        end

        -- 找到当前 buffer 在列表中的位置
        local idx = nil
        for i, buf in ipairs(bufs) do
          if buf.bufnr == bufnr then
            idx = i
            break
          end
        end

        -- 第一个就跳下一个，否则跳上一个
        local target
        print("idx is "..idx)
        if idx == 1 then
          target = bufs[2].bufnr
        else
          target = bufs[idx - 1].bufnr
        end

        vim.api.nvim_set_current_buf(target)
        vim.api.nvim_buf_delete(bufnr, { force = false })
      end

      bufferline.setup({
        options = {
          -- 关闭 Tab 的命令
          --mode = "tabs",
          --close_command = "tabclose! %d",
          close_command = closeBuf, -- can be a string | function, | false see "Mouse actions"
          right_mouse_command = closeBuf, -- can be a string | function | false, see "Mouse actions"
          left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
          always_show_bufferline = false,
          enforce_regular_tabs = true,
          indicator = {
            --icon = "",
            style = "none",
          },
          --left_mouse_command = "tabnext %d", -- can be a string | function | false, see "Mouse actions"
          --middle_mouse_command = function(arg)
            --	vim.cmd("tabclose " .. arg)
            --end,
            left_trunc_marker = "",
            right_trunc_marker = "",
            buffer_close_icon = "󰅖",
            separator_style = { "|", "|" },
            numbers = "none",
            themable = false,
            padding = 0,
            tab_size = 16,
            truncate_names = false,
            diagnostics = "nvim_lsp",
            diagnostics_update_in_insert = false,
            show_close_icon = false,
            show_buffer_close_icons = false,
            show_tab_indicators = false,
            show_duplicate_prefix = true,
          },
        })

        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }

        local function goTo(num)
          bufferline.go_to(num)
        end

        map("n", "<a-w>", function()
          local bufnr = vim.api.nvim_get_current_buf()
          closeBuf(bufnr)
        end, opts)



        map("n", "<leader>sw", "<Cmd>BufferLinePick<CR>", opts)

        map("n", "<c-h>", "<Cmd>BufferLineCyclePrev<CR>", opts)
        map("n", "<c-l>", "<Cmd>BufferLineCycleNext<CR>", opts)

        map("n", "<leader>bl", "<Cmd>BufferCloseRight<CR>", opts)
        map("n", "<leader>bh", "<Cmd>BufferCloseLeft<CR>", opts)

        map("n", "<A-i>", "<Cmd>BufferLineMovePrev<CR>", opts)
        map("n", "<A-o>", "<Cmd>BufferLineMoveNext<CR>", opts)

        for i = 1, 9, 1 do
          map("n", "<leader>" .. i, function()
            goTo(i)
          end, opts)
        end
      end,
      enabled = false
    },
  }

