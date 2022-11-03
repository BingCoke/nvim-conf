
local status, db = pcall(require, "dashboard")
if not status then
  vim.notify("没有找到 dashboard")
  return
end

db.custom_footer = {
  "",
  "",
  "hello world !",
}

db.custom_center = {
  {
    icon = "  ",
    desc = "Projects                            ",
    action = "Telescope projects",
  },
  {
    icon = "  ",
    desc = "Recently files                      ",
    action = "Telescope oldfiles",
  },
  {
    icon = "  ",
    desc = "Edit keybindings                    ",
    action = "edit ~/.config/nvim/lua/keybindings.lua",
  },
  {
    icon = "  ",
    desc = "Edit Projects                       ",
    action = "edit ~/.local/share/nvim/project_nvim/project_history",
  },
  -- {
  --   icon = "  ",
  --   desc = "Edit .bashrc                        ",
  --   action = "edit ~/.bashrc",
  -- },
  -- {
  --   icon = "  ",
  --   desc = "Change colorscheme                  ",
  --   action = "ChangeColorScheme",
  -- },
  -- {
  --   icon = "  ",
  --   desc = "Edit init.lua                       ",
  --   action = "edit ~/.config/nvim/init.lua",
  -- },
  -- {
  --   icon = "  ",
  --   desc = "Find file                           ",
  --   action = "Telescope find_files",
  -- },
  -- {
  --   icon = "  ",
  --   desc = "Find text                           ",
  --   action = "Telescopecope live_grep",
  -- },
}


db.custom_header = {

[[ _          _ _         ____  _              ____      _         ]],
[[| |__   ___| | | ___   | __ )(_)_ __   __ _ / ___|___ | | _____  ]],
[[| '_ \ / _ \ | |/ _ \  |  _ \| | '_ \ / _` | |   / _ \| |/ / _ \ ]],
[[| | | |  __/ | | (_) | | |_) | | | | | (_| | |__| (_) |   <  __/ ]],
[[|_| |_|\___|_|_|\___/  |____/|_|_| |_|\__, |\____\___/|_|\_\___| ]],
[[                                      |___/                      ]],

}
