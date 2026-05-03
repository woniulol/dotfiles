require("blink.cmp").setup({
	keymap = {
		-- this is not for the K doc
		["<C-u>"] = { "scroll_documentation_up", "fallback" },
		["<C-d>"] = { "scroll_documentation_down", "fallback" },
	},

	appearance = { nerd_font_variant = "mono" },

	completion = {
		ghost_text = { enabled = true },
		menu = {
			auto_show = true,
			auto_show_delay_ms = 0,
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 0,
		},
	},

	signature = { enabled = true },

	cmdline = {
		keymap = { preset = "inherit" },
		completion = {
			menu = { auto_show = true },
		},
	},

	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
		providers = {
			snippets = { score_offset = 500 },
		},
	},

	fuzzy = { implementation = "rust" },
})
