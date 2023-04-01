local def_opts = require("core.lsp.opts")

local M = {}

M.opts = {
    on_attach = function(client, bufnr)
        print("Loading jdtls")
        def_opts.on_attach(client, bufnr)
        -- Require mfussenegger/nvim-jdtls
        vim.cmd [[
            command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
            command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
            command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
            command! -buffer JdtJol lua require('jdtls').jol()
            command! -buffer JdtBytecode lua require('jdtls').javap()
            command! -buffer JdtJshell lua require('jdtls').jshell()
        ]]
    end,
    capabilities = def_opts.capabilities,
}

return M.opts
