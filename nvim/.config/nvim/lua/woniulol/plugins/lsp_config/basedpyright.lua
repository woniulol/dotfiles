vim.lsp.config('basedpyright', {
    settings =   {
        basedpyright = {
            analysis = {
                ignore = { "*" },  -- Only use pure lsp capabilities. Prefer `ty` for type checking.
            }
        }
    }
})
