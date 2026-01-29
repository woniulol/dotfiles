return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "v0.2.0",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
                cond = function()
                    return vim.fn.executable "make" == 1
                end,
            },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            local builtin = require("telescope.builtin")

            require("telescope").setup({
                extensions = {
                    fzf = {},
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown(),
                    },
                },
                defaults = {
                    borderchars = { '━', '┃', '━', '┃', '┏', '┓', '┛', '┗' },
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                        },
                    },
                    file_ignore_patterns = { ".git/" },
                },

            })

            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")

            vim.keymap.set("n", "<leader>d", function()
                builtin.diagnostics({ layout_strategy = "vertical" })
            end, { desc = "Telescope: [d]iagnostics" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: [f]ind [h]elp" })
            vim.keymap.set("n", "<leader>cs", builtin.spell_suggest, { desc = "Telescope: [c]heck [s]pell" })
            vim.keymap.set("n", "<leader>ob", builtin.buffers, { desc = "Telescope: [o]pen [b]uffers" })
            vim.keymap.set("n", "<leader>of",
                function() builtin.find_files({ hidden = true }) end,
                { desc = "Telescope: [o]pen [f]iles" })
            vim.keymap.set("n", "<leader>ok", builtin.keymaps, { desc = "Telescope: [o]pen [k]eymaps" })
            vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope: [l]ive [g]rep" })
            vim.keymap.set("n", "<leader>ffb", builtin.current_buffer_fuzzy_find,
                { desc = "Telescope: [f]uzz [f]ind current [b]uff" })

            vim.keymap.set("v", "<leader>fw", function()
                vim.cmd("normal! y")
                local word = vim.fn.getreg([["]])
                vim.fn.setreg("/", word)
                vim.o.hlsearch = true
                builtin.grep_string({ search = word })
            end, { desc = "Telescope: [f]ind current [w]ords" })

            vim.keymap.set("n", "<leader>oc", function()
                builtin.find_files { cwd = vim.fn.stdpath "config" }
            end, { desc = "Telescope: [o]pen [c]onfigs" })
        end
    },
}
