local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

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
	ensure_installed = {
		"lua_ls",
		"stylua",
		"ty",
		-- "basedpyright",
		"pyright",
		"rust_analyzer",
		"ruff",
		"pyrefly",
		-- brew install marksman
		-- "marksman",
		-- "prettierd",
		-- https://github.com/bash-lsp/bash-language-server/tree/main
		"bashls",
		"html",
		"cssls",
		"ts_ls",
		-- "bqls",
		"jsonls",
		"biome",
	},
})
