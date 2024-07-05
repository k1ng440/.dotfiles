return {
  {
    'zbirenbaum/copilot.lua',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    build = ':Copilot auth',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      panel = { enabled = false },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = false,
          accept_word = '<M-w>',
          accept_line = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-/>',
        },
      },
      filetypes = {},
    },
    config = function(_, opts)
      local copilot = require('copilot.suggestion')
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      opts = opts or {}
      local project_root = vim.g.project_root
      if project_root then
        opts.server_opts_overrides = {
          root_dir = project_root,
        }
      end
      require('copilot').setup(opts)

      local function set_trigger(trigger)
        vim.b.copilot_suggestion_auto_trigger = trigger
        vim.b.copilot_suggestion_hidden = not trigger
      end

      -- Hide suggestions when the completion menu is open.
      cmp.event:on('menu_opened', function()
        if copilot.is_visible() then
          copilot.dismiss()
        end
        set_trigger(false)
      end)

      -- Disable suggestions when inside a snippet.
      cmp.event:on('menu_closed', function()
        set_trigger(not luasnip.expand_or_locally_jumpable())
      end)

      -- Disable suggestions when inside a snippet.
      vim.api.nvim_create_autocmd('User', {
        pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
        callback = function()
          set_trigger(not luasnip.expand_or_locally_jumpable())
        end,
      })
    end,
  },
}
