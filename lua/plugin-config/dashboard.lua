require('dashboard').setup {
  theme = 'doom',
  config = {
    center = {
      {
        icon = "  ",
        desc = "Projects                            ",
        key = "p",
        action = "Telescope projects",
      },
      {
        icon = "  ",
        key = "c",
        desc = "current                            ",
        action = "Telescope find_files",
      },
      {
        icon = "  ",
        key = "r",
        desc = "Recently files                      ",
        action = "Telescope oldfiles",
      },
      {
        icon = "  ",
        key = "s",
        desc = "Edit Snippets                    ",
        action = "edit ~/.config/nvim/my-snippets",
      },
      {
        icon = "  ",
        key = "e",
        desc = "Edit Projects                       ",
        action = "edit ~/.local/share/nvim/project_nvim/project_history",
      },
      {
        icon = "  ",
        key = "z",
        desc = "Edit .zshrc                        ",
        action = "edit ~/.zshrc",
      },
    },
    footer = {
      "",
      "",
      "hello world !",
    },

    header = {
      [[ _          _ _         ____  _              ____      _         ]],
      [[| |__   ___| | | ___   | __ )(_)_ __   __ _ / ___|___ | | _____  ]],
      [[| '_ \ / _ \ | |/ _ \  |  _ \| | '_ \ / _` | |   / _ \| |/ / _ \ ]],
      [[| | | |  __/ | | (_) | | |_) | | | | | (_| | |__| (_) |   <  __/ ]],
      [[|_| |_|\___|_|_|\___/  |____/|_|_| |_|\__, |\____\___/|_|\_\___| ]],
      [[                                      |___/                      ]],

    }

  }
}
