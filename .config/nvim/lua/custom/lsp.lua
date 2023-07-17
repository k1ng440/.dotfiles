require('neodev').setup()

vim.diagnostic.config({
  virtual_text = false
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- EOF Diagnostic keymaps

-- Lspsaga
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Go to previous diagnostics message (ERROR)" })

vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Go to next diagnostics message (ERROR)" })


vim.keymap.set('n', '<leader>rn', '<Cmd>Lspsaga rename<CR>', { desc = '[R]e[n]ame' })
vim.keymap.set('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', { desc = 'Peek Definition' })
vim.keymap.set('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', { desc = '[P]eek [D]efinition' })

-- EOF Lspsaga



-- [[ Configure LSP ]]
local on_attach = function(client, bufnr)
  -- Go
  -- workaround for gopls not supporting semanticTokensProvider
  -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  if client.name == "gopls" then
    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
        range = true,
      }
    end
  end
  -- EOF Go

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', '<Cmd>Lspsaga rename<CR>', '[R]e[n]ame')
  nmap('<leader>rn', '<Cmd>Lspsaga rename<CR>', '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', '<cmd> Lspsaga lsp_finder <CR>', '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('<C-k>', '<cmd> Lspsaga signature_help <CR>', 'Signature Documentation')

  -- See `:help K` for why this keymap
  nmap('K', '<cmd> Lspsaga hover_doc <CR>', 'Hover Documentation')
  nmap('<leader>ld', '<cmd> Lspsaga show_line_diagnostics <CR>', 'Show [L]ine [D]iagnostics')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  ansiblels = {},
  clangd = {},
  rust_analyzer = {},
  tsserver = {},
  bashls = {},
  intelephense = {
    stubs = {
      "bcmath", "bz2", "Core", "curl", "date", "dom", "fileinfo",
      "filter", "gd", "gettext", "hash", "iconv", "imap", "intl",
      "json", "libxml", "mbstring", "mcrypt", "mysql", "mysqli",
      "password", "pcntl", "pcre", "PDO", "pdo_mysql", "Phar",
      "readline", "regex", "session", "SimpleXML", "sockets",
      "sodium", "standard", "superglobals", "tokenizer", "xml",
      "xdebug", "xmlreader", "xmlwriter", "yaml", "zip", "zlib",
      "wordpress-stubs", "woocommerce-stubs", "acf-pro-stubs", "wordpress-globals",
      "wp-cli-stubs", "genesis-stubs", "polylang-stubs",
    },
    files = {
      maxSize = 5000000,
    },
    environment = {
      includePaths = { "~/.composer/vendor/php-stubs/" },
    },
  },
  jsonls = {},
  yamlls = {},
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
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
  lua_ls = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
