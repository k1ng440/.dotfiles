-- settings for each language server
local util = require('k1ng.lsp.utils')

local M = {
  servers = {
    ansiblels = {},
    clangd = {
      cmd = {
        'clangd',
        '--offset-encoding=utf-16',
        '--enable-config',
      },
      root_dir = function(fname)
        local root_files = {
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac', -- AutoTools
        }

        return util.get_root_dir(fname, unpack(root_files))
      end
    },
    rust_analyzer = {},
    terraformls = {},
    tsserver = {
      root_dir = function(fname)
        return require('lspconfig.util').root_pattern('package.json', 'tsconfig.json') or vim.fn.getcwd()
      end,
    },
    denols = {
      root_dir = function(fname)
        return require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
      end,
    },
    bashls = {},
    dockerls = {},
    helm_ls = {},
    svelte = {},
    tailwindcss = {},
    html = {},
    emmet_language_server = {},
    pyright = {
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = 'workspace',
            useLibraryCodeForTypes = true,
          },
        },
      },
    },
    intelephense = {
      root_dir = function(fname)
        local root_files = {
          'composer.json',
          'composer.lock',
          '.git',
          'phpunit.xml',
          '.php_cs',
        }
        return require('lspconfig.util').root_pattern(root_files)(fname) or vim.fn.getcwd()
      end,
      init_options = {
        licenceKey = vim.fn.expand('~/.vim/intelephense/license.txt'),
      },
      settings = {
        -- stylua: ignore
        stubs = {
          'bcmath', 'bz2', 'Core', 'curl', 'date', 'dom', 'fileinfo', 'filter', 'gd', 'gettext', 'hash', 'iconv', 'imap',
          'intl', 'json', 'libxml', 'mbstring', 'mcrypt', 'mysql',
          'mysqli', 'password', 'pcntl', 'pcre', 'PDO', 'pdo_mysql', 'Phar', 'readline', 'regex', 'session', 'SimpleXML',
          'sockets', 'sodium', 'standard', 'superglobals', 'tokenizer', 'xml', 'xdebug', 'xmlreader',
          'xmlwriter', 'yaml', 'zip', 'zlib', 'genesis-stubs', 'polylang-stubs',
        },
        files = {
          maxSize = 5000000,
        },
        environment = {
          includePaths = { '~/.config/composer/vendor/php-stubs/' },
        },
      },
    },
    jsonls = {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
        redhat = {
          telemetry = {
            enabled = false,
          },
        },
      },
    },
    yamlls = {
      settigns = {
        yaml = {
          schemaStore = {
            enable = false,
            url = '',
          },
          schemas = require('schemastore').yaml.schemas(),
          completion = true,
          hover = true,
        },
      },
    },
    quick_lint_js = {},
    templ = {},
    gopls = {
      settings = {
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
    },
    lua_ls = {
      settings = {
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
            checkThirdParty = false,
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
    },
    jdtls = {},
  },
}

function M.setCapabilities(server_name, capabilities)
  M.server[server_name].capabilities = capabilities
end

function M.listServers()
  return vim.tbl_keys(M.servers)
end

function M.getServerConfig(server_name)
  return M.servers[server_name] or {}
end

return M

-- vim: ts=2 sts=2 sw=2 et
