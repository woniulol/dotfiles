-- NOTE: About MacOS Keybidings
--
-- CTRL, OPTION, COMMAND key might not be mapped properly.
-- Especially when you have a terminal emulator, such as Alacritty.
--
-- It might affect certain default keybindings of some plugins, such as mini.move.
--
-- For Alacritty, set window.option_as_alt = "Both"

vim.o.encoding = "UTF-8"

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Decrease update time
vim.o.updatetime = 50

-- Set to true if you have a Nerd Font installed and selected in the terminal.
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Search
vim.o.incsearch = true

-- Visual Setting
vim.o.cursorline = true    -- Highlight cursor line
vim.o.termguicolors = true -- Enable 24-bit RGB colors
vim.o.signcolumn = "yes"   -- Ruler
vim.o.colorcolumn = "100"  -- Ruler show at n char
vim.o.showmatch = true     -- Highlight matching parenthesis
vim.o.showmode = false     -- Status line already show the mode

-- File Handling
vim.o.backup = false                            -- Don't create backup files
vim.o.writebackup = false                       -- Don't create backup files before writing
vim.o.swapfile = false                          -- Don't create swap files
vim.o.undofile = true                           -- Enable persistent undo
vim.o.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory
vim.o.timeoutlen = 500                          -- Key timeout duration
vim.o.ttimeoutlen = 5                           -- Key code timeout
vim.o.autoread = true                           -- Reload file if changed
vim.o.autowrite = false                         -- Don't auto write

-- Behavior setting
vim.opt.iskeyword:append("-") -- Treat "-" as part of a word
vim.opt.iskeyword:append("-") -- Treat "_" as part of a word
vim.opt.path:append("**")     -- Include files in sub directories
vim.o.scrolloff = 20          -- Prevent cursor drop to bottom

-- Clipboard setting
vim.keymap.set({ "x", "v" }, "p", [["_dP]], { desc = "Paste without yank" })
vim.keymap.set({ "n", "v" }, "d", [["_d]], { desc = "Delete without yank" })
vim.keymap.set({ "n", "x", "v" }, "x", [["_x]], { desc = "Delete without yank" })

-- Sync clipboard between Os and Neovim, ssh and local.
-- https://github.com/neovim/neovim/discussions/28010#discussioncomment-9877494
vim.o.clipboard = "unnamedplus"
local is_ssh = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil
if is_ssh then
    local function paste()
        return {
            vim.fn.split(vim.fn.getreg('"'), "\n"),
            vim.fn.getregtype(""),
        }
    end
    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = {
            ["+"] = paste,
            ["*"] = paste,
        },
    }
end

-- Enable spell checking from nvim
vim.o.spelllang = "en_us"
vim.o.spell = true

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Clear highlights on search when pressing <Esc>" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })
vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of line" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Center screen when jumping" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center screen when jumping" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center screen when scrolling down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center screen when scrolling up" })

-- Split navigation easier
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move Lines up/down
vim.keymap.set("n", "<S-M-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<S-M-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<S-M-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "<S-M-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Shortcut to create a new [s]mall [t]erminal
vim.keymap.set("n", "<leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("L")
    -- vim.api.nvim_win_set_height(0, 6)
    vim.cmd("startinsert")
end)

-- Copy the full file path
vim.keymap.set("n", "<leader>yp", function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("file:", path)
end)

-- Tabs and buffers
-- Default we have <leader>gt to go to the next tab and <leader>gT to go to the previous tab
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Create new tab" })
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close tab" })

-- Lsp formatting
vim.keymap.set("n", "<leader>fmt", vim.lsp.buf.format)
vim.opt.fixendofline = false
