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

-- Mode-aware highlights — hex values mirror the Ghostty palette slots
-- (since termguicolors=true uses RGB, not the palette directly).
-- ctermfg kept as a fallback for non-truecolor terminals.
local function set_mode_hls()
	vim.api.nvim_set_hl(0, "ModeNormal", { fg = "#9bc9ff", ctermfg = 12, bold = true }) -- slot 12 — bright blue
	vim.api.nvim_set_hl(0, "ModeInsert", { fg = "#bce690", ctermfg = 10, bold = true }) -- slot 10 — bright green
	vim.api.nvim_set_hl(0, "ModeVisual", { fg = "#c89aff", ctermfg = 5, bold = true }) -- slot 5  — magenta
	vim.api.nvim_set_hl(0, "ModeReplace", { fg = "#ff95a4", ctermfg = 9, bold = true }) -- slot 9  — bright red
	vim.api.nvim_set_hl(0, "ModeCommand", { fg = "#ffe28c", ctermfg = 11, bold = true }) -- slot 11 — bright yellow
end
set_mode_hls()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_mode_hls })

function _G.mode_hl()
	local m = vim.fn.mode()
	if m == "i" then
		return "%#ModeInsert#"
	elseif m == "v" or m == "V" or m == "\22" then
		return "%#ModeVisual#"
	elseif m == "R" then
		return "%#ModeReplace#"
	elseif m == "c" then
		return "%#ModeCommand#"
	else
		return "%#ModeNormal#"
	end
end

vim.opt.statusline = table.concat({
	"%{%v:lua.mode_hl()%}",
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
