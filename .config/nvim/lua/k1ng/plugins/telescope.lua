local Util = require('k1ng.util')
return {

  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.schedule(function()
        require('k1ng.plugin-configs.telescope-config').setup()
      end)
    end,
  },

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build ' .. '--config Release && cmake --install build --prefix build',
    config = function()
      require('telescope').load_extension('fzf')
    end,
  },
  {
    'danielfalk/smart-open.nvim',
    branch = '0.2.x',
    config = function()
      require('telescope').load_extension('smart_open')
    end,
    dependencies = {
      'kkharji/sqlite.lua',
      { 'nvim-telescope/telescope-fzf-native.nvim' },
    },
  },
}
