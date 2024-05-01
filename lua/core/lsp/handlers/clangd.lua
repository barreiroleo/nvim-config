local clangd_flags = require("core.lsp.handlers.clangd_flags")

---@param bufnr integer
---@param splitcmd string
local function switch_source_header(bufnr, splitcmd)
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

return {
    on_attach = function(_client, bufnr)
        print("Loading clangd")
        vim.keymap.set({ "n", "i" }, "<A-o>", function()
            switch_source_header(0, "edit")
        end, { desc = "[Clang] Switch source/header", buffer = bufnr })
    end,
    commands = {
        ClangdSwitchSourceHeader = {
            function() switch_source_header(0, "edit") end,
            description = "Open source/header in current buffer",
        },
        ClangdSwitchSourceHeaderSplit = {
            function() switch_source_header(0, "vsplit") end,
            description = "Open source/header in a new vsplit",
        },
        ClangdPrintFlags = {
            function() P({ clangd_flags.randomized, clangd_flags.flags }) end,
            description = "Print the clangd flags"
        }
    },
    cmd = clangd_flags.flags,
}
