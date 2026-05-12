-- plugin-specific keymaps should be defined together with the plugin settins

local function map(mode, lhs, rhs, desc, extra_opts)
	local options = {
		noremap = true,
		silent = true,
		desc = desc,
	}
	if extra_opts then
		options = vim.tbl_extend("force", options, extra_opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear highlights on search when pressing <Esc>")

map({ "x", "v" }, "p", [["_dP]], "paste without yank")
map({ "n", "v" }, "d", [["_d]], "delete d without yank")
map({ "n", "x", "v" }, "x", [["_x]], "delete x without yank")

map("n", "n", "nzzzv", "center screen when jumping to next")
map("n", "N", "Nzzzv", "center screen when jumping to previous")
map("n", "<C-d>", "<C-d>zz", "center screen when scrolling down")
map("n", "<C-u>", "<C-u>zz", "center screen when scrolling up")

map("n", "<C-h>", "<C-w>h", "Move focus to the left window")
map("n", "<C-l>", "<C-w>l", "Move focus to the right window")
map("n", "<C-j>", "<C-w>j", "Move focus to the lower window")
map("n", "<C-k>", "<C-w>k", "Move focus to the upper window")

map("v", "J", ":m '>+1<CR>gv=gv", "Move line down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move line up")
map("v", "L", ">gv", "Indent right and reselect")
map("v", "H", "<gv", "Indent left and reselect")

map("v", "v", "an", "Increment Selection", { remap = true })
map("v", "V", "in", "Decrement Selection", { remap = true })

map("n", "<leader>aa", function()
	vim.cmd("argadd %")
	vim.cmd("argdedupe")
	print("Arg added: " .. vim.fn.expand("%:~:."))
end, "add buffer to arg list")

map("n", "<leader>al", function()
	require("user.shp").focus_or_open()
end, "delete buffer to arg list")

map("n", "<leader>sh", function()
	require("user.sh").open()
	vim.cmd.startinsert()
end, "create small terminal")

map("x", "<leader>rs", function()
	require("user.sh").run_selection()
end, "run selection as shell command")

-- Save <C-\\> for zmx
map("t", "<C-]>", "<C-\\><C-n>", "exit terminal mode")
map("t", "<C-\\>", function()
	vim.api.nvim_chan_send(vim.b.terminal_job_id, "\28")
end, "send <C-\\> to terminal (zmx detach)")

map("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, "yank full file path")

map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, "wrap-aware down", { expr = true })

map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, "wrap-aware up", { expr = true })

map("n", "<leader>h", function()
	local word = vim.fn.expand("<cword>")
	if word == "" then
		return
	end
	vim.fn.setreg("/", [[\<]] .. word .. [[\>]])
	vim.opt.hlsearch = true
end, "highlight word under cursor")

map("n", "<leader>ts", function()
	vim.opt_local.spell = not vim.opt_local.spell:get()
	print("Toggle spell check: " .. tostring(vim.opt_local.spell:get()))
end, "toggle spell check")

map("n", "<leader>fmt", vim.lsp.buf.format, "lsp format")
map("n", "<leader>D", vim.diagnostic.setloclist, "open diagnostic list")
map("n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics")
