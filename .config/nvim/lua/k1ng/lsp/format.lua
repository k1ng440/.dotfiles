local Util = require('k1ng.util')
local M = {}

-- TODO: Persist this across sessions
vim.g.autoformat = true

function M.toggle()
  vim.g.autoformat = not vim.g.autoformat
  if vim.g.autoformat then
    vim.notify('Enabled format on save', vim.log.INFO, { title = 'Toggle Format' })
    return
  end
  vim.notify('Disabled format on save', vim.log.INFO, { title = 'Toggle Format' })
end

function M.supports_format(client)
  if client.config and client.config.capabilities and client.config.capabilities.documentFormattingProvider == false then
    return false
  end
  return client.supports_method('textDocument/formatting') or client.supports_method('textDocument/rangeFormatting')
end

-- Priotize efm formatters
function M.get_formatters(bufnr)
  local ret = {
    active = {},
    available = {},
  }

  local efm = vim.lsp.get_active_clients({ name = 'efm', bufnr = bufnr })
  for _, client in ipairs(efm) do
    table.insert(ret.active, client)
  end

  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if M.supports_format(client) then
      if vim.tbl_count(ret.active) == 0 then
        table.insert(ret.active, client)
      else
        table.insert(ret.available, client)
      end
    end
  end
  return ret
end

function M.format(opts)
  local buf = vim.api.nvim_get_current_buf()
  if vim.g.autoformat == false and not (opts and opts.force) then
    return
  end

  local formatters = M.get_formatters(buf)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters.active)
  if #client_ids == 0 then
    return
  end

  vim.lsp.buf.format({
    timeout_ms = 2000,
    bufnr = buf,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  })
end

vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('AutoFormat', {}),
  callback = function()
    M.format()
  end,
})

vim.api.nvim_create_user_command('FormatToggle', function()
  M.toggle()
end, { desc = 'Toggle auto format on save' })

vim.api.nvim_create_user_command('Format', function()
  M.format({ force = true })
end, { desc = 'Format current buffer with LSP' })
