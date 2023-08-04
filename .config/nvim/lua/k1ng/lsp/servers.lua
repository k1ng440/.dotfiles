local servers = {
  ansiblels = {},
  clangd = {},
  rust_analyzer = {},
  tsserver = {},
  bashls = {},
  dockerls = {},
  helm_ls = {},
  pyright = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
      },
    },
  },
  intelephense = {
    stubs = {
      "bcmath", "bz2", "Core", "curl", "date", "dom", "fileinfo", "filter", "gd", "gettext", "hash", "iconv", "imap",
      "intl",
      "json", "libxml", "mbstring", "mcrypt", "mysql", "mysqli", "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar",
      "readline", "regex", "session", "SimpleXML", "sockets", "sodium", "standard", "superglobals", "tokenizer", "xml",
      "xdebug", "xmlreader", "xmlwriter", "yaml", "zip", "zlib", "genesis-stubs", "polylang-stubs",
    },
    files = {
      maxSize = 5000000,
    },
    environment = {
      includePaths = { "~/.composer/vendor/php-stubs/" },
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
        ["https://json.schemastore.org/github-action"] = ".github/action.{yaml,yml}",
        ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*lab-ci.{yaml,yml}",
        ["https://json.schemastore.org/helmfile"] = "helmfile.{yaml,yml}",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.yml.{yml,yaml}",
        ["https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json"] = "resume.{json,yml,yaml}",
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
  yamlls = {},
  -- quick_lint_js = {},
  -- denols = {},
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
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
  lua_ls = {
    Lua = {
      telemetry = { enable = false },
      completion = {
        callSnippet = "Replace"
      },
    },
  },
}


return servers

-- vim: ts=2 sts=2 sw=2 et
