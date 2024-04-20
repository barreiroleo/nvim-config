-- Remove items from quickfix list.
local function del_qf_items()
    local qflist = vim.fn.getqflist()

    local mode = vim.api.nvim_get_mode()['mode']
    local start_idx
    local count

    if mode == 'n' then
        start_idx = vim.fn.line('.')
        count = vim.v.count > 0 and vim.v.count or 1
    elseif mode == "V" or mode "v" then
        local v_start_idx = vim.fn.line('v')
        local v_end_idx = vim.fn.line('.')

        start_idx = math.min(v_start_idx, v_end_idx)
        count = math.abs(v_end_idx - v_start_idx) + 1

        -- Go back to normal
        vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes(
                '<esc>', -- what to escape
                true,    -- Vim leftovers
                false,   -- Also replace `<lt>`?
                true     -- Replace keycodes (like `<esc>`)?
            ),
            'x',         -- Mode flag
            false        -- Should be false, since we already `nvim_replace_termcodes()`
        )
    end

    for _ = 1, count, 1 do
        table.remove(qflist, start_idx)
    end

    vim.fn.setqflist(qflist, 'r')
    vim.fn.cursor(start_idx, 1)
end


vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "qf" },
    callback = function()
        vim.keymap.set("n", "dd", del_qf_items, { buffer = true, desc = "QuickFix: Remove entry from" })
        vim.keymap.set("x", "d", del_qf_items, { buffer = true, desc = "QuickFix: Remove entry from" })
    end
})
