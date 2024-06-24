local cmp = require('cmp')
local copilot_ok, copilot_suggestion = pcall(require, 'copilot.suggestion')
local ok, luasnip = pcall(require, 'luasnip')

vim.schedule(function()
  require('k1ng.luasnip')
end)

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

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  auto_brackets = {},
  experimental = {
    native_menu = false,
    ghost_text = {
      hl_group = 'CmpGhostText',
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' },
    docs = {
      auto_open = true,
    },
  },
  window = {
    completion = window,
    documentation = window.documentation,
  },
  mapping = cmp.mapping.preset.insert({
    -- stylua: ignore
    ['<C-g>'] = function() if cmp.visible_docs() then cmp.close_docs() else cmp.open_docs() end end,

    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping({
      i = cmp.mapping.complete(),
      c = function(_)
        if cmp.visible() then
          if not cmp.confirm({ select = true }) then
            return
          end
        else
          cmp.complete()
        end
      end,
    }),
    ['<S-CR>'] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { 'i', 'c' }
    ),
    ['<CR>'] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      { 'i', 'c' }
    ),

    ['<Tab>'] = cmp.mapping(function(fallback)
      print(vim.inspect(cmp.visible()))
      if cmp.visible() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
      elseif copilot_ok and copilot_suggestion.is_visible() then
        copilot_suggestion.accept()
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
    { name = 'copilot', group_index = 1 },
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'luasnip', group_index = 2 },
    { name = 'nvim_lsp_signature_help', group_index = 2 },
    { name = 'path', group_index = 2 },
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  formatting = {
    fields = { 'kind', 'abbr' },
    format = require('k1ng.lsp.utils').cmp_formatter(30, 30, '...'),
  },
})

cmp.event:on('menu_opened', function()
  vim.b.copilot_suggestion_hidden = true
end)

cmp.event:on('menu_closed', function()
  vim.b.copilot_suggestion_hidden = false
end)

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
