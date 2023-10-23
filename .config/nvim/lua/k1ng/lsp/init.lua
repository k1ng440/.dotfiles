local lsp_present, lspconfig = pcall(require, 'lspconfig')
local cmp_present, cmp = pcall(require, 'cmp')
if not (cmp_present and lsp_present) then
  vim.notify('Missing cmp, lspconfig, or luasnip', vim.log.levels.ERROR)
  return
end

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

-- Lazy load snippets
local ok, luasnip = pcall(require, 'luasnip')
if not ok then
  vim.notify('luasnip is not loaded', vim.log.levels.ERROR)
  return
end
require('k1ng.luasnip')
-- EOF snippets

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

local cmp_window = {
  border = { vim.g.bc.topleft, vim.g.bc.horiz, vim.g.bc.topright, vim.g.bc.vert, vim.g.bc.botright, vim.g.bc.horiz, vim.g.bc.botleft, vim.g.bc.vert },
  -- winhighlight = 'Normal:Pmenu,CursorLine:PmenuSel',
}
-- EOF border style

-- Helper functions for cmp
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
-- EOF helper functions

--------------------------------------------------
-- Setup cmp
--------------------------------------------------
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = {
    docs = {
      auto_open = false,
    },
  },
  window = {
    completion = cmp_window,
    documentation = cmp_window,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-g>'] = function()
      if cmp.visible_docs() then
        cmp.close_docs()
      else
        cmp.open_docs()
      end
    end,
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
      -- elseif require('copilot.suggestion').is_visible() then
      --   require('copilot.suggestion').accept()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  preselect = cmp.PreselectMode.None,
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
  completion = {
    completeopt = 'menu,menuone',
  },
  formatting = {
    fields = { 'kind', 'abbr' },
    format = require('k1ng.lsp.utils').cmp_formatter(30, 30, '...'),
  },
})
--------------------------------------------------
-- EOF cmp
--------------------------------------------------

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
if not capabilities.workspace then
  capabilities.workspace = {}
end
capabilities.workspace.didChangeWatchedFiles = {
  dynamicRegistration = true,
}

---@diagnostic disable-next-line: missing-fields
capabilities.textDocument.completion.completionItem = {
  documentationFormat = { 'markdown', 'plaintext' },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
  },
}

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
ensure_installed[#ensure_installed + 1] = 'efm' -- We handle efm seperately
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
      capabilities = capabilities,
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
  capabilities = capabilities,
}))
