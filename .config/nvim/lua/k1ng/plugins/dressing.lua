return {
  'stevearc/dressing.nvim',
  event = "LspAttach",
  opts = {},
  config = function(_, opts)
    require('dressing').setup(opts)
  end
}
