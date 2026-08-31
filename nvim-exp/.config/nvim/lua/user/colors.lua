require("nekomi").setup({
	colors = {
		crust = "#1e1e2e",
		mantle = "#262637",
	},
	highlights = function(self)
		local cursor = { fg = self.colors.base, bg = "#fec270" }
		return {
			Cursor = cursor,
			lCursor = cursor,
			CursorIM = cursor,
			TermCursor = cursor,

			-- docstrings are prose, not data, so they read as comments. only
			-- languages where docs are string literals need this; rust /// is
			-- already @comment.documentation.
			["@string.documentation"] = { fg = self.colors.overlay2 },

			-- nekomi draws the separator in base, which is now the ground
			WinSeparator = { fg = self.colors.surface0 },
		}
	end,
})
vim.cmd.colorscheme("nekomi")
