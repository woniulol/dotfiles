return {
    {
        "stevearc/conform.nvim",
        event = "VeryLazy",
        config = function()
            require("conform").setup({
                format_after_save = {
                    -- These options will be passed to conform.format()
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
                formatters_by_ft = {
                    markdown = { "prettierd" },
                },
            })
        end,
    },
}
