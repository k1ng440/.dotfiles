local cmp = require('cmp')
local ok, luasnip = pcall(require, 'luasnip')

local defaults = require('cmp.config.default')()

local window = {
  completion = cmp.config.window.bordered({
    col_offset = -3,
    side_padding = 0,
    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual',
  }),
  documentation = cmp.config.window.bordered({
    winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
  }),
}

cmp.setup({
  preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' },
    docs = {
      auto_open = false,
    },
  },
  window = {
    completion = window,
    documentation = window.documentation,
  },
  mapping = cmp.mapping.preset.insert({
    -- stylua: ignore
    -- Toggle the documentation window
    ['<C-d>'] = function() if cmp.visible_docs() then cmp.close_docs() else cmp.open_docs() end end,

    -- Scroll the documentation window [b]ack / [f]orward
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),

    -- Explicitly request completions.
    ['<C-Space>'] = cmp.mapping.complete({}),

    ['<A-/>'] = cmp.mapping.close(),

    -- Overload tab to accept Copilot suggestions.
    ['<Tab>'] = cmp.mapping(function(fallback)
      local copilot = require('copilot.suggestion')

      if copilot.is_visible() then
        copilot.accept()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.expand_or_locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
    fields = { 'kind', 'abbr' },
    format = require('k1ng.lsp.utils').cmp_formatter(30, 30, '...'),
  },
})

-- gray
vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
-- blue
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
-- light blue
vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
-- pink
vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
-- front
vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
