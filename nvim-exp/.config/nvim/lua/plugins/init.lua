vim.pack.add({
    "https://www.github.com/nvim-tree/nvim-tree.lua",
    "https://www.github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-mini/mini.surround",
    "https://github.com/lewis6991/gitsigns.nvim",
})

require("plugins.fzf-lua")
require("plugins.nvim-tree")
require("plugins.mini-surround")
require("plugins.gitsigns")

