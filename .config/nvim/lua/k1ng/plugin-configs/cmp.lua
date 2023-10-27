local cmp = require('cmp')
local copilot_ok, copilot_suggestion = pcall(require, 'copilot.suggestion')
local ok, luasnip = pcall(require, 'luasnip')

require('k1ng.luasnip')

local window = {
  completion = cmp.config.window.bordered({
    col_offset = -3,
    side_padding = 0,
    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
  }),
  documentation = cmp.config.window.bordered({
    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
  }),
}

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

cmp.setup({
  -- experimental = {
  --   ghost_text = true,
  -- },
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
    documentation = window,
  },
  mapping = cmp.mapping.preset.insert({
    -- stylua: ignore
    ['<C-g>'] = function() if cmp.visible_docs() then cmp.close_docs() else cmp.open_docs() end end,
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete({}),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })
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

-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline({}),
--   sources = {
--     { name = 'cmdline' },
--     { name = 'cmdline_history' },
--     { name = 'path' },
--   },
--   enabled = function()
--     -- Set of commands where cmp will be disabled
--     local disabled = {
--       IncRename = true,
--     }
--     -- Get first word of cmdline
--     local cmd = vim.fn.getcmdline():match('%S+')
--     -- Return true if cmd isn't disabled
--     -- else call/return cmp.close(), which returns false
--     return not disabled[cmd] or cmp.close()
--   end,
-- })

cmp.setup.cmdline('/', {
  sources = { { name = 'buffer' } },
})
