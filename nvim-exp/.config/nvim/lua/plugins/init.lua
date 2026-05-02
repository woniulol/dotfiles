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
    "https://www.github.com/nvim-tree/nvim-tree.lua",
    "https://www.github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-mini/mini.surround",
    "https://github.com/lewis6991/gitsigns.nvim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main"},
})

require("plugins.fzf-lua")
require("plugins.nvim-tree")
require("plugins.mini-surround")
require("plugins.gitsigns")
require("plugins.treesitter")

