-- lazy: nvim-tree is loaded on first toggle
vim.keymap.set("n", "<leader>e", function()
	require("nvim-tree").setup({})
	vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "NvimTree: Toggle" })
	vim.cmd("NvimTreeToggle")
end, { desc = "NvimTree: Toggle" })
