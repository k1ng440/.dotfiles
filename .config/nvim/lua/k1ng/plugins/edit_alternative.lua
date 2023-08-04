return {
  { "tjdevries/standard.vim", lazy = false, priority = 100 },
  { "tjdevries/conf.vim",     lazy = false, priority = 90 },
  {
    "tjdevries/edit_alternate.vim",
    config = function()
      -- Add special alternates for golang
      -- Finds the alternate test
      vim.fn["edit_alternate#rule#add"]("go", function(filename)
        if filename:find "_test.go" then
          return (filename:gsub("_test%.go", ".go"))
        else
          return (filename:gsub("%.go", "_test.go"))
        end
      end)

      vim.keymap.set("n", "<leader>ea", "<cmd>EditAlternate<CR>", { silent = true, desc = "[E]dit [A]lternate File" })
    end,
    priority = 80,
  },
}
