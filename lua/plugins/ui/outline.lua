local function OpenOutline()
    local outline = require("outline")

    if not outline.is_open() then
        outline.open()
    else
        outline.focus_toggle()
    end
end

return {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = 'Outline',
    keys = { { '<leader>cs', OpenOutline, desc = 'Symbols LSP navigation' } },
    config = function()
        require('outline').setup {
            preview_window = { live = true },
        }
    end,
}
