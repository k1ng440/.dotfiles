return {
  { "tpope/vim-surround",        lazy = false },
  { 'tpope/vim-repeat',          event = 'VeryLazy' },
  { 'AndrewRadev/splitjoin.vim', event = 'VeryLazy' },
  { 'numToStr/Comment.nvim',     event = 'VeryLazy' },
  { 'chentoast/marks.nvim',      event = 'VeryLazy' },
  {
    'mbbill/undotree', -- undotree
    event = 'VeryLazy',
    keys = {
      { '<leader>ut', '<cmd>UndotreeToggle<CR>', desc = '[U]ndo [T]ree' },
    },
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
    "iamcco/markdown-preview.nvim",
    ft = 'md',
    build = function()
      vim.fn["mkdp#util#install"]()
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      position = "right",
    },
  },
}
