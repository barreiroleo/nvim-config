local M = {}

M.proyects = {
    ["/home/leonardo/develop/"] = "arduino:avr:nano",
}

M.DEFAULT_FQBN = "arduino:avr:uno"

M.find_proyect = function(config, root_dir)
    local fqbn = M.proyects[root_dir]
    if not fqbn then
        vim.notify(("Could not find which FQBN to use in %q. Defaulting to %q."):format(root_dir, M.DEFAULT_FQBN))
        fqbn = M.DEFAULT_FQBN
    end
    config.cmd = {
        "arduino-language-server",
        "-cli-config", "~/.arduino15/arduino-cli.yaml",
        "-fqbn", fqbn,
        "cli", "arduino-cli",
        -- "-clangd", "/home/leonardo/.local/share/nvim/mason/bin/clangd"
    }
end


M.opts = {
    on_new_config = M.find_proyect,
}

return M
