local options = {
  filters = {
    dotfiles = false,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
  },
  git = {
    enable = true,
    ignore = true,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
      quit_on_open = true,
    },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = false,
    highlight_opened_files = "none",
    indent_markers = {
      enable = false,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },

      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}


return {
  "nvim-tree/nvim-tree.lua",
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeFindFileToggle" },
  opts = options,
  init = function()
    --  TODO: Add Keybinds
  end,
  config = function(_, opts)
    require("nvim-tree").setup(vim.tbl_extend("force", options, opts))
    vim.g.nvimtree_side = opts.view.side
    -- auto close
    local function is_modified_buffer_open(buffers)
      for _, v in pairs(buffers) do
        if v.name:match("NvimTree_") == nil then
          return true
        end
      end
      return false
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if
            #vim.api.nvim_list_wins() == 1
            and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
            and is_modified_buffer_open(vim.fn.getbufinfo({ bufmodified = 1 })) == false
        then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
