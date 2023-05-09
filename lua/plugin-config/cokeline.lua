local map = vim.api.nvim_set_keymap

map('n', '<c-h>', '<Plug>(cokeline-focus-prev)', { silent = true })
map('n', '<c-l>', '<Plug>(cokeline-focus-next)', { silent = true })
map('n', '<a-p>', '<Plug>(cokeline-switch-prev)', { silent = true })
map('n', '<a-n>', '<Plug>(cokeline-switch-next)', { silent = true })
--map('n', '<a-w>', '<Plug>(cokeline-pick-close)', { silent = true })
map('n', '<a-w>', ':Bdelete<CR>', { silent = true })

for i = 1, 9 do
  map('n', ('<a-%s>'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i), { silent = true })
  map('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
end
-- https://www.baidu.cm

local get_hex = require('cokeline/utils').get_hex
local mappings = require('cokeline/mappings')

local comments_fg = get_hex('Comment', 'fg')
local errors_fg = get_hex('DiagnosticError', 'fg')
local warnings_fg = get_hex('DiagnosticWarn', 'fg')

local red = vim.g.terminal_color_2
local yellow = vim.g.terminal_color_3

local flush = require("coc.coc_flush")
vim.cmd(
  [[autocmd User CocDiagnosticChange lua require('coc.coc_flush').flush()]]
)

local components = {
  space = {
    text = ' ',
    truncation = { priority = 1 }
  },
  two_spaces = {
    text = ' ',
    truncation = { priority = 1 },
  },
  separator = {
    text = function(buffer)
      return buffer.index ~= 1 and '▏' or ''
    end,
    truncation = { priority = 1 }
  },
  devicon = {
    text = function(buffer)
      return
          (mappings.is_picking_focus() or mappings.is_picking_close())
          and buffer.pick_letter .. ''
          or buffer.devicon.icon
    end,
    fg = function(buffer)
      return
          (mappings.is_picking_focus() and yellow)
          or (mappings.is_picking_close() and red)
          or buffer.devicon.color
    end,
    style = function(_)
      return
          (mappings.is_picking_focus() or mappings.is_picking_close())
          and 'italic,bold'
          or nil
    end,
    truncation = { priority = 1 }
  },
  index = {
    text = function(buffer)
      return buffer.index .. ':'
    end,
    truncation = { priority = 1 }
  },
  unique_prefix = {
    text = function(buffer)
      return buffer.unique_prefix
    end,
    fg = comments_fg,
    style = 'italic',
    truncation = {
      priority = 3,
      direction = 'left',
    },
  },
  filename = {
    text = function(buffer)
      return buffer.filename
    end,
    style = function(buffer)
      return
          ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
          and 'bold,underline')
          or (buffer.is_focused and 'bold')
          or (buffer.diagnostics.errors ~= 0 and 'underline')
          or nil
    end,
    truncation = {
      priority = 2,
      direction = 'left',
    },
  },
  diagnostics = {
    text = function(buffer)
      local info = vim.b.coc_diagnostic_info;
      if info == nil then
        return '  '
      end

      if buffer.is_focused == false then
        return '  '
      end
      if vim.b.coc_diagnostic_info.error > 0 then
        return ' '
      end
      --[[ if vim.b.coc_diagnostic_info.warning > 0 then
        return ' '
      end ]]
      return '  '
    end,
    fg = function(buffer)
      local info = vim.b.coc_diagnostic_info;
      if info == nil then
        return nil
      end

      if buffer.is_focused == false then
        return nil
      end

      return
          (info.errors ~= 0 and errors_fg)
          or (info.warning ~= 0 and warnings_fg)
          or nil
    end,
    truncation = { priority = 1 },
  },
  close_or_unsaved = {
    text = function(buffer)
      return buffer.is_modified and '●' or ''
    end,
    fg = function(buffer)
      return buffer.is_modified and green or nil
    end,
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}

require('cokeline').setup({
  show_if_buffers_are_at_least = 1,
  buffers = {
    -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
    -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
    new_buffers_position = 'next',
  },
  rendering = {
    max_buffer_width = 30,
  },
  default_hl = {
    fg = function(buffer)
      return buffer.is_focused and "NONE" or "#5f6a8e"
    end,
    bg = function(buffer)
      return "NONE"
    end,
    style = function(buffer)
      return buffer.is_focused and "bold" or nil
    end,
  },
  sidebar = {
    filetype = 'NvimTree',
    components = {
      {
        text = '  NvimTree',
        fg = yellow,
        bg = get_hex('NvimTreeNormal', 'bg'),
        style = 'bold',
      },
    }
  },
  components = {
    components.space,
    components.separator,
    components.space,
    components.devicon,
    components.index,
    components.unique_prefix,
    components.filename,
    components.diagnostics,
    components.space,
    components.close_or_unsaved,
    components.space,
  },
})
