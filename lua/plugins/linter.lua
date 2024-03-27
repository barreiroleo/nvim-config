return {
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            local lint = require 'lint'

            -- To allow other plugins to add linters, declare linters_by_ft like this:
            lint.linters_by_ft = lint.linters_by_ft or {}
            lint.linters_by_ft['sh'] = { 'shellcheck' }
            lint.linters_by_ft['dockerfile'] = { 'hadolint' }
            lint.linters_by_ft['json'] = { 'jsonlint' }
            lint.linters_by_ft['lua'] = { 'selene' }
            lint.linters_by_ft['cpp'] = { 'cppcheck' }
            lint.linters_by_ft['cmake'] = { 'checkmake', 'cmake_lint' }
            lint.linters_by_ft['markdown'] = { 'markdownlint' }
            lint.linters_by_ft['python'] = { 'mypy', 'pylint', 'vulture' }
            lint.linters_by_ft['sql'] = { 'sqlfluff' } -- args = { "--dialect", "sqlite" }, -- mandatory

            -- autocommand which carries out the actual linting on the specified events.
            local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
                group = lint_augroup,
                callback = function()
                    require('lint').try_lint()
                end,
            })
        end,
    },
}
