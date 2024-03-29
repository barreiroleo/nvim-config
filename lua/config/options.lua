-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- vim.o: behaves like :let &{option-name}
-- vim.go: behaves like :let &g:{option-name}
-- vim.bo: behaves like :let &l:{option-name} for buffer-local options
-- vim.wo: behaves like :let &l:{option-name} for window-local optionslocal present, impatient = pcall(require, "impatient")

vim.g.mapleader = ","
vim.g.maplocalleader = ","


local opt = vim.opt

-- vim.cmd.language("en_US.utf8")
opt.exrc = true        -- Auto exec {.nvim.lua, .nvimrc, .exrc} in the current dir
-- Editing
opt.expandtab = true   -- Use spaces instead of tabs
opt.shiftround = true  -- Round indent to a multiple of shiftwidth
opt.shiftwidth = 4     -- Size of an indent
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = 0    -- Number of spaces in editing (no indent). Zero for smart spaces.
opt.spelllang = { "en", "es" }
opt.tabstop = 4        -- Number of spaces tabs count for
opt.wrap = false       -- Disable line wrap

-- Behaviour
opt.clipboard = "unnamedplus"             -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect" -- List of options for Insert mode completion
opt.confirm = true                        -- Confirm to save changes before exiting modified buffer
opt.mouse = "a"                           -- Enable mouse mode
opt.nrformats = "alpha,hex,bin"           --Support systems for increment/decrements <C-x>: 0b01 0x1 a1
opt.scrolloff = 4                         -- Lines of context
opt.sidescrolloff = 4                     -- Columns of context
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.mousemoveevent = true
opt.bufhidden = "delete"


-- Keymaps: Avoid <esc> delay. Also set escape-time 0 in tmux
opt.timeout = true    -- for mappings
opt.timeoutlen = 1000 -- default value
opt.ttimeout = true   -- for key codes
opt.ttimeoutlen = 10  -- unnoticeable small value

-- Search
opt.hlsearch = false  -- Off by default
opt.ignorecase = true -- Ignore case
opt.incsearch = true  -- While typing show where the pattern
opt.smartcase = true  -- Don't ignore case with capitals
-- Highlight search results only in search mode.
vim.api.nvim_create_autocmd("CmdlineEnter", { pattern = { "/", "\\?" }, command = "set hlsearch" })
vim.api.nvim_create_autocmd("CmdlineLeave", { pattern = { "/", "\\?" }, command = "set nohlsearch" })
-- Disable smartcase for command line
vim.api.nvim_create_autocmd("CmdlineEnter", { pattern = { ":" }, command = "set nosmartcase" })
vim.api.nvim_create_autocmd("CmdlineLeave", { pattern = { ":" }, command = "set smartcase" })

-- Visual
opt.colorcolumn = "100"
opt.cursorline = true     -- Enable highlighting of the current line
opt.laststatus = 2        -- Status line in all windows
opt.list = true           -- Show some invisible characters (tabs...
opt.number = true         -- Print line number
opt.pumblend = 10         -- Popup blend
opt.pumheight = 10        -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.splitbelow = true     -- New hor. splits goes under the current win instead of below.
opt.splitright = true     -- New ver. splits goes right the current win instead of left.
opt.splitkeep = "screen"
opt.winminwidth = 5       -- Minimum window width
-- opt.listchars:append("space:⋅ ")
-- opt.listchars:append("eol:↴")
opt.listchars:append("tab:» ")

-- WSL Specific configs
if vim.fn.has("wsl") == 1 then
    -- Clipboard
    vim.g.clipboard = {
        name = 'WslClipboard',
        copy = {
            ['+'] = 'clip.exe',
            ['*'] = 'clip.exe',
        },
        paste = {
            ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

-- Test
-- Fix markdown indentation settings
vim.g.markdown_folding = 1           -- Enable the markdown plugin
vim.g.markdown_recommended_style = 0 -- expandtab will be set by default
-- Fix tex recognized as latex instead of plaintex
vim.g.tex_flavor = "latex"
