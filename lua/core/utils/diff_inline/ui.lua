local state = require("core.utils.diff_inline.state")

local M = {}

-- ============================================================================
-- BUFFER MANAGEMENT
-- ============================================================================

---@param prefix string
---@param index integer
---@return string
function M.create_buffer_name(prefix, index)
    return string.format("[%s_%d]", prefix, index)
end

---@param name string
---@param lines string[]
---@param filetype string?
---@return integer
function M.create_buffer(name, lines, filetype)
    local buf = vim.api.nvim_create_buf(false, true)
    local opts = { scope = 'local', buf = buf } --[[@type vim.api.keyset.option]]
    vim.api.nvim_buf_set_name(buf, name)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value("buftype", "nofile", opts)
    vim.api.nvim_set_option_value("swapfile", false, opts)
    vim.api.nvim_set_option_value("modifiable", false, opts)
    if filetype then
        vim.api.nvim_set_option_value("filetype", filetype, opts)
    end
    return buf
end

---Generate a unique postfix for buffer names
---@return string
function M.generate_unique_postfix()
    return tostring(os.time())
end

-- ============================================================================
-- WINDOW MANAGEMENT
-- ============================================================================

---Enable diff mode for a window
---@param win integer
function M.enable_diff_for_window(win)
    vim.api.nvim_win_call(win, function()
        vim.cmd("diffthis")
    end)
end

---Set buffer in window and enable diff
---@param win integer
---@param buf integer
function M.setup_diff_window(win, buf)
    vim.api.nvim_win_set_buf(win, buf)
    M.enable_diff_for_window(win)
end

---Create vertical split and return the new window
---@return integer
function M.create_vertical_split()
    vim.cmd("vsplit")
    return vim.api.nvim_get_current_win()
end

-- ============================================================================
-- TAB MANAGEMENT
-- ============================================================================

---Initialize diff tab and cleanup previous state
function M.init_diff_tab()
    M.close_diff()
    vim.cmd("tabnew")
end

---Set up keymaps for all windows in the current tab
function M.setup_diff_keymaps()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        vim.api.nvim_win_call(win, function()
            local opts = { noremap = true, silent = true, buffer = true }
            vim.keymap.set("n", "q", M.close_diff, opts)
            vim.keymap.set("n", "<leader>dc", M.close_diff, opts)
            vim.keymap.set("n", "]c", "]c", opts)
            vim.keymap.set("n", "[c", "[c", opts)
        end)
    end
end

---Finalize diff setup with keymaps and title
---@param buffers integer[]
---@param title string?
function M.finalize_diff_setup(buffers, title)
    state.diff_buffers = buffers
    M.setup_diff_keymaps()

    if title then
        print("Diff view: " .. title)
    end
end

---Close the diff view and clean up
function M.close_diff()
    -- Close diff mode in all windows
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_call(win, function()
                if vim.wo.diff then
                    vim.cmd("diffoff")
                end
            end)
        end
    end

    -- Delete diff buffers
    for _, buf in ipairs(state.diff_buffers) do
        if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
    end
    state.diff_buffers = {}

    -- Close the diff tab if we're in one
    local current_tab = vim.api.nvim_get_current_tabpage()
    local tab_wins = vim.api.nvim_tabpage_list_wins(current_tab)

    -- Check if current tab only has diff buffers
    local has_only_diff = true
    for _, win in ipairs(tab_wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        local bufname = vim.api.nvim_buf_get_name(buf)
        if not (bufname:match("%[.*%]") or bufname == "") then
            has_only_diff = false
            break
        end
    end

    if has_only_diff and vim.fn.tabpagenr('$') > 1 then
        vim.cmd("tabclose")
    end
end

-- ============================================================================
-- DIFF VIEW MANAGEMENT
-- ============================================================================

---@param buf1 integer
---@param buf2 integer
---@param title string?
function M.open_two_way_diff(buf1, buf2, title)
    M.init_diff_tab()

    -- Set up left buffer
    local left_win = vim.api.nvim_get_current_win()
    M.setup_diff_window(left_win, buf1)

    -- Create right split
    local right_win = M.create_vertical_split()
    M.setup_diff_window(right_win, buf2)

    -- Return to left window
    vim.cmd("wincmd h")

    M.finalize_diff_setup({ buf1, buf2 }, title)
end

---@param buf1 integer
---@param buf2 integer
---@param buf3 integer
---@param title string?
function M.open_three_way_diff(buf1, buf2, buf3, title)
    M.init_diff_tab()

    -- Set up first buffer
    local win1 = vim.api.nvim_get_current_win()
    M.setup_diff_window(win1, buf1)

    -- Create second split
    local win2 = M.create_vertical_split()
    M.setup_diff_window(win2, buf2)

    -- Create third split
    local win3 = M.create_vertical_split()
    M.setup_diff_window(win3, buf3)

    -- Balance window sizes
    vim.cmd("wincmd =")

    M.finalize_diff_setup({ buf1, buf2, buf3 }, title)
end

return M
