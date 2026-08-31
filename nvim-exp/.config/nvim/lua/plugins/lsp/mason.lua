local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

mason_lspconfig.setup({
	automatic_enable = false,
})

mason_tool_installer.setup({
	ensure_installed = {
		"prettier",
		"lua_ls",
		"stylua",
		-- "ty",
		-- "basedpyright",
		"pyright",
		"rust_analyzer",
		"ruff",
		"pyrefly",
		-- https://github.com/bash-lsp/bash-language-server/tree/main
		-- "bashls",
		"html",
		"cssls",
		"ts_ls",
		"bqls",
		"jsonls",
		"biome",
		"postgres-language-server",
		-- brew install marksman
		"marksman",
		"terraform-ls",
	},
})

mason_tool_installer.check_install(false)
