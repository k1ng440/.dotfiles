return {
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    event = 'VimEnter',
    build = './kitty/install-kittens.bash',
    opts = {
      resize_mode = {
        silent = true,
        hooks = {
          on_enter = function()
            vim.notify('Entering resize mode')
          end,
          on_leave = function()
            vim.notify('Exiting resize mode, bye')
          end,
        },
      },
    },
    config = function(_, opts)
      local ss = require('smart-splits')
      ss.setup(opts)

      vim.keymap.set('n', '<A-h>', ss.resize_left)
      vim.keymap.set('n', '<A-j>', ss.resize_down)
      vim.keymap.set('n', '<A-k>', ss.resize_up)
      vim.keymap.set('n', '<A-l>', ss.resize_right)

      -- moving between splits
      vim.keymap.set('n', '<C-h>', ss.move_cursor_left)
      vim.keymap.set('n', '<C-j>', ss.move_cursor_down)
      vim.keymap.set('n', '<C-k>', ss.move_cursor_up)
      vim.keymap.set('n', '<C-l>', ss.move_cursor_right)

      -- swapping buffers between windows
      vim.keymap.set('n', '<leader><leader>h', ss.swap_buf_left)
      vim.keymap.set('n', '<leader><leader>j', ss.swap_buf_down)
      vim.keymap.set('n', '<leader><leader>k', ss.swap_buf_up)
      vim.keymap.set('n', '<leader><leader>l', ss.swap_buf_right)
    end,
  },
}
