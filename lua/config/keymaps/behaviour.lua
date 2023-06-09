local Util = require("core.utils")
local map = require("core.utils").map

-- Breaks the undofile blocks
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Can indent without exit from visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Sanner ctrl-L: https://github.com/mhinz/vim-galore#saner-ctrl-l
-- Clear search, diff update and redraw. Taken from runtime/lua/_editor.lua
map( "n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / clear hlsearch / diff update" })

-- Sanner N-n search: https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- N and n direction depends on whether / or ?. For n always search forward and N backward
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
