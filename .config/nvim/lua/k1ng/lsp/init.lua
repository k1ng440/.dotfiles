local lsp_present, lspconfig = pcall(require, "lspconfig")
local cmp_present, cmp = pcall(require, "cmp")
if not (cmp_present and lsp_present) then
  vim.notify("Missing cmp, lspconfig, or luasnip", vim.log.levels.ERROR)
  return
end

require('k1ng.lsp.keymaps')
require('k1ng.lsp.on_attach')
require('k1ng.lsp.format')

-- Setup neodev and neoconf
local neoconfstatus, neoconf = pcall(require, "neoconf")
if neoconfstatus then
  neoconf.setup({})
end

local neodevstatus, neodev = pcall(require, "neodev")
if neodevstatus then
  neodev.setup({})
end
-- EOF neodev and neoconf

-- Lazy load snippets
local ok, luasnip = pcall(require, "luasnip")
if ok then
  require("luasnip.loaders.from_vscode").lazy_load({
    path = { vim.fn.stdpath("config") .. "/snippets" },
  })
end
-- EOF snippets

-- border style
require("lspconfig.ui.windows").default_options.border = "double"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = vim.g.bc.style,
})
local cmp_borders = {
  border = {
    vim.g.bc.topleft,
    vim.g.bc.horiz,
    vim.g.bc.topright,
    vim.g.bc.vert,
    vim.g.bc.botright,
    vim.g.bc.horiz,
    vim.g.bc.botleft,
    vim.g.bc.vert,
  },
  winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
}
-- EOF border style

-- Helper functions for cmp
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
-- EOF helper functions

-- Setup cmp
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp_borders,
    documentation = cmp_borders,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
      elseif require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
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
  },
  preselect = cmp.PreselectMode.None,
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = "emoji" },
    { name = "calc" },
  },
  completion = {
    completeopt = "menu,menuone",
  },
  formatting = {
    format = require('k1ng.lsp.utils').cmp_formatter(45, 50, '...'),
  },
})
-- EOF cmp

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

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
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

--- Setup handlers for lspconfig
mason_lspconfig.setup_handlers {
  function(server_name)
    local opts = {
      capabilities = capabilities,
      settings = servers[server_name],
    }

    -- intelephense requires a license key on init_options
    if server_name == 'intelephense' then
      opts.init_options = {
        licenceKey = vim.fn.expand "~/.vim/intelephense/license.txt",
      }
    end

    -- Setup lsp server
    require('lspconfig')[server_name].setup(opts)
  end,
}

-- vim: ts=2 sts=2 sw=2 et
