-- Show where the type under the cursor comes from. rust-analyzer hover on a
-- variable only gives the bare type name, so combine two requests:
--   1. "Insert explicit type" code action: public (re-export aware) path as
--      written from the current module; only offered on untyped `let`
--   2. typeDefinition + hover on the definition: absolute defining module
local M = {}

local function to_explicit_type(actions)
	for _, action in ipairs(actions or {}) do
		local ty = action.title:match("^Insert explicit type `(.+)`$")
		if ty then
			return ty
		end
	end
end

-- hover on a definition starts with a ```rust block holding its module path,
-- followed by the item signature
local function to_defining_path(hover)
	local value = hover and hover.contents and hover.contents.value or ""
	local module = value:match("```rust\n(.-)\n```")
	local name = value:match("%f[%w]struct%s+([%w_]+)")
		or value:match("%f[%w]enum%s+([%w_]+)")
		or value:match("%f[%w]union%s+([%w_]+)")
		or value:match("%f[%w]trait%s+([%w_]+)")
		or value:match("%f[%w]type%s+([%w_]+)")
	if module and name then
		return module .. "::" .. name
	end
end

function M.show_type_path()
	local client = vim.lsp.get_clients({ bufnr = 0, name = "rust_analyzer" })[1]
	if not client then
		return
	end
	local win = vim.api.nvim_get_current_win()
	local pos_params = vim.lsp.util.make_position_params(win, client.offset_encoding)
	local range_params = vim.lsp.util.make_range_params(win, client.offset_encoding)
	range_params.context = { diagnostics = {} }

	local explicit
	local defined = {}
	local pending = 2
	local function finish()
		pending = pending - 1
		if pending > 0 then
			return
		end
		local paths = vim.tbl_filter(function(path)
			return path
		end, defined)
		if not explicit and #paths == 0 then
			vim.notify("No type path found", vim.log.levels.INFO)
			return
		end
		-- markdown with rust fences, rendered like the K hover float;
		-- `---` becomes a full width rule
		local lines = {}
		if explicit then
			vim.list_extend(lines, { "```rust", explicit, "```" })
		end
		if #paths > 0 then
			if explicit then
				table.insert(lines, "---")
			end
			table.insert(lines, "```rust")
			vim.list_extend(lines, paths)
			table.insert(lines, "```")
		end
		-- same focus_id on a second gK jumps into the float, like K K
		vim.lsp.util.open_floating_preview(lines, "markdown", { focus_id = "rust_type_path" })
	end

	client:request("textDocument/codeAction", range_params, function(_, actions)
		explicit = to_explicit_type(actions)
		finish()
	end)

	client:request("textDocument/typeDefinition", pos_params, function(_, result)
		local locations = result or {}
		if not vim.islist(locations) then
			locations = { locations }
		end
		pending = pending + #locations
		for i, loc in ipairs(locations) do
			local params = {
				textDocument = { uri = loc.targetUri or loc.uri },
				position = (loc.targetSelectionRange or loc.range).start,
			}
			client:request("textDocument/hover", params, function(_, hover)
				defined[i] = to_defining_path(hover) or false
				finish()
			end)
		end
		finish()
	end)
end

return M
