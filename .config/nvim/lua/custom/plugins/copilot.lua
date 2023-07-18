return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          accept = false,
          keymap = {
            accept = "<M-p>",
            cancel = "<M-c>",
            next = "<M-n>",
            prev = "<M-p>",
          },
        },
        on_status_update = require('lualine').refresh
      })

      -- hide copilot suggestions when cmp menu is open
      -- to prevent odd behavior/garbled up suggestions
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("menu_opened", function()
          vim.b.copilot_suggestion_hidden = true
        end)
        cmp.event:on("menu_closed", function()
          vim.b.copilot_suggestion_hidden = false
        end)
      end
    end,
  },
  {
    'jonahgoldwastaken/copilot-status.nvim',
    lazy = true,
    dependencies = { 'zbirenbaum/copilot.lua' },
    config = function()
      vim.notify('copilit-status.nvim loaded')
    end,
    event = "BufReadPost",
  },
}
