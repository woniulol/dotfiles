-- transparent bg
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiffAdd", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiffChange", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiffDelete", { bg = "none" })
		vim.api.nvim_set_hl(0, "DiffText", { bg = "none", bold = true })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	end,
})

vim.cmd.colorscheme("default")
-- vim.cmd.colorscheme("nord")
-- vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("vague")

-- require("catppuccin").setup({
-- 	transparent_background = true,
-- 	float = { transparent = true },
-- })
-- vim.cmd.colorscheme("catppuccin-macchiato")

-- vim.opt.termguicolors = true
-- set background=light " or dark
-- vim.opt.background = "dark"
-- vim.cmd.colorscheme("nordbones")
