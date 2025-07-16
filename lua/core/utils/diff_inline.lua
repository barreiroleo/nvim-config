-- ============================================================================
-- DIFF INLINE - MAIN MODULE
-- ============================================================================
-- A modular Neovim utility for creating inline diffs, inspired by linediff.vim
-- Supports both manual section marking and automatic conflict marker detection
-- ============================================================================

local marking = require("core.utils.diff_inline.marking")
local conflicts = require("core.utils.diff_inline.conflicts")
local commands = require("core.utils.diff_inline.commands")
local ui = require("core.utils.diff_inline.ui")

local M = {}

-- ============================================================================
-- PUBLIC API
-- ============================================================================

-- Export marking functions
M.mark_section = marking.mark_section
M.diff_marked_sections = marking.diff_marked_sections

-- Export conflict functions
M.find_conflict_markers = conflicts.find_conflict_markers
M.diff_conflicts = conflicts.diff_conflicts
M.diff_conflicts_two_way = conflicts.diff_conflicts_two_way
M.diff_conflicts_three_way = conflicts.diff_conflicts_three_way

-- Export UI functions
M.close_diff = ui.close_diff

-- Export setup function
M.setup = commands.setup

return M

