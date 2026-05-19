require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		json = { "biome" },
		--     markdown = { "prettierd" },
		["*"] = { "trim_whitespace" },
	},
	format_after_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
		async = true,
	},
})
