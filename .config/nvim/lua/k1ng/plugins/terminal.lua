local close_terminal_on_zero_exit = function(terminal, _, exit_code)
  if exit_code == 0 then
    terminal:close()
  end
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
    on_open = function(term)
      vim.cmd('startinsert!')
      vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    end,
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
    on_open = function(termT)
      vim.cmd('startinsert!')
      vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-q>', '<cmd>close<CR>', { noremap = true, silent = true })

      -- if direction == 'horizontal' then
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-h>', [[<C-\><C-n><C-W>h]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-j>', [[<C-\><C-n><C-W>j]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-k>', [[<C-\><C-n><C-W>k]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-l>', [[<C-\><C-n><C-W>l]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', '<C-h>', [[<C-\><C-n><C-W>h]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', '<C-j>', [[<C-\><C-n><C-W>j]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', '<C-k>', [[<C-\><C-n><C-W>k]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', '<C-l>', [[<C-\><C-n><C-W>l]], { noremap = true, silent = true })
      -- elseif direction == 'float' then
      --   -- close terminal on any direction keymaps in float mode and then send the direction keymap to the underlying buffer
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-h>', [[<cmd>close<CR><C-W>h]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-j>', [[<cmd>close<CR><C-W>j]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-k>', [[<cmd>close<CR><C-W>k]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 't', '<C-l>', [[<cmd>close<CR><C-W>l]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', '<C-h>', [[<cmd>close<CR><C-W>h]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', '<C-j>', [[<cmd>close<CR><C-W>j]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', '<C-k>', [[<cmd>close<CR><C-W>k]], { noremap = true, silent = true })
      --   vim.api.nvim_buf_set_keymap(termT.bufnr, 'n', '<C-l>', [[<cmd>close<CR><C-W>l]], { noremap = true, silent = true })
      -- end
    end,
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
      { '<leader>tf', function() toggle_term('float') end, desc = '[T]erminal [F]loating' },
      { '<leader>tb', function() toggle_term('horizontal') end, desc = '[T]erminal [B]ottom' },
      { '<leader>tn', function() toggle_term('tab') end, desc = '[T]erminal [N]ew Tab' },
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)
    end,
  },
}
