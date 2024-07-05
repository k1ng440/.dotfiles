local keys = {
  { "<leader>h",  "",                                                                                desc = "+harpoon" },
  { "<leader>ha", function() require("harpoon"):list():add() end,                                    desc = "Add current file to Harpoon list" },
  { "<leader>hl", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Toggle Harpoon menu" },
}
for i = 1, 5, 1 do
  table.insert(keys,
    { "<leader>h" .. i, function() require("harpoon"):list():select(i) end, desc = "Switch to file " .. i }
  )
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = "nvim-lua/plenary.nvim",
  keys = keys,
  config = function() require("harpoon"):setup() end,
}
