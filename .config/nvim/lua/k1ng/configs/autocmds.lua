local function augroup(name)
  return vim.api.nvim_create_augroup('nvimtrap_' .. name, { clear = true })
end

vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('no_auto_comment'),
  command = [[set formatoptions-=cro]],
})

-- Disable ColorScheme when opening large files
vim.api.nvim_create_autocmd('BufRead', {
  command = [[if getfsize(expand('%')) > 100000 | setlocal eventignore+=ColorScheme | endif]],
  group = augroup('disable_colorscheme'),
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup('checktime'),
  command = 'checktime',
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup('highlight_yank'),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'vimresized' }, {
  group = augroup('resize_splits'),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('close_with_q'),
  pattern = {
    'NvimTree',
    'PlenaryTestPopup',
    'Trouble',
    'checkhealth',
    'copilot',
    'dap-float',
    'fugitive',
    'help',
    'lspinfo',
    'man',
    'neo-tree',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'netrw',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = augroup('wrap_spell'),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('auto_create_dir'),
  callback = function(event)
    if event.match:match('^%w%w+://') then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Auto save sessions
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup('save_current_session'),
  callback = function()
    local project_root = vim.g.project_root
    if project_root == nil then
      return
    end

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_get_option_value('buftype', { buf = buf }) == 'nofile' then
        return
      end
    end
    require('session_manager').save_current_session()
  end,
})

-- tmux reload on config change
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
  group = augroup('tmux_reload'),
  pattern = '*tmux.conf',
  callback = function(opts)
    if vim.env.TMUX ~= nil then
      vim.fn.jobstart({ 'tmux', 'source-file', opts.file })
    end
  end,
})

-- reload config on save
vim.api.nvim_create_autocmd('BufWritePost', {
  group = augroup('config_reload'),
  pattern = {
    '**/lua/k1ng/*.lua',
    '**/lua/k1ng/configs/*.lua',
  },
  callback = function()
    local filepath = vim.fn.expand('%')
    dofile(filepath)
    vim.notify('Reloaded \n' .. filepath, nil)
  end,
  desc = 'Reload config on save',
})

-- HACK: re-caclulate folds when entering a buffer through Telescope
-- @see https://github.com/nvim-telescope/telescope.nvim/issues/699
vim.api.nvim_create_autocmd('BufEnter', {
  group = augroup('fix_folds'),
  callback = function()
    if vim.opt.foldmethod:get() == 'expr' then
      vim.schedule(function()
        vim.opt.foldmethod = 'expr'
      end)
    end
  end,
})
