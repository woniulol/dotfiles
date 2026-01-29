return {
    -- Check https://github.com/Exafunction/windsurf.nvim for authentication.
    {
        "Exafunction/windsurf.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({})
        end
    },
}
