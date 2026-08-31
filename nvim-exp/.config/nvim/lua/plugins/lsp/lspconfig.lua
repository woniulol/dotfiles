-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local fzf = require("fzf-lua")
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("grn", vim.lsp.buf.rename, "rename")
		map("gra", fzf.lsp_code_actions, "goto code action", { "n", "x" })
		map("grd", fzf.lsp_definitions, "goto definition")
		map("grr", fzf.lsp_references, "goto references")
		map("gri", fzf.lsp_implementations, "goto implementation")
		map("grt", fzf.lsp_typedefs, "type defs")

		map("gO", fzf.lsp_document_symbols, "open document symbols")
		map("gW", fzf.lsp_live_workspace_symbols, "open workspace symbols")
	end,
})

local signs = {
	[vim.diagnostic.severity.ERROR] = "E",
	[vim.diagnostic.severity.WARN] = "W",
	[vim.diagnostic.severity.HINT] = "H",
	[vim.diagnostic.severity.INFO] = "I",
}

-- update diagnostic config function
vim.diagnostic.config({
	signs = { text = signs },
	virtual_text = true,
	underline = true,
	update_in_insert = true,
	float = {
		focusable = false,
		style = "minimal",
		source = true,
	},
})

-- <leader>lx toggle for virtual text (no hover changes)
vim.keymap.set("n", "<leader>lx", function()
	local current = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({ virtual_text = not current })
end, { desc = "Toggle LSP virtual text" })

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
				path ~= vim.fn.stdpath("config")
				and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				version = "LuaJIT",
				path = { "lua/?.lua", "lua/?/init.lua" },
			},
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		})
	end,
})

vim.lsp.config("ruff", {})

vim.filetype.add({
	filename = {
		[".zshrc"] = "zsh",
		[".zprofile"] = "zsh",
		[".zshenv"] = "zsh",
		[".zlogin"] = "zsh",
	},
	extension = {
		zsh = "zsh",
		tf = "terraform",
	},
})

vim.lsp.config("bashls", {
	settings = {
		bashIde = {
			globPattern = "**/*@(.sh|.inc|.bash|.command|.zsh|.zshrc|.zprofile|.zshenv|.zlogin)",
		},
	},
	filetypes = { "bash", "sh", "zsh" },
	root_markers = { ".git" },
})

vim.lsp.config("ty", {
	settings = {
		ty = {
			disableLanguageServices = true, -- Use `ty` solely for type checking.
		},
	},
})

vim.lsp.config("ts_ls", {})

vim.lsp.config("jsonls", {
	filetypes = { "json", "jsonc", "jsonl" },
})

vim.lsp.config("html", {})

vim.lsp.config("cssls", {})

vim.lsp.config("pyright", {
	-- settings = {
	-- 	python = {
	-- 		analysis = {
	-- 			-- Disables type checking, leaving only intellisense
	-- 			typeCheckingMode = "off",
	-- 			-- Disables automatic import sorting so you can use tools like ruff
	-- 			disableOrganizeImports = true,
	-- 		},
	-- 	},
	-- },
})
vim.lsp.config("pyrefly", {})
vim.lsp.config("postgres_lsp", {})

-- Marksman only work in a git repo or with a `.marksman.toml` in the root dir.
-- See https://github.com/artempyanykh/marksman/blob/main/docs/features.md#workspace-folders-project-roots-and-single-file-mode
vim.lsp.config("marksman", {
	-- Only attach to buffers backed by a real file.
	root_dir = function(bufnr, on_dir)
		local name = vim.api.nvim_buf_get_name(bufnr)
		if name == "" or name:find("://", 1, true) then
			return
		end
		on_dir(nil) -- fall back to marksman's own root_markers
	end,
})

vim.lsp.config("terraformls", {})
vim.lsp.config("rust_analyzer", {})

-- vim.lsp.config("bqls", {
-- 	settings = {
-- 		project_id = "mydpv-project",
-- 		location = "asia-southeast1",
-- 	},
-- })
-- local function bqls_configure(project_id, location)
-- 	for _, client in ipairs(vim.lsp.get_clients({ name = "bqls" })) do
-- 		client:notify("workspace/didChangeConfiguration", {
-- 			settings = { project_id = project_id, location = location },
-- 		})
-- 	end
-- 	vim.notify(("bqls -> %s @ %s"):format(project_id, location))
-- end
-- vim.keymap.set("n", "<leader>dp", function()
-- 	local presets = {
-- 		{ project = "mydpv-project", location = "asia-southeast1" },
-- 		{ project = "dpv-aicto", location = "asia-southeast1" },
-- 		{ project = "dpv-aicto-client", location = "asia-southeast1" },
-- 	}
-- 	vim.ui.select(presets, {
-- 		prompt = "bqls project",
-- 		format_item = function(p)
-- 			return ("%s @ %s"):format(p.project, p.location)
-- 		end,
-- 	}, function(choice)
-- 		if choice then
-- 			bqls_configure(choice.project, choice.location)
-- 		end
-- 	end)
-- end, { desc = "Switch bqls project/location" })

vim.lsp.enable({
	"lua_ls",
	"ruff",
	"pyright",
	-- "pyrefly",
	-- "ty",
	"bashls",
	"ts_ls",
	"html",
	"cssls",
	"jsonls",
	"biome",
	"postgres_lsp",
	"marksman",
	"terraformls",
	"rust_analyzer",
	"bqls",
})
