return {
  "ThePrimeagen/harpoon",
  keys = { "<a-1>", "<a-2>", "<a-3>", "<a-4>", "<a-5>", "<a-6>", "<a-7>", "<a-8>", "<leader>hs", "<leader>ha" },
  config = function(_, opts)
    require("harpoon").setup(opts)
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    -- Harpoon marked files 1 through 4.
    vim.keymap.set("n", "<a-1>", function() ui.nav_file(1) end, { desc = "Harpoon marked file 1" })
    vim.keymap.set("n", "<a-2>", function() ui.nav_file(2) end, { desc = "Harpoon marked file 2" })
    vim.keymap.set("n", "<a-3>", function() ui.nav_file(3) end, { desc = "Harpoon marked file 3" })
    vim.keymap.set("n", "<a-4>", function() ui.nav_file(4) end, { desc = "Harpoon marked file 4" })

    -- Harpoon next and previous.
    vim.keymap.set("n", "<a-5>", function() ui.nav_next() end, { desc = "Harpoon next" })
    vim.keymap.set("n", "<a-6>", function() ui.nav_prev() end, { desc = "Harpoon previous" })

    -- Harpoon user interface.
    vim.keymap.set("n", "<a-7>", ui.toggle_quick_menu, { desc = "Harpoon user interface" })
    vim.keymap.set("n", "<a-8>", mark.add_file, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>hs", ui.toggle_quick_menu, { desc = "Harpoon user interface" })
    vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon add file" })
  end,
}
