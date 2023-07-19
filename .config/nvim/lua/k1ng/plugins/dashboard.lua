return {
    {
        'glepnir/dashboard-nvim',
        dependencies = {
            'MaximilianLloyd/ascii.nvim'
        },
        event = 'VimEnter',
        config = function()
            local home = os.getenv('HOME')
            local config = {}
            config.header = require("ascii").get_random('misc', 'krakens')
            config.center = {
                {
                    icon = '  ',
                    desc = 'Projects                               ',
                    action = 'Telescope projects',
                    shortcut = 'SPC f h'
                },
                {
                    icon = '  ',
                    desc = 'Find File                              ',
                    action = 'Telescope find_files find_command=rg,--hidden,--files',
                    shortcut = 'SPC s f'
                },
                {
                    icon = '  ',

                    desc = 'File Browser                            ',
                    action = 'Telescope file_browser',
                    shortcut = 'SPC s f'
                },
                {
                    icon = '  ',
                    desc = 'Find Word                              ',
                    action = 'Telescope live_grep',
                    shortcut = 'SPC s w'
                },
                {
                    icon = '  ',
                    desc = 'Open Personal dotfiles                  ',
                    action = 'Telescope dotfiles path=' .. home .. '/.dotfiles',
                    shortcut = 'SPC f d'
                },
            }

            config.custom_footer = {
                [[                                          ]],
                [[                                          ]],
                [[                                          ]],
                [[                                          ]],
                [[                                          ]],
                [[🎉 Happy coding!]]
            }

            require('dashboard').setup({
                theme = 'doom',
                config = config
            })
        end
    }
}
