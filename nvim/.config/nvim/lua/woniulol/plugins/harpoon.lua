return {
    {
        "ThePrimeagen/harpoon",
        event = { "BufNewFile", "BufReadPost" },
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require('harpoon')
            harpoon:setup({
                global_settings =
                {
                    save_on_toggle = true,
                    save_on_change = true,
                },
            })

            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
                { desc = "Harpoon: [a]dd buffer to list" })
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
                { desc = "Harpoon: toogle quick menu show list" })

            -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
            -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
            -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
            -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon: previous list item" })
            vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon: next list item" })

            local harpoon_extensions = require("harpoon.extensions")
            harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
        end
    }
}
