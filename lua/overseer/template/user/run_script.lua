local file = vim.fn.expand '%:p'
local cmd_list = {
    ['sh'] = { 'bash', file },
    ['python'] = { 'python3', file },
    ['lua'] = { 'lua', file },
}

local function get_cmd()
    for extension, cmd in pairs(cmd_list) do
        if extension == vim.bo.filetype then
            return cmd
        end
    end
end

return {
    name = 'run script',
    builder = function()
        return {
            cmd = get_cmd(),
            components = {
                { 'on_output_quickfix', set_diagnostics = true },
                'on_result_diagnostics',
                'default',
            },
        }
    end,
    condition = {
        filetype = vim.tbl_keys(cmd_list),
    },
}
