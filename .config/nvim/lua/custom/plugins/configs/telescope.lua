local bc = vim.g.bc
local no_preview = function(opts)
  local defaults = require("telescope.themes").get_dropdown({
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
  return vim.tbl_deep_extend("keep", opts or {}, defaults)
end

local options = {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '-L',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    borderchars = { bc.horiz, bc.vert, bc.horiz, bc.vert, bc.topleft, bc.topright, bc.botright, bc.botleft },
    prompt_prefix = '   ',
    selection_caret = '  ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'horizontal',
    layout_config = {
      horizontal = {
        prompt_position = 'top',
        preview_width = 0.55,
        results_width = 0.3,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    pickers = {
      find_files = no_preview(),
      live_grep = no_preview({
        previewer = true,
      }),
      load_session = no_preview(),
    },
    extensions = {
      file_browser = {
        grouped = true,
        sorting_strategy = "ascending",
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
    ["ui-select"] = no_preview(),
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    file_ignore_patterns = { 'node_modules' },
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
    winblend = 0,
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
    mappings = {
      n = { ['q'] = require('telescope.actions').close },
    },
  },
  extensions_list = { 'file_browser' },
}

return options
