local packer = require("packer")

packer.startup(function(use)
  -- Packer 可以管理自己本身
  use("wbthomason/packer.nvim")
  --markdonw
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })
  -- 主题
  use("shaunsingh/nord.nvim")
  use "joshdick/onedark.vim"
  use 'marko-cerovac/material.nvim'

  use("puremourning/vimspector")
  use "EdenEast/nightfox.nvim"
  -- 功能性插件
  -- 跳转插件
  use 'ggandor/leap.nvim'
  -- surround
  use "yaocccc/vim-surround"
  -- 标签页
  use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
  -- ranger
  -- use 'francoiscabrol/ranger.vim'
  use "rbgrouleff/bclose.vim"
  -- 文件树
  use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
  -- 文件树拓展 project
  use("ahmedkhalf/project.nvim")
  -- 加载
  --  use ('j-hui/fidget.nvim')
  -- lualine
  use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
  use("arkav/lualine-lsp-progress")
  -- telescope
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- zfz telescope的拓展
  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  })
  -- telescope-env
  use("LinArcX/telescope-env.nvim")
  -- 启动页面
  -- dashboard-nvim
  use {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require("plugin-config.dashboard")
    end,
    requires = { 'nvim-tree/nvim-web-devicons' }
  }
  -- 代码高亮
  --[[ use {
    "shift-d/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  } ]]
  ------- LSP -----
  use({ "williamboman/mason.nvim" })
  --use({ "williamboman/mason-lspconfig.nvim" })
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'Alloyed/lua-lsp'
  use 'IngoMeyer441/coc_current_word'


  -- 常见编程语言代码段
  use 'honza/vim-snippets'
  -- JSON 增强
  use("b0o/schemastore.nvim")

  ---------- DAP debug------
  -- use("mfussenegger/nvim-dap")
  -- use("theHamsta/nvim-dap-virtual-text")
  -- use("rcariga/nvim-dap-ui")
  -- 输入法切换，当模式成为 normal模式的时候
  use 'h-hg/fcitx.nvim'
  -- 标签智能补全
  -- use 'windwp/nvim-ts-autotag'
  -- 注释
  use 'numToStr/comment.nvim'
  -- 翻译
  use 'voldikss/vim-translator'

  --


  use {
    'gelguy/wilder.nvim',
    config = function()
      -- config goes here
    end,
  }
end)
config = {
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
}
-- 每次保存 plugins.lua 自动安装插件
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)
