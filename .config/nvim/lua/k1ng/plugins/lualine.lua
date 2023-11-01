return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'BufEnter',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    config = function()
      vim.defer_fn(function()
        require('k1ng.plugin-configs.lualine')
      end, 10)
    end,
  },
}
