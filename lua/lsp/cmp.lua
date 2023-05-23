-- import nvim-cmp plugin safely
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end
local luasnip = require("luasnip")
-- import lspkind plugin safely
local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
  return
end

-- load vs-code like snippets from plugins (e.g. friendly-snippets)

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
--

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

-- load snippets from path/of/your/nvim/config/my-cool-snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets" } })
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  --[[ completion = {
    keyword_lenth = 1,
  }, ]]
  view = {
    --entries = {name = 'native' }
  },
  mapping = {
    ["<c-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<c-j>"] = cmp.mapping.select_next_item(), -- next suggestion

    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),

    ["<A-Space>"] = cmp.mapping.complete({
      config = {
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        },
      },
    }),                            -- show completion suggestions

    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),

    -- 自定义代码段跳转到下一个参数
    ["<c-l>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<c-h>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
  },
  -- 阻止预选则
  preselect = cmp.PreselectMode.None,
  -- sources for autocompletion
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" }, -- text within current buffer
    { name = "path" }, -- file system paths
  }),
  -- configure lspkind for vs-code like icons
  --formatting = require("cmp.lspkind").formatting,
  formatting = {
    fields = { "abbr", "kind", "menu" },
    duplicates = {
      buffer = 1,
      path = 1,
      nvim_lsp = 0,
      luasnip = 1,
    },
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 30,      -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
    }),
  },
  window = {
    -- 弹窗设置出来一个边框
    completion = cmp.config.window.bordered(),
    -- doc边框
    documentation = {
      border = border("CmpDocBorder"),
      winhighlight = "Normal:CmpDoc",
      max_width = 20,
    },
  },
})

-- / 查找模式使用 buffer 源
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- : 命令行模式中使用 path 和 cmdline 源.
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

-- auto pair
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local handlers = require("nvim-autopairs.completion.handlers")

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done({
    filetypes = {
      -- "*" is a alias to all filetypes
      ["*"] = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          handler = handlers["*"],
        },
      },
      rust = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          ---@param char string
          ---@param item table item completion
          ---@param bufnr number buffer number
          ---@param rules table
          ---@param commit_character table<string>
          handler = function(char, item, bufnr, rules, commit_character)
            -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
          end,
        },
      },
      lua = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          ---@param char string
          ---@param item table item completion
          ---@param bufnr number buffer number
          ---@param rules table
          ---@param commit_character table<string>
          handler = function(char, item, bufnr, rules, commit_character)
            -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
          end,
        },
      },
      python = {
        ["("] = {
          kind = {
            cmp.lsp.CompletionItemKind.Function,
            cmp.lsp.CompletionItemKind.Method,
          },
          ---@param char string
          ---@param item table item completion
          ---@param bufnr number buffer number
          ---@param rules table
          ---@param commit_character table<string>
          handler = function(char, item, bufnr, rules, commit_character)
            -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr, rules, commit_character})
          end,
        },
      },
      -- Disable for tex
      tex = false,
    },
  })
)
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

local api = vim.api
local function generate_highlight()
  -- gray
  api.nvim_command("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
  -- blue
  api.nvim_command("highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6")
  api.nvim_command("highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch")
  -- light blue
  api.nvim_command("highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE")
  api.nvim_command("highlight! link CmpItemKindInterface CmpItemKindVariable")
  api.nvim_command("highlight! link CmpItemKindText CmpItemKindVariable")
  -- pink
  api.nvim_command("highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0")
  api.nvim_command("highlight! link CmpItemKindMethod CmpItemKindFunction")
  -- front
  api.nvim_command("highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4")
  api.nvim_command("highlight! link CmpItemKindProperty CmpItemKindKeyword")
  api.nvim_command("highlight! link CmpItemKindUnit CmpItemKindKeyword")



  --api.nvim_command("highlight CmpItemMenu CmpItemKindKeyword")
end

generate_highlight()
