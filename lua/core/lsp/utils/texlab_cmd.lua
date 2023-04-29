local function cmd_backsearch (file, line, CR_char)
    local cmd = "nvim --server " .. vim.v.servername .. " --remote-send " .. string.format("\":lua DROP_TEX(%s,%s)%s\"", file, line, CR_char)
    -- %f = tex, %l = line, %p = pdf
    return cmd
end

local SearchCmds = {
    evincesyn = {
        executable = "evince-synctex",
        args = { "--forward", "%l", "--pdffile", "%p", "--texfile", "%f", "--cmd", cmd_backsearch("%f", "%l", "\r") }
    },
    zathura = {
        executable = "zathura",
        args = { "-x", cmd_backsearch("'%{input}'", "%{line}", "<CR>"),
            "--synctex-forward", "%l:1:%f", "%p" }
    },
    sioyek = {
        executable = "sioyek",
        args = { "--inverse-search", cmd_backsearch("'%1'", "%2", "\r"), -- %1 file, %2 line
            "--forward-search-file", "%f", "--forward-search-line", "%l", "%p" }
    },
}

local BuildCmds = {
    latexmk = {
        executable = "latexmk",
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-output-directory=../build" },
        onSave = true,
        forwardSearchAfter = true
    },
    tectonic = {
        executable = "tectonic",
        args = { "-X", "compile", "%f", "--keep-logs", "--keep-intermediates", "--synctex", "--outdir build" },
        onSave = true,
        forwardSearchAfter = false
    }
}

local M = {
    forwardSearch = SearchCmds,
    build = BuildCmds
}

return M
