return {
  {
    'nvim-tree/nvim-web-devicons',
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function()
      require('k1ng.plugin-configs.catppuccin')
    end,
  },
}
