-- need to install treesitter cli first
--
-- https://github.com/tree-sitter/tree-sitter/releases
--
-- curl -LO https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.8/tree-sitter-cli-macos-arm64.zip
-- unzip tree-sitter-cli-macos-arm64.zip
-- chmod +x tree-sitter
-- sudo mv tree-sitter /usr/local/bin/
-- rm tree-sitter-cli-macos-arm64.zip
--
-- :checkhealth nvim-treesitter
-- :set indentexpr?
--
-- nake nvim already had treesitter installed and with a bounch of `nvim-treesitter-api`
-- what we are doing here is more like extending it's functionality.

local treesitter = require("nvim-treesitter")

local ensure_installed = {
    "json", "javascript", "typescript", "tsx", "go", "yaml", "html", "css", "python", "http",
    "prisma", "markdown", "markdown_inline", "svelte", "graphql", "bash", "lua", "vim",
    "dockerfile", "gitignore", "query", "vimdoc", "c", "java", "rust", "ron",
}
treesitter.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)

        if not lang then return end

        local ok_add = pcall(vim.treesitter.language.add, lang)
        if not ok_add then return end

        pcall(vim.treesitter.start, buf, lang)

        -- enable indentation only for real languages
        if ft ~= "yaml" and ft ~= "markdown" then
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.bo[buf].smartindent = false
            vim.bo[buf].cindent = false
        end
    end,
})
