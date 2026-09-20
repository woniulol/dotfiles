-- jq is the whole implementation, because `jq .` pretty prints a single json
-- document and a stream of concatenated ones (json lines) with the same
-- invocation, so log files and plain .json files take one path
local function to_jq_indent(buf)
	if not vim.bo[buf].expandtab then
		return { "--tab" }
	end
	local width = vim.bo[buf].shiftwidth
	if width == 0 then
		width = vim.bo[buf].tabstop
	end
	return { "--indent", tostring(math.min(width, 7)) } -- jq rejects anything above 7
end

vim.api.nvim_create_user_command("JsonFormat", function(opts)
	if vim.fn.executable("jq") == 0 then
		vim.notify("JsonFormat: jq not found on PATH", vim.log.levels.ERROR)
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local first, last = opts.line1 - 1, opts.line2
	local lines = vim.api.nvim_buf_get_lines(buf, first, last, false)

	local cmd = { "jq" }
	vim.list_extend(cmd, to_jq_indent(buf))
	table.insert(cmd, ".")

	local res = vim.system(cmd, { stdin = table.concat(lines, "\n"), text = true }):wait()
	if res.code ~= 0 then
		-- leave the buffer untouched so a half parsed file is never written back
		vim.notify(vim.trim(res.stderr ~= "" and res.stderr or "jq failed"), vim.log.levels.ERROR)
		return
	end

	local view = vim.fn.winsaveview()
	vim.api.nvim_buf_set_lines(buf, first, last, false, vim.split(vim.trim(res.stdout), "\n"))
	vim.fn.winrestview(view)
end, {
	range = "%", -- no range means the whole buffer, a visual selection means just that
	desc = "pretty print json (or json lines) with jq",
})
