return {
    -- Setup status bar.
    {
        'nvim-lualine/lualine.nvim',
        event = { "BufNewFile", "BufReadPost" },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({

                icons_enabled = true,
                options = {
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                    theme = "catppuccin"
                }

            })
        end
    }
}
