-- transparent bg
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
-- 		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "none" })
--      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "none" })
--      vim.api.nvim_set_hl(0, "DiffChange", { bg = "none" })
--      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "none" })
--      vim.api.nvim_set_hl(0, "DiffText", { bg = "none", bold = true })
-- 		vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
-- 	end,
-- })

-- Render spell errors with a flat underline instead of undercurl (which
-- some terminals draw as a row of `~`). Re-applied on ColorScheme so a
-- theme load doesn't clobber it.
-- local function _flat_spell_hl()
-- 	for _, group in ipairs({ "SpellBad", "SpellCap", "SpellRare", "SpellLocal" }) do
-- 		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
-- 		hl.undercurl = false
-- 		hl.underline = true
-- 		-- cterm attrs live in a separate subtable; clear undercurl there too
-- 		hl.cterm = hl.cterm or {}
-- 		hl.cterm.undercurl = false
-- 		hl.cterm.underline = true
-- 		vim.api.nvim_set_hl(0, group, hl)
-- 	end
-- end
-- _flat_spell_hl()
-- vim.api.nvim_create_autocmd("ColorScheme", { callback = _flat_spell_hl })

-- local function _unbold_visual()
-- 	for _, group in ipairs({ "Visual", "VisualNOS" }) do
-- 		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
-- 		hl.bold = false
-- 		vim.api.nvim_set_hl(0, group, hl)
-- 	end
-- end
-- _unbold_visual()
-- vim.api.nvim_create_autocmd("ColorScheme", { callback = _unbold_visual })

-- vim.cmd.colorscheme("default")
--
-- require("mellifluous").setup({})
-- vim.cmd.colorscheme("mellifluous")

-- require("vague").setup({
-- 	transparent = true,
-- })
-- vim.cmd.colorscheme("vague")
-- vim.cmd.colorscheme("kanso-mist")

require("rose-pine").setup({
	variant = "moon", -- auto, main, moon, or dawn
	enable = {
		terminal = true,
		legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
		migrations = true, -- Handle deprecated options automatically
	},
	styles = {
		bold = true,
		italic = true,
		transparency = true,
	},
	palette = {
		-- Override the builtin palette per variant
		moon = {
			pine = "#6f9fd8",
		},
	},
	highlight_groups = {
		StatusLineTerm = { fg = "subtle", bg = "none" },
		StatusLineTermNC = { fg = "subtle", bg = "none" },
		-- Diagnostic virtual text in italic (inherits existing fg)
		DiagnosticVirtualTextError = { italic = true },
		DiagnosticVirtualTextWarn = { italic = true },
		DiagnosticVirtualTextInfo = { italic = true },
		DiagnosticVirtualTextHint = { italic = true },
		-- Comment = { fg = "foam" },
		-- StatusLine = { fg = "love", bg = "love", blend = 15 },
		-- VertSplit = { fg = "muted", bg = "muted" },
		-- Visual = { fg = "base", bg = "text", inherit = false },
	},
})
vim.cmd("colorscheme rose-pine")
-- vim.cmd.colorscheme("boring")
-- vim.cmd.colorscheme("Oshen")
-- vim.cmd.colorscheme("koda")
-- vim.cmd.colorscheme("lumon")
-- vim.cmd.colorscheme("nord")
-- vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("vague")

-- require("catppuccin").setup({
-- 	transparent_background = true,
-- 	float = { transparent = true },
-- 	styles = {
-- 		keywords = { "bold" },
-- 		conditionals = { "bold" },
-- 		loops = { "bold" },
-- 	},
-- 	color_overrides = {
-- 		frappe = {
--
-- 			-- errors (red — rarely seen in normal code, only in diagnostics)
-- 			red = "#ffc0b9",
-- 			maroon = "#ffc0b9",
--
-- 			-- strings (green — the one "data" accent)
-- 			green = "#b3f6c0",
--
-- 			-- keywords (magenta — the one "structure" accent)
-- 			mauve = "#ffcaff",
-- 			pink = "#ffcaff",
--
-- 			-- everything else → text white (blends in)
-- 			yellow = "#fce094",
-- 			peach = "#ffffff",
-- 			teal = "#ffffff",
-- 			sky = "#ffffff",
-- 			sapphire = "#ffffff",
-- 			blue = "#ffffff",
-- 			lavender = "#ffffff",
-- 			flamingo = "#ffffff",
-- 			rosewater = "#ffffff",
--
-- 			-- text + ui scale (brightened)
-- 			text = "#ffffff",
-- 			subtext1 = "#e8ebf5",
-- 			subtext0 = "#c8cce0",
-- 			overlay2 = "#9a9ebc",
-- 			overlay1 = "#838ba7",
-- 			overlay0 = "#6e6e88", -- ghostty bright black (8)
-- 			surface2 = "#5a5a78",
-- 			surface1 = "#454560", -- ghostty black (0)
-- 			surface0 = "#3a3f5c", -- ghostty selection-background
-- 			base = "#1e1e2e", -- ghostty background
-- 			mantle = "#181826",
-- 			crust = "#121220",
-- 		},
-- 	},
-- })
-- vim.cmd.colorscheme("catppuccin-frappe")

-- vim.opt.termguicolors = true
-- set background=light " or dark
-- vim.opt.background = "dark"
-- vim.cmd.colorscheme("nordbones")
-- vim.cmd.colorscheme("neobones")
