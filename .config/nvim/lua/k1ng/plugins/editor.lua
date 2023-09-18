return {
  'tpope/vim-repeat',
  'AndrewRadev/splitjoin.vim',
  {
    'mbbill/undotree', -- undotree
    keys = {
      { '<leader>ut', '<cmd>UndotreeToggle<CR>', desc = '[U]ndo [T]ree' },
    },
  },
  { "tpope/vim-surround",    lazy = false },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  { 'numToStr/Comment.nvim', opts = {} },
  {
    "iamcco/markdown-preview.nvim",
    ft = 'md',
    build = function()
      vim.fn["mkdp#util#install"]()
    end
  },
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy'
  },
  {
    'max397574/better-escape.nvim',
    event = 'InsertEnter',
    config = function()
      require('better_escape').setup {
        mapping = { 'jk', 'jj' },
        timeout = vim.o.timeoutlen,
        clear_empty_lines = true,
        keys = '<Esc>',
      }
    end
  }
}
