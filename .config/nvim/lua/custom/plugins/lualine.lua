return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'catppuccin',
        component_separators = '|',
        section_separators = { left = '', right = '' },
      },
      sections = {
        -- +-------------------------------------------------+
        -- | A | B | C                             X | Y | Z |
        -- +-------------------------------------------------+
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = { 'fileformat' },
        lualine_y = { 'filetype', 'progress' },
        lualine_z = {
          { 'location', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          function() return require("copilot_status").status_string() end,
        },
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    },
  },
}
