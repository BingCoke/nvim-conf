--local packer = require("packer")
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
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  { "CRAG666/code_runner.nvim",
    config = function()
      require('code_runner').setup(
      -- put here the commands by filetype
      )
    end
  },
  {
    'marko-cerovac/material.nvim',
    config = function()
      require("colorscheme")
    end,
  },
  {
    'bluz71/vim-nightfly-colors'
  },
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
  --[[   {
    'vim-airline/vim-airline',
    -- dependencies = { 'vim-airline/vim-airline' },
    config = function()
      vim.g.airline_theme = 'icebergDark'
    end
  }, ]]
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
  --use({ "williamboman/mason.nvim" })
  --use({ "williamboman/mason-lspconfig.nvim" })
  {
    'fannheyward/telescope-coc.nvim',
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          coc = {
            theme = 'ivy',
            prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
          }
        },
      })
      require('telescope').load_extension('coc')
    end
  },


  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      require("coc.coc-basic")
      require("coc.coc-need")
    end

  },
  --use 'Alloyed/lua-lsp'
  {
    'IngoMeyer441/coc_current_word',
    dependencies = { "neoclide/coc.nvim" },
    config = function()
      pcall(vim.cmd,
        "hi CurrentWord guifg=#eeeeee guibg=NONE gui=underline,bold,italic ctermfg=NONE ctermbg=NONE cterm=underline,bold,italic")
    end
  },
  -- 常见编程语言代码段
  {
    'honza/vim-snippets',
  },
  -- JSON 增强
  "b0o/schemastore.nvim",
  ---------- DAP debug------
  -- use("mfussenegger/nvim-dap")
  -- use("theHamsta/nvim-dap-virtual-text")
  -- use("rcariga/nvim-dap-ui")
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

  --[[ {
    'gelguy/wilder.nvim',
    config = function()
      -- config goes here
      require("plugin-config.wilder")
    end,
    event = "CmdlineEnter",
  }, ]]
  {
    'yaocccc/nvim-hlchunk',
    config = function()

    end,
  },
})
