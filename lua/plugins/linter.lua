return {
    "mfussenegger/nvim-lint",
    opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
            sh = { 'shellcheck' },
            dockerfile = { 'hadolint' },
            json = { 'jsonlint' },
            lua = { 'selene' },
            cpp = { 'cppcheck' },
            cmake = { 'checkmake', 'cmakelint' },
            markdown = { 'markdownlint' },
            sql = { 'sqlfluff' } -- args = { "--dialect", "sqlite" }, -- mandatory
        },
        linters = {
        }
    },

    config = function(_, opts)
        local lint = require("lint")

        local selene = vim.fs.find('selene.toml', {
            upward = true, stop = vim.uv.os_homedir(), path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
        })[1]
        lint.linters["selene"].args = { "--config", selene, "--display-style", "json", "-" }

        for name, linter in pairs(opts.linters) do
            if type(linter) == "table" and type(lint.linters[name]) == "table" then
                lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
            else
                lint.linters[name] = linter
            end
        end

        lint.linters_by_ft = opts.linters_by_ft

        vim.api.nvim_create_autocmd(opts.events, {
            callback = function()
                require("lint").try_lint()
                require("lint").try_lint("compiler")
            end,
        })
    end,
}
