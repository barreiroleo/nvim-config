local def_opts = require("core.lsp.opts")
local M = {}

local function switch_source_header_splitcmd(bufnr, splitcmd)
    bufnr = require 'lspconfig'.util.validate_bufnr(bufnr)
    local clangd_client = require 'lspconfig'.util.get_active_client_by_name(bufnr, 'clangd')
    local params = { uri = vim.uri_from_bufnr(bufnr) }
    if clangd_client then
        clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
            if err then
                error(tostring(err))
            end
            if not result then
                print("Corresponding file can’t be determined")
                return
            end
            vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
        end, bufnr)
    else
        print 'textDocument/switchSourceHeader is not supported by the clangd server active on the current buffer'
    end
end

-- NOTE: Clangd help: ~/.local/share/nvim/mason/packages/clangd/clangd_16.0.2/bin/clangd --help-hidden

M.cmd = {
    'clangd',
    '--all-scopes-completion',
    '--background-index',
    '--clang-tidy',
    "--clang-tidy-checks=-*, clang-analyzer-*, concurrency-*, cppcoreguidelines-*, hicpp-*, llvm-*, llvmlibc-*, misc-*, modernize-*,-modernize-use-trailing-return-type, mpi-*, performance-*, portability-*, readability-*",
    '--completion-style=bundled',
    '--enable-config',
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--use-dirty-headers",
    '--offset-encoding=utf-16', --temporary fix for null-ls
}

M.commands = {
    ClangdSwitchSourceHeader = {
        function() switch_source_header_splitcmd(0, "edit") end,
        description = "Open source/header in current buffer",
    },
    ClangdSwitchSourceHeaderVSplit = {
        function() switch_source_header_splitcmd(0, "vsplit") end,
        description = "Open source/header in a new vsplit",
    },
    ClangdSwitchSourceHeaderSplit = {
        function() switch_source_header_splitcmd(0, "split") end,
        description = "Open source/header in a new split",
    }
}

M.opts = {
    on_attach = function(client, bufnr)
        print("Loading clangd")
        def_opts.on_attach(client, bufnr)
    end,
    capabilities = def_opts.capabilities,
    commands = M.commands,
    cmd = M.cmd,
}

return M.opts
