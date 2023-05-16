---@diagnostic disable: unused-local
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local language = {
  "c",
  "cpp",
  "rust",
  "go",
  "python",
  "javascript",
  "html",
  "css",
  "markdown",
  "yaml",
  "json",
  "lua",
  "typescript",
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
  -- autopairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugin-config.autopairs")
    end,
  },
  --markdonw preview
  {
    "iamcco/markdown-preview.nvim",
    --cmd = "cd app && npm install",
    --opts = function() vim.g.mkdp_filetypes = { "markdown" } end,
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
  },
  -- tokyngingt
  {
    "folke/tokyonight.nvim",
    config = function()
      require("colorscheme")
    end,
  },
  --"puremourning/vimspector",
  -- 功能性插件
  -- 跳转插件
  -- vim
  --[[ {
    "tpope/vim-fugitive",
  }, ]]
  -- surround
  "yaocccc/vim-surround",
  -- 文件树
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugin-config.nvim-tree")
    end,
  },
  -- 文件树拓展 project
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugin-config.project")
    end,
  },
  -- language ts
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
    end,
    ft = { "js", "ts" },
  }, -- additional functionality for typescript server (e.g. rename file & update imports)
  -- 加载
  --  use ('j-hui/fidget.nvim')
  -- -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("plugin-config.lualine")
    end,
  },
  {
    "romgrk/barbar.nvim",
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
  --[[ {
    "willothy/nvim-cokeline",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugin-config.cokeline")
    end,
  }, ]]
  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugin-config.telescope")
    end,
  },
  -- 启动页面
  -- dashboard-nvim
  { "kyazdani42/nvim-web-devicons" },
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("plugin-config.dashboard")
    end,
    dependencies = "kyazdani42/nvim-web-devicons",
  },
  ------- LSP -----
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
      "onsails/lspkind.nvim",
      "lvimuser/lsp-inlayhints.nvim",
    },
    config = function()
      require("lsp.mason")
      require("lsp.lsp")
      require("lsp.lspkind")
      require("lsp.inlayghints")
    end,
    ft = language,
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
      local cfg = {
        floating_window = false,
      } -- add your config here
      require("lsp_signature").setup(cfg)
    end,
    ft = language,
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
  -- language rust
  --[[ {
    --"simrat39/rust-tools.nvim", -- rust server
    dir = "/home/bk/tmp/rust-tools.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("language.rust")
    end,
    event = "BufEnter Cargo.toml",
    ft = { "rust" },
  }, ]]
  -- language ts
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "js", "ts" },
  }, -- additional functionality for typescript server (e.g. rename file & update imports)
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
      "rafamadriz/friendly-snippets", -- useful snippets
      "honza/vim-snippets",
    },
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
    },
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
    requires = "kyazdani42/nvim-web-devicons",
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
  },
  -- 高亮当前单词
  {
    "RRethy/vim-illuminate",
    config = function()
    end,
    ft = language,
  },
  --[[ {
    "stevearc/overseer.nvim",
    opts = {},
    config = function(self, opts)
      require("overseer").setup()
    end,
    ft = language,
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
    --ft = language,
  },
  -- 输入法切换，当模式成为 normal模式的时候
  "h-hg/fcitx.nvim",
  -- 标签智能补全
  -- use 'windwp/nvim-ts-autotag'
  -- 注释
  {
    "numToStr/comment.nvim",
    config = function()
      require("plugin-config.coment")
    end,
  },
  -- 线
  {
    "yaocccc/nvim-hlchunk",
    config = function()
    end,
    --ft = language,
  },
})
