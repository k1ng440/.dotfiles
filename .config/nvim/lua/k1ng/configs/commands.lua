local user_cmd = vim.api.nvim_create_user_command

-- [[ Custom commands ]]

-- Change working directory to the directory of the current file
user_cmd('CD', 'cd %:p:h', {
  nargs = 0,
  bar = false,
})

-- Delete all marks
user_cmd('DelMarks', 'delm! | delm A-Z0-9', {
  nargs = 0,
  bar = false,
})

user_cmd('ToggleLineNumbers', 'set number! relativenumber!', {
  nargs = 0,
  bar = false,
})

user_cmd('ToggleWrap', 'set wrap!', {
  nargs = 0,
  bar = false,
})

user_cmd('ToggleSpell', 'set spell!', {
  nargs = 0,
  bar = false,
})

user_cmd('ToggleColorColumn', 'set colorcolumn=80', {
  nargs = 0,
  bar = false,
})
