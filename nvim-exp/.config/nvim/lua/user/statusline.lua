vim.opt.laststatus = 3  -- ensure there is only one status bar with multiple split

local function update_git_branch()
    local ok, branch = pcall(vim.fn.system, "git branch --show-current 2>/dev/null")
    branch = ok and branch:gsub("%s+", "") or ""
    vim.b.git_branch = (branch ~= "") and branch or "no-repo"
    return vim.b.git_branch
end

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    callback = update_git_branch
})

local function get_git_branch()
    return vim.b.git_branch or update_git_branch()
end

_G.git_branch = get_git_branch

vim.opt.statusline = table.concat({
    "%#PmenuSel#",
    " [%{mode()}] ",
    "%#StatusLine#",
    " %{v:lua.git_branch()} ",
    "%=",
    " %{pathshorten(expand('%:p:~'))}",
    " %l:%c", 
    " %m",
    " [%P of %L] ",
})
