local M = {}

-- {mode}	means the mode for which the mapping is defined (i, n, v, x, s, o, t, c, l)
-- {lhs}	means the left-hand-side key(s) in the mapping
-- {rhs}	means the right-hand-side action(s) in the mapping
-- {opts}	means the options for the mapping (default: {noremap = true, silent = true})
function M.keymap(mode, lhs, rhs, opts)
  local options = {
    noremap = true,
    silent = true,
  }
  if opts then
    if type(opts) == 'string' then
      options.desc = opts
    elseif type(opts) == 'table' then
      options = vim.tbl_extend('force', options, opts)
    end
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

M.buf_keymap = function(bufnr, mode, lhs, rhs, opts)
  local options = {
    buffer = bufnr,
    noremap = true,
    silent = true,
  }
  if opts then
    if type(opts) == 'string' then
      options.desc = opts
    elseif type(opts) == 'table' then
      options = vim.tbl_extend('force', options, opts)
    end
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.autocmd(group_name, event, pattern, callback)
  local augroup = vim.api.nvim_create_augroup('core_' .. group_name, { clear = true })
  vim.api.nvim_create_autocmd(event, {
    group = augroup,
    pattern = pattern,
    callback = callback,
  })
end

-- filetype keymap
function M.ft_keymap(filetype, mode, lhs, rhs, opts)
  M.autocmd(filetype .. '_' .. mode .. '_' .. lhs, 'FileType', { filetype }, function()
    M.keymap(mode, lhs, rhs, opts)
  end)
end

-- Function using buffernames to see if "Trouble" is open
function M.has_buffer_in_list(name)
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    if string.match(vim.api.nvim_buf_get_name(buffer), name) then
      return true
    end
  end
  return false
end

-- borrowed from LazyVim
function M.fg(name)
  ---@type {foreground?:number}?
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format('#%06x', fg) }
end

-- borrowed from LazyVim
---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

-- borrowed from LazyVim
-- for `files`, git_files or find_files will be chosen depending on .git
function M.telescope(builtin, opts)
  local params = { builtin = builtin, opts = opts or {} }
  return function()
    local is_inside_work_tree = {}
    local cwd = vim.fn.getcwd()

    builtin = params.builtin
    opts = vim.tbl_deep_extend('force', {
      cwd = cwd,
      show_untracked = true,
    }, params.opts)

    if is_inside_work_tree[cwd] == nil then
      vim.fn.system('git rev-parse --is-inside-work-tree')
      is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
      builtin = 'git_files'
    else
      builtin = 'find_files'
    end

    require('telescope.builtin')[builtin](opts)
  end
end

function M.telescope_neovim_config()
  require('telescope.builtin').find_files({
    cwd = vim.env.HOME .. '/.config/nvim',
    prompt = '~ Neovim Configs ~',
    -- height = 10,
    layout_strategy = 'horizontal',
  })
end

function M.telescope_keymaps()
  require('telescope.builtin')['keymaps']({
    lhs_filter = function(lhs)
      if string.find(lhs, 'Þ') or string.find(lhs, 'Plug') then
        return false
      end

      return true
    end,
  })
end

function M.border_color(border, color)
  local result = {}
  for _, v in ipairs(border) do
    table.insert(result, { v, color })
  end
end

function M.tbl_insert(tbl, ...)
  local args = { ... }
  for _, v in ipairs(args) do
    table.insert(tbl, v)
  end
end

function M.config_home()
  if vim.env.XDG_CONFIG_HOME ~= nil then
    return vim.env.XDG_CONFIG_HOME
  end

  return vim.env.HOME .. '/.config'
end

function M.set_yadm_git()
  vim.b[vim.api.nvim_get_current_buf()].git_dir = vim.env.HOME .. '/.local/share/yadm/repo.git'
  if vim.fn.exists('*FugitiveDetect') ~= 0 then
    vim.fn.FugitiveDetect(vim.env.HOME .. '/.local/share/yadm/repo.git')
  end
end

return M
