return {
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            transparent_background = true,
            float = {
                transparent = true, -- enable transparent floating windows
                -- solid = true,        -- use solid styling for floating windows, see |winborder|
            },
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            lsp_styles = {
                underlines = {
                    errors = { "undercurl" },
                    hints = { "undercurl" },
                    warnings = { "undercurl" },
                    information = { "undercurl" },
                },
            },
            integrations = {
                aerial = true,
                alpha = true,
                cmp = true,
                dashboard = true,
                flash = true,
                fzf = true,
                grug_far = true,
                gitsigns = true,
                headlines = true,
                illuminate = true,
                indent_blankline = { enabled = true, colored_indent_levels = true, },
                leap = true,
                lsp_trouble = true,
                mason = true,
                mini = true,
                navic = { enabled = true, custom_bg = "lualine" },
                neotest = true,
                neotree = true,
                noice = true,
                notify = true,
                snacks = true,
                telescope = true,
                treesitter_context = true,
                which_key = true,
                blink_cmp = true,
            },
            -- auto_integrations = true,
            color_overrides = {
                all = {},
            },
            highlight_overrides = {
                all = function(colors)
                    return {
                        Visual = { bg = colors.surface1, style = {} },
                        -- LspReferenceText = { bg = "#c2dffe", fg = colors.base },
                        -- LspReferenceRead  = { bg = "#c2dffe", fg = colors.base },
                        -- LspReferenceWrite = { bg = "#c2dffe", fg = colors.base },
                        CursorLine = { bg = colors.surface1 },
                        Search = { bg = "#86c5d2", fg = "#1e2030", style = {} },
                        FloatBorder = { fg = colors.blue },
                    }
                end,
            },
        },
        specs = {
            {
                "akinsho/bufferline.nvim",
                optional = true,
                opts = function(_, opts)
                    if (vim.g.colors_name or ""):find("catppuccin") then
                        opts.highlights = require("catppuccin.special.bufferline").get_theme()
                    end
                end,
            },
        },
    }
}
