local Util = require('k1ng.util')
return {
    {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
            keys = {
            { '<leader>,', '<cmd>Telescope buffers show_all_buffers=true<cr>', desc = 'Switch Buffer' },
            { '<leader>/', Util.telescope('live_grep'), desc = 'Grep (root dir)' },
            { '<leader>:', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
            -- find
            { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = '[F]ile [B]uffers' },
            { '<leader>ff', Util.telescope('files'), desc = '[F]ind [F]iles (root dir)' },
            { '<leader>fF', Util.telescope('files', { cwd = false }), desc = '[F]ind [F]iles (cwd)' },
            { '<leader>sf', Util.telescope('files'), desc = '[F]ind Files (root dir)' },
            { '<leader>sF', Util.telescope('files', { cwd = false }), desc = 'Find Files (cwd)' },
            { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = '[R]ecent' },
            { '<leader>fR', Util.telescope('oldfiles', { cwd = vim.loop.cwd() }), desc = '[R]ecent (cwd)' },
            -- git
            { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = '[G]it [C]ommits' },
            { '<leader>gs', '<cmd>Telescope git_status<CR>', desc = '[G]it [S]tatus' },
            -- search
            { '<leader>sa', '<cmd>Telescope autocommands<cr>', desc = 'Auto Commands' },
            { '<leader>sb', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Buffer' },
            { '<leader>sc', '<cmd>Telescope command_history<cr>', desc = 'Command History' },
            { '<leader>sC', '<cmd>Telescope commands<cr>', desc = 'Commands' },
            { '<leader>sd', '<cmd>Telescope diagnostics bufnr=0<cr>', desc = 'Document diagnostics' },
            { '<leader>sD', '<cmd>Telescope diagnostics<cr>', desc = 'Workspace diagnostics' },
            { '<leader>sg', Util.telescope('live_grep'), desc = 'Grep (root dir)' },
            { '<leader>sG', Util.telescope('live_grep', { cwd = false }), desc = 'Grep (cwd)' },
            { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Help Pages' },
            { '<leader>sH', '<cmd>Telescope highlights<cr>', desc = 'Search Highlight Groups' },
            { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Key Maps' },
            { '<leader>sM', '<cmd>Telescope man_pages<cr>', desc = 'Man Pages' },
            { '<leader>sm', '<cmd>Telescope marks<cr>', desc = 'Jump to Mark' },
            { '<leader>so', '<cmd>Telescope vim_options<cr>', desc = 'Options' },
            { '<leader>sR', '<cmd>Telescope resume<cr>', desc = 'Resume' },
            { '<leader>sw', Util.telescope('grep_string'), desc = 'Word (root dir)' },
            { '<leader>sW', Util.telescope('grep_string', { cwd = false }), desc = 'Word (cwd)' },
            { '<leader>uC', Util.telescope('colorscheme', { enable_preview = true }), desc = 'Colorscheme with preview' },
            {
                '<leader>ss',
                Util.telescope('lsp_document_symbols', {
                    symbols = {
                        'Class',
                        'Function',
                        'Method',
                        'Constructor',
                        'Interface',
                        'Module',
                        'Struct',
                        'Trait',
                        'Field',
                        'Property',
                    },
                }),
                desc = 'Goto Symbol',
            },
            {
                '<leader>sS',
                Util.telescope('lsp_dynamic_workspace_symbols', {
                    symbols = {
                        'Class',
                        'Function',
                        'Method',
                        'Constructor',
                        'Interface',
                        'Module',
                        'Struct',
                        'Trait',
                        'Field',
                        'Property',
                    },
                }),
                desc = 'Goto Symbol (Workspace)',
            },
        },
        opts = function()
            return require('k1ng.plugin-configs.telescope-config')
        end,
        config = function(_, opts)
            local telescope = require('telescope')
            telescope.setup(opts)
            for _, ext in ipairs(opts.extensions_list) do
                telescope.load_extension(ext)
            end
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        event = 'VeryLazy',
        build = 'make',
        cond = function()
            return vim.fn.executable 'make' == 1
        end,
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        config = function (_, opts)
            require('telescope._extensions.file_browser').setup(opts)
            require('telescope').load_extension('file_browser')
        end
    },
    {
        'debugloop/telescope-undo.nvim',
        event = 'VeryLazy',
        config = function()
            require('telescope').load_extension('undo')
        end,
    },
    'nvim-telescope/telescope-hop.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    {
        'ThePrimeagen/git-worktree.nvim',
        event = 'VeryLazy',
        config = function()
            require('git-worktree').setup {}
        end,
    },
    {
        'AckslD/nvim-neoclip.lua',
        event = 'VeryLazy',
        config = function()
            require('neoclip').setup()
        end,
    },
    {
        'nvim-telescope/telescope-live-grep-args.nvim',
        event = 'VeryLazy',
        dependencies = { 'nvim-telescope/telescope.nvim' },
       keys = {
            {'<leader>rg', function () require("telescope").extensions.live_grep_args.live_grep_args() end, desc = 'Grep (root dir)'},
        },
        config = function()
            require('telescope').load_extension('live_grep_args')
        end,
    }
    -- {
    --     'sopa0/telescope-makefile',
    --     dependencies = { 'nvim-telescope/telescope.nvim' },
    --     config = function()
    --         require('telescope').load_extension('make')
    --     end,
    -- },
    -- {
    -- 'GustavoKatel/telescope-asynctasks.nvim',
    --     dependencies = {
    --         'nvim-telescope/telescope.nvim',
    --         'skywind3000/asynctasks.vim',
    --         'skywind3000/asyncrun.vim',
    --     },
    -- }
}