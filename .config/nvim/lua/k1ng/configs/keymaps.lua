local Util = require('k1ng.util')
local map = Util.keymap

map({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true, desc = 'Disable <Space>' })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = '[k] Move up' })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = '[j] Move down' })
map('n', ';', ':')
map('n', 'Q', '@q', { desc = 'Replay macro' })
map('n', '<Tab>', '%', { desc = 'Remap % to Tab' })

-- Close buffer
map('n', '<Leader>q', '<cmd>close<cr>', { desc = 'Close buffer' })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- Move selection up/down/left/right
map("v", "J", ":m '>+1<CR>gv=gv", { desc = '[J] Move selection down' })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = '[K] Move selection up' })
map("v", ">", ">gv", { desc = '[>] Indent selection' })
map("v", "<", "<gv", { desc = '[<] Unindent selection' })
map("v", "=", "=gv", { desc = '[=] Reindent selection' })

-- Copy & Paste
map('v', 'p', '"_dP', { desc = 'Paste without overwriting clipboard' })
map('n', 'Y', 'Y$', { desc = 'Copy to end of line' })

-- nohlsearch
map('n', '<esc><esc>', ':nohlsearch<CR>', { desc = 'Clear highlights' })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below", })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", })

-- Split navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", })

-- Split reslizing
map('n', '<C-Up>', ':resize -2<CR>', { desc = '[Up] Resize split up' })
map('n', '<C-Down>', ':resize +2<CR>', { desc = '[Down] Resize split down' })
map('n', '<C-Left>', ':vertical resize -2<CR>', { desc = '[Left] Resize split left' })
map('n', '<C-Right>', ':vertical resize +2<CR>', { desc = '[Right] Resize split right' })
-- terminal
map("t", "<C-Up>", "<cmd>resize -2<CR>")
map("t", "<C-Down>", "<cmd>resize +2<CR>")
map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- Navigate buffers
map('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer', })
map('n', ']b', ':bnext<CR>', { desc = 'Next buffer',  })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- Telescope
-- map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- map('n', '\\\\', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
-- map('n', '<leader>/', function()
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 5,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })
-- map('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
-- map('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- map('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
-- map('n', '<leader>sg', Util.telescope("live_grep"), { desc = '[S]earch by [G]rep (root)' })
-- map('n', '<leader>sG', Util.telescope("live_grep"), { desc = '[S]earch by [G]rep (cwd)' })
-- --
--        -- "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
--
-- map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- map('n', '<leader>sc', require('telescope.builtin').colorscheme, { desc = '[S]earch [C]olorscheme' })
-- map('n', '<leader>st', require('telescope.builtin').tags, { desc = '[S]earch [T]ags' })
-- map('n', '<leader>sr', require('telescope.builtin').registers, { desc = '[S]earch [R]egisters' })
-- map('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
-- map('n', '<leader>sm', require('telescope.builtin').marks, { desc = '[S]earch [M]arks' })
-- map('n', '<leader>so', require('telescope.builtin').vim_options, { desc = '[S]earch Vim [O]ptions' })
-- map('n', '<leader>ss', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[S]earch [S]tring' })

-- lazygit
-- --@stylua: ignore
map("n", "<leader>gg", function() Util.float_term({ "lazygit" }, { cwd = Util.get_root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() Util.float_term({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (cwd)" })

-- floating terminal
local lazyterm = function() Util.float_term(nil, { cwd = Util.get_root() }) end
map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Util.float_term() end, { desc = "Terminal (cwd)" })
map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Copilot
map('n', '<A-p>', function() require('copilot.panel').open() end, { desc = 'Open Copilot Panel' })

-- Trouble.nvim
map('n', '<leader>xx', '<cmd>TroubleToggle<CR>', { silent = true, noremap = true, desc = 'Toggle Trouble' })
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [W]orkspace diagnostics' })
map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [D]ocument diagnostics' })
map('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [L]ocation list' })
map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [Q]uickfix' })
map('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [R]eferences' })
