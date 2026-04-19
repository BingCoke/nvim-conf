
local language = require("language").language
local ts = require("language").ts


return {
  {
    "windwp/nvim-autopairs",
    dependencies = {},
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      local ts_conds = require('nvim-autopairs.ts-conds')

      npairs.setup({
        check_ts = true,
      })

    end,
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter")
      .install({
        "rust",
        "javascript",
        "zig",
        "json",
        "html",
        "lua",
        "vim",
        "bash",
        "typespec",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "java",
        "yaml",
        "go",
        "markdown",
        "markdown_inline",
        "dart",
        "http",
      })
      :wait(300000)
    end,
    ft = language,
    enabled = true,
  },

  -- 跳转引用 
  {
    "mawkler/refjump.nvim",
    event = "LspAttach", -- Uncomment to lazy load
    opts = {
      keymaps = {
        enable = true,
        next = "<M-n>", -- Keymap to jump to next LSP reference
        prev = "<M-p>", -- Keymap to jump to previous LSP reference
      },
      highlights = {
        enable = true, -- Highlight the LSP references on jump
        auto_clear = true, -- Automatically clear highlights when cursor moves
      },
    },
  },

  -- 注释
  {
    "numToStr/comment.nvim",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        enabled = true,
        opts = {},
      },
    },
    config = function()
      require("config.comment")
    end,
    ft = language,
  },
  -- 线
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({})
    end,
    enabled = true,
    ft = language,
  },



  ---- 折叠
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("config.ufo")

    end,
    ft = language,
  },


  {
    "lewis6991/gitsigns.nvim",
    opts = {
    },
    config=function ()
      require("gitsigns").setup({})
      
    end,
    ft = language,
  },


  {
    "stevearc/conform.nvim",
    config = function()
      require("config.conform")
    end,
    event = "BufRead",
  },

  {
    "edolphin-ydf/goimpl.nvim",
    enabled = false,
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-telescope/telescope.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    config = function()
      require("telescope").load_extension("goimpl")
      vim.api.nvim_set_keymap(
        "n",
        "<leader>mi",
        [[<cmd>lua require'telescope'.extensions.goimpl.goimpl{}<CR>]],
        { noremap = true, silent = true }
      )
    end,
    ft = "go",
  },

	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		ft = language,
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
  -- {
  --   "nabekou29/js-i18n.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = {},
  -- },

}
