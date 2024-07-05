return {
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'VeryLazy',
    config = function()
      require('k1ng.plugin-configs.cmp')
    end,
    dependencies = {
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        build = (function()
          if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        config = function()
          local luasnip = require('luasnip')
          local types = require('luasnip.util.types')

          require('luasnip.loaders.from_vscode').lazy_load()

          -- HACK: Cancel the snippet session when leaving insert mode.
          vim.api.nvim_create_autocmd('ModeChanged', {
            group = vim.api.nvim_create_augroup('UnlinkSnippetOnModeChange', { clear = true }),
            pattern = { 's:n', 'i:*' },
            callback = function(event)
              if luasnip.session and luasnip.session.current_nodes[event.buf] and not luasnip.session.jump_active then
                luasnip.unlink_current()
              end
            end,
          })

          luasnip.setup({
            snippets = {
              go = require('k1ng.luasnip.go'),
              gitcommit = require('k1ng.luasnip.gitcommit'),
            },
            -- Display a cursor-like placeholder in unvisited nodes
            -- of the snippet.
            ext_opts = {
              [types.insertNode] = {
                unvisited = {
                  virt_text = { { '|', 'Conceal' } },
                  virt_text_pos = 'inline',
                },
              },
              [types.exitNode] = {
                unvisited = {
                  virt_text = { { '|', 'Conceal' } },
                  virt_text_pos = 'inline',
                },
              },
            },
          })
        end,
      },
      'hrsh7th/cmp-nvim-lsp-signature-help',
      {
        'saadparwaiz1/cmp_luasnip',
        version = '2.*',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load({
            path = { vim.fn.stdpath('config') .. '/snippets' },
          })
        end,
      },
    },
  },
  { 'hrsh7th/cmp-nvim-lsp', event = 'VeryLazy', dependencies = 'hrsh7th/nvim-cmp' },
  {
    'hrsh7th/cmp-cmdline',
    enabled = false,
    dependencies = {
      'hrsh7th/cmp-buffer',
    },
    event = 'VeryLazy',
    config = function()
      local cmp = require('cmp')
      local keymaps = {
        ['<C-Space>'] = { c = cmp.mapping.complete({}) },
        -- ['<C-n>'] = { c = false },
        -- ['<C-p>'] = { c = false },
        ['<C-n>'] = { c = cmp.mapping.select_next_item() },
        ['<C-p>'] = { c = cmp.mapping.select_prev_item() },
        ['<C-e>'] = { c = cmp.mapping.abort() },
        ['<C-y>'] = {
          c = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          }),
        },
      }

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(keymaps),
        sources = {
          { name = 'buffer' },
        },
      })

      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(keymaps),
      --   sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
      -- })
    end,
  },
}
