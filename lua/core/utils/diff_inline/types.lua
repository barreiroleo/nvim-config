-- ============================================================================
-- DATA STRUCTURES AND TYPES
-- ============================================================================

---@class DiffSection
---@field filename string
---@field filetype string
---@field start_line integer
---@field end_line integer
---@field lines string[]
---@field timestamp integer

---@class ConflictBlock
---@field start_line integer
---@field start_marker string
---@field has_base boolean
---@field base_line integer?
---@field base_marker string?
---@field middle_line integer?
---@field end_line integer?
---@field end_marker string?
---@field head string[]
---@field base string[]?
---@field ours string[]

return {}
