require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'go', 'gosum', 'gomod', 'gowork', 'jq', 'javascript', 'jsdoc', 'make',
    'passwd', 'php', 'proto', 'sql', 'svelte', 'todotxt', 'yaml', 'toml', 'lua', 'python', 'rust',
    'tsx', 'typescript', 'vimdoc', 'vim', 'markdown', 'markdown_inline', 'regex', 'bash', "jsonc",

  },
  auto_install = true,
  highlight = { enable = true },
  indent = {
    enable = false,
    disable = { 'python', 'yaml' },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
