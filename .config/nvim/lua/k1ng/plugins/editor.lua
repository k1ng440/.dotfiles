return {
  { 'tpope/vim-surround', lazy = false },
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'AndrewRadev/splitjoin.vim', event = 'VeryLazy' },
  { 'chentoast/marks.nvim', event = 'VeryLazy' },
  {
    'mbbill/undotree',
    event = 'VeryLazy',
    keys = {
      { '<leader>ut', '<cmd>UndotreeToggle<CR>', desc = '[U]ndo [T]ree' },
    },
  },
  {
    'numToStr/Comment.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  {
    'simrat39/symbols-outline.nvim',
    cmd = 'SymbolsOutline',
    keys = { { '<leader>cs', '<cmd>SymbolsOutline<cr>', desc = 'Symbols Outline' } },
    opts = {
      position = 'right',
    },
  },
}
