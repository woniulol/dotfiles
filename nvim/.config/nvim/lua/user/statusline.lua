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
-- The mode color is the background; text sits on it in the dark ground color.
-- cterm values kept as a fallback for non-truecolor terminals.
-- Each mode gets a plain group for the whole line plus a bold variant
-- used for the mode indicator itself.
local mode_colors = {
	Normal = { "#9bc9ff", 12 }, -- slot 12 — bright blue
	Insert = { "#bce690", 10 }, -- slot 10 — bright green
	Visual = { "#c89aff", 5 }, -- slot 5  — magenta
	Replace = { "#ff95a4", 9 }, -- slot 9  — bright red
	Command = { "#ffe28c", 11 }, -- slot 11 — bright yellow
	Terminal = { "#7fd6c2", 14 }, -- slot 14 — bright cyan
}

local fg_on_mode = { "#1e1e2e", 0 } -- crust, matches colors.lua

local function set_mode_hls()
	for name, c in pairs(mode_colors) do
		local hl = { fg = fg_on_mode[1], ctermfg = fg_on_mode[2], bg = c[1], ctermbg = c[2] }
		vim.api.nvim_set_hl(0, "Mode" .. name, hl)
		vim.api.nvim_set_hl(0, "Mode" .. name .. "Bold", vim.tbl_extend("force", hl, { bold = true }))
	end
end
set_mode_hls()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_mode_hls })

local function mode_name()
	local m = vim.fn.mode()
	if m == "t" or m == "nt" then
		return "Terminal"
	elseif m == "i" then
		return "Insert"
	elseif m == "v" or m == "V" or m == "\22" then
		return "Visual"
	elseif m == "R" then
		return "Replace"
	elseif m == "c" then
		return "Command"
	else
		return "Normal"
	end
end

-- suffix picks the variant, e.g. "Bold" for the mode indicator
function _G.mode_hl(suffix)
	return "%#Mode" .. mode_name() .. (suffix or "") .. "#"
end

vim.opt.statusline = table.concat({
	"%{%v:lua.mode_hl('Bold')%}",
	" [%{mode()}] ",
	"%{%v:lua.mode_hl()%}",
	" %{v:lua.git_branch()}",
	" %{v:lua.diag_status()}",
	"%=",
	" %{pathshorten(expand('%:p:~'))}",
	" %l:%c",
	" %m",
	" [%P of %L] ",
})
