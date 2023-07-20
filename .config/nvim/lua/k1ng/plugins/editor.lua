return {
  'tpope/vim-repeat',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  {
    'mbbill/undotree', -- undotree
    keys = {
      { 'n', '<leader>ut', '<cmd>UndotreeToggle<CR>', desc = '[U]ndo [T]ree' },
    },
  },
  { "tpope/vim-surround", lazy = false },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  { 'numToStr/Comment.nvim',  opts = {} },
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
}
