local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

  --markdonw
  {
    "iamcco/markdown-preview.nvim",
    --cmd = "cd app && npm install",
    --opts = function() vim.g.mkdp_filetypes = { "markdown" } end,
    config = function()
      vim.g.mkdp_path_to_chrome = "google-chrome-stable"
      vim.g.mkdp_theme = 'dark'
    end,
  },
  {
    'voldikss/vim-floaterm',
    config = function()
      require("plugin-config.fterm").setup()
      require("plugin-config.fterm").config()
    end

  },
  { "CRAG666/code_runner.nvim",
    config = function()
      require('code_runner').setup(
      -- put here the commands by filetype
        {
          mode = 'float',
          float = {
            border = 'single'
          }
        }
      )
    end
  },
  {
    'preservim/tagbar'
  },
  {
    'marko-cerovac/material.nvim',
    config = function()
      --require("colorscheme")
    end,
  },
  {
    'bluz71/vim-nightfly-colors'
  },
  {'folke/tokyonight.nvim',
    config = function ()
      require("colorscheme")
    end
  },
  { "catppuccin/nvim", name = "catppuccin" },
  --"puremourning/vimspector",
  -- 功能性插件
  -- 跳转插件
  {
    'tpope/vim-fugitive'
  },
  {
    'ggandor/leap.nvim',
    lazy = true,
    config = function()
      require("plugin-config.leap-conf")
    end,
  },
  -- surround
  "yaocccc/vim-surround",
  -- 文件树
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugin-config.nvim-tree")
    end
  },
  -- 文件树拓展 project
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugin-config.project")
    end
  },
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
    "moll/vim-bbye"
  },
  {
    'willothy/nvim-cokeline',
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require "plugin-config.cokeline"
    end
  },
  --"arkav/lualine-lsp-progress",
  -- telescope
  { "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("plugin-config.telescope")
    end
  },
  -- zfz telescope的拓展
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    --cmd = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    dependencies = { "nvim-telescope/telescope.nvim" }
  },
  -- telescope-env
  {
    "LinArcX/telescope-env.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" }
  },
  -- 启动页面
  -- dashboard-nvim
  { 'kyazdani42/nvim-web-devicons' },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require("plugin-config.dashboard")
    end,
    dependencies = "kyazdani42/nvim-web-devicons",
  },
  -- 代码高亮
  --[[ use {
    "shift-d/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  } ]]
  ------- LSP -----
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "ray-x/go.nvim",
      "ray-x/guihua.lua",
    },
    config = function()
      require "lsp.lsp"
    end
  },
  { "williamboman/mason.nvim",
    config = function()
      require "lsp.mason"
    end
  },
  { "mfussenegger/nvim-dap" },
  { "jose-elias-alvarez/null-ls.nvim" },
  --- cmp

  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- for autocompletion
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      "rafamadriz/friendly-snippets", -- useful snippets
    },
    config = function()
      require "lsp.cmp"
    end
  },
  {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        vim.api.nvim_create_autocmd({"BufRead"}, {
          group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
          pattern = "Cargo.toml",
          callback = function()
            require('crates').setup()
            local cmp = require("cmp")
            cmp.setup.buffer({ sources = { { name = "crates" } } })
          end,
        })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lsp.saga")
    end,
  }, -- enhanced lsp uis

  -- 常见编程语言代码段
  {
    'honza/vim-snippets',
  },
  -- JSON 增强
  "b0o/schemastore.nvim",


  { "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require "lsp.trouble"
    end
  },
  { "jose-elias-alvarez/typescript.nvim" }, -- additional functionality for typescript server (e.g. rename file & update imports)
  { "onsails/lspkind.nvim" }, -- vs-code like icons for autocompletion
  { "simrat39/rust-tools.nvim" }, -- rust server

  -- formatting & linting
  { "jose-elias-alvarez/null-ls.nvim" }, -- configure formatters & linters
  { "jayp0521/mason-null-ls.nvim" }, -- bridges gap b/w mason & null-ls


  -- treesitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    config = function ()
      require "plugin-config.nvim-treesitter"
    end,
  },

  -- 输入法切换，当模式成为 normal模式的时候
  'h-hg/fcitx.nvim',
  -- 标签智能补全
  -- use 'windwp/nvim-ts-autotag'
  -- 注释
  {
    'numToStr/comment.nvim',
    config = function()
      require("plugin-config.coment")
    end
  },
  {
    'yaocccc/nvim-hlchunk',
    config = function()
    end,
  },
})
