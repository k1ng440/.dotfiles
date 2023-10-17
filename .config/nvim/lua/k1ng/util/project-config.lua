local root_markers = { '.git', 'Makefile', 'ansible.cfg', 'go.mod' }
local exrcs = { '.nvim.lua', '.nvimrc', '.exrc' }

-- If there's an exrc file that's trusted at the given path,
-- source it, otherwise return
local read_exrc = function(path)
  if vim.o.exrc == false then
    return
  end

  -- stops on first found, returns table so we index it to get string
  local exrc = vim.fs.find(exrcs, {
    path = path,
    type = 'file',
  })[1] -- string|nil
  if not exrc then
    return
  end

  if vim.secure.read(exrc) then
    vim.cmd.source(exrc)
  end
end

-- Return directory path to start search from
local set_project_root = function()
  local cwd = vim.fn.getcwd()

  local root_marker = vim.fs.find(root_markers, {
    path = cwd,
    upward = true,
  })[1]

  if not root_marker then
    return
  end

  -- otherwise you get root_dir as '/foo/bar/.git', '/foo/bar'
  local root_dir = vim.fs.dirname(root_marker)

  vim.fn.chdir(root_dir)
  read_exrc(root_dir)
end

vim.api.nvim_create_autocmd('BufEnter', {
  group = vim.api.nvim_create_augroup('Rooter', {}),
  desc = 'Find project root on BufEnter. cd there and try reading any exrc there.',
  callback = set_project_root,
})
