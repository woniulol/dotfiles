local gs = require("gitsigns")
local map = vim.keymap.set

gs.setup({
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
    preview_config = { border = 'bold'},
    on_attach = function(bufnr)
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        map("n", "<leader>gph", gs.preview_hunk_inline, { desc = "gitsigns preview hunk" })
        map("n", "<leader>gsh", gs.stage_hunk, { desc = "gitsigns stage or non-stage hunk" })
        map("n", "<leader>grh", gs.reset_hunk, { desc = "gitsigns reset non-stage hunk" })
        map("n", "<leader>gsb", gs.stage_buffer, { desc = "gitsigns stage buffer"})
        map("n", "<leader>gub", gs.reset_buffer_index, { desc = "gitsigns unstage buffer"})
        map("n", "<leader>grb", gs.reset_buffer, { desc = "gitsigns reset buffer"})
        map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, { desc = "gitsigns blame line"})
        map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "toogle gitsigns blame line"})
        map("n", "<leader>gsd", gs.diffthis, { desc = "gitsigns show diff to latest commit"})
        map("n", "<leader>gsD", function() gs.diffthis("~") end, { desc = "gitsigns show diff to HEAD"})
    end
})

