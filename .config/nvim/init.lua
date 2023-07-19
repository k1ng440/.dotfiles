--
-- Neovim Configuration
-- Auther: Asaduzzaman Pavel
-- Github: https://github.com/k1ng440
-- Email: contact@iampavel.dev
-- Date: 2023-07-19
-- Base Template: Kickstart (https://github.com/nvim-lua/kickstart.nvim)

require('custom.options')

-- [[ Lazy Load ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Lazy Setup ]]
require('lazy').setup({
  'folke/zen-mode.nvim',
  {
    'folke/todo-comments.nvim',
    opts = {
      signs = true,
    }
  },
  'tpope/vim-repeat',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  { "tpope/vim-surround", lazy = false },
  {
    'lukas-reineke/indent-blankline.nvim',
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
  {
    'robstumborg/yadm.nvim',
  },


  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',
  { import = 'custom.plugins' },
}, {})

require('custom.init')
