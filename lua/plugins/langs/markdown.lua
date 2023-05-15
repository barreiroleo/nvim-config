return {
    { "dhruvasagar/vim-table-mode" },

    -- FIX: If the plug not load at :MarkdownPreview, check for tslib asserts at :messages and run
    -- vim.fn["mkdp#util#install"]()
    { "iamcco/markdown-preview.nvim",
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        -- config = function()
        --     -- Launch with java -jar ~/.local/bin/plantuml.jar -picoweb:8000
        --     vim.g.mkdp_preview_options = {
        --         uml = { server = "http://localhost:8000", imageFormat = "png" },
        --     }
        -- end
    },

    { "AckslD/nvim-FeMaco.lua",
        ft = { "markdown" },
        config = function()
            require("femaco").setup()
        end,
    },
}
