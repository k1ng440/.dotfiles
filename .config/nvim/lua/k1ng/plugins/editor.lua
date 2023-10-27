return {
  { 'tpope/vim-surround', event = 'BufEnter' },
  { 'farmergreg/vim-lastplace', event = 'BufEnter' },
  { 'tpope/vim-repeat', event = 'BufEnter' },
  {
    'AndrewRadev/splitjoin.vim',
    keys = { 'gS', 'gJ' },
  },
  {
    'chentoast/marks.nvim',
    event = 'BufEnter',
    config = function()
      require('marks').setup({
        mappings = {
          set_next = 'm,',
          next = 'm]',
          preview = 'm:',
          set_bookmark0 = 'm0',
        },
      })
    end,
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = { { '<leader>ut', '<cmd>UndotreeToggle<CR>', desc = '[U]ndo [T]ree' } },
  },
  {
    'numToStr/Comment.nvim',
    event = 'BufEnter',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufRead', 'BufNewFile' },
    main = 'ibl',
    config = require('k1ng.plugin-configs.indent-blankline').setup,
  },
  {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown',
    cmd = { 'MarkdownPreview', 'MarkdownPreviewToggle' },
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
  {
    'jinh0/eyeliner.nvim',
    event = 'BufRead',
    config = function()
      require('eyeliner').setup({
        highlight_on_key = true,
        dim = true,
      })
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    -- stylua: ignore
    keys = {
      {
        '<leader>cl',
        function()
          require('colorizer').attach_to_buffer(0, { mode = 'background', css = true })
        end,
        'Color Highlighter',
      },
    },
    config = function()
      require('colorizer').setup({
        filetypes = { '*' },
        user_default_options = {},
        buftypes = {},
      })
    end,
  },
}
