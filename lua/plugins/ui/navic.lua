local M = {}

--- Create the highlights for navic
---@param bg string "#181825" | "#11111B"
---@param fg string "#94E2D5" | "#CDD6F4"
---@param fg_icon string "#FAB387"
local function create_highlight(bg, fg, fg_icon)
    vim.api.nvim_set_hl(0, "NavicIconsFile",          { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsModule",        { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsNamespace",     { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsPackage",       { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsClass",         { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsMethod",        { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsProperty",      { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsField",         { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsConstructor",   { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsEnum",          { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsInterface",     { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsFunction",      { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsVariable",      { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsConstant",      { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsString",        { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsNumber",        { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsBoolean",       { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsArray",         { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsObject",        { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsKey",           { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsNull",          { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsStruct",        { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsEvent",         { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsOperator",      { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, bg = bg, fg = fg_icon })
    vim.api.nvim_set_hl(0, "NavicText",               { default = true, bg = bg, fg = fg })
    vim.api.nvim_set_hl(0, "NavicSeparator",          { default = true, bg = bg, fg = fg })
end

function M.setup(hl_colors)
    create_highlight(hl_colors.bg, hl_colors.fg, hl_colors.fg_icon)
end

return M
