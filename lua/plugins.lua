local packer = require("packer")

packer.startup(function(use)
	-- Packer 可以管理自己本身
	use("wbthomason/packer.nvim")
  --markdonw
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
	-- 中文
	--use "yianwillis/vimcdoc"
	-- 主题
	use("folke/tokyonight.nvim")
	use("shaunsingh/nord.nvim")
	--use 'arcticicestudio/nord-vim'
	use "EdenEast/nightfox.nvim"
	-- 功能性插件
	-- 跳转插件
	use 'easymotion/vim-easymotion'
	--use 'ggandor/leap.nvim'
	-- surround
	use "yaocccc/vim-surround"
	-- 标签页
	use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })
	-- 文件树
	use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
	-- 文件树拓展 project
	use("ahmedkhalf/project.nvim")
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
	use("glepnir/dashboard-nvim")
	-- 代码高亮
	use 'lfv89/vim-interestingwords'
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	------- LSP -----
	use({ "williamboman/mason.nvim" })
	--use({ "williamboman/mason-lspconfig.nvim" })
	use {'neoclide/coc.nvim', branch = 'release'}
	use 'Alloyed/lua-lsp'
	-- Lspconfig
	--use({ "neovim/nvim-lspconfig" })
	-- lua
	-- Lua 增强
	--use("folke/neodev.nvim")
	-- tsserver 增强
	--use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lua/plenary.nvim" })
	--use("jose-elias-alvarez/typescript.nvim")
	-- 补全引擎
	--use("hrsh7th/nvim-cmp")
	-- snippet 引擎
	--use("hrsh7th/vim-vsnip")
	--use 'hrsh7th/vim-vsnip-integ'
	-- 补全源
	--use("hrsh7th/cmp-vsnip")
	-- use("hrsh7th/cmp-nvim-lsp") -- { name = nvim_lsp }
	-- use("hrsh7th/cmp-buffer") -- { name = 'buffer' },
	-- use("hrsh7th/cmp-path") -- { name = 'path' }
	-- use("hrsh7th/cmp-cmdline") -- { name = 'cmdline' }

	-- 常见编程语言代码段
  use 'honza/vim-snippets'
	-- ui 代码提示的ui显示
	--[[ use("onsails/lspkind-nvim")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			local saga = require("lspsaga")

			saga.init_lsp_saga({
				-- your configuration
			})
		end,
	})
	-----------------------------------S------------------------------
	-- 代码格式化
	-- use("mhartington/formatter.nvim")
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" }) ]]
	-- JSON 增强
	use("b0o/schemastore.nvim")

	---------- DAP debug------
	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/nvim-dap-ui")
	-- 输入法切换，当模式成为 normal模式的时候
	use 'h-hg/fcitx.nvim'
	-- 标签智能补全
	use 'windwp/nvim-ts-autotag'
	-- 注释
	use 'numToStr/comment.nvim'
	-- 翻译
	use 'voldikss/vim-translator'
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
