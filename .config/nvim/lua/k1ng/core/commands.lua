local user_cmd = vim.api.nvim_create_user_command

user_cmd('CD', 'cd %:p:h', { nargs = 0, bar = false })
user_cmd('DelMarks', 'delm! | delm A-Z0-9', { nargs = 0, bar = false })
user_cmd('ToggleLineNumbers', 'set number! relativenumber!', { nargs = 0, bar = false })
user_cmd('ToggleWrap', 'set wrap!', { nargs = 0, bar = false })
user_cmd('ToggleSpell', 'set spell!', { nargs = 0, bar = false })
