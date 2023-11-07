local M = {}
function M.setup()
  local ibl = require('ibl')
  local hooks = require('ibl.hooks')

  local highlight = {
    'RainbowRed',
    'RainbowYellow',
    'RainbowBlue',
    'RainbowOrange',
    'RainbowGreen',
    'RainbowViolet',
    'RainbowCyan',
  }

  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
    vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
    vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
    vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
    vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
    vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
    vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
  end)
  vim.g.rainbow_delimiters = { highlight = highlight }
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

  ibl.setup({
    enabled = true,
    debounce = 200,
    exclude = {
      filetypes = {
        'help',
        'alpha',
        'dashboard',
        '*oil*',
        'neo-tree',
        'Trouble',
        'lazy',
        'mason',
        'notify',
        'toggleterm',
        'lazyterm',
        'asm',
      },
    },
    scope = {
      enabled = true,
      highlight = highlight,
    },
    indent = {
      char = '┊',
    },
    whitespace = {
      remove_blankline_trail = true,
    },
  })
end

return M
