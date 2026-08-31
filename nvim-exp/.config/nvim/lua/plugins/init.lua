-- auto run :TSUpdate on first install or when parsers change
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		if event.data.spec and event.data.spec.name == "nvim-treesitter" then
			if not event.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.pack.add({
	"https://github.com/kotsuban/nekomi.nvim",
	"https://github.com/folke/snacks.nvim",

	-- deps
	"https://github.com/nvim-lua/plenary.nvim",

	"https://github.com/mikavilpas/yazi.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/lewis6991/gitsigns.nvim",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
	},
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",

	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/selimacerbas/live-server.nvim",
	"https://github.com/selimacerbas/markdown-preview.nvim",

	"https://github.com/stevearc/conform.nvim",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/mcauley-penney/visual-whitespace.nvim",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/windwp/nvim-autopairs",
	{
		src = "https://github.com/kitagry/bqls.nvim",
		version = "main",
	},
})

-- prepend mason's bin dir so lspconfig can spawn already-installed servers
-- before the deferred mason.setup() runs
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- eager: register lazy keymaps (no plugin code loaded yet)
require("plugins.fzf-lua")
-- require("plugins.nvim-tree")

-- eager: needed before the first buffer's FileType fires
require("plugins.treesitter")
require("plugins.blinkcmp")
require("plugins.lsp.lspconfig")

-- deferred: run on the next event loop tick so they don't block first paint
vim.schedule(function()
	require("plugins.mini-surround")
	require("plugins.gitsigns")
	require("plugins.conform")
	require("plugins.diffview")
	require("plugins.visual-whitespace")
	require("plugins.todo-comments")
	require("plugins.yazi")
	require("plugins.autopairs")
	require("plugins.snacks")
	require("plugins.bqls")
end)

-- lazy: load mason the first time you open the cmdline (covers :Mason*)
vim.api.nvim_create_autocmd("CmdlineEnter", {
	once = true,
	callback = function()
		require("plugins.lsp.mason")
	end,
})
