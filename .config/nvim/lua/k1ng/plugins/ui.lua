return {
  {
    'nvim-tree/nvim-web-devicons',
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'mocha',
      transparent_background = true,
      term_colors = true,
      show_end_of_buffer = false,
      integrations = {
        alpha = true,
        cmp = true,
        gitsigns = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = true,
        notify = true,
        neotree = true,
        which_key = true,
        fidget = true,
        dashboard = true,
        harpoon = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        navic = { enabled = true, custom_bg = 'NONE' },
        neotest = true,
        noice = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme('catppuccin')

      -- Eyeliner
      local colors = require('catppuccin.palettes').get_palette('mocha')
      vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = colors.flamingo, bold = true, underline = true })
      vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = colors.pink, underline = true })
    end,
  },
}
