return {
  'MaximilianLloyd/ascii.nvim',
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('telescope').load_extension('ascii')
  end,
}
