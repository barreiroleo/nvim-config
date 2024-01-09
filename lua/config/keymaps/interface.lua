local util_has = require("core.utils").has

-- Buffers
if util_has("bufferline.nvim") then
    vim.keymap.set({ "n" }, "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer: Prev buffer" })
    vim.keymap.set({ "n" }, "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer: Next buffer" })
else
    vim.keymap.set({ "n" }, "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer: Prev buffer" })
    vim.keymap.set({ "n" }, "<S-l>", "<cmd>bnext<cr>",     { desc = "Buffer: Next buffer" })
end
vim.keymap.set({ "n" }, "<leader>bd", function() require('bufdelete').bufwipeout(0) end, { desc = "Buffer delete" })

-- Tabs
vim.keymap.set({ "n" }, "<leader><leader><tab>", "<cmd>tabnew<cr>", { desc = "Tabs: New Tab" })
vim.keymap.set({ "n" }, "<leader><tab>q", "<cmd>tabnext<cr>",       { desc = "Tabs: Next Tab" })
vim.keymap.set({ "n" }, "<leader><tab>w", "<cmd>tabprevious<cr>",   { desc = "Tabs: Previous Tab" })
vim.keymap.set({ "n" }, "<leader><tab>d", "<cmd>tabclose<cr>",      { desc = "Tabs: Close Tab" })

-- Resize window using <ctrl> arrow keys
vim.keymap.set({ "n" }, "<C-Up>", "<cmd>resize +1<cr>",             { desc = "Window: Increase window height" })
vim.keymap.set({ "n" }, "<C-Down>", "<cmd>resize -1<cr>",           { desc = "Window: Decrease window height" })
vim.keymap.set({ "n" }, "<C-Left>", "<cmd>vertical resize -1<cr>",  { desc = "Window: Decrease window width" })
vim.keymap.set({ "n" }, "<C-Right>", "<cmd>vertical resize +1<cr>", { desc = "Window: Increase window width" })
