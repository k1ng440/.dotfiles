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
  },
}
