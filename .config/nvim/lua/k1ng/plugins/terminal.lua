return {
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    version = "*",
    opts = {
      hide_numbers = true,
      shade_terminals = false,
    },
    config = function(_, opts)
      require('toggleterm').setup(opts)

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
      local function toggle_lazygit()
        lazygit:toggle()
      end

      local python = Terminal:new({ cmd = "python3", hidden = true, direction = 'float' })
      local function toggle_python()
        python:toggle()
      end

      vim.keymap.set('n', '<leader>gg', toggle_lazygit, { desc = 'Lazygit' })
      vim.keymap.set('n', '<leader>pt', toggle_python, { desc = 'Python' })
      vim.keymap.set('n', '<leader>ft', '<cmd>ToggleTerm direction=float<cr>', { desc = '[F]loating [T]erminal' })
    end
  }
}
