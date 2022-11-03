local packer = require("packer")
packer.startup(
  function(use)
   -- Packer 可以管理自己本身
   use 'wbthomason/packer.nvim'
   -- 主题
   use "olimorris/onedarkpro.nvim"
   use "folke/tokyonight.nvim"
   use "shaunsingh/nord.nvim"
   -- 功能性插件
   -- 标签页
   use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" }})
   -- 文件树
   use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
   -- 文件树拓展 project
   use("ahmedkhalf/project.nvim")
   -- lualine
   use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
   use("arkav/lualine-lsp-progress")
   -- telescope
   use { 'nvim-telescope/telescope.nvim', requires = { "nvim-lua/plenary.nvim" } }
   -- zfz telescope的拓展
   use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
   -- telescope-env
   use "LinArcX/telescope-env.nvim"
   -- 启动页面
   -- dashboard-nvim 
    use("glepnir/dashboard-nvim")
    -- 代码高亮
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
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
