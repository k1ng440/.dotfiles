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

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  next_diagnostic_or_trouble(false)
end, { desc = 'LSP: Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function()
  next_diagnostic_or_trouble(true)
end, { desc = 'LSP: Go to next diagnostic message' })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'LSP: Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'LSP: Open diagnostics list' })
Util.keymap('n', '<leader>lrs', '<cmd>LspRestart<cr>', { desc = 'LSP: Restart' })

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
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gdt', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', '[G]oto [D]definition in new tab')
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  imap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  vim.keymap.set('n', '<leader>th', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, { desc = '[T]oggle Inlay [H]ints' })

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end)
