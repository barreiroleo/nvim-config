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
    cmd = 'Outline',
    keys = {
        { '<leader>cs', OpenOutline, desc = 'Outline: Symbols LSP navigation' }
    },
    opts = {
        preview_window = { live = true },
    }
}
