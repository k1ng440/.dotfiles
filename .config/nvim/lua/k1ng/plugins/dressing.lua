return {
  'stevearc/dressing.nvim',
  opts = {},
  config = function(_, opts)
    require('dressing').setup(opts)
  end,
}
