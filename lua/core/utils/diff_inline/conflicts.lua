local ui = require("core.utils.diff_inline.ui")

local M = {}

-- ============================================================================
-- CONFLICT MARKER DETECTION HELPERS
-- ============================================================================

---Set marks for two-way conflict
---@param bufnr integer
---@param conflict ConflictBlock
local function set_two_way_marks(bufnr, conflict)
    vim.api.nvim_buf_set_mark(bufnr, "q", conflict.start_line, 0, {})
    vim.api.nvim_buf_set_mark(bufnr, "w", conflict.middle_line, 0, {})
    vim.api.nvim_buf_set_mark(bufnr, "e", conflict.end_line, 0, {})
    print(string.format("Two-way conflict marked: 'q=start(L%d), 'w=middle(L%d), 'e=end(L%d)",
        conflict.start_line, conflict.middle_line, conflict.end_line))
    print("Use 'q, 'w, 'e to jump to marked sections")
end

---Set marks for three-way conflict
---@param bufnr integer
---@param conflict ConflictBlock
local function set_three_way_marks(bufnr, conflict)
    vim.api.nvim_buf_set_mark(bufnr, "q", conflict.start_line, 0, {})
    vim.api.nvim_buf_set_mark(bufnr, "w", conflict.base_line, 0, {})
    vim.api.nvim_buf_set_mark(bufnr, "e", conflict.middle_line, 0, {})
    vim.api.nvim_buf_set_mark(bufnr, "r", conflict.end_line, 0, {})

    print(string.format("Three-way conflict marked: 'q=start(L%d), 'w=base(L%d), 'e=middle(L%d), 'r=end(L%d)",
        conflict.start_line, conflict.base_line, conflict.middle_line, conflict.end_line))
    print("Use 'q, 'w, 'e, 'r to jump to marked sections")
end

---Find base marker within conflict block
---@param lines string[]
---@param start_line integer
---@param end_search integer
---@return integer?, string?
local function find_base_marker(lines, start_line, end_search)
    for j = start_line, end_search do
        if lines[j]:match("^|||||||") then
            return j, lines[j]
        end
        if lines[j]:match("^=======") then
            break
        end
    end
    return nil, nil
end

---Find middle marker (=======) within conflict block
---@param lines string[]
---@param start_line integer
---@return integer?
local function find_middle_marker(lines, start_line)
    for j = start_line, #lines do
        if lines[j]:match("^=======") then
            return j
        end
    end
    return nil
end

---Find end marker (>>>>>>>) within conflict block
---@param lines string[]
---@param start_line integer
---@return integer?, string?
local function find_end_marker(lines, start_line)
    for j = start_line, #lines do
        if lines[j]:match("^>>>>>>>") then
            return j, lines[j]
        end
    end
    return nil, nil
end

---Extract lines between two markers
---@param lines string[]
---@param start_line integer
---@param end_line integer
---@return string[]
local function extract_lines(lines, start_line, end_line)
    local result = {}
    for k = start_line, end_line do
        table.insert(result, lines[k])
    end
    return result
end

-- ============================================================================
-- CONFLICT PARSING
-- ============================================================================

---Parse conflict content for two-way conflict
---@param lines string[]
---@param conflict ConflictBlock
local function parse_two_way_conflict(lines, conflict)
    conflict.head = extract_lines(lines, conflict.start_line + 1, conflict.middle_line - 1)
    conflict.ours = extract_lines(lines, conflict.middle_line + 1, conflict.end_line - 1)
end

---Parse conflict content for three-way conflict
---@param lines string[]
---@param conflict ConflictBlock
local function parse_three_way_conflict(lines, conflict)
    conflict.head = extract_lines(lines, conflict.start_line + 1, conflict.base_line - 1)
    conflict.base = extract_lines(lines, conflict.base_line + 1, conflict.middle_line - 1)
    conflict.ours = extract_lines(lines, conflict.middle_line + 1, conflict.end_line - 1)
end

---Parse a single conflict block starting at the given line
---@param lines string[]
---@param start_line integer
---@return ConflictBlock?, integer
local function parse_conflict_block(lines, start_line)
    local conflict = {
        start_line = start_line,
        start_marker = lines[start_line],
        has_base = false
    }

    -- Find base marker if it exists
    local base_line, base_marker = find_base_marker(lines, start_line + 1, #lines)
    if base_line then
        conflict.base_line = base_line
        conflict.base_marker = base_marker
        conflict.has_base = true
    end

    -- Find middle marker
    local middle_line = find_middle_marker(lines, start_line + 1)
    if not middle_line then
        return nil, start_line + 1
    end
    conflict.middle_line = middle_line

    -- Find end marker
    local end_line, end_marker = find_end_marker(lines, middle_line + 1)
    if not end_line then
        return nil, start_line + 1
    end
    conflict.end_line = end_line
    conflict.end_marker = end_marker

    -- Parse conflict content
    if conflict.has_base then
        parse_three_way_conflict(lines, conflict)
    else
        parse_two_way_conflict(lines, conflict)
    end

    return conflict, end_line + 1
end

-- ============================================================================
-- PUBLIC API
-- ============================================================================

---@param start_from_line? integer Optional line to start searching from (defaults to cursor position)
---@return ConflictBlock[]
function M.find_conflict_markers(start_from_line)
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local conflicts = {}

    -- Start from cursor position if no line specified
    local start_line = start_from_line or vim.fn.line(".")

    local i = start_line
    while i <= #lines do
        local line = lines[i]

        -- Look for conflict start marker (<<<<<<< HEAD)
        if line:match("^<<<<<<<") then
            local conflict, next_line = parse_conflict_block(lines, i)
            if conflict then
                table.insert(conflicts, conflict)
                i = next_line
            else
                i = i + 1
            end
        else
            i = i + 1
        end
    end

    return conflicts
end

---Handle two-way conflict diffing
---@param conflict ConflictBlock
---@param filetype string
function M.handle_two_way_conflict(conflict, filetype)
    local postfix = ui.generate_unique_postfix()
    local head_buf = ui.create_buffer(string.format("[HEAD_%s]", postfix), conflict.head, filetype)
    local ours_buf = ui.create_buffer(string.format("[OURS_%s]", postfix), conflict.ours, filetype)
    local title = string.format("Conflict at line %d: %s vs %s",
        conflict.start_line,
        conflict.start_marker:match("<<<<<<< (.*)") or "HEAD",
        conflict.end_marker:match(">>>>>>> (.*)") or "OURS")
    ui.open_two_way_diff(head_buf, ours_buf, title)
end

---Handle three-way conflict diffing
---@param conflict ConflictBlock
---@param filetype string
function M.handle_three_way_conflict(conflict, filetype)
    local postfix = ui.generate_unique_postfix()
    local head_buf = ui.create_buffer(string.format("[HEAD_%s]", postfix), conflict.head, filetype)
    local base_buf = ui.create_buffer(string.format("[BASE_%s]", postfix), conflict.base, filetype)
    local ours_buf = ui.create_buffer(string.format("[OURS_%s]", postfix), conflict.ours, filetype)
    local title = string.format("Three-way conflict at line %d: HEAD | BASE | OURS", conflict.start_line)
    ui.open_three_way_diff(head_buf, base_buf, ours_buf, title)
end

---Show a two-way diff for the first conflict
---@param conflicts ConflictBlock[]
---@param filetype? string
function M.diff_conflicts_two_way(conflicts, filetype)
    if not conflicts or #conflicts == 0 then
        print("No conflicts provided")
        return
    end

    local conflict = conflicts[1]
    filetype = filetype or vim.api.nvim_get_option_value("filetype", { buf = 0 })
    M.handle_two_way_conflict(conflict, filetype)
end

---Show a three-way diff for the first conflict
---@param conflicts ConflictBlock[]
---@param filetype? string
function M.diff_conflicts_three_way(conflicts, filetype)
    if not conflicts or #conflicts == 0 then
        print("No conflicts provided")
        return
    end

    local conflict = conflicts[1]
    if not conflict.has_base then
        print("No base/parent information found. Use diff_conflicts_two_way() instead.")
        return
    end

    filetype = filetype or vim.api.nvim_get_option_value("filetype", { buf = 0 })
    M.handle_three_way_conflict(conflict, filetype)
end

---Auto-detect and show a diff for the first conflict from cursor position
function M.diff_conflicts()
    local conflicts = M.find_conflict_markers()
    if #conflicts == 0 then
        print("No conflict markers found from cursor position")
        return
    end

    if #conflicts > 1 then
        print(string.format("Found %d conflicts from cursor. Showing the first one.", #conflicts))
    end

    local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    local conflict = conflicts[1]

    if conflict.has_base then
        M.handle_three_way_conflict(conflict, filetype)
    else
        M.handle_two_way_conflict(conflict, filetype)
    end
end

---Set buffer marks on conflict sections for easy navigation
function M.mark_conflict_sections()
    local conflicts = M.find_conflict_markers()
    if #conflicts == 0 then
        print("No conflict markers found from cursor position")
        return
    end

    local conflict = conflicts[1]
    local bufnr = vim.api.nvim_get_current_buf()

    if conflict.has_base then
        set_three_way_marks(bufnr, conflict)
    else
        set_two_way_marks(bufnr, conflict)
    end
end

return M
