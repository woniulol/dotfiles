vim.opt.laststatus = 3 -- ensure there is only one status bar with multiple split

local function update_git_branch()
	local ok, branch = pcall(vim.fn.system, "git branch --show-current 2>/dev/null")
	branch = ok and branch:gsub("%s+", "") or ""
	vim.b.git_branch = (branch ~= "") and branch or "no-repo"
	return vim.b.git_branch
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
	callback = update_git_branch,
})

local function get_git_branch()
	return vim.b.git_branch or update_git_branch()
end

_G.git_branch = get_git_branch

function _G.diag_status()
	local s = vim.diagnostic.severity
	local c = vim.diagnostic.count(0)
	return ("E%d W%d I%d H%d"):format(c[s.ERROR] or 0, c[s.WARN] or 0, c[s.INFO] or 0, c[s.HINT] or 0)
end

vim.opt.statusline = table.concat({
	"%#PmenuSel#",
	" [%{mode()}] ",
	"%#StatusLine#",
	" %{v:lua.git_branch()}",
	" %{v:lua.diag_status()}",
	"%=",
	" %{pathshorten(expand('%:p:~'))}",
	" %l:%c",
	" %m",
	" [%P of %L] ",
})
