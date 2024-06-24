vim.filetype.add({
  extension = {
    rasi = 'rasi',
    rofi = 'rasi',
    wofi = 'rasi',
  },
  filename = {
    ['.env'] = 'sh',
    ['.env.example'] = 'sh',
    ['vifmrc'] = 'vim',
  },
  pattern = {
    ['.*/waybar/config'] = 'jsonc',
    ['.*/mako/config'] = 'dosini',
    ['.*/kitty/.+%.conf'] = 'bash',
    ['.*/hypr/.+%.conf'] = 'hyprlang',
    ['%.env%.[%w_.-]+'] = 'sh',
  },
})
