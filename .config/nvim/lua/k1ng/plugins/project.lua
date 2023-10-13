return {
  {
    'ahmedkhalf/project.nvim',
    -- https://github.com/ahmedkhalf/project.nvim
    opts = {
      manual_mode = false,
      detection_methods = { 'lsp', 'pattern' },
      patterns = {
        '.go', '.work', '.project',
        '.git', '_darcs', '.hg', '.bzr',
        '.svn', 'Makefile', 'package.json', 'Cargo.toml'
      },
      exclude_dirs = {},
      show_hidden = false,
      silent_chdir = true,
      scope_chdir = 'global'
    },
    config = function(opts)
      require("project_nvim").setup(opts.opts)
      require('telescope').load_extension('projects')
    end
  }, {
    'windwp/nvim-projectconfig',
    opts = {
      autocmd = true,
      silent = false,
    }
  }
}
