local types = require("luasnip.util.types")

require('luasnip').config.setup {
    history = false,
    region_check_events = { 'InsertLeave', 'InsertEnter' },
    delete_check_events = { 'InsertLeave', 'InsertEnter', 'TextChanged' },
    ext_opts = {
        [types.insertNode] = { unvisited = { hl_mode = 'combine', virt_text = { { '◈', 'Conceal' } }, virt_text_pos = 'inline' }, },
        -- [types.choiceNode] = { active    = { hl_mode = 'combine', virt_text = { { '◈', 'Conceal' } }, virt_text_pos = 'inline' }, },
        [types.exitNode]   = { unvisited = { hl_mode = 'combine', virt_text = { { '◈', 'Conceal' } }, virt_text_pos = 'inline' }, },
        -- [types.snippet]    = { active   = { hl_mode = 'combine', virt_text = { { '◈', 'Conceal' } }, virt_text_pos = 'inline' } },
    },
}

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })

vim.cmd('command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()')

-- U+25AA 	▪ 	Black small square
-- U+25C6 	◆ 	Black diamond
-- U+25C7 	◇ 	White diamond
-- U+25C8 	◈ 	White diamond containing small black diamond
