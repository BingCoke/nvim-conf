---@diagnostic disable: unused-local
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local language = {
  "ruby",
  "awk",
  "c",
  "cpp",
  "dart",
  "rust",
  "go",
  "python",
  "javascript",
  "html",
  "css",
  "markdown",
  "yaml",
  "yml",
  "json",
  "lua",
  "typescript",
  "xml",
  "sh",
  "toml",
}

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
-- Example using a list of specs with the default options
require("lazy").setup({
  {
    "simrat39/symbols-outline.nvim",
    config = function(opts, self)
      require("plugin-config.symbols-outline")
    end,
    ft = language,
  },
  --[[ {
    "dstein64/nvim-scrollview"
  }, ]]
  -- autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin-config.autopairs")
    end,
    ft = language,
  },
  --markdonw preview
  --[[ {
    "edluffy/hologram.nvim",
    config = function(self, opts)
      require("hologram").setup({
        auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
      })
    end,
    ft = { "markdown" },
  }, ]]
  {
    "iamcco/markdown-preview.nvim",
    config = function()
      vim.g.mkdp_path_to_chrome = "google-chrome-stable"
      vim.g.mkdp_theme = "dark"
      vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_auto_close = 0
    end,
    ft = { "markdown" },
  },
  -- floaterm
  {
    "voldikss/vim-floaterm",
    config = function()
      require("plugin-config.fterm").setup()
      require("plugin-config.fterm").config()
    end,
    event = "VeryLazy",
  },
  -- tokyngingt
  {
    "folke/tokyonight.nvim",
    config = function()
      require("colorscheme")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      --"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function(self, opts)
      require("plugin-config.neotree")
    end,
    event = "VeryLazy",
  },
  -- 文件树拓展 project
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugin-config.project")
    end,
    event = "VeryLazy",
  },
  -- language ts
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function() end,
    ft = { "js", "ts" },
  }, -- additional functionality for typescript server (e.g. rename file & update imports)
  -- 加载
  --  use ('j-hui/fidget.nvim')
  -- -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugin-config.lualine")
    end,
  },
  {
    "romgrk/barbar.nvim",
    event = "VimEnter",
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      --"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
      -- 页面关闭
      "moll/vim-bbye",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function(self, opts)
      vim.g.barbar_auto_setup = false
      require("plugin-config.barbar")
    end,
  },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("plugin-config.telescope")
    end,
  },
  -- 启动页面
  -- dashboard-nvim
  {
    "nvim-tree/nvim-web-devicons",
    priority = 70,
    config = function(self, opts)
      require("plugin-config.nvim-web-devicions")
    end,
  },
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("plugin-config.dashboard")
    end,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  ------- LSP -----
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "onsails/lspkind.nvim",
      {
        "lvimuser/lsp-inlayhints.nvim",
        init = function(self)
          require("lsp.inlayghints")
          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
            callback = function(args)
              if not (args.data and args.data.client_id) then
                return
              end
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              require("lsp-inlayhints").on_attach(client, args.buf)
            end,
          })
        end,
        ft = language,
      },
    },
    config = function()
      require("lsp.mason")
      require("lsp.lsp")
    end,
    ft = language,
  },
  {
    "folke/neodev.nvim",
    config = function(self, opts)
      require("neodev").setup({
        -- add any options here, or leave empty to use the default settings
      })
    end,
    ft = {
      "lua",
    },
  },
  {
    "onsails/lspkind.nvim",
    config = function(self, opts)
      require("lsp.lspkind")
    end,
    event = "VeryLazy",
  },
  -- JSON 增强
  {
    "b0o/schemastore.nvim",
    config = function()
      -- code
      require("language.json")
    end,
    ft = "json",
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lsp.saga")
    end,
    ft = language,
  }, -- enhanced lsp uis
  -- lsp_signature
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp.lsp_signature")
    end,
    ft = language,
    enabled = false,
  },

  -- language go
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig" },
    config = function()
      require("language.go")
    end,
    --event = "BufEnter *.go",
    ft = "go",
  },
  -- language ts
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "js", "ts" },
  }, -- additional functionality for typescript server (e.g. rename file & update imports)
  {
    "windwp/nvim-ts-autotag",
    config = function(self, opts)
      require("nvim-ts-autotag").setup()
    end,
    ft = language,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function(self, opts)
      require("colorizer").setup()
    end,
  },

  -- dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("dap.dap")
      require("dap.dap-virtual-text")
      require("dap.dap-ui")
      require("dap.dap-keymap")
    end,
    ft = { "rust", "go", "python", "shell" },
  },
  --- cmp
  -- 常见编程语言代码段
  -- 引擎
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "honza/vim-snippets",
      "rafamadriz/friendly-snippets", -- useful snippets
    },
    event = "BufReadPre",
    config = function(self, opts)
      require("luasnip").config.setup({
        history = true,
        --region_check_events = 'CursorMoved'
      })
    end,
  },
  -- cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- for autocompletion
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    event = "VeryLazy",
    config = function()
      require("lsp.cmp")
    end,
  },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
      local cmp = require("cmp")
      cmp.setup.buffer({ sources = { { name = "crates" } } })
    end,
    --  event = "BufEnter Cargo.toml",
    ft = { "toml" },
  },

  -- trouble
  {
    "folke/trouble.nvim",
    dependencies = {},
    config = function()
      require("lsp.trouble")
    end,
    ft = language,
  },

  -- formatting & linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jayp0521/mason-null-ls.nvim",
    },
    config = function()
      require("lsp.null-ls")
    end,
    ft = language,
    --enabled = false,
  },
  -- 高亮当前单词
  {
    "RRethy/vim-illuminate",
    config = function()
      require("plugin-config.illuminate")
    end,
    ft = language,
  },
  --[[ {
    "neoclide/coc.nvim",
    build = "yarn install --frozen-lockfile",
    config = function (self, opts)
      require("coc.coc_tab")
      require("coc.coc_flush")
      require("coc.coc-basic")
      require("coc.coc-need")
    end
  }, ]]
  -- treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugin-config.nvim-treesitter")
    end,
    ft = language,
  },
  -- 折叠
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("plugin-config.ufo")
    end,
    ft = language,
  },
  -- 输入法切换，当模式成为 normal模式的时候
  {
    "h-hg/fcitx.nvim",
    event = "BufReadPre",
  },
  -- 标签智能补全
  -- use 'windwp/nvim-ts-autotag'
  -- 注释
  {
    "numToStr/comment.nvim",
    config = function()
      require("plugin-config.coment")
    end,
    ft = language,
  },
  {
    "jbyuki/venn.nvim",
    --ft = "markdonw",
    config = function(self, opts) end,
  },
  {
    "yaocccc/nvim-hl-mdcodeblock.lua",
    config = function(self, opts)
      require("hl-mdcodeblock").setup({
        -- option
      })
    end,
    ft = { "markdonw" },
  },
  -- 线
  {
    "yaocccc/nvim-hlchunk",
    config = function() end,
    ft = language,
  },
})
