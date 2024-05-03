local utils = require("core.utils")
vim.keymap.set({ "n", "x", "v" }, "<leader><leader>x", utils.save_and_exec, { desc = "Save and execute the current file" })
vim.keymap.set("n", "<leader><leader>c", ":<up>",     { desc = "Run previous command" })
vim.keymap.set("n", "<leader>m", "<cmd>messages<cr>", { desc = "Open vim messages" })
vim.keymap.set("n", '<leader>z', '<cmd>call ToggleWrap()<cr>', { desc = "Toggle line wrap" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==",        { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==",        { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv",        { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv",        { desc = "Move up" })
-- Can indent without exit from visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-- Breaks the undofile blocks
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- Search
-- Sanner N-n search: https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({ "n", "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "[Search] Next search result" })
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "PSearch] Nrev search result" })
vim.keymap.set({ "n", "x" }, "fw", "*N <bar>:set hls<cr>",      { desc = "[Search] Search word under cursor" })
vim.keymap.set( "n" , "<esc>", "<cmd>noh<cr><esc>",             { desc = "[Search] Escape and clear hlsearch" })

-- floating terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Diagnostics
vim.keymap.set('n', '[d', ":lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous diagnostics" })
vim.keymap.set('n', ']d', ":lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next diagnostics" })

vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- Sanner ctrl-L: https://github.com/mhinz/vim-galore#saner-ctrl-l
-- Clear search, diff update and redraw. Taken from runtime/lua/_editor.lua
vim.keymap.set( "n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- Buffers
vim.keymap.set( "n" , "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer: Prev buffer" })
vim.keymap.set( "n" , "<S-l>", "<cmd>bnext<cr>",     { desc = "Buffer: Next buffer" })
vim.keymap.set( "n" , "<leader>bd", "<cmd>bdelete<cr>", { desc = "Buffer delete" })

-- Tabs
vim.keymap.set( "n" , "<leader><leader><tab>", "<cmd>tabnew<cr>", { desc = "Tabs: New Tab" })
vim.keymap.set( "n" , "<leader><tab>q", "<cmd>tabnext<cr>",       { desc = "Tabs: Next Tab" })
vim.keymap.set( "n" , "<leader><tab>w", "<cmd>tabprevious<cr>",   { desc = "Tabs: Previous Tab" })
vim.keymap.set( "n" , "<leader><tab>d", "<cmd>tabclose<cr>",      { desc = "Tabs: Close Tab" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set( "n" , "<C-Up>", "<cmd>resize +1<cr>",             { desc = "Window: Increase window height" })
vim.keymap.set( "n" , "<C-Down>", "<cmd>resize -1<cr>",           { desc = "Window: Decrease window height" })
vim.keymap.set( "n" , "<C-Left>", "<cmd>vertical resize -1<cr>",  { desc = "Window: Decrease window width" })
vim.keymap.set( "n" , "<C-Right>", "<cmd>vertical resize +1<cr>", { desc = "Window: Increase window width" })

-- Netrw
vim.api.nvim_create_autocmd("filetype", {
    group = vim.api.nvim_create_augroup("UserAutocmd_Netrw", { clear = false }),
    desc = "Netrw navigation mappings",
    pattern = "netrw",
    callback = function()
        vim.keymap.set("n", "<esc>", "<cmd>Rex<cr>", { remap = true, buffer = true, desc = "[Netrw] Toggle" })
        vim.keymap.set("n", "h", "-", { remap = true, buffer = true, desc = "[Netrw] Nav back" })
        vim.keymap.set("n", "l", "<cr>", { remap = true, buffer = true, desc = "[Netrw] Nav enter" })
    end,
})
