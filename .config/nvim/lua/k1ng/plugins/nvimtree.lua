return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    actions = {
      open_file = {
        resize_window = true,
        quit_on_open = true,
      },
    },
    view = {
      width = 30,
    },
    filters = {
      dotfiles = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    renderer = {
      group_empty = true,
      root_folder_label = false,
      highlight_git = true,
      highlight_opened_files = "none",
      indent_markers = {
        enable = true,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
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
  },
  config = function(_, opts)
    require('nvim-tree').setup(opts)
    vim.g.nvimtree_side = opts.view.side
  end,
}
