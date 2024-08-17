return {
    "mfussenegger/nvim-lint",
    opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
            sh = { 'shellcheck' },
            dockerfile = { 'hadolint' },
            json = { 'jsonlint' },
            lua = { 'selene' },
            cpp = { 'cppcheck', 'cpplint'--[[CPPLINT.cfg]]},
            markdown = { 'markdownlint' },
            sql = { 'sqlfluff' },
            cmake = { 'cmakelint' }
        },
    },

    config = function(_, opts)
        local lint = require("lint")

        lint.linters["selene"].args = vim.tbl_deep_extend('force', lint.linters["selene"].args,
            { "--config", vim.fs.find('selene.toml', {
                upward = true, stop = vim.uv.os_homedir(), path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
            })[1] })

        lint.linters["cpplint"].args = vim.tbl_deep_extend('force', lint.linters["cpplint"].args,
            { "--filter=-legal/copyright,-whitespace", "--linelength=120" }
        )

        lint.linters["sqlfluff"].args = vim.tbl_deep_extend('force', lint.linters["cpplint"].args,
            { "--dialect", "sqlite" }
        )

        lint.linters_by_ft = opts.linters_by_ft

        vim.api.nvim_create_autocmd(opts.events, {
            callback = function()
                require("lint").try_lint()
                require("lint").try_lint("compiler")
            end,
        })
    end,
}
