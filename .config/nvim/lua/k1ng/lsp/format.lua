local Util = require('k1ng.util')

local M = {
  opts = {
    autoformat = true,
  },
}

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.opts.autoformat = true
  else
    M.opts.autoformat = not M.opts.autoformat
  end
  if M.opts.autoformat then
    vim.notify('Enabled format on save', vim.log.INFO, { title = 'Toggle Format' })
    M.auto_format()
  else
    vim.notify('Disabled format on save', vim.log.INFO, { title = 'Toggle Format' })
    if M.autocmd_id then
      vim.api.nvim_del_autocmd(M.autocmd_id)
    end
  end
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
  if vim.b.autoformat == false and not (opts and opts.force) then
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
      if not vim.tbl_contains(client_ids, client.id) then
        return false
      end
      -- vim.notify('Formatting with ' .. client.name, vim.log.INFO, { title = 'Format Document' })
      return true
    end,
  })
end

function M.auto_format()
  M.autocmd_id = vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('AutoFormat', {}),
    callback = function()
      if M.opts.autoformat then
        M.format()
      end
    end,
  })
end

Util.on_attach(function(client, _)
  M.auto_format()

  vim.api.nvim_create_user_command('FormatToggle', function()
    M.toggle()
  end, { desc = 'Toggle auto format on save' })

  vim.api.nvim_create_user_command('Format', function()
    M.format({ force = true })
  end, { desc = 'Format current buffer with LSP' })
end)
