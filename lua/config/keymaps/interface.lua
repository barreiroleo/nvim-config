-- Buffers
vim.keymap.set({ "n" }, "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer: Prev buffer" })
vim.keymap.set({ "n" }, "<S-l>", "<cmd>bnext<cr>",     { desc = "Buffer: Next buffer" })
vim.keymap.set({ "n" }, "<leader>bd", "<cmd>bdelete<cr>", { desc = "Buffer delete" })

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
