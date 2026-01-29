return {
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            vim.keymap.set(
                "n",
                "g=",
                "<cmd>lua require('illuminate').goto_next_reference(true)<cr>",
                { noremap = true, silent = true, desc = "Go to next reference" }
            )
            vim.keymap.set(
                "n",
                "g-",
                "<cmd>lua require('illuminate').goto_prev_reference(true)<cr>",
                { noremap = true, silent = true, desc = "Go to previous reference" }
            )
        end,
    },
}
