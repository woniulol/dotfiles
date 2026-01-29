return {
    -- Highlight todo, notes, etc in comments
    {
        'folke/todo-comments.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = true },
        keys = {
            { "<leader>tdt", "<cmd>TodoTelescope<CR>TODO",    desc = "Todo: Telescope" },
            { "<leader>tdf", "<cmd>TodoTelescope<CR>FIX",     desc = "Fix: Telescope" },
            { "<leader>tdw", "<cmd>TodoTelescope<CR>WARNING", desc = "Warning: Telescope" },
        },
    },
}
