-- [[ Custom commands ]]

-- Change working directory to the directory of the current file
vim.api.nvim_create_user_command('CD', 'cd %:p:h', {
  nargs = 0,
  bar = false,
})
