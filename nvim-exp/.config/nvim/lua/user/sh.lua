local M = {}

function M.open(pos, size)
	pos = pos or "J"
	size = size or 8
	local horizontal = pos == "J" or pos == "K"
	local vertical = pos == "H" or pos == "L"
	assert(horizontal or vertical, "sh: pos must be 'H', 'J', 'K', or 'L', got " .. tostring(pos))
	vim.cmd.vnew()
	vim.cmd.term()
	vim.g.user_sh_terminal_buf = vim.api.nvim_get_current_buf()
	vim.cmd.wincmd(pos)
	if horizontal then
		vim.api.nvim_win_set_height(0, size)
	else
		vim.api.nvim_win_set_width(0, size)
	end
	return vim.bo.channel
end

function M.toggle(pos, size)
	pos = pos or "J"
	size = size or 8
	local buf = vim.g.user_sh_terminal_buf
	if buf and vim.api.nvim_buf_is_valid(buf) then
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_buf(win) == buf then
				vim.api.nvim_win_close(win, true)
				return
			end
		end
		local horizontal = pos == "J" or pos == "K"
		vim.cmd("botright " .. (horizontal and "split" or "vsplit"))
		vim.api.nvim_set_current_buf(buf)
		vim.cmd.wincmd(pos)
		if horizontal then
			vim.api.nvim_win_set_height(0, size)
		else
			vim.api.nvim_win_set_width(0, size)
		end
		vim.cmd.startinsert()
		return
	end
	M.open(pos, size)
	vim.cmd.startinsert()
end

function M.run_selection()
	vim.cmd('noautocmd normal! "vy')
	local chan = M.open()
	vim.fn.chansend(chan, (vim.fn.getreg("v"):gsub("\n+$", "")) .. "\n")
	vim.cmd.startinsert()
end

return M
