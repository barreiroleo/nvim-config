local state = require("core.utils.diff_inline.state")
local ui = require("core.utils.diff_inline.ui")

local M = {}

-- ============================================================================
-- VISUAL SELECTION HELPERS
-- ============================================================================

---Get visual selection range
---@return integer, integer
local function get_visual_selection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]

    return start_line, end_line
end

-- ============================================================================
-- MARKING FUNCTIONALITIES
-- ============================================================================

---Mark a section for diffing
function M.mark_section()
    local bufnr = vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

    -- Get selection range
    local start_line, end_line
    local mode = vim.fn.mode()

    if mode == "v" or mode == "V" or mode == "\22" then -- Visual mode
        start_line, end_line = get_visual_selection()
    else
        -- Use current line if not in visual mode
        start_line = vim.fn.line(".")
        end_line = start_line
    end

    -- Get the selected lines
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

    -- Store the marked section
    local section = {
        filename = filename,
        filetype = filetype,
        start_line = start_line,
        end_line = end_line,
        lines = lines,
        timestamp = os.time()
    }

    table.insert(state.marked_sections, section)

    local section_count = #state.marked_sections
    print(string.format("Marked section %d (lines %d-%d from %s)",
        section_count, start_line, end_line, vim.fn.fnamemodify(filename, ":t")))

    -- If we have 2 sections, offer to diff them
    if section_count == 2 then
        print("Press <leader>dd to diff the two marked sections")
    elseif section_count > 2 then
        print("Multiple sections marked. Use :DiffMarkDiff to diff the last two.")
    end
end

---Diff the last two marked sections
function M.diff_marked_sections()
    if #state.marked_sections < 2 then
        print("Need at least 2 marked sections to diff")
        return
    end

    local section1 = state.marked_sections[#state.marked_sections - 1]
    local section2 = state.marked_sections[#state.marked_sections]

    -- Create buffers for diff with unique postfix
    local postfix = ui.generate_unique_postfix()
    local buf1_name = string.format("[Section1_%s]", postfix)
    local buf2_name = string.format("[Section2_%s]", postfix)

    local buf1 = ui.create_buffer(buf1_name, section1.lines, section1.filetype)
    local buf2 = ui.create_buffer(buf2_name, section2.lines, section2.filetype)

    local title = string.format("%s:%d-%d vs %s:%d-%d",
        vim.fn.fnamemodify(section1.filename, ":t"), section1.start_line, section1.end_line,
        vim.fn.fnamemodify(section2.filename, ":t"), section2.start_line, section2.end_line)

    ui.open_two_way_diff(buf1, buf2, title)
end

return M
