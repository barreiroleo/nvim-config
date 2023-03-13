local util_has = require("core.utils").has
local map = require("core.utils").map

map('n', '<F3>', ':w | :TexlabBuild<CR>', { desc = "Build tex file" })
map('n', '<F4>', ':TexlabForward<CR>',    { desc = "Search line in pdf" })
if util_has("nabla") then
    map('n', '<leader>p', function() require("nabla").popup() end, { desc = "Open Nabla popout" })
end
