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

      -- Better navigation to and from terminal
      local buf_map = vim.api.nvim_buf_set_keymap
      local set_terminal_keymaps = function()
        local bufopts = { noremap = true }
        buf_map(0, 't', '<esc>', [[<C-\><C-n>]], bufopts)
        buf_map(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], bufopts)
        buf_map(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], bufopts)
        buf_map(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], bufopts)
        buf_map(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], bufopts)
      end
      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.api.nvim_create_autocmd('TermOpen', {
        pattern = 'term://*',
        callback = function()
          set_terminal_keymaps()
        end,
        desc = 'Mappings for navigation with a terminal',
      })
    end,
  },
}
