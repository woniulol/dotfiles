require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		json = { "biome" },
		typescript = { "prettier" },
		markdown = { "prettier" },
		["*"] = { "trim_whitespace" },
	},
	formatters = {
		prettier = {
			prepend_args = {
				"--tab-width",
				"4",
				"--print-width",
				"88",
			},
		},
	},
	format_after_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
		async = true,
	},
})
