LOG =  require("core.utils.log").warn

function P(v)
    vim.notify(vim.inspect(v) .. "\n", vim.log.levels.WARN)
    return v
end

function RELOAD(...)
    return require("plenary.reload").reload_module(...)
end

function R(name)
    RELOAD(name)
    return require(name)
end

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
