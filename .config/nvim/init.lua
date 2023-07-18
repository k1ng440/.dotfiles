vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


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
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },
      'folke/neodev.nvim',
    },
  },
  {
    'nvimdev/lspsaga.nvim',
    event = 'LspAttach',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    }
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'folke/which-key.nvim',
    opts = {}
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  { 'numToStr/Comment.nvim',         opts = {} },
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = 'md',
    build = function()
      vim.fn["mkdp#util#install"]()
    end
  },
  {
    'rcarriga/nvim-notify'
  },
  {
    'chentoast/marks.nvim',
    event = 'VeryLazy'
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup({
        extra_groups = {
          'NvimTreeNormal',
          'NormalFloat',
          'GitSignsAdd',
          'GitSignsChange',
          'GitSignsDelete',
        },
      })
      require('transparent').toggle(true)
    end,
  },
  {
    'robstumborg/yadm.nvim',
  },

  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',
  { import = 'custom.plugins' },
}, {})


-- [[ Basic Sets ]]
vim.opt.termguicolors = true -- 24-bit color
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.o.tabstop = 4
vim.o.shiftwidth = 4


local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')

-- [[ Configure Treesitter ]]
require("custom.nvim-treesitter")

-- [[ Configure LSP ]]
require("custom.lsp")

-- [[ Keymaps ]]
require("custom.keybinds")

-- [[ autocommands ]]
require('custom.autocmds')

-- [[ commands ]]
require('custom.commands')

-- [[ Colorscheme ]]
require('custom.colorscheme')

-- vim: ts=2 sts=2 sw=2 et
