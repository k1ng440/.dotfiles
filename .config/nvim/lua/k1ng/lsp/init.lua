local lspconfig = require('lspconfig')

require('k1ng.lsp.lsp-keymaps')
require('k1ng.lsp.on_attach')
require('k1ng.lsp.format')
require('k1ng.lsp.diagnostics')

-- Setup neodev and neoconf
local neoconfstatus, neoconf = pcall(require, 'neoconf')
if neoconfstatus and not vim.g.neoconf_configured then
  neoconf.setup({})
  vim.g.neoconf_configured = true
end

local neodevstatus, neodev = pcall(require, 'neodev')
if neodevstatus then
  neodev.setup({})
end
-- EOF neodev and neoconf

-- border style
require('lspconfig.ui.windows').default_options.border = 'double'

-- hover
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  width = 80,
  border = vim.g.bc.style,
  focusable = false,
})

-- publishDiagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

-- Configure vim.diagnostic
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Configure LSP using Mason lspconfig
local servers = require('k1ng.lsp.servers')
local mason_lspconfig = require('mason-lspconfig')
local ensure_installed = vim.tbl_keys(servers)
ensure_installed[#ensure_installed + 1] = 'efm'
mason_lspconfig.setup({
  ensure_installed = ensure_installed,
})

--- Setup handlers for lspconfig
mason_lspconfig.setup_handlers({
  function(server_name)
    -- Ignore efm setup
    if server_name == 'efm' then
      return
    end

    local opts = {
      capabilities = require('k1ng.lsp.lsp-capabilities').capabilities(server_name),
      settings = servers[server_name],
    }

    -- intelephense requires a license key on init_options
    if server_name == 'intelephense' then
      opts.init_options = {
        licenceKey = vim.fn.expand('~/.vim/intelephense/license.txt'),
      }
    end

    -- clangd
    if server_name == 'clangd' then
      opts.cmd = {
        'clangd',
        '--offset-encoding=utf-16',
      }
    end

    -- Setup lsp server
    lspconfig[server_name].setup(opts)
  end,
})

-- Setup efm
local efmls_config = require('k1ng.lsp.efm')
require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
  capabilities = require('k1ng.lsp.lsp-capabilities').capabilities('efm'),
}))

vim.defer_fn(function()
  require('lazy.core.handler.event').trigger({
    event = 'FileType',
    buf = vim.api.nvim_get_current_buf(),
  })
end, 100)

local group = vim.api.nvim_create_augroup('__env', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '.env',
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})
