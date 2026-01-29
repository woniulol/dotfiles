vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Aviod ':' to trigger a indent in python file",
    pattern = "python",
    command = "setlocal indentkeys-=<:>",
})
vim.api.nvim_create_autocmd("FileType", {
    desc = "Aviod ':' to trigger a indent in python file",
    pattern = "python",
    command = "setlocal indentkeys-=<:>",
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.o.spell = false -- Disable spell checking when terminal is open.
    end,
})
