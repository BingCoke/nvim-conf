local M = {}

function M.markdown_head()
  local line = vim.api.nvim_get_current_line()
  local prefix = string.sub(line, 1, 1)
  local new = ""
  if prefix == "#" then
    new = "#"
  else
    new = "# "
  end
  vim.api.nvim_set_current_line(new .. line)
  local currentPos = vim.api.nvim_win_get_cursor(0)
  local newPos = { currentPos[1], currentPos[2] + 1 }
  vim.api.nvim_win_set_cursor(0, newPos)
end

function M.markdown_todo()
  local line = vim.api.nvim_get_current_line()
  local prefix = string.sub(line, 1, 5)

  if prefix == "- [x]" or prefix == "- [ ]" then
    local new = ""
    if prefix == "- [ ]" then
      new = "- [x]"
    elseif prefix == "- [x]" then
      new = "- [ ]"
    else
    end
    vim.api.nvim_set_current_line(new .. string.sub(line, 6))
  else
    vim.api.nvim_set_current_line("- [ ] " .. line)
    -- 在 Neovim 中设置新的光标位置
    local currentPos = vim.api.nvim_win_get_cursor(0)
    local newPos = { currentPos[1], currentPos[2] + 6 }
    vim.api.nvim_win_set_cursor(0, newPos)
  end
end

function M.setup(lspconfig, capabilities, on_attach)
  lspconfig["marksman"].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      --print(vim.json.encode(v1))
      on_attach(client, bufnr)
      if client.name == "marksman" then
        local keymap = vim.keymap
        -- 复用 opt 参数
        local opt = { silent = true, buffer = bufnr, noremap = true }
        --local opt = { noremap = true, silent = true, buffer = v2 }
        --        print("set cl ")
        --vim.api.nvim_set_keymap("i", "<C-l>", M.markdown_todo, opt)
        keymap.set("i", "<c-l>", M.markdown_todo, opt)
        keymap.set("i", "<c-h>", M.markdown_head, opt)

        keymap.set("n", "<leader>m", ":MarkdownPreview<CR>", opt)

        local venn_enabled = vim.inspect(vim.b.venn_enabled)
        if venn_enabled == "nil" then
          vim.b.venn_enabled = true
          vim.cmd([[setlocal ve=all]])
          -- draw a line on HJKL keystokes
          keymap.set("n", "J", "<C-v>j:VBox<CR>", opt)
          keymap.set("n", "K", "<C-v>k:VBox<CR>", opt)
          keymap.set("n", "L", "<C-v>l:VBox<CR>", opt)
          keymap.set("n", "H", "<C-v>h:VBox<CR>", opt)
          keymap.set("v", "f", ":VBox<CR>", opt)
        else
          vim.cmd([[setlocal ve=]])
          vim.cmd([[mapclear <buffer>]])
          vim.b.venn_enabled = nil
        end
        vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
      end
    end,
  })
end

return M
