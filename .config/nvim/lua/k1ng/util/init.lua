require('k1ng/util/project-config')

local M = {}
M.root_patterns = { '.git', 'init.lua', 'init.vim', 'package.json', 'go.mod', 'Cargo.toml', 'Makefile', 'build.gradle' }

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
    options = vim.tbl_extend('force', options, opts)
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
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- borrowed from LazyVim
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= '' and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        ---@type string
        local r = vim.loop.fs_realpath(p)
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
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
  local params = { builtin = builtin, opts = opts }
  return function()
    opts = opts or {}
    builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend('force', { cwd = M.get_root() }, opts or {})
    if builtin == 'files' then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. '/.git') then
        opts.show_untracked = true
        builtin = 'git_files'
      else
        builtin = 'find_files'
      end
    end
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      opts.attach_mappings = function(_, map)
        map('i', '<a-c>', function()
          local action_state = require('telescope.actions.state')
          local line = action_state.get_current_line()
          M.telescope(params.builtin, vim.tbl_deep_extend('force', {}, params.opts or {}, { cwd = false, default_text = line }))()
        end)
        return true
      end
    end
    require('telescope.builtin')[builtin](opts)
  end
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

return M
