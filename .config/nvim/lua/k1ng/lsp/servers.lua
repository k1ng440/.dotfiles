local servers = {
  ansiblels = {},
  clangd = {},
  rust_analyzer = {},
  terraformls = {},
  tsserver = {},
  bashls = {},
  dockerls = {},
  helm_ls = {},
  svelte = {},
  tailwindcss = {},
  html = {},
  pyright = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'workspace',
        useLibraryCodeForTypes = true,
      },
    },
  },
  intelephense = {
    -- stylua: ignore
    stubs = {
      'bcmath', 'bz2', 'Core', 'curl', 'date', 'dom', 'fileinfo', 'filter', 'gd', 'gettext', 'hash', 'iconv', 'imap', 'intl', 'json', 'libxml', 'mbstring', 'mcrypt', 'mysql',
      'mysqli', 'password', 'pcntl', 'pcre', 'PDO', 'pdo_mysql', 'Phar', 'readline', 'regex', 'session', 'SimpleXML', 'sockets', 'sodium', 'standard', 'superglobals', 'tokenizer', 'xml', 'xdebug', 'xmlreader',
      'xmlwriter', 'yaml', 'zip', 'zlib', 'genesis-stubs', 'polylang-stubs',
    },
    files = {
      maxSize = 5000000,
    },
    environment = {
      includePaths = { '~/.config/composer/vendor/php-stubs/' },
    },
  },
  jsonls = {
    yaml = {
      completion = true,
      validate = true,
      suggest = {
        parentSkeletonSelectedFirst = true,
      },
      schemas = {
        ['https://json.schemastore.org/github-action'] = '.github/action.{yaml,yml}',
        ['https://json.schemastore.org/github-workflow'] = '.github/workflows/*',
        ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '*lab-ci.{yaml,yml}',
        ['https://json.schemastore.org/helmfile'] = 'helmfile.{yaml,yml}',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.yml.{yml,yaml}',
        ['https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json'] = 'resume.{json,yml,yaml}',
        -- stylua: ignore
        kubernetes = {
          '*-deployment.yaml', '*-deployment.yml', '*-service.yaml', '*-service.yml',
          'clusterrole-contour.yaml', 'clusterrole-contour.yml', 'clusterrole.yaml', 'clusterrole.yml',
          'clusterrolebinding.yaml', 'clusterrolebinding.yml', 'configmap.yaml', 'configmap.yml',
          'cronjob.yaml', 'cronjob.yml', 'daemonset.yaml', 'daemonset.yml', 'deployment-*.yaml',
          'deployment-*.yml', 'deployment.yaml', 'deployment.yml', 'hpa.yaml', 'hpa.yml',
          'ingress.yaml', 'ingress.yml', 'job.yaml', 'job.yml', 'kubectl-edit-*.yaml',
          'namespace.yaml', 'namespace.yml', 'pvc.yaml', 'pvc.yml', 'rbac.yaml', 'rbac.yml',
          'replicaset.yaml', 'replicaset.yml', 'role.yaml', 'role.yml', 'rolebinding.yaml',
          'rolebinding.yml', 'sa.yaml', 'sa.yml', 'secret.yaml', 'secret.yml', 'service-*.yaml',
          'service-*.yml', 'service-account.yaml', 'service-account.yml', 'service.yaml',
          'service.yml', 'serviceaccount.yaml', 'serviceaccount.yml', 'serviceaccounts.yaml',
          'serviceaccounts.yml', 'statefulset.yaml', 'statefulset.yml'
        },
      },
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
  yamlls = {
    yaml = {
      schemaStore = {
        enable = true,
        url = 'https://www.schemastore.org/api/json/catalog.json',
      },
      schemas = {
        kubernetes = '*.yaml',
        ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
        ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
        ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] = 'azure-pipelines.yml',
        ['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
        ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
        ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
        ['http://json.schemastore.org/ansible-playbook'] = '*play*.{yml,yaml}',
        ['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
        ['https://json.schemastore.org/dependabot-v2'] = '.github/dependabot.{yml,yaml}',
        ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '*gitlab-ci*.{yml,yaml}',
        ['https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json'] = '*api*.{yml,yaml}',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
        ['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
      },
      format = { enabled = false },
      -- anabling this conflicts between Kubernetes resources and kustomization.yaml and Helmreleases
      -- see utils.custom_lsp_attach() for the workaround
      -- how can I detect Kubernetes ONLY yaml files? (no CRDs, Helmreleases, etc.)
      validate = false,
      completion = true,
      hover = true,
    },
  },
  quick_lint_js = {},
  denols = {},
  gopls = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      analyses = {
        fieldalignment = true,
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
      semanticTokens = true,
    },
  },
  lua_ls = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      hint = {
        enable = false,
      },
      diagnostics = {
        globals = { 'vim', 'C' },
      },
      workspace = {
        library = {
          -- Make the server aware of Neovim runtime files
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.stdpath('config') .. '/lua',
        },
        -- adjust these two values if your performance is not optimal
        maxPreload = 2000,
        preloadFileSize = 1000,
      },
      telemetry = { enable = false },
      completion = { callSnippet = 'Insert' },
    },
  },
}

return servers

-- vim: ts=2 sts=2 sw=2 et
