-- lazy: fzf-lua is loaded on first keypress, not at startup
local map = vim.keymap.set

local loaded = false
local function fzf()
	local f = require("fzf-lua")
	if not loaded then
		f.setup({ ui_select = true })
		loaded = true
	end
	return f
end

map("n", "<leader>of", function()
	fzf().files()
end, { desc = "FZF Files" })

map("n", "<leader>lg", function()
	fzf().live_grep()
end, { desc = "FZF Live Grep" })

map("n", "<leader>fb", function()
	fzf().buffers()
end, { desc = "FZF Buffers" })

map("n", "<leader>fh", function()
	fzf().help_tags()
end, { desc = "FZF Help Tags" })

map("n", "<leader>fd", function()
	fzf().diagnostics_document({ diag_source = true })
end, { desc = "FZF Diagnostics Document" })

map("n", "<leader>fD", function()
	fzf().diagnostics_workspace({ diag_source = true })
end, { desc = "FZF Diagnostics Workspace" })

map("n", "<leader>cs", function()
	fzf().spell_suggest({ winopts = { height = 0.33, width = 0.33, relative = "cursor" } })
end, { desc = "Fuzzy spell suggestions" })
