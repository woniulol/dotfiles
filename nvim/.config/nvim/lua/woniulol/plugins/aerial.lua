return {
    {
        "stevearc/aerial.nvim",
        config = function()
            require("aerial").setup({
                backends = { "lsp", "treesitter" },
                filter_kind = false,
                layout = {
                    resize_to_content = false,
                    min_width = 0.15,
                    width = 0.15,
                    placement = "edge",
                    default_direction = "prefer_right",
                },
                show_guides = true,
                guide_chars = "│ ─├─└",
                autojump = true,
            })
            vim.keymap.set("n", "<leader>O", "<cmd>AerialToggle!<CR>")
        end,
        keys = { "<leader>O" },

    },
}
