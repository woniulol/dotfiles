local fzf = require("fzf-lua")
local map = vim.keymap.set

fzf.setup({
    ui_select = true
})

map("n", "<leader>of", fzf.files, { desc = "FZF Files" })
map("n", "<leader>lg", fzf.live_grep, { desc = "FZF Live Grep" })
map("n", "<leader>fb", fzf.buffers, { desc = "FZF Buffers" })
map("n", "<leader>fh", fzf.help_tags, { desc = "FZF Help Tags" })
map("n", "<leader>fq", fzf.diagnostics_document, { desc = "FZF Diagnostics Document" })
map("n", "<leader>fQ", fzf.diagnostics_workspace, { desc = "FZF Diagnostics Workspace" })
map("n", "<leader>cs", function()
    fzf.spell_suggest({ winopts = { height=0.33, width=0.33, relative="cursor" } })
end , { desc = "Fuzzy spell suggestions" })



