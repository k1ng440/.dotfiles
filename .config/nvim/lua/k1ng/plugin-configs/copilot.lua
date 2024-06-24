require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = '[[',
      jump_next = ']]',
      accept = '<CR>',
      refresh = 'gr',
    },
    layout = {
      position = 'bottom',
      ratio = 0.4,
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    accept = false,
    debounce = 75,
    keymap = {
      accept = '<A-j>',
      accept_line = '<A-l>',
      cancel = '<A-c>',
      next = '<A-n>',
      prev = '<A-p>',
    },
  },
  filetypes = {
    oil = false,
    yaml = true,
    sh = function()
      if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
        return false
      end
      return true
    end,
  },
})
