return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod' },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql' },
      after = 'vim-dadbod',
    },
    { 'jsborjesson/vim-uppercase-sql' },
  },
  cmd = { 'DBUI', 'DBUIToggle', 'DBUIAddConnection', 'DBUIFindBuffer' },
  keys = { { '<leader>cD', '<cmd>DUIToggle<CR>', desc = 'Dadbod UI' } },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
  end,
}
