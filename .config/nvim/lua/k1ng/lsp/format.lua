local Util = require('k1ng.util')

local M = {}

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.opts.autoformat = true
  else
    M.opts.autoformat = not M.opts.autoformat
  end
  if M.opts.autoformat then
    Util.info("Enabled format on save", { title = "Format" })
  else
    Util.warn("Disabled format on save", { title = "Format" })
  end
end

function M.supports_format(client)
  if client.config and client.config.capabilities and client.config.capabilities.documentFormattingProvider == false then
    return false
  end
  return client.supports_method("textDocument/formatting") or client.supports_method("textDocument/rangeFormatting")
end

-- Priotize null-ls over lsp formatters
function M.get_formatters(bufnr)
  local ft = vim.bo[bufnr].filetype
  local null_ls = package.loaded["null-ls"] and require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") or {}

  local ret = {
    active = {},
    available = {},
    null_ls = null_ls,
  }

  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if M.supports_format(client) then
      if (#null_ls > 0 and client.name == "null-ls") or #null_ls == 0 then
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
    bufnr = buf,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  })
end

function M.auto_format(opts)
  M.opts = opts
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("AutoFormat", {}),
    callback = function()
      if M.opts.autoformat then
        M.format()
      end
    end,
  })
end

Util.on_attach(function(client, _)
  -- Keep simple for go
  if client.name == 'gopls' then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("GoImport", { clear = true }),
      pattern = "*.go",
      callback = function()
        require("go.format").goimport()
        require("go.format").gofmt()
      end,
    })

    vim.api.nvim_create_user_command('Format', function()
      require("go.format").goimport()
      require("go.format").gofmt()
    end, { desc = 'Format current buffer with LSP' })
    return
  end -- gopls

  -- Auto Format
  M.auto_format({
    autoformat = true,
  })

  vim.api.nvim_create_user_command('Format', function()
    M.format({ force = true })
  end, { desc = 'Format current buffer with LSP' })
end)
