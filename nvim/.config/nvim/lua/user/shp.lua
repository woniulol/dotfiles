local M = {}
M._win = nil

function M.open()
	local args = vim.fn.argv(-1) --[[@as string[] ]]
	local cur = vim.fn.argidx() + 1

	local lines = {}
	for i, path in ipairs(args) do
		local marker = (i == cur) and ">" or " "
		lines[#lines + 1] = string.format("%s %d  %s", marker, i, vim.fn.fnamemodify(path, ":~:."))
	end

	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].bufhidden = "wipe"

	local width = 60
	for _, l in ipairs(lines) do
		width = math.max(width, #l + 3)
	end

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		row = math.floor((vim.o.lines - #lines) / 2) - 5,
		col = math.floor((vim.o.columns - width) / 2),
		width = width,
		height = #lines + 3,
		style = "minimal",
		title = " choose your buf ",
		title_pos = "center",
	})
	vim.api.nvim_win_set_cursor(win, { cur, 0 })
	vim.wo[win].cursorline = true
	M._win = win

	local function close()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
		M._win = nil
	end

	local function jump()
		local lnum = vim.api.nvim_win_get_cursor(win)[1]
		close()
		if lnum > 0 then
			vim.cmd("argument! " .. lnum)
		end
	end

	local function delete()
		local mode = vim.api.nvim_get_mode().mode
		local s, e
		if mode:match("^[vV\22]") then
			s, e = vim.fn.line("v"), vim.fn.line(".")
			if s > e then
				s, e = e, s
			end
			vim.cmd("normal! \27")
		else
			s = vim.api.nvim_win_get_cursor(win)[1]
			e = s
		end

		vim.cmd(string.format("%d,%dargdelete", s, e))
		close()

		-- a new window id
		M.open()
		local target = math.min(s, #vim.fn.argv(), 1)
		if target > 0 then
			vim.api.nvim_win_set_cursor(0, { target, 0 })
		end
	end

	-- buffer local keymap
	vim.keymap.set("n", "q", close, { buffer = buf, nowait = true })
	vim.keymap.set("n", "dd", delete, { buffer = buf, nowait = true })
	vim.keymap.set("n", "D", delete, { buffer = buf, nowait = true })
	vim.keymap.set({ "v", "x" }, "d", delete, { buffer = buf, nowait = true })
	vim.keymap.set("n", "<esc>", close, { buffer = buf, nowait = true })
	vim.keymap.set("n", "<cr>", jump, { buffer = buf, nowait = true })
end

function M.focus_or_open()
	if M._win and vim.api.nvim_win_is_valid(M._win) then
		vim.api.nvim_set_current_win(M._win)
	else
		M.open()
	end
end

return M
