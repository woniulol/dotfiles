return {
    {
        'MeanderingProgrammer/render-markdown.nvim',
        event = { "BufEnter *.md" },
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        opts = {
            sign = { enabled = false },
            code = {
                width = 'block',
                min_width = 80,
                border = 'thin',
                left_pad = 1,
                right_pad = 1,
                position = 'right',
                -- Avoid code block in header having different background.
                highlight_inline = 'RenderMarkdownCodeInfo',
            },
            checkbox = {
                unchecked = {
                    highlight = 'RenderMarkdownCodeFallback',
                    scope_highlight = 'RenderMarkdownCodeFallback',
                },
                checked = {
                    highlight = 'RenderMarkdownUnchecked',
                    scope_highlight = 'RenderMarkdownUnchecked',
                }
            },
            completions = {
                blink = { enabled = true },
                lsp = { enabled = true },
            },
        },
    },
}
