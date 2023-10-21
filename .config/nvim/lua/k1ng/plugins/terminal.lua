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
    config = function(_, opts)
      require('toggleterm').setup(opts)

      local function close_terminal_on_zero_exit(terminal, _, exit_code)
        if exit_code == 0 then
          terminal:close()
        end
      end

      local Terminal = require('toggleterm.terminal').Terminal

      local toggle_lazygit = function()
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

      local python = Terminal:new({ cmd = 'python3', hidden = true, direction = 'float' })
      local function toggle_python()
        python:toggle()
      end

      vim.keymap.set('n', '<leader>gg', toggle_lazygit, { desc = 'Lazygit' })
      vim.keymap.set('n', '<leader>pt', toggle_python, { desc = 'Python' })
      vim.keymap.set('n', '<leader>ft', '<cmd>ToggleTerm direction=float<cr>', { desc = '[F]loating [T]erminal' })
    end,
  },
}
