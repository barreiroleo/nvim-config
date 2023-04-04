local def_opts = require("core.lsp.opts")

local M = {}

-- FQBN = Fully qualified board name: <package>:<architecture>:<board>
--  <package>: vendor identifier (tipically arduino)
--  <architecture>: avr, megaavr, sam
--  <board>: uno, uno2018, yun
-- To identify FQBNs for boards currently connected, use the 'arduino-cli board list'
M.DEFAULT_FQBN = "arduino:avr:uno"

-- When the arduino server starts in these directories, use the provided FQBN.
-- Note that the server needs to start exactly in these directories.
M.proyects_fqbn = {
    ["/home/leonardo/develop/"] = "arduino:avr:nano",
    -- ["/home/leonardo/develop/arduino_proyect_1"] = "arduino:avr:nano",
}

M.set_FQBN = function(config, root_dir)
    local fqbn = M.proyects_fqbn[root_dir]
    if not fqbn then
        vim.notify(("Could not find which FQBN to use in %q. Defaulting to %q."):format(root_dir, M.DEFAULT_FQBN))
        fqbn = M.DEFAULT_FQBN
    end
    config.cmd = {
        "arduino-language-server",
        "-cli-config", "/path/to/arduino-cli.yaml",
        "-fqbn",
        fqbn
    }
end

M.opts = {
    on_attach = function(client, bufnr)
        LOG("Loading arduino_ls")
        def_opts.on_attach(client, bufnr)
    end,
    capabilities = def_opts.capabilities,
    on_new_config = M.set_FQBN -- Callback, don't execute
}

return M.opts
