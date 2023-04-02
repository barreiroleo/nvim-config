local types = require("luasnip.util.types")

require("luasnip").config.setup({
    history = true,
    update_events = "InsertLeave",
    region_check_events = "InsertEnter",
    delete_check_events = "TextChanged,InsertLeave",
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "●", "GruvboxOrange" } }
            }
        },
        [types.insertNode] = {
            active = {
                virt_text = { { "●", "GruvboxBlue" } }
            }
        }
    },
})

require("luasnip.loaders.from_vscode").lazy_load {
    paths = "./snippets"
}

vim.cmd('command! LuaSnipEdit :lua require("luasnip.loaders").edit_snippet_files()')
