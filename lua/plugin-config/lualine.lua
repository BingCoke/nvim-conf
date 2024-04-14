local status, lualine = pcall(require, "lualine")
if not status then
  return
end

lualine.setup({
  options = {
    icons_enabled = true,
    --section_separators = { left = "", right = "" },
    section_separators = { left = " ", right = " " },
    component_separators = { left = " ", right = " " },
    disabled_filetypes = { "Outline" },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        icons_enabled = false,
        color = { fg = "grey" }
      },
    },
    lualine_b = {
      "branch",
    },
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0,           -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = {
      "rest",
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
      },
      "encoding",
      "filetype",
    },
    lualine_z = {
      {
        "location",
        color = { fg = "grey" }
      }

    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 0,           -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = { { "location", color = { fg = 'grey' } } },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "fugitive", "neo-tree", "nvim-dap-ui", "mason", "lazy", "man" },
})
