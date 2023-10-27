local Util = require('k1ng.util')
local map = Util.keymap

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = 'Disable <Space>' })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = '[k] Move up' })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = '[j] Move down' })
map('n', 'Q', '@q', { desc = 'Replay macro' })
map('n', '<Tab>', '%', { desc = 'Remap % to Tab' })

-- Close buffer
map('n', '<leader>ub', '<cmd>bdelete<cr>', { desc = '[U]nload [B]uffer' })
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = '[B]uffer [D]elete' })
map('n', '<leader>bD', '<cmd>DeleteFile<cr>', { desc = 'Delete buffer and file' })

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Tree and explorer
map({ 'n' }, '-', '<cmd>Oil<cr>', { desc = 'Oil' })

-- Move selection up/down/left/right
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = '[J] Move selection down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = '[K] Move selection up' })
map('v', '>', '>gv', { desc = '[>] Indent selection' })
map('v', '<', '<gv', { desc = '[<] Unindent selection' })
map('v', '=', '=gv', { desc = '[=] Reindent selection' })

-- Copy & Paste
map('v', 'p', '"_dP', { desc = 'Paste without overwriting clipboard' })
map('n', 'Y', 'y$', { desc = 'Copy to end of line' })

-- nohlsearch
map('n', '<esc><esc>', ':nohlsearch<CR>', { desc = 'Clear highlights' })

-- windows
map('n', '<leader>ww', '<C-W>p', { desc = 'Other window' })
map('n', '<leader>wd', '<C-W>c', { desc = 'Delete window' })

-- Split {{{
map('n', '<leader>w-', '<C-W>s', { desc = 'Split window below' })
map('n', '<leader>w|', '<C-W>v', { desc = 'Split window right' })
map('n', '<leader>-', '<C-W>s', { desc = 'Split window below' })
map('n', '<leader>|', '<C-W>v', { desc = 'Split window right' })

-- Navigate buffers
map('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '[t', ':tabprevious<CR>', { desc = 'Previous tab' })
map('n', ']t', ':tabnext<CR>', { desc = 'Next tab' })

map('n', 'gp', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', 'gn', ':bnext<CR>', { desc = 'Next buffer' })
map('n', 'tp', ':tabprevious<CR>', { desc = 'Previous tab' })
map('n', 'tn', ':tabnext<CR>', { desc = 'Next tab' })

-- Other keymaps
map('n', '<leader>vim', ':tabedit ~/.config/nvim/<Return>')
map('n', '<leader>nvim', ':tabedit ~/.config/nvim/<Return>')
map('n', '<leader>tmux', ':tabedit ~/.config/tmux/<Return>')

-- Terminal Mappings
map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Enter Normal Mode' })
map('t', '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Go to left window' })
map('t', '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Go to lower window' })
map('t', '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Go to upper window' })
map('t', '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Go to right window' })
map('t', '<C-/>', '<cmd>close<cr>', { desc = 'Hide Terminal' })
map('t', '<c-_>', '<cmd>close<cr>', { desc = 'which_key_ignore' })

-- Trouble.nvim
map('n', '<leader>xx', '<cmd>TroubleToggle<CR>', { silent = true, noremap = true, desc = 'Toggle Trouble' })
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', { silent = true, noremap = true, desc = 'Toggle Trouble [W]orkspace diagnostics' })
map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', { silent = true, noremap = true, desc = 'Toggle Trouble [D]ocument diagnostics' })
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', { silent = true, noremap = true, desc = 'Toggle Trouble [L]ocation list' })
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', { silent = true, noremap = true, desc = 'Toggle Trouble [Q]uickfix' })
map('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', { silent = true, noremap = true, desc = 'Toggle Trouble [R]eferences' })
-- stylua: ignore end
