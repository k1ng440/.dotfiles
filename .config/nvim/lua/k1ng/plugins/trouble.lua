local Util = require('k1ng.util')

-- Step through diagnostic messages or trouble entries if there
local next_diagnostic_or_trouble = function(forwards)
  local is_trouble_open = Util.has_buffer_in_list('Trouble')
  if is_trouble_open then
    if forwards then
      require('trouble').next({ skip_groups = true, jump = true })
    else
      require('trouble').previous({ skip_groups = true, jump = true })
    end
    return
  end
  if forwards then
    vim.diagnostic.goto_next()
  else
    vim.diagnostic.goto_prev({})
  end
end

-- Populate trouble with document diagnostics
local close_or_open_with_diagnostics = function()
  local is_trouble_open = Util.has_buffer_in_list('Trouble')
  if is_trouble_open then
    require('trouble').close()
  else
    vim.cmd([[TroubleToggle workspace_diagnostics]])
  end
end

return {
  'folke/trouble.nvim',
  events = 'BufEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  -- stylua: ignore
  keys = {
    { 'gr', '<cmd>TroubleToggle lsp_references<cr>', desc = '[G]oto [R]eferences' },
    { 'gd', '<cmd>TroubleToggle lsp_definitions<cr>', desc = '[G]oto [D]efinitions' },
    { 'gD', '<cmd>TroubleToggle lsp_definitions<cr>', desc = '[G]oto [D]efinitions' },
    { '<leader>D', '<cmd>TroubleToggle lsp_type_definitions<cr>', desc = 'Type [D]efinition'},
    { '<C-p>', function() next_diagnostic_or_trouble(false) end },
    { '<C-n>', function() next_diagnostic_or_trouble(true) end },
    { '<C-t>', close_or_open_with_diagnostics, { noremap = true } },
  },
  config = function()
    require('trouble').setup({
      action_keys = { open_tab = '<c-q>' },
    })
  end,
}
