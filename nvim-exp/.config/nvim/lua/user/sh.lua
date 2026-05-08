local M = {}

function M.open(pos, size)
	pos = pos or "J"
	size = size or 8
	local horizontal = pos == "J" or pos == "K"
	local vertical = pos == "H" or pos == "L"
	assert(horizontal or vertical, "sh: pos must be 'H', 'J', 'K', or 'L', got " .. tostring(pos))
	vim.cmd.vnew()
	vim.cmd.term()
	vim.cmd.wincmd(pos)
	if horizontal then
		vim.api.nvim_win_set_height(0, size)
	else
		vim.api.nvim_win_set_width(0, size)
	end
	return vim.bo.channel
end

function M.run_selection()
	vim.cmd('noautocmd normal! "vy')
	local chan = M.open()
	vim.fn.chansend(chan, (vim.fn.getreg("v"):gsub("\n+$", "")) .. "\n")
	vim.cmd.startinsert()
end

return M
