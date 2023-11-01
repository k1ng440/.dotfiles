vim.filetype.add({
  pattern = {
    ['*.rasi'] = 'rasi',
  },
  filename = {
    ['.env'] = 'sh',
    ['.env.example'] = 'sh',
  },
})
