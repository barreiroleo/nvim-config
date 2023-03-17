local renderers = require("plugins.neotree.renderers")
local commands  = require("plugins.neotree.commands")
local mappings  = require("plugins.neotree.mappings")

local opts = {
    popup_border_style = "rounded",
    source_selector = {
        winbar = false,
        statusline = true
    },
    default_component_configs = {
        indent = {
            with_expanders = true
        },
    },
    renderers = renderers,
    window = {
        position = "left",
        width = 35,
        mappings = mappings,
    },
    filesystem = {
        commands = commands,
        filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_by_name = {},
            hide_by_pattern = {},
            always_show = { ".gitignored" },
            never_show = {},
        },
        group_empty_dirs = true,
        follow_current_file = true,
        use_libuv_file_watcher = true -- OS level file watchers
    },
    git_status = {
        window = {
            position = "right",
        }
    },
    event_handlers = {
        { event = "neo_tree_buffer_enter",
            handler = function(arg)
                vim.opt.number = true
                vim.opt.relativenumber = true
            end,
        }
    },
}

return opts
