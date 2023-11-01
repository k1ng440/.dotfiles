return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    config = function()
      vim.schedule(function()
        require('k1ng.plugin-configs.copilot')
      end)
    end,
  },
}
