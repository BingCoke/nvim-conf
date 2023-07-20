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
  "html",
  "css",
  "markdown",
  "yaml",
  "yml",
  "json",
  "jsonc",
  "lua",
  "xml",
  "sh",
  "toml",
  "typst",
  "sql",
  "typescript",
  "typescriptreact",
  "javascript",
  "javascriptreact",
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
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function(self, opts)
      require("plugin-config.noice")
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function(opts, self)
      require("plugin-config.symbols-outline")
    end,
    ft = language,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(self, opts)
      require("plugin-config.flash")
    end,
  },
  -- autopairs
  {
    "windwp/nvim-autopairs",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("plugin-config.autopairs")
    end,
    ft = language,
  },
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
    event = { "UIEnter" },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function(self, opts)
      require("plugin-config.neotree")
    end,
    event = { "VeryLazy" },
  },
  -- 文件树拓展 project
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugin-config.project")
    end,
    lazy = true,
  },
  -- 加载
  -- -- lualine
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/tokyonight.nvim",
    },
    config = function()
      require("plugin-config.lualine")
    end,
    event = "VeryLazy",
  },
  {
    "romgrk/barbar.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
      --"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
      -- 页面关闭
      "moll/vim-bbye",
    },
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
      --"nvim-telescope/telescope-project.nvim",
      --"nvim-telescope/telescope-file-browser.nvim",
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
    event = "VeryLazy",
  },
  {
    "glepnir/dashboard-nvim",
    event = "UIEnter",
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
      "jose-elias-alvarez/typescript.nvim",
    },
    config = function()
      require("lsp.mason")
      require("lsp.lsp")
    end,
    ft = language,
    event = { "VeryLazy" },
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    config = function(self)
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
  {
    "kaarmu/typst.vim",
    ft = "typst",
    lazy = false,
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
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
    event = "VeryLazy",
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
    ft = language,
  },
  --- flutter
  {
    "akinsho/flutter-tools.nvim",
    event = "LspAttach",
    config = function(self, opts) end,
  },
  {
    "nvimdev/lspsaga.nvim",
    branch = "main",
    config = function()
      require("lsp.saga")
    end,
    ft = language,
  }, -- enhanced lsp uis
  {
    "DNLHC/glance.nvim",
    config = function(self, opts)
      require("plugin-config.glance")
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
  -- language ts
  {
    "windwp/nvim-ts-autotag",
    config = function(self, opts)
      require("nvim-ts-autotag").setup()
    end,
    ft = language,
  },
  {
    "NvChad/nvim-colorizer.lua",
    config = function(self, opts)
      require("plugin-config.color")
    end,
    event = "BufReadPre",
  },

  -- dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "mxsdev/nvim-dap-vscode-js",
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    config = function()
      require("dap.dap")
      require("dap.dap-virtual-text")
      require("dap.dap-ui")
      require("dap.dap-keymap")
    end,
    ft = {
      "rust",
      "go",
      "python",
      "shell",
      "dart",
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
    },
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
      "jcha0713/cmp-tw2css",
      {
        "js-everts/cmp-tailwind-colors",
        opts = {},
        config = function()
          require("cmp-tailwind-colors").setup({})
        end,
      },
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
    ft = "markdown",
  },
  {
    "yaocccc/nvim-hl-mdcodeblock.lua",
    config = function(self, opts)
      require("hl-mdcodeblock").setup({
        -- option
      })
    end,
    ft = { "markdown" },
  },
  -- 线
  {
    "yaocccc/nvim-hlchunk",
    config = function() end,
    ft = language,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function(self, opts)
      vim.g.indent_blankline_filetype_exclude = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "dashboard",
        "",
      }

      vim.g.indentLine_fileTypeExclude = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "dashboard",
        "",
      }
      require("indent_blankline").setup({
        -- for example, context is off by default, use this to turn it on
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
    ft = language,
  },
})
