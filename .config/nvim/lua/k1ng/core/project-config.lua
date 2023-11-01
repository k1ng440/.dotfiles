local M = {}

M.root_markers = {
  '.go',
  '.work',
  '.project',
  '.nvimroot',
  '.git',
  '_darcs',
  '.hg',
  '.bzr',
  '.svn',
  'Makefile',
  'package.json',
  'Cargo.toml',
  'composer.json',
}

M.exrcs = {
  '.nvim.lua',
  '.nvimrc',
  '.exrc',
}

M.ignore_filetype = {
  'oil',
  'term',
  'toggleterm',
}

function M.setup()
  local Util = require('k1ng.util')
  local config_home = Util.config_home()
  local current_root_marker = ''
  local has_yadm = vim.fn.executable('yadm')

  -- If there's an exrc file that's trusted at the given path,
  -- source it, otherwise return
  local read_exrc = function(path)
    if vim.o.exrc == false then
      return
    end

    local exrc = vim.fs.find(M.exrcs, {
      path = path,
      type = 'file',
    })[1]
    if not exrc then
      return
    end

    if vim.secure.read(exrc) then
      vim.cmd.source(exrc)
    end
  end

  local yadm_git_root = function()
    if not has_yadm then
      return
    end

    if vim.g.project_root == config_home or string.sub(vim.g.project_root, 1, #config_home) == config_home then
      Util.set_yadm_git()
      return
    end

    local filepath = vim.fn.expand('%:p')
    vim.fn.jobstart({ 'yadm', 'ls-files', '--error-unmatch', filepath }, {
      on_exit = function(j, d, e)
        if d == 0 then
          Util.set_yadm_git()
        end
      end,
    })
  end

  local set_project_root = function()
    local filepath = vim.fn.expand('%:p')
    if vim.fn.filereadable(filepath) ~= 1 then
      return
    end

    for _, ft in ipairs(M.ignore_filetype) do
      if ft == vim.bo.filetype then
        return
      end
    end

    local root_marker = vim.fs.find(M.root_markers, {
      path = vim.fs.dirname(filepath),
      upward = true,
    })[1]

    if not root_marker then
      return
    end

    if root_marker == current_root_marker then
      return
    end
    current_root_marker = root_marker

    local root_dir = vim.fs.dirname(root_marker)
    vim.fn.chdir(root_dir)
    vim.g.project_root = root_dir
    vim.api.nvim_exec_autocmds('User', { pattern = 'ProjectRoot', data = { dir = root_dir } })
    yadm_git_root()
    read_exrc(root_dir)
  end

  -- TODO: This need to be fixed. It's not working as expected.
  -- Opening file outside of project root should not change the project root.
  vim.api.nvim_create_autocmd({ 'BufEnter', 'VimEnter' }, {
    group = vim.api.nvim_create_augroup('nvim_rooter', {}),
    desc = 'Find project root on BufEnter. cd there and try reading any exrc there.',
    callback = set_project_root,
  })
end

return M
