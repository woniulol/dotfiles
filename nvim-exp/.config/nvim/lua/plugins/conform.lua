require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format" },
		json = { "biome" },
		typescript = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
		terraform = { "terraform_fmt" },
		rust = { "rustfmt" },
		["*"] = { "trim_whitespace", "trim_newlines" },
	},
	format_after_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
		async = true,
	},
})
