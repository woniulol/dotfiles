local M = {
	-- Change this flag and restart Neovim to enable or disable the whole feature.
	enabled = false,
	-- Add entries with project_id and location; the first is the default project.
	-- Example (replace the placeholder IDs with your own):
	-- projects = {
	-- 	{ project_id = "project-a", location = "asia-southeast1" },
	-- 	{ project_id = "project-b", location = "US" },
	-- 	{ project_id = "project-c", location = "EU" },
	-- },
	-- Sidebar project_ids are generated from this list automatically.
	-- <leader>db toggles the sidebar; <leader>dp switches project and location.
	projects = {},
}

function M.tools()
	return M.enabled and { "bqls" } or {}
end

function M.setup()
	if not M.enabled then
		return
	end

	vim.pack.add({
		{ src = "https://github.com/kitagry/bqls.nvim", version = "main" },
	})

	local project_ids = {}
	for _, project in ipairs(M.projects) do
		table.insert(project_ids, project.project_id)
	end
	require("bqls").setup({ project_ids = project_ids })
	vim.lsp.config("bqls", { settings = M.projects[1] or {} })
	vim.lsp.enable("bqls")

	vim.keymap.set("n", "<leader>db", require("bqls").sidebar.toggle, { desc = "Toggle BigQuery sidebar" })
	vim.keymap.set("n", "<leader>dp", function()
		if #M.projects == 0 then
			vim.notify("Add projects in lua/features/bigquery/init.lua first", vim.log.levels.INFO)
			return
		end
		vim.ui.select(M.projects, {
			prompt = "BigQuery project",
			format_item = function(project)
				return project.project_id .. " @ " .. (project.location or "default")
			end,
		}, function(project)
			if not project then
				return
			end
			vim.lsp.config("bqls", { settings = project })
			for _, client in ipairs(vim.lsp.get_clients({ name = "bqls" })) do
				client.config.settings = vim.deepcopy(project)
				client:notify("workspace/didChangeConfiguration", { settings = project })
			end
		end)
	end, { desc = "Switch BigQuery project/location" })
end

return M
