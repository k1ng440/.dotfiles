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
    vim.cmd([[Trouble workspace_diagnostics]])
  end
end

return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  -- stylua: ignore
  keys = {
    { 'gr',         '<cmd>Trouble lsp_references<cr>',                            desc = '[G]oto [R]eferences' },
    { 'gd',         '<cmd>Trouble lsp_definitions<cr>',                           desc = '[G]oto [D]efinitions' },
    { 'gD',         '<cmd>Trouble lsp_definitions<cr>',                           desc = '[G]to [D]efinitions' },
    { '<leader>D',  '<cmd>Trouble lsp_type_definitions<cr>',                      desc = 'Type [D]efinition' },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)" },
    { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
    { '<C-t>',      close_or_open_with_diagnostics,                               { noremap = true } },
  },
  config = function()
    require('trouble').setup({
      action_keys = { open_tab = '<c-q>' },
    })
  end,
}
