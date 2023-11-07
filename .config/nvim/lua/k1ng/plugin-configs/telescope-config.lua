local telescope_installed, telescope = pcall(require, 'telescope')
if not telescope_installed then
  return vim.warn('telescope.nvim is not installed.')
end

local Util = require('k1ng.util')
local keymap = require('k1ng.util').keymap

local actions = require('telescope.actions')
local themes = require('telescope.themes')
local previewers = require('telescope.previewers')
local sorters = require('telescope.sorters')
local layout = require('telescope.actions.layout')

local bc = vim.g.bc
local no_preview = function(opts)
  local defaults = require('telescope.themes').get_dropdown({
    -- stylua: ignore
    borderchars = {
      { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
      prompt = { bc.horiz, bc.vert, " ", bc.vert, bc.topleft, bc.topright, bc.vert, bc.vert },
      results = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.vertright, bc.vertleft, bc.botright, bc.botleft },
      preview = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
    },
    width = 0.8,
    previewer = false,
    prompt_title = false,
    results_title = false,
  })
  return vim.tbl_deep_extend('keep', opts or {}, defaults)
end

local ivy = function(options)
  local defaults = themes.get_ivy({
    layout_config = {
      height = 0.3,
    },
  })

  return vim.tbl_deep_extend('force', defaults, options or {})
end

local ivy_tall = function(options)
  local defaults = {
    initial_mode = 'normal',
    layout_config = {
      height = 0.5,
      width = 0.5,
    },
  }

  return ivy(vim.tbl_deep_extend('force', defaults, options or {}))
end

local open_with_trouble = function(...)
  return require('trouble.providers.telescope').open_with_trouble(...)
end

local open_selected_with_trouble = function(...)
  return require('trouble.providers.telescope').open_selected_with_trouble(...)
end

local find_files_no_ignore = function()
  local action_state = require('telescope.actions.state')
  local line = action_state.get_current_line()
  Util.telescope('find_files', { no_ignore = true, default_text = line })()
end

local find_files_with_hidden = function()
  local action_state = require('telescope.actions.state')
  local line = action_state.get_current_line()
  Util.telescope('find_files', { hidden = true, default_text = line })()
end

telescope.setup({
  ------------ pickers ------------
  pickers = {
    ['autocommands'] = ivy(),
    ['buffers'] = ivy(),
    ['commands'] = ivy(),
    ['git_commits'] = ivy_tall(),
    ['grep_string'] = ivy(),
    ['help_tags'] = ivy(),
    ['highlights'] = ivy(),
    ['keymaps'] = ivy(),
    ['live_grep'] = ivy_tall({ initial_mode = 'insert' }),
    ['lsp_workspace_symbols'] = ivy(),
    ['lsp_implementations'] = ivy(),
    ['lsp_references'] = ivy(),
    ['quickfix'] = ivy(),
    ['git_files'] = ivy(),
    ['find_files'] = ivy(),
    ['diagnostics'] = ivy(),
  },

  ------------ default ------------
  defaults = {
    ['ui-select'] = no_preview(),
    theme = 'ivy',
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!{.git,.svn,.hg,.DS_Store,thumbs.db,node_modules,bower_components,lazy-lock.json,LICENSE,LICENSE.md}',
    },
    file_ignore_patterns = {
      '^node_modules/',
      '^dist/',
      '^.git/',
      '^.direnv/',
      '^.sqlx/',
      '%.png',
      '%.jpg',
      '%.jpeg',
      '%.svg',
      '%.ttf',
      '%.otf',
      '%.lock',
      '%-lock.json',
      '%.wasm',
      '%.xml',
      '%.css',
      '%.tmTheme',
      'shell/zsh%-syntax%-highlighting/',
      'shell/zsh%-autosuggestions/',
      '^gtk/',
      'nvim/pack/',
      '%.snap',
    },
    prompt_prefix = '   ',
    selection_caret = '  ',
    sort_mru = true,
    sorting_strategy = 'ascending',
    border = {},
    borderchars = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
    color_devicons = true,
    entry_prefix = '  ',
    layout_strategy = 'vertical',
    preview = {
      hide_on_startup = false, -- hide previewer when picker starts
    },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = { shorten = { len = 2 } }, -- truncate
    winblend = 0,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    mappings = {
      -- stylua: ignore
      i = {
        -- Trouble
        ['<c-t>'] = open_with_trouble,
        ['<a-t>'] = open_selected_with_trouble,

        -- Toggle
        ["<a-i>"] = find_files_no_ignore,
        ["<a-h>"] = find_files_with_hidden,

        -- Cycle history
        ['<C-Down>'] = actions.cycle_history_next,
        ['<C-Up>'] = actions.cycle_history_prev,

        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        -- Previewer
        ['<M-p>'] = layout.toggle_preview,
        ['<C-f>'] = actions.preview_scrolling_down,
        ['<C-b>'] = actions.preview_scrolling_up,

        ["<C-Space>"] = actions.to_fuzzy_refine,
        ["<Esc>"] = actions.close,
        ['<C-u>'] = false, -- Clear prompt
      },
      -- stylua: ignore
      n = {
        ['q'] = actions.close,
      },
    },
  },

  ------------ extensions ------------
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
})

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
pcall(telescope.load_extension, 'http')
pcall(telescope.load_extension, 'trouble')

local pickers = require('telescope.builtin')

keymap('n', '<leader>,', '<cmd>Telescope buffers show_all_buffers=true ignore_current_buffer=true sort_lastused=true<cr>', { desc = 'Switch Buffer' })
keymap('n', '<leader>b', '<cmd>Telescope buffers show_all_buffers=true ignore_current_buffer=true sort_lastused=true<cr>', { desc = 'Switch Buffer' })
keymap('n', '<leader>bb', '<cmd>Telescope buffers show_all_buffers=true ignore_current_buffer=true sort_lastused=true<cr>', { desc = 'Switch Buffer' })
keymap('n', '<leader>ob', '<cmd>Telescope buffers show_all_buffers=true ignore_current_buffer=true sort_lastused=true<cr>', { desc = 'Switch Buffer' })
keymap('n', '<leader>sw', '<cmd>Telescope grep_string<CR>', { desc = '[S]earch [W]ord' })
keymap('n', '<leader>:', '<cmd>Telescope command_history<cr>', { desc = 'Command History' })
keymap('n', '<leader>sC', '<cmd>Telescope commands<cr>', { desc = 'Commands' })
keymap('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', { desc = '[R]ecent' })
keymap('n', '<leader>sg', '<cmd>Telescope live_grep<cr>', { desc = 'Grep' })
keymap('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { desc = '[G]it [C]ommits' })
keymap('n', '<leader>gs', '<cmd>Telescope git_status<CR>', { desc = '[G]it [S]tatus' })
keymap('n', '<leager>sa', '<cmd>Telescope autocommands<cr>', { desc = 'Auto Commands' })
keymap('n', '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Buffer' })
keymap('n', '<leader>sh', '<cmd>Telescope help_tags<cr>', { desc = 'Help Pages' })
keymap('n', '<leader>sr', '<cmd>Telescope resume<cr>', { desc = 'Resume' })
keymap('n', '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', { desc = 'Document diagnostics' })
keymap('n', '<leader>sD', '<cmd>Telescope diagnostics<cr>', { desc = 'Workspace diagnostics' })
keymap('n', '<leader>sk', Util.telescope_keymaps, { desc = 'Key Maps' })
keymap('n', '<leader>sO', '<cmd>Telescope vim_options<cr>', { desc = '[S]earch [O]ptions' })
keymap('n', '<leader>sM', '<cmd>Telescope man_pages<cr>', { desc = 'Man Pages' })
keymap('n', '<leader>sm', '<cmd>Telescope marks<cr>', { desc = 'Jump to Mark' })
keymap('n', '<leader>li', '<cmd>Telescope lsp_incoming_calls<cr>', { desc = '[l]sp [i]ncoming calls' })
keymap('n', '<leader>lo', '<cmd>Telescope lsp_outgoing_calls<cr>', { desc = '[l]sp [o]utgoing calls' })
-- stylua: ignore
keymap('n', '<leader>ss', Util.telescope( 'lsp_document_symbols', { symbols = { 'Class', 'Function', 'Method', 'Constructor', 'Interface', 'Module', 'Struct', 'Trait', 'Field', 'Property' } }), { desc = 'Goto Symbol' })
-- stylua: ignore
keymap('n', '<leader>sS', Util.telescope( 'lsp_dynamic_workspace_symbols', { symbols = { 'Class', 'Function', 'Method', 'Constructor', 'Interface', 'Module', 'Struct', 'Trait', 'Field', 'Property' } }), { desc = 'Goto Symbol (Workspace)' })

local find_dotfiles = function(subdir)
  local cwd = vim.env.HOME .. '/.config/'
  if subdir ~= nil and subdir ~= '' then
    cwd = cwd .. subdir
  end

  pickers.find_files({
    prompt_title = '~ dotfiles ~',
    hidden = true,
    follow = true,
    cwd = vim.env.HOME,
    find_command = { 'yadm', 'ls-files' },
  })
end

local find_files = function()
  local cwd = vim.fn.expand('%:p:h')
  if vim.startswith(cwd, vim.env.HOME .. '/.dotfiles') or vim.startswith(cwd, vim.env.HOME .. '/.config') then
    return find_dotfiles()
  end

  local options = {
    hidden = true,
    follow = true,
    show_untracked = true,
  }

  if not pcall(pickers.git_files, options) then
    pickers.find_files(options)
  end
end

keymap('n', '<Leader>df', find_dotfiles, { desc = '[d]otfiles [f]iles' })
keymap('n', '<Leader>ff', function() end)
keymap('n', '<leader>ff', find_files, { desc = '[F]ind [F]iles' })
keymap('n', '<leader>sf', find_files, { desc = '[F]ind [F]iles' })
keymap('n', '<Leader>fhh', function()
  pickers.grep_string(themes.get_dropdown({
    prompt_title = 'Help',
    search = '',
    search_dirs = vim.api.nvim_get_runtime_file('doc/*.txt', true),
    only_sort_text = true,
    disable_coordinates = true,
    path_display = 'hidden',
    layout_config = {
      anchor = 'S',
      prompt_position = 'bottom',
      height = 0.35,
      width = 0.9,
    },
  }))
end, { desc = '[f]ind [h]elp [h]ere' })
