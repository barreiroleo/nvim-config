return {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = 'Outline',
    keys = { { '<leader>cs', '<cmd>Outline<cr>', desc = 'Symbols LSP navigation' } },
    config = function()
        require('outline').setup {
            preview_window = { live = true },
        }
    end,
}
