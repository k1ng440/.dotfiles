local M = {}

M.linterConfigFolder = os.getenv('HOME') .. '/.config/nvim/linter-configs/'

--- @param mode "n"|"v"|"x"|"i"|"o"|"c"|"t"|"ia"|"ca"|"!a"|string[]
--- @param lhs string
--- @param rhs string|function
--- @param opts? { unique: boolean, desc: string, buffer: boolean, nowait: boolean, remap: boolean }|string
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

--- @param bufnr number
--- @param mode "n"|"v"|"x"|"i"|"o"|"c"|"t"|"ia"|"ca"|"!a"|string[]
--- @param lhs string
--- @param rhs string|function
--- @param opts? { unique: boolean, desc: string, buffer: boolean, nowait: boolean, remap: boolean }
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

---https://www.reddit.com/r/neovim/comments/oxddk9/comment/h7maerh/
---@param name string name of highlight group
---@param key "fg"|"bg"
---@nodiscard
---@return string|nil the value, or nil if hlgroup or key is not available
function M.getHighlightValue(name, key)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name })
  if not ok then
    return
  end
  local value = hl[key]
  if not value then
    return
  end
  return string.format('#%06x', value)
end

---runs :normal natively with bang
---@param cmdStr string
function M.normal(cmdStr)
  vim.cmd.normal({ cmdStr, bang = true })
end

---@param str string
---@param filePath string line(s) to add
---@param mode "w"|"a" -- write or append
---@return string|nil error
---@nodiscard
function M.writeToFile(filePath, str, mode)
  local file, error = io.open(filePath, mode)
  if not file then
    return error
  end
  file:write(str .. '\n')
  file:close()
end

-- reads a template to apply if the file is empty. Add to a filetype config to
-- activate templates for it
-- @param ext string extension of the skeleton
function M.applyTemplateIfEmptyFile(ext)
  -- prevent buggy duplicate application of template
  if vim.b.templateWasApplied then
    return
  end
  vim.b.templateWasApplied = true ---@diagnostic disable-line: inject-field

  vim.defer_fn(function()
    local filename = vim.fn.expand('%')
    local fileExists = vim.loop.fs_stat(filename) ~= nil
    if not fileExists then
      return
    end

    local skeletonFile = vim.fn.stdpath('config') .. '/templates/skeleton.' .. ext
    local skeletonExists = vim.loop.fs_stat(skeletonFile) ~= nil
    if not skeletonExists then
      vim.notify('Skeleton file not found.', vim.log.levels.ERROR)
      return
    end

    local fileIsEmpty = vim.loop.fs_stat(filename).size < 4 -- account for linebreaks
    if not fileIsEmpty then
      return
    end

    vim.cmd('silent keepalt 0read ' .. skeletonFile)
    M.normal('G')
  end, 1)
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
