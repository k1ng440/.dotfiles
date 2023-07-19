return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require('null-ls')
      local sources = {
        nls.builtins.formatting.prettierd,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.gofmt,
        nls.builtins.formatting.golines,
        nls.builtins.diagnostics.golangci_lint,
        nls.builtins.formatting.goimports_reviser,
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.formatting.fish_indent,
        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.shfmt,
      }

      if not opts.sources then
        opts.sources = {}
      end
      for _, source in ipairs(sources) do
        table.insert(opts.sources, source)
      end
      return {
        root_dir = require('null-ls.utils').root_pattern(
          '.null-ls-root', '.neoconf.json', 'Makefile', '.git', 'package.json', 'Cargo.toml',
          'go.mod', 'go.sum', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile',
          'poetry.lock', 'composer.json', 'composer.lock', 'Gemfile', 'Gemfile.lock', 'Rakefile', 'Makefile',
          'docker-compose.yml', 'Dockerfile', 'dockerfile', 'build.gradle', 'build.gradle.kts', 'pom.xml',
          'gradlew', 'gradle', 'build.xml', 'settings.gradle', 'settings.gradle.kts'
        ),
      }
    end,
  },
}
