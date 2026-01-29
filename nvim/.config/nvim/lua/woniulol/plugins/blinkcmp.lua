return {
    {
        'saghen/blink.cmp',

        event = "VeryLazy",

        -- optional: provides snippets for the snippet source
        -- dependencies = { 'rafamadriz/friendly-snippets', "xzbdmw/colorful-menu.nvim" },
        dependencies = { "xzbdmw/colorful-menu.nvim" },

        -- use a release tag to download pre-built binaries
        version = '1.*',
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = {
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                -- Adjusts spacing to ensure icons are aligned
                nerd_font_variant = 'mono'
            },

            completion = {
                documentation = {
                    auto_show = true,
                    window = {
                        border = 'single',
                        max_height = 50,
                    },
                    auto_show_delay_ms = 0,
                },
                keyword = { range = 'full' },
                accept = { auto_brackets = { enabled = false }, },
                ghost_text = { enabled = true },
                menu = {
                    -- min_width = 20,
                    -- max_height = 50,
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    border = "single",
                    draw = {
                        columns = {
                            { "label",     "label_description", gap = 1 },
                            { "kind_icon", "kind",              gap = 1 },
                        },
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },

            cmdline = {
                keymap = { preset = 'inherit' },
                completion = { menu = { auto_show = true } },
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', 'codeium' },
                providers = {
                    snippets = { score_offset = 500 },
                    codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
                },
            },

            fuzzy = { implementation = "rust" },

            signature = { enabled = true, window = { border = 'single' }, }
        },
        opts_extend = { "sources.default" }
    },
}
