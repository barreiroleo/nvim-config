---@alias ClientId integer
---
---@alias LspProgress {client_name: string, client_id:number, value: LspProgress.Params.Value?}
---
---@alias LspProgress.AutocmdEventData {client_id: integer, params: lsp.ProgressParams}
---
---@class LspProgress.Params.Value --[[ lsp.LSPAny ]]
---@field client_id integer
---@field title string Typically used for client name
---@field message string? Typically for notification message
---@field kind "begin" | "report" | "end"?
---@field percentage number? Progress percentage (0-100)
---@field spinner string? Character to show in the progress message
---
---@alias LspProgress.Cache table<ClientId, LspProgress.Params.Value>

---@type LspProgress.Cache
local lsp_attached_map = {}
---@type LspProgress.Cache
local lsp_progress_map = {}

local SPINNER = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

---@param client vim.lsp.Client
---@param value LspProgress.Params.Value
local function update_progress_cache(client, value)
    local cached = lsp_progress_map[client.id]
    local percentage = value.kind == "end" and 100 or value.percentage or 0

    if cached and cached.percentage == 100 then
        lsp_progress_map[client.id] = nil
    end

    if cached and cached.percentage == percentage then
        return -- skip update if percentage is unchanged
    end

    lsp_progress_map[client.id] = {
        client_id = client.id,
        title = client.name,
        message = string.format("[%3d%%] %s %s", percentage, value.title, value.message or ""),
        kind = value.kind,
        percentage = percentage,
        spinner = (percentage == 100) and "✓" or
            SPINNER[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #SPINNER + 1]
    }
end

---
--- PUBLIC API
---
local M = { _loaded = false }

---@param event_data {data: LspProgress.AutocmdEventData}
---@return LspProgress.Params.Value?
function M.get_notify_data(event_data)
    M.setup()
    return lsp_progress_map[event_data.data.client_id]
end

---Loading => "[[ ⠏ client: 27%; ...]]"
---Done    => "[[ client ; ...]]"
---@return string Formatted string for statusline
function M.get_statusline_data()
    M.setup()
    local clients = {}

    -- In progress lsp clients
    for _, value in pairs(lsp_progress_map) do
        local percentage = (value.percentage == 100 and "") or (": " .. value.percentage .. "%%")
        local spinner = (value.percentage == 100 and "") or (value.spinner .. " ")
        table.insert(clients, string.format("%s%s%s", spinner, value.title, percentage))
    end

    -- Complement with attached clients
    for _, value in pairs(lsp_attached_map) do
        if not lsp_progress_map[value.client_id] then
            table.insert(clients, value.title)
        end
    end

    return "[ " .. table.concat(clients, ", ") .. " ]"
end

function M.setup()
    if M._loaded then return end

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event_data)
            local client = vim.lsp.get_client_by_id(event_data.data.client_id)
            if client then
                lsp_attached_map[client.id] = { title = client.name, client_id = client.id }
            end
        end,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
        callback = function(event_data)
            lsp_attached_map[event_data.data.client_id] = nil
        end,
    })

    vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(event_data)
            local client_id = event_data.data.client_id
            local client = vim.lsp.get_client_by_id(client_id)
            if not client then return end

            vim.schedule(function()
                update_progress_cache(client, event_data.data.params.value --[[@as LspProgress.Params.Value]])
            end)
        end,
    })

    M._loaded = true
end

function M.inspect()
    vim.notify(string.format("LSP in progress: %s", vim.inspect(lsp_progress_map)))
    vim.notify(string.format("LSP attached: %s", vim.inspect(lsp_attached_map)))
end

return M
