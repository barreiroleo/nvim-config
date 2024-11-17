-- Diagnostic message display. Error lens
vim.diagnostic.config {
    virtual_text = {
        spacing = 4,
        severity = {
            min = vim.diagnostic.severity.WARN,
            max = vim.diagnostic.severity.ERROR
        },
        source = "if_many",
        prefix = '■' -- Could be '●', '▎', 'x', '⯀'
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
    float = { source = "if_many", border = "rounded" },
    underline = true,
    update_in_insert = true,
    severity_sort = true,
}
vim.cmd.highlight("ErrorMsg guibg=#250003 guifg=0")
vim.cmd.highlight("WarningMsg guibg=#382b00 guifg=0")


-- Code action hint
vim.fn.sign_define("lsp-ca", { text = "", texthl = "LineNr", numhl = "LineNr" }) --  
local function codeaction_indication(bufnr)
    local params = vim.lsp.util.make_range_params()
    params.context = { diagnostics = vim.diagnostic.get(bufnr) }
    vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result, context, config)
        if not result or type(result) ~= "table" or vim.tbl_isempty(result) then
            return vim.fn.sign_unplace("lsp-ca")
        else
            return vim.fn.sign_place(0, "lsp-ca", "lsp-ca", bufnr, { lnum = context.params.range.start.line + 1 })
        end
    end)
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserAutocmd_CodeActionSign", { clear = false }),
    callback = function(lsp_args)
        local client = vim.lsp.get_client_by_id(lsp_args.data.client_id)
        if client and (not client.server_capabilities.codeActionProvider or client.name == "null-ls") then return end
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = vim.api.nvim_create_augroup("code_action_sign", { clear = false }),
            callback = function(args) codeaction_indication(args.buf) end,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = vim.api.nvim_create_augroup("code_action_sign", { clear = false }),
            callback = function() vim.fn.sign_unplace("lsp-ca") end,
        })
    end
})


-- Override floating windows border globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    ---@diagnostic disable-next-line: assign-type-mismatch
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

---NOTE: this function produce mocks diagnostics to test the behaviour
local function test_diagnostics()
    local diags = {}
    local base_diag = {
        bufnr = vim.api.nvim_get_current_buf(),
        code = "imagine-two-cows",
        col = 0,
        end_col = vim.api.nvim_win_get_cursor(0)[2],
        lnum = vim.api.nvim_win_get_cursor(0)[1] - 2,
        end_lnum = vim.api.nvim_win_get_cursor(0)[1] - 2,
        message = "Dummy error",
        namespace = 22,
        severity = 5,
        source = "Mocking error",
    }
    for i = 1, 4, 1 do
        diags[i] = vim.deepcopy(base_diag)
        diags[i].severity = i
        diags[i].lnum = base_diag.lnum + i
        diags[i].end_lnum = base_diag.end_lnum + i
    end
    vim.diagnostic.set(base_diag.namespace, base_diag.bufnr, diags)
end
-- test_diagnostics()
