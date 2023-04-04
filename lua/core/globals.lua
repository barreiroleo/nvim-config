LOG =  require("core.utils.log").warn

P = function(v)
    vim.notify(vim.inspect(v) .. "\n", vim.log.levels.WARN)
    return v
end

RELOAD = function(...)
    return require("plenary.reload").reload_module(...)
end

R = function(name)
    RELOAD(name)
    return require(name)
end

DROP_TEX = function(file, line)
    -- From shell: nvim --listen /tmp/SOCKET FILE -c +LINE
    -- Example:    nvim --listen /tmp/nvim.latex src/main.tex -c +24
    -- Example:    nvim --listen /tmp/nvim.latex src/main.tex -c ":call cursor(29,8)"
    file = file or "~/develop/pps/src/main.tex"
    line = line or 10

    local clean = { "\'", "\"" }
    for _, char in ipairs(clean) do
        file = string.gsub(file, "^" .. char, "")
        file = string.gsub(file, char .. "$", "")
    end
    file = string.gsub(file, " ", "\\ ")

    local cmd = string.format(":drop %s|%s", file, line)
    vim.notify(cmd)
    vim.cmd(cmd)
end
--
-- local filename = "/lala lala/main.tex"
-- local chars = { "", "'", "\"" }
-- for _, char in ipairs(chars) do
--     DROP_TEX(char .. filename .. char, 1)
-- end

-- Command less. Usefull to inspect vim outputs in teporary buffer
-- Use: <cmd>less messages<cr>
vim.cmd[[
    command! -nargs=+ -complete=command Less call Less(win_getid(), <q-mods>, <q-args>)

    function! Less(winid, mods, args) abort
        execute (len(a:mods) ? a:mods . ' new' : 'botr 20new')
        call setline(1,split(win_execute(a:winid, a:args),"\n"))
        setl bt=nofile bh=wipe nobl nomod
    endfunction
]]
