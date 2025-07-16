local marking = require("core.utils.diff_inline.marking")
local conflicts = require("core.utils.diff_inline.conflicts")
local ui = require("core.utils.diff_inline.ui")

local M = {}

-- ============================================================================
-- SETUP STAGE
-- ============================================================================

---Setup user commands
---@param opts? table
function M.setup(opts)
    opts = opts or {}

    -- Create user commands
    vim.api.nvim_create_user_command("DiffMarkAdd", marking.mark_section, {
        desc = "Mark current selection or line for diffing",
        range = true
    })

    vim.api.nvim_create_user_command("DiffMarkDiff", marking.diff_marked_sections, {
        desc = "Diff the last two marked sections"
    })

    vim.api.nvim_create_user_command("DiffConflicts", conflicts.diff_conflicts, {
        desc = "Show conflict markers in diff view (auto-detect)"
    })

    vim.api.nvim_create_user_command("DiffConflicts2", function()
        local found_conflicts = conflicts.find_conflict_markers()
        if #found_conflicts == 0 then
            print("No conflict markers found from cursor position")
            return
        end
        conflicts.diff_conflicts_two_way(found_conflicts)
    end, {
        desc = "Show conflict markers in two-way diff view"
    })

    vim.api.nvim_create_user_command("DiffConflicts3", function()
        local found_conflicts = conflicts.find_conflict_markers()
        if #found_conflicts == 0 then
            print("No conflict markers found from cursor position")
            return
        end
        conflicts.diff_conflicts_three_way(found_conflicts)
    end, {
        desc = "Show conflict markers in three-way diff view"
    })

    vim.api.nvim_create_user_command("DiffMarkConflicts", conflicts.mark_conflict_sections, {
        desc = "Mark conflict sections with buffer marks (q,w,e,r)"
    })

    vim.api.nvim_create_user_command("DiffClose", ui.close_diff, {
        desc = "Close diff view"
    })
end

return M
