-- Leader is set in init.lua

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('n', '<Tab>', '%')

-- Move selection up/down/left/right
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "=", "=gv")

-- Copy & Paste
vim.keymap.set('v', 'p', '"_dP')
vim.keymap.set('n', 'Y', 'Y$')

-- Split
vim.keymap.set('n', '<leader><space>h', ':split<CR>', { desc = '[h] Split horizontally' })
vim.keymap.set('n', '<leader><space>v', ':vsplit<CR>', { desc = '[v] Split vertically' })
vim.keymap.set('n', '<leader><space>o', ':only<CR>', { desc = '[o] Close other windows' })
vim.keymap.set('n', '<leader><space>q', ':q<CR>', { desc = '[q] Close window' })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')

-- Split reslizing
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Navigate buffers
vim.keymap.set('n', '<C-h>', ':bprevious<CR>')
vim.keymap.set('n', '<C-l>', ':bnext<CR>')

-- NvimTree
vim.keymap.set('n', '<C-n>', '<cmd>:NvimTreeFindFileToggle<CR>')

-- LspSaga
vim.keymap.set({ 'n', 't' }, '<A-d>', '<cmd>Lspsaga term_toggle<CR>')

-- Telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '\\\\', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<C-/>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- Copilot
vim.keymap.set({ 'n' }, '<A-p>', require('copilot.panel').open, { desc = 'Open Copilot Panel' })

-- -- GitHub
-- vim.keymap.set({ 'n' }, '<leader>gb', require('neogit').open, { desc = '[G]it [B]ranch' })
--
-- -- Nvim-Tree
-- vim.keymap.set({ 'n' }, '<leader>nt', require('nvim-tree').toggle, { desc = '[N]vim [T]ree' })
-- vim.keymap.set({ 'n' }, '<leader>nr', require('nvim-tree').refresh, { desc = '[N]vim [R]efresh' })
-- vim.keymap.set({ 'n' }, '<leader>nf', require('nvim-tree').find_file, { desc = '[N]vim [F]ind file' })
--
-- -- Git Gutter
-- vim.keymap.set({ 'n' }, '<leader>gh', ':GitGutterLineHighlightsToggle<CR>', { desc = '[G]it [H]ighlights' })
-- vim.keymap.set({ 'n' }, '<leader>gn', ':GitGutterLineHighlightsDisable<CR>', { desc = '[G]it [N]o [H]ighlights' })
--
-- -- Git Signs
-- vim.keymap.set({ 'n' }, '<leader>gs', ':Gitsigns toggle_signs<CR>', { desc = '[G]it [S]igns' })
-- vim.keymap.set({ 'n' }, '<leader>gn', ':Gitsigns toggle_numhl<CR>', { desc = '[G]it [N]um [H]ighlights' })
-- vim.keymap.set({ 'n' }, '<leader>gl', ':Gitsigns toggle_linehl<CR>', { desc = '[G]it [L]ine [H]ighlights' })
-- vim.keymap.set({ 'n' }, '<leader>gt', ':Gitsigns toggle_current_line_blame<CR>', { desc = '[G]it [T]oggle [B]lame' })

-- Git
-- vim.keymap.set({ 'n' }, '<leader>g', ':Git<CR>', { desc = '[G]it' })
-- vim.keymap.set({ 'n' }, '<leader>gd', ':Gdiff<CR>', { desc = '[G]it [D]iff' })



-- Trouble.nvim
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<CR>',
  { silent = true, noremap = true, desc = 'Toggle Trouble' }
)
vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [W]orkspace diagnostics' }
)
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [D]ocument diagnostics' }
)
vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [L]ocation list' }
)
vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [Q]uickfix' }
)
vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>',
  { silent = true, noremap = true, desc = 'Toggle Trouble [R]eferences' }
)
