-- require("nekomi").setup({
-- 	colors = {
-- 		crust = "#1e1e2e",
-- 		mantle = "#262637",
-- 	},
-- 	highlights = function(self)
-- 		local cursor = { fg = self.colors.base, bg = "#fec270" }
-- 		return {
-- 			Cursor = cursor,
-- 			lCursor = cursor,
-- 			CursorIM = cursor,
-- 			TermCursor = cursor,
--
-- 			-- docstrings are prose, not data, so they read as comments. only
-- 			-- languages where docs are string literals need this; rust /// is
-- 			-- already @comment.documentation.
-- 			["@string.documentation"] = { fg = self.colors.overlay2 },
--
-- 			-- nekomi draws the separator in base, which is now the ground
-- 			WinSeparator = { fg = self.colors.surface0 },
-- 		}
-- 	end,
-- })
-- vim.cmd.colorscheme("nekomi")
require("catppuccin").setup({
	flavour = "mocha",
	color_overrides = {
		mocha = { text = "#e6efff" },
	},
	-- no bg so ghostty's background-opacity shows through; winborder keeps floats readable
	transparent_background = true,
	float = { transparent = true },
	custom_highlights = function(C)
		return {
			-- Keep relative line numbers readable and emphasize the current line.
			LineNr = { fg = C.subtext1 },
			LineNrAbove = { fg = C.subtext1 },
			LineNrBelow = { fg = C.subtext1 },
			CursorLineNr = { fg = C.peach, style = { "bold" } },
			-- default is peach text on a bg close to CursorLine, too easy to miss
			-- Blue distinguishes the matching bracket from the terminal's peach cursor.
			MatchParen = { fg = C.base, bg = C.blue, style = { "bold" } },
		}
	end,
})
vim.cmd.colorscheme("catppuccin-nvim")
