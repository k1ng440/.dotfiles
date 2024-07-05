vim.g.dispatch_handlers = {
  'job',
  'screen',
  'terminal',
  'windows',
  'iterm',
  'x11',
  'headless',
}

return {
  {
    'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
    keys = {
      { '<leader>mt', '<cmd>:silent Make test<CR>', desc = 'Make test' },
      { '<leader>md', '<cmd>:silent Dispatch<CR>', desc = 'Make using dispatch' },
      { '<leader>mf', '<cmd>:silent Dispatch focus<cr>', desc = 'Make using dispatch (focus)' },
    },
  },
  {
    'vim-test/vim-test',
    cmd = { 'TestNearest', 'TestFile', 'TestSuite', 'TestLast', 'TestVisit' },
    keys = {
      { '<leader>tn', '<cmd>TestNearest<cr>', desc = 'Test nearest' },
      { '<leader>tf', '<cmd>TestFile<cr>', desc = 'Test file' },
      { '<leader>ts', '<cmd>TestSuite<cr>', desc = 'Test suite' },
      { '<leader>tl', '<cmd>TestLast<cr>', desc = 'Test last' },
      { '<leader>tv', '<cmd>TestVisit<cr>', desc = 'Test visit' },
    },
    config = function()
      vim.g['test#strategy'] = 'dispatch'
    end,
  },
}
