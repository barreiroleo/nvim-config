return {
    {
        name = 'Cpp build',
        description = 'Try to build the current C++ file',
        builder = function()
            -- Full path to current file (see :help expand())
            local source = vim.fn.expand '%:p'
            local target = vim.fn.expand '%:p:r'
            return {
                cmd = { 'g++' },
                args = { source, '-o', target },
                cwd = './build/',
                components = { { 'on_output_quickfix', open = true }, 'default' },
            }
        end,
        condition = {
            filetype = { 'cpp' },
        },
    },
}
