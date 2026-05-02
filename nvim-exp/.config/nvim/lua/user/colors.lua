-- transparent bg
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
    vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
  end,
})

vim.cmd.colorscheme("default")
-- vim.cmd.colorscheme("nord")
-- vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("vague")



