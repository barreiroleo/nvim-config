-- Shorthands
vim.keymap.set({ "n", "x", "v" }, "<leader><leader>x", require("core.utils.save_and_exec"), { desc = "Save and execute the current file" })
vim.keymap.set("n", "<leader>m", "<cmd>messages<cr>", { desc = "Open vim messages" })

-- Move cursor support for wrapped lines
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Move cursor up", expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Move cursor down", expr = true })

-- Move Lines
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

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
vim.keymap.set({ "n", "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "[Search] Nrev search result" })
vim.keymap.set({ "n", "x" }, "fw", "*N <bar>:set hls<cr>", { desc = "[Search] Search word under cursor" })
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>",          { desc = "[Search] Escape and clear hlsearch" })

-- Terminal escape
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

-- Sanner ctrl-L: https://github.com/mhinz/vim-galore#saner-ctrl-l
-- Clear search, diff update and redraw. Taken from runtime/lua/_editor.lua
vim.keymap.set( "n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- Buffers
vim.keymap.set("n", "<leader>bd", "<cmd>bp | bd #<cr>", { desc = "Buffer delete" })
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer: Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Buffer: Next buffer" })

-- Tabs
vim.keymap.set("n", "<leader><leader><tab>", "<cmd>tabnew<cr>", { desc = "Tabs: New Tab" })
vim.keymap.set("n", "<leader><tab>w", "<cmd>tabprevious<cr>", { desc = "Tabs: Previous Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Tabs: Close Tab" })
vim.keymap.set("n", "<leader><tab>q", "<cmd>tabnext<cr>", { desc = "Tabs: Next Tab" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -1<cr>",  { desc = "Window: Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +1<cr>", { desc = "Window: Increase window width" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize +1<cr>",   { desc = "Window: Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -1<cr>", { desc = "Window: Decrease window height" })

-- Quickfix
vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "qf" },
    callback = function()
        local qf_rm_entries = require("core.utils.qf_rm_entries")
        vim.keymap.set("n", "dd", qf_rm_entries, { buffer = true, desc = "QuickFix: Remove entry from" })
        vim.keymap.set("x", "d", qf_rm_entries, { buffer = true, desc = "QuickFix: Remove entry from" })
    end
})
