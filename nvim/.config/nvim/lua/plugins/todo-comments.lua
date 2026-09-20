vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		require("todo-comments").setup({})
	end,
})

vim.keymap.set("n", "<leader>tdt", "<cmd>TodoFzfLua<CR>TODO", { desc = "Todo: Fzflua" })
vim.keymap.set("n", "<leader>tdf", "<cmd>TodoFzfLua<CR>FIX", { desc = "Fix: Fzflua" })
vim.keymap.set("n", "<leader>tdw", "<cmd>TodoFzfLua<CR>WARNING", { desc = "Warning: Fzflua" })
