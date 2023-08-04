return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-plenary',
      'nvim-neotest/neotest-vim-test',
      'olimorris/neotest-phpunit',
    },
    enabled = false,
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        adapters = {
          require("neotest-go"),
          require("neotest-plenary"),
          require("neotest-vim-test")({
            ignore_file_types = { "python", "vim", "lua" },
          }),
        },
      })
    end,
  }
}
