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

        map("n", "<leader>gph", gs.preview_hunk_inline, { desc="gitsigns preview hunk" })
        -- Hunk level stage or non-stage
        map("n", "<leader>gsh", gs.stage_hunk, { desc = "gitsigns stage hunk" })
        -- Non-stage hunk reset
        map("n", "<leader>grh", gs.reset_hunk, { desc = "gitsigns reset hunk" })
        map("n", "<leader>gsb", gs.stage_buffer, "gitsigns sstage buffer")
        map("n", "<leader>gub", gs.reset_buffer_index, "gitsigns unstage buffer")
        map("n", "<leader>grb", gs.reset_buffer, "gitsigns reset buffer")
        map("n", "<leader>gbl", function() gs.blame_line({ full = true }) end, "gitsigns blame line")
        map("n", "<leader>gB", gs.toggle_current_line_blame, "gitsigns blame line")

        -- Diff between current buffer with latest commit
        map("n", "<leader>gsd", gs.diffthis, "Gitsigns [s]how [d]iff")
        -- Diff between current buffer with HEAD
        map("n", "<leader>gsD", function() gs.diffthis("~") end, "Gitsigns [s]how [D]iff [~]")

        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns [i]nclude [h]unk")
    end

})

