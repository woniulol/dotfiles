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

-- Render spell errors with a flat underline instead of undercurl (which
-- some terminals draw as a row of `~`). Re-applied on ColorScheme so a
-- theme load doesn't clobber it.
local function _flat_spell_hl()
	for _, group in ipairs({ "SpellBad", "SpellCap", "SpellRare", "SpellLocal" }) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		hl.undercurl = false
		hl.underline = true
		vim.api.nvim_set_hl(0, group, hl)
	end
end
_flat_spell_hl()
vim.api.nvim_create_autocmd("ColorScheme", { callback = _flat_spell_hl })

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
