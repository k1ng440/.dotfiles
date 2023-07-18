-- [[ Custom commands ]]

-- Change working directory to the directory of the current file
vim.api.nvim_create_user_command('CD', 'cd %:p:h', {
  nargs = 0,
  bar = false,
})

-- Delete all marks
vim.api.nvim_create_user_command('DelMarks', 'delm! | delm A-Z0-9', {
  nargs = 0,
  bar = false,
})
