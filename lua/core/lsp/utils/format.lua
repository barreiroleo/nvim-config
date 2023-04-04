local get_opts = require("core.utils").get_opts

local M = {}

function M.format()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.bo[buf].filetype
    local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

    local filter = function(client)
        if have_nls then
            return client.name == "null-ls"
        end
        return client.name ~= "null-ls"
    end

    vim.lsp.buf.format(
        vim.tbl_deep_extend("force", { bufnr = buf, filter = filter }, get_opts("nvim-lspconfig").format or {})
    )
end

return M.format
