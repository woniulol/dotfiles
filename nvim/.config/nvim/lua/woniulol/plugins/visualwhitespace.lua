return {
    {
        'mcauley-penney/visual-whitespace.nvim',
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.keymap.set({ 'n', 'v' }, "<leader>tw", require("visual-whitespace").toggle, {})
        end
    },
}
