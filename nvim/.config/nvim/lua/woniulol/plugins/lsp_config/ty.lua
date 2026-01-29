vim.lsp.config('ty', {
    settings = {
        ty = {
            disableLanguageServices = true, -- Use `ty` solely for type checking.
        },
    },
})
