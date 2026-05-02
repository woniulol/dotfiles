local loaded = false
local function diffview()
	local f = require("diffview")
	if not loaded then
		f.setup({ use_icons = false, enhanced_diff_hl = true })
		loaded = true
	end
	return f
end

local map = vim.keymap.set

map("n", "<leader>dvo", function()
	diffview().open()
end, { desc = "Diffview Open" })

map("n", "<leader>dvc", function()
	diffview().close()
end, { desc = "Diffview Close" })
