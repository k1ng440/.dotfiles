local lspconfig = require('lspconfig')

require('k1ng.lsp.lsp-keymaps')
require('k1ng.lsp.on_attach')
require('k1ng.lsp.format')
require('k1ng.lsp.diagnostics')

local neodevstatus, neodev = pcall(require, 'neodev')
if neodevstatus then
  neodev.setup({
    library = { plugins = { 'nvim-dap-ui' }, types = true },
  })
end

-- ui
require('lspconfig.ui.windows').default_options.border = 'rounded'

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
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = vim.g.bc.style,
  },
})

-- Configure LSP using Mason lspconfig
local servers = require('k1ng.lsp.servers')
local mason_lspconfig = require('mason-lspconfig')
local ensure_installed = servers.listServers()
ensure_installed[#ensure_installed + 1] = 'efm'
mason_lspconfig.setup({
  ensure_installed = ensure_installed,
})

--- Setup handlers for lspconfig
local capabilities = require('k1ng.lsp.lsp-capabilities').capabilities()
mason_lspconfig.setup_handlers({
  function(server_name)
    if server_name == 'efm' then
      return
    end
    local server = servers.getServerConfig(server_name)
    server.capabilities = capabilities
    lspconfig[server_name].setup(server)
  end,
})

-- Setup efm
local efmls_config = require('k1ng.lsp.efm')
require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
  capabilities = capabilities,
}))

local group = vim.api.nvim_create_augroup('__env', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '.env',
  group = group,
  callback = function(args)
    vim.diagnostic.disable(args.buf)
  end,
})
