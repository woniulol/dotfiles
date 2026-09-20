local autocmd = vim.api.nvim_create_autocmd
local general = vim.api.nvim_create_augroup("LocalGeneral", { clear = true })

autocmd("TextYankPost", {
	desc = "highlight when yanking text",
	group = general,
	callback = function()
		vim.hl.on_yank()
	end,
})

autocmd("TermOpen", {
	desc = "disable spell checking in terminal",
	group = general,
	callback = function()
		vim.o.spell = false
	end,
})

autocmd("BufReadPost", {
	desc = "go back to where you left",
	group = general,
	callback = function()
		if vim.o.diff then
			return
		end
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line_count = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
