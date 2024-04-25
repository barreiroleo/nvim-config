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
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.tabstop = 4        -- Number of spaces tabs count for
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftround = true  -- Round indent to a multiple of shiftwidth
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.wrap = false       -- Disable line wrap
vim.opt.spelllang = { "en", "es" }

-- Behaviour
vim.opt.clipboard = "unnamedplus"   -- Sync with system clipboard
vim.opt.confirm = true              -- Confirm to save changes before exiting modified buffer
vim.opt.mouse = "a"                 -- Enable mouse mode
vim.opt.nrformats = "alpha,hex,bin" --Support systems for increment/decrements <C-x>: 0b01 0x1 a1

-- Keymaps: Avoid <esc> delay. Also set escape-time 0 in tmux
vim.opt.timeout = true    -- for mappings
vim.opt.timeoutlen = 1000 -- default value
vim.opt.ttimeout = true   -- for key codes
vim.opt.ttimeoutlen = 10  -- unnoticeable small value
vim.opt.updatetime = 200  -- Save swap file and trigger CursorHold
vim.opt.undofile = true

-- Search
vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true  -- Don't ignore case with capitals

-- Visual
vim.opt.colorcolumn = "100"
vim.opt.cursorline = true     -- Enable highlighting of the current line
vim.opt.number = true
vim.opt.relativenumber = true -- Relative line numbers
vim.wo.signcolumn = "yes"
-- Window behaviour
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = { trail = '⋅', tab = '  ↦' } -- »

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
