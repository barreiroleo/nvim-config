-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- vim.o: behaves like :let &{option-name}
-- vim.go: behaves like :let &g:{option-name}
-- vim.bo: behaves like :let &l:{option-name} for buffer-local options
-- vim.wo: behaves like :let &l:{option-name} for window-local optionslocal present, impatient = pcall(require, "impatient")

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- vim.cmd.language("en_US.utf8")
vim.opt.exrc = true        -- Auto exec {.nvim.lua, .nvimrc, .exrc} in the current dir
-- Editing
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftround = true  -- Round indent to a multiple of shiftwidth
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en", "es" }
vim.opt.tabstop = 4        -- Number of spaces tabs count for
vim.opt.wrap = false       -- Disable line wrap

-- Behaviour
vim.opt.clipboard = "unnamedplus"             -- Sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect" -- List of options for Insert mode completion
vim.opt.confirm = true                        -- Confirm to save changes before exiting modified buffer
vim.opt.mouse = "a"                           -- Enable mouse mode
vim.opt.nrformats = "alpha,hex,bin"           --Support systems for increment/decrements <C-x>: 0b01 0x1 a1
vim.opt.scrolloff = 4                         -- Lines of context
vim.opt.sidescrolloff = 4                     -- Columns of context
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200                      -- Save swap file and trigger CursorHold
-- opt.wildmode = "longest:full,full" - FIX: Useless along the cmp module
vim.opt.mousemoveevent = true
vim.opt.bufhidden = "delete"


-- Keymaps: Avoid <esc> delay. Also set escape-time 0 in tmux
vim.opt.timeout = true    -- for mappings
vim.opt.timeoutlen = 1000 -- default value
vim.opt.ttimeout = true   -- for key codes
vim.opt.ttimeoutlen = 10  -- unnoticeable small value

-- Search
vim.opt.hlsearch = true  -- Off by default
vim.opt.ignorecase = true -- Ignore case
vim.opt.incsearch = true  -- While typing show where the pattern
vim.opt.smartcase = true  -- Don't ignore case with capitals

-- Visual
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true     -- Enable highlighting of the current line
vim.opt.laststatus = 2        -- Status line in all windows
vim.opt.list = true           -- Show some invisible characters (tabs...
vim.opt.number = true         -- Print line number
vim.opt.pumblend = 10         -- Popup blend
vim.opt.pumheight = 10        -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.splitbelow = true     -- New hor. splits goes under the current win instead of below.
vim.opt.splitright = true     -- New ver. splits goes right the current win instead of left.
-- vim.opt.winminwidth = 5       -- Minimum window width
-- vim.opt.listchars:append("space:⋅ ")
-- vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("tab:» ")

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
