return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufNewFile', 'BufReadPre' },
    opts = {
        indent = { char = "┆" },
    },
}
