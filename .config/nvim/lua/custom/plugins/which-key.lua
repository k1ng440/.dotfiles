return {
    {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ['<leader>c'] = { name = '+code' },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>r"] = { name = "+rename/replace" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>h"] = { name = "+harpoon" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
       wk.register(opts.defaults)
    end,
  },
}
