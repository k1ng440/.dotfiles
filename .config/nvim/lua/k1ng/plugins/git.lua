return {
  {
    'tpope/vim-fugitive',
    event = 'VeryLazy',
    cmd = {
      'G',
      'Git',
      'Ggrep',
      'Gclog',
      'Gllog',
      'Gcd',
      'Glcd',
      'Gedit',
      'Gsplit',
      'Gvsplit',
      'Gtabedit',
      'Gdiff',
      'Gdiffsplit',
      'Gvdiffsplit',
      'Gcdiff',
      'Gsdiff',
      'Gvdiff',
      'Gwrite',
      'Gread',
      'Ggrepadd',
      'Glgrep',
      'GRemove',
      'GDelete',
      'GMove',
      'GRename',
      'GBrowse',
      'Ghdiffsplit',
      'Gitblame',
    },
    cond = function()
      if vim.fn.isdirectory('.git') ~= 0 then
        return true
      end
    end,
  },
  {
    'tpope/vim-rhubarb',
    event = 'VeryLazy',
    cond = function()
      if vim.fn.isdirectory('.git') ~= 0 then
        return true
      end
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      yadm = {
        enable = true,
      },
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
    config = function(_, opts)
      vim.schedule(function()
        require('gitsigns').setup(opts)
      end)
    end,
    cond = function()
      if vim.fn.isdirectory('.git') ~= 0 then
        return true
      end
    end,
  },
}
