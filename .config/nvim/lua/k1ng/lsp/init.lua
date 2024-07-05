local lspconfig = require('lspconfig')
require('k1ng.lsp.lsp-keymaps')
require('k1ng.lsp.on_attach')

local methods = vim.lsp.protocol.Methods

local neodevstatus, neodev = pcall(require, 'neodev')
if neodevstatus then
  neodev.setup({
    library = { plugins = { 'nvim-dap-ui' }, types = true },
  })
end

-- ui
require('lspconfig.ui.windows').default_options.border = 'rounded'

-- hover
vim.lsp.handlers[methods.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, {
  width = 80,
  border = vim.g.bc.style,
  focusable = false,
})

-- publishDiagnostics
vim.lsp.handlers[methods.textDocument_publishDiagnostics] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = {
    prefix = '',
    spacing = 8,
  },
  signs = true,
  update_in_insert = false,
})

-- Workaround for truncating long TypeScript inlay hints.
-- TODO: Remove this if https://github.com/neovim/neovim/issues/27240 gets addressed.
local inlay_hint_handler = vim.lsp.handlers[methods.textDocument_inlayHint]
vim.lsp.handlers[methods.textDocument_inlayHint] = function(err, result, ctx, config)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if client and client.name == 'typescript-tools' then
    result = vim.iter.map(function(hint)
      local label = hint.label ---@type string
      if label:len() >= 30 then
        label = label:sub(1, 29) .. '…'
      end
      hint.label = label
      return hint
    end, result)
  end
  inlay_hint_handler(err, result, ctx, config)
end

-- Configure vim.diagnostic
vim.diagnostic.config({
  underline = true,
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
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
mason_lspconfig.setup({
  ensure_installed = ensure_installed,
})

--- Setup handlers for lspconfig
local capabilities = require('k1ng.lsp.lsp-capabilities').capabilities()
mason_lspconfig.setup_handlers({
  function(server_name)
    if require('neoconf').get(server_name .. '.disable') then
      return
    end

    local server = servers.getServerConfig(server_name)
    if server.enabled == false then
      return
    end

    server.capabilities = capabilities
    lspconfig[server_name].setup(server)
  end,
})

local group = vim.api.nvim_create_augroup('__env', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '.env',
  group = group,
  callback = function(args)
    vim.diagnostic.enable(false, args.buf)
  end,
})
