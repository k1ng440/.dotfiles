return {
  "ThePrimeagen/harpoon",
  keys = {
    -- Harpoon marked files 1 through 4.
    { '<a-1>',      function() require('harpoon.ui').nav_file(1) end,         desc = 'Harpoon marked file 1' },
    { '<a-2>',      function() require('harpoon.ui').nav_file(2) end,         desc = 'Harpoon marked file 2' },
    { '<a-3>',      function() require('harpoon.ui').nav_file(3) end,         desc = 'Harpoon marked file 3' },
    { '<a-4>',      function() require('harpoon.ui').nav_file(4) end,         desc = 'Harpoon marked file 4' },

    { '<leader>hj',      function() require('harpoon.ui').nav_file(1) end,         desc = 'Harpoon marked file 1' },
    { '<leader>hk',      function() require('harpoon.ui').nav_file(2) end,         desc = 'Harpoon marked file 2' },
    { '<leader>hl',      function() require('harpoon.ui').nav_file(3) end,         desc = 'Harpoon marked file 3' },
    { '<leader>h;',      function() require('harpoon.ui').nav_file(4) end,         desc = 'Harpoon marked file 4' },

    -- Harpoon next and previous.
    { '<a-5>',      function() require('harpoon.ui').nav_next() end,          desc = 'Harpoon next' },
    { '<a-6>',      function() require('harpoon.ui').nav_prev() end,          desc = 'Harpoon previous' },
    { '<leader>hn', function() require('harpoon.ui').nav_next() end,          desc = '[H]arpoon [N]ext' },
    { '<leader>hp', function() require('harpoon.ui').nav_prev() end,          desc = '[H]arpoon [P]revious' },

    -- Harpoon user interface
    { '<a-7>',      function() require('harpoon.ui').toggle_quick_menu() end, desc = 'Harpoon user interface' },
    { "<a-8>",      function() require("harpoon.mark").add_file() end,        desc = "Harpoon add file" },
    { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "[H]arpoon [A]dd file" },
    { "<leader>ht", function() require('harpoon.ui').toggle_quick_menu() end, desc = "[H]arpoon [T]oggle quick menu" },
    { "<leader>ha", function() require("harpoon.mark").add_file() end,        desc = "[H]arpoon [A]dd file" },
  },
  opts = {},
}
