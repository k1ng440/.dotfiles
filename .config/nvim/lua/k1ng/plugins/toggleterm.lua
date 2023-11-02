local close_terminal_on_zero_exit = function(terminal, _, exit_code)
  if exit_code == 0 then
    terminal:close()
  end
end

local on_open = function(term)
  vim.cmd('startinsert!')
  vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-q>', '<cmd>close<CR>', { noremap = true, silent = true })
end

local toggle_lazygit = function()
  local Terminal = require('toggleterm.terminal').Terminal
  local cmd = 'lazygit'
  local git_dir = vim.b[vim.api.nvim_get_current_buf()].git_dir

  if git_dir ~= nil then
    cmd = cmd .. ' --work-tree=$HOME'
    cmd = cmd .. ' --git-dir=' .. git_dir
  else
    cmd = cmd .. ' --work-tree=' .. vim.g.project_root
  end

  local lazygit = Terminal:new({
    cmd = cmd,
    close_on_exit = true,
    direction = 'float',
    hidden = true,
    on_exit = close_terminal_on_zero_exit,
    on_open = on_open,
  })

  lazygit:toggle()
end

local term = nil
local toggle_term = function(direction)
  local Terminal = require('toggleterm.terminal').Terminal

  if term ~= nil then
    term:toggle()
  end

  term = Terminal:new({
    direction = direction,
    hidden = true,
    dir = vim.g.project_root,
    cmd = vim.o.shell,
    close_on_exit = true,
    on_open = on_open,
    on_exit = function()
      term = nil
    end,
  })

  term:toggle()
end

return {
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    version = '*',
    opts = {
      hide_numbers = true,
      shade_terminals = false,
      autochdir = true,
      float_opts = {
        border = 'curved',
      },
    },
    cmd = { 'ToggleTerm' },
    -- stylua: ignore
    keys = {
      { '<leader>gg', toggle_lazygit,  desc = 'Lazygit'  },
      { '<leader>tf', function() toggle_term('float') end, desc = '[T]oggle [F]loating Terminal' },
      { '<leader>tb', function() toggle_term('horizontal') end, desc = '[T]oggle [B]ottom Terminal' },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)
    end,
  },
}
