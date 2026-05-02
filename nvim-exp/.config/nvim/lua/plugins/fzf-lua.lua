local fzf = require("fzf-lua")
local map = vim.keymap.set

fzf.setup({})

map("n", "<leader>of", fzf.files, { desc = "FZF Files" })
map("n", "<leader>lg", fzf.live_grep, { desc = "FZF Live Grep" })
map("n", "<leader>fb", fzf.buffers, { desc = "FZF Buffers" })
map("n", "<leader>fh", fzf.help_tags, { desc = "FZF Help Tags" })
map("n", "<leader>q", fzf.diagnostics_document, { desc = "FZF Diagnostics Document" })
map("n", "<leader>Q", fzf.diagnostics_workspace, { desc = "FZF Diagnostics Workspace" })
map("n", "<leader>cs", fzf.spell_suggest, { desc = "Fuzzy spell suggestions" })



