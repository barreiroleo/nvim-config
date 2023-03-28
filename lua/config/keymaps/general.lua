local util_has = require("core.utils").has
local map = require("core.utils").map

map("n", "<leader><leader>x", require("core.utils").save_and_exec, { desc = "Save and execute the current file" })

map('', '<leader>z', '<cmd>call ToggleWrap()<cr>',{ desc = "Toggle line wrap" })
map('n', '<F7>', 'gg=G<C-o>', { desc = "Reindent file"})

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- FIXME: Doesn't work with Tmux or ZSH
-- Delete the previous word.
map('i', '<C-BS>', '<C-W>', { desc = "Delete the previous word" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Search
map({ "n", "v" }, "/", "/\\v", { desc = "Search with regex by default" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map({ "n", "x" }, "fw", "*N", { desc = "Search word under cursor" })
map('n', 'n', 'nzz', { desc = "Next search result and center" })
map('n', 'N', 'Nzz', { desc = "Prev search result and center" })


if not util_has("trouble.nvim") then
    map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- toggle options
map("n", "<leader>ud", require("core.utils").toggle_diagnostics, { desc = "Toggle Diagnostics" })

-- lazygit
map("n", "<leader>gg", function() require("core.utils").float_term({ "lazygit" }, { cwd = require("core.utils").get_root() }) end, { desc = "Lazygit (root dir)" })
map("n", "<leader>gG", function() require("core.utils").float_term({ "lazygit" }) end, { desc = "Lazygit (cwd)" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
    map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- floating terminal
map("n", "<leader>ft", function() require("core.utils").float_term(nil, { cwd = require("core.utils").get_root() }) end, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() require("core.utils").float_term() end, { desc = "Terminal (cwd)" })
map("t", "<esc><esc>", "<c-\\><c-n>", {desc = "Enter Normal Mode"})
