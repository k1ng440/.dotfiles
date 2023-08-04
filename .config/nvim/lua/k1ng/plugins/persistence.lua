return {
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
      pre_save = nil,                                               -- a function to call before saving the session
    }
  },
}
