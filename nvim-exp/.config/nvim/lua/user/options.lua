-- default config will remained commented

-- sys
-- vim.opt.encoding = "UTF-8"  -- encoding
vim.opt.termguicolors = true -- enable 24-bit RGB colors

-- disable language providers we don't use (saves ~40ms on first python file open).
-- re-enable if you install a plugin that calls :python3 / :ruby / :perl / node-host plugins.
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- tab
vim.opt.tabstop = 4 -- number of spaces to be treated as a tab
vim.opt.shiftwidth = 4 -- indent width (with >> and <<)
vim.opt.softtabstop = 4 -- editing number of spaces to jump
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

-- search
vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
-- vim.opt.hlsearch = true -- highlight search matches (<C-l> to cancle)
-- vim.opt.incsearch = true -- show matches as you type
vim.opt.path:append("**") -- include subdirs in search for find, sfind, tabf checkpath
vim.opt.wildignore:append({ "**/node_modules/**", "**/.git/**", "**/build/**" })
vim.o.inccommand = "split" -- preview substitutions live, as you type!

-- visual
vim.opt.cursorline = true -- highlight cursor line
vim.opt.signcolumn = "yes" -- ruler
vim.opt.colorcolumn = "89" -- ruler show at n char
vim.opt.showmatch = true -- highlight matching parenthesis
vim.opt.showmode = false -- status line already show the mode
vim.opt.wrap = true -- wrap lines by default
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.fillchars = {
	eob = " ", -- hide "~" on empty lines
}

-- scroll
vim.opt.scrolloff = 10 -- keep 10 lines above/blow cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor
vim.o.mousescroll = "ver:2,hor:2" -- line number multiplier to the scrolling

-- undo
local undodir = vim.fn.expand("~/.vim/undodir") -- create undodir is not exist
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undodir = undodir -- Undo directory

-- file
vim.opt.backup = false -- don't create backup files
vim.opt.writebackup = false -- don't create backup files before writing
vim.opt.swapfile = false -- don't create swap files
vim.opt.autoread = true -- reload file if changed
vim.opt.autowrite = false -- don't auto write
vim.opt.hidden = true -- allow hidden buffer
vim.opt.fixendofline = false

-- time
vim.opt.updatetime = 50 -- faster react time
vim.opt.timeoutlen = 500 -- key timeout duration
vim.opt.ttimeoutlen = 0 -- key code timeout

-- text
-- vim.opt.selection = "inclusive"  -- include the last char in selection
vim.opt.iskeyword:append("-") -- treat "-" as part of a word
vim.opt.iskeyword:append("_") -- treat "_" as part of a word

-- clipboard
-- sync clipboard between Os and Neovim, ssh and local.
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

-- fold
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treasitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

-- split
vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

-- completion
-- vim.opt.completeopt = "menuone,noinsert,noselect"  -- completion options
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- other
-- vim.opt.pumheight = 10 -- pop-up menu height
-- vim.opt.pumblend = 0 -- pop-up menu transparency
vim.opt.winborder = "single"
-- vim.opt.winblend = 0  -- floating window transparency
-- vim.opt.conceallevel = 0 -- do not hide markup
-- vim.opt.concealcursor = "" -- do not hide cursor line in markup

-- spelling
vim.opt.spelllang = "en_us"
vim.opt.spell = true
