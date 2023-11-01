return {
  'stevearc/dressing.nvim',
  opts = {},
  event = 'BufReadPost',
  config = function(_, opts)
    vim.schedule(function()
      require('dressing').setup({
        select = {
          get_config = function(_opts)
            if _opts.kind == 'codeaction' then
              return {
                backend = 'nui',
                nui = {
                  relative = 'cursor',
                  max_width = 40,
                },
              }
            end
          end,
        },
      })
    end)
  end,
}
