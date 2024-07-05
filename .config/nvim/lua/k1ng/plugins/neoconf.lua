return {
  'folke/neoconf.nvim',
  config = function(_, opts)
    local neoconf = require('neoconf')
    neoconf.setup(opts)
  end,
}
