return {
    {
        -- Collection of various small independent plugins/modules
        'echasnovski/mini.nvim',
        event = "VeryLazy",
        config = function()
            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            require('mini.surround').setup({
                mappings = {
                    add = '<leader>sa',
                    delete = '<leader>sd',
                    replace = '<leader>sr',
                },
                n_lines = 100,
            })

            -- Easy comment/uncomment code lines/block.
            require('mini.comment').setup({
                options = {
                    -- Whether to ignore blank lines when commenting
                    ignore_blank_line = true,
                }
            })

            -- Auto pairing.
            -- Replaced by nvim-autopairs
            -- require("mini.pairs").setup({})

            -- Trailing spaces
            -- Handled by LSP format operation
            -- require('mini.trailspace').setup()
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     pattern = "*",
            --     callback = function()
            --         require("mini.trailspace").trim()
            --     end,
            -- })

            require("mini.splitjoin").setup({
                mappings = { toggle = "" }
            })

            vim.keymap.set({ "n", "x" }, "sj", function() require("mini.splitjoin").join() end,
                { desc = "Join arguments" })
            vim.keymap.set({ "n", "x" }, "sk", function() require("mini.splitjoin").split() end,
                { desc = "Split arguments" })
        end,
    },
}
