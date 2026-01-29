return {
    {
        "neovim/nvim-lspconfig",
         event = "VeryLazy",
        dependencies = {
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
            { "WhoIsSethDaniel/mason-tool-installer.nvim" },
            { "saghen/blink.cmp" },
        },
        config = function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

            require("mason").setup({
                ui = {
                    border = "bold",
                },
            })
            require("mason-lspconfig").setup({
                automatic_enable = {},
            })
            require("mason-tool-installer").setup({
                ensure_installed = {
                    { "lua_ls", version = "3.15.0" },
                    "ty",
                    "pyright",
                    "basedpyright",
                    "rust_analyzer",
                    "ruff",
                    -- brew install marksman
                    "marksman",
                    "prettierd",
                },
            })
            require("woniulol.plugins.lsp_config")

            vim.lsp.enable("lua_ls")
            vim.lsp.enable("ty")
            vim.lsp.enable("ruff")
            -- vim.lsp.enable("pyright")
            vim.lsp.enable("basedpyright")
            vim.lsp.enable("rust_analyzer")
            vim.lsp.enable("marksman")
            vim.lsp.enable("prettierd")

            local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                    end

                    -- Rename the variable under your cursor.
                    -- Most Language Servers support renaming across files, etc.
                    map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    -- or a suggestion from your LSP for this to activate.
                    map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

                    -- Find references for the word under your cursor.
                    map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

                    -- Jump to the implementation of the word under your cursor.
                    -- Useful when your language has ways of declaring types without an actual implementation.
                    map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

                    -- Jump to the definition of the word under your cursor.
                    -- This is where a variable was first declared, or where a function is defined, etc.
                    -- To jump back, press <C-t>.
                    map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

                    -- WARN: This is not Goto Definition, this is Goto Declaration.
                    -- For example, in C this would take you to the header.
                    map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

                    -- Fuzzy find all the symbols in your current document.
                    -- Symbols are things like variables, functions, types, etc.
                    map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

                    -- Fuzzy find all the symbols in your current workspace.
                    -- Similar to document symbols, except searches over your entire project.
                    map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
                    -- Jump to the type of the word under your cursor.
                    -- Useful when you're not sure what type a variable is and you want to see
                    -- the definition of its *type*, not where it was *defined*.
                    map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")
                end,
            })

            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover({ border = "bold" })
            end, { desc = "Add border" })

            vim.diagnostic.config({
                severity_sort = true,
                float = { border = "rounded", source = "if_many" },
                underline = { severity = vim.diagnostic.severity.ERROR },
                signs = vim.g.have_nerd_font and {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                } or {},
                virtual_text = {
                    source = "if_many",
                    spacing = 2,
                    format = function(diagnostic)
                        -- Only show the first line of the diagnostic message to virtual text.
                        local msg = diagnostic.message:match("^[^\n]+")
                        return string.format("%s", msg)
                    end,
                },
            })
        end,
    },
}
