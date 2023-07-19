return {
  "ThePrimeagen/harpoon",
  keys = {
    -- Harpoon marked files 1 through 4.
    { '<a-1>',      function() require('harpoon.ui').nav_file(1) end,         desc = 'Harpoon marked file 1' },
    { '<a-2>',      function() require('harpoon.ui').nav_file(2) end,         desc = 'Harpoon marked file 2' },
    { '<a-3>',      function() require('harpoon.ui').nav_file(3) end,         desc = 'Harpoon marked file 3' },
    { '<a-4>',      function() require('harpoon.ui').nav_file(4) end,         desc = 'Harpoon marked file 4' },

    -- Harpoon next and previous.
    { '<a-5>',      function() require('harpoon.ui').nav_next() end,          desc = 'Harpoon next' },
    { '<a-6>',      function() require('harpoon.ui').nav_prev() end,          desc = 'Harpoon previous' },

    -- Harpoon user interface
    { '<a-7>',      function() require('harpoon.ui').toggle_quick_menu() end, desc = 'Harpoon user interface' },
    { "<a-8>",      function() require("harpoon.mark").add_file() end,        desc = "Harpoon add file" },
    { "<leader>hs", function() require('harpoon.ui').toggle_quick_menu() end, desc = "Harpoon user interface" },
    { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "Harpoon add file" },
  },
  opts = {},
}
