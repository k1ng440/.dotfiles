local Util = require('k1ng.util')

if vim.lsp.inlay_hint then
  vim.keymap.set('n', '<leader>lh', function()
    vim.lsp.inlay_hint(0, nil)
  end, { desc = '[T]oggle Inlay [H]ints' })

  -- vim.api.nvim_create_autocmd('InsertEnter', {
  --   group = vim.api.nvim_create_augroup('inlay_hint_insert', { clear = true }),
  --   callback = function()
  --     vim.lsp.inlay_hint(0, true)
  --   end,
  -- })
  --
  -- vim.api.nvim_create_autocmd('InsertLeave', {
  --   group = vim.api.nvim_create_augroup('inlay_hint_leave', { clear = true }),
  --   callback = function()
  --     vim.lsp.inlay_hint(0, false)
  --   end,
  -- })
end

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'LSP: Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'LSP: Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'LSP: Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'LSP: Open diagnostics list' })

Util.on_attach(function(_, buffer)
  local map = function(mode, lhs, rhs, desc)
    desc = desc or rhs
    local opts = { buffer = buffer, noremap = true, silent = true, desc = 'LSP: ' .. desc }
    Util.keymap(mode, lhs, rhs, opts)
  end

  local nmap = function(lhs, rhs, desc)
    map('n', lhs, rhs, desc)
  end

  local imap = function(lhs, rhs, desc)
    map('i', lhs, rhs, desc)
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>cf', '<cmd>Format<cr>', '[C]ode [F]ormat')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  -- see plugins/trouble.lua
  -- nmap('gd', '<cmd>TroubleToggle lsp_definitions<cr>', '[G]oto [D]efinition')
  -- nmap('gD', '<cmd>TroubleToggle lsp_definitions<cr>', '[G]oto [D]efinition')
  -- nmap('gr', '<cmd>TroubleToggle lsp_references<cr>', '[G]oto [R]eferences')
  -- nmap('<leader>D', '<cmd>TroubleToggle lsp_type_definitions<cr>', 'Type [D]efinition')

  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  imap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end)
