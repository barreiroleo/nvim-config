local dap, dapui = require('dap'), require("dapui")
local keymap_manager = require("core.dap.keymap_manager")
local keymaps = require("core.dap.keymaps")

-- Events
local function clean_and_open()
    dapui.open()
    keymap_manager.setup(keymaps.debug_keymaps)
    vim.diagnostic.hide(nil, 0)
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
end

local function restore_and_close()
    vim.diagnostic.show()
    keymap_manager.shutdown()
    dapui.close()
end

dap.listeners.before.attach.dapui_config = clean_and_open
dap.listeners.before.launch.dapui_config = clean_and_open
dap.listeners.after.terminate.dapui_config = restore_and_close
dap.listeners.after.disconnect.dapui_config = restore_and_close

-- Setup
require('nvim-dap-virtual-text').setup({})
dapui.setup()
require("core.dap.adapters")
