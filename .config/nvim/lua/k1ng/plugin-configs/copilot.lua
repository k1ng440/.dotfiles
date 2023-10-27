require('copilot').setup({
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    accept = false,
    keymap = {
      accept = '<A-j>',
      accept_line = '<A-l>',
      cancel = '<A-c>',
      next = '<A-n>',
      prev = '<A-p>',
    },
  },
  filetypes = {
    sh = function()
      if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
        -- disable for .env files
        return false
      end
      return true
    end,
  },
})

-- hide copilot suggestions when cmp menu is open
-- to prevent odd behavior/garbled up suggestions
local cmp_status_ok, cmp = pcall(require, 'cmp')
if cmp_status_ok then
  cmp.event:on('menu_opened', function()
    vim.b.copilot_suggestion_hidden = true
  end)
  cmp.event:on('menu_closed', function()
    vim.b.copilot_suggestion_hidden = false
  end)
end
