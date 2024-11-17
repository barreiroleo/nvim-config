---@diagnostic disable: undefined-field
local dap, dapui, dapwidgets = require('dap'), require('dapui'), require('dap.ui.widgets')

local M = {}

---@type vim.api.keyset.keymap[]
M.debug_keymaps = {
    { mode = "n",          lhs = "<leader>dC",  rhs = function() dap.set_breakpoint(vim.fn.input '[Condition] > ') end,       desc = "DAP: Conditional breakpoint" },
    { mode = 'n',          lhs = "<leader>dLC", rhs = function() dap.set_breakpoint(nil, nil, vim.fn.input('Log msg: ')) end, desc = "DAP: Breakpoint log" },

    { mode = "n",          lhs = "<leader>db",  rhs = dap.step_back,                                                          desc = "DAP: Step back" },
    { mode = "n",          lhs = "<leader>dR",  rhs = dap.run_to_cursor,                                                      desc = "DAP: Run to cursor" },
    { mode = "n",          lhs = "<leader>dp",  rhs = dap.pause,                                                              desc = "DAP: Pause" },

    { mode = "n",          lhs = "<leader>dq",  rhs = dap.close,                                                              desc = "DAP: Quit" },
    { mode = "n",          lhs = "<leader>dr",  rhs = dap.repl.open,                                                          desc = "DAP: Open REPL" },
    { mode = "n",          lhs = "<leader>dE",  rhs = function() dapui.eval(vim.fn.input '[Expression] > ') end,              desc = "DAP: Evaluate input" },
    { mode = { "n", "v" }, lhs = "<leader>de",  rhs = dapui.eval,                                                             desc = "DAP: Evaluate" },
    { mode = "n",          lhs = "<leader>du",  rhs = dapui.toggle,                                                           desc = "DAP: Toggle UI" },

    { mode = "n",          lhs = "<leader>dd",  rhs = dap.disconnect,                                                         desc = "DAP: Disconnect" },
    { mode = "n",          lhs = "<leader>dg",  rhs = dap.session,                                                            desc = "DAP: Get session" },
    { mode = "n",          lhs = "<leader>dt",  rhs = dap.terminate,                                                          desc = "DAP: Terminate" },
    { mode = "n",          lhs = "K",           rhs = dapwidgets.hover,                                                       desc = "DAP: Hover variables" },
    { mode = "n",          lhs = "<leader>dp",  rhs = dapwidgets.preview,                                                     desc = "DAP: Hover variable but in preview window" },
    { mode = "n",          lhs = "<leader>df",  rhs = function() dapwidgets.centered_float(dapwidgets.frames) end,            desc = "DAP: Frames" },
    { mode = "n",          lhs = "<leader>ds",  rhs = function() dapwidgets.centered_float(dapwidgets.scopes) end,            desc = "DAP: Scopes" },
}

return M
