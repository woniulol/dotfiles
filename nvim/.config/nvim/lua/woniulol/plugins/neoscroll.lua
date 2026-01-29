return {
    "karb94/neoscroll.nvim",
    opts = {},
    config = function()
        local neoscroll = require('neoscroll')
        local keymap = {
            ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 80, easing = "sine", }) end,
            ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 80, easing = "sine", }) end,
        }
        local modes = { 'n', 'v', 'x' }
        for key, func in pairs(keymap) do
            vim.keymap.set(modes, key, func)
        end
    end
}
