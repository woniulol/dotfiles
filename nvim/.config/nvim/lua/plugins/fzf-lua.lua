-- lazy: fzf-lua is loaded on first keypress, not at startup
local map = vim.keymap.set

local grep_rg_opts = table.concat({
	"--column",
	"--line-number",
	"--no-heading",
	"--color=always",
	"--smart-case",
	"--hidden",
	"--max-columns=4096",
	"-e",
}, " ")

local loaded = false
local function fzf()
	local f = require("fzf-lua")
	if not loaded then
		f.setup({ ui_select = true, fzf_colors = true })
		loaded = true
	end
	return f
end

map("n", "<leader>of", function()
	fzf().files()
end, { desc = "FZF Files" })

map("n", "<leader>oc", function()
	fzf().files({ cwd = vim.fn.stdpath("config") })
end, { desc = "FZF Files" })

map("n", "<leader>lg", function()
	fzf().live_grep({ rg_opts = grep_rg_opts })
end, { desc = "FZF Live Grep" })

map("n", "<leader>lw", function()
	fzf().grep_cword({ rg_opts = grep_rg_opts })
end, { desc = "FZF Grep Word" })

map("n", "<leader>fb", function()
	fzf().buffers({
		fzf_opts = {
			["--header-lines"] = false,
		},
	})
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
