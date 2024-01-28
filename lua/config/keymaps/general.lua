local util_has = require("core.utils").has

vim.keymap.set('n', 'gqf', require("core.lsp.utils.format"),                  { desc = "LSP: Format the whole file, use null-ls if available" })
vim.keymap.set("n", "<leader><leader>x", require("core.utils").save_and_exec, { desc = "Save and execute the current file" })
vim.keymap.set("n", "<leader><leader>c", ":<up>",                             { desc = "Run previous command" })
vim.keymap.set("n", "<leader>m", "<cmd>messages<cr>",                         { desc = "Open vim messages" })

vim.keymap.set('', '<leader>z', '<cmd>call ToggleWrap()<cr>', { desc = "Toggle line wrap" })

vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==",        { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==",        { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv",        { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv",        { desc = "Move up" })

-- Search
vim.keymap.set({ "n", "v" }, "/", "/\\v",                  { desc = "Search with regex by default" })
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
vim.keymap.set({ "n", "x" }, "fw", "*N",                   { desc = "Search word under cursor" })
vim.keymap.set('n', 'n', 'nzz',                            { desc = "Next search result and center" })
vim.keymap.set('n', 'N', 'Nzz',                            { desc = "Prev search result and center" })


if not util_has("trouble.nvim") then
    vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
    vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- floating terminal
vim.keymap.set("n", "<leader>ft", function() require("core.utils").float_term(nil,   { cwd = require("core.utils").get_root() }) end, { desc = "Terminal (root dir)" })
vim.keymap.set("n", "<leader>fT", function() require("core.utils").float_term() end, { desc = "Terminal (cwd)" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>",                                     { desc = "Enter Normal Mode"})

-- Diagnostics
vim.keymap.set("n", "<leader>ud", require("core.utils").toggle_diagnostics, { desc = "Toggle Diagnostics" })
-- vim.keymap.set('n', '<leader>e', ":lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostics in float" })
vim.keymap.set('n', '[d', ":lua vim.diagnostic.goto_prev()<CR>",            { desc = "Go to previous diagnostics" })
vim.keymap.set('n', ']d', ":lua vim.diagnostic.goto_next()<CR>",            { desc = "Go to next diagnostics" })
vim.keymap.set('n', '<leader>q', ":lua vim.diagnostic.setloclist()<CR>",    { desc = "Location of diagnostics" })
