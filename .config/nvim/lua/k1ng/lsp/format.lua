local Util = require('k1ng.util')

Util.on_attach(function(client, _)
  if client.name == 'gopls' then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("GoImport", { clear = true }),
      pattern = "*.go",
      callback = function()
        require("go.format").goimport()
        require("go.format").gofmt()
      end,
    })

    vim.api.nvim_create_user_command('Format', function ()
      require("go.format").goimport()
      require("go.format").gofmt()
    end, { desc = 'Format current buffer with LSP' })
  end -- gopls

  -- TODO: add null-ls formatting for other languages
end)
