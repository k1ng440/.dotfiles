return {
  { 'tpope/vim-surround', event = 'BufEnter' },
  { 'tpope/vim-sleuth', event = 'BufEnter' },
  {
    'AndrewRadev/splitjoin.vim',
    keys = { 'gS', 'gJ' },
  },
  {
    'chentoast/marks.nvim',
    event = 'BufEnter',
    config = function()
      vim.schedule(function()
        require('marks').setup({
          mappings = {
            set_next = 'm,',
            next = 'm]',
            preview = 'm:',
            set_bookmark0 = 'm0',
          },
        })
      end)
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
    config = function()
      vim.schedule(function()
        require('Comment').setup({
          pre_hook = require('ts_context_commentstring.internal').pre_hook,
        })
      end)
    end,
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
    'jinh0/eyeliner.nvim',
    event = 'BufReadPost',
    config = function()
      vim.schedule(function()
        require('eyeliner').setup({
          highlight_on_key = true,
          dim = true,
        })
      end)
    end,
  },
  {
    'echasnovski/mini.indentscope',
    event = 'BufReadPost',
    config = function()
      vim.schedule(function()
        require('mini.indentscope').setup({
          highlight_on_key = true,
          dim = true,
        })
      end)
    end,
  },
}
