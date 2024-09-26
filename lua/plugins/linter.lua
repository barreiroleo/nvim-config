---@param filename string
---@return string
local function find_file_root(filename)
    ---@diagnostic disable-next-line: undefined-field
    local stop, path = vim.uv.os_homedir(), vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    return vim.fs.find(filename, { upward = true, stop = stop, path = path })[1]
end

---@param linters table
---@param extra_args {linter:string, args:string[]}[]
local function extend_args(linters, extra_args)
    vim.iter(extra_args):each(function(linter, args)
        linters[linter].args = vim.tbl_deep_extend('force', linters[linter].args, args)
    end)
end

return {
    "mfussenegger/nvim-lint",
    opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
            sh = { 'shellcheck' },
            dockerfile = { 'hadolint' },
            json = { 'jsonlint' },
            lua = { 'selene' },
            -- TODO: Update cppcheck. Too many false positives
            cpp = { 'cpplint' --[[CPPLINT.cfg]], --[[ 'cppcheck', ]] },
            markdown = { 'markdownlint' },
            sql = { 'sqlfluff' },
            cmake = { 'cmakelint' }
        },
    },

    config = function(_, opts)
        local lint = require("lint")

        local extra_args = {
            ["selene"] = { "--config", find_file_root('selene.toml') },
            ["cmakelint"] = { "--linelength=120" },
            ["cpplint"] = { "--filter=-legal/copyright,-whitespace,-build/c++11,-build/include_subdir", "--linelength=120" },
            ["sqlfluff"] = { "--dialect", "sqlite" }
        }
        extend_args(lint.linters, extra_args)

        lint.linters_by_ft = opts.linters_by_ft

        vim.api.nvim_create_autocmd(opts.events, {
            callback = function()
                require("lint").try_lint()
                require("lint").try_lint("compiler")
            end,
        })
    end,
}
