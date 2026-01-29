local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        require("woniulol.plugins.colorschemes"),
        require("woniulol.plugins.dashboard"),
        require("woniulol.plugins.telescope"),
        require("woniulol.plugins.treesitter"),
        require("woniulol.plugins.lsp"),
        require("woniulol.plugins.windsurf"),
        require("woniulol.plugins.lualine"),
        require("woniulol.plugins.blinkcmp"),
        require("woniulol.plugins.todocomments"),
        require("woniulol.plugins.mininvim"),
        require("woniulol.plugins.rendermarkdown"),
        require("woniulol.plugins.conform"),
        require("woniulol.plugins.gitsigns"),
        require("woniulol.plugins.lazygit"),
        require("woniulol.plugins.iron"),
        require("woniulol.plugins.harpoon"),
        require("woniulol.plugins.autopairs"),
        require("woniulol.plugins.illuminate"),
        require("woniulol.plugins.visualwhitespace"),
        require("woniulol.plugins.yazi"),
        require("woniulol.plugins.fugitive"),
        require("woniulol.plugins.snacks"),
        require("woniulol.plugins.aerial"),
        require("woniulol.plugins.colorizer"),
        require("woniulol.plugins.diffview"),

        -- Replace by snack.
        -- require("woniulol.plugins.indentblankline"),

        -- Replaced by terminal emulator.
        -- require("woniulol.plugins.smearcursor"),

        -- Good to have.
        -- require("woniulol.plugins.whichkey"),

        -- Poor performance on ssh server.
        -- require("woniulol.plugins.neoscroll"),

    }, {
        ui = { border = "bold" },
    }
)
